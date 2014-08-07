import TurnOrder from '../models/turn-order';

var ApplicationRoute = Ember.Route.extend({
    model: function () {
        return TurnOrder.create({});
    }
});

export default ApplicationRoute;
