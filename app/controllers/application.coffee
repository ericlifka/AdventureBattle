ApplicationController = Ember.Controller.extend
    game: null

    gameLoaded: Ember.computed 'game', ->
        !!@get 'game'

    notOnLoading: Ember.computed 'currentRouteName', ->
        'load' isnt @get 'currentRouteName'

    actions:
        newGame: ->
            console.log 'create new game'

        loadGame: (game) ->
            console.log 'load game', game.name, game.id

`export default ApplicationController`
