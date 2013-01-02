class window.Map
  constructor: ->
    @mapOptions =
      center: new google.maps.LatLng(32.074231, 34.785973)
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      zoom: 13,
      zoomControlOptions:
        style: google.maps.ZoomControlStyle.SMALL
      mapTypeControl: false
      panControl: false
      zoomControl: false
    @

  render: (el)->
    if el.jquery
      el = el.get(0)
    @map = new google.maps.Map(el, @mapOptions)
    @

  @show: ->
    new Map().render($("#map_canvas"))

#$(document).ready(-> google.maps.event.addDomListener(window, 'load', window.Map.show))