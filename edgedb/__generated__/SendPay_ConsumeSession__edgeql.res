// @sourceHash ac53db09cae2c7037c0fff6381eb02a9

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
    confirmation_address: string,
    sendtag: Null.t<string>,
    sendid: float,
    refcode: Null.t<string>,
    created_at: Date.t,
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