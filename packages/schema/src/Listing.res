let listings = %edgeql(`
    # @name listings
    with
      selection := (select Listing{*, creator, skills:{id, title_name}}
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
  select Listing {*, creator, skills:{id, title_name}} filter .id = <uuid>$id limit 1;
`)

let offers = %edgeql(`
    # @name offers
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
    }
`)

let gigs = %edgeql(`
    # @name gigs
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
    }
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
  creator: string,
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
  @gql.field
  categories: array<Schema.Category.category>,
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

let castManyToResgraph = (listings: array<Listing__edgeql.Listings.response__listings>): array<
  listing,
> => {
  listings->Array.map(listing => {
    {
      id: listing.id,
      creator: listing.creator.id,
      listingType: listing.listing_type->ListingType.castFromDb,
      title: listing.title,
      description: ?listing.description->Null.toOption,
      imageLinks: ?listing.image_links->Null.toOption,
      pills: (listing.pills :> pills),
      skills: listing.skills->Array.map(skill => {id: skill.id, name: skill.title_name}),
      categories: listing.categories->Array.map(category => category->Schema.Category.castFromDb),
      createdAt: listing.created_at->Date.getTime,
    }
  })
}

let castOneToResgraph = (listing: Listing__edgeql.One.response): listing => {
  {
    id: listing.id,
    creator: listing.creator.id,
    listingType: listing.listing_type->ListingType.castFromDb,
    title: listing.title,
    description: ?listing.description->Null.toOption,
    imageLinks: ?listing.image_links->Null.toOption,
    pills: (listing.pills :> pills),
    skills: listing.skills->Array.map(skill => {id: skill.id, name: skill.title_name}),
    categories: listing.categories->Array.map(category => category->Schema.Category.castFromDb),
    createdAt: listing.created_at->Date.getTime,
  }
}

let castOffersToResgraph = (offers: array<Listing__edgeql.Offers.response__offers>): array<
  listing,
> => {
  offers->Array.map(offer => {
    {
      id: offer.id,
      creator: offer.creator.id,
      listingType: offer.listing_type->ListingType.castFromDb,
      title: offer.title,
      description: ?offer.description->Null.toOption,
      imageLinks: ?offer.image_links->Null.toOption,
      pills: (offer.pills :> pills),
      skills: offer.skills->Array.map(skill => {id: skill.id, name: skill.title_name}),
      categories: offer.categories->Array.map(category => category->Schema.Category.castFromDb),
      createdAt: offer.created_at->Date.getTime,
    }
  })
}

let castGigsToResgraph = (gigs: array<Listing__edgeql.Gigs.response__gigs>): array<listing> => {
  gigs->Array.map(gig => {
    {
      id: gig.id,
      creator: gig.creator.id,
      listingType: gig.listing_type->ListingType.castFromDb,
      title: gig.title,
      description: ?gig.description->Null.toOption,
      imageLinks: ?gig.image_links->Null.toOption,
      pills: (gig.pills :> pills),
      skills: gig.skills->Array.map(skill => {id: skill.id, name: skill.title_name}),
      categories: gig.categories->Array.map(category => category->Schema.Category.castFromDb),
      createdAt: gig.created_at->Date.getTime,
    }
  })
}
