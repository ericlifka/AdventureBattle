loginFormTemplate =
"""
<div class='login-modal'>
    <form id="loginForm" role="form">
        <div id="loginError"></div>
        <input type="text" id="username" placeholder="Username">
        <input type="password" id="password" placeholder="Password">
        <button type="submit" role="button">Login</button>
    </form>
</div>
"""

DomView =
    viewport: null

    setupContext: (@viewport) ->

    showLogin: -> new RSVP.Promise (resolve, reject) =>
        @renderLoginForm()
        @loginForm.on 'submit', (event) =>
            event.preventDefault()

            username = $("#username").val()
            password = $("#password").val()

            $.post '/login', {username, password}
                .done (data, status) =>
                    console.log 'success', arguments
                .fail (request, error, message) =>
                    $('#loginError')
                        .text "Error logging in"
                        .addClass 'visible'

                    $("#username").val null
                    $("#password").val null

            return false

        resolve()

    renderLoginForm: ->
        @loginForm = $(loginFormTemplate)
        @viewport.append @loginForm
        $("#username").focus()
