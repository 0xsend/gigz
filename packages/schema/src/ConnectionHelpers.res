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

let first = (~first, ~arrayLength) =>
  switch first {
  | None => None
  | Some(first) if first < 0 => panic("Invalid first argument")
  | Some(first) => Some(min(float(first), arrayLength))
  }
let after = (~after, ~arrayLength) =>
  switch after->Option.map(cursorToOffset) {
  | None => None
  | Some(offset) if offset < 0. || Float.isNaN(offset) => panic("Invalid after argument") // Should be result type or something
  | Some(offset) => min(offset, arrayLength -. 1.)->Some
  }

let last = (~last, ~arrayLength) =>
  switch last {
  | None => arrayLength
  | Some(last) if last < 0 => panic("Invalid last argument")
  | Some(last) if float(last) > arrayLength => arrayLength
  | Some(last) => float(last)
  }

let before = (~before, ~last, ~arrayLength) =>
  switch before->Option.map(cursorToOffset) {
  | None => max(0., arrayLength -. last)
  | Some(offset) if offset < 0. || offset->Float.isNaN => panic("Invalid before argument") // Should be result type or something
  | Some(offset) => max(0., 0. +. offset -. last +. 1.)
  }
