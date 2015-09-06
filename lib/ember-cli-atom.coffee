EmberCliAtomView = require './ember-cli-atom-view'
{CompositeDisposable} = require 'atom'

module.exports = EmberCliAtom =
  emberCliAtomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @emberCliAtomView = new EmberCliAtomView(state.emberCliAtomViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @emberCliAtomView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ember-cli-atom:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @emberCliAtomView.destroy()

  serialize: ->
    emberCliAtomViewState: @emberCliAtomView.serialize()

  toggle: ->
    console.log 'EmberCliAtom was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
