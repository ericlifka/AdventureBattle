InjectStoreInitializer =
    name: 'inject-store-services'
    after: 'store'
    initialize: (container, app) ->
        app.set 'store', container.lookup 'store:main'

        app.inject 'service', 'store', 'store:main'

`export default InjectStoreInitializer`
