module Query = %relay(`
  query SingleTodoQuery($id: ID!, $showMore: Boolean!) {
    node(id: $id) {
      ... on Todo {
        ...SingleTodoDisplay_todo @arguments(showMore: $showMore)
      }
    }
  }
`)

@react.component
let make = (~queryRef) => {
  let data = Query.usePreloaded(~queryRef)

  switch data.node {
  | Some(Todo({fragmentRefs})) => <SingleTodoDisplay todo=fragmentRefs />
  | _ => React.string("Oops, did not find todo!")
  }
}
