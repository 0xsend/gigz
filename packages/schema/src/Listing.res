let listings = %edgeql(`
    # @name listings
    with
      selection := (select Listing{**}
        order by .created_at desc
        offset <optional int64>$offset
        limit <optional int64>$limit),
      select_all := (select Listing)
    select {
      listings := selection{**},
      total_cnt := count(select_all)
    }
`)

let one = %edgeql(`
  # @name one
  select Listing {**} filter .id = <uuid>$id limit 1;
`)

let offers = %edgeql(`
    # @name offers
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
    }
`)

let gigs = %edgeql(`
    # @name gigs
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
    }
`)

let offerBySendId = %edgeql(`
  # @name offerBySendId
  select Listing {**} filter
    .listing_type = ListingType.Offer
    and .sendid = <int64>$sendid;
`)

@gql.enum
type listingType = Gig | Offer

@gql.enum
type token = USDC | ETH | SEND

@gql.type
type pills = {
  @gql.field
  usdc: Schema.BigInt.t,
  @gql.field
  eth: Schema.BigInt.t,
  @gql.field
  send: Schema.BigInt.t,
}

@gql.type
type skill = {
  ...NodeInterface.node,
  @gql.field
  name: string,
}

/** A single listing item. */
@gql.type
type listing = {
  ...NodeInterface.node,
  @gql.field
  title: string,
  @gql.enum
  listingType: listingType,
  @gql.field
  description?: string,
  @gql.field
  imageLinks?: array<string>,
  @gql.field
  pills: pills,
  @gql.field
  skills: array<skill>,
  @gql.field
  createdAt: float,
}

/** An edge to a listing. */
@gql.type
type listingEdge = {...ResGraph.Connections.edge<listing>}

/** A connection to a listing. */
@gql.type
type listingConnection = {...ResGraph.Connections.connection<listingEdge>}

module Token = {
  let castFromDb = token =>
    switch token {
    | #USDC => USDC
    | #ETH => ETH
    | #SEND => SEND
    }
  let castToDb = token =>
    switch token {
    | USDC => #USDC
    | ETH => #ETH
    | SEND => #SEND
    }
}

module ListingType = {
  let castFromDb = listingType =>
    switch listingType {
    | #Gig => Gig
    | #Offer => Offer
    }
  let castToDb = listingType =>
    switch listingType {
    | Gig => #Gig
    | Offer => #Offer
    }
}

let castToResgraph = (listing: Listing__edgeql.One.response): listing => {
  {
    id: listing.id,
    listingType: listing.listing_type->ListingType.castFromDb,
    title: listing.title,
    description: ?listing.description->Null.toOption,
    imageLinks: ?listing.image_links->Null.toOption,
    pills: (listing.pills :> pills),
    skills: (listing.skills :> array<skill>),
    createdAt: listing.created_at->Date.getTime,
  }
}
