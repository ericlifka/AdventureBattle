loginFormTemplate =
"""
<div class='login-modal'>
    <form id="loginForm" role="form">
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

        resolve()

    renderLoginForm: ->
        @loginForm = $(loginFormTemplate)
        @viewport.append @loginForm
