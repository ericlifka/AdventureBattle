`import breeds from '../helpers/breeds'`

startingStats = ->
    hp: 10
    attack: 5
    defense: 5
    special_attack: 5
    special_defense: 5
    speed: 5


advanceToLevel = (startingStats, breed) ->
    false

PokemonService = Ember.Object.extend
    generateWild: (breed, level) ->
        if not breeds.hashOwnProperty breed
            throw error: "Unknown Breed: #{breed}"

        breed = breeds[breed]
        startingStats = startingStatus()
        advanceToLevel startingStats, breed

`export default PokemonService`
