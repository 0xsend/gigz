type list = {listings: array<Listing.listing>, totalCount: float}

type t = {
  byId: DataLoader.t<(EdgeDB.Client.t, string), option<Listing.listing>>,
  many: DataLoader.t<(EdgeDB.Client.t, Listing__edgeql.Listings.args), list>,
  offers: DataLoader.t<(EdgeDB.Client.t, Listing__edgeql.Offers.args), list>,
  gigs: DataLoader.t<(EdgeDB.Client.t, Listing__edgeql.Gigs.args), list>,
}

let make = () => {
  byId: DataLoader.makeSingle(async ((edgedbClient, id)) =>
    (await Listing.one(edgedbClient, {id: id}, ~onError=Console.error))->Option.map(
      Listing.castToResgraph,
    )
  ),
  many: DataLoader.makeSingle(async ((edgedbClient, args)) =>
    switch await Listing.listings(edgedbClient, args) {
    | Ok({listings, total_cnt}) => {
        listings: listings->Array.map(listing =>
          (listing :> Listing__edgeql.One.response)->Listing.castToResgraph
        ),
        totalCount: total_cnt,
      }
    | Error(_) => panic("Error listings") //@Todo: better error handling
    }
  ),
  offers: DataLoader.makeSingle(async ((edgedbClient, args)) =>
    switch await Listing.offers(edgedbClient, args) {
    | Ok({listings, total_cnt}) => {
        listings: listings->Array.map(listing =>
          (listing :> Listing__edgeql.One.response)->Listing.castToResgraph
        ),
        totalCount: total_cnt,
      }
    | Error(_) => panic("Error offers") //@Todo: better error handling
    }
  ),
  gigs: DataLoader.makeSingle(async ((edgedbClient, args)) =>
    switch await Listing.gigs(edgedbClient, args) {
    | Ok({listings, total_cnt}) => {
        listings: listings->Array.map(listing =>
          (listing :> Listing__edgeql.One.response)->Listing.castToResgraph
        ),
        totalCount: total_cnt,
      }
    | Error(_) => panic("Error gigs") //@Todo: better error handling
    }
  ),
}
