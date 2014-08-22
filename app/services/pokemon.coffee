`import breeds from '../helpers/breeds'`

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
    generateWild: (breed, level) ->
        if not breeds.hasOwnProperty breed
            throw error: "Unknown Breed: #{breed}"

        breed = breeds[breed]
        stats = startingStats()
        genes = randomGenes()

        pokemon = @store.createRecord 'pokemon', { breed, stats, genes }
        pokemon.save()


#        levelUp() for [1..level]

`export default PokemonService`

###
        0   1   2   3   4   5   6   7   8   9
        80  85  90  95  100 105 110 115 120 125
weak   [---------]
medium [-------------]
strong [-----------------]
###
