module Chain = {
  @gql.enum
  type chain = Mainnet | Base | BaseSepolia

  let toId = chain =>
    switch chain {
    | Mainnet => 1
    | Base => 8453
    | BaseSepolia => 84532
    }

  let fromId = chain =>
    switch chain {
    | 1 => Mainnet
    | 8453 => Base
    | 84532 => BaseSepolia
    | _ => panic("Invalid chain id")
    }
}
module LookupType = {
  @gql.enum
  type lookupType = | @as("tag") Tag | @as("sendid") SendId
}
