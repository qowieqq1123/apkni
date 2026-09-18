








local ballPhysics={}
local MATH_SQRT_=math.sqrt
local MATH_ACOS_=math.acos
local MATH_TAN_=math.tan
local MATH_ABS_=math.abs
local MATH_RAD_=math.rad
local MATH_RAD_90=MATH_RAD_(90)
local MATH_PI_=math.pi
local maxSafeCnt=10
local maxSafeCnt2=99







function ballPhysics.raycastLine(angle,bt)





















local poslist={}

local posx=bt.shooterPosX
local posy=bt.shooterPosY

local s_posx=posx
local s_posy=posy
local sangle=angle
local k,b
local A
local angleLeft,angleRight
local toward
local ball=nil
local hitx,hity
local topWall=bt.topWall
local leftWall=bt.leftWall
local rightWall=bt.rightWall
local balls=bt:getSortBalls()
local radius=bt.sCfg.ballRadius
local safeCnt=0
while safeCnt<maxSafeCnt do

if sangle~=MATH_RAD_90 then
k=MATH_TAN_(sangle)
b=s_posy-k*s_posx
A=1+k*k
else

k=nil
b=posx
A=nil
end
angleLeft=ballPhysics.vectorsAngle(leftWall+radius-s_posx,topWall-radius-s_posy)
angleRight=ballPhysics.vectorsAngle(rightWall-radius-s_posx,topWall-radius-s_posy)
if sangle>=angleRight and sangle<=angleLeft then
toward=0
else
toward=k>0 and 1 or-1
end

ball,hitx,hity=ballPhysics.lineCrashBalls(s_posx,s_posy,k,b,A,balls,radius)
if ball~=nil and hity+radius<=topWall and hitx>=leftWall and hitx<=rightWall then
table.insert(poslist,{hitx,hity,nil})
break
end

hitx,hity=ballPhysics.lineCrashWallPos(k,b,topWall,radius,toward)
if hitx~=nil and hitx>leftWall and hitx<rightWall then
table.insert(poslist,{hitx,hity,nil})
break
end

if toward==0 then

break
end

hitx,hity=ballPhysics.lineCrashWallPos(k,b,toward==-1 and leftWall or rightWall,radius,toward)
if hitx~=nil and hitx>leftWall and hitx<rightWall and hity<topWall then
s_posx=hitx
s_posy=hity
sangle=MATH_PI_-sangle
toward=-toward
table.insert(poslist,{hitx,hity,sangle})
else

break
end

hitx=nil
hity=nil
safeCnt=safeCnt+1
if safeCnt>=maxSafeCnt then

end
end
if#poslist>0 then
table.insert(poslist,1,{posx,posy,angle})
return poslist
end
end







function ballPhysics.raycastPath(angle,bt)

local poslist={}

local posx=bt.shooterPosX
local posy=bt.shooterPosY

local s_posx=posx
local s_posy=posy
local sangle=angle
local k,b
local A
local angleLeft,angleRight
local toward
local ball=nil
local hitx,hity
local dropRow,dropCol
local topWall=bt.topWall
local leftWall=bt.leftWall
local rightWall=bt.rightWall
local balls=bt:getSortBalls()
local radius=bt.sCfg.ballRadius
local safeCnt=0
while safeCnt<maxSafeCnt2 do

if sangle~=MATH_RAD_90 then
k=MATH_TAN_(sangle)
b=s_posy-k*s_posx
A=1+k*k
else

k=nil
b=posx
A=nil
end
angleLeft=ballPhysics.vectorsAngle(leftWall+radius-s_posx,topWall-radius-s_posy)
angleRight=ballPhysics.vectorsAngle(rightWall-radius-s_posx,topWall-radius-s_posy)
if sangle>=angleRight and sangle<=angleLeft then
toward=0
else
toward=k>0 and 1 or-1
end

ball,hitx,hity=ballPhysics.lineCrashBalls(s_posx,s_posy,k,b,A,balls,radius+radius)
if ball~=nil and hity+radius<=topWall and hitx>=leftWall and hitx<=rightWall then
dropRow,dropCol=bt:getDropRowCol(k,b,hitx,hity,ball)
table.insert(poslist,{hitx,hity,nil})
break
end

hitx,hity=ballPhysics.lineCrashWallPos(k,b,topWall,radius,toward)
if hitx~=nil and hitx>leftWall and hitx<rightWall then
dropRow,dropCol=bt:getDropRowCol(k,b,hitx,hity)
table.insert(poslist,{hitx,hity,nil})
break
end

if toward==0 then

break
end

hitx,hity=ballPhysics.lineCrashWallPos(k,b,toward==-1 and leftWall or rightWall,radius,toward)
if hitx~=nil and hitx>leftWall and hitx<rightWall and hity<topWall then
s_posx=hitx
s_posy=hity
sangle=MATH_PI_-sangle
toward=-toward
table.insert(poslist,{hitx,hity,sangle})
else

break
end

hitx=nil
hity=nil
safeCnt=safeCnt+1
if safeCnt>=maxSafeCnt2 then

end
end
if#poslist>0 then
table.insert(poslist,1,{posx,posy,angle})
return poslist,dropRow,dropCol,ball
end
end







function ballPhysics.raycastPos(angle,bt)


local posx=bt.shooterPosX
local posy=bt.shooterPosY

local s_posx=posx
local s_posy=posy
local sangle=angle
local k,b
local A
local angleLeft,angleRight
local toward
local ball=nil
local hitx,hity
local dropRow,dropCol
local topWall=bt.topWall
local leftWall=bt.leftWall
local rightWall=bt.rightWall
local balls=bt:getSortBalls()
local radius=bt.sCfg.ballRadius
local safeCnt=0
while safeCnt<maxSafeCnt2 do

if sangle~=MATH_RAD_90 then
k=MATH_TAN_(sangle)
b=s_posy-k*s_posx
A=1+k*k
else

k=nil
b=posx
A=nil
end
angleLeft=ballPhysics.vectorsAngle(leftWall+radius-s_posx,topWall-radius-s_posy)
angleRight=ballPhysics.vectorsAngle(rightWall-radius-s_posx,topWall-radius-s_posy)
if sangle>=angleRight and sangle<=angleLeft then
toward=0
else
toward=k>0 and 1 or-1
end

ball,hitx,hity=ballPhysics.lineCrashBalls(s_posx,s_posy,k,b,A,balls,radius+radius)
if ball~=nil and hity+radius<=topWall and hitx>=leftWall and hitx<=rightWall then
dropRow,dropCol=bt:getDropRowCol(k,b,hitx,hity,ball)
break
end

hitx,hity=ballPhysics.lineCrashWallPos(k,b,topWall,radius,toward)
if hitx~=nil and hitx>leftWall and hitx<rightWall then
dropRow,dropCol=bt:getDropRowCol(k,b,hitx,hity)
break
end

if toward==0 then

break
end

hitx,hity=ballPhysics.lineCrashWallPos(k,b,toward==-1 and leftWall or rightWall,radius,toward)
if hitx~=nil and hitx>leftWall and hitx<rightWall and hity<topWall then
s_posx=hitx
s_posy=hity
sangle=MATH_PI_-sangle
toward=-toward
else

break
end

hitx=nil
hity=nil
safeCnt=safeCnt+1
if safeCnt>=maxSafeCnt2 then

end
end
return dropRow,dropCol
end


function ballPhysics.vectorsAngle(vx,vy)




return MATH_ACOS_(vx/MATH_SQRT_(vx*vx+vy*vy))
end


function ballPhysics.twoPosDistance(x1,y1,x2,y2)
local dx=x2-x1
local dy=y2-y1
return MATH_SQRT_(dx*dx+dy*dy)
end


function ballPhysics.lineCrashBalls(posx,posy,k,b,A,balls,radius)
local ball,ball_,dis,dis_,hitx,hity,hitx_,hity_
for i=#balls,1,-1 do
ball_=balls[i]
hitx_,hity_=ballPhysics.lineCrashBallPos(posx,posy,k,b,A,ball_,radius)
if hitx_~=nil then
dis_=ballPhysics.twoPosDistance(posx,posy,hitx_,hity_)
if dis==nil or dis_<dis then
dis=dis_
ball=ball_
hitx=hitx_
hity=hity_
end
end
end
return ball,hitx,hity
end




















function ballPhysics.lineCrashBallPos(posx,posy,k,b,A,ball,radius)
if k==nil then
local dx=b-ball.x
local delta=radius*radius-dx*dx
if delta>0 then
return b,ball.y-MATH_SQRT_(delta)
elseif delta==0 then
return b,ball.y
end
else
local x=ball.x
local dy=b-ball.y
local B=2*(k*dy-x)
local C=x*x+dy*dy-radius*radius
local delta=B*B-4*A*C
if delta>0 then
local delta_s=MATH_SQRT_(delta)
local AA=A+A
local hit_x=(-B+delta_s)/AA
local hit_y=k*hit_x+b
local hit2_x=(-B-delta_s)/AA
local hit2_y=k*hit2_x+b
local dis1=ballPhysics.twoPosDistance(posx,posy,hit_x,hit_y)
local dis2=ballPhysics.twoPosDistance(posx,posy,hit2_x,hit2_y)
if dis1<=dis2 then
return hit_x,hit_y
else
return hit2_x,hit2_y
end
elseif delta==0 then
local x=-B/(A+A)
return x,k*x+b
end
end
return nil,nil
end


function ballPhysics.lineCrashWallPos(k,b,wall,radius,toward)
if toward==0 then
if k==nil then
return b,wall-radius
else
local x=(wall-b-radius)/k
return x,k*x+b
end
else
local y=k*(wall-toward*radius)+b
return(y-b)/k,y
end
end

return ballPhysics
