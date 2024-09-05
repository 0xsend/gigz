type t = {
  byId: DataLoader.t<(EdgeDB.Client.t, string), option<Profile.profile>>,
  bySendId: DataLoader.t<(EdgeDB.Client.t, float), option<Profile.profile>>,
}

let make = () => {
  byId: DataLoader.makeSingle(async ((edgedbClient, id)) => {
    (await Profile.byId(edgedbClient, {id: id}, ~onError=Console.error))->Option.map(
      Profile.castOneToResgraph,
    )
  }),
  bySendId: DataLoader.makeSingle(async ((edgedbClient, sendid)) => {
    (
      await Profile.bySendId(edgedbClient, {sendid: sendid}, ~onError=Console.error)
    )->Option.map(profile =>
      (profile :> Profile__edgeql.ProfileById.response)->Profile.castOneToResgraph
    )
  }),
}
