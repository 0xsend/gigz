// @sourceHash cd642b3aacab223cabf800eef9c560d9

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
    refcode: Null.t<string>,
    confirmation_amount: Null.t<bigint>,
    avatar_url: Null.t<string>,
    about: Null.t<string>,
    sendtag: Null.t<string>,
    sendid: float,
    created_at: Date.t,
    confirmation_address: string,
    chain_id: Null.t<int>,
    address: string,
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