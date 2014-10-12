class PlayerController
    hitBoxHeight: 64 * 2
    hitBoxWidth: 64 * 1

    # These represent the upper left corner of the hit box
    xPosition: 0
    yPosition: 0

    xVelocity: 0
    yVelocity: 0

    accelerationStep: 30
    accelerationCap: 7

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

    accelerateRight: (timeRatio) ->
        @xVelocity += @accelerationStep * timeRatio
        @capVelocity()

    accelerateLeft: (timeRatio) ->
        @xVelocity -= @accelerationStep * timeRatio
        @capVelocity()

    slow: (timeRatio) ->
        if @xVelocity < 0
            @xVelocity += @accelerationStep * timeRatio
            if @xVelocity > 0
                @xVelocity = 0

        else if @xVelocity > 0
            @xVelocity -= @accelerationStep * timeRatio
            if @xVelocity < 0
                @xVelocity = 0

    capVelocity: ->
        if @xVelocity < -@accelerationCap
            @xVelocity = -@accelerationCap

        if @xVelocity > @accelerationCap
            @xVelocity = @accelerationCap

    update: (elapsedTime, inputState) ->
        timeRatio = elapsedTime / 1000

        if inputState.right
            @accelerateRight timeRatio

        else if inputState.left
            @accelerateLeft timeRatio

        else
            @slow timeRatio

        @hitBox.position.x += @xVelocity
