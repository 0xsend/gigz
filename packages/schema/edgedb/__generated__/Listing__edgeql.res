// @sourceHash 54e722e0b63471afc56634ab5b189740

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
  
  type response__listings__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response__listings__skills = {
    name: string,
    id: string,
  }
  
  type response__listings = {
    id: string,
    listing_type: [#Gig | #Offer],
    sendid: float,
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    title: string,
    created_at: Date.t,
    pills: response__listings__pills,
    skills: array<response__listings__skills>,
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
    id: string,
    listing_type: [#Gig | #Offer],
    sendid: float,
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    title: string,
    created_at: Date.t,
    pills: response__pills,
    skills: array<response__skills>,
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
  
  type response__listings__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response__listings__skills = {
    name: string,
    id: string,
  }
  
  type response__listings = {
    id: string,
    listing_type: [#Gig | #Offer],
    sendid: float,
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    title: string,
    created_at: Date.t,
    pills: response__listings__pills,
    skills: array<response__listings__skills>,
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
  
  type response__listings__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response__listings__skills = {
    name: string,
    id: string,
  }
  
  type response__listings = {
    id: string,
    listing_type: [#Gig | #Offer],
    sendid: float,
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    title: string,
    created_at: Date.t,
    pills: response__listings__pills,
    skills: array<response__listings__skills>,
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
    id: string,
    listing_type: [#Gig | #Offer],
    sendid: float,
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    title: string,
    created_at: Date.t,
    pills: response__pills,
    skills: array<response__skills>,
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