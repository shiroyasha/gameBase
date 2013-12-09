
define (require, exports, module) ->

	GO = require 'gameObject'
	Asteroid = (require 'asteroid').Asteroid


	$ ->
		area = $('canvas')[0];
		c = area.getContext '2d'
		console.log new GO()

		a1 = new Asteroid(50, 50, 20, "small", 0, 0)
		a1.renderVector(c)