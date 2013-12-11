define (require, exports, module) ->

    class Player
        constructor: (@model)->


        update: (dt) ->


        render: (c) ->

            p = @model.me

            c.save()
            c.beginPath()

            c.translate(p.position.x, p.position.y)
            c.moveTo(0,0-p.radius)

            arms = 5
            c.rotate(Math.PI)
            for i in [0..arms]
                c.rotate(Math.PI / arms)
                c.lineTo(0, 0 - (p.radius*2))
                c.rotate(Math.PI / arms)
                c.lineTo(0, 0 - p.radius)

            c.fillStyle = "yellow"
            c.fill()

            c.restore()
            c.restore()

    return Player