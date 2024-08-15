/* @sourceLoc SingleTodoDisplay.res */
/* @generated */
%%raw("/* @generated */")
module Types = {
  @@warning("-30")

  @live type todoUpdateInput = RelaySchemaAssets_graphql.input_TodoUpdateInput
  @live
  type rec response_todoUpdate_TodoUpdateResultOk_updatedTodo = {
    completed: bool,
  }
  @tag("__typename") and response_todoUpdate = 
    | @live TodoUpdateResultError(
      {
        @live __typename: [ | #TodoUpdateResultError],
        message: string,
      }
    )
    | @live TodoUpdateResultOk(
      {
        @live __typename: [ | #TodoUpdateResultOk],
        updatedTodo: response_todoUpdate_TodoUpdateResultOk_updatedTodo,
      }
    )
    | @live @as("__unselected") UnselectedUnionMember(string)

  @live
  type response = {
    todoUpdate: response_todoUpdate,
  }
  @live
  type rawResponse = response
  @live
  type variables = {
    input: todoUpdateInput,
  }
}

@live
let unwrap_response_todoUpdate: Types.response_todoUpdate => Types.response_todoUpdate = RescriptRelay_Internal.unwrapUnion(_, ["TodoUpdateResultError", "TodoUpdateResultOk"])
@live
let wrap_response_todoUpdate: Types.response_todoUpdate => Types.response_todoUpdate = RescriptRelay_Internal.wrapUnion
module Internal = {
  @live
  let variablesConverter: Js.Dict.t<Js.Dict.t<Js.Dict.t<string>>> = %raw(
    json`{"todoUpdateInput":{},"__root":{"input":{"r":"todoUpdateInput"}}}`
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
    json`{"__root":{"todoUpdate":{"u":"response_todoUpdate"}}}`
  )
  @live
  let wrapResponseConverterMap = {
    "response_todoUpdate": wrap_response_todoUpdate,
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
    json`{"__root":{"todoUpdate":{"u":"response_todoUpdate"}}}`
  )
  @live
  let responseConverterMap = {
    "response_todoUpdate": unwrap_response_todoUpdate,
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
    "defaultValue": null,
    "kind": "LocalArgument",
    "name": "input"
  }
],
v1 = [
  {
    "kind": "Variable",
    "name": "input",
    "variableName": "input"
  }
],
v2 = {
  "alias": null,
  "args": null,
  "kind": "ScalarField",
  "name": "__typename",
  "storageKey": null
},
v3 = {
  "kind": "InlineFragment",
  "selections": [
    {
      "alias": null,
      "args": null,
      "concreteType": "Todo",
      "kind": "LinkedField",
      "name": "updatedTodo",
      "plural": false,
      "selections": [
        {
          "alias": null,
          "args": null,
          "kind": "ScalarField",
          "name": "completed",
          "storageKey": null
        }
      ],
      "storageKey": null
    }
  ],
  "type": "TodoUpdateResultOk",
  "abstractKey": null
},
v4 = {
  "kind": "InlineFragment",
  "selections": [
    {
      "alias": null,
      "args": null,
      "kind": "ScalarField",
      "name": "message",
      "storageKey": null
    }
  ],
  "type": "TodoUpdateResultError",
  "abstractKey": null
};
return {
  "fragment": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Fragment",
    "metadata": null,
    "name": "SingleTodoDisplay_UpdateTodoItemMutation",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "todoUpdate",
        "plural": false,
        "selections": [
          (v2/*: any*/),
          (v3/*: any*/),
          (v4/*: any*/)
        ],
        "storageKey": null
      }
    ],
    "type": "Mutation",
    "abstractKey": null
  },
  "kind": "Request",
  "operation": {
    "argumentDefinitions": (v0/*: any*/),
    "kind": "Operation",
    "name": "SingleTodoDisplay_UpdateTodoItemMutation",
    "selections": [
      {
        "alias": null,
        "args": (v1/*: any*/),
        "concreteType": null,
        "kind": "LinkedField",
        "name": "todoUpdate",
        "plural": false,
        "selections": [
          (v2/*: any*/),
          {
            "kind": "TypeDiscriminator",
            "abstractKey": "__isTodoUpdateResult"
          },
          (v3/*: any*/),
          (v4/*: any*/)
        ],
        "storageKey": null
      }
    ]
  },
  "params": {
    "cacheID": "e3608fe0c3545e53390b15f700030059",
    "id": null,
    "metadata": {},
    "name": "SingleTodoDisplay_UpdateTodoItemMutation",
    "operationKind": "mutation",
    "text": "mutation SingleTodoDisplay_UpdateTodoItemMutation(\n  $input: TodoUpdateInput!\n) {\n  todoUpdate(input: $input) {\n    __typename\n    __isTodoUpdateResult: __typename\n    ... on TodoUpdateResultOk {\n      updatedTodo {\n        completed\n      }\n    }\n    ... on TodoUpdateResultError {\n      message\n    }\n  }\n}\n"
  }
};
})() `)


