@gql.enum
type chainId = | @as(1) Mainnet | @as(8453) Base | @as(84532) BaseSepolia

module LookupType = {
  @gql.enum
  type lookupType = | @as("tag") Tag | @as("sendid") SendId

  let toPolyvariant = lookupType =>
    switch lookupType {
    | Tag => #Tag
    | SendId => #SendId
    }

  let fromPolyvariant = lookupType =>
    switch lookupType {
    | #Tag => Tag
    | #SendId => SendId
    }
}

module MakeSession = {
  let query = %edgeql(`
    # @name makeSession
    select(insert Session {
      key := <str>$key,
      lookup_type := <LookupType>$lookup_type,
      identifier := <str>$identifier,
      confirmation_address := <str>$confirmationAddress,
      chainId := <optional SupportedChainId>$chainId
    }){id, identifier, lookup_type}
  `)
  /** Request to open a sendpay session */
  @gql.inputObject
  type input = {
    /** The identifier to request a session for */
    identifier: string,
    /** The type of identifier */
    lookupType: LookupType.lookupType,
    /** The ethereum address to receive the confirmation tx */
    confirmationAddress: string,
    /** The chain id to use for the session */
    chainId?: chainId,
  }
  @gql.union
  type result =
    | Ok({sessionId: string, identifier: string, lookupType: LookupType.lookupType})
    | Error({name: string, reason: string})
}

module VerifySession = {
  @gql.union
  type verifySessionResult =
    | Ok({sendId: string, address: string, sendtags?: array<string>, chainId: int})
    | Error({name: string, reason: string})
}
