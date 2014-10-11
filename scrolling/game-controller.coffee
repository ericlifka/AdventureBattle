window.GameController = class GameController
    constructor: (@viewport) ->
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
        @level.update elapsed
        @level.render @renderer

    elapsedSinceLastFrame: ->
        now = Date.now()
        elapsed = now - @lastTimestamp
        @lastTimestamp = now
        elapsed
