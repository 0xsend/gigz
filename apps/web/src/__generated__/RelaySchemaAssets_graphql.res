/* @generated */
@@warning("-30")

@live @unboxed
type enum_Category = 
  | GraphicDesign
  | MotionDesign
  | ThreeDArt
  | PhotoVideo
  | WebDesign
  | FutureAddedValue(string)


@live @unboxed
type enum_Category_input = 
  | GraphicDesign
  | MotionDesign
  | ThreeDArt
  | PhotoVideo
  | WebDesign


@live @unboxed
type enum_Chain = 
  | Mainnet
  | Base
  | BaseSepolia
  | FutureAddedValue(string)


@live @unboxed
type enum_Chain_input = 
  | Mainnet
  | Base
  | BaseSepolia


@live @unboxed
type enum_ListingType = 
  | Gig
  | Offer
  | FutureAddedValue(string)


@live @unboxed
type enum_ListingType_input = 
  | Gig
  | Offer


@live @unboxed
type enum_LookupType = 
  | @as("tag") Tag
  | @as("sendid") Sendid
  | FutureAddedValue(string)


@live @unboxed
type enum_LookupType_input = 
  | @as("tag") Tag
  | @as("sendid") Sendid


@live @unboxed
type enum_Token = 
  | USDC
  | ETH
  | SEND
  | FutureAddedValue(string)


@live @unboxed
type enum_Token_input = 
  | USDC
  | ETH
  | SEND


@live @unboxed
type enum_RequiredFieldAction = 
  | NONE
  | LOG
  | THROW
  | FutureAddedValue(string)


@live @unboxed
type enum_RequiredFieldAction_input = 
  | NONE
  | LOG
  | THROW


@live @unboxed
type enum_CatchFieldTo = 
  | NULL
  | RESULT
  | FutureAddedValue(string)


@live @unboxed
type enum_CatchFieldTo_input = 
  | NULL
  | RESULT


@live
type rec input_MakeListing = {
  categories: array<enum_Category_input>,
  creator: string,
  description?: string,
  imageLinks?: array<string>,
  pills: input_PillsInput,
  skills?: array<input_SkillInput>,
  title: string,
}

@live
and input_MakeListing_nullable = {
  categories: array<enum_Category_input>,
  creator: string,
  description?: Js.Null.t<string>,
  imageLinks?: Js.Null.t<array<string>>,
  pills: input_PillsInput_nullable,
  skills?: Js.Null.t<array<input_SkillInput_nullable>>,
  title: string,
}

@live
and input_MakeListingByType = {
  gig?: input_MakeListing,
  offer?: input_MakeListing,
}

@live
and input_MakeListingByType_nullable = {
  gig?: Js.Null.t<input_MakeListing_nullable>,
  offer?: Js.Null.t<input_MakeListing_nullable>,
}

@live
and input_MakeSessionInput = {
  bySendId?: input_MakeSessionInputBySendId,
  byTag?: input_MakeSessionInputByTag,
}

@live
and input_MakeSessionInput_nullable = {
  bySendId?: Js.Null.t<input_MakeSessionInputBySendId_nullable>,
  byTag?: Js.Null.t<input_MakeSessionInputByTag_nullable>,
}

@live
and input_MakeSessionInputBySendId = {
  chain?: enum_Chain_input,
  confirmationAddress: string,
  confirmationAmount?: Schema.BigInt.t,
  duration?: float,
  sendid: float,
}

@live
and input_MakeSessionInputBySendId_nullable = {
  chain?: Js.Null.t<enum_Chain_input>,
  confirmationAddress: string,
  confirmationAmount?: Js.Null.t<Schema.BigInt.t>,
  duration?: Js.Null.t<float>,
  sendid: float,
}

@live
and input_MakeSessionInputByTag = {
  chain?: enum_Chain_input,
  confirmationAddress: string,
  confirmationAmount?: Schema.BigInt.t,
  duration?: float,
  tag: string,
}

@live
and input_MakeSessionInputByTag_nullable = {
  chain?: Js.Null.t<enum_Chain_input>,
  confirmationAddress: string,
  confirmationAmount?: Js.Null.t<Schema.BigInt.t>,
  duration?: Js.Null.t<float>,
  tag: string,
}

@live
and input_PillsInput = {
  eth: Schema.BigInt.t,
  send: Schema.BigInt.t,
  usdc: Schema.BigInt.t,
}

@live
and input_PillsInput_nullable = {
  eth: Schema.BigInt.t,
  send: Schema.BigInt.t,
  usdc: Schema.BigInt.t,
}

@live
and input_SkillInput = {
  name: string,
}

@live
and input_SkillInput_nullable = {
  name: string,
}

@live
and input_TodoAddInput = {
  completed: bool,
  text: string,
}

@live
and input_TodoAddInput_nullable = {
  completed: bool,
  text: string,
}

@live
and input_TodoUpdateInput = {
  completed?: bool,
  text?: string,
  todoId: string,
}

@live
and input_TodoUpdateInput_nullable = {
  completed?: Js.Null.t<bool>,
  text?: Js.Null.t<string>,
  todoId: string,
}
