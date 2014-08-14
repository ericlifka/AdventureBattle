`import Save from '../models/save'`

utf8_to_b64 = (str) ->
    btoa encodeURIComponent escape str

b64_to_utf8 = (str) ->
    unescape decodeURIComponent atob str

guid = (->
    s4 = ->
        Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)

    return ->
        s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4()
)()

getKey = (id) ->
    if typeof id is 'object'
        id = id.get 'id'

    "#{id}"

Promise = Ember.RSVP.Promise


ApplicationAdapter = DS.Adapter.extend
    defaultSerializer: '-rest'

    find: (store, type, id) -> new Promise (resolve, reject) ->
        key = getKey id
        json = localStorage.getItem key

        try
            result = { }
            hash = JSON.parse b64_to_utf8 json
            hash.id = id
            result[type.typeKey] = hash
            resolve result

        catch error
            reject error

    findAll: (store, type, sinceToken) ->
        throw "I DIDN'T IMPLEMENT THIS SHIT"

    findQuery: (store, type, query) ->
        throw "I DIDN'T IMPLEMENT THIS SHIT"

    createRecord: (store, type, record) -> new Promise (resolve) ->
        record.set 'id', guid()
        serializer = store.serializerFor type.typeKey

        key = getKey record
        data = serializer.serialize record

        localStorage.setItem key, utf8_to_b64 JSON.stringify data
        resolve()

    updateRecord: (store, type, record) -> new Promise (resolve) ->
        serializer = store.serializerFor type.typeKey

        key = getKey record
        data = serializer.serialize record

        localStorage.setItem key, utf8_to_b64 JSON.stringify data
        resolve()

    deleteRecord: (store, type, record) ->
        throw "I DIDN'T IMPLEMENT THIS SHIT"

`export default ApplicationAdapter`
