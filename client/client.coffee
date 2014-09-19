window.AdventureBattle = class AdventureBattle
    viewport: null
    player: null

    constructor: (viewport) ->
        @viewport = $(viewport)
        DomView.setupContext @viewport

    start: ->
        authenticated = (player) =>
            @player = player
            @setupGame()

        Authorization.requestSession()
            .then authenticated
            .catch -> DomView.showLogin()
                .then authenticated

    setupGame: ->
