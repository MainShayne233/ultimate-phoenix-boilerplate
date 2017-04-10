import React, { Component } from 'react'
import { render } from 'react-dom'
import { 
  Router, 
  Route, 
  browserHistory  
} from 'react-router'


class App extends Component {

  render() {
    return (
      <div>
        App
      </div>
    )
  }
}

export default function renderApp() {
  const root = document.getElementById('root')
  const app = React.createElement(App)

  render(app, root)
}

