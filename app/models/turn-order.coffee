TurnOrder = Ember.Object.extend
    participants: null

    init: ->
        Ember.assert "turn-order requires participants array", @participants
        Ember.assert("turn-order requires battleStats.speed", pokemon.battleStats.speed?) for pokemon in @participants

`export default TurnOrder`
