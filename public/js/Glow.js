// Generated by CoffeeScript 1.6.3
(function() {
  define(function(require, exports, module) {
    var Glow;
    Glow = (function() {
      function Glow(model) {
        this.model = model;
        this.radius = 20;
        this.times = 1;
      }

      Glow.prototype.update = function(dt) {
        if (this.times === 1) {
          this.radius = Math.min(30, this.radius + dt / 20);
          if (this.radius === 30) {
            return this.times = -1;
          }
        } else {
          this.radius = Math.max(20, this.radius - dt / 20);
          if (this.radius === 20) {
            return this.times = 1;
          }
        }
      };

      Glow.prototype.render = function(c) {
        var p;
        p = this.model.me;
        c.save();
        c.translate(p.position.x, p.position.y);
        c.moveTo(0, 0 - p.radius + 4);
        c.beginPath();
        c.arc(0, 0, p.radius + this.radius, 0, Math.PI * 2);
        c.lineWidth = 10;
        c.strokeStyle = "#f44";
        c.stroke();
        return c.restore();
      };

      return Glow;

    })();
    return Glow;
  });

}).call(this);
