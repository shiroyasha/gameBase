define (require, exports, module) ->

	$ ->
		
		area = $('canvas')[0];
		c    = area.getContext '2d'

		render = (dt)->
			

		lastTime = null
		_loop = (time) ->
			if lastTime == null then lastTime = time
			dt = time - lastTime
			
			render(dt)
			lastTime = time

			requestAnimationFrame (_loop)

		requestAnimationFrame (_loop)