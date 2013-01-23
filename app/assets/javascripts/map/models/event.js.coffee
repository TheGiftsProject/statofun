RC.module "Admin.Map", (Module, RC) ->

  class Module.Event extends Backbone.Model

    defaults:
      time: null
      site: null # stubhub | ebay
      type: null # visit | create | pay
      extra: null
      position: null # LngLtd

    parse: (data) ->
      parsed_data = super(data)
      parsed_data.position = new google.maps.LatLng(parsed_data.latitude, parsed_data.longitude)
      parsed_data.time = moment(parsed_data.time).add('m', moment().zone()).subtract('h', 8) # from UTC to PST
      parsed_data

    #====================================== VISUALIZATION ======================================#
    showEvent: (map)->
      icon = @icon()
      if icon
        marker = new google.maps.Marker(
          position: @get('position')
          animation: google.maps.Animation.DROP
          map: map
          icon: icon
          shadow: @shadow()
        )

    shadow: ->
      if @get('type') == "visit" then Module.Event.userShadow else null

    icon: ->
      switch @get('type')
        when "visit" then @userIcon()
        when "pay" then Module.Event.markers.actions.paid
        when "voted" then Module.Event.markers.actions.voted
        when "purchase" then Module.Event.markers.actions.purchased
        when "create" then @createIcon()
        else null

    userIcon: ->
      switch @get('site')
        when "redcup" then Module.Event.markers.users.redcup
        when "stubhub" then Module.Event.markers.users.stubhub
        when "ebay" then Module.Event.markers.users.ebay
        else null

    createIcon: ->
      if @get('site') == "redcup"
        Module.Event.markers.actions.created.wi
      else
        Module.Event.markers.actions.created.sp

    @markers:
      users:
        stubhub:  new google.maps.MarkerImage("/wi/assets/map/sp-user.png",new google.maps.Size(22, 23))
        ebay:     new google.maps.MarkerImage("/wi/assets/map/ebay-user.png",new google.maps.Size(22, 23))
        redcup:   new google.maps.MarkerImage("/wi/assets/map/wi-user.png",new google.maps.Size(22, 23))
      actions:
        paid:     new google.maps.MarkerImage("/wi/assets/map/paid.png",new google.maps.Size(20, 50))
        purchased:new google.maps.MarkerImage("/wi/assets/map/purchase.png",new google.maps.Size(29, 43))
        voted:    new google.maps.MarkerImage("/wi/assets/map/voted.png",new google.maps.Size(23, 45))
        created:
          sp:     new google.maps.MarkerImage("/wi/assets/map/create.png",new google.maps.Size(23, 45))
          wi:     new google.maps.MarkerImage("/wi/assets/map/redcup-create.png",new google.maps.Size(28, 48))
    @userShadow:  new google.maps.MarkerImage("/wi/assets/map/shadow.png",new google.maps.Size(50, 20))


  class Module.Events extends Backbone.Collection
    model: Module.Event
    url: '/wi/admin/map'