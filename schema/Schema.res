// Schema.res - Called `Schema` here, but this can be called anything
@gql.type
type query

/** The current time on the server, as a timestamp. */
@gql.field
let currentTime = (_: query) => {
  Some(Date.now())
}