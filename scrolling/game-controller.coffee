window.GameController = class GameController
    constructor: (@viewport) ->
        @stage = new PIXI.Stage 0xf5f5f5
        @renderer = new PIXI.WebGLRenderer 1024, 576
        @viewport.append @renderer.view

    start: ->
        browserFrameHook = =>
            @nextAnimationFrame()
            requestAnimationFrame browserFrameHook

        requestAnimationFrame browserFrameHook

    nextAnimationFrame: ->
        @renderer.render @stage
