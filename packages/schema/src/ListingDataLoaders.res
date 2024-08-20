type t = {byId: DataLoader.t<string, option<Listing.listing>>}

let tap = x => {
  Console.log(x)
  x
}
let make = (~edgedbClient) => {
  byId: DataLoader.makeSingle(async listingId => {
    Console.log(listingId)

    (
      await Listing__edgeql.One.query(edgedbClient, {id: listingId}, ~onError=e => Console.log(e))
    )->Option.map(Listing.castToResgraph)
  }),
  // list: DataLoader.makeSingle(async ({completed, filterText}) => {
  //   let filteredTodos = await PretendDb.findTodos(~filterText?, ~filterCompleted=?completed)
  //   filteredTodos->Array.map(todo => (todo :> Todo.todo))
  // }),
}
