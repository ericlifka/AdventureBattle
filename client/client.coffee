window.AdventureBattle = class AdventureBattle
    assetPaths: ['static/assets/32x32_map_tile v3.1.json']
    viewport: null
    player: null
    world: null

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

        @world = new World @stage

        loader = new PIXI.AssetLoader @assetPaths
        loader.onComplete = => @setupTextures()
        loader.load()

    setupConnection: ->
        @socket = io.connect 'http://localhost:5000'
#        window.setInterval ( =>
#            console.log 'emitting'
#            @socket.emit 'test-event'
#        ), 500
#        @socket.on 'server-event', (msg) ->
#            console.log "message received", msg

    setupTextures: ->
        @world.setup()
        @startGameLoop()

    startGameLoop: ->
        browserFrameHook = =>
            @nextAnimationFrame()
            requestAnimationFrame browserFrameHook

        requestAnimationFrame browserFrameHook

    nextAnimationFrame: ->
        @world.update()

        @renderer.render @stage