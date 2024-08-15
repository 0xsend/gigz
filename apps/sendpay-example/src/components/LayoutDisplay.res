open Types

// Patch BigInt for react query
%%raw(`
BigInt.prototype['toJSON'] = function () {
  return this.toString()
}
`)

@val @scope(("import", "meta", "env"))
external port: option<string> = "VITE_PORT"
let port = port->Option.getOr("9000")

module DeviceDetect = {
  @module("react-device-detect") @val external isMobile: bool = "isMobile"
}

module Window = {
  type t = Dom.window
  type windowFeatures = | @as("popup,height=800px,width=800px") Popup
  @send
  external open_: (t, ~url: string=?, ~target: string=?, ~features: windowFeatures=?) => unit =
    "open"
}

let confirmationAddress = switch Vercel.Vite.env {
| Some(Production) => "0x7CE90eF0f63c786C627576cFFa6d942fB55Ae385"
| Some(Preview)
| Some(Development)
| None => "0xe3eed8fCfBf3C5dE658339Cb2fb4829C4118893c"
}

let recipient = switch Vercel.Vite.env {
| Some(Production) => "sendpay"
| Some(Preview)
| Some(Development)
| None => "gigzdev"
}

let chain = switch Vercel.Vite.env {
| Some(Production) => Base
| Some(Preview) | Some(Development) | None => BaseSepolia
}

let sendAppUrl = switch Vercel.Vite.env {
| Some(Production) => "https://send.app"
| Some(Preview)
| Some(Development)
| None => "https://dev.send.app"
}

let usdcAddress = chain => {
  switch chain {
  | Mainnet => "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
  | Base => "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
  | BaseSepolia => "0x036CbD53842c5426634e7929541eC2318f3dCF7e"
  }
}

type identifier = SendId(option<float>) | Tag(option<string>)
type user = {
  sendId: float,
  address: string,
  sendtag: option<string>,
  avatar_url: option<string>,
  about: option<string>,
  refcode: option<string>,
}

let graphqlUrl = {
  open Vercel.Vite
  switch env {
  | Some(Production) => `https://${projectProductionUrl}/api/graphql`
  | Some(Development) => `http://localhost:3000/api/graphql`
  | None => `http://localhost:${port}/api/graphql`
  | Some(Preview) => `https://${url}/api/graphql`
  }
}

let makeSendPaySessionQuery = `
 mutation LayoutDisplayMakeSendpaySessionMutation($input: MakeSessionInput!) {
    makeSendpaySession(input: $input) {
      ... on MakeSessionResultOk {
        id
      }
      ... on MakeSessionResultError {
        name
        reason
      }
    }
  }
    `

let consumeSendpaySessionQuery = `
 mutation LayoutDisplayConsumeSendpaySessionMutation {
    consumeSendpaySession {
      ... on ConsumeSessionResultOk {
        sendId
        address
        about
        sendtag
        avatar_url
        refcode
      }
      ... on ConsumeSessionResultError {
        name
        reason
      }
    }
  }
  `

type makeSendPaySessionVariables = {input: input_MakeSessionInput}

let makeSendpaySessionMutation = async (~variables) => {
  open Fetch
  let res = await fetch(
    graphqlUrl,
    {
      method: #POST,
      headers: Headers.fromArray([
        ("content-type", "application/json"),
        (
          "x-sendpay-key",
          Dom.Storage2.localStorage->Dom.Storage2.getItem("sendpay_sendpayKey")->Option.getOr(""),
        ),
      ]),
      body: Body.string(
        {"query": makeSendPaySessionQuery, "variables": variables}
        ->JSON.stringifyAny
        ->Option.getOr(""),
      ),
      credentials: #"same-origin",
    },
  )
  let json = await res->Response.json
}

let consumeSendpaySessionMutation = async () => {
  open Fetch
  await fetch(
    graphqlUrl,
    {
      method: #POST,
      headers: Headers.fromArray([
        ("content-type", "application/json"),
        (
          "x-sendpay-key",
          Dom.Storage2.localStorage->Dom.Storage2.getItem("sendpay_sendpayKey")->Option.getOr(""),
        ),
      ]),
      body: Body.string(
        {"query": consumeSendpaySessionQuery, "variables": ()}
        ->JSON.stringifyAny
        ->Option.getOr(""),
      ),
      credentials: #"same-origin",
    },
  )
}

@react.component
let make = () => {
  let (identifier, setIdentifier) = React.useState(_ => Tag(None))
  let (sendpayId, setSendpayId) = React.useState(_ => None)

  let (error, setError) = React.useState(_ => None)
  let (user, setUser) = React.useState(_ => None)

  let makeSendpaySessionVariables = identifier =>
    switch identifier {
    | SendId(Some(sendid)) => {
        input: {
          bySendId: {
            sendid,
            confirmationAddress,
            confirmationAmount: Viem.parseUnits("0.01", 6)->Option.getUnsafe,
            chain: switch Vercel.Vite.env {
            | Some(Production) => Base
            | Some(Preview) | Some(Development) | None => BaseSepolia
            },
          },
        },
      }
    | Tag(Some(tag)) => {
        input: {
          byTag: {
            tag,
            confirmationAddress,
            confirmationAmount: Viem.parseUnits("0.01", 6)->Option.getUnsafe,
            chain: switch Vercel.Vite.env {
            | Some(Production) => Base
            | Some(Preview) | Some(Development) | None => BaseSepolia
            },
          },
        },
      }
    | Tag(None) | SendId(None) => panic("Invalid identifier")
    }

  let {mutate: makeSendPaySession} = ReactQuery.useMutation({
    mutationKey: ["makeSendPaySession"],
    mutationFn: _ => makeSendpaySessionMutation(~variables=makeSendpaySessionVariables(identifier)),
    onError: async (error, _, _) => {
      Console.log(error)
    },
    onSuccess: async (makeSendpaySession, _, _) => {
      Console.log(makeSendpaySession)
      window->Window.open_(
        ~url=`${sendAppUrl}/send/confirm?idType=tag&recipient=${recipient}&amount=0.01&sendToken=${usdcAddress(
            chain,
          )}`,
        ~target="_blank",
        ~features=?switch DeviceDetect.isMobile {
        | false => Some(Popup)
        | true => None
        },
      )
    },
  })

  let {mutate: consumeSendPaySession} = ReactQuery.useMutation({
    mutationKey: ["consumeSendPaySession"],
    mutationFn: () => consumeSendpaySessionMutation(),
    onSuccess: async (consumeSendpaySession, _, _) => {
      Console.log(consumeSendpaySession)
      // switch consumeSendpaySession {
      // | ConsumeSessionResultOk({sendId, address, about, sendtag, avatar_url, refcode}) =>
      //   setUser(_ => Some({sendId, address, about, sendtag, avatar_url, refcode}))
      //   setSendpayId(_ => None)
      // | ConsumeSessionResultError(consumeSessionResultError) =>
      //   setError(_ => consumeSessionResultError.name->Some)
      //   setSendpayId(_ => None)
      //   Console.log(consumeSessionResultError.name)
      // }
    },
  })

  let formattedIdentifier = switch identifier {
  | SendId(Some(sendid)) => sendid->Float.toString
  | Tag(Some(tag)) => tag
  | _ => ""
  }
  <div className="h-full flex flex-col justify-center items-center">
    <div
      className="flex flex-col items-center p-6 bg-color12 text-center rounded-lg w-full md:w-1/2 max-w-[400px] min-h-[300px]">
      <h3 className="text-4xl font-semibold text-color1"> {React.string("Login with /send")} </h3>
      <div className="flex flex-col items-center gap-2 flex-1 w-full py-2">
        {switch (identifier, user, sendpayId) {
        | (_, Some(user), _) =>
          <>
            <div className="flex flex-1 flex-col w-full justify-center items-center my-auto">
              <img src={user.avatar_url->Option.getOr("")} className="w-24 h-24 rounded-full" />
              <p> {React.string(`Logged in as /${user.sendtag->Option.getOr("No Sendtag")}`)} </p>
            </div>
          </>
        | (SendId(None), None, None) | (Tag(None), None, None) =>
          <>
            <form
              className="flex flex-col flex-1 w-full justify-center items-center my-auto"
              onSubmit={event => {
                event->ReactEvent.Form.preventDefault
                setIdentifier(_ => Tag(ReactEvent.Form.target(event)["0"]["value"]))
              }}>
              <div className="flex flex-1 w-full justify-center items-center my-auto">
                <input
                  name="value"
                  placeholder="Enter Sendtag"
                  className="border w-full  border-color0  hover:border-color11 focus:border-color11 focus:ring-0 rounded-md p-2 flex items-center"
                />
              </div>
              <button
                className="bg-color11 rounded-md py-3 px-4 flex items-center space-x-3 disabled:opacity-50 "
                type_="submit">
                <div className="w-4 h-4">
                  <IconSendLogo />
                </div>
                <p className="text-color0"> {React.string("Sign In")} </p>
              </button>
            </form>
          </>
        | (SendId(Some(_)), None, None) | (Tag(Some(_)), None, None) =>
          <>
            <div className="flex flex-1 w-full justify-center items-center my-auto">
              <p> {React.string(`Send .01 USDC from sendtag /${formattedIdentifier} to login`)} </p>
            </div>
            {switch error {
            | Some(error) => <p className="text-red-500 text-sm"> {React.string(error)} </p>
            | None => React.null
            }}
            <button
              className="bg-color11 rounded-md py-3 px-4 flex items-center space-x-3 "
              onClick={_ => makeSendPaySession((), None)}>
              <p className="text-color0"> {React.string("Proceed")} </p>
            </button>
          </>
        | (_, _, Some(_)) =>
          <div
            className="flex flex-col flex-1 w-full justify-center items-center my-auto text-center">
            {switch error {
            | Some(error) => <p className="text-red-500 text-sm"> {React.string(error)} </p>
            | None => React.null
            }}
            <button
              className="bg-color11 rounded-md py-3 px-4 flex items-center space-x-3"
              onClick={_ => consumeSendPaySession((), None)}>
              <div className="w-4 h-4">
                <IconSendLogo />
              </div>
              <p className="text-color0"> {React.string("Login")} </p>
            </button>
          </div>
        }}
      </div>
    </div>
  </div>
}
