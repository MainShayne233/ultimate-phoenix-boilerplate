import '../css/app.scss'
import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import { AppContainer } from 'react-hot-loader'
import App from './ui/app'

const root = document.getElementById('root')

const render = () => {
  ReactDOM.render(
    <AppContainer>
      <App />
    </AppContainer>,
    root
  )
}

render()

if (module.hot) module.hot.accept('./ui/app', render)
