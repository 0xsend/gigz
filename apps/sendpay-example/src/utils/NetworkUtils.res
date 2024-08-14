@val @scope(("import", "meta", "env"))
external port: option<string> = "VITE_PORT"
let port = port->Option.getOr("9000")

let url = {
  open Vercel.Vite
  switch env {
  | Some(Production) => `https://${projectProductionUrl}/api/graphql`
  | Some(Development) => `http://localhost:3000/api/graphql`
  | None => `http://localhost:${port}/api/graphql`
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

  let sendpayKey = Dom.Storage2.localStorage->Dom.Storage2.getItem("sendpay_sendpayKey")
  let res = await fetch(
    url,
    {
      method: #POST,
      headers: Headers.fromArray([
        ("content-type", "application/json"),
        ("x-sendpay-key", sendpayKey->Option.getOr("")),
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
