open GraphQLYoga

let edgedbClient = EdgeDB.Client.make()

let viemClient = {
  Viem.PublicClient.make({
    //@todo: probably need barg node here
    chain: Constants.chain,
    transport: Viem.Transport.http(Constants.transportUrl),
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
