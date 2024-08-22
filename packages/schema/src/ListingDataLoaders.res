type t = {
  byId: DataLoader.t<(EdgeDB.Client.t, string), option<Listing.listing>>,
  many: DataLoader.t<(EdgeDB.Client.t, Listing__edgeql.All.args), array<Listing.listing>>,
  count: DataLoader.t<
    (EdgeDB.Client.t, Listing__edgeql.Count.args),
    Listing__edgeql.Count.response,
  >,
}

let make = () => {
  byId: DataLoader.makeSingle(async ((edgedbClient, id)) =>
    (await Listing.one(edgedbClient, {id: id}, ~onError=Console.error))->Option.map(
      Listing.castToResgraph,
    )
  ),
  many: DataLoader.makeSingle(async ((edgedbClient, args)) =>
    (await Listing.all(edgedbClient, args))->Array.map(listing =>
      (listing :> Listing__edgeql.One.response)->Listing.castToResgraph
    )
  ),
  count: DataLoader.makeSingle(async ((edgedbClient, args)) =>
    switch await Listing.count(edgedbClient, args) {
    | Some(count) => count
    | None => panic("Error counting listings")
    }
  ),
}
