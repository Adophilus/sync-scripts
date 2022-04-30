#! /usr/bin/env node

const watch = require('node-watch')
const fs = require('fs')
const path = require('path')

const scripts = fs
  .readdirSync(path.join(__dirname, 'scripts'))
  .map((script) => require(`./scripts/${script}`))

/*
events: [ 'update', 'remove' ]
*/

watch(
  process.argv[2] || './',
  { recursive: true, filter: (f) => !/node_modules|\.git/.test(f) },
  function (event, filepath) {
    // console.log('%s changed.', name)
    scripts.forEach((script) => script(event, filepath))
  }
)
