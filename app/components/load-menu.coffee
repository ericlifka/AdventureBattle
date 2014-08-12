LoadMenuComponent = Ember.Component.extend
    gameList: Ember.computed ->
        [
            {name: 'Eric', id: "1"}
            {name: 'Nicole', id: "2"}
            {name: 'Peter', id: "3"}
        ]

    actions:
        newGameForm: ->
            @sendAction 'new', @get 'newGameName'

        gameListItemClicked: (game) ->
            @sendAction 'load', game

`export default LoadMenuComponent`
