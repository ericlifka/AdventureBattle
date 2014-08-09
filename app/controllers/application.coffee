ApplicationController = Ember.Controller.extend
    game: null

    gameLoaded: Ember.computed 'game', ->
        !!@get 'game'

    actions:
        newGame: ->
            console.log 'create new game'

`export default ApplicationController`
