let renderer = Routes.Root.Sendtag.Route.makeRenderer(
  ~prepare=_ => {
    ()
  },
  ~render=_ => {
    React.null
  },
)