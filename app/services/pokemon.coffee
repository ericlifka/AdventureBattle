`import breeds from '../helpers/breeds'`

###
        0   1   2   3   4   5   6   7   8   9
        80  85  90  95  100 105 110 115 120 125
weak   [---------]
medium [-------------]
strong [-----------------]
###

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

modifiers = [.8, .85, .9, .95, 1, 1.05, 1.1, 1.15, 1.2, 1.25]

geneToModifier = (gene) ->
    if 0 <= gene <= 9
        modifiers[gene]
    else
        modifiers[0]

randomGene = (strength) ->
    list = switch strength
        when 'weak' then [0, 1, 2]
        when 'medium' then [0, 1, 2, 3]
        when 'strong' then [0, 1, 2, 3, 4]

    _.sample list

inheritGenes = (father, mother) ->
    genes = { }
    for stat in statNames
        base = (father.get('genes')[stat] + mother.get('genes')[stat]) / 2
        randomized = Math.round _.random(base - 1, base + 1)
        randomized = 0 if randomized < 0
        randomized = 9 if randomized > 9
        genes[stat] = randomized
    genes

randomGender = (breed) ->
    #TODO: needs to check for breeds with non normal distributions
    _.sample ['male', 'female']

getMatedHeritage = (father, mother) ->


PokemonService = Ember.Object.extend
    generateWild: (breedName, targetLevel) ->
        level = 0
        breedDescription = getBreedDescription(breedName)
        breed = breedDescription.name
        stats = startingStats()
        genes = randomGenes()
        gender = randomGender(breed)
        heritage = { }
        heritage[breed] = 1.0

        pokemon = @store.createRecord 'pokemon', { level, breed, stats, genes, gender, heritage }
        @levelUp pokemon for [0...targetLevel]
        pokemon

    levelUp: (pokemon) ->
        changes = { }
        breed = getBreedDescription pokemon

        Ember.changeProperties =>
            for stat in statNames
                bonus = breed.stats[stat] / 50
                bonus += 1 if stat is 'hp'
                bonus *= geneToModifier(pokemon.get('genes')[stat])
                pokemon.get('stats')[stat] += bonus
                changes[stat] = bonus
            null

        changes

    mate: (father, mother) ->
        if not father or not mother
            throw "It takes two to tango"
        if father.get('gender') isnt 'male' or mother.get('gender') isnt 'female'
            throw "Gender mismatch, one male and one female required for mating"

        egg = @store.createRecord 'egg', { father, mother }
        egg.save()

#        fathersBreed = father.get 'breed'
#        mothersBreed = mother.get 'breed'
#
#        if not breedsAreCompatible(fathersBreed, mothersBreed)
#            throw "Breeds aren't compatible for breeding"
#
#        #TODO: implement mutations
#        breed = _.sample [fathersBreed, mothersBreed]
#        stats = startingStats()
#        genes = inheritGenes(father, mother)
#        gender = randomGender(breed)
#        level = 0
#        heritage = getMatedHeritage(father, mother)


        @store.createRecord 'pokemon', { level, breed, stats, genes, gender }


`export default PokemonService`
