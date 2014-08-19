GameService = Ember.Object.extend
    loadedTrainerModel: null
    active: Ember.computed 'loadedTrainerModel', ->
        !!@get 'loadedTrainerModel'

`export default GameService`
