Authorization =
    requestSession: -> new RSVP.Promise (resolve, reject) =>
            reject()

    login: (username, password) -> new RSVP.Promise (resolve, reject) =>
        $.post '/login', { username, password }
            .done -> resolve { username }
            .fail -> reject()
