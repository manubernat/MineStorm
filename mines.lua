mines = {}

function CreeMines()
    for i=1,28 do
        local mine = {
            x = math.random(largeurEcran),
            y = math.random(hauteurEcran),
            dx = math.random(-40,40),
            dy = math.random(-40,40),
            r = 5,
            type = "float", -- "float", "fireball, "magnetic", "magfire"
            active = (i<5)  -- active les 4 premières mines à la création
        }
        if (i<13) then mine.r = 10 end
        if (i<5) then mine.r = 15 end

        table.insert(mines,mine)
    end
end

function DessineMines()
    for i=1,#mines do
        if mines[i].active then
            love.graphics.setColor(0,1,0)
            love.graphics.circle("fill",mines[i].x,mines[i].y,mines[i].r,3)   -- adapter le dessin selon le type
        else
            love.graphics.setColor(1,1,0)
            love.graphics.circle("fill",mines[i].x,mines[i].y,1)
        end
    end
end

function DeplaceMines( dt )
    for i=1,#mines do
        if mines[i].active then
            -- Déplacement
            mines[i].x = mines[i].x + mines[i].dx * dt
            mines[i].y = mines[i].y + mines[i].dy * dt

            -- Ecran traversable
            if mines[i].x<0 then mines[i].x=largeurEcran end
            if mines[i].x>largeurEcran then mines[i].x=0 end
            if mines[i].y<0 then mines[i].y=hauteurEcran end
            if mines[i].y>hauteurEcran then mines[i].y=0 end
        end
    end
end