PokemonModel = DS.Model.extend
    breed: DS.attr 'string'
    nickname: DS.attr 'string'

    trainer: DS.belongsTo 'trainer',
        inverse: 'ownedPokemon'
        async: true

`export default PokemonModel`
