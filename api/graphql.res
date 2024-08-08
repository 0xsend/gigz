open GraphQLYoga

let edgedbClient = EdgeDB.Client.make()

let viemClient = {
  Viem.PublicClient.make({
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
      sendpayKey: request->Request.headers->Headers.get("x-sendpay-key")->Option.getOr(""),
      dataLoaders: DataLoaders.make(),
      edgedbClient,
      viemClient,
    }
  },
})
