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
			for i in [0..250]
				@arrayDots.push(createDot())

		update: (dt) ->

			@moveFactor = 0.5

			@model.background.angle += -@model.inputDirection.x*0.01;

			for dot in @arrayDots
				# wannabe_star location (B dot)
				dx = -@model.inputDirection.x * dot.z * @moveFactor	# - because of inverting
				dy = -@model.inputDirection.y * dot.z * @moveFactor # - because of inverting

				if(@model.inputDirection.x != 0)
					#dy = Math.abs(dy)*1000;
					#angle = Math.abs(@model.background.angle)
					@model.background.angle = Math.min(5, @model.background.angle)
					#c_length = Math.sqrt(Math.abs((2*dy*dy*(1-Math.cos(angle)))))/1000

					#beta = (Math.PI - angle)/2 
					#c_x = c_length * Math.cos(Math.PI/2-beta)
					#c_y = c_length * Math.sin(Math.PI/2-beta)
					c_x = @model.inputDirection.x * -@model.background.angle
					c_y = @model.inputDirection.x * @model.background.angle * 2
					#C dot
					dot.x += c_x + dx
					dot.y += c_y + dy
				else
					@model.background.angle = 1
					dot.x += dx
					dot.y += dy
				#enable 3 lines up

				if dot.x >= WIDTH
					dot.x = -WIDTH
				else if dot.x <= -WIDTH
					dot.x = WIDTH

				if dot.y >= HEIGHT
					dot.y = -HEIGHT
				else if dot.y <= -HEIGHT
					dot.y = HEIGHT

			#camera-in / camera-out effect
			if Math.abs(@model.inputDirection.x) + Math.abs(@model.inputDirection.y) >= 0.1
				@model.background.scale = Math.max( 1 , @model.background.scale- 0.001 )
			else
				@model.background.scale = Math.min( 1.05, @model.background.scale + 0.001 )

		render: (c) ->
			c.save()
			#c.translate( @model.me.position.x, @model.me.position.y)
			#c.rotate(@model.background.angle);
			c.scale( @model.background.scale, @model.background.scale )
			c.fillStyle = "rgba( 255, 255, 255, 0.6 )"

			for dot in @arrayDots			
				c.beginPath()
				
				c.fillRect(~~dot.x, ~~dot.y, dot.r, dot.r)
				c.fill()

			c.restore()
			
	return Stars