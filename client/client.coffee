window.AdventureBattle = class AdventureBattle
    assetPaths: ['static/assets/wall.json']
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

    setupPixi: ->
        @stage = new PIXI.Stage 0xf5f5f5
        @renderer = new PIXI.WebGLRenderer 1024, 576
        @viewport.append @renderer.view

        loader = new PIXI.AssetLoader @assetPaths
        loader.onComplete = => @startGameLoop()
        loader.load()

    setupConnection: ->
        @socket = io.connect 'http://localhost:5000'
#        window.setInterval ( =>
#            console.log 'emitting'
#            @socket.emit 'test-event'
#        ), 500
#        @socket.on 'server-event', (msg) ->
#            console.log "message received", msg

    startGameLoop: ->
        browserFrameHook = =>
            @nextAnimationFrame()
            requestAnimationFrame browserFrameHook

        requestAnimationFrame browserFrameHook

        slice1 = PIXI.Sprite.fromFrame("edge_01")
        slice1.position.x = 32
        slice1.position.y = 64
        this.stage.addChild(slice1)

    nextAnimationFrame: ->
        @renderer.render @stage