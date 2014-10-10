window.GameController = class GameController
    constructor: (@viewport) ->
        @stage = new PIXI.Stage 0xf5f5f5
        @renderer = new PIXI.WebGLRenderer 1024, 576

    start: ->
        @viewport.append @renderer.view
