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
                    images: {
                        icon: "/pokemon/charizard/icon.png"
                    }
                }
                {
                    name: "Squirtle"
                    type: "squirtle"
                    battleStats: {
                        speed: 43
                    }
                    images: {
                        icon: "/pokemon/squirtle/icon.png"
                    }
                }
            ]

`export default ApplicationRoute`
