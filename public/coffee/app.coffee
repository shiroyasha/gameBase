define (require, exports, module) ->

	area = $('canvas')[0];
	c    = area.getContext '2d'

	exp = require 'modelUpdater'
	$ ->
		model = {	
			players: []
			asteroids: []
		}

		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)
		exp.addRandomAsteroid(model)

		lastTime = null
		_loop = (time) ->
			if lastTime == null then lastTime = time
			dt = time - lastTime
			
			c.fillStyle = "white"
			c.fillRect(0,0, 1000,1000)

			exp.updateModel(model,dt/1000)
			exp.renderModel(c, model)

			lastTime = time

			requestAnimationFrame (_loop)

		requestAnimationFrame (_loop)