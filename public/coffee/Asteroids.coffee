define (requiere, exports, module) ->

	class Asteroids

		constructor: (@model) ->
			@x = 0
			@y = 0

		update: (dt) ->

			@x += dt/10
			@y += dt/10

		render: (c) ->

			W = 120
			H = 120
			image = window.images.Asteroids

			for asteroid in @model.asteroids
				c.save()

				c.translate( asteroid.position.x + W/2, asteroid.position.y + H/2 )
				c.rotate( asteroid.orientation )

				size = asteroid.radius*2

				c.drawImage image, 0, 0, W, H, -size/2, -size/2, size, size
				c.restore()
	return Asteroids






