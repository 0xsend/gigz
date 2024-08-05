// @sourceHash 5f87d7452b58a13e525e2aed64ed707a

module MakeSession = {
  let queryText = `# @name makeSession
      select(insert Session {
        key := <str>$key,
        lookup_type := <LookupType>$lookup_type,
        identifier := <str>$identifier,
        confirmation_address := <str>$confirmationAddress,
        chainId := <optional SupportedChainId>$chainId
      }){id, identifier, lookup_type}`
  
  @live  
  type args = {
    key: string,
    lookup_type: [#Tag | #SendId],
    identifier: string,
    confirmationAddress: string,
    chainId?: Null.t<int>,
  }
  
  type response = {
    id: string,
    identifier: string,
    lookup_type: [#Tag | #SendId],
  }
  
  @live
  let query = (client: EdgeDB.Client.t, args: args): promise<result<response, EdgeDB.Error.errorFromOperation>> => {
    client->EdgeDB.QueryHelpers.singleRequired(queryText, ~args)
  }
  
  @live
  let transaction = (transaction: EdgeDB.Transaction.t, args: args): promise<result<response, EdgeDB.Error.errorFromOperation>> => {
    transaction->EdgeDB.TransactionHelpers.singleRequired(queryText, ~args)
  }
}