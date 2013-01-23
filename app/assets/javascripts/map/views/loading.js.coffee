RC.module "Admin.Map", (Module, RC) ->

  class Module.LoadingView extends Backbone.Marionette.ItemView
    template:  'admin/map/templates/loading'
    className: 'loading-overlay'

    initialize: ->
      @render()
      @show()

    show: ->
      $('body').append(@$el)

    error: ->
      @$el.find("h5").text("Error loading data")
      @$el.addClass("error")
