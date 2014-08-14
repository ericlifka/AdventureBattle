LoadController = Ember.ArrayController.extend
    actions:
        newGameForm: ->
            name = @get 'newGameName'
            if not name
                @set 'hasError', true
                return

            @set 'hasError', false
            save = @store.createRecord 'save', { name }
            save.save().then =>
                @set 'newGameName', ''
#                @transitionToRoute 'index'

`export default LoadController`
