/* @sourceLoc LayoutDisplay.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  @tag("__typename") type response_consumeSendpaySession = 
    | @live ConsumeSessionResultError(
      {
        @live __typename: [ | #ConsumeSessionResultError],
        name: string,
        reason: option<string>,
      }
    )
    | @live ConsumeSessionResultOk(
      {
        @live __typename: [ | #ConsumeSessionResultOk],
        about: option<string>,
        address: string,
        avatar_url: option<string>,
        chainId: option<int>,
        refcode: option<string>,
        sendId: float,
        sendtag: option<string>,
      }
    )
    | @live @as("__unselected") UnselectedUnionMember(string)

  @live
  type response = {
    consumeSendpaySession: response_consumeSendpaySession,
  }
  @live
  type rawResponse = response
  @live
  type variables = unit
}

@live
let unwrap_response_consumeSendpaySession: Types.response_consumeSendpaySession => Types.response_consumeSendpaySession = RescriptRelay_Internal.unwrapUnion(_, ["ConsumeSessionResultError", "ConsumeSessionResultOk"])
@live
let wrap_response_consumeSendpaySession: Types.response_consumeSendpaySession => Types.response_consumeSendpaySession = RescriptRelay_Internal.wrapUnion
module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{}`
  )
  @live
  let variablesConverterMap = ()
  @live
  let convertVariables = v => v->RescriptRelay.convertObj(
    variablesConverter,
    variablesConverterMap,
    Js.undefined
  )
  @live
  type wrapResponseRaw
  @live
  let wrapResponseConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"__root":{"consumeSendpaySession":{"u":"response_consumeSendpaySession"}}}`
  )
  @live
  let wrapResponseConverterMap = {
    "response_consumeSendpaySession": wrap_response_consumeSendpaySession,
  }
  @live
  let convertWrapResponse = v => v->RescriptRelay.convertObj(
    wrapResponseConverter,
    wrapResponseConverterMap,
    Js.null
  )
  @live
  type responseRaw
  @live
  let responseConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"__root":{"consumeSendpaySession":{"u":"response_consumeSendpaySession"}}}`
  )
  @live
  let responseConverterMap = {
    "response_consumeSendpaySession": unwrap_response_consumeSendpaySession,
  }
  @live
  let convertResponse = v => v->RescriptRelay.convertObj(
    responseConverter,
    responseConverterMap,
    Js.undefined
  )
  type wrapRawResponseRaw = wrapResponseRaw
  @live
  let convertWrapRawResponse = convertWrapResponse
  type rawResponseRaw = responseRaw
  @live
  let convertRawResponse = convertResponse
}
module Utils = {
  @@warning("-33")
  open Types
}

type relayOperationNode
type operationType = RescriptRelay.mutationNode<relayOperationNode>


let node: operationType = %raw(json` (function(){
var v0 = [
  {
    "alias": null,
    "args": null,
    "concreteType": null,
    "kind": "LinkedField",
    "name": "consumeSendpaySession",
    "plural": false,
    "selections": [
      {
        "alias": null,
        "args": null,
        "kind": "ScalarField",
        "name": "__typename",
        "storageKey": null
      },
      {
        "kind": "InlineFragment",
        "selections": [
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "sendId",
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "address",
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "sendtag",
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "avatar_url",
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "about",
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "refcode",
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "chainId",
            "storageKey": null
          }
        ],
        "type": "ConsumeSessionResultOk",
        "abstractKey": null
      },
      {
        "kind": "InlineFragment",
        "selections": [
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "name",
            "storageKey": null
          },
          {
            "alias": null,
            "args": null,
            "kind": "ScalarField",
            "name": "reason",
            "storageKey": null
          }
        ],
        "type": "ConsumeSessionResultError",
        "abstractKey": null
      }
    ],
    "storageKey": null
  }
];
return {
  "fragment": {
    "argumentDefinitions": [],
    "kind": "Fragment",
    "metadata": null,
    "name": "LayoutDisplayConsumeSessionMutation",
    "selections": (v0/*: any*/),
    "type": "Mutation",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": [],
    "kind": "Operation",
    "name": "LayoutDisplayConsumeSessionMutation",
    "selections": (v0/*: any*/)
  },
  "params": {
    "cacheID": "03ff4a1dfe1f1a80b23f7918dbafc01a",
    "id": null,
    "metadata": {},
    "name": "LayoutDisplayConsumeSessionMutation",
    "operationKind": "mutation",
    "text": "mutation LayoutDisplayConsumeSessionMutation {\n  consumeSendpaySession {\n    __typename\n    ... on ConsumeSessionResultOk {\n      sendId\n      address\n      sendtag\n      avatar_url\n      about\n      refcode\n      chainId\n    }\n    ... on ConsumeSessionResultError {\n      name\n      reason\n    }\n  }\n}\n"
  }
};
})() `)


