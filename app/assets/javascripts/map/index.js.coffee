class Map
  constructor: (opts = {}) ->
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
    console.dir @mapOptions
    @map = new google.maps.Map(el, @mapOptions)
    @

  addMarker: (latLng) ->
    marker = new google.maps.Marker({
    position: latLng,
    map: @map,
    animation: google.maps.Animation.DROP
    })

  setMyLocation: (latLng) ->
    myloc = new google.maps.Marker({
    clickable: false,
    icon: new google.maps.MarkerImage('//maps.gstatic.com/mapfiles/mobile/mobileimgs2.png',
    new google.maps.Size(22, 22),
    new google.maps.Point(0, 18),
    new google.maps.Point(11, 11)),
    shadow: null,
    zIndex: 999,
    map: @map
    })
    myloc.setPosition(latLng)

  addEventListener: (eventType, handler) ->
    google.maps.event.addListener(@map, eventType, handler)
