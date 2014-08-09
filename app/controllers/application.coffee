ApplicationController = Ember.Controller.extend
    game: null

    gameLoaded: Ember.computed 'game', ->
        !!@get 'game'

`export default ApplicationController`
