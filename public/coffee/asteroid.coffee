define (requiere, exports, module) ->

	class Asteroid

		constructor: (@x, @y, @r, @type, @orientation= 0, @rotation = 0, @speedX= 0, @speedY= 0) ->

		setPos: (@x, @y) ->
		setSize: (@r) ->
		setOrientation: (@orientation) ->
		setType: (@type) ->
		setSpeed: (@speedX, @speedY) ->

		move: (dt) ->
			@x = @x + dt*speedX
			@y = @y + dt*speedy
			@orientation = @orientation + dt*@rotation

		renderVector: (c) ->
			c.beginPath()
			c.strokeStyle = "brown"
			c.arc(@x, @y, @r, 0, Math.PI*2, true)
			c.stroke()

		hasCollided= (ast1, ast2) ->
			if Math.sqrt((ast1.x-ast2.x)^2+(ast1.y-ast2.y)^2) < (ast1.r+ast2.r)
				return true
			else return false

	return {
		hasCollided: hasCollided,
		Asteroid: Asteroid
	}




