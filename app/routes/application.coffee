`import TurnOrder from '../models/turn-order'`

ApplicationRoute = Ember.Route.extend
    model: ->
        return TurnOrder.create {}

`export default ApplicationRoute`
