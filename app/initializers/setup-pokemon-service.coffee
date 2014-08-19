`import PokemonService from '../services/pokemon'`

GameServiceInitializer =
    name: 'pokemon-service'
    initialize: (container, app) ->
        app.register 'service:pokemon', PokemonService, { singleton: true, initialize: true }

        app.inject 'adapter:application', 'pokemon', 'service:pokemon'
        app.inject 'controller', 'pokemon', 'service:pokemon'
        app.inject 'component', 'pokemon', 'service:pokemon'

`export default GameServiceInitializer`
