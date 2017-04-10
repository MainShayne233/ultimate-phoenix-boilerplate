import React, { Component } from 'react'
import { render } from 'react-dom'
import App from './ui/app'

const root = document.getElementById('root')
const app = React.createElement(App)

render(app, root)

