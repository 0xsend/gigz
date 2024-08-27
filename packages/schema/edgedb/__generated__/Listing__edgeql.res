// @sourceHash 9aa0dbc8e0e2b63b8cd46caf21f6a85a

module Listings = {
  let queryText = `# @name listings
      with
        selection := (select Listing{*, creator, skills:{id, title_name}}
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
  
  type response__listings__creator__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response__listings__creator__socials = {
    x: string,
    telegram: string,
  }
  
  type response__listings__creator = {
    id: string,
    categories: Null.t<array<[#GraphicDesign | #MotionDesign | #ThreeDArt | #PhotoVideo | #WebDesign]>>,
    created_at: Date.t,
    sendid: float,
    bio: Null.t<string>,
    hearts: Null.t<float>,
    pills: response__listings__creator__pills,
    portfolio_link: Null.t<string>,
    socials: response__listings__creator__socials,
  }
  
  type response__listings__skills = {
    title_name: string,
    name: string,
    id: string,
  }
  
  type response__listings = {
    id: string,
    categories: array<[#GraphicDesign | #MotionDesign | #ThreeDArt | #PhotoVideo | #WebDesign]>,
    created_at: Date.t,
    listing_type: [#Gig | #Offer],
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    pills: response__listings__pills,
    title: string,
    creator: response__listings__creator,
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
    select Listing {*, creator, skills:{id, title_name}} filter .id = <uuid>$id limit 1;`
  
  @live  
  type args = {
    id: string,
  }
  
  type response__creator = {
    id: string,
  }
  
  type response__skills = {
    id: string,
    title_name: string,
  }
  
  type response__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response = {
    creator: response__creator,
    skills: array<response__skills>,
    id: string,
    categories: array<[#GraphicDesign | #MotionDesign | #ThreeDArt | #PhotoVideo | #WebDesign]>,
    created_at: Date.t,
    listing_type: [#Gig | #Offer],
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    pills: response__pills,
    title: string,
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
        selection := (select Listing {*, creator, skills:{id, title_name}}
          filter .listing_type = ListingType.Offer
          order by .created_at desc
          offset <optional int64>$offset
          limit <optional int64>$limit),
        select_all := (select Listing filter .listing_type = ListingType.Offer)
      select {
        offers := selection{**},
        total_cnt := count(select_all)
      }`
  
  @live  
  type args = {
    offset?: Null.t<float>,
    limit?: Null.t<float>,
  }
  
  type response__offers__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response__offers__creator__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response__offers__creator__socials = {
    x: string,
    telegram: string,
  }
  
  type response__offers__creator = {
    id: string,
    categories: Null.t<array<[#GraphicDesign | #MotionDesign | #ThreeDArt | #PhotoVideo | #WebDesign]>>,
    created_at: Date.t,
    sendid: float,
    bio: Null.t<string>,
    hearts: Null.t<float>,
    pills: response__offers__creator__pills,
    portfolio_link: Null.t<string>,
    socials: response__offers__creator__socials,
  }
  
  type response__offers__skills = {
    title_name: string,
    name: string,
    id: string,
  }
  
  type response__offers = {
    id: string,
    categories: array<[#GraphicDesign | #MotionDesign | #ThreeDArt | #PhotoVideo | #WebDesign]>,
    created_at: Date.t,
    listing_type: [#Gig | #Offer],
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    pills: response__offers__pills,
    title: string,
    creator: response__offers__creator,
    skills: array<response__offers__skills>,
  }
  
  type response = {
    offers: array<response__offers>,
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
        selection := (select Listing {*, creator, skills:{id, title_name}}
          filter .listing_type = ListingType.Gig
          order by .created_at desc
          offset <optional int64>$offset
          limit <optional int64>$limit),
        select_all := (select Listing filter .listing_type = ListingType.Gig)
      select {
        gigs := selection{**},
        total_cnt := count(select_all)
      }`
  
  @live  
  type args = {
    offset?: Null.t<float>,
    limit?: Null.t<float>,
  }
  
  type response__gigs__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response__gigs__creator__pills = {
    usdc: bigint,
    eth: bigint,
    send: bigint,
  }
  
  type response__gigs__creator__socials = {
    x: string,
    telegram: string,
  }
  
  type response__gigs__creator = {
    id: string,
    categories: Null.t<array<[#GraphicDesign | #MotionDesign | #ThreeDArt | #PhotoVideo | #WebDesign]>>,
    created_at: Date.t,
    sendid: float,
    bio: Null.t<string>,
    hearts: Null.t<float>,
    pills: response__gigs__creator__pills,
    portfolio_link: Null.t<string>,
    socials: response__gigs__creator__socials,
  }
  
  type response__gigs__skills = {
    title_name: string,
    name: string,
    id: string,
  }
  
  type response__gigs = {
    id: string,
    categories: array<[#GraphicDesign | #MotionDesign | #ThreeDArt | #PhotoVideo | #WebDesign]>,
    created_at: Date.t,
    listing_type: [#Gig | #Offer],
    description: Null.t<string>,
    image_links: Null.t<array<string>>,
    pills: response__gigs__pills,
    title: string,
    creator: response__gigs__creator,
    skills: array<response__gigs__skills>,
  }
  
  type response = {
    gigs: array<response__gigs>,
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