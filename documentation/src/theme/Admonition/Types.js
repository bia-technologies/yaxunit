
import React from 'react';
import DefaultAdmonitionTypes from '@theme-original/Admonition/Types';

function BadAdmonition(props) {
    return (
        <div class="theme-admonition alert--bad">
          <p class='admonition-header'>{props.title??'Плохо'}</p>
          <div>{props.children}</div>
        </div>
      );
  }

  function GoodAdmonition(props) {
    return (
      <div class="theme-admonition alert--good">
        <p class='admonition-header'>{props.title??'Лучше'}</p>
        <div>{props.children}</div>
      </div>
    );
  }
    
const AdmonitionTypes = {
  ...DefaultAdmonitionTypes,

  // Add all your custom admonition types here...
  // You can also override the default ones if you want
  'bad': BadAdmonition,
  'good': GoodAdmonition,
};

export default AdmonitionTypes;