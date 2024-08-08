type context = {
  currentUserId?: string,
  sendpayKey: string,
  dataLoaders: DataLoaders.t,
  edgedbClient: EdgeDB.Client.t,
  viemClient: Viem.PublicClient.t,
}
