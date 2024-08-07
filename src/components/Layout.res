@react.component
let make = () => {
  <div className="p-6 h-full">
    <header className="w-full justify-center items-center">
      <div className="flex justify-center space-x-5 items-center">
        <h1 className="text-color12 text-uppercase text-3xl font-semibold">
          {React.string("Sendpay Example App")}
        </h1>
        <div className="h-14 border border-color11 rounded-md p-2 flex items-center space-x-3">
          <div className="w-10 rounded-lg">
            <IconLogo />
          </div>
          <p className="text-color12 font-semibold font-mono text-xl"> {React.string("v0.0.0")} </p>
        </div>
      </div>
    </header>
    <div className="flex flex-row py-2 " />
    <React.Suspense fallback={<div> {React.string("Loading...")} </div>}>
      <LayoutDisplay />
    </React.Suspense>
  </div>
}
