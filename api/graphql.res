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
