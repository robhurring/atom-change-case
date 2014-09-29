{WorkspaceView} = require 'atom'

describe "changing case", ->
  [editorView, editor, buffer] = []

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    atom.workspaceView.attachToDom()

    waitsForPromise ->
      atom.workspace.open('sample.js')

    waitsForPromise ->
      atom.packages.activatePackage('change-case')

    runs ->
      editorView = atom.workspaceView.getActiveView()
      editor = editorView.getModel()
      buffer = editor.getBuffer()

  describe "when empty editor", ->
    it "should do nothing", ->
      editor.setText ''
      atom.workspaceView.trigger 'change-case:camel'
      expect(editor.getText()).toBe ''

  describe "when text is selected", ->
    it "should camelcase selected text", ->
      editor.setText 'WorkspaceView'
      editor.moveToBottom()
      editor.selectToTop()
      editor.selectAll()
      atom.workspaceView.trigger 'change-case:camel'
      expect(editor.getText()).toBe 'workspaceView'
