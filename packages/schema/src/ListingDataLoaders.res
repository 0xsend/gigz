type listings = {listings: array<Listing.listing>, totalCount: float}
type offers = {offers: array<Listing.listing>, totalCount: float}
type gigs = {gigs: array<Listing.listing>, totalCount: float}

type t = {
  byId: DataLoader.t<(EdgeDB.Client.t, string), option<Listing.listing>>,
  listings: DataLoader.t<(EdgeDB.Client.t, Listing__edgeql.Listings.args), listings>,
  offers: DataLoader.t<(EdgeDB.Client.t, Listing__edgeql.Offers.args), offers>,
  gigs: DataLoader.t<(EdgeDB.Client.t, Listing__edgeql.Gigs.args), gigs>,
}

let make = () => {
  byId: DataLoader.makeSingle(async ((edgedbClient, id)) =>
    (await Listing.one(edgedbClient, {id: id}, ~onError=Console.error))->Option.map(
      Listing.castOneToResgraph,
    )
  ),
  listings: DataLoader.makeSingle(async ((edgedbClient, args)) =>
    switch await Listing.listings(edgedbClient, args) {
    | Ok({listings, total_cnt}) => {
        listings: listings->Listing.castManyToResgraph,
        totalCount: total_cnt,
      }
    | Error(_) => panic("Error listings") //@Todo: better error handling
    }
  ),
  offers: DataLoader.makeSingle(async ((edgedbClient, args)) =>
    switch await Listing.offers(edgedbClient, args) {
    | Ok({offers, total_cnt}) => {
        offers: offers->Listing.castOffersToResgraph,
        totalCount: total_cnt,
      }
    | Error(_) => panic("Error offers") //@Todo: better error handling
    }
  ),
  gigs: DataLoader.makeSingle(async ((edgedbClient, args)) =>
    switch await Listing.gigs(edgedbClient, args) {
    | Ok({gigs, total_cnt}) => {
        gigs: gigs->Listing.castGigsToResgraph,
        totalCount: total_cnt,
      }
    | Error(_) => panic("Error gigs") //@Todo: better error handling
    }
  ),
}
