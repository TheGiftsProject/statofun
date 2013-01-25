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

    # Set the 'currentTime' as the 'startTime' if a 'currentTime' option is not given at creation.
    @set('currentTime', @get('startTime')) unless @get('currentTime')

    @on('change:running', @tick)


  # Stops/pauses the timeline.
  stop: ->
    clearTimeout(@tickTimeout) if @tickTimeout
    @set('running', false)


  # Stars/resumes the timeline.
  start: ->
    @set('running', true)


  # Increases the 'currentTime' by the 'timePerTick' attribute.
  # If 'currentTime' doesn't equal 'endTime' after the incrementation,
  # a timeout is set to call the 'tick' method again after the tick interval.
  tick: ->
    return unless @get('running')

    timePerTick = @get('timePerTick')
    currentTime = @get('currentTime')
    endTime = @get('endTime')
    newTime = currentTime.add(timePerTick.timeUnit, timePerTick.units)
    newTime = endTime.clone() if newTime > endTime

    @set('currentTime', newTime)
    console.log(@get('currentTime').format())

    if @get('currentTime') == @get('endTime')
      @trigger('ended')
    else
      @tickTimeout = setTimeout((=> @tick()), @get('tickInterval'))


  # Sets the 'currentTime' to a different time.
  #   time - The time to jump to. A 'moment' object.
  jumpTo: (time) ->
    if time < @get('startTime') or time > @get('endTime')
      throw "New time (#{time.format()}) must be " +
      "between the start time (#{@get('startTime').format()}) " +
      "and the end time (#{@get('endTime').format()})."

    @_pauseAndExecute(-> @set('currentTime', time.clone()))


  # Changes the tick interval.
  #   interval - The tick interval in milliseconds.
  changeInterval: (interval) ->
    @_pauseAndExecute(-> @set('tickInterval', interval))


  # Changes the time per tick configuration of the timeline (how much time passes every tick).
  #   timeUnit - Time unit in 'moment' form (ms, s, m, h, d, w, etc).
  #   units    - How much of the time unit passes every tick.
  changeTimePerTick: (timeUnit, units) ->
    @_pauseAndExecute(-> @set('timePerTick', {timeUnit: timeUnit, units: units}))


  # Pauses the timeline in order to call a function the shouldn't be run while the timeline is running.
  # Resumes the timeline after the code is executed.
  #   func - The function to run while the timeline is paused.
  _pauseAndExecute: (func) ->
    wasRunning = @get('running')

    @stop() if wasRunning
    func.call(@)
    @start() if wasRunning

