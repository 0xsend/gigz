open SendPay

@gql.field
let makeSendpaySession = async (
  _: Schema.mutation,
  ~ctx: ResGraphContext.context,
  ~input: MakeSession.makeSessionInput,
): MakeSession.makeSessionResult => {
  let (
    identifier,
    sendtag,
    confirmationAddress,
    confirmationAmount,
    chain,
    duration,
  ) = switch input {
  | BySendId({sendid, ?confirmationAddress, ?confirmationAmount, ?chain, ?duration}) => (
      SendApi.SendId(sendid),
      Null.null,
      confirmationAddress,
      confirmationAmount,
      chain,
      duration,
    )
  | ByTag({tag, ?confirmationAddress, ?confirmationAmount, ?chain, ?duration}) => (
      SendApi.Tag(tag),
      tag->Null.make,
      confirmationAddress,
      confirmationAmount,
      chain,
      duration,
    )
  }
  switch await SendApi.profileLookup(identifier) {
  | Error(err) =>
    Console.error(err)
    Error({name: "SendPay Error", reason: "Something went wrong"})
  | Ok({address: Null | Undefined}) => Error({name: "SendPay Error", reason: "No send account"})
  | Ok({sendid, address: Value(address), avatar_url: avatarUrl, about, refcode}) =>
    // Check if profile exists
    switch await ctx.edgedbClient->MakeSession.query({
      key: ctx.sendpayKey,
      sendid,
      sendtag,
      avatarUrl: avatarUrl->Nullable.mapOr(Null.null, Null.make),
      about: about->Nullable.mapOr(Null.null, Null.make),
      refcode: Null.make(refcode),
      address,
      confirmationAddress: confirmationAddress->Null.fromOption,
      confirmationAmount: confirmationAmount->Option.mapOr(Null.make(0n), Null.make),
      chainId: chain->Option.map(Chain.toId)->Null.fromOption,
      //@todo: passing null causes the db entry to be null, so we set default to 5 minutes here.
      // It would be better to enforce by the db. Probably a bug in rescript-edgedb
      expiresAt: (duration->Option.getOr(5. *. 60. *. 1000.) +. Date.now())
      ->Date.fromTime
      ->Null.Value,
    }) {
    | Ok({id}) => Ok({id: id})
    | Error(edgeDbError) =>
      switch edgeDbError {
      | EdgeDbError({code: ConstraintViolationError}) => Error({name: "Invalid Input", reason: ""})
      | EdgeDbError(err) =>
        Console.error(err)
        Error({name: "EdgeDB Error", reason: "Failed to write to db. Check server logs."}) //@Make a helper for edgedb error codes
      | GenericError(exn) =>
        Error({
          name: exn->Exn.name->Option.getOr("Unknown Error"),
          reason: exn->Exn.message->Option.getOr(""),
        })
      }
    }
  }
}

let eventIsExpired = (eventTimestamp, blockTimestamp, expiresAt) => {
  open BigInt
  let eventTimestamp = eventTimestamp->mul(1000n)->toFloat
  let blockTimestamp = blockTimestamp->mul(1000n)->toFloat
  let expiresAt = expiresAt->Date.getTime

  eventTimestamp > expiresAt || blockTimestamp > expiresAt
}

@gql.field
let consumeSendpaySession = async (
  _: Schema.mutation,
  ~ctx: ResGraphContext.context,
): ConsumeSession.consumeSessionResult => {
  switch await ctx.edgedbClient->ConsumeSession.query({
    key: ctx.sendpayKey,
  }) {
  | None => Error({name: "Verify Failed", reason: "Session not found"})
  | Some({
      sendid,
      sendtag,
      address: sendAccountAddress,
      avatar_url: avatarUrl,
      about,
      refcode,
      expires_at: expiresAt,
      chain_id: chainId,
      confirmation_amount: confirmationAmount,
      confirmation_address: confirmationAddress,
    }) =>
    let blockNumber = await ctx.viemClient->Viem.Block.getNumber
    let eventLogs = await ctx.viemClient->Viem.Logs.get(
      ~input={
        address: chainId->Null.getOr(-1)->Chain.fromId->Constants.usdcAddress,
        event: Viem.Abi.parseAbiItem(
          "event Transfer(address indexed from, address indexed to, uint256 value)",
        ),
        args: {
          "from": sendAccountAddress,
          "to": confirmationAddress,
        },
        fromBlock: blockNumber //@todo: can we get block from created_at field
        ->BigInt.sub(3600n) //@2 hours of blocks on base
        ->Block,
        toBlock: Block(blockNumber),
      },
    )
    switch (eventLogs->Array.get(0), confirmationAmount->Null.toOption) {
    // Only need the latest event
    | (None, _) => Error({name: "No Sendpay Event Found"})
    | (Some({args}), Some(confirmationAmount)) if args["value"] < confirmationAmount =>
      Error({name: "Token Amount Below Threshold"})
    | (Some({blockHash}), _) =>
      switch (
        await ctx.viemClient->Viem.Block.get(~config={blockHash: blockHash}),
        await ctx.viemClient->Viem.Block.get,
      ) {
      | exception _ => Error({name: "Failed to get blocks from RPC"})
      | ({timestamp: eventTimestamp}, {timestamp: blockTimestamp})
        if eventIsExpired(eventTimestamp, blockTimestamp, expiresAt) =>
        ConsumeSession.Error({name: "Sendpay Event Expired"})
      | _ =>
        Ok({
          sendId: sendid,
          address: sendAccountAddress,
          sendtag: sendtag->Null.toOption,
          avatar_url: avatarUrl->Null.toOption,
          about: about->Null.toOption,
          refcode: refcode->Null.toOption,
          chainId: chainId->Null.toOption,
        })
      }
    }
  }
}
