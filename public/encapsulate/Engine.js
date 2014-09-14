(function () {
    var Engine = function () {
        this.initialize();
    };

    Engine.prototype = {
        initialize: function () {
            var self = this;
            this._boundFrameRenderer = function () { self.renderFrame() };

            this.stage = new PIXI.Stage(0x66FF99);
            this.renderer = new PIXI.WebGLRenderer(400, 300);
            document.body.appendChild(this.renderer.view);

            var texture = PIXI.Texture.fromImage("../bunny.png");
            this.bunny = new PIXI.Sprite(texture);
        },
        startAnimation: function () {
            this.bunny.anchor.x = 0.5;
            this.bunny.anchor.y = 0.5;
            this.bunny.position.x = 200;
            this.bunny.position.y = 150;
            this.stage.addChild(this.bunny);

            requestAnimationFrame(this._boundFrameRenderer);
        },
        renderFrame: function () {
            this.bunny.rotation += 0.1;

            this.renderer.render(this.stage);
            requestAnimationFrame(this._boundFrameRenderer);
        }
    };

    window.Engine = Engine;
}());

