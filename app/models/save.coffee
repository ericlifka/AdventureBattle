Save = DS.Model.extend
    name: DS.attr()

    ownedPokemon: DS.hasMany 'pokemon',
        inverse: 'owner'
        async: true

`export default Save`
