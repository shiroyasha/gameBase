define (require, exports, module) ->

    class Glow
        constructor: (@model)->
            @radius = 20
            @times = 1

        update: (dt) ->
            if @times == 1
                @radius = Math.min( 30, @radius+ dt/20)
                if @radius == 30 then @times = -1
            else
                @radius = Math.max( 20, @radius- dt/20)
                if @radius == 20 then @times = 1

        render: (c) ->

            p = @model.me

            c.save()

            c.translate(p.position.x, p.position.y)
            c.moveTo(0,0-p.radius + 4)

            c.beginPath()
            c.arc(0, 0, p.radius + @radius, 0, Math.PI*2)

            c.lineWidth = 10
            c.strokeStyle = "#f44"

            c.stroke()
            c.restore()

    return Glow