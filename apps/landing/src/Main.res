%%raw("import './index.css'")
%%raw("import '@fontsource/dm-sans/400.css'")
%%raw("import '@fontsource/dm-sans/700.css'")
%%raw("import '@fontsource/dm-mono/400.css'")


switch ReactDOM.querySelector("#root") {
| Some(domElement) =>
  ReactDOM.Client.createRoot(domElement)->ReactDOM.Client.Root.render(
    <React.StrictMode>
      <App/>
    </React.StrictMode>,
  )
| None => ()
}
