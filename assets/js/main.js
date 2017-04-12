import '../css/app.less';
import React, { Component } from 'react';
import { AppContainer } from 'react-hot-loader';
import ReactDOM from 'react-dom';
import App from './ui/app';

const root = document.getElementById('root')
const render = Component =>
  ReactDOM.render(
    <AppContainer>
      <Component />
    </AppContainer>,
    root
  );

render(App)
if (module.hot) module.hot.accept('./ui/app', () => render(App));
