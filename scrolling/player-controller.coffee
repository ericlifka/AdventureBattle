class PlayerController
    hitBoxHeight: 64 * 2
    hitBoxWidth: 64 * 1

    # These represent the upper left corner of the hit box
    xPosition: 0
    yPosition: 0

    xVelocity: 0
    yVelocity: 0

    hitBox: null

    constructor: ->

    jumpToPosition: (position) ->
        @xPosition = position.x
        @yPosition = position.y - @hitBoxHeight

    addToStage: (stage) ->
        @hitBox = new PIXI.Graphics()
        @hitBox.beginFill 0xFF0000
        @hitBox.drawRect @xPosition, @yPosition, @hitBoxWidth, @hitBoxHeight

        stage.addChild @hitBox

    moveRight: ->
        @xVelocity += 1
        @capVelocity()

    moveLeft: ->
        @xVelocity -= 1
        @capVelocity()

    slow: ->
        if @xVelocity < 0
            @xVelocity += 1

        else if @xVelocity > 0
            @xVelocity -= 1

    capVelocity: ->
        if @xVelocity < -4
            @xVelocity = -4

        if @xVelocity > 4
            @xVelocity = 4

    update: ->
        @hitBox.position.x += @xVelocity
