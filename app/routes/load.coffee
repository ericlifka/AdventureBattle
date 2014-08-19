LoadRoute = Ember.Route.extend
    model: ->
        @store.findAll 'trainer'

`export default LoadRoute`
