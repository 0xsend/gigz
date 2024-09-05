type t = {
  user: UserDataLoaders.t,
  todo: TodoDataLoaders.t,
  listing: ListingDataLoaders.t,
  profile: ProfileDataLoaders.t,
}

let make = () => {
  user: UserDataLoaders.make(),
  todo: TodoDataLoaders.make(),
  listing: ListingDataLoaders.make(),
  profile: ProfileDataLoaders.make(),
}
