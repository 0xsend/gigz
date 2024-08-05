module Chain = {
  type t
  @module("viem/chains") @val external mainnet: t = "mainnet"
  @module("viem/chains") @val external base: t = "base"
  @module("viem/chains") @val external baseSepolia: t = "baseSepolia"
}

module Transport = {
  type t
  @module("viem") external http: unit => t = "http"
}

module PublicClient = {
  type t
  type config = {
    chain: Chain.t,
    transport: Transport.t,
  }
  @module("viem") external make: config => t = "createPublicClient"
}
