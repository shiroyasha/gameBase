// Generated by CoffeeScript 1.6.3
(function() {
  define(function(require, exports, module) {
    var RenderQueue;
    RenderQueue = (function() {
      function RenderQueue() {
        this.lista = [];
      }

      RenderQueue.prototype.add = function(objekat) {
        return this.lista.push(objekat);
      };

      RenderQueue.prototype.update = function(dt) {
        var a, _i, _len, _ref, _results;
        _ref = this.lista;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          a = _ref[_i];
          _results.push(a.update(dt));
        }
        return _results;
      };

      RenderQueue.prototype.render = function(c) {
        var a, _i, _len, _ref, _results;
        _ref = this.lista;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          a = _ref[_i];
          _results.push(a.render(c));
        }
        return _results;
      };

      return RenderQueue;

    })();
    return RenderQueue;
  });

}).call(this);