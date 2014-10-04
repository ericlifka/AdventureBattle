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
        # Shore
        @stage.addChild @setPosition 4, 0, @animatedTexture "A24", "K24"
        @stage.addChild @setPosition 0, 1, @animatedTexture "A23", "K23"
        @stage.addChild @setPosition 1, 1, @animatedTexture "B23", "L23"
        @stage.addChild @setPosition 2, 1, @animatedTexture "B23", "L23"
        @stage.addChild @setPosition 3, 1, @animatedTexture "B23", "L23"
        @stage.addChild @setPosition 4, 1, @animatedTexture "I25", "S25"
        @stage.addChild @setPosition 0, 2, @animatedTexture "A24", "K24"
        @stage.addChild @setPosition 0, 3, @animatedTexture "A27", "K27"
        @stage.addChild @setPosition 1, 3, @animatedTexture "E25", "O25"
        @stage.addChild @setPosition 2, 3, @animatedTexture "I20", "S20"
        @stage.addChild @setPosition 2, 4, @animatedTexture "D25", "N25"
        @stage.addChild @setPosition 3, 4, @animatedTexture "E25", "O25"
        @stage.addChild @setPosition 4, 4, @animatedTexture "E25", "O25"
        @stage.addChild @setPosition 5, 4, @animatedTexture "E25", "O25"
        # Water
        @stage.addChild @setPosition 5, 0, @animatedTexture "D22", "N22"
        @stage.addChild @setPosition 5, 1, @animatedTexture "D22", "N22"
        @stage.addChild @setPosition 1, 2, @animatedTexture "D22", "N22"
        @stage.addChild @setPosition 2, 2, @animatedTexture "D22", "N22"
        @stage.addChild @setPosition 3, 2, @animatedTexture "D22", "N22"
        @stage.addChild @setPosition 4, 2, @animatedTexture "D22", "N22"
        @stage.addChild @setPosition 5, 2, @animatedTexture "D22", "N22"
        @stage.addChild @setPosition 3, 3, @animatedTexture "D22", "N22"
        @stage.addChild @setPosition 4, 3, @animatedTexture "D22", "N22"
        @stage.addChild @setPosition 5, 3, @animatedTexture "D22", "N22"
        # Grass
        @stage.addChild @setPosition 0, 0, @texture "B03"
        @stage.addChild @setPosition 1, 0, @texture "B03"
        @stage.addChild @setPosition 2, 0, @texture "B03"
        @stage.addChild @setPosition 3, 0, @texture "B03"
        @stage.addChild @setPosition 0, 6, @texture "B03"
        @stage.addChild @setPosition 1, 6, @texture "B03"
        @stage.addChild @setPosition 2, 6, @texture "B03"
        @stage.addChild @setPosition 3, 6, @texture "B03"
        @stage.addChild @setPosition 4, 6, @texture "B03"
        @stage.addChild @setPosition 5, 6, @texture "B03"
        # Sand Grass
        @stage.addChild @setPosition 5, 5, @texture "E08"
        @stage.addChild @setPosition 4, 5, @texture "E08"
        @stage.addChild @setPosition 3, 5, @texture "E08"
        @stage.addChild @setPosition 2, 5, @texture "E08"
        @stage.addChild @setPosition 1, 5, @texture "E08"
        @stage.addChild @setPosition 0, 5, @texture "D08"
        @stage.addChild @setPosition 0, 4, @texture "D07"
        # Sand
        @stage.addChild @setPosition 1, 4, @texture "E07"


        @startGameLoop()

#        slice1 = PIXI.Sprite.fromFrame("edge_01").texture
#        slice2 = PIXI.Sprite.fromFrame("step_01").texture
#        clip = new PIXI.MovieClip [slice1, slice2]
#        clip.gotoAndPlay 0
#        clip.animationSpeed = .1
#
#        clip.position.x = 32
#        clip.position.y = 64
#
#        grass1 = PIXI.Sprite.fromFrame "U14"
#        grass1.position.x = 200
#        grass1.position.y = 64
#
#        @stage.addChild clip
#        @stage.addChild grass1

    setPosition: (x, y, texture) ->
        texture.position.x = x * 32
        texture.position.y = y * 32
        texture

    animatedTexture: (texture1, texture2) ->
        frame1 = PIXI.Sprite.fromFrame(texture1).texture
        frame2 = PIXI.Sprite.fromFrame(texture2).texture
        texture = new PIXI.MovieClip [frame1, frame2]
        texture.gotoAndPlay 0
        texture.animationSpeed = .1
        texture

    texture: (texture) ->
        PIXI.Sprite.fromFrame texture

    startGameLoop: ->
        browserFrameHook = =>
            @nextAnimationFrame()
            requestAnimationFrame browserFrameHook

        requestAnimationFrame browserFrameHook

    nextAnimationFrame: ->
        @renderer.render @stage
#        @slice1.position.x += 1
        console.log 'frame'