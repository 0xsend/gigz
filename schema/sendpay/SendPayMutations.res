// open SendPay

// @gql.field
// let makeSendpaySession = async (
//   _: Schema.mutation,
//   ~ctx: ResGraphContext.context,
//   ~input: MakeSession.makeSessionInput,
// ): MakeSession.makeSessionResult => {
//   switch await SendApi.profileLookup(input.identifier, input.lookupType) {
//   | Error(err) =>
//     Console.error(err)
//     MakeSession.Error({name: "SendPay Error", reason: "Something went wrong"})
//   | Ok(_) =>
//     // Check if user exists
//     switch await ctx.edgedbClient->MakeSession.query({
//       key: ctx.sendpayKey,
//       identifier: input.identifier,
//       lookup_type: SendPay.LookupType.toPolyvariant(input.lookupType),
//       confirmationAddress: input.confirmationAddress,
//       chainId: input.chainId->Option.map(chainId => (chainId :> int))->Null.fromOption,
//     }) {
//     | Ok({id: sessionId, identifier, lookup_type}) =>
//       Ok({
//         sessionId,
//         identifier,
//         lookupType: SendPay.LookupType.fromPolyvariant(lookup_type),
//       })
//     | Error(edgeDbError) =>
//       switch edgeDbError {
//       | EdgeDbError({code: ConstraintViolationError}) => Error({name: "Invalid Input", reason: ""})
//       | EdgeDbError(err) =>
//         Console.error(err)
//         Error({name: "EdgeDB Error", reason: "Failed to write to db. Check server logs."}) //@Make a helper for edgedb error codes
//       | GenericError(exn) =>
//         Error({
//           name: exn->Exn.name->Option.getOr("Unknown Error"),
//           reason: exn->Exn.message->Option.getOr(""),
//         })
//       }
//     }
//   }
// }

