// Generated by CoffeeScript 1.6.3
(function() {
  define(function(require, exports, module) {
    var DOT_SIZE, Stars, Z_FAKTOR, createDot;
    Z_FAKTOR = 10;
    DOT_SIZE = 2;
    createDot = function() {
      return {
        x: -WIDTH + Math.random() * WIDTH * 2,
        y: -HEIGHT + Math.random() * HEIGHT * 2,
        z: Math.random() * Z_FAKTOR,
        r: (Math.random() + 1) * DOT_SIZE
      };
    };
    Stars = (function() {
      function Stars(model) {
        var i, _i;
        this.model = model;
        this.arrayDots = [];
        for (i = _i = 0; _i <= 500; i = ++_i) {
          this.arrayDots.push(createDot());
        }
      }

      Stars.prototype.update = function(dt) {
        var dot, _i, _len, _ref;
        this.moveFactor = 0.15;
        _ref = this.arrayDots;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          dot = _ref[_i];
          dot.x += -this.model.inputDirection.x * dot.z * this.moveFactor;
          dot.y += -this.model.inputDirection.y * dot.z * this.moveFactor;
          if (dot.x >= WIDTH) {
            dot.x = -WIDTH;
          } else if (dot.x <= -WIDTH) {
            dot.x = WIDTH;
          }
          if (dot.y >= HEIGHT) {
            dot.y = -HEIGHT;
          } else if (dot.y <= -HEIGHT) {
            dot.y = HEIGHT;
          }
        }
        if (Math.abs(this.model.inputDirection.x) + Math.abs(this.model.inputDirection.y) >= 0.1) {
          return this.model.background.scale = Math.max(1, this.model.background.scale - 0.001);
        } else {
          return this.model.background.scale = Math.min(1.05, this.model.background.scale + 0.001);
        }
      };

      Stars.prototype.render = function(c) {
        var dot, _i, _len, _ref;
        c.save();
        c.translate(WIDTH / 2, HEIGHT / 2);
        c.rotate(this.model.background.angle);
        c.scale(this.model.background.scale, this.model.background.scale);
        c.fillStyle = "rgba( 255, 255, 255, 0.6 )";
        _ref = this.arrayDots;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          dot = _ref[_i];
          c.beginPath();
          c.fillRect(~~dot.x, ~~dot.y, dot.r, dot.r);
          c.fill();
        }
        return c.restore();
      };

      return Stars;

    })();
    return Stars;
  });

}).call(this);
