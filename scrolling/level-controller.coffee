level_descriptions = level_descriptions or { }

class LevelController
    constructor: ->

    load: (levelIdentifier) ->
        @description = level_descriptions[levelIdentifier]
