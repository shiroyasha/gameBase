define (require, exports, module) ->

	Z_FAKTOR = 10
	DOT_SIZE = 5

	createDot = -> {
		x: Math.random()*800
		y: Math.random()*600
		z: Math.random()*Z_FAKTOR
		r: (Math.random()+1)*DOT_SIZE
	}

	class BackgroundDots

		constructor: ->
			@arrayDots = []
			for i in [0..100]
				@arrayDots.push(createDot())

		update: (dt) ->
			@dx = 1
			@dy = 1
			@moveFactor = 0.001

			for dot in @arrayDots
				dot.x += @dx * (1/dot.Z_FAKTOR)
				dot.y += @dy * (1/dot.Z_FAKTOR)

		render: (c) ->
			for dot in @arrayDots
				c.beginPath()
				c.arc(dot.x, dot.y, dot.r, 0, 2 * Math.PI, false)
				c.fillStyle = "white"
				c.fill()

	return BackgroundDots