module TodoFragment = %relay(`
  fragment SingleTodoDisplay_todo on Todo
  @refetchable(queryName: "SingleTodoDisplayRefetchQuery")
  @argumentDefinitions(showMore: { type: "Boolean", defaultValue: false }) {
    id
    text
    completed
    isShowingMore: id @include(if: $showMore)
  }
`)

module UpdateTodoItemMutation = %relay(`
  mutation SingleTodoDisplay_UpdateTodoItemMutation($input: TodoUpdateInput!) {
    todoUpdate(input: $input) {
      ... on TodoUpdateResult {
        ... on TodoUpdateResultOk {
          updatedTodo {
            completed
          }
        }
        ... on TodoUpdateResultError {
          message
        }
      }
    }
  }
`)

@react.component
let make = (~todo) => {
  let (todo, refetch) = TodoFragment.useRefetchable(todo)
  let (mutate, isMutating) = UpdateTodoItemMutation.use()
  let (isRefetching, startTransition) = React.useTransition()
  let completed = todo.completed
  let {setParams} = Routes.Root.Todos.Single.Route.useQueryParams()
  let isShowingMore = todo.isShowingMore->Option.isSome

  <div className="border-2">
    <p> {React.string(todo.text)} </p>
    <div className="p-2"> {React.string(completed ? "Completed" : "Not completed")} </div>
    {if isShowingMore {
      <button
        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        disabled=isMutating
        onClick={_ => {
          let _ = mutate(
            ~variables={
              input: {
                todoId: todo.id,
                completed: !completed,
                text: todo.text,
              },
            },
          )
        }}>
        {React.string(completed ? "Uncomplete" : "Complete")}
      </button>
    } else {
      <button
        disabled=isRefetching
        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        onClick={_ => {
          setParams(
            ~navigationMode_=Replace,
            ~setter=c => {...c, showMore: Some(true)},
            ~onAfterParamsSet=_ => {
              startTransition(() => {
                refetch(
                  ~variables=TodoFragment.makeRefetchVariables(~showMore=Some(true)),
                )->RescriptRelay.Disposable.ignore
              })
            },
          )
        }}>
        {React.string("Show more")}
      </button>
    }}
  </div>
}
