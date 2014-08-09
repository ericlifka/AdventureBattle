LoadMenuComponent = Ember.Component.extend
    actions:
        newGameClicked: ->
            @sendAction 'new'

`export default LoadMenuComponent`
