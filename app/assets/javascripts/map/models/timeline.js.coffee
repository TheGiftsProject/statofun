class Backbone.Timeline extends Backbone.Model

  # Add description.
  #
  # Noteable Events:
  #   'change:currentTime' - The 'currentTime' has changed (happens after every tick).
  #   'change:running'     - The running status of the timeline has changed (timeline started or stopped).
  #   'ended'              - 'currentTime' reached the timeline's end ('endTime').

  defaults:
    currentTime: null   # Current time, a 'moment' object. If not given at creation, uses the 'startTime' property.
    startTime:   null   # The time at the timeline beginning, a 'moment' object.
    endTime:     null   # The time at the timeline end, a 'moment' object.

    running:      false # Is the timeline running or not?
    tickInterval: 1000  # Interval between ticks in milliseconds.

    timePerTick:        # How much time passes every tick (timeUnit x units).
      timeUnit: 's'     #   Time unit in 'moment' form (ms, s, m, h, d, w, etc).
      units:     1      #   How much of the time unit passes every tick.


  initialize: ->
    throw 'Must set a `startTime` option at creation.' if not @get('startTime')
    throw 'Must set an `endTime` option at creation.'  if not @get('endTime')

    _.bind(@tick, @)

    # Set the 'currentTime' as the 'startTime' if a 'currentTime' option is not given at creation.
    @set('currentTime', @get('startTime')) unless @get('currentTime')

    @on('change:running', @tick)
    @on('change:currentTime', @afterTick)


  # Stops/pauses the timeline.
  stop: ->
    @set('running', false)


  # Stars/resumes the timeline.
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


  # Increases the 'currentTime' by the 'timePerTick' attribute
  #   options
  #     force - If set to 'true', ticks even if the timeline isn't running.
  tick: (options = {force: false}) ->
    return unless @get('isRunning') || options.force

    timePerTick = @get('timePerTick')
    currentTime = @get('current')
    endTime = @get('endTime')
    newTime = currentTime.add(timePerTick.timeUnit, timePerTick.units)
    newTime = endTime.clone() if newTime > endTime

    @set('currentTime', newTime)

  afterTick: ->
    if @get('currentTime') == @get('endTime')
      @trigger('ended')
    else
      _.delay(@tick, @get('tickInterval'))


  # Changes the tick interval.
  #   interval - The tick interval in milliseconds.
  changeInterval: (interval) ->
    @stop()
    @set('tickInterval', interval)
    @start()


  # Changes the time per tick configuration of the timeline (how much time passes every tick).
  #   timeUnit - Time unit in 'moment' form (ms, s, m, h, d, w, etc).
  #   units    - How much of the time unit passes every tick.
  changeTimePerTick: (timeUnit, units) ->
    @stop()
    @set('timePerTick', {timeUnit: timeUnit, units: units})
    @start()