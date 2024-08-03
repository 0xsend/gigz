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

let t_Query: ref<GraphQLObjectType.t> = Obj.magic({"contents": Js.null})
let get_Query = () => t_Query.contents

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
    }->makeFields,
})

let schema = GraphQLSchemaType.make({"query": get_Query()})
