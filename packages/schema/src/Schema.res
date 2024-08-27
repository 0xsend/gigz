@gql.type
type query

@gql.type
type mutation

/** The current time on the server, as a timestamp. */
@gql.field
let currentTime = (_: query) => {
  Some(Date.now())
}

module BigInt: {
  /** A bigint. */
  @gql.scalar
  type t = bigint
  /** Parses a bigint from a string. */
  let parseValue: ResGraph.GraphQLLiteralValue.t => option<t>
  /** Serializes a bigint to a string. */
  let serialize: t => ResGraph.GraphQLLiteralValue.t
} = {
  type t = bigint

  open ResGraph.GraphQLLiteralValue

  let parseValue = v =>
    switch v {
    | String(str) =>
      try {
        Some(BigInt.fromStringExn(str))
      } catch {
      | _ => None
      }
    | Number(number) => Some(BigInt.fromFloat(number))
    | _ => None
    }

  let serialize = x => x->BigInt.toString->String
}

module Category = {
  @gql.enum
  type category = GraphicDesign | MotionDesign | ThreeDArt | PhotoVideo | WebDesign
  let castFromDb = category =>
    switch category {
    | #GraphicDesign => GraphicDesign
    | #MotionDesign => MotionDesign
    | #ThreeDArt => ThreeDArt
    | #PhotoVideo => PhotoVideo
    | #WebDesign => WebDesign
    }
  let castToDb = category =>
    switch category {
    | GraphicDesign => #GraphicDesign
    | MotionDesign => #MotionDesign
    | ThreeDArt => #ThreeDArt
    | PhotoVideo => #PhotoVideo
    | WebDesign => #WebDesign
    }
}
