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

    options = {}
    options.wordRegex = /^[\t ]*$|[^\s\/\\\(\)"':,\.;<>~!@#\$%\^&\*\|\+=\[\]\{\}`\?]+/g

    selection = editor.getLastSelection()
    if selection.getText().length > 0
        text = selection.getText()
        newText = text.replace(options.wordRegex, converter)
        selection.insertText(newText)
    else
        for cursor in editor.getCursors()
          position = cursor.getBufferPosition()

          range = cursor.getCurrentWordBufferRange(options)
          text = editor.getTextInBufferRange(range)
          newText = converter(text)
          editor.setTextInBufferRange(range, newText)
