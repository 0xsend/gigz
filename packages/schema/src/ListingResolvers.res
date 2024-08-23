open Listing

/** All listings in chronological order */
@gql.field
let listings = async (
  _: Schema.query,
  ~ctx: ResGraphContext.context,
  ~first,
  ~after,
): listingConnection => {
  open ResGraph.Connections
  let limit = switch first {
  | None => Null.null
  | Some(count) if count < 0 => panic("Invalid first or last argument")
  | Some(count) => Value(float(count))
  }
  let offset = switch after->Option.map(ConnectionHelpers.cursorToOffset) {
  | None => Null.null
  | Some(offset) if offset < 0. || Float.isNaN(offset) => panic("Invalid after argument") // Should be result type or something
  | Some(offset) => Value(offset)
  }
  let {listings, totalCount} =
    await ctx.dataLoaders.listing.many->DataLoader.load((ctx.edgedbClient, {limit, offset}))

  ConnectionHelpers.connectionFromArraySlice(
    listings,
    ~args={first, after, last: None, before: None},
    ~meta={sliceStart: offset->Null.getOr(0.), arrayLength: totalCount},
  )
}

/** All offers in chronological order */
@gql.field
let offers = async (
  _: Schema.query,
  ~ctx: ResGraphContext.context,
  ~first,
  ~after,
): listingConnection => {
  open ResGraph.Connections
  let limit = switch first {
  | None => Null.null
  | Some(count) if count < 0 => panic("Invalid first or last argument")
  | Some(count) => Value(float(count))
  }
  let offset = switch after->Option.map(ConnectionHelpers.cursorToOffset) {
  | None => Null.null
  | Some(offset) if offset < 0. || Float.isNaN(offset) => panic("Invalid after argument") // Should be result type or something
  | Some(offset) => Value(offset)
  }

  let {listings, totalCount} =
    await ctx.dataLoaders.listing.offers->DataLoader.load((ctx.edgedbClient, {limit, offset}))

  ConnectionHelpers.connectionFromArraySlice(
    listings,
    ~args={first, after, last: None, before: None},
    ~meta={sliceStart: offset->Null.getOr(0.), arrayLength: totalCount},
  )
}

/** All gigs in chronological order */
@gql.field
let gigs = async (
  _: Schema.query,
  ~ctx: ResGraphContext.context,
  ~first,
  ~after,
): listingConnection => {
  open ResGraph.Connections
  let limit = switch first {
  | None => Null.null
  | Some(count) if count < 0 => panic("Invalid first or last argument")
  | Some(count) => Value(float(count))
  }
  let offset = switch after->Option.map(ConnectionHelpers.cursorToOffset) {
  | None => Null.null
  | Some(offset) if offset < 0. || Float.isNaN(offset) => panic("Invalid after argument") // Should be result type or something
  | Some(offset) => Value(offset)
  }

  let {listings, totalCount} =
    await ctx.dataLoaders.listing.gigs->DataLoader.load((ctx.edgedbClient, {limit, offset}))

  ConnectionHelpers.connectionFromArraySlice(
    listings,
    ~args={first, after, last: None, before: None},
    ~meta={sliceStart: offset->Null.getOr(0.), arrayLength: totalCount},
  )
}
