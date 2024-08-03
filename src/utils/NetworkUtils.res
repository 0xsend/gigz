@val @scope(("import", "meta", "env"))
external vercelUrl: option<string> = "VITE_VERCEL_URL"

let fetchQuery: RescriptRelay.Network.fetchFunctionPromise = async (
  operation,
  variables,
  _cacheConfig,
  _uploads,
) => {
  open Fetch

  let res = await fetch(
    vercelUrl->Option.mapOr("http://localhost:3000/api/graphql", url =>
      `https://${url}/api/graphql`
    ),
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
