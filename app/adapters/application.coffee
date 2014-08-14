`import Save from '../models/save'`

utf8_to_b64 = (str) ->
    btoa encodeURIComponent escape str

b64_to_utf8 = (str) ->
    unescape decodeURIComponent atob str

serialize = (record, serializer) ->
    object = serializer.serialize record
    json = JSON.stringify object
    encodedJson = utf8_to_b64 json
    encodedJson

deserialize = (id, encodedJson) ->
    json = b64_to_utf8 encodedJson
    object = JSON.parse json
    object.id = id
    object

guid = (->
    s4 = ->
        Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)

    return ->
        s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4()
)()

Promise = Ember.RSVP.Promise


ApplicationAdapter = DS.Adapter.extend
    defaultSerializer: '-rest'

    find: (store, type, id) -> new Promise (resolve, reject) ->
        try
            result = { }
            result[type.typeKey] = deserialize id, localStorage.getItem id
            resolve result

        catch error
            reject error

    findAll: (store, type, sinceToken) ->
        throw "I DIDN'T IMPLEMENT THIS SHIT"

    findQuery: (store, type, query) ->
        throw "I DIDN'T IMPLEMENT THIS SHIT"

    createRecord: (store, type, record) -> new Promise (resolve) ->
        key = guid()
        value = serialize record, store.serializerFor type.typeKey

        localStorage.setItem key, value
        resolve()

    updateRecord: (store, type, record) -> new Promise (resolve) ->
        key = record.get 'id'
        value = serialize record, store.serializerFor type.typeKey

        localStorage.setItem key, value
        resolve()

    deleteRecord: (store, type, record) ->
        throw "I DIDN'T IMPLEMENT THIS SHIT"

`export default ApplicationAdapter`
