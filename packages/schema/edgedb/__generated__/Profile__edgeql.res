// @sourceHash 96238cd1d4ae5b5667f84bfb23398e44

module ProfileById = {
  let queryText = `# @name profileById
      with
        id := <uuid>$id
      select Profile{*} filter .id = id limit 1`
  
  @live  
  type args = {
    id: string,
  }
  
  type response__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response__socials = {
    x: string,
    telegram: string,
  }
  
  type response = {
    id: string,
    categories: Null.t<array<[#GraphicDesign | #MotionDesign | #ThreeDArt | #PhotoVideo | #WebDesign]>>,
    created_at: Date.t,
    sendid: float,
    bio: Null.t<string>,
    hearts: Null.t<float>,
    pills: response__pills,
    portfolio_link: Null.t<string>,
    socials: response__socials,
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

module ProfileBySendId = {
  let queryText = `# @name profileBySendId
      with
        sendid := <int64>$sendid
      select Profile{*} filter .sendid = sendid limit 1`
  
  @live  
  type args = {
    sendid: float,
  }
  
  type response__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response__socials = {
    x: string,
    telegram: string,
  }
  
  type response = {
    id: string,
    categories: Null.t<array<[#GraphicDesign | #MotionDesign | #ThreeDArt | #PhotoVideo | #WebDesign]>>,
    created_at: Date.t,
    sendid: float,
    bio: Null.t<string>,
    hearts: Null.t<float>,
    pills: response__pills,
    portfolio_link: Null.t<string>,
    socials: response__socials,
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