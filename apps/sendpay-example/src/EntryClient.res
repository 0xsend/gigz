let boot = () => {
  let routes = RouteDeclarations.make()
  let routerEnvironment = RelayRouter.RouterEnvironment.makeBrowserEnvironment()

  let (_, routerContext) = RelayRouter.Router.make(
    ~routes,
    ~environment=RelayEnv.environment,
    ~routerEnvironment,
    ~preloadAsset=RelayRouter.AssetPreloader.makeClientAssetPreloader(RelayEnv.preparedAssetsMap),
  )

  let localPrivateKey = Dom.Storage2.localStorage->Dom.Storage2.getItem("sendpay_privateKey")
  let localPublicKey = Dom.Storage2.localStorage->Dom.Storage2.getItem("sendpay_publicKey")
  let localSendpayKey = Dom.Storage2.localStorage->Dom.Storage2.getItem("sendpay_sendpayKey")

  let initializeKeyPair = async () => {
    switch await Jose.generateKeyPair(
      ES256,
      ~options={
        extractable: true,
      },
    ) {
    | {publicKey, privateKey} =>
      switch (
        await Jose.exportSPKI(publicKey),
        await Jose.exportPKCS8(privateKey),
        await {Jose.exportJWK(publicKey)}->Promise.then(Jose.calculateJwkThumbprint),
      ) {
      | (publicKey, privateKey, sendpayKey) =>
        if localPrivateKey->Option.isNone {
          Dom.Storage2.localStorage->Dom.Storage2.setItem("sendpay_privateKey", privateKey)
        }
        if localPublicKey->Option.isNone {
          Dom.Storage2.localStorage->Dom.Storage2.setItem("sendpay_publicKey", publicKey)
        }
        if localSendpayKey->Option.isNone {
          Dom.Storage2.localStorage->Dom.Storage2.setItem("sendpay_sendpayKey", sendpayKey)
        }
      }

    | exception e => raise(e)
    }
  }

  initializeKeyPair()->ignore

  ReactDOMExperimental.renderConcurrentRootAtElementWithId(
    <App environment=RelayEnv.environment routerContext />,
    "root",
  )
}

boot()
