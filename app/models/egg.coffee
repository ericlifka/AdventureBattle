FIVE_MINUTES = 1000 * 60 * 5

EggModel = DS.Model.extend
    fatherId: DS.attr()
    motherId: DS.attr()
    hatchTime: DS.attr()

    father: null
    mother: null

    init: ->
        @set 'hatchTime', (new Date()).getTime() + FIVE_MINUTES
        @set 'fatherId', @get 'father.id'
        @set 'motherId', @get 'mother.id'
