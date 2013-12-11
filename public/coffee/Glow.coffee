define (require, exports, module) ->

    class Player
        constructor: (@model)->
            @time = 0

        update: (dt) ->


        render: (c) ->

            p = @model.me

            c.save()


            c.translate(p.position.x, p.position.y)
            c.moveTo(0,0-p.radius + 4)

            c.beginPath()
            c.arc(0, 0, p.radius + 20, 0, Math.PI*2)

            c.lineWidth = 10
            c.strokeStyle = "#f44"

            c.stroke()
            c.restore()

    return Player