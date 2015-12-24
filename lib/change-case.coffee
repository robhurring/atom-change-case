ChangeCase = require 'change-case'
kebabCase = require 'lodash.kebabcase'

Commands =
  camel: 'camelCase'
  constant: 'constantCase'
  dot: 'dotCase'
  kebab: 'kebabCase'
  lower: 'lowerCase'
  lowerFirst: 'lowerCaseFirst'
  param: 'paramCase'
  pascal: 'pascalCase'
  path: 'pathCase'
  sentence: 'sentenceCase'
  snake: 'snakeCase'
  switch: 'switchCase'
  title: 'titleCase'
  upper: 'upperCase'
  upperFirst: 'upperCaseFirst'

module.exports =
  activate: (state) ->
    for command of Commands
      makeCommand(command)

makeCommand = (command) ->
  atom.commands.add 'atom-workspace', "change-case:#{command}", ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    method = Commands[command]
    converter = ChangeCase[method]
    converter = kebabCase if Commands.kebab == method

    for selection in editor.getSelections()
      range = selection.getBufferRange()
      text = editor.getTextInBufferRange(range)
      newText = converter(text)
      editor.setTextInBufferRange(range, newText)
