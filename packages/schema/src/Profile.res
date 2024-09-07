let byId = %edgeql(`
    # @name profileById
    with
      id := <uuid>$id
    select Profile{*} filter .id = id limit 1
`)

let bySendId = %edgeql(`
    # @name profileBySendId
    with
      sendid := <int64>$sendid
    select Profile{*} filter .sendid = sendid limit 1
`)

@gql.type
type pills = {
  @gql.field
  usdc: Schema.BigInt.t,
  @gql.field
  eth: Schema.BigInt.t,
  @gql.field
  send: Schema.BigInt.t,
}

@gql.type
type socials = {
  @gql.field
  x: string,
  @gql.field
  telegram: string,
}

/* A profile linked to a send account */
@gql.type
type profile = {
  ...NodeInterface.node,
  @gql.field
  categories: array<Schema.Category.category>,
  @gql.field
  createdAt: float,
  @gql.field
  sendid: float,
  @gql.field
  bio?: string,
  @gql.field
  hearts?: float,
  @gql.field
  pills: pills,
  @gql.field
  portfolioLink?: string,
  @gql.field
  socials: socials,
}

let castOneToResgraph = (profile: Profile__edgeql.ProfileById.response): profile => {
  {
    id: profile.id,
    categories: profile.categories->Null.mapOr([], category =>
      category->Array.map(category => category->Schema.Category.castFromDb)
    ),
    createdAt: profile.created_at->Date.getTime,
    sendid: profile.sendid,
    bio: ?profile.bio->Null.toOption,
    hearts: ?profile.hearts->Null.toOption,
    pills: {
      usdc: profile.pills.usdc,
      eth: profile.pills.eth,
      send: profile.pills.send,
    },
    portfolioLink: ?profile.portfolio_link->Null.toOption,
    socials: {
      x: profile.socials.x,
      telegram: profile.socials.telegram,
    },
  }
}
