RC.module "Admin.Map", (Module, RC) ->

  class Module.LegendView extends Backbone.Marionette.ItemView
    template:  'admin/map/templates/legend'
    className: 'legend map'

    ui:
      tab: '.tab'

    events:
      'click .tab' : '_clickedTab'

    initialize: ->
      @isHidden = false
      @render()
      @show()

    show: ->
      $('body').append(@$el)

    _clickedTab: ->
      @isHidden = !@isHidden
      @ui.tab.toggleClass('closed', @isHidden)
      @$el.animate({left: "#{if @isHidden then -150 else -10}px"})


