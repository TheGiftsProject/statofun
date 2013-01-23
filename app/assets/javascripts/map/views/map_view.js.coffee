RC.module "Admin.Map", (Module, RC) ->

  class Module.MapView extends Backbone.Marionette.ItemView

    id: 'map'

    modelEvents:
      'tick': 'tick'

    initialize: ->
      @_initializeMap()
      @options.interval = @batch_interval
      $('.map-logo').click(=> @centerMap())
      @render()
      @show()
      @reset()

    reset: ->
      @eventsStack = []
      @count = 0

    show: ->
      $('body').append(@$el)

    tick: ->
      @showEventsOnTime()
      @setDayNight()

    showEventsOnTime: ->
      return unless @model.running
      if @count >= @options.events.length
        @model.stop()
        @model.trigger('done')
      else if @nextEventIsOn()
        while @count < @options.events.length && @nextEventIsOn()
          @eventsStack.push(@options.events.at(@count))
          @count++
        @showEvent(@eventsStack.shift())
      else if _.any(@eventsStack)
        @showEvent(@eventsStack.shift())

    nextEventIsOn: ->
      event = @options.events.at(@count)
      event.get('time') <= @model.get('current')

    showEvent: (event) ->
      event.showEvent(@map)

    setDayNight: ->
      @dayNightOverlay.setDate(@model.get('current').clone().add('h', 10).toDate()) # 10 due to timezone issues.

    centerMap: ->
      @map.panTo(@center)
      @map.setZoom(5)

    _initializeMap: ->
      styledMap = new google.maps.StyledMapType(@styles, name: "Live Map")
      @map = new google.maps.Map(@$el[0], @mapOptions())
      @map.mapTypes.set('map_style', styledMap)
      @map.setMapTypeId('map_style')

      @dayNightOverlay = new DayNightOverlay(
        map: @map
        date: moment().add('h',1).toDate()
      )

    #====================================== OPTIONS ======================================#
    center: new google.maps.LatLng(38.822591, -95.361328)

    mapOptions: ->
      center: @center
      zoom: 5
      disableDefaultUI: true
      mapTypeControlOptions:
        mapTypeIds: [google.maps.MapTypeId.TERRAIN]

    styles: [
      {
        featureType: "administrative.locality"
        elementType: "labels"
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "poi.park"
        elementType: "all"
        stylers: [
          { lightness: "20" }
        ]
      }
    ]
