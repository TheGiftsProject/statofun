RC.module "Admin.Map", (Module, RC) ->

  class Module.Controller extends Backbone.Marionette.Controller

    initialize: ->
      @events = new Module.Events()
      @time   = new Module.Time()

    onStart: ->
      @_setBodyStylesForMap()
      @map = new Module.MapView(events: @events, model: @time)
      google.maps.event.addDomListener(window, 'load', => @_fetchEvents())

    _fetchEvents: ->
      @loadingView = new Module.LoadingView()
      @events.fetch(success: (=> @_showEvents()), error: (=> @_showError()))

    _showEvents: ->
      @loadingView.close()
      @_showControlUI()
      @_startTimeline()
      @bindTo(@time, 'done', @_refresh, @)

    _showControlUI: ->
      new Module.ClockView(model: @time, timezone: 'pst', timezoneOffset: 0)
      new Module.ClockView(model: @time, timezone: 'est', timezoneOffset: 3)
      new Module.ControlsView(model: @time)
      new Module.LegendView() unless @options.no_legend

    _showError: ->
      @loadingView.error()

    _startTimeline: ->
      if @events.any()
        @time.start(@events.first().get('time'))
      else
        @events.on('reset', => @time.start())

    _refresh: ->
      setTimeout(RC.Browser.refresh, 5000)

    _setBodyStylesForMap: ->
      $('html').css('height', '100%')
      $('body').css(
        'height': '100%'
        'margin': '0'
        'padding': '0'
      )