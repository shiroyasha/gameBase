define (require, exports, module) ->

	class Planets

		constructor: (@model) ->
			@x = 0
			@y = 0

		update: (dt) ->

			@x += dt/10
			@y += dt/10

		render: (c) ->

			image = window.images.Planet

			W = image.width
			H = image.height

			for planet in @model.planets
				c.save()

				c.translate( planet.position.x + W/2, planet.position.y + H/2 )
				c.rotate( planet.orientation )

				size = planet.radius*2

				c.drawImage image, 0, 0, W, H, -size/2, -size/2, size, size
				c.restore()
	return Planets