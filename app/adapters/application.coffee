`import Save from '../models/save'`

guid = (->
    s4 = ->
        Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)

    return ->
        s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4()
)()

getKey = (type, id) ->
    if typeof id is 'object'
        id = id.get 'id'

    type.typeKey + "#" + id

Promise = Ember.RSVP.Promise


ApplicationAdapter = DS.Adapter.extend
    defaultSerializer: '-rest'

    find: (store, type, id) -> new Promise (resolve, reject) ->
        key = getKey type, id
        json = localStorage.getItem key

        try
            result = { }
            hash = JSON.parse json
            hash.id = id
            result[type.typeKey] = hash
            resolve result

        catch error
            reject error

    findAll: (store, type, sinceToken) ->

    findQuery: (store, type, query) ->

    createRecord: (store, type, record) -> new Promise (resolve) ->
        record.set 'id', guid()
        serializer = store.serializerFor type.typeKey

        key = getKey type, record
        data = serializer.serialize record

        localStorage.setItem key, JSON.stringify data
        resolve()

    updateRecord: (store, type, record) -> new Promise (resolve) ->
        serializer = store.serializerFor type.typeKey

        key = getKey type, record
        data = serializer.serialize record

        localStorage.setItem key, JSON.stringify data
        resolve()

    deleteRecord: (store, type, record) ->

`export default ApplicationAdapter`
