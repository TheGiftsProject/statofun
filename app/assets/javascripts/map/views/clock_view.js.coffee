RC.module "Admin.Map", (Module, RC) ->

  class Module.ClockView extends Backbone.Marionette.ItemView
    template: 'admin/map/templates/clock'
    className: 'clock'

    ui:
      seconds:  '.seconds'
      minutes:  '.minutes'
      hours:    '.hours'
      part:     '.daypart'
      date:     '.date'
      timezone: '.timezone'

    modelEvents:
      'tick': 'tick'

    initialize: ->
      @render()
      @show()

    onRender: ->
      @ui.timezone.text(@options.timezone)
      @$el.addClass(@options.timezone)

    show: ->
      $('body').append(@$el)

    tick: ->
      time = @model.get('current').clone().add('h', @options.timezoneOffset)

      minutes = time.minutes() + time.seconds() / 60
      hours = time.hours() + minutes / 60

      @_rotateHand(@ui.minutes, 360 * (minutes / 60))
      @_rotateHand(@ui.hours, 360 * ((hours / 12) % 12))

      if hours < 12
        @_setText(@ui.part, 'AM')
      else
        @_setText(@ui.part, 'PM')

      @_setDate(time)

    _rotateHand: (hand, degrees) ->
      hand.css("-webkit-transform", "rotate(#{degrees}deg)")

    _setDate: (time) ->
      @_setText(@ui.date, time.format('MMM Do'))

    _setText: (element, text) ->
      element.text(text) if @ui.part.text() != text
