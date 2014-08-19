Save = DS.Model.extend
    name: DS.attr()

    ownedPokemon: DS.hasMany 'pokemon',
        inverse: 'trainer'
        async: true

`export default Save`
