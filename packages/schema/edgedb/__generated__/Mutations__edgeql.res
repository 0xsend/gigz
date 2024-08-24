// @sourceHash f83b988c5b585cd2da856b2bb67bc25e

module MakeListing = {
  let queryText = `# @name makeListing
    with NewListing := (insert Listing {
      title := <str>$title,
      sendid := <int64>$sendid,
      description := <optional str>$description,
      image_links := <optional array<str>>$imageLinks,
      listing_type := <ListingType>$listingType,
      pills := <tuple<usdc: bigint, eth: bigint, send: bigint>>$pills,
      skills := (with
                raw_data := <optional json>$skillData,
              for item in json_array_unpack(raw_data) union (
                insert Skill { name := <str>item['name'] }
              )),
      }) select NewListing {**}`
  
  @live  
  type args__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  @live  
  type args = {
    title: string,
    sendid: float,
    description?: Null.t<string>,
    imageLinks?: Null.t<array<string>>,
    listingType: [#Gig | #Offer],
    pills: args__pills,
    skillData?: Null.t<JSON.t>,
  }
  
  type response__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response__skills = {
    id: string,
    name: string,
  }
  
  type response = {
    pills: response__pills,
    created_at: Date.t,
    title: string,
    image_links: Null.t<array<string>>,
    description: Null.t<string>,
    sendid: float,
    listing_type: [#Gig | #Offer],
    id: string,
    skills: array<response__skills>,
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