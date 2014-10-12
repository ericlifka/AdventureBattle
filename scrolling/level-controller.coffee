level_descriptions = level_descriptions or { }

class LevelController
    player: null
    stage: null

    constructor: (@player) ->
        @stage = new PIXI.Stage 0xf5f5f5

    load: (levelIdentifier) ->
        @description = level_descriptions[levelIdentifier]
        @setInitialPlayerPosition()

        @addPlatformsToStage()
        @player.addToStage @stage

    update: (elapsedTime, inputState) ->
        if inputState.right
            @player.moveRight()

        else if inputState.left
            @player.moveLeft()

        else
            @player.slow()

        @player.update elapsedTime

    getStage: ->
        @stage

    setInitialPlayerPosition: ->
        @player.jumpToPosition @description.startingPosition

    addPlatformsToStage: ->
        for {start, end, height} in @description.platforms
            platform = new PIXI.Graphics()
            platform.beginFill 0x000000
            platform.drawRect start, height, end - start, 5
            @stage.addChild platform
