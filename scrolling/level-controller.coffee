level_descriptions = level_descriptions or { }

class LevelController
    constructor: (@player) ->
        @stage = new PIXI.Stage 0xf5f5f5

    load: (levelIdentifier) ->
        @description = level_descriptions[levelIdentifier]
        @setInitialPlayerPosition()

    update: (elapsedTime) ->

    render: (renderer) ->
        renderer.render @stage

    setInitialPlayerPosition: ->
        @player.jumpToPosition @description.startingPosition
