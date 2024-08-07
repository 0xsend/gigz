module Window = {
  type t = Dom.window
  type windowFeatures = | @as("popup,height=800px,width=800px") Popup
  @send
  external open_: (t, ~url: string=?, ~target: string=?, ~features: windowFeatures=?) => unit =
    "open"
}

module MakeSendpaySessionMutation = %relay(`
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
`)

module ConsumeSessionMutation = %relay(`
  mutation LayoutDisplayConsumeSessionMutation {
    consumeSendpaySession {
      ... on ConsumeSessionResultOk {
        sendId
        address
        sendtag
        avatar_url
        about
        refcode
        chainId
      }
      ... on ConsumeSessionResultError {
        name
        reason
      }
    }
  }
`)

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

let chain: SendPay.Chain.chain = switch Vercel.Vite.env {
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
  open SendPay.Chain
  switch chain {
  | Mainnet => "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
  | Base => "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
  | BaseSepolia => "0x036CbD53842c5426634e7929541eC2318f3dCF7e"
  }
}

type identifier = SendId(option<float>) | Tag(option<string>)
type sendpayState = SignIn | Proceed | Login
type user = {
  sendId: float,
  address: string,
  sendtag: option<string>,
  avatar_url: option<string>,
  about: option<string>,
  refcode: option<string>,
}
@react.component
let make = () => {
  let (identifier, setIdentifier) = React.useState(_ => Tag(None))
  let (makeSession, isMakingSession) = MakeSendpaySessionMutation.use()
  let (consumeSession, isConsumingSession) = ConsumeSessionMutation.use()
  let (sendpayState, setSendpayState) = React.useState(_ => SignIn)
  let (error, setError) = React.useState(_ => None)
  let (user, setUser) = React.useState(_ => None)
  let makeSendpaySession = () => {
    switch identifier {
    | SendId(Some(sendid)) =>
      makeSession(
        ~variables={
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
        },
        ~onCompleted={
          (_, _) => {
            window->Window.open_(
              ~url=`${sendAppUrl}/send/confirm?idType=tag&recipient=${recipient}&amount=0.01&sendToken=${usdcAddress(
                  chain,
                )}`,
              ~target="OpenSendWindow",
              ~features=Popup,
            )
            setSendpayState(_ => Login)
          }
        },
      )->RescriptRelay.Disposable.ignore
    | Tag(Some(tag)) =>
      makeSession(
        ~variables={
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
        },
        ~onCompleted={
          (_, _) => {
            window->Window.open_(
              ~url=`${sendAppUrl}/send/confirm?idType=tag&recipient=${recipient}&amount=0.01&sendToken=${usdcAddress(
                  chain,
                )}`,
              ~target="OpenSendWindow",
              ~features=Popup,
            )
            setSendpayState(_ => Login)
          }
        },
      )->RescriptRelay.Disposable.ignore
    | _ => ()
    }
  }

  let consumeSendpaySession = () => {
    consumeSession(~variables=(), ~onCompleted=({consumeSendpaySession}, mutationErrors) =>
      switch consumeSendpaySession {
      | ConsumeSessionResultOk({sendId, address, about, sendtag, avatar_url, refcode}) =>
        setUser(_ => Some({sendId, address, about, sendtag, avatar_url, refcode}))
      | ConsumeSessionResultError(consumeSessionResultError) =>
        setError(_ => consumeSessionResultError.name->Some)
        Console.log(consumeSessionResultError.name)
      | UnselectedUnionMember(_) => ()
      }
    )->RescriptRelay.Disposable.ignore
  }

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
        {switch (sendpayState, user) {
        | (_, Some(user)) =>
          <>
            <div className="flex flex-1 flex-col w-full justify-center items-center my-auto">
              <img src={user.avatar_url->Option.getOr("")} className="w-24 h-24 rounded-full" />
              <p> {React.string(`Logged in as /${user.sendtag->Option.getOr("No Sendtag")}`)} </p>
            </div>
          </>
        | (SignIn, None) =>
          <>
            <div className="flex flex-1 w-full justify-center items-center my-auto">
              <input
                placeholder="Enter Sendtag"
                onChange={event => {
                  setIdentifier(_ => Tag(ReactEvent.Form.target(event)["value"]->Some))
                }}
                className="border w-full  border-color0  hover:border-color11 focus:border-color11 focus:ring-0 rounded-md p-2 flex items-center"
              />
            </div>
            <button
              className="bg-color11 rounded-md py-3 px-4 flex items-center space-x-3 disabled:opacity-50 "
              disabled={isMakingSession}
              onClick={_ => {
                setSendpayState(_ => Proceed)
              }}>
              <div className="w-4 h-4">
                <IconSendLogo />
              </div>
              <p className="text-color0"> {React.string("Sign In")} </p>
            </button>
          </>
        | (Proceed, None) =>
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
              onClick={_ => makeSendpaySession()}>
              <p className="text-color0"> {React.string("Proceed")} </p>
            </button>
          </>
        | (Login, None) =>
          <>
            <div className="flex flex-1 w-full justify-center items-center my-auto">
              <p> {React.string("Login after confirming the transaction")} </p>
            </div>
            {switch error {
            | Some(error) => <p className="text-red-500 text-sm"> {React.string(error)} </p>
            | None => React.null
            }}
            <button
              className="bg-color11 rounded-md py-3 px-4 flex items-center space-x-3"
              onClick={_ => consumeSendpaySession()}
              disabled={isConsumingSession}>
              <div className="w-4 h-4">
                <IconSendLogo />
              </div>
              <p className="text-color0"> {React.string("Login")} </p>
            </button>
          </>
        }}
      </div>
    </div>
  </div>
}
