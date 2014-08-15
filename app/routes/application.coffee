`import TurnOrder from '../models/turn-order'`

ApplicationRoute = Ember.Route.extend
    beforeModel: ->
        if not @game.active
            @transitionTo 'load'

    actions:
        willTransition: ->
            if not @game.active
                @transitionTo 'load'

        gameLoaded: ->
            @transitionTo 'index'

`export default ApplicationRoute`
