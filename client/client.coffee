window.AdventureBattle = class AdventureBattle
    assetPaths: ['static/assets/wall.json', 'static/assets/32x32_map_tile v3.1.json']
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

        slice1 = PIXI.Sprite.fromFrame("edge_01").texture
        slice2 = PIXI.Sprite.fromFrame("step_01").texture
        clip = new PIXI.MovieClip [slice1, slice2]
        clip.gotoAndPlay 0
        clip.animationSpeed = .1

        clip.position.x = 32
        clip.position.y = 64

        grass1 = PIXI.Sprite.fromFrame "grass_01"
        grass1.position.x = 200
        grass1.position.y = 64

        @stage.addChild clip
        @stage.addChild grass1

    nextAnimationFrame: ->
        @renderer.render @stage
#        @slice1.position.x += 1
        console.log 'frame'