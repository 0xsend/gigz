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
let enum_ListingType = GraphQLEnumType.make({
  name: "ListingType",
  description: ?None,
  values: {
    "Gig": {GraphQLEnumType.value: "Gig", description: ?None, deprecationReason: ?None},
    "Offer": {GraphQLEnumType.value: "Offer", description: ?None, deprecationReason: ?None},
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
let enum_Token = GraphQLEnumType.make({
  name: "Token",
  description: ?None,
  values: {
    "USDC": {GraphQLEnumType.value: "USDC", description: ?None, deprecationReason: ?None},
    "ETH": {GraphQLEnumType.value: "ETH", description: ?None, deprecationReason: ?None},
    "SEND": {GraphQLEnumType.value: "SEND", description: ?None, deprecationReason: ?None},
  }->makeEnumValues,
})
let i_Node: ref<GraphQLInterfaceType.t> = Obj.magic({"contents": Js.null})
let get_Node = () => i_Node.contents
let t_ConsumeSessionResultError: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_ConsumeSessionResultError = () => t_ConsumeSessionResultError.contents
let t_ConsumeSessionResultOk: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_ConsumeSessionResultOk = () => t_ConsumeSessionResultOk.contents
let t_MakeListingResultError: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_MakeListingResultError = () => t_MakeListingResultError.contents
let t_MakeListingResultOk: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_MakeListingResultOk = () => t_MakeListingResultOk.contents
let t_MakeSessionResultError: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_MakeSessionResultError = () => t_MakeSessionResultError.contents
let t_MakeSessionResultOk: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_MakeSessionResultOk = () => t_MakeSessionResultOk.contents
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
let t_Fee: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Fee = () => t_Fee.contents
let t_Listing: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Listing = () => t_Listing.contents
let t_ListingConnection: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_ListingConnection = () => t_ListingConnection.contents
let t_ListingEdge: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_ListingEdge = () => t_ListingEdge.contents
let t_Mutation: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Mutation = () => t_Mutation.contents
let t_PageInfo: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_PageInfo = () => t_PageInfo.contents
let t_Query: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Query = () => t_Query.contents
let t_Tag: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Tag = () => t_Tag.contents
let t_Todo: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Todo = () => t_Todo.contents
let t_TodoConnection: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoConnection = () => t_TodoConnection.contents
let t_TodoEdge: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoEdge = () => t_TodoEdge.contents
let t_User: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_User = () => t_User.contents
let input_MakeSessionInputBySendId: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_MakeSessionInputBySendId = () => input_MakeSessionInputBySendId.contents
let input_MakeSessionInputBySendId_conversionInstructions = []
let input_MakeSessionInputByTag: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_MakeSessionInputByTag = () => input_MakeSessionInputByTag.contents
let input_MakeSessionInputByTag_conversionInstructions = []
let input_FeeInput: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_FeeInput = () => input_FeeInput.contents
let input_FeeInput_conversionInstructions = []
let input_MakeListing: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_MakeListing = () => input_MakeListing.contents
let input_MakeListing_conversionInstructions = []
let input_TagInput: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_TagInput = () => input_TagInput.contents
let input_TagInput_conversionInstructions = []
let input_TodoAddInput: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoAddInput = () => input_TodoAddInput.contents
let input_TodoAddInput_conversionInstructions = []
let input_TodoUpdateInput: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_TodoUpdateInput = () => input_TodoUpdateInput.contents
let input_TodoUpdateInput_conversionInstructions = []
input_MakeSessionInputBySendId_conversionInstructions->Array.pushMany([
  ("confirmationAmount", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
  ("chain", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
  ("duration", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
])
input_MakeSessionInputByTag_conversionInstructions->Array.pushMany([
  ("confirmationAmount", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
  ("chain", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
  ("duration", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
])
input_FeeInput_conversionInstructions->Array.pushMany([])
input_MakeListing_conversionInstructions->Array.pushMany([
  ("description", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
  ("imageLinks", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
  (
    "fees",
    makeInputObjectFieldConverterFn(v =>
      v->Array.map(v => v->applyConversionToInputObject(input_FeeInput_conversionInstructions))
    ),
  ),
  (
    "tags",
    makeInputObjectFieldConverterFn(v =>
      switch v->Nullable.toOption {
      | None => None
      | Some(v) =>
        v
        ->Array.map(v => v->applyConversionToInputObject(input_TagInput_conversionInstructions))
        ->Some
      }
    ),
  ),
  (
    "contactFees",
    makeInputObjectFieldConverterFn(v =>
      v->Array.map(v => v->applyConversionToInputObject(input_FeeInput_conversionInstructions))
    ),
  ),
])
input_TagInput_conversionInstructions->Array.pushMany([])
input_TodoAddInput_conversionInstructions->Array.pushMany([])
input_TodoUpdateInput_conversionInstructions->Array.pushMany([
  ("completed", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
  ("text", makeInputObjectFieldConverterFn(v => v->Nullable.toOption)),
])
let union_ConsumeSessionResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_ConsumeSessionResult = () => union_ConsumeSessionResult.contents
let union_MakeListingResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_MakeListingResult = () => union_MakeListingResult.contents
let union_MakeSessionResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_MakeSessionResult = () => union_MakeSessionResult.contents
let union_TodoAddResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_TodoAddResult = () => union_TodoAddResult.contents
let union_TodoDeleteResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_TodoDeleteResult = () => union_TodoDeleteResult.contents
let union_TodoUpdateResult: ref<GraphQLUnionType.t> = Obj.magic({"contents": Js.null})
let get_TodoUpdateResult = () => union_TodoUpdateResult.contents
let inputUnion_MakeListingByType: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_MakeListingByType = () => inputUnion_MakeListingByType.contents
let inputUnion_MakeListingByType_conversionInstructions = []
let inputUnion_MakeSessionInput: ref<GraphQLInputObjectType.t> = Obj.magic({"contents": Js.null})
let get_MakeSessionInput = () => inputUnion_MakeSessionInput.contents
let inputUnion_MakeSessionInput_conversionInstructions = []
inputUnion_MakeListingByType_conversionInstructions->Array.pushMany([
  (
    "offer",
    makeInputObjectFieldConverterFn(v =>
      switch v->Nullable.toOption {
      | None => None
      | Some(v) => v->applyConversionToInputObject(input_MakeListing_conversionInstructions)->Some
      }
    ),
  ),
  (
    "gig",
    makeInputObjectFieldConverterFn(v =>
      switch v->Nullable.toOption {
      | None => None
      | Some(v) => v->applyConversionToInputObject(input_MakeListing_conversionInstructions)->Some
      }
    ),
  ),
])
inputUnion_MakeSessionInput_conversionInstructions->Array.pushMany([
  (
    "bySendId",
    makeInputObjectFieldConverterFn(v =>
      switch v->Nullable.toOption {
      | None => None
      | Some(v) =>
        v->applyConversionToInputObject(input_MakeSessionInputBySendId_conversionInstructions)->Some
      }
    ),
  ),
  (
    "byTag",
    makeInputObjectFieldConverterFn(v =>
      switch v->Nullable.toOption {
      | None => None
      | Some(v) =>
        v->applyConversionToInputObject(input_MakeSessionInputByTag_conversionInstructions)->Some
      }
    ),
  ),
])

let union_ConsumeSessionResult_resolveType = (v: SendPay_ConsumeSession.consumeSessionResult) =>
  switch v {
  | Ok(_) => "ConsumeSessionResultOk"
  | Error(_) => "ConsumeSessionResultError"
  }

let union_MakeListingResult_resolveType = (v: Mutations.makeListingResult) =>
  switch v {
  | Ok(_) => "MakeListingResultOk"
  | Error(_) => "MakeListingResultError"
  }

let union_MakeSessionResult_resolveType = (v: SendPay_MakeSession.makeSessionResult) =>
  switch v {
  | Ok(_) => "MakeSessionResultOk"
  | Error(_) => "MakeSessionResultError"
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

let interface_Node_resolveType = (v: Interface_node.Resolver.t) =>
  switch v {
  | User(_) => "User"
  | Listing(_) => "Listing"
  | Tag(_) => "Tag"
  | Fee(_) => "Fee"
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
t_ConsumeSessionResultError.contents = GraphQLObjectType.make({
  name: "ConsumeSessionResultError",
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
        typ: Scalars.string->Scalars.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["reason"]
        }),
      },
    }->makeFields,
})
t_ConsumeSessionResultOk.contents = GraphQLObjectType.make({
  name: "ConsumeSessionResultOk",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "about": {
        typ: Scalars.string->Scalars.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["about"]
        }),
      },
      "address": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["address"]
        }),
      },
      "avatar_url": {
        typ: Scalars.string->Scalars.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["avatar_url"]
        }),
      },
      "chainId": {
        typ: Scalars.int->Scalars.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["chainId"]
        }),
      },
      "refcode": {
        typ: Scalars.string->Scalars.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["refcode"]
        }),
      },
      "sendId": {
        typ: Scalars.float->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["sendId"]
        }),
      },
      "sendtag": {
        typ: Scalars.string->Scalars.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["sendtag"]
        }),
      },
    }->makeFields,
})
t_MakeListingResultError.contents = GraphQLObjectType.make({
  name: "MakeListingResultError",
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
t_MakeListingResultOk.contents = GraphQLObjectType.make({
  name: "MakeListingResultOk",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "newListing": {
        typ: get_Listing()->GraphQLObjectType.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["newListing"]
        }),
      },
    }->makeFields,
})
t_MakeSessionResultError.contents = GraphQLObjectType.make({
  name: "MakeSessionResultError",
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
t_MakeSessionResultOk.contents = GraphQLObjectType.make({
  name: "MakeSessionResultOk",
  description: ?None,
  interfaces: [],
  fields: () =>
    {
      "id": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["id"]
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
t_Fee.contents = GraphQLObjectType.make({
  name: "Fee",
  description: ?None,
  interfaces: [get_Node()],
  fields: () =>
    {
      "amount": {
        typ: scalar_BigInt->GraphQLScalar.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["amount"]
        }),
      },
      "id": {
        typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: "The id of the object.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          NodeInterfaceResolver.id(src, ~typename=Fee)
        }),
      },
      "token": {
        typ: enum_Token->GraphQLEnumType.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["token"]
        }),
      },
    }->makeFields,
})
t_Listing.contents = GraphQLObjectType.make({
  name: "Listing",
  description: "A single listing item.",
  interfaces: [get_Node()],
  fields: () =>
    {
      "contactFees": {
        typ: GraphQLListType.make(get_Fee()->GraphQLObjectType.toGraphQLType->nonNull)
        ->GraphQLListType.toGraphQLType
        ->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["contactFees"]
        }),
      },
      "contactLinks": {
        typ: GraphQLListType.make(Scalars.string->Scalars.toGraphQLType->nonNull)
        ->GraphQLListType.toGraphQLType
        ->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["contactLinks"]
        }),
      },
      "description": {
        typ: Scalars.string->Scalars.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["description"]
        }),
      },
      "fees": {
        typ: GraphQLListType.make(get_Fee()->GraphQLObjectType.toGraphQLType->nonNull)
        ->GraphQLListType.toGraphQLType
        ->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["fees"]
        }),
      },
      "id": {
        typ: Scalars.id->Scalars.toGraphQLType->nonNull,
        description: "The id of the object.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          NodeInterfaceResolver.id(src, ~typename=Listing)
        }),
      },
      "imageLinks": {
        typ: GraphQLListType.make(
          Scalars.string->Scalars.toGraphQLType->nonNull,
        )->GraphQLListType.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["imageLinks"]
        }),
      },
      "tags": {
        typ: GraphQLListType.make(get_Tag()->GraphQLObjectType.toGraphQLType->nonNull)
        ->GraphQLListType.toGraphQLType
        ->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["tags"]
        }),
      },
      "title": {
        typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["title"]
        }),
      },
    }->makeFields,
})
t_ListingConnection.contents = GraphQLObjectType.make({
  name: "ListingConnection",
  description: "A connection to a todo.",
  interfaces: [],
  fields: () =>
    {
      "edges": {
        typ: GraphQLListType.make(
          get_ListingEdge()->GraphQLObjectType.toGraphQLType,
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
t_ListingEdge.contents = GraphQLObjectType.make({
  name: "ListingEdge",
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
        typ: get_Listing()->GraphQLObjectType.toGraphQLType,
        description: "The item at the end of the edge.",
        deprecationReason: ?None,
        resolve: makeResolveFn((src, _args, _ctx, _info) => {
          let src = typeUnwrapper(src)
          src["node"]
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
      "consumeSendpaySession": {
        typ: get_ConsumeSessionResult()->GraphQLUnionType.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          SendPayMutations.consumeSendpaySession(src, ~ctx)
        }),
      },
      "makeListing": {
        typ: get_MakeListingResult()->GraphQLUnionType.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        args: {
          "input": {typ: get_MakeListingByType()->GraphQLInputObjectType.toGraphQLType->nonNull},
        }->makeArgs,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          Mutations.makeListing(
            src,
            ~ctx,
            ~input=args["input"]
            ->applyConversionToInputObject(inputUnion_MakeListingByType_conversionInstructions)
            ->inputUnionUnwrapper([]),
          )
        }),
      },
      "makeSendpaySession": {
        typ: get_MakeSessionResult()->GraphQLUnionType.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
        args: {
          "input": {typ: get_MakeSessionInput()->GraphQLInputObjectType.toGraphQLType->nonNull},
        }->makeArgs,
        resolve: makeResolveFn((src, args, ctx, info) => {
          let src = typeUnwrapper(src)
          SendPayMutations.makeSendpaySession(
            src,
            ~ctx,
            ~input=args["input"]
            ->applyConversionToInputObject(inputUnion_MakeSessionInput_conversionInstructions)
            ->inputUnionUnwrapper(["BySendId", "ByTag"]),
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
t_Tag.contents = GraphQLObjectType.make({
  name: "Tag",
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
          NodeInterfaceResolver.id(src, ~typename=Tag)
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
input_MakeSessionInputBySendId.contents = GraphQLInputObjectType.make({
  name: "MakeSessionInputBySendId",
  description: ?None,
  fields: () =>
    {
      "chain": {
        GraphQLInputObjectType.typ: enum_Chain->GraphQLEnumType.toGraphQLType,
        description: "The chain id to use for the session",
        deprecationReason: ?None,
      },
      "confirmationAddress": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "The ethereum address to receive the confirmation tx",
        deprecationReason: ?None,
      },
      "confirmationAmount": {
        GraphQLInputObjectType.typ: scalar_BigInt->GraphQLScalar.toGraphQLType,
        description: "The amount of tokens to send to the confirmation address",
        deprecationReason: ?None,
      },
      "duration": {
        GraphQLInputObjectType.typ: Scalars.float->Scalars.toGraphQLType,
        description: "Duration of the session in milliseconds",
        deprecationReason: ?None,
      },
      "sendid": {
        GraphQLInputObjectType.typ: Scalars.float->Scalars.toGraphQLType->nonNull,
        description: "The sendid to request a session for",
        deprecationReason: ?None,
      },
    }->makeFields,
})
input_MakeSessionInputByTag.contents = GraphQLInputObjectType.make({
  name: "MakeSessionInputByTag",
  description: ?None,
  fields: () =>
    {
      "chain": {
        GraphQLInputObjectType.typ: enum_Chain->GraphQLEnumType.toGraphQLType,
        description: "The chain id to use for the session",
        deprecationReason: ?None,
      },
      "confirmationAddress": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "The ethereum address to receive the confirmation tx",
        deprecationReason: ?None,
      },
      "confirmationAmount": {
        GraphQLInputObjectType.typ: scalar_BigInt->GraphQLScalar.toGraphQLType,
        description: "The amount of tokens to send to the confirmation address",
        deprecationReason: ?None,
      },
      "duration": {
        GraphQLInputObjectType.typ: Scalars.float->Scalars.toGraphQLType,
        description: "Duration of the session in milliseconds",
        deprecationReason: ?None,
      },
      "tag": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "The sendtag to request a session for",
        deprecationReason: ?None,
      },
    }->makeFields,
})
input_FeeInput.contents = GraphQLInputObjectType.make({
  name: "FeeInput",
  description: ?None,
  fields: () =>
    {
      "amount": {
        GraphQLInputObjectType.typ: scalar_BigInt->GraphQLScalar.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
      },
      "token": {
        GraphQLInputObjectType.typ: enum_Token->GraphQLEnumType.toGraphQLType->nonNull,
        description: ?None,
        deprecationReason: ?None,
      },
    }->makeFields,
})
input_MakeListing.contents = GraphQLInputObjectType.make({
  name: "MakeListing",
  description: ?None,
  fields: () =>
    {
      "contactFees": {
        GraphQLInputObjectType.typ: GraphQLListType.make(
          get_FeeInput()->GraphQLInputObjectType.toGraphQLType->nonNull,
        )
        ->GraphQLListType.toGraphQLType
        ->nonNull,
        description: "The fees to contact the lister",
        deprecationReason: ?None,
      },
      "contactLinks": {
        GraphQLInputObjectType.typ: GraphQLListType.make(
          Scalars.string->Scalars.toGraphQLType->nonNull,
        )
        ->GraphQLListType.toGraphQLType
        ->nonNull,
        description: "The chain id to use for the session",
        deprecationReason: ?None,
      },
      "description": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType,
        description: "The description of the listing",
        deprecationReason: ?None,
      },
      "fees": {
        GraphQLInputObjectType.typ: GraphQLListType.make(
          get_FeeInput()->GraphQLInputObjectType.toGraphQLType->nonNull,
        )
        ->GraphQLListType.toGraphQLType
        ->nonNull,
        description: "The fees for the listing",
        deprecationReason: ?None,
      },
      "imageLinks": {
        GraphQLInputObjectType.typ: GraphQLListType.make(
          Scalars.string->Scalars.toGraphQLType->nonNull,
        )->GraphQLListType.toGraphQLType,
        description: "The chain id to use for the session",
        deprecationReason: ?None,
      },
      "sendid": {
        GraphQLInputObjectType.typ: Scalars.float->Scalars.toGraphQLType->nonNull,
        description: "The sendid to request a session for",
        deprecationReason: ?None,
      },
      "tags": {
        GraphQLInputObjectType.typ: GraphQLListType.make(
          get_TagInput()->GraphQLInputObjectType.toGraphQLType->nonNull,
        )->GraphQLListType.toGraphQLType,
        description: "The tags for the listing",
        deprecationReason: ?None,
      },
      "title": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: "The title of the listing",
        deprecationReason: ?None,
      },
    }->makeFields,
})
input_TagInput.contents = GraphQLInputObjectType.make({
  name: "TagInput",
  description: ?None,
  fields: () =>
    {
      "name": {
        GraphQLInputObjectType.typ: Scalars.string->Scalars.toGraphQLType->nonNull,
        description: ?None,
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
inputUnion_MakeListingByType.contents = GraphQLInputObjectType.make({
  name: "MakeListingByType",
  description: ?None,
  fields: () =>
    {
      "gig": {
        GraphQLInputObjectType.typ: get_MakeListing()->GraphQLInputObjectType.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
      },
      "offer": {
        GraphQLInputObjectType.typ: get_MakeListing()->GraphQLInputObjectType.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
      },
    }->makeFields,
  extensions: {oneOf: true},
})
inputUnion_MakeSessionInput.contents = GraphQLInputObjectType.make({
  name: "MakeSessionInput",
  description: ?None,
  fields: () =>
    {
      "bySendId": {
        GraphQLInputObjectType.typ: get_MakeSessionInputBySendId()->GraphQLInputObjectType.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
      },
      "byTag": {
        GraphQLInputObjectType.typ: get_MakeSessionInputByTag()->GraphQLInputObjectType.toGraphQLType,
        description: ?None,
        deprecationReason: ?None,
      },
    }->makeFields,
  extensions: {oneOf: true},
})
union_ConsumeSessionResult.contents = GraphQLUnionType.make({
  name: "ConsumeSessionResult",
  description: ?None,
  types: () => [get_ConsumeSessionResultError(), get_ConsumeSessionResultOk()],
  resolveType: GraphQLUnionType.makeResolveUnionTypeFn(union_ConsumeSessionResult_resolveType),
})
union_MakeListingResult.contents = GraphQLUnionType.make({
  name: "MakeListingResult",
  description: ?None,
  types: () => [get_MakeListingResultError(), get_MakeListingResultOk()],
  resolveType: GraphQLUnionType.makeResolveUnionTypeFn(union_MakeListingResult_resolveType),
})
union_MakeSessionResult.contents = GraphQLUnionType.make({
  name: "MakeSessionResult",
  description: ?None,
  types: () => [get_MakeSessionResultError(), get_MakeSessionResultOk()],
  resolveType: GraphQLUnionType.makeResolveUnionTypeFn(union_MakeSessionResult_resolveType),
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

let schema = GraphQLSchemaType.make({"query": get_Query(), "mutation": get_Mutation()})
