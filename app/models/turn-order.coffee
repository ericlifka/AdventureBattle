TurnOrder = Ember.Object.extend
    participants: null

    frames: Ember.computed -> []

    whoIsNext: ->
        null

    nextTurn: ->
        null

    init: ->
        participants = @get 'participants'
        Ember.assert "turn-order requires participants array", participants
        Ember.assert("turn-order requires battleStats.speed", pokemon.battleStats.speed?) for pokemon in participants

        @_generateInternalData()
        @_sortBySpeed()
        @_calculateMultipliers()
        @_buildNextFrame()
        debugger

    _generateInternalData: ->
        @_participants = ( {pokemon} for pokemon in @get 'participants' )

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

    _buildNextFrame: ->
        frame = []
        _.each @_participants, (p) =>
            if @_shouldParticipantInNextFrame p
                frame.push p
            p.currentFrame++

        @get('frames').pushObject frame

    _shouldParticipantInNextFrame: (participant) ->
        frame = participant.currentFrame
        multiplier = participant.multiplier

        offset = frame / multiplier
        low_offset = Math.floor offset
        high_offset = Math.ceil offset

        low_bound = Math.round(low_offset * multiplier)
        high_bound = Math.round(high_offset * multiplier)

        return frame is low_bound or frame is high_bound

`export default TurnOrder`
