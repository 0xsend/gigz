let renderer = Route__Root_route.makeRenderer(
  ~prepare=({environment}) => (),
  ~render=props => {
    <Layout />
  },
)
