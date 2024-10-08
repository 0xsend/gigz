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
      dataLoaders: DataLoaders.make(~edgedbClient),
      edgedbClient,
      viemClient,
    },
     plugins: [
    Envelope.Plugin.ExtendedValidation.use({
      rules: [Envelope.Plugin.ExtendedValidation.Rule.oneOfInputObjectsRule],
    }),
  },
})

if Vercel.env->Option.isNone {
  let yoga = createYoga({
    graphqlEndpoint: "/api/graphql",2
    schema: ResGraphSchema.schema,
    context: async ({request}) => {
      open ResGraphContext
      {
        sendpayKey: request->Request.headers->Headers.get("x-sendpay-key")->Option.getOr(""),
        dataLoaders: DataLoaders.make(~edgedbClient),
        edgedbClient,
        viemClient,
      }
    },
  })
  let server = NodeHttpServer.createServer(yoga)

  server->NodeHttpServer.listen(9000, () => {
    Console.info("Server is running on http://localhost:9000/api/graphql")
  })
}
