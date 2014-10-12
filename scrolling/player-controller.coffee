class PlayerController
    hitBoxHeight: 64 * 2
    hitBoxWidth: 64 * 1

    # These represent the upper left corner of the hit box
    xPosition: 0
    yPosition: 0

    xVelocity: 0
    yVelocity: 0

    accelerationStep: 0.2
    accelerationCap: 5

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

    accelerateRight: ->
        @xVelocity += @accelerationStep
        @capVelocity()

    accelerateLeft: ->
        @xVelocity -= @accelerationStep
        @capVelocity()

    slow: ->
        if @xVelocity < 0
            @xVelocity += @accelerationStep
            if @xVelocity > 0
                @xVelocity = 0

        else if @xVelocity > 0
            @xVelocity -= @accelerationStep
            if @xVelocity < 0
                @xVelocity = 0

    capVelocity: ->
        if @xVelocity < -@accelerationCap
            @xVelocity = -@accelerationCap

        if @xVelocity > @accelerationCap
            @xVelocity = @accelerationCap

    update: (elapsedTime, inputState) ->
        if inputState.right
            @accelerateRight()

        else if inputState.left
            @accelerateLeft()

        else
            @player.slow()

        @hitBox.position.x += @xVelocity
