@val @scope(("import", "meta", "env"))
external port: option<string> = "VITE_PORT"
let port = port->Option.getOr("3000")

let url = {
  open Vercel.Vite
  switch env {
  | Some(Production) => `https://${projectProductionUrl}/api/graphql`
  | Some(Development) | None => `http://localhost:${port}/api/graphql`
  | Some(Preview) => `https://${url}/api/graphql`
  }
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
      headers: Headers.fromArray([
        ("content-type", "application/json"),
        ("x-sendpay-key", "sXGTOzTB4_t9pfuq8tAKCj30X3ZlCVmt6lCQStqrgEo"),
      ]),
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
