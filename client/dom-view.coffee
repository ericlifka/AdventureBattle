loginFormTemplate =
"""
<div class='login-modal'>
    <form id="loginForm" role="form">
        <div id="loginError"></div>
        <input type="text" id="username" placeholder="Username">
        <input type="password" id="password" placeholder="Password">
        <button type="submit" role="button">Login</button>
        <button type="button" role="button" class="link">Register</button>
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

    renderLoginForm: ->
        @loginForm = $(loginFormTemplate)
        @viewport.append @loginForm
        $("#username").focus()

    processLogin: (resolve) ->
        $username = $("#username")
        $password = $("#password")
        $error = $("#loginError")

        Authorization.login $username.val(), $password.val()
            .then (player) ->
                @loginForm.remove()
                @loginForm = null
                resolve player

            .catch ->
                $error.addClass 'visible'
                $error.text "Error logging in"
                $username.val null
                $password.val null
