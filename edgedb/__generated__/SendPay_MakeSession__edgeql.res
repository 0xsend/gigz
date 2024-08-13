// @sourceHash c2c74ea0041c3a2c26d6c82404f12adf

module MakeSession = {
  let queryText = `# @name makeSession
      select(insert Session {
        key := <str>$key,
        sendid := <int64>$sendid,
        sendtag := <optional str>$sendtag,
        address := <str>$address,
        avatar_url := <optional str>$avatarUrl,
        about := <optional str>$about,
        refcode := <optional str>$refcode,
        confirmation_address := <str>$confirmationAddress,
        confirmation_amount := <optional bigint>$confirmationAmount,
        chain_id := <optional SupportedChainId>$chainId,
        expires_at := <optional datetime>$expiresAt
      }){id,sendid, address, confirmation_address, chain_id}`
  
  @live  
  type args = {
    key: string,
    sendid: float,
    sendtag?: Null.t<string>,
    address: string,
    avatarUrl?: Null.t<string>,
    about?: Null.t<string>,
    refcode?: Null.t<string>,
    confirmationAddress: string,
    confirmationAmount?: Null.t<bigint>,
    chainId?: Null.t<int>,
    expiresAt?: Null.t<Date.t>,
  }
  
  type response = {
    id: string,
    sendid: float,
    address: string,
    confirmation_address: string,
    chain_id: Null.t<int>,
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