Authorization =
    requestSession: -> new RSVP.Promise (resolve, reject) =>
        $.get '/session'
            .done (userJson) -> resolve JSON.parse userJson
            .fail -> reject()

    login: (username, password) -> new RSVP.Promise (resolve, reject) =>
        $.post '/login', { username, password }
            .done -> resolve { username }
            .fail -> reject()

    register: (username, password) -> new RSVP.Promise (resolve, reject) =>
        $.post '/register', { username, password }
            .done -> resolve { username }
            .fail -> reject()
        