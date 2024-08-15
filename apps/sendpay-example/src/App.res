let client = ReactQuery.Provider.createClient()

@react.component
let make = () => {
  <ReactQuery.Provider client>
    <React.Suspense
      fallback={<p className="text-color12 text-center"> {React.string("Loading...")} </p>}>
      <ErrorBoundary fallback={_ => {<div> {React.string("Error!")} </div>}}>
        <Layout />
      </ErrorBoundary>
    </React.Suspense>
  </ReactQuery.Provider>
}
