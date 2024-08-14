/* @generated */
@@warning("-30")

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
type rec input_MakeSessionInput = {
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
