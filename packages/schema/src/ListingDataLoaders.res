type t = {
  byId: DataLoader.t<(EdgeDB.Client.t, string), option<Listing.listing>>,
  list: DataLoader.t<(EdgeDB.Client.t, Listing__edgeql.All.args), array<Listing.listing>>,
  totalCount: DataLoader.t<EdgeDB.Client.t, Listing__edgeql.CountAll.response>,
}

let make = () => {
  byId: DataLoader.makeSingle(async ((edgedbClient, id)) =>
    (await Listing.one(edgedbClient, {id: id}, ~onError=Console.error))->Option.map(
      Listing.castToResgraph,
    )
  ),
  list: DataLoader.makeSingle(async ((edgedbClient, args)) =>
    (await Listing.all(edgedbClient, args))->Array.map(listing =>
      (listing :> Listing__edgeql.One.response)->Listing.castToResgraph
    )
  ),
  totalCount: DataLoader.makeSingle(async edgedbClient =>
    switch await Listing.countAll(edgedbClient) {
    | Ok(count) => count
    | Error(_) => panic("Error counting listings")
    }
  ),
}
