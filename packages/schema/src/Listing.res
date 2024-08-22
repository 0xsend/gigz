let all = %edgeql(`
    # @name all
    select Listing {**};
`)

let one = %edgeql(`
  # @name one
  select Listing {**} filter .id = <uuid>$id;
`)

let allOffers = %edgeql(`
    # @name allOffers
    select Listing {**} filter .listing_type = ListingType.Offer;
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
type fee = {
  ...NodeInterface.node,
  @gql.field
  amount: Schema.BigInt.t,
  @gql.field
  token: token,
}

@gql.type
type tag = {
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
  contactLinks: array<string>,
  @gql.field
  contactFees?: array<fee>,
  @gql.field
  fees: array<fee>,
  @gql.field
  tags: array<tag>,
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

module Fee = {
  let castFromDb = (fee: Listing__edgeql.One.response__fees): fee => {
    {id: fee.id, amount: fee.amount, token: fee.token->Token.castFromDb}
  }
}

let castToResgraph = (listing: Listing__edgeql.One.response): listing => {
  {
    id: listing.id,
    listingType: listing.listing_type->ListingType.castFromDb,
    title: listing.title,
    contactLinks: listing.contact_links,
    description: ?listing.description->Null.toOption,
    imageLinks: ?listing.image_links->Null.toOption,
    contactFees: listing.contact_fees->Array.map(({id, amount, token}) =>
      ({id, amount, token: Token.castFromDb(token)} :> fee)
    ),
    fees: listing.fees->Array.map(({id, amount, token}) =>
      ({id, amount, token: Token.castFromDb(token)} :> fee)
    ),
    tags: (listing.tags :> array<tag>),
    createdAt: listing.created_at->Date.getTime,
  }
}
