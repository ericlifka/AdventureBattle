// Generated by CoffeeScript 1.8.0
(function() {
  var GameController;

  window.GameController = GameController = (function() {
    function GameController(viewport) {
      this.viewport = viewport;
      this.stage = new PIXI.Stage(0xf5f5f5);
      this.renderer = new PIXI.WebGLRenderer(1024, 576);
      this.viewport.append(this.renderer.view);
    }

    GameController.prototype.start = function() {
      var browserFrameHook;
      browserFrameHook = (function(_this) {
        return function() {
          _this.nextAnimationFrame();
          return requestAnimationFrame(browserFrameHook);
        };
      })(this);
      return requestAnimationFrame(browserFrameHook);
    };

    GameController.prototype.nextAnimationFrame = function() {
      return this.renderer.render(this.stage);
    };

    return GameController;

  })();

}).call(this);
