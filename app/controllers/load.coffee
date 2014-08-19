LoadController = Ember.ArrayController.extend
    actions:
        gameListItemClicked: (id) ->
            @store.find 'save', id
                .then (save) =>
                    @game.set 'loadedTrainerModel', save
                    @send 'gameLoaded'

        newGameForm: ->
            name = @get 'newGameName'
            if not name
                @set 'hasError', true
                return

            @set 'hasError', false
            trainer = @store.createRecord 'trainer', { name }
            trainer.save().then =>
                @set 'newGameName', ''
                @game.set 'loadedTrainerModel', trainer
                @send 'gameLoaded'

`export default LoadController`
