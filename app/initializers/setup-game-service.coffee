`import GameService from '../services/game'`

GameServiceInitializer =
    name: 'session-service'
    initialize: (container, app) ->
        app.register 'service:game', GameService, { singleton: true, initialize: true }

        app.inject 'route', 'game', 'service:game'
        app.inject 'controller', 'game', 'service:game'
        app.inject 'component', 'game', 'service:game'
        app.inject 'view', 'game', 'service:game'

`export default GameServiceInitializer`
