let query = %edgeql(`
  # @name consumeSession
  with session :=(delete Session
  filter .key = <str>$key
  limit 1) select session {*} limit 1;`)

@gql.union
type consumeSessionResult =
  | Ok({
      sendId: float,
      address: string,
      sendtag: option<string>,
      avatar_url: option<string>,
      about: option<string>,
      refcode: option<string>,
      chainId: option<int>,
    })
  | Error({name: string, reason?: string})
