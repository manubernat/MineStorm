tirs = {}
VitesseTir = 500
DelaiTir = 0

function AjouteTir( xinit, yinit, dxinit, dyinit )
    if DelaiTir<0 then
        local tir = {
            x = xinit,
            y = yinit,
            dx = dxinit + VitesseTir * math.sin(VaisseauAngle),
            dy = dyinit + VitesseTir * math.cos(VaisseauAngle+math.pi),
            vie = 1
        }
        table.insert(tirs,tir)

        DelaiTir = 0.1
    end
end

function DeplaceTirs( dt )
    for i=#tirs, 1, -1 do
        tirs[i].vie = tirs[i].vie - dt
        if tirs[i].vie<0 then 
            table.remove(tirs,i)
        else
            -- Déplacement
            tirs[i].x = tirs[i].x + tirs[i].dx * dt
            tirs[i].y = tirs[i].y + tirs[i].dy * dt

            -- Ecran traversable
            if tirs[i].x<0 then tirs[i].x=largeurEcran end
            if tirs[i].x>largeurEcran then tirs[i].x=0 end
            if tirs[i].y<0 then tirs[i].y=hauteurEcran end
            if tirs[i].y>hauteurEcran then tirs[i].y=0 end
        end
    end
    DelaiTir = DelaiTir - dt
end

function DessineTirs()
    for i=1, #tirs do
        love.graphics.setColor(1,0,0)
        love.graphics.circle("fill", tirs[i].x, tirs[i].y, 4)
    end
end

