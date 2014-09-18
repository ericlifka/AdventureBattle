window.AdventureBattle = class AdventureBattle
    constructor: ->

    start: ->
        Authorization.requestSession().then (player) =>
            if player
                @setupGame()
            else
                DomView.showLogin()

    setupGame: ->
