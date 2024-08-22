open Listing

/** All listings in chronological order */
@gql.field
let listings = async (
  _: Schema.query,
  ~ctx: ResGraphContext.context,
  ~first,
  ~after,
  ~before,
  ~last,
): listingConnection => {
  open ResGraph.Connections
  let arrayLength =
    await ctx.dataLoaders.listing.count->DataLoader.load((ctx.edgedbClient, {}))

  let (args, sliceStart) = switch {first, after, before, last} {
  | {first: None, after: None, before: None, last: None} => (({}: Listing__edgeql.All.args), 0.)
  | {first, after, before: None, last: None} => (
      {
        limit: ConnectionHelpers.first(~first, ~arrayLength)->Null.fromOption,
        offset: ConnectionHelpers.after(~after, ~arrayLength)->Null.fromOption,
      },
      ConnectionHelpers.after(~after, ~arrayLength)->Option.getOr(0.),
    )
  | {first: None, after: None, before, last} =>
    let last = ConnectionHelpers.last(~last, ~arrayLength)
    let before = ConnectionHelpers.before(~before, ~last, ~arrayLength)
    ({limit: Null.make(last), offset: Null.make(before)}, before)
  | _ => panic("Invalid arguments")
  }
  let listings = await ctx.dataLoaders.listing.many->DataLoader.load((ctx.edgedbClient, args))

  ConnectionHelpers.connectionFromArraySlice(
    listings,
    ~args={first, after, before, last},
    ~meta={sliceStart, arrayLength},
  )
}
