ApplicationController = Ember.Controller.extend
    game: null

    gameLoaded: Ember.computed 'game', ->
        !!@get 'game'

    actions:
        newGame: ->
            console.log 'create new game'

        loadGame: (game) ->
            console.log 'load game', game.name, game.id

`export default ApplicationController`
