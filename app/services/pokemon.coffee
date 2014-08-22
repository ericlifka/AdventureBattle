`import breeds from '../helpers/breeds'`

getBreedDescription = (pokemon) ->
    if typeof pokemon is 'object' and pokemon.get?
        pokemon = pokemon.get 'breed'

    if not breeds.hasOwnProperty pokemon
        throw error: "Unknown Breed: #{pokemon}"

    breeds[pokemon]

statNames = [
    'hp'
    'attack'
    'defense'
    'spAttack'
    'spDefense'
    'speed'
]

startingStats = ->
    hp: 10
    attack: 5
    defense: 5
    spAttack: 5
    spDefense: 5
    speed: 5

randomGenes = (strength = 'weak') ->
    genes = { }
    for stat in statNames
        genes[stat] = randomGene strength

    genes

randomGene = (strength) ->
    list = switch strength
        when 'weak' then [0, 1, 2]
        when 'medium' then [0, 1, 2, 3]
        when 'strong' then [0, 1, 2, 3, 4]

    _.sample list

PokemonService = Ember.Object.extend
    generateWild: (breedName, targetLevel) ->
        level = 0
        breedDescription = getBreedDescription breedName
        breed = breedDescription.name
        stats = startingStats()
        genes = randomGenes()

        pokemon = @store.createRecord 'pokemon', { level, breed, stats, genes }
        @levelUp pokemon for [0...targetLevel]
        pokemon

    levelUp: (pokemon) ->
        changes = { }
        breed = getBreedDescription pokemon

        Ember.changeProperties =>
            for stat in statNames
                bonus = breed.stats[stat] / 50
                bonus += 1 if stat is 'hp'
                pokemon.get('stats')[stat] += bonus
                changes[stat] = bonus
            null

        changes

`export default PokemonService`

###
        0   1   2   3   4   5   6   7   8   9
        80  85  90  95  100 105 110 115 120 125
weak   [---------]
medium [-------------]
strong [-----------------]
###
