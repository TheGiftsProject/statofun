class Backbone.Timeline extends Backbone.Model

  # Add description.
  #
  # Events:
  #   'change:currentTime' - The 'currentTime' has changed (happens after every tick).
  #   'change:running'     - The running status of the timeline has changed (timeline started or stopped).
  #   'ended'              - 'currentTime' reached the timeline's end ('endTime').

  defaults:
    currentTime: null   # Current time, a 'moment' object. If not given at creation, uses the 'startTime' property.
    startTime:   null   # The time at the timeline beginning, a 'moment' object.
    endTime:     null   # The time at the timeline end, a 'moment' object.

    loop:         false # Whether to restart the timelime once it ended.
    running:      false # Is the timeline running or not?
    tickInterval: 1000  # Interval between ticks in milliseconds.

    timePerTick:        # How much time passes every tick (timeUnit x units).
      timeUnit: 's'     #   Time unit in 'moment' form (ms, s, m, h, etc)
      units:     1      #   How much of the time unit passes every tick.

  initialize: ->
    throw 'Must set a `startTime` option at creation.' if not @get('startTime')
    throw 'Must set an `endTime` option at creation.'  if not @get('endTime')

    _.bind(@tick, @)
    @set('currentTime', @get('startTime'))
    @on('change:running', @tick)

  # Stops/pauses the timeline.
  stop: ->
    @set('running', false)

  # Stars/resumes the timeline
  start: ->
    @set('running', true)

  # Sets the 'currentTime' to a different time.
  #   time - The time to jump to. A 'moment' object.
  jumpTo: (time) ->
    if time < @get('startTime') or time > @get('endTime')
      throw "New time (#{time.format()}) must be " +
            "between the start time (#{@get('startTime').format()}) " +
            "and the end time (#{@get('endTime').format()})."

    @stop()
    @set('currentTime', time.clone())
    @start()

  # Increases the 'currentTime' by how
  tick: ->
    return unless @get('isRunning')


    # add time but maximum of end timeline.
    # use loop.
    newTime = @get('current').add(@INTERVAL_CONFIG.time, @INTERVAL_CONFIG.interval)
    @set('current', )
    @msSinceSOD   = @get('current').diff(@get('current').sod())
    @msSinceStart = @get('current').diff(@startTime)
    if @_didDayEnd()
      @trigger('done')
    else
      _.delay(@tick, @interval)

  changeInterval: (interval) ->
    @stop()
    @set('tickInterval', interval)
    @start()

  changeTimePerTick: (timeUnit, units) ->
    @stop()
    @set('timePerTick', {timeUnit: timeUnit, units: units})
    @start()