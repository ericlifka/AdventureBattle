PokemonModel = DS.Model.extend
    nickname: DS.attr 'string'

    breed: DS.attr 'string'
    stats: DS.attr()
    genes: DS.attr()

    trainer: DS.belongsTo 'trainer',
        inverse: 'ownedPokemon'
        async: true

`export default PokemonModel`
