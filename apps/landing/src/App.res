module Card = {
  @react.component
  let make = (~children) => {
    <div
      className="w-full md:max-w-[480px] bg-color12/10 md:my-auto h-[100svh] backdrop-blur-[56px] rounded-lg  p-6 flex flex-col justify-between ">
      {children}
    </div>
  }
}

@react.component
let make = () => {
  <div className="h-full w-full md:p-10">
    <Background />
    <div className="flex flex-col w-full h-full items-center md:items-start md:p-12">
      <Card>
        <div className="w-28 ">
          <Logo />
        </div>
        <div className="flex flex-col space-y-2">
          <h1 className="text-6xl font-bold font-sans font-blacs text-color12 uppercase leading-[56px] tracking-tight">
            {"A New Way to Create"->React.string}
          </h1>
          <p className="text-lg font-normal font-sans text-color3 ">
            {"Stay tuned for what's next"->React.string}
          </p>
        </div>
        <p className="text-xl font-bold font-mono text-color11 uppercase "> {"Coming Soon"->React.string} </p>
      </Card>
    </div>
  </div>
}
