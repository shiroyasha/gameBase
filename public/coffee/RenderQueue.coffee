define (require, exports, module) ->

	class RenderQueue
		constructor: ->
			@lista = []

		add: ( objekat ) ->
			@lista.push objekat

		update: (dt) ->
			a.update(dt) for a in @lista

		render: (c) ->
			a.render(c) for a in @lista

	return RenderQueue