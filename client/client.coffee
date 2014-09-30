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
            .catch ->
                DomView.showLogin().then authenticated

    setupGame: ->
        @setupPixi()
        @setupConnection()
        @startGameLoop()

    setupPixi: ->
        @stage = new PIXI.Stage 0xf5f5f5
        @renderer = new PIXI.WebGLRenderer 1024, 576
        @viewport.append @renderer.view

    setupConnection: ->
        @socket = io.connect 'http://localhost:5000'
#        window.setInterval ( =>
#            console.log 'emitting'
#            @socket.emit 'test-event'
#        ), 500
#        @socket.on 'server-event', (msg) ->
#            console.log "message received", msg

    startGameLoop: ->