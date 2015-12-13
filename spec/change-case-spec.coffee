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

  describe "when text with more than one word is selected", ->
    it "should camelcase selected text", ->
      editor.setText 'the quick brown fox jumps over the lazy dog'
      editor.moveToBottom()
      editor.selectToTop()
      editor.selectAll()
      atom.commands.dispatch(workspaceView, 'change-case:camel')
      expect(editor.getText()).toBe 'theQuickBrownFoxJumpsOverTheLazyDog'

  describe "when text selection is empty", ->
    it "should change case of the word nearest to the cursor", ->
      editor.setText 'workspaceView'
      atom.commands.dispatch(workspaceView, 'change-case:upper')
      expect(editor.getText()).toBe 'WORKSPACEVIEW'

    it "should select the word nearest to the cursor", ->
      editor.setText 'workspaceView'
      atom.commands.dispatch(workspaceView, 'change-case:upper')
      expect(editor.getSelectedText()).toBe 'WORKSPACEVIEW'

  describe "when selected text length changes after changing its case", ->
    it "should modify selection range to fit new text", ->
      editor.setText 'workspace.view'
      editor.selectAll()

      atom.commands.dispatch(workspaceView, 'change-case:upper')
      expect(editor.getSelectedText()).toBe 'WORKSPACE.VIEW'

      atom.commands.dispatch(workspaceView, 'change-case:camel')
      expect(editor.getSelectedText()).toBe 'workspaceView'

      atom.commands.dispatch(workspaceView, 'change-case:dot')
      expect(editor.getSelectedText()).toBe 'workspace.view'

  describe "when there are multiple selections", ->
    it "should change case of each selection", ->
      editor.setText '''
      the quick brown fox
      jumps over the lazy dog
      '''
      editor.selectAll()
      editor.splitSelectionsIntoLines()

      atom.commands.dispatch(workspaceView, 'change-case:camel')

      expect(editor.lineTextForBufferRow(0)).toContain 'theQuickBrownFox'
      expect(editor.lineTextForBufferRow(1)).toContain 'jumpsOverTheLazyDog'

    it "should undo/redo changes in batch", ->
      editor.setText '''
      the quick brown fox
      jumps over the lazy dog
      '''
      editor.selectAll()
      editor.splitSelectionsIntoLines()

      atom.commands.dispatch(workspaceView, 'change-case:camel')

      expect(editor.lineTextForBufferRow(0)).toContain 'theQuickBrownFox'
      expect(editor.lineTextForBufferRow(1)).toContain 'jumpsOverTheLazyDog'

      editor.undo()

      expect(editor.lineTextForBufferRow(0)).toContain 'the quick brown fox'
      expect(editor.lineTextForBufferRow(1)).toContain 'jumps over the lazy dog'

      editor.redo()

      expect(editor.lineTextForBufferRow(0)).toContain 'theQuickBrownFox'
      expect(editor.lineTextForBufferRow(1)).toContain 'jumpsOverTheLazyDog'
