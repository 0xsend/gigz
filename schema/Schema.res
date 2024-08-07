@gql.type
type query

@gql.type
type mutation

/** The current time on the server, as a timestamp. */
@gql.field
let currentTime = (_: query) => {
  Some(Date.now())
}

// import { ObjectType, Field, ID } from '@nestjs/graphql';
// //               v Don't forget to prefix type with "GraphQL"
// import { GraphQLBigInt, GraphQLDate } from 'graphql-scalars';

// @ObjectType()
// export class GuyEntity {
//   @Field(() => String, {
//     description: 'The guy name.',
//     nullable: false,
//   })
//   name: string;

//   //                 v GraphQL scalar type
//   @Field(() => GraphQLBigInt, {
//     description: 'Social security number, must be unique.',
//     nullable: false,
//   })
//   //                      v js/ts type
//   socialSecurityNumber: number;

//   @Field(() => GraphQLDate, {
//     description: 'Date of creation',
//     nullable: false,
//   })
//   createdAt: Date;
// }

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
