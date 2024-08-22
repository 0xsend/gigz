// @sourceHash c0b42c42584f3268006cc438a0cad166

module Count = {
  let queryText = `# @name count
    with listingType := <optional ListingType>$listingType,
      select count(Listing)
      if exists listingType = false else
      count(Listing filter .listing_type = ListingType.Gig)
        if listingType = ListingType.Gig else
      count(Listing filter .listing_type = ListingType.Offer)
        if listingType = ListingType.Offer else
      count({})`

  @live
  type args = {
    listingType?: Null.t<[#Gig | #Offer]>,
  }

  type response = float

  @live
  let query = (client: EdgeDB.Client.t, args: args, ~onError=?): promise<option<response>> => {
    client->EdgeDB.QueryHelpers.single(queryText, ~args, ~onError?)
  }

  @live
  let transaction = (transaction: EdgeDB.Transaction.t, args: args, ~onError=?): promise<option<response>> => {
    transaction->EdgeDB.TransactionHelpers.single(queryText, ~args, ~onError?)
  }
}

module All = {
  let queryText = `# @name all
      select Listing {**}
      order by .created_at desc
      offset <optional int64>$offset
      limit <optional int64>$limit`

  @live
  type args = {
    offset?: Null.t<float>,
    limit?: Null.t<float>,
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

module AllOffers = {
  let queryText = `# @name allOffers
      select Listing {**}
      filter .listing_type = ListingType.Offer
      order by .created_at desc
      offset <optional int64>$offset
      limit <optional int64>$limit`

  @live
  type args = {
    offset?: Null.t<float>,
    limit?: Null.t<float>,
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

module AllGigs = {
  let queryText = `# @name allGigs
      select Listing {**}
      filter .listing_type = ListingType.Gig
      order by .created_at desc
      offset <optional int64>$offset
      limit <optional int64>$limit`

  @live
  type args = {
    offset?: Null.t<float>,
    limit?: Null.t<float>,
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