// @sourceHash e5b51c4ae9881d4842c992a3824a62a8

module ConsumeSession = {
  let queryText = `# @name consumeSession
    with session :=(delete Session
    filter .key = <str>$key
    limit 1) select session {*} limit 1;`
  
  @live  
  type args = {
    key: string,
  }
  
  type response = {
    confirmation_amount: Null.t<bigint>,
    sendtag: Null.t<string>,
    sendid: float,
    refcode: Null.t<string>,
    created_at: Date.t,
    confirmation_address: string,
    chain_id: Null.t<int>,
    avatar_url: Null.t<string>,
    address: string,
    about: Null.t<string>,
    key: string,
    expires_at: Date.t,
    id: string,
  }
  
  @live
  let query = (client: EdgeDB.Client.t, args: args, ~onError=?): promise<option<response>> => {
    client->EdgeDB.QueryHelpers.single(queryText, ~args, ~onError?)
  }
  
  @live
  let transaction = (transaction: EdgeDB.Transaction.t, args: args, ~onError=?): promise<option<response>> => {
    transaction->EdgeDB.TransactionHelpers.single(queryText, ~args, ~onError?)
  }
}