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
			@rot = 0;
			@arrayDots = []
			for i in [0..500]
				@arrayDots.push(createDot())

		update: (dt) ->

			@moveFactor = 0.15

			for dot in @arrayDots
				dot.x += -@model.me.direction.x * dot.z * @moveFactor
				dot.y += -@model.me.direction.y * dot.z * @moveFactor

				if dot.x >= WIDTH
					dot.x = -WIDTH
				else if dot.x <= -WIDTH
					dot.x = WIDTH

				if dot.y >= HEIGHT
					dot.y = -HEIGHT
				else if dot.y <= -HEIGHT
					dot.y = HEIGHT

			@model.background.angle += -@model.me.direction.x*0.005;

			if Math.abs(@model.me.direction.x) + Math.abs(@model.me.direction.y) >= 0.1
				@model.background.scale = Math.max( 1 , @model.background.scale- 0.001 )
			else
				@model.background.scale = Math.min( 1.05, @model.background.scale + 0.001 )

		render: (c) ->
			c.save()
			c.translate( WIDTH/2, HEIGHT/2)
			c.rotate(@model.background.angle);
			c.scale( @model.background.scale, @model.background.scale )
			c.fillStyle = "rgba( 255, 255, 255, 0.6 )"
			for dot in @arrayDots
				#krug
				#c.beginPath()
				#c.arc(~~dot.x, ~~dot.y, ~~dot.r, 0, 2 * Math.PI, false)
				#c.fillStyle = "white"
				#c.fill()
				
				c.beginPath()
				
				c.fillRect(~~dot.x, ~~dot.y, dot.r, dot.r)
				c.fill()
			c.restore()
			
	return Stars