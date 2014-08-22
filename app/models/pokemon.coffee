PokemonModel = DS.Model.extend
    nickname: DS.attr()
    level: DS.attr()
    breed: DS.attr()
    stats: DS.attr()
    genes: DS.attr()

    trainer: DS.belongsTo 'trainer',
        inverse: 'ownedPokemon'
        async: true

`export default PokemonModel`
