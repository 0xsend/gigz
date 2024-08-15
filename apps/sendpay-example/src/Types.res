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
