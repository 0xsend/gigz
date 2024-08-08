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
| Some(Production) => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZqc3dnd2R3ZW9od2VqYnJtaWlsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTMwOTE3MzksImV4cCI6MjAwODY2NzczOX0.dQ6UzwBKeCEKMOaiG1XImzCcV_X_GmKVkYVwEdSZ1fk"
| Some(Preview)
| Some(Development)
| None => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVncXRvdWxleGh2YWhldnN5c3VxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTMwOTE5MzUsImV4cCI6MjAwODY2NzkzNX0.RL8W-jw2rsDhimYl8KklF2B9bNTPQ-Kj5zZA0XlufUA"
}

let sendAnonAuthKey = switch Vercel.env {
| Some(Production) => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwicm9sZSI6ImF1dGhlbnRpY2F0ZWQiLCJzdWIiOiI2ZmVhY2JmMC03NmU2LTQ2NDYtYjYwYy01YzBlZGM5NTI1NDgiLCJpc19hbm9ueW1vdXMiOmZhbHNlLCJpYXQiOjE3MjI5MDQ0OTgsImV4cCI6MTcyMzUwOTI5OH0.DLRpwI1-g9wMVk8jtSrjyx_vC2RjXeFbIN-qHOh7KQw"
| Some(Preview)
| Some(Development)
| None => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwicm9sZSI6ImF1dGhlbnRpY2F0ZWQiLCJzdWIiOiJlNzcwNjA1OS0wMTE3LTQyZmEtOGZjYi1hMGJhYmQxMjRlNzIiLCJpc19hbm9ueW1vdXMiOmZhbHNlLCJpYXQiOjE3MjM1Njc1MDUsImV4cCI6MTcyNDE3MjMwNX0.5jq_5gn9rWqt_eEVLqzF-512RlQBLOwNpZPiF0FCv0I"
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
