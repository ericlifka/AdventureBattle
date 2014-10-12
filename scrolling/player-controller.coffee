class PlayerController
    hitBoxHeight: 64 * 2
    hitBoxWidth: 64 * 1

    # These represent the upper left corner of the hit box
    xPosition: 0
    yPosition: 0

    xVelocity: 0
    yVelocity: 0

    jumpAcceleration: 500
    yAccelerationStep: 1000
    xAccelerationStep: 1000
    xAccelerationCap: 400

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

    update: (elapsedTime, inputState) ->
        timeRatio = elapsedTime / 1000

        if inputState.right
            @accelerateRight timeRatio
        else if inputState.left
            @accelerateLeft timeRatio
        else
            @slow timeRatio

        if inputState.jump and not @jumping
            @jumping = true
            @yVelocity += @jumpAcceleration

        if @jumping
            @accelerateDown timeRatio
            @checkFloorCollision timeRatio

        @updatePosition timeRatio

    accelerateRight: (timeRatio) ->
        @xVelocity += @xAccelerationStep * timeRatio
        @capVelocity()

    accelerateLeft: (timeRatio) ->
        @xVelocity -= @xAccelerationStep * timeRatio
        @capVelocity()

    accelerateDown: (timeRatio) ->
        @yVelocity -= @yAccelerationStep * timeRatio

    slow: (timeRatio) ->
        if @xVelocity < 0
            @xVelocity += @xAccelerationStep * timeRatio
            if @xVelocity > 0
                @xVelocity = 0

        else if @xVelocity > 0
            @xVelocity -= @xAccelerationStep * timeRatio
            if @xVelocity < 0
                @xVelocity = 0

    capVelocity: ->
        if @xVelocity < -@xAccelerationCap
            @xVelocity = -@xAccelerationCap

        if @xVelocity > @xAccelerationCap
            @xVelocity = @xAccelerationCap

    updatePosition: (timeRatio) ->
        @hitBox.position.x += @xVelocity * timeRatio
        @hitBox.position.y -= @yVelocity * timeRatio

    checkFloorCollision: (timeRatio) ->
        y = @hitBox.position.y
        yStep = y - @yVelocity * timeRatio
        console.log y, yStep

        if y < 0 and yStep >= 0
            @jumping = false
            @yVelocity = 0
            @hitBox.position.y = 0
