/** Get a profile by it's sendid */
@gql.field
let profileBySendId = async (
  _: Schema.query,
  ~ctx: ResGraphContext.context,
  ~sendid: float,
): option<Profile.profile> => {
  switch await ctx.dataLoaders.profile.bySendId->DataLoader.load((ctx.edgedbClient, sendid)) {
  | None => None
  | Some(profile) => Some(profile)
  }
}
