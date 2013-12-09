define (require, exports, module) ->

	class Background
		constructor: ->
			@boja = [40, 40, 40]
			@pocetak = [40,40,40]

			@apsoluteTime = 0
			@faktor = [20,20,20]

			@timeFaktor = 0.001

		update: (dt) ->
			@apsoluteTime += dt

			for i in [0...3]
				@boja[i] = @pocetak[i] + Math.sin( @apsoluteTime * @timeFaktor ) * @faktor[i]
			
			#console.log @boja[0]
			
		render: (c) ->
			#console.log "rgb(#{~~@boja[0]}, #{~~@boja[1]}, #{~~@boja[2]})"
			#c.globalCompositeOperation = 'lighter'
			c.fillStyle = "rgb(#{~~@boja[0]}, #{~~@boja[1]}, #{~~@boja[2]})"
			#c.fillStyle = 'rgba(0,0,0, 0.2)'
			c.fillRect( 0, 0, WIDTH, HEIGHT )

	return Background