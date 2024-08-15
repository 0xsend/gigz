module QueryFragment = %relay(`
  fragment LayoutDisplay_query on Query {
    currentTime
  }
`)

@react.component
let make = (~query, ~children) => {
  let query = QueryFragment.use(query)

  <>
    <div className="my-4">
      {`Unix Time: ${query.currentTime->Option.mapOr("0", time =>
          Float.toString(time)
        )}`->React.string}
    </div>
    <div> {children} </div>
  </>
}
