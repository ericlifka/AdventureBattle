LoadController = Ember.ArrayController.extend
    actions:
        gameListItemClicked: (id) ->
            @store.find 'save', id
                .then (save) =>
                    @game.set 'loadedGameModel', save
                    @send 'gameLoaded'

        newGameForm: ->
            name = @get 'newGameName'
            if not name
                @set 'hasError', true
                return

            @set 'hasError', false
            save = @store.createRecord 'save', { name }
            save.save().then =>
                @set 'newGameName', ''
                @game.set 'loadedGameModel', save
                @send 'gameLoaded'

`export default LoadController`
