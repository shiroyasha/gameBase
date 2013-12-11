define (require, exports, module) ->

	Z_FAKTOR = 10
	DOT_SIZE = 2

	createDot = -> {
		x: (-WIDTH + Math.random()*WIDTH*2)
		y: (-HEIGHT + Math.random()*HEIGHT*2)
		z: (Math.random()*Z_FAKTOR)
		r: (Math.random() + 1)*DOT_SIZE
	}

	class Stars

		constructor: (@model)->

			@arrayDots = []
			for i in [0..500]
				@arrayDots.push(createDot())

		update: (dt) ->

			@moveFactor = 0.18

			for dot in @arrayDots
				dot.x += -@model.inputDirection.x * dot.z * @moveFactor
				dot.y += -@model.inputDirection.y * dot.z * @moveFactor

				if dot.x >= WIDTH
					dot.x = -WIDTH
				else if dot.x <= -WIDTH
					dot.x = WIDTH

				if dot.y >= HEIGHT
					dot.y = -HEIGHT
				else if dot.y <= -HEIGHT
					dot.y = HEIGHT

			@model.background.angle += -@model.inputDirection.x*0.005;

			if Math.abs(@model.inputDirection.x) + Math.abs(@model.inputDirection.y) >= 0.1
				@model.background.scale = Math.max( 1 , @model.background.scale- 0.001 )
			else
				@model.background.scale = Math.min( 1.05, @model.background.scale + 0.001 )

		render: (c) ->
			c.save()
			c.translate( @model.me.position.x, @model.me.position.y)
			c.rotate(@model.background.angle);
			c.scale( @model.background.scale, @model.background.scale )
			c.fillStyle = "rgba( 255, 255, 255, 0.6 )"

			for dot in @arrayDots			
				c.beginPath()
				
				c.fillRect(~~dot.x, ~~dot.y, dot.r, dot.r)
				c.fill()

			c.restore()
			
	return Stars