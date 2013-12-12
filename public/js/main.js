// Generated by CoffeeScript 1.6.3
(function() {
  define(function(require, exports, module) {
    var App, Keys;
    Keys = require('Keys');
    App = require('App');
    return $(function() {
      var addMouseMotion, app, area, c, doubleTouch, k, keyDownHandler, keyUpHandler, keysDown, mouseActive, mouseDownHandler, mouseMoveHandler, mouseUpHandler, removeMouseMotion, touchEndHandler, touchHandler, touchStartHandler;
      area = $('canvas')[0];
      c = area.getContext('2d');
      app = new App(c);
      mouseActive = false;
      doubleTouch = false;
      k = app.model.me.position.y / 320;
      keysDown = {};
      addMouseMotion = function(x, y) {
        var direction;
        direction = app.model.inputDirection;
        if (doubleTouch) {
          direction.x = 0;
          direction.y = -1;
          return;
        }
        if ((k * x - y - 320 * k > 0) && (k * x + y - 960 * k < 0)) {
          direction.x = 0;
          return direction.y = -1;
        } else if (x < app.model.me.position.x) {
          direction.x = -1;
          return direction.y = 1;
        } else {
          direction.x = 1;
          return direction.y = 1;
        }
      };
      removeMouseMotion = function() {
        var direction;
        direction = app.model.inputDirection;
        direction.x = 0;
        return direction.y = 0;
      };
      keyDownHandler = function(e) {
        var direction;
        if (keysDown[e.which] != null) {
          return e.preventDefault();
        }
        keysDown[e.which] = true;
        direction = app.model.inputDirection;
        console.log('down', e.which);
        switch (e.which) {
          case Keys.left:
          case Keys.a:
            direction.x = -1;
            e.preventDefault();
            break;
          case Keys.right:
          case Keys.d:
            direction.x = 1;
            e.preventDefault();
            break;
          case Keys.up:
          case Keys.w:
            direction.y = -1;
            e.preventDefault();
        }
        return console.log("Down:", app.model.inputDirection);
      };
      keyUpHandler = function(e) {
        var direction;
        e.preventDefault();
        delete keysDown[e.which];
        direction = app.model.inputDirection;
        switch (e.which) {
          case Keys.left:
          case Keys.a:
            direction.x = 0;
            e.preventDefault();
            break;
          case Keys.right:
          case Keys.d:
            direction.x = 0;
            e.preventDefault();
            break;
          case Keys.up:
          case Keys.w:
            direction.y = 0;
            e.preventDefault();
        }
        return console.log("Up:", app.model.inputDirection);
      };
      mouseDownHandler = function(e) {
        e.preventDefault();
        mouseActive = true;
        return addMouseMotion(e.clientX, e.clientY);
      };
      mouseUpHandler = function(e) {
        e.preventDefault();
        mouseActive = false;
        return removeMouseMotion();
      };
      mouseMoveHandler = function(e) {
        e.preventDefault();
        if (mouseActive) {
          return addMouseMotion(e.clientX, e.clientY);
        }
      };
      touchStartHandler = function(e) {
        return touchHandler(e);
      };
      touchHandler = function(e) {
        e.preventDefault();
        if (e.originalEvent.touches[1]) {
          doubleTouch = true;
        } else {
          doubleTouch = false;
        }
        return addMouseMotion(e.originalEvent.touches[0].pageX, e.originalEvent.touches[0].pageY);
      };
      touchEndHandler = function(e) {
        if (e.originalEvent.touches.length === 1) {
          doubleTouch = false;
          addMouseMotion(e.originalEvent.touches[0].pageX, e.originalEvent.touches[0].pageY);
        }
        if (e.originalEvent.touches.length === 0) {
          return removeMouseMotion();
        }
      };
      $(document).on('keydown', keyDownHandler);
      $(document).on('keyup', keyUpHandler);
      $(document).on('mouseup', mouseUpHandler);
      $(document).on('mousedown', mouseDownHandler);
      $(document).on('mousemove', mouseMoveHandler);
      $(document).on('touchstart', touchStartHandler);
      $(document).on('touchmove', touchHandler);
      return $(document).on('touchend', touchEndHandler);
    });
  });

}).call(this);
