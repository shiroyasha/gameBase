// Generated by CoffeeScript 1.6.3
(function() {
  define(function(require, exports, module) {
    var DOT_SIZE, Stars, Z_FAKTOR, createDot;
    Z_FAKTOR = 10;
    DOT_SIZE = 2;
    createDot = function() {
      return {
        x: Math.random() * WIDTH,
        y: Math.random() * HEIGHT,
        z: Math.random() * Z_FAKTOR,
        r: (Math.random() + 1) * DOT_SIZE
      };
    };
    Stars = (function() {
      function Stars(acc) {
        var i, _i;
        this.acc = acc != null ? acc : 0.05;
        this.arrayDots = [];
        for (i = _i = 0; _i <= 100; i = ++_i) {
          this.arrayDots.push(createDot());
        }
      }

      Stars.prototype.update = function(dt) {
        var dot, _i, _len, _ref, _results;
        console.log(this.acc);
        this.dx = 0;
        if (KEYS[37] != null) {
          this.dx -= 1 * this.acc;
          if (this.acc < 1) {
            this.acc += this.acc;
          }
        } else {
          this.dx -= 1 * this.acc;
          if (this.acc > 0) {
            this.acc -= this.acc;
          }
        }
        if (KEYS[39] != null) {
          this.dx += 1 * this.acc;
          if (this.acc < 1) {
            this.acc += this.acc;
          }
        } else {
          this.dx += 1 * this.acc;
          if (this.acc > 0) {
            this.acc -= this.acc;
          }
        }
        this.dy = 0;
        if (KEYS[38] != null) {
          this.dy -= 1 * this.acc;
          if (this.acc < 1) {
            this.acc += this.acc;
          }
        } else {
          this.dy -= 1 * this.acc;
          if (this.acc > 0) {
            this.acc -= this.acc;
          }
        }
        if (KEYS[40] != null) {
          this.dy += 1 * this.acc;
          if (this.acc < 1) {
            this.acc += this.acc;
          }
        } else {
          this.dy += 1 * this.acc;
          if (this.acc > 0) {
            this.acc -= this.acc;
          }
        }
        this.moveFactor = 0.05;
        _ref = this.arrayDots;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          dot = _ref[_i];
          dot.x += this.dx * dot.z * this.moveFactor;
          dot.y += this.dy * dot.z * this.moveFactor;
          if (dot.x >= WIDTH) {
            dot.x = 0;
          }
          if (dot.y >= HEIGHT) {
            _results.push(dot.y = 0);
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };

      Stars.prototype.render = function(c) {
        var dot, _i, _len, _ref, _results;
        _ref = this.arrayDots;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          dot = _ref[_i];
          c.beginPath();
          c.fillRect(~~dot.x, ~~dot.y, dot.r, dot.r);
          c.fillStyle = "white";
          _results.push(c.fill());
        }
        return _results;
      };

      return Stars;

    })();
    return Stars;
  });

}).call(this);
