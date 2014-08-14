LoadRoute = Ember.Route.extend
    model: ->
        @store.findAll 'save'

`export default LoadRoute`
