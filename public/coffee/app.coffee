define (require, exports, module) ->

	RenderQueue = require 'RenderQueue'
	Background  = require 'Background'
	Stars       = require 'Stars'
	model		= require 'Model'

	class App

		constructor: (@c)->
			@model   = model
			@queue   = new RenderQueue()
			@queue.add new Background()
			@queue.add new Stars(model)

			@lastTime = null
			requestAnimationFrame ( @_loop.bind(this) )	

		update: (dt) ->
			@queue.update(dt)

		render: (c) ->
			@queue.render(c)	

		_loop: (time) ->
			if @lastTime == null then @lastTime = time
			dt = time - @lastTime
			
			@update(dt)
			@render(@c)

			@lastTime = time

			requestAnimationFrame ( @_loop.bind(this) )

	return App