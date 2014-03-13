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
  currentSelection = editor.getSelectedBufferRange()

  # make sure we have a current selection
  if currentSelection.start != currentSelection.end
    word = editor.getSelectedText()
    newWord = callback(word)

    editor.setTextInBufferRange(currentSelection, newWord)
    editor.moveCursorToEndOfWord()
