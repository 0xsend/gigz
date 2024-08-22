open Listing

type connectionMeta = {sliceStart: float, arrayLength: float}

// TODO: This is ugly and hacky. Should be fixed in resgraph soon.
@module("resgraph/src/res/graphqlRelayConnections.mjs")
external connectionFromArraySlice: (
  array<listing>,
  ~args: ResGraph.Connections.connectionArgs,
  ~meta: connectionMeta,
) => listingConnection = "connectionFromArraySlice"

@module("resgraph/src/res/graphqlRelayConnections.mjs")
external getOffsetWithDefault: (option<string>, float) => float = "getOffsetWithDefault"

@module("resgraph/src/res/graphqlRelayConnections.mjs")
external cursorToOffset: string => float = "cursorToOffset"

/** All listings */
@gql.field
let allListings = async (
  _: Schema.query,
  ~ctx: ResGraphContext.context,
  ~first,
  ~after,
  ~before,
  ~last,
): listingConnection => {
  open ResGraph.Connections
  let arrayLength = await ctx.dataLoaders.listing.totalCount->DataLoader.load(ctx.edgedbClient)
  let (listings, sliceStart) = switch {first, after, before, last} {
  | {first: None, after: None, before: None, last: None} => (
      await ctx.dataLoaders.listing.list->DataLoader.load((ctx.edgedbClient, {})),
      0.,
    )
  | {first, after, before: None, last: None} =>
    let limit = switch first {
    | None => Null.null
    | Some(first) if first < 0 => panic("Invalid first argument")
    | Some(first) => Null.Value(min(float(first), arrayLength))
    }
    let offset = switch after->Option.map(cursorToOffset) {
    | None => Null.null
    | Some(offset) if offset < 0. || Float.isNaN(offset) => panic("Invalid after argument") // Should be result type or something
    | Some(offset) => Null.Value(min(offset, arrayLength -. 1.))
    }
    (
      await ctx.dataLoaders.listing.list->DataLoader.load((ctx.edgedbClient, {offset, limit})),
      offset->Null.toOption->Option.getOr(0.),
    )
  | {first: None, after: None, before, last} =>
    let limit = switch last {
    | None => arrayLength
    | Some(last) if last < 0 => panic("Invalid last argument")
    | Some(last) if float(last) > arrayLength => arrayLength
    | Some(last) => float(last)
    }
    let offset = switch before->Option.map(cursorToOffset) {
    | None => max(0., arrayLength -. 1. -. limit)
    | Some(offset) if offset < 0. || offset->Float.isNaN => panic("Invalid before argument") // Should be result type or something
    | Some(offset) => max(0., arrayLength -. limit -. offset +. 1.)
    }
    Console.log(offset)
    (
      await ctx.dataLoaders.listing.list->DataLoader.load((
        ctx.edgedbClient,
        {offset: Null.Value(offset), limit: Null.Value(limit)},
      )),
      offset,
    )
  | _ => panic("Invalid arguments")
  }

  connectionFromArraySlice(
    listings,
    ~args={first, after, before, last},
    ~meta={sliceStart, arrayLength},
  )
}
