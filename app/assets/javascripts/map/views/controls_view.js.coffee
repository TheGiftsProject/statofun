RC.module "Admin.Map", (Module, RC) ->

  class Module.ControlsView extends Backbone.Marionette.ItemView
    template: 'admin/map/templates/controls'
    className: 'controls'

    ui:
      buttons : ".button"

    events:
      "click .button" : "_toggleButtons"
      "click .pause"  : "_onPause"
      "click .play"   : "_onNormal"
      "click .ff"     : "_onFast"

    initialize: ->
      @render()
      @show()

    show: ->
      $('body').append(@$el)

    _onPause: ->
      @model.pause()

    _onNormal: ->
      @model.goNormal()

    _onFast: ->
      @model.goFast()

    _toggleButtons: (event) ->
      @ui.buttons.removeClass('active')
      $(event.currentTarget).addClass('active')
