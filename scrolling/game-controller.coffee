window.GameController = class GameController
    constructor: (@viewport) ->
        @input = new InputController()

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
        inputState = @input.getFrameState()

        @level.update elapsed, inputState
        @level.render @renderer

    elapsedSinceLastFrame: ->
        now = Date.now()
        elapsed = now - @lastTimestamp
        @lastTimestamp = now
        elapsed
