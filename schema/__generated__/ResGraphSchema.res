@@warning("-27-32")

open ResGraph__GraphQLJs

let typeUnwrapper: 'src => 'return = %raw(`function typeUnwrapper(src) { if (src == null) return null; if (typeof src === 'object' && src.hasOwnProperty('_0')) return src['_0']; return src;}`)
let inputUnionUnwrapper: (
  'src,
  array<string>,
) => 'return = %raw(`function inputUnionUnwrapper(src, inlineRecordTypenames) {
      if (src == null) return null;
    
      let targetKey = null;
      let targetValue = null;
    
      Object.entries(src).forEach(([key, value]) => {
        if (value != null) {
          targetKey = key;
          targetValue = value;
        }
      });
    
      if (targetKey != null && targetValue != null) {
        let tagName = targetKey.slice(0, 1).toUpperCase() + targetKey.slice(1);
    
        if (inlineRecordTypenames.includes(tagName)) {
          return Object.assign({ TAG: tagName }, targetValue);
        }
    
        return {
          TAG: tagName,
          _0: targetValue,
        };
      }
    
      return null;
    }
    `)
type inputObjectFieldConverterFn
external makeInputObjectFieldConverterFn: ('a => 'b) => inputObjectFieldConverterFn = "%identity"

let applyConversionToInputObject: (
  'a,
  array<(string, inputObjectFieldConverterFn)>,
) => 'a = %raw(`function applyConversionToInputObject(obj, instructions) {
      if (instructions.length === 0) return obj;
      let newObj = Object.assign({}, obj);
      instructions.forEach(instruction => {
        let value = newObj[instruction[0]];
         newObj[instruction[0]] = instruction[1](value);
      })
      return newObj;
    }`)

let scalar_BigInt = GraphQLScalar.make({
  let config: GraphQLScalar.config<Schema.BigInt.t> = {
    name: "BigInt",
    description: "A bigint.",
    parseValue: Schema.BigInt.parseValue,
    serialize: Schema.BigInt.serialize,
  }
  config
})
let enum_Chain = GraphQLEnumType.make({
  name: "Chain",
  description: ?None,
  values: {
    "Mainnet": {GraphQLEnumType.value: "Mainnet", description: ?None, deprecationReason: ?None},
    "Base": {GraphQLEnumType.value: "Base", description: ?None, deprecationReason: ?None},
    "BaseSepolia": {
      GraphQLEnumType.value: "BaseSepolia",
      description: ?None,
      deprecationReason: ?None,
    },
  }->makeEnumValues,
})
let enum_ChainId = GraphQLEnumType.make({
  name: "ChainId",
  description: ?None,
  values: {
    "Mainnet": {GraphQLEnumType.value: "Mainnet", description: ?None, deprecationReason: ?None},
    "Base": {GraphQLEnumType.value: "Base", description: ?None, deprecationReason: ?None},
    "BaseSepolia": {
      GraphQLEnumType.value: "BaseSepolia",
      description: ?None,
      deprecationReason: ?None,
    },
  }->makeEnumValues,
})
let enum_LookupType = GraphQLEnumType.make({
  name: "LookupType",
  description: ?None,
  values: {
    "tag": {GraphQLEnumType.value: "tag", description: ?None, deprecationReason: ?None},
    "sendid": {GraphQLEnumType.value: "sendid", description: ?None, deprecationReason: ?None},
  }->makeEnumValues,
})
let i_Node: ref<GraphQLInterfaceType.t> = Obj.magic({"contents": Js.null})
let get_Node = () => i_Node.contents
let t_ResultError: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_ResultError = () => t_ResultError.contents
let t_ResultOk: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_ResultOk = () => t_ResultOk.contents
let t_TodoAddResultError: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoAddResultError = () => t_TodoAddResultError.contents
let t_TodoAddResultOk: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoAddResultOk = () => t_TodoAddResultOk.contents
let t_TodoDeleteResultError: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoDeleteResultError = () => t_TodoDeleteResultError.contents
let t_TodoDeleteResultOk: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoDeleteResultOk = () => t_TodoDeleteResultOk.contents
let t_TodoUpdateResultError: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoUpdateResultError = () => t_TodoUpdateResultError.contents
let t_TodoUpdateResultOk: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoUpdateResultOk = () => t_TodoUpdateResultOk.contents
let t_VerifySessionResultError: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_VerifySessionResultError = () => t_VerifySessionResultError.contents
let t_VerifySessionResultOk: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_VerifySessionResultOk = () => t_VerifySessionResultOk.contents
let t_Mutation: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Mutation = () => t_Mutation.contents
let t_PageInfo: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_PageInfo = () => t_PageInfo.contents
let t_Query: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Query = () => t_Query.contents
let t_Todo: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Todo = () => t_Todo.contents
let t_TodoConnection: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoConnection = () => t_TodoConnection.contents
let t_TodoEdge: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoEdge = () => t_TodoEdge.contents
let t_User: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_User = () => t_User.contents
let input_Input: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_Input = () => input_Input.contents
let input_Input_conversionInstructions = []
let input_TodoAddInput: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoAddInput = () => input_TodoAddInput.contents
let input_TodoAddInput_conversionInstructions = []
let input_TodoUpdateInput: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoUpdateInput = () => input_TodoUpdateInput.contents
let input_TodoUpdateInput_conversionInstructions = []
input_Input_conversionInstructions->Array.pushMany([
  ("chainId", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
])
input_TodoAddInput_conversionInstructions->Array.pushMany([])
input_TodoUpdateInput_conversionInstructions->Array.pushMany([
  ("completed", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
  ("text", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
])
let union_Result: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_Result = () => union_Result.contents
let union_TodoAddResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_TodoAddResult = () => union_TodoAddResult.contents
let union_TodoDeleteResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_TodoDeleteResult = () => union_TodoDeleteResult.contents
let union_TodoUpdateResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_TodoUpdateResult = () => union_TodoUpdateResult.contents
let union_VerifySessionResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_VerifySessionResult = () => union_VerifySessionResult.contents

let union_Result_resolveType = (v: SendPay.MakeSession.result) =>
  switch v {
  | Ok(_) => "ResultOk"
  | Error(_) => "ResultError"
  }

let union_TodoAddResult_resolveType = (v: TodoMutations.todoAddResult) =>
  switch v {
  | Ok(_) => "TodoAddResultOk"
  | Error(_) => "TodoAddResultError"
  }

let union_TodoDeleteResult_resolveType = (v: TodoMutations.todoDeleteResult) =>
  switch v {
  | Ok(_) => "TodoDeleteResultOk"
  | Error(_) => "TodoDeleteResultError"
  }

let union_TodoUpdateResult_resolveType = (v: TodoMutations.todoUpdateResult) =>
  switch v {
  | Ok(_) => "TodoUpdateResultOk"
  | Error(_) => "TodoUpdateResultError"
  }

let union_VerifySessionResult_resolveType = (v: SendPay.VerifySession.verifySessionResult) =>
  switch v {
  | Ok(_) => "VerifySessionResultOk"
  | Error(_) => "VerifySessionResultError"
  }

let interface_Node_resolveType = (v: Interface_node.Resolver.t) =>
  switch v {
  | User(_) => "User"
  | Todo(_) => "Todo"
  }

i_Node.contents = GraphQLInterfaceType.make({
  name: "Node",
  description: "An object with an ID.",
  interfaces: [],
  fields: () =>
    {
      "id": {
        typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: "The id of the object.",
        deprecationReason: ?None,
      },
    }->makeFields,
  resolveType: GraphQLInterfaceType.makeResolveInterfaceTypeFn(interface_Node_resolveType),
})
t_ResultError.contents = GraphQLObjectType.make({
  name: "ResultError",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "name": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["name"]
        }),
      },
      "reason": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["reason"]
        }),
      },
    }->makeFields,
})
t_ResultOk.contents = GraphQLObjectType.make({
  name: "ResultOk",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "identifier": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["identifier"]
        }),
      },
      "lookupType": {
        typ: enum_LookupType->GraphQLEnumType.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["lookupType"]
        }),
      },
      "sessionId": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["sessionId"]
        }),
      },
    }->makeFields,
})
t_TodoAddResultError.contents = GraphQLObjectType.make({
  name: "TodoAddResultError",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "reason": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["reason"]
        }),
      },
    }->makeFields,
})
t_TodoAddResultOk.contents = GraphQLObjectType.make({
  name: "TodoAddResultOk",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "addedTodo": {
        typ: get_Todo()->GraphQLObjectType.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["addedTodo"]
        }),
      },
    }->makeFields,
})
t_TodoDeleteResultError.contents = GraphQLObjectType.make({
  name: "TodoDeleteResultError",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "reason": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["reason"]
        }),
      },
    }->makeFields,
})
t_TodoDeleteResultOk.contents = GraphQLObjectType.make({
  name: "TodoDeleteResultOk",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "deletedTodoId": {
        typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["deletedTodoId"]
        }),
      },
    }->makeFields,
})
t_TodoUpdateResultError.contents = GraphQLObjectType.make({
  name: "TodoUpdateResultError",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "message": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "What went wrong updating the todo.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["message"]
        }),
      },
    }->makeFields,
})
t_TodoUpdateResultOk.contents = GraphQLObjectType.make({
  name: "TodoUpdateResultOk",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "updatedTodo": {
        typ: get_Todo()->GraphQLObjectType.toGraphQLType->nonNull,
        description: "The todo that was updated.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["updatedTodo"]
        }),
      },
    }->makeFields,
})
t_VerifySessionResultError.contents = GraphQLObjectType.make({
  name: "VerifySessionResultError",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "name": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["name"]
        }),
      },
      "reason": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["reason"]
        }),
      },
    }->makeFields,
})
t_VerifySessionResultOk.contents = GraphQLObjectType.make({
  name: "VerifySessionResultOk",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "address": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["address"]
        }),
      },
      "chainId": {
        typ: Scalars.int->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["chainId"]
        }),
      },
      "sendId": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["sendId"]
        }),
      },
      "sendtags": {
        typ: GraphQLListType.make(
          Scalars.string->Scalars.toGraphQLType->nonNull,
        )->GraphQLListType.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["sendtags"]
        }),
      },
    }->makeFields,
})
t_Mutation.contents = GraphQLObjectType.make({
  name: "Mutation",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "makeSendpaySession": {
        typ: get_Result()->GraphQLUnionType.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        args: {
          "input": {typ: get_Input()->GraphQLInputObjectType.toGraphQLType->nonNull},
        }->makeArgs,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          SendPayMutations.makeSendpaySession(
            src,
            ~ctx,
            ~input=args["input"]->applyConversionToInputObject(input_Input_conversionInstructions),
          )
        }),
      },
      "todoAdd": {
        typ: get_TodoAddResult()->GraphQLUnionType.toGraphQLType->nonNull,
        description: "Add a new Todo item.",
        deprecationReason: ?None,
        args: {
          "input": {typ: get_TodoAddInput()->GraphQLInputObjectType.toGraphQLType->nonNull},
        }->makeArgs,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          TodoMutations.todoAdd(
            src,
            ~input=args["input"]->applyConversionToInputObject(
              input_TodoAddInput_conversionInstructions,
            ),
          )
        }),
      },
      "todoDelete": {
        typ: get_TodoDeleteResult()->GraphQLUnionType.toGraphQLType->nonNull,
        description: "Delete a todo.",
        deprecationReason: ?None,
        args: {"todoId": {typ: Scalars.id->Scalars.toGraphQLType->nonNull}}->makeArgs,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          TodoMutations.todoDelete(src, ~todoId=args["todoId"])
        }),
      },
      "todoUpdate": {
        typ: get_TodoUpdateResult()->GraphQLUnionType.toGraphQLType->nonNull,
        description: "Update a todo.",
        deprecationReason: ?None,
        args: {
          "input": {typ: get_TodoUpdateInput()->GraphQLInputObjectType.toGraphQLType->nonNull},
        }->makeArgs,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          TodoMutations.todoUpdate(
            src,
            ~ctx,
            ~input=args["input"]->applyConversionToInputObject(
              input_TodoUpdateInput_conversionInstructions,
            ),
          )
        }),
      },
    }->makeFields,
})
t_PageInfo.contents = GraphQLObjectType.make({
  name: "PageInfo",
  description: "Information about pagination in a connection.",
  interfaces: [],
  fields: () =>
    {
      "endCursor": {
        typ: Scalars.string->Scalars.toGraphQLType,
        description: "When paginating forwards, the cursor to continue.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["endCursor"]
        }),
      },
      "hasNextPage": {
        typ: Scalars.boolean->Scalars.toGraphQLType->nonNull,
        description: "When paginating forwards, are there more items?",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["hasNextPage"]
        }),
      },
      "hasPreviousPage": {
        typ: Scalars.boolean->Scalars.toGraphQLType->nonNull,
        description: "When paginating backwards, are there more items?",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["hasPreviousPage"]
        }),
      },
      "startCursor": {
        typ: Scalars.string->Scalars.toGraphQLType,
        description: "When paginating backwards, the cursor to continue.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["startCursor"]
        }),
      },
    }->makeFields,
})
t_Query.contents = GraphQLObjectType.make({
  name: "Query",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "currentTime": {
        typ: Scalars.float->Scalars.toGraphQLType,
        description: "The current time on the server, as a timestamp.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          Schema.currentTime(src)
        }),
      },
      "listTodos": {
        typ: get_TodoConnection()->GraphQLObjectType.toGraphQLType,
        description: "List todos.",
        deprecationReason: ?None,
        args: {
          "after": {typ: Scalars.string->Scalars.toGraphQLType},
          "before": {typ: Scalars.string->Scalars.toGraphQLType},
          "completed": {typ: Scalars.boolean->Scalars.toGraphQLType},
          "filterText": {typ: Scalars.string->Scalars.toGraphQLType},
          "first": {typ: Scalars.int->Scalars.toGraphQLType},
          "last": {typ: Scalars.int->Scalars.toGraphQLType},
        }->makeArgs,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          TodoResolvers.listTodos(
            src,
            ~after=args["after"]->Nullable.toOption,
            ~before=args["before"]->Nullable.toOption,
            ~completed=args["completed"]->Nullable.toOption,
            ~ctx,
            ~filterText=args["filterText"]->Nullable.toOption,
            ~first=args["first"]->Nullable.toOption,
            ~last=args["last"]->Nullable.toOption,
          )
        }),
      },
      "me": {
        typ: get_User()->GraphQLObjectType.toGraphQLType->nonNull,
        description: "The currently logged in user.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          UserResolvers.me(src, ~ctx)
        }),
      },
      "node": {
        typ: get_Node()->GraphQLInterfaceType.toGraphQLType,
        description: "Fetches an object given its ID.",
        deprecationReason: ?None,
        args: {"id": {typ: Scalars.id->Scalars.toGraphQLType->nonNull}}->makeArgs,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          NodeInterfaceResolver.node(src, ~ctx, ~id=args["id"])
        }),
      },
      "nodes": {
        typ: GraphQLListType.make(get_Node()->GraphQLInterfaceType.toGraphQLType)
        ->GraphQLListType.toGraphQLType
        ->nonNull,
        description: "Fetches objects given their IDs.",
        deprecationReason: ?None,
        args: {
          "ids": {
            typ: GraphQLListType.make(Scalars.id->Scalars.toGraphQLType->nonNull)
            ->GraphQLListType.toGraphQLType
            ->nonNull,
          },
        }->makeArgs,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          NodeInterfaceResolver.nodes(src, ~ctx, ~ids=args["ids"])
        }),
      },
    }->makeFields,
})
t_Todo.contents = GraphQLObjectType.make({
  name: "Todo",
  description: "A single todo item.",
  interfaces: [get_Node()],
  fields: () =>
    {
      "completed": {
        typ: Scalars.boolean->Scalars.toGraphQLType->nonNull,
        description: "Whether the todo is completed or not.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["completed"]
        }),
      },
      "id": {
        typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: "The id of the object.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          NodeInterfaceResolver.id(src, ~typename=Todo)
        }),
      },
      "text": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "The text of the todo item.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["text"]
        }),
      },
    }->makeFields,
})
t_TodoConnection.contents = GraphQLObjectType.make({
  name: "TodoConnection",
  description: "A connection to a todo.",
  interfaces: [],
  fields: () =>
    {
      "edges": {
        typ: GraphQLListType.make(
          get_TodoEdge()->GraphQLObjectType.toGraphQLType,
        )->GraphQLListType.toGraphQLType,
        description: "A list of edges.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["edges"]
        }),
      },
      "pageInfo": {
        typ: get_PageInfo()->GraphQLObjectType.toGraphQLType->nonNull,
        description: "Information to aid in pagination.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["pageInfo"]
        }),
      },
    }->makeFields,
})
t_TodoEdge.contents = GraphQLObjectType.make({
  name: "TodoEdge",
  description: "An edge to a todo.",
  interfaces: [],
  fields: () =>
    {
      "cursor": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "A cursor for use in pagination.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["cursor"]
        }),
      },
      "node": {
        typ: get_Todo()->GraphQLObjectType.toGraphQLType,
        description: "The item at the end of the edge.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["node"]
        }),
      },
    }->makeFields,
})
t_User.contents = GraphQLObjectType.make({
  name: "User",
  description: ?None,
  interfaces: [get_Node()],
  fields: () =>
    {
      "id": {
        typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: "The id of the object.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          NodeInterfaceResolver.id(src, ~typename=User)
        }),
      },
      "name": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["name"]
        }),
      },
    }->makeFields,
})
input_Input.contents = GraphQLInputObjectType.make({
  name: "Input",
  description: "Request to open a sendpay session",
  fields: () =>
    {
      "chainId": {
        GraphQLInputObjectType.typ: enum_ChainId->GraphQLEnumType.toGraphQLType,
        description: "The chain id to use for the session",
        deprecationReason: ?None,
      },
      "confirmationAddress": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "The ethereum address to receive the confirmation tx",
        deprecationReason: ?None,
      },
      "identifier": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "The identifier to request a session for",
        deprecationReason: ?None,
      },
      "lookupType": {
        GraphQLInputObjectType.typ: enum_LookupType->GraphQLEnumType.toGraphQLType->nonNull,
        description: "The type of identifier",
        deprecationReason: ?None,
      },
    }->makeFields,
})
input_TodoAddInput.contents = GraphQLInputObjectType.make({
  name: "TodoAddInput",
  description: ?None,
  fields: () =>
    {
      "completed": {
        GraphQLInputObjectType.typ: Scalars.boolean->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
      },
      "text": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
      },
    }->makeFields,
})
input_TodoUpdateInput.contents = GraphQLInputObjectType.make({
  name: "TodoUpdateInput",
  description: "Input for updating a todo.",
  fields: () =>
    {
      "completed": {
        GraphQLInputObjectType.typ: Scalars.boolean->Scalars.toGraphQLType,
        description: "Whether the todo is completed or not.",
        deprecationReason: ?None,
      },
      "text": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType,
        description: "What text the todo has.",
        deprecationReason: ?None,
      },
      "todoId": {
        GraphQLInputObjectType.typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: "The id of the todo to update.",
        deprecationReason: ?None,
      },
    }->makeFields,
})
union_Result.contents = GraphQLUnionType.make({
  name: "Result",
  description: ?None,
  types: () => [get_ResultError(), get_ResultOk()],
  resolveType: GraphQLUnionType.makeResolveUnionTypeFn(union_Result_resolveType),
})
union_TodoAddResult.contents = GraphQLUnionType.make({
  name: "TodoAddResult",
  description: ?None,
  types: () => [get_TodoAddResultError(), get_TodoAddResultOk()],
  resolveType: GraphQLUnionType.makeResolveUnionTypeFn(union_TodoAddResult_resolveType),
})
union_TodoDeleteResult.contents = GraphQLUnionType.make({
  name: "TodoDeleteResult",
  description: ?None,
  types: () => [get_TodoDeleteResultError(), get_TodoDeleteResultOk()],
  resolveType: GraphQLUnionType.makeResolveUnionTypeFn(union_TodoDeleteResult_resolveType),
})
union_TodoUpdateResult.contents = GraphQLUnionType.make({
  name: "TodoUpdateResult",
  description: ?None,
  types: () => [get_TodoUpdateResultError(), get_TodoUpdateResultOk()],
  resolveType: GraphQLUnionType.makeResolveUnionTypeFn(union_TodoUpdateResult_resolveType),
})
union_VerifySessionResult.contents = GraphQLUnionType.make({
  name: "VerifySessionResult",
  description: ?None,
  types: () => [get_VerifySessionResultError(), get_VerifySessionResultOk()],
  resolveType: GraphQLUnionType.makeResolveUnionTypeFn(union_VerifySessionResult_resolveType),
})

let schema = GraphQLSchemaType.make({"query": get_Query(), "mutation": get_Mutation()})
