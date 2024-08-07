type publicClient

module Chain = {
  type t
  @module("viem/chains") @val external mainnet: t = "mainnet"
  @module("viem/chains") @val external base: t = "base"
  @module("viem/chains") @val external baseSepolia: t = "baseSepolia"
}

module Transport = {
  type t
  type config = {}
  @module("viem") external http: (string, ~config: config=?) => t = "http"
}
module Event = {
  type t
  type log<'args> = {
    address: string,
    args: 'args,
    blockHash: string,
    blockNumber: bigint,
    data: string,
    eventName: string,
    logIndex: int,
    removed: bool,
    topics: array<string>,
    transactionHash: string,
    transactionIndex: int,
  }
}

module Contract = {
  type t
  @module("viem") external getContractEvents: string => Promise.t<t> = "getContract"
}

module Abi = {
  type t
  @module("viem") external parseAbiItem: string => t = "parseAbiItem"

  type eventInput = {
    name: string,
    indexed: bool,
    @as("type") type_: string,
  }
  type event = {
    name: string,
    inputs: array<eventInput>,
  }
}

module Block = {
  type t = {timestamp: bigint}
  type config = {
    blockHash?: string,
    blockNumber?: bigint,
  }
  @send external get: (publicClient, ~config: config=?) => Promise.t<t> = "getBlock"
  @send
  external getNumber: (publicClient, ~cacheTime: int=?) => Promise.t<bigint> = "getBlockNumber"
}

module Logs = {
  type t

  @unboxed
  type block =
    | Block(bigint)
    | @as("latest") Latest
    | @as("pending") Pending
    | @as("safe") Safe
    | @as("finalized") Finalized
    | @as("earliest") Earliest

  type input<'filterArgs, 'eventArgs> = {
    address?: string,
    event?: Abi.t,
    args?: 'filterArgs,
    fromBlock?: block,
    toBlock?: block,
    strict?: bool,
  }
  @send
  external get: (
    publicClient,
    ~input: input<'filterArgs, 'eventArgs>=?,
  ) => Promise.t<array<Event.log<'eventArgs>>> = "getLogs"
}

module PublicClient = {
  type t = publicClient
  type config = {
    chain: Chain.t,
    transport: Transport.t,
  }
  @module("viem") external make: config => t = "createPublicClient"
}
