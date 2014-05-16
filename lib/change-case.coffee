ChangeCase = require 'change-case'

Commands =
  camel: 'camelCase'
  constant: 'constantCase'
  dot: 'dotCase'
  lower: 'lowerCase'
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

    updateCurrentWord editor, (word) ->
      converter(word)

updateCurrentWord = (editor, callback) ->
  selection = editor.getSelection()

  text = selection.getText()

  # make sure we have a current selection
  if text
    newText = callback(text)
    selection.insertText(newText)
