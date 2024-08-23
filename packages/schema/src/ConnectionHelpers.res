//@TODO: Should probably test this and write some comments

type connectionMeta = {sliceStart: float, arrayLength: float}

// TODO: This is ugly and hacky. Should be fixed in resgraph soon.
@module("resgraph/src/res/graphqlRelayConnections.mjs")
external connectionFromArraySlice: (
  array<'a>,
  ~args: ResGraph.Connections.connectionArgs,
  ~meta: connectionMeta,
) => 'b = "connectionFromArraySlice"

@module("resgraph/src/res/graphqlRelayConnections.mjs")
external cursorToOffset: string => float = "cursorToOffset"