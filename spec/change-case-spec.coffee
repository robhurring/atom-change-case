describe "changing case", ->
  [workspaceView, editor] = []

  beforeEach ->
    waitsForPromise ->
      atom.workspace.open('sample.js')

    waitsForPromise ->
      atom.packages.activatePackage('change-case')

    runs ->
      workspaceView = atom.views.getView(atom.workspace)
      editor = atom.workspace.getActiveTextEditor()
      editor.selectAll();
      editor.backspace();

  describe "when empty editor", ->
    it "should do nothing", ->
      editor.setText ''
      atom.commands.dispatch(workspaceView, 'change-case:camel')
      expect(editor.getText()).toBe ''

  describe "when text is selected", ->
    it "should camelcase selected text", ->
      editor.setText 'WorkspaceView'
      editor.moveToBottom()
      editor.selectToTop()
      editor.selectAll()
      atom.commands.dispatch(workspaceView, 'change-case:camel')
      expect(editor.getText()).toBe 'workspaceView'
