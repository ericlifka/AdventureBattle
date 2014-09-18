window.AdventureBattle = class AdventureBattle
    constructor: ->

    start: ->
        authenticated = (player) =>
            @player = player
            @setupGame()

        Authorization.requestSession()
            .then authenticated
            .catch =>
                DomView.showLogin().then authenticated

    setupGame: ->
