`import TurnOrder from '../models/turn-order'`

ApplicationRoute = Ember.Route.extend
    model: ->
        return TurnOrder.create
            participants: [
                {
                    name: "Charizzle"
                    type: "charizard"
                    battleStats: {
                        speed: 100
                    }
                }
                {
                    name: "Squirtle"
                    type: "squirtle"
                    battleStats: {
                        speed: 43
                    }
                }
            ]

`export default ApplicationRoute`
