class InputController
    keyCache: null

    constructor: ->
        @keyCache = { }

        # TODO: String.fromCharCode can only handle alphanumeric,
        # this needs to be replaced with a more robust solution at some point
        document.addEventListener 'keydown', (event) =>
            @keyCache[ String.fromCharCode(event.keyCode) ] = true

        document.addEventListener 'keyup', (event) =>
            @keyCache[ String.fromCharCode(event.keyCode) ] = false

    getFrameState: ->
        left: @keyCache['A']
        right: @keyCache['D']
        up: @keyCache['W']
        down: @keyCache['S']
        jump: @keyCache[' ']
