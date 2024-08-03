@val @scope(("import", "meta", "env"))
external vercelUrl: string = "VITE_VERCEL_URL"
@val @scope(("import", "meta", "env"))
external vercelProjectProductionUrl: string = "VITE_VERCEL_PROJECT_PRODUCTION_URL"

type vercelEnv =
  | @as("production") Production | @as("development") Development | @as("preview") Preview
@val @scope(("import", "meta", "env"))
external vercelEnv: option<vercelEnv> = "VITE_VERCEL_ENV"

@val @scope(("import", "meta", "env"))
external port: option<string> = "VITE_PORT"
let port = port->Option.getOr("3000")

let url = switch vercelEnv {
| Some(Production) => `https://${vercelProjectProductionUrl}/api/graphql`
| Some(Development) | None => "http://localhost:${port}/api/graphql"
| Some(Preview) => `https://${vercelUrl}/api/graphql`
}

let fetchQuery: RescriptRelay.Network.fetchFunctionPromise = async (
  operation,
  variables,
  _cacheConfig,
  _uploads,
) => {
  open Fetch

  let res = await fetch(
    url,
    {
      method: #POST,
      headers: Headers.fromArray([("content-type", "application/json"), ("x-user-id", "1")]),
      body: Body.string(
        {"query": operation.text, "variables": variables}
        ->JSON.stringifyAny
        ->Option.getOr(""),
      ),
      credentials: #"same-origin",
    },
  )

  if res->Response.ok {
    await res->Response.json
  } else {
    Exn.raiseError("API error.")
  }
}
