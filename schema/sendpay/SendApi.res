@val @scope(("process", "env"))
external sendApiUrl: option<string> = "SEND_API_URL"

@val @scope(("process", "env"))
external sendApiVersion: option<string> = "SEND_API_VERSION"

exception MissingSendApiUrl

let sendApiUrl = switch sendApiUrl {
| Some(url) => url
| None => raise(MissingSendApiUrl)
}

let sendApiVersion = sendApiVersion->Option.getOr("v1")

let sendProfileLookupUrl = `${sendApiUrl}/rest/${sendApiVersion}/rpc/profile_lookup`

let sendAnonApiKey = switch Vercel.env {
| Some(Production) => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVncXRvdWxleGh2YWhldnN5c3VxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTMwOTE5MzUsImV4cCI6MjAwODY2NzkzNX0.RL8W-jw2rsDhimYl8KklF2B9bNTPQ-Kj5zZA0XlufUA"
| Some(Preview)
| Some(Development)
| None => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVncXRvdWxleGh2YWhldnN5c3VxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTMwOTE5MzUsImV4cCI6MjAwODY2NzkzNX0.RL8W-jw2rsDhimYl8KklF2B9bNTPQ-Kj5zZA0XlufUA"
}

let sendAnonAuthKey = switch Vercel.env {
| Some(Production) => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwicm9sZSI6ImF1dGhlbnRpY2F0ZWQiLCJzdWIiOiJlNzcwNjA1OS0wMTE3LTQyZmEtOGZjYi1hMGJhYmQxMjRlNzIiLCJpc19hbm9ueW1vdXMiOmZhbHNlLCJpYXQiOjE3MjI0MDgyMDEsImV4cCI6MTcyMzAxMzAwMX0.I6WzY_0QOcUkqnSA2XUwzIDHxpErv1Ooq6G9xmyB5sQ"
| Some(Preview)
| Some(Development)
| None => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwicm9sZSI6ImF1dGhlbnRpY2F0ZWQiLCJzdWIiOiJlNzcwNjA1OS0wMTE3LTQyZmEtOGZjYi1hMGJhYmQxMjRlNzIiLCJpc19hbm9ueW1vdXMiOmZhbHNlLCJpYXQiOjE3MjI5NDI3NjEsImV4cCI6MTcyMzU0NzU2MX0.Eq9MADslgY1WanZ-VGYRb390Dq2WQALUCLPVf_Vw8yM"
}

module SpiceHelpers = {
  let nullableToJson = (encoder, value: Nullable.t<'a>): JSON.t => {
    switch value->Nullable.toOption {
    | Some(x) => encoder(x)
    | None => JSON.Null
    }
  }

  let nullableFromJson = (decoder, json: JSON.t) => {
    switch JSON.Classify.classify(json) {
    | JSON.Classify.Null => Ok(Nullable.null)
    | JSON.Classify.String("__NULL__") => Ok(Nullable.null)
    | _ => Result.map(decoder(json), v => Nullable.make(v))
    }
  }

  let nullable = (nullableToJson, nullableFromJson)
}

module Profile = {
  @spice
  type t = {
    id: @spice.codec(SpiceHelpers.nullable) Nullable.t<string>,
    avatar_url: @spice.codec(SpiceHelpers.nullable) Nullable.t<string>,
    name: @spice.codec(SpiceHelpers.nullable) Nullable.t<string>,
    about: @spice.codec(SpiceHelpers.nullable) Nullable.t<string>,
    refcode: string,
    tag: @spice.codec(SpiceHelpers.nullable) Nullable.t<string>,
    address: @spice.codec(SpiceHelpers.nullable) Nullable.t<string>,
    chain_id: @spice.codec(SpiceHelpers.nullable) Nullable.t<int>,
    is_public: bool,
    sendid: float,
    all_tags: @spice.codec(SpiceHelpers.nullable) Nullable.t<array<string>>,
  }
  @spice
  type data = array<t>
}

type identifier = SendId(float) | Tag(string)
let profileLookup = async identifier => {
  open Fetch
  switch await fetch(
    sendProfileLookupUrl,
    {
      method: #POST,
      headers: Headers.fromArray([
        ("apikey", sendAnonApiKey),
        ("Content-Type", "application/json"),
        ("Authorization", `Bearer ${sendAnonAuthKey}`),
      ]),
      body: switch identifier {
      | SendId(sendid) => {"lookup_type": "sendid", "identifier": sendid->Float.toString}
      | Tag(tag) => {"lookup_type": "tag", "identifier": tag}
      }
      ->JSON.stringifyAny
      ->Option.getOr("")
      ->Body.string,
      credentials: #"same-origin",
    },
  ) {
  | exception _ => Error("FetchError: Something went wrong") //@todo: better error handling
  | res if Response.ok(res) =>
    (await res
    ->Response.json)
    ->Profile.data_decode
    ->Result.mapOr(Error("No profile found"), data =>
      switch data->Array.get(0) {
      | None => Error("No profile found")
      | Some(profile) => Ok(profile)
      }
    )
  | res =>
    Console.error2(`Status: ${res->Response.status->Int.toString}`, res->Response.statusText)
    switch res->Response.status {
    | 400 | 401 => Error(Response.statusText(res))
    | _ => Error("Unhandled error. Check Console for more info")
    }
  }
}
