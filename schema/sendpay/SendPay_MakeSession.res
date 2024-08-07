open SendPay_Types
let query = %edgeql(`
    # @name makeSession
    select(insert Session {
      key := <str>$key,
      sendid := <int64>$sendid,
      sendtag := <optional str>$sendtag,
      address := <str>$address,
      avatar_url := <optional str>$avatarUrl,
      about := <optional str>$about,
      refcode := <optional str>$refcode,
      confirmation_address := <optional str>$confirmationAddress,
      confirmation_amount := <optional bigint>$confirmationAmount,
      chain_id := <optional SupportedChainId>$chainId,
      expires_at := <optional datetime>$expiresAt
    }){id,sendid, address, confirmation_address, chain_id}
  `)

@gql.inputUnion
type makeSessionInput =     //@todo: probably a better way to spread these values
  | BySendId({
      /** The sendid to request a session for*/
      sendid: float,
      /** The ethereum address to receive the confirmation tx */
      confirmationAddress?: string,
      /** The amount of tokens to send to the confirmation address */
      confirmationAmount?: Schema.BigInt.t,
      /** The chain id to use for the session */
      chain?: Chain.chain,
      /** Duration of the session in milliseconds */
      duration?: float,
    })
  | ByTag({
      /** The sendtag to request a session for*/
      tag: string,
      /** The ethereum address to receive the confirmation tx */
      confirmationAddress?: string,
      /** The amount of tokens to send to the confirmation address */
      confirmationAmount?: Schema.BigInt.t,
      /** The chain id to use for the session */
      chain?: Chain.chain,
      /** Duration of the session in milliseconds */
      duration?: float,
    })

@gql.union
type makeSessionResult =
  | Ok({id: string})
  | Error({name: string, reason: string})
