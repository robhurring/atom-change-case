ChangeCase = require 'change-case'

Commands =
  camel: 'camelCase'
  constant: 'constantCase'
  dot: 'dotCase'
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
  atom.workspaceView.command "change-case:#{command}", ->
    editor = atom.workspace.getActiveEditor()
    return unless editor?

    method = Commands[command]
    converter = ChangeCase[method]

    for selection in editor.getSelections()
      updateCurrentWord selection, (word) ->
        converter(word)

updateCurrentWord = (selection, callback) ->
  text = selection.getText()

  # make sure we have a current selection
  if text
    newText = callback(text)
    selection.insertText(newText)
