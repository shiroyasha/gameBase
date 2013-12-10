define (require, exports, module) ->

	Z_FAKTOR = 10
	DOT_SIZE = 2

	createDot = -> {
		x: (Math.random()*WIDTH)
		y: (Math.random()*HEIGHT)
		z: (Math.random()*Z_FAKTOR)
		r: (Math.random() + 1)*DOT_SIZE
	}

	class Stars

		constructor: (@acc = 0.05)->
			@arrayDots = []
			for i in [0..100]
				@arrayDots.push(createDot())

		update: (dt) ->
			console.log @acc
			@dx = 0
			#
			if KEYS[37]?
				@dx -= 1 * @acc
				if @acc < 1 then @acc+= @acc
			else
				@dx -= 1 * @acc
				if @acc > 0 then @acc-= @acc

			if KEYS[39]?
				@dx += 1 * @acc
				if @acc < 1 then @acc+= @acc
			else
				@dx += 1 * @acc
				if @acc > 0 then @acc-= @acc

			#
			@dy = 0
			#
			if KEYS[38]?
				@dy -= 1 * @acc
				if @acc < 1 then @acc+= @acc
			else
				@dy -= 1 * @acc
				if @acc > 0 then @acc-= @acc

			if KEYS[40]?
				@dy += 1 * @acc
				if @acc < 1 then @acc+= @acc
			else
				@dy += 1 * @acc
				if @acc > 0 then @acc-= @acc
			#

			@moveFactor = 0.05

			for dot in @arrayDots
				dot.x += @dx * dot.z * @moveFactor
				dot.y += @dy * dot.z * @moveFactor

				if dot.x >= WIDTH then dot.x = 0
				if dot.y >= HEIGHT then dot.y = 0

		render: (c) ->
			for dot in @arrayDots
				#c.beginPath()
				#c.arc(~~dot.x, ~~dot.y, ~~dot.r, 0, 2 * Math.PI, false)
				#c.fillStyle = "white"
				#c.fill()
				c.beginPath()
				c.fillRect(~~dot.x, ~~dot.y, dot.r, dot.r)
				c.fillStyle = "white"
				c.fill()
	return Stars