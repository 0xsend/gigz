type context = {
  currentUserId: option<string>,
  sendpayKey: string,
  dataLoaders: DataLoaders.t,
  edgedbClient: EdgeDB.Client.t,
  viemClient: Viem.PublicClient.t,
}
