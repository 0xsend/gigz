open GraphQLYoga

let edgedbClient = EdgeDB.Client.make()

let viemClient = {
  let chain = switch Vercel.env {
  | Some(Production) => Viem.Chain.base
  | Some(Preview) => Viem.Chain.baseSepolia
    | Some(Development) | None => Viem.Chain.baseSepolia
  }
  Viem.PublicClient.make({
    chain,
    transport: Viem.Transport.http(),
  })
}

let default = createYoga({
  graphqlEndpoint: "/api/graphql",
  schema: ResGraphSchema.schema,
  context: async ({request}) => {
    open ResGraphContext
    {
      currentUserId: request->Request.headers->Headers.get("x-user-id"),
      sendpayKey: "sXGTOzTB4_t9pfuq8tAKCj30X3ZlCVmt6lCQStqrgEo",
      dataLoaders: DataLoaders.make(),
      edgedbClient,
      viemClient,
    }
  },
})
