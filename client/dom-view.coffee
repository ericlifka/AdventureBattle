loginFormTemplate =
"""
<div class='login-modal'>
    <form id="loginForm" class="auth-form" role="form">
        <div id="error"></div>
        <input type="text" id="loginUsername" placeholder="username">
        <input type="password" id="loginPassword" placeholder="password">
        <button type="submit">Login</button>
        <button type="button" id="register" class="link">Register</button>
    </form>

    <form id="registerForm" class="auth-form hidden" role="form">
        <div id="error"></div>
        <input type="text" id="registerUsername" placeholder="username">
        <input type="password" id="registerPassword" placeholder="password">
        <input type="password" id="passwordRepeat" placeholder="re-enter password">
        <button type="submit">Register</button>
        <button type="button" id="cancelRegister" class="link">Cancel</button>
    </form>
</div>
"""

DomView =
    viewport: null

    setupContext: (@viewport) ->

    showLogin: -> new RSVP.Promise (resolve) =>
        @renderLoginForm()
        @loginForm.on 'submit', (event) =>
            event.preventDefault()
            @processLogin resolve
            false
        $('#register').on 'click', =>
            @switchToRegister()
        $('#cancelRegister').on 'click', =>
            @switchToLogin()

    renderLoginForm: ->
        @loginForm = $(loginFormTemplate)
        @viewport.append @loginForm
        $("#loginUsername").focus()

    removeLoginForm: ->
        @loginForm.remove()
        @loginForm = null

    processLogin: (resolve) ->
        $username = $("#loginUsername")
        $password = $("#loginPassword")
        $error = $("#error")

        Authorization.login $username.val(), $password.val()
            .then (player) ->
                @loginForm.remove()
                @loginForm = null
                resolve player

            .catch ->
                $error.addClass 'visible'
                $error.text "Error logging in"
                @clearFormValues()

    switchToRegister: ->
        @clearFormValues()
        $('#loginForm').addClass 'hidden'
        $('#registerForm').removeClass 'hidden'
        $('#registerUsername').focus()

    switchToLogin: ->
        @clearFormValues()
        $('#registerForm').addClass 'hidden'
        $('#loginForm').removeClass 'hidden'
        $('#loginUsername').focus()

    clearFormValues: ->
        $('#loginUsername').val null
        $('#loginPassword').val null
        $('#registerUsername').val null
        $('#registerPassword').val null
        $('#passwordRepeat').val null
