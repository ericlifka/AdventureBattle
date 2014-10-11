window.GameController = class GameController
    constructor: (@viewport) ->
        @stage = new PIXI.Stage 0xf5f5f5
        @renderer = new PIXI.WebGLRenderer 1024, 576
        @viewport.append @renderer.view

        @player = new PlayerController()
        @level = new LevelController(@player)
        @level.load "test-level"

    start: ->
        browserFrameHook = =>
            @nextAnimationFrame()
            requestAnimationFrame browserFrameHook

        @lastTimestamp = Date.now()
        requestAnimationFrame browserFrameHook

    nextAnimationFrame: ->
        elapsed = @elapsedSinceLastFrame()

        @renderer.render @stage

    elapsedSinceLastFrame: ->
        now = Date.now()
        elapsed = now - @lastTimestamp
        @lastTimestamp = now
        elapsed
