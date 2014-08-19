StoreConvenienceInitializer =
    name: 'store-convenience'
    after: 'store'
    initialize: (container, app) ->
        app.set 'store', container.lookup 'store:main'

`export default StoreConvenienceInitializer`
