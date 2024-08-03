open GraphQLYoga

let default = createYoga({
  graphqlEndpoint: "/api/graphql",
  schema: ResGraphSchema.schema,
  context: async ({request}) => {
    open ResGraphContext
    {
      currentUserId: request->Request.headers->Headers.get("x-user-id"),
      dataLoaders: DataLoaders.make(),
    }
  },
})

//@TODO: remove when vercel serverless functions are setup
let server = NodeHttpServer.createServer(default)

let port = 4000

server->NodeHttpServer.listen(port, () => {
  Console.info(`Server is running on http://localhost:${port->Int.toString}/api/graphql`)
})
