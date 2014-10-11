level_descriptions = level_descriptions or { }

class LevelController
    constructor: (@player) ->

    load: (levelIdentifier) ->
        @description = level_descriptions[levelIdentifier]
        @setInitialPlayerPosition()

    setInitialPlayerPosition: ->
        @player.jumpToPosition @description.startingPosition
