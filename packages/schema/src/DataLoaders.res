type t = {
  user: UserDataLoaders.t,
  todo: TodoDataLoaders.t,
  listing: ListingDataLoaders.t,
}

let make = (~edgedbClient) => {
  user: UserDataLoaders.make(),
  todo: TodoDataLoaders.make(),
  listing: ListingDataLoaders.make(~edgedbClient),
}
