# Change Case Plugin
[![Build Status](https://travis-ci.org/robhurring/atom-change-case.svg)](https://travis-ci.org/robhurring/atom-change-case)
[![apm](https://img.shields.io/apm/v/change-case.svg)](https://atom.io/packages/change-case)

A wrapper around [node-change-case](https://github.com/blakeembrey/node-change-case) for atom.

A quick way to change the case of the current selection.

## Commands

* `change-case:camel`
* `change-case:constant`
* `change-case:dot`
* `change-case:lower`
* `change-case:lowerFirst`
* `change-case:param`
* `change-case:pascal`
* `change-case:path`
* `change-case:sentence`
* `change-case:snake`
* `change-case:swap`
* `change-case:title`
* `change-case:upper`
* `change-case:upperFirst`
* `change-case:kebab`

### Key Map

Edit your `keymap.cson` to add the commands you want. For example:

```cson
'atom-workspace':
  'ctrl-k ctrl-d': 'change-case:dot'
```
