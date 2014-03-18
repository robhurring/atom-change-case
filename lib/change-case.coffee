ChangeCase = require 'change-case'

Commands =
  camel: 'camelCase'
  snake: 'snakeCase'
  dot: 'dotCase'
  param: 'paramCase'
  path: 'pathCase'
  constant: 'constantCase'

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
