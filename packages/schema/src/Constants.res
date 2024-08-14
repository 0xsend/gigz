open SendPay_Types.Chain

@val @scope(("process", "env"))
external baseSepoliaRpcUrl: option<string> = "BASE_SEPOLIA_RPC_URL"

@val @scope(("process", "env"))
external baseRpcUrl: option<string> = "BASE_RPC_URL"

let usdcAddress = chain =>
  switch chain {
  | Mainnet => "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
  | Base => "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"
  | BaseSepolia => "0x036CbD53842c5426634e7929541eC2318f3dCF7e"
  }

let sendTokenAddress = chain =>
  switch chain {
  | Mainnet => "0x3f14920c99BEB920Afa163031c4e47a3e03B3e4A"
  | Base => "0x3f14920c99BEB920Afa163031c4e47a3e03B3e4A"
  | BaseSepolia => "0x7cEfbe54c37a35dCdaD29b86373ca8353a2F4680"
  }

let transportUrl = switch Vercel.env {
| Some(Production) => baseRpcUrl->Option.getOr("https://mainnet.base.org")
| Some(Preview) | Some(Development) | None =>
  baseSepoliaRpcUrl->Option.getOr("https://sepolia.base.org")
}

let chain = switch Vercel.env {
| Some(Production) => Viem.Chain.base
| Some(Preview) => Viem.Chain.baseSepolia
| Some(Development) | None => Viem.Chain.baseSepolia
}
