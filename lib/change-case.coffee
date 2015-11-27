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
  atom.commands.add 'atom-workspace', "change-case:#{command}", ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    method = Commands[command]
    converter = ChangeCase[method]

    editor.mutateSelectedText (selection) ->
      range = selection.getBufferRange()
      if selection.isEmpty()
        selection.selectWord()

      text = selection.getText()
      newText = converter(text)
      selection.deleteSelectedText()
      selection.insertText(newText)

      selection.setBufferRange(range)
