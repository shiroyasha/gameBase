define (require, exports, module) ->

	area = $('canvas')[0];
	c    = area.getContext '2d'
	RenderQueue = require 'RenderQueue'
	Background = require 'Background'
	BackgroundDots = require 'BackgroundDots'



	$ ->
		queue = new RenderQueue()
		queue.add new Background()
		queue.add new BackgroundDots()

		render = (dt) ->
			queue.update(dt)
			queue.render(c)		

		lastTime = null
		_loop = (time) ->
			if lastTime == null then lastTime = time
			dt = time - lastTime
			
			render(dt)
			lastTime = time

			requestAnimationFrame (_loop)

		requestAnimationFrame (_loop)