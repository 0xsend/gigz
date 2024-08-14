/* @sourceLoc LayoutDisplay.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  @live type makeSessionInput = RelaySchemaAssets_graphql.input_MakeSessionInput
  @live type makeSessionInputBySendId = RelaySchemaAssets_graphql.input_MakeSessionInputBySendId
  @live type makeSessionInputByTag = RelaySchemaAssets_graphql.input_MakeSessionInputByTag
  @tag("__typename") type response_makeSendpaySession = 
    | @live MakeSessionResultError(
      {
        @live __typename: [ | #MakeSessionResultError],
        name: string,
        reason: string,
      }
    )
    | @live MakeSessionResultOk(
      {
        @live __typename: [ | #MakeSessionResultOk],
        @live id: string,
      }
    )
    | @live @as("__unselected") UnselectedUnionMember(string)

  @live
  type response = {
    makeSendpaySession: response_makeSendpaySession,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    input: makeSessionInput,
  }
}

@live
let unwrap_response_makeSendpaySession: Types.response_makeSendpaySession => Types.response_makeSendpaySession = RescriptRelay_Internal.unwrapUnion(_, ["MakeSessionResultError", "MakeSessionResultOk"])
@live
let wrap_response_makeSendpaySession: Types.response_makeSendpaySession => Types.response_makeSendpaySession = RescriptRelay_Internal.wrapUnion
module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"makeSessionInput":{"byTag":{"r":"makeSessionInputByTag"},"bySendId":{"r":"makeSessionInputBySendId"}},"makeSessionInputBySendId":{"confirmationAmount":{"c":"Schema.BigInt"}},"makeSessionInputByTag":{"confirmationAmount":{"c":"Schema.BigInt"}},"__root":{"input":{"r":"makeSessionInput"}}}`
  )
  @live
  let variablesConverterMap = {
    "Schema.BigInt": Schema.BigInt.serialize,
  }
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
    json`{"__root":{"makeSendpaySession":{"u":"response_makeSendpaySession"}}}`
  )
  @live
  let wrapResponseConverterMap = {
    "response_makeSendpaySession": wrap_response_makeSendpaySession,
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
    json`{"__root":{"makeSendpaySession":{"u":"response_makeSendpaySession"}}}`
  )
  @live
  let responseConverterMap = {
    "response_makeSendpaySession": unwrap_response_makeSendpaySession,
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
  @live
  external chain_toString: RelaySchemaAssets_graphql.enum_Chain => string = "%identity"
  @live
  external chain_input_toString: RelaySchemaAssets_graphql.enum_Chain_input => string = "%identity"
  @live
  let chain_decode = (enum: RelaySchemaAssets_graphql.enum_Chain): option<RelaySchemaAssets_graphql.enum_Chain_input> => {
    switch enum {
      | FutureAddedValue(_) => None
      | valid => Some(Obj.magic(valid))
    }
  }
  @live
  let chain_fromString = (str: string): option<RelaySchemaAssets_graphql.enum_Chain_input> => {
    chain_decode(Obj.magic(str))
  }
}

type relayOperationNode
type operationType = RescriptRelay.mutationNode<relayOperationNode>


let node: operationType = %raw(json` (function(){
var v0 = [
  {
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "input"
  }
],
v1 = [
  {
    "alias": null,
    "args": [
      {
        "kind": "Variable",
        "name": "input",
        "variableName": "input"
      }
    ],
    "concreteType": null,
    "kind": "LinkedField",
    "name": "makeSendpaySession",
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
            "name": "id",
            "storageKey": null
          }
        ],
        "type": "MakeSessionResultOk",
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
        "type": "MakeSessionResultError",
        "abstractKey": null
      }
    ],
    "storageKey": null
  }
];
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "LayoutDisplayMakeSendpaySessionMutation",
    "selections": (v1/*: any*/),
    "type": "Mutation",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "LayoutDisplayMakeSendpaySessionMutation",
    "selections": (v1/*: any*/)
  },
  "params": {
    "cacheID": "21b1405a28fe779019d0516e7ea32af0",
    "id": null,
    "metadata": {},
    "name": "LayoutDisplayMakeSendpaySessionMutation",
    "operationKind": "mutation",
    "text": "mutation LayoutDisplayMakeSendpaySessionMutation(\n  $input: MakeSessionInput!\n) {\n  makeSendpaySession(input: $input) {\n    __typename\n    ... on MakeSessionResultOk {\n      id\n    }\n    ... on MakeSessionResultError {\n      name\n      reason\n    }\n  }\n}\n"
  }
};
})() `)


