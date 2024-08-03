open GraphQLYoga

let default = createYoga({
  graphqlEndpoint: "/api/graphql",
  schema: ResGraphSchema.schema,
  context: async (_): ResGraphContext.context => {
    {}
  },
})

//@TODO: remove when vercel serverless functions are setup
let server = NodeHttpServer.createServer(default)

let port = 4000

server->NodeHttpServer.listen(port, () => {
  Console.info(`Server is running on http://localhost:${port->Int.toString}/graphql`)
})
