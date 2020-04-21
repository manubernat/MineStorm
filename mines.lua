mines = {}

function CreeMines( typeMines )
    for i=1,28 do
        local mine = {
            x = math.random(largeurEcran),
            y = math.random(hauteurEcran),
            dx = math.random(-40,40),
            dy = math.random(-40,40),
            r = 5,
            type = string.sub(typeMines,math.fmod(i,4)+1,math.fmod(i,4)+1), -- "A:float", "B:fireball, "C:magnetic", "D:magfire"
            active = (i<5),  -- active les 4 premières mines à la création
            score = 100
        }
        if (i<13) then 
            mine.r = 10
            mine.score = 200 
        end
        if (i<5) then 
            mine.r = 15
            mine.score = 300
        end

        table.insert(mines,mine)
    end
end

function DessineMines()
    for i=1,#mines do
        if mines[i].active then
            if mines[i].type=="A" then
                love.graphics.setColor(0,1,0)
                love.graphics.circle("fill",mines[i].x,mines[i].y,mines[i].r,3)
            end
            if mines[i].type=="B" then
                love.graphics.setColor(0,1,0)
                love.graphics.circle("fill",mines[i].x,mines[i].y,mines[i].r,4)   -- adapter le dessin selon le type
            end
            if mines[i].type=="C" then
                love.graphics.setColor(0,1,0)
                love.graphics.circle("fill",mines[i].x,mines[i].y,mines[i].r,5)   -- adapter le dessin selon le type
            end
            if mines[i].type=="D" then
                love.graphics.setColor(0,1,0)
                love.graphics.circle("fill",mines[i].x,mines[i].y,mines[i].r,6)   -- adapter le dessin selon le type
            end
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

            -- Mines magnetiques
            if mines[i].type=="B" or mines[i].type=="D" then
                sensX = 1
                if VaisseauX<mines[i].x then sensX=-1 end
                sensY = 1
                if VaisseauY<mines[i].y then sensY=-1 end

                mines[i].dx = sensX * math.max(math.abs(math.ceil(VaisseauX - mines[i].x)) / 5,math.abs(mines[i].dx))
                mines[i].dy = sensY * math.max(math.abs(math.ceil(VaisseauY - mines[i].y)) / 5,math.abs(mines[i].dy))
            end
        end
    end
end