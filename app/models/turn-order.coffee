TurnOrder = Ember.Object.extend
    participants: null

    nextTwentyTurns: Ember.computed -> []

    whoIsNext: ->
        null

    nextTurn: ->
        null

    init: ->
        Ember.assert "turn-order requires participants array", @participants
        Ember.assert("turn-order requires battleStats.speed", pokemon.battleStats.speed?) for pokemon in @participants

        @_generateInternalData()
        @_sortBySpeed()
        @_calculateMultipliers()
        debugger

    _generateInternalData: ->
        @_participants = ({pokemon} for pokemon in @participants)

    _sortBySpeed: ->
        @_participants = _.sortBy @_participants, (p) ->
            -p.pokemon.battleStats.speed

    _calculateMultipliers: ->
        fastestParticipant = _.max @_participants, (p) ->
            p.pokemon.battleStats.speed

        maxSpeed = fastestParticipant.pokemon.battleStats.speed

        _.each @_participants, (p) ->
            p.multiplier = maxSpeed / p.pokemon.battleStats.speed
            p.currentFrame = 0






`export default TurnOrder`
