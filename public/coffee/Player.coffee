define (require, exports, module) ->

	class Player
		constructor: (@model)->


		update: (dt) ->
			
			
		render: (c) ->
			c.save()
			c.beginPath()
			c.fillRect(~~@model.me.position.x, ~~@model.me.position.y, dot.r, dot.r)
			c.fill()
			c.restore()
	return Player