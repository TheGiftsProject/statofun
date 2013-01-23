RC.module "Admin.Map", (Module, RC) ->

  class Module.Time extends Backbone.Model

    defaults:
      current: null

    MILLISECONDS_PER_DAY: 86400000

    NORMAL_SPEED_INTERVAL: 30
    FAST_SPEED_INTERVAL  : 6

    INTERVAL_CONFIG:
      time: 's'
      interval: 12

    initialize: ->
      @interval = @NORMAL_SPEED_INTERVAL
      @running = false

    stop: ->
      @running = false

    start: (@startTime) ->
      @set('current', @startTime.clone())
      @running = true
      @tick()

    tick: =>
      @set('current', @get('current').add(@INTERVAL_CONFIG.time, @INTERVAL_CONFIG.interval))
      @msSinceSOD   = @get('current').diff(@get('current').sod())
      @msSinceStart = @get('current').diff(@startTime)
      @trigger('tick')
      if @_didDayEnd()
        @trigger('done')
      else if @running
        setTimeout(@tick, @interval)

    pause: ->
      @running = false

    resume: ->
      @running = true
      @tick()

    goNormal: ->
      @interval = @NORMAL_SPEED_INTERVAL
      @resume() unless @running

    goFast: ->
      @interval = @FAST_SPEED_INTERVAL
      @resume() unless @running

    _didDayEnd: ->
      @msSinceStart >= @MILLISECONDS_PER_DAY
