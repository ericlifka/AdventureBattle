GameService = Ember.Object.extend
    loadedGameModel: null
    active: Ember.computed 'loadedGameModel', ->
        !!@get 'loadedGameModel'

`export default GameService`
