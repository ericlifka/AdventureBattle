PokemonModel = DS.Model.extend
    breed: DS.attr 'string'
    nickname: DS.attr 'string'
    owner: DS.belongsTo 'save',
        inverse: 'ownedPokemon'
        async: true

`export default PokemonModel`
