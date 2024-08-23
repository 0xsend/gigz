// @sourceHash e9b3ccdd671b14f0ad6121073638b0e6

module Listings = {
  let queryText = `# @name listings
      with
        selection := (select Listing{**}
          order by .created_at desc
          offset <optional int64>$offset
          limit <optional int64>$limit),
        select_all := (select Listing)
      select {
        listings := selection{**},
        total_cnt := count(select_all)
      }`
  
  @live  
  type args = {
    offset?: Null.t<float>,
    limit?: Null.t<float>,
  }
  
  type response__listings__contact_fees = {
    token: [#USDC | #ETH | #SEND],
    amount: bigint,
    id: string,
  }
  
  type response__listings__fees = {
    token: [#USDC | #ETH | #SEND],
    amount: bigint,
    id: string,
  }
  
  type response__listings__tags = {
    name: string,
    id: string,
  }
  
  type response__listings = {
    id: string,
    listing_type: [#Gig | #Offer],
    sendid: float,
    contact_links: array<string>,
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    title: string,
    created_at: Date.t,
    contact_fees: array<response__listings__contact_fees>,
    fees: array<response__listings__fees>,
    tags: array<response__listings__tags>,
  }
  
  type response = {
    listings: array<response__listings>,
    total_cnt: float,
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

module One = {
  let queryText = `# @name one
    select Listing {**} filter .id = <uuid>$id limit 1;`
  
  @live  
  type args = {
    id: string,
  }
  
  type response__contact_fees = {
    id: string,
    amount: bigint,
    token: [#USDC | #ETH | #SEND],
  }
  
  type response__fees = {
    id: string,
    amount: bigint,
    token: [#USDC | #ETH | #SEND],
  }
  
  type response__tags = {
    id: string,
    name: string,
  }
  
  type response = {
    id: string,
    listing_type: [#Gig | #Offer],
    sendid: float,
    contact_links: array<string>,
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    title: string,
    created_at: Date.t,
    contact_fees: array<response__contact_fees>,
    fees: array<response__fees>,
    tags: array<response__tags>,
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

module Offers = {
  let queryText = `# @name offers
      with
        selection := (select Listing {**}
          filter .listing_type = ListingType.Offer
          order by .created_at desc
          offset <optional int64>$offset
          limit <optional int64>$limit),
        select_all := (select Listing filter .listing_type = ListingType.Offer)
      select {
        listings := selection{**},
        total_cnt := count(select_all)
      }`
  
  @live  
  type args = {
    offset?: Null.t<float>,
    limit?: Null.t<float>,
  }
  
  type response__listings__contact_fees = {
    token: [#USDC | #ETH | #SEND],
    amount: bigint,
    id: string,
  }
  
  type response__listings__fees = {
    token: [#USDC | #ETH | #SEND],
    amount: bigint,
    id: string,
  }
  
  type response__listings__tags = {
    name: string,
    id: string,
  }
  
  type response__listings = {
    id: string,
    listing_type: [#Gig | #Offer],
    sendid: float,
    contact_links: array<string>,
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    title: string,
    created_at: Date.t,
    contact_fees: array<response__listings__contact_fees>,
    fees: array<response__listings__fees>,
    tags: array<response__listings__tags>,
  }
  
  type response = {
    listings: array<response__listings>,
    total_cnt: float,
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

module Gigs = {
  let queryText = `# @name gigs
      with
        selection := (select Listing {**}
          filter .listing_type = ListingType.Gig
          order by .created_at desc
          offset <optional int64>$offset
          limit <optional int64>$limit),
        select_all := (select Listing filter .listing_type = ListingType.Gig)
      select {
        listings := selection{**},
        total_cnt := count(select_all)
      }`
  
  @live  
  type args = {
    offset?: Null.t<float>,
    limit?: Null.t<float>,
  }
  
  type response__listings__contact_fees = {
    token: [#USDC | #ETH | #SEND],
    amount: bigint,
    id: string,
  }
  
  type response__listings__fees = {
    token: [#USDC | #ETH | #SEND],
    amount: bigint,
    id: string,
  }
  
  type response__listings__tags = {
    name: string,
    id: string,
  }
  
  type response__listings = {
    id: string,
    listing_type: [#Gig | #Offer],
    sendid: float,
    contact_links: array<string>,
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    title: string,
    created_at: Date.t,
    contact_fees: array<response__listings__contact_fees>,
    fees: array<response__listings__fees>,
    tags: array<response__listings__tags>,
  }
  
  type response = {
    listings: array<response__listings>,
    total_cnt: float,
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

module OfferBySendId = {
  let queryText = `# @name offerBySendId
    select Listing {**} filter
      .listing_type = ListingType.Offer
      and .sendid = <int64>$sendid;`
  
  @live  
  type args = {
    sendid: float,
  }
  
  type response__contact_fees = {
    id: string,
    amount: bigint,
    token: [#USDC | #ETH | #SEND],
  }
  
  type response__fees = {
    id: string,
    amount: bigint,
    token: [#USDC | #ETH | #SEND],
  }
  
  type response__tags = {
    id: string,
    name: string,
  }
  
  type response = {
    id: string,
    listing_type: [#Gig | #Offer],
    sendid: float,
    contact_links: array<string>,
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    title: string,
    created_at: Date.t,
    contact_fees: array<response__contact_fees>,
    fees: array<response__fees>,
    tags: array<response__tags>,
  }
  
  @live
  let query = (client: EdgeDB.Client.t, args: args): promise<array<response>> => {
    client->EdgeDB.QueryHelpers.many(queryText, ~args)
  }
  
  @live
  let transaction = (transaction: EdgeDB.Transaction.t, args: args): promise<array<response>> => {
    transaction->EdgeDB.TransactionHelpers.many(queryText, ~args)
  }
}