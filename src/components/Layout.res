module Query = %relay(`
  query LayoutQuery {
    ...LayoutDisplay_query
  }
`)

let links = [("Show Gigs", Routes.Root.Todos.Route.makeLink())]

@react.component
let make = (~queryRef, ~children) => {
  let data = Query.usePreloaded(~queryRef)

  <div className="p-6">
    <div className="f-1 w-full justify-center items-center">
      <div className="w-full max-w-80 mx-auto">
        <Logo />
      </div>
    </div>
    <div className="flex flex-row py-2 ">
      {links
      ->Array.map(((label, link)) =>
        <RelayRouter.Link className="p-4 rounded-md bg-[#40FB50] text-black" key=label to_=link>
          {React.string(label)}
        </RelayRouter.Link>
      )
      ->React.array}
    </div>
    <React.Suspense fallback={<div> {React.string("Loading...")} </div>}>
      <LayoutDisplay query={data.fragmentRefs}> {children} </LayoutDisplay>
    </React.Suspense>
  </div>
}
