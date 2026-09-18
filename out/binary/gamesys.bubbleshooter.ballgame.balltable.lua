








local ballTable={}
local MATH_SQRT_=math.sqrt
local MATH_SQRT_3=MATH_SQRT_(3)
local MATH_FLOOR_=math.floor
local MATH_CEIL_=math.ceil

local neighborDirectionType={
eLeftTop=1,
eRightTop=2,
eRight=3,
eRightBottom=4,
eLeftBottom=5,
eLeft=6,
}

local neighborDirectionFunc={
[neighborDirectionType.eLeftTop]=function(row,col,isEven)
if isEven==true then
return row-1,col
else
return row-1,col-1
end
end,
[neighborDirectionType.eRightTop]=function(row,col,isEven)
if isEven==true then
return row-1,col+1
else
return row-1,col
end
end,
[neighborDirectionType.eRight]=function(row,col,isEven)
return row,col+1
end,
[neighborDirectionType.eRightBottom]=function(row,col,isEven)
if isEven==true then
return row+1,col+1
else
return row+1,col
end
end,
[neighborDirectionType.eLeftBottom]=function(row,col,isEven)
if isEven==true then
return row+1,col
else
return row+1,col-1
end
end,
[neighborDirectionType.eLeft]=function(row,col,isEven)
return row,col-1
end,
}

function ballTable:__init(basecfg,cfg,data)
self.sCfg=basecfg
self:initCfg(cfg)
self:initData(data)
end


function ballTable:initCfg(cfg)
local hw=self:calculateTableHalfWidth()
self.leftWall=-hw
self.rightWall=hw

self.halfHeight=self:calculateTableHalfHeight(self.sCfg.tableRow)

self.shooterPosX=0
self.shooterPosY=-self.halfHeight+self.sCfg.shooterOffsetY
end


function ballTable:initData(data)
self.gameid=data.id
self.groupid=data.groupid
self.level=data.level
self.score=data.score

local moveRow=data.moveRow
if moveRow==nil then
moveRow=self:calculateMoveRow2(data.balls)
end
self:changeMoveRow(moveRow)

local ballsLookup={}
self.ballsLookup={}
for i,v in ipairs(data.balls)do
self:createBall(v)
end

self.ballSortList=nil
for _,ball in pairs(self.ballsLookup)do
self:initBallNeighborBall(ball)
end

self:initShootColor(data.waitBalls)
end


function ballTable:decomposeKey(key)
local index=MATH_FLOOR_(key/100)
local color=key%100
local row,col=self:decomposeIndex(index)
return index,row,col,color
end


function ballTable:mergeKey(row,col,color)
local idx=self:mergeIndex(row,col)
return idx*100+color
end


function ballTable:decomposeIndex(index)
local maxCol=self.sCfg.maxCol
local row=MATH_CEIL_(index/maxCol)
local col=index%maxCol
if col==0 then
col=maxCol
end
return row,col
end


function ballTable:mergeIndex(row,col)
return(row-1)*self.sCfg.maxCol+col
end


function ballTable:indexOffsetRow(index,row)
return index+row*self.sCfg.maxCol
end


function ballTable:calculateTableHalfWidth()
return self.sCfg.ballRadius*self.sCfg.maxCol
end


function ballTable:calculateTableHalfHeight(tableRow)
return(2+(tableRow-1)*MATH_SQRT_3)*self.sCfg.ballRadius/2
end


function ballTable:getShootAngle(clickx,clicky)
local vx=clickx-self.shooterPosX
local vy=clicky-self.shooterPosY
local angle=self.physics.vectorsAngle(vx,vy)
local angle_deg=math.deg(angle)

if vy<0 then
angle_deg=angle_deg+180
angle=-angle
end
return angle,angle_deg
end


function ballTable:isValidAngle(angle_deg)
return angle_deg>=self.sCfg.minShootAngle and angle_deg<=self.sCfg.maxShootAngle
end


function ballTable:getDropRowCol(k,b,hitx,hity,ball)
local row,col,x,y
if ball==nil then

local r=self.sCfg.ballRadius
local maxCol=self.sCfg.maxCol
row=1
col=MATH_FLOOR_((hitx+r*maxCol)/(r+r))+1
x,y=self:getPosByRowCol(row,col)
if k~=nil then
local dropSlope=self.sCfg.dropSlope
if k>0 and k<=dropSlope and hitx>x and col<maxCol then
local idx=self:mergeIndex(row,col+1)
if self.ballsLookup[idx]==nil then
col=col+1
end
elseif k<0 and k>=-dropSlope and hitx<x and col>1 then
local idx=self:mergeIndex(row,col-1)
if self.ballsLookup[idx]==nil then
col=col-1
end
end
end
return row,col
else

local dis,dis_,row_,col_,typo,typo_
for typo_,idx in pairs(ball.neighbor)do
if ball.neighborBall[typo_]==nil then
row_,col_=self:decomposeIndex(idx)
x,y=self:getPosByRowCol(row_,col_)
dis_=self.physics.twoPosDistance(hitx,hity,x,y)
if dis==nil or dis_<dis or(dis_==dis and typo_<typo)then
dis=dis_
row=row_
col=col_
typo=typo_
end
end
end
if row~=nil then
return row,col
end
end
end


function ballTable:getPosByRowCol(row,col,moveRow)
moveRow=moveRow or self.moveRow
local r=self.sCfg.ballRadius
local movex=row%2==0 and r or 0
return r*(2*col-1-self.sCfg.maxCol)+movex,self.halfHeight-r*(1+(row-1-moveRow)*MATH_SQRT_3)
end


function ballTable:changeMoveRow(moveRow_)
local moveRow=self.moveRow
if moveRow~=moveRow_ then
self.moveRow=moveRow_
self.topWall=self.halfHeight+moveRow_*self.sCfg.ballRadius*MATH_SQRT_3
return true
end
return false
end




function ballTable:getSortBalls()
local ballSortList=self.ballSortList
if ballSortList==nil or self.changeBallList==true then
ballSortList={}
local n=0
for _,ball in pairs(self.ballsLookup)do
n=n+1
ballSortList[n]=ball
end
if n>1 then
table.sort(ballSortList,function(a,b)
return a.index<b.index
end)
end
self.ballSortList=ballSortList
self.changeBallList=nil
end
return ballSortList
end


function ballTable:createBall(key,moveRow)
local index,row,col,color=self:decomposeKey(key)
local ball=self:createBallEx(index,row,col,color,moveRow)
self.ballsLookup[index]=ball
self.changeBallList=true
return ball
end


function ballTable:createBallEx(index,row,col,color,moveRow)
local ball=self.newBall(index,row,col,color)
local x,y=self:getPosByRowCol(row,col,moveRow)
ball:setPos(x,y)
return ball
end


function ballTable:insertBalls(balls)
local _,insertRow=self:decomposeKey(balls[#balls])
local lp={}
local newBalls={}
local ball_,idx_,row_,col_,color_
for _,ball__ in pairs(self.ballsLookup)do
row_=ball__.row+insertRow
col_=ball__.col
idx_=self:mergeIndex(row_,col_)
ball__:setRowCol(idx_,row_,col_)
lp[idx_]=ball__
end
local moveRow=self.moveRow+insertRow
for i,v in ipairs(balls)do
idx_,row_,col_,color_=self:decomposeKey(v)
ball_=self:createBallEx(idx_,row_,col_,color_,moveRow)
lp[idx_]=ball_
table.insert(newBalls,ball_)
end
self.ballsLookup=lp
self.ballSortList=nil
for _,ball__ in pairs(self.ballsLookup)do
self:initBallNeighborBall2(ball__)
end
return newBalls,insertRow,moveRow
end


function ballTable:removeBall(index)
self.ballsLookup[index]=nil
self.changeBallList=true
end


function ballTable:getBall(index)
return self.ballsLookup[index]
end


function ballTable:initBallNeighbor(ball)
local neighbor={}
local row=ball.row
local col=ball.col
local isEven=row%2==0
local row_,col_
for _,typo in pairs(neighborDirectionType)do
row_,col_=self:getNeighborIndex(typo,row,col,isEven)
if row_~=nil then
neighbor[typo]=self:mergeIndex(row_,col_)
end
end
ball.neighbor=neighbor
end


function ballTable:initBallNeighborBall(ball)
local neighbor=ball.neighbor
if neighbor==nil then
self:initBallNeighbor(ball)
neighbor=ball.neighbor
end
local neighborBall={}
for typo,idx in pairs(neighbor)do
if self.ballsLookup[idx]~=nil then
neighborBall[typo]=idx
end
end
ball.neighborBall=neighborBall
end

function ballTable:initBallNeighborBall2(ball)
self:initBallNeighbor(ball)
local neighbor=ball.neighbor
local neighborBall={}
for typo,idx in pairs(neighbor)do
if self.ballsLookup[idx]~=nil then
neighborBall[typo]=idx
end
end
ball.neighborBall=neighborBall
end


function ballTable:getNeighborIndex(typo,row,col,isEven)
local func=neighborDirectionFunc[typo]
local row_,col_=func(row,col,isEven)
if row_>0 and col_>0 then
local maxCol=self.sCfg.maxCol
local isEven_=row_%2==0
if isEven_==true then
maxCol=maxCol-1
end
if col_<=maxCol then
return row_,col_
end
end
return nil,nil
end


function ballTable:getNeighborMergeIndex(row,col)
local neighbor={}
local isEven=row%2==0
local row_,col_
for _,typo in pairs(neighborDirectionType)do
row_,col_=self:getNeighborIndex(typo,row,col,isEven)
if row_~=nil then
neighbor[typo]=self:mergeIndex(row_,col_)
end
end
return neighbor
end


function ballTable:refreshBallNeighborBall(ball)
local neighborBall=ball.neighborBall
for typo,idx in pairs(ball.neighbor)do
if self.ballsLookup[idx]~=nil then
neighborBall[typo]=idx
else
neighborBall[typo]=nil
end
end
end


function ballTable:refreshBallRoundNeighborBall(ball)
local neighborBall=ball.neighborBall
for typo,idx in pairs(neighborBall)do
local ball_=self.ballsLookup[idx]
if ball_~=nil then
self:refreshBallNeighborBall(ball_)
end
end
end


function ballTable:calculateDelBalls(dropRow,dropCol,color)

local delBalls={}
local n=0
local idx=self:mergeIndex(dropRow,dropCol)
local ball=self:createBallEx(idx,dropRow,dropCol,color)
self:initBallNeighborBall(ball)
local lp=self.ballsLookup
local ball_
local open={}
local close={}
for _,idx_ in pairs(ball.neighborBall)do
open[idx_]=true
end
local idx2=next(open)
while idx2~=nil do
open[idx2]=nil
if close[idx2]==nil then
close[idx2]=true
ball_=lp[idx2]
if ball_.color==color then
n=n+1
delBalls[n]=idx2
for _,idx_ in pairs(ball_.neighborBall)do
if close[idx_]==nil then
open[idx_]=true
end
end
end
end
idx2=next(open)
end
if n>=2 then
delBalls[n+1]=idx
return delBalls
end
end


function ballTable:calculateDropBalls(delBalls,dropRow,dropCol,color)


local rootlp={}
local lp={}
for idx_,ball_ in pairs(self.ballsLookup)do
lp[idx_]=ball_
if ball_.row==1 then
rootlp[idx_]=true
end
end
if delBalls~=nil then
for _,idx_ in ipairs(delBalls)do
lp[idx_]=nil
rootlp[idx_]=nil
end
else
local idx_=self:mergeIndex(dropRow,dropCol)
local ball_=self:createBallEx(idx_,dropRow,dropCol,color)
self:initBallNeighbor(ball_)
lp[idx_]=ball_
if ball_.row==1 then
rootlp[idx_]=true
end
end

local droplp={}
local dropBalls={}
local n=0
for idx_,ball_ in pairs(lp)do
if rootlp[idx_]==nil and droplp[idx_]==nil then
local open={}
local close={}
local check=false
open[idx_]=true
local idx2=idx_
local ball2
while idx2~=nil and check==false do
open[idx2]=nil
if close[idx2]==nil then
close[idx2]=true
ball2=lp[idx2]
for _,idx__ in pairs(ball2.neighbor)do
if lp[idx__]~=nil then
if rootlp[idx__]~=nil then
check=true
break
elseif droplp[idx__]~=nil then
check=nil
break
else
if close[idx__]==nil then
open[idx__]=true
end
end
end
end
end
idx2=next(open)
end
if check==true then
rootlp[idx_]=true
else
droplp[idx_]=true
n=n+1
dropBalls[n]=idx_
end
end
end
if n>0 then
return dropBalls
end
end


function ballTable:calculateSelectBalls(ballRow,ballCol,color,specialParam)

local delBalls={}
local n=0
local idx=self:mergeIndex(ballRow,ballCol)
local ball=self:createBallEx(idx,ballRow,ballCol,color)
self:initBallNeighborBall(ball)
local lp=self.ballsLookup
local ball_
local open={}
local close={}
local floorLp={}
local minRow=ballRow
for _,idx_ in pairs(ball.neighborBall)do
open[idx_]=true
floorLp[idx_]=1
ball_=lp[idx_]
if ball_ and ball_.row<minRow then
minRow=ball_.row
end
end
local delFloor
if color==bbBallColor.eFunc1 then
if specialParam[color]then
delFloor=specialParam[color][1]
for _,idx_ in pairs(ball.neighbor)do
open[idx_]=true
floorLp[idx_]=1
end
end
elseif color==bbBallColor.eFunc2 then
local minCol=1
local maxCol=self.sCfg.maxCol
for col=minCol,maxCol do
local checkIdx=self:mergeIndex(minRow,col)
ball_=lp[checkIdx]
if ball_ then
open[checkIdx]=true
end
end
end
local idx2=next(open)
while idx2~=nil do
open[idx2]=nil
if close[idx2]==nil then
close[idx2]=true
ball_=lp[idx2]
local floor=floorLp[idx2]
if color==bbBallColor.eFunc1 then

if floor and floor<=delFloor then
local neighbor
if ball_ then
n=n+1
delBalls[n]=idx2
neighbor=ball_.neighbor
else
local row,col=self:decomposeIndex(idx2)
neighbor=self:getNeighborMergeIndex(row,col)
end
for _,idx_ in pairs(neighbor)do
local floor_=floorLp[idx_]
if close[idx_]==nil and not floor_ and floor<delFloor then
floorLp[idx_]=floor+1
open[idx_]=true
end
end
end
elseif color==bbBallColor.eFunc2 then

if ball_.row==minRow then
n=n+1
delBalls[n]=idx2
end
elseif bbBallNormalColor[color]then
if ball_.color==color then
n=n+1
delBalls[n]=idx2
for _,idx_ in pairs(ball_.neighborBall)do
if close[idx_]==nil then
open[idx_]=true
end
end
end
end
end
idx2=next(open)
end

if bbBallNormalColor[color]then
if n>=2 then
delBalls[n+1]=idx
return delBalls
end
else
return delBalls
end
end



function ballTable:calculateMaxRow(lp)
lp=lp or self.ballsLookup
local maxRow=1
for idx_,ball_ in pairs(lp)do
if ball_.row>maxRow then
maxRow=ball_.row
end
end
return maxRow
end

function ballTable:calculateMaxRow2(balls)
local maxRow=0
for i,v in ipairs(balls)do
local index,row,col,color=self:decomposeKey(v)
if row>maxRow then
maxRow=row
end
end
return maxRow
end

function ballTable:calculateMaxRow3()
local list=self:getSortBalls()
local ball=list[#list]
if ball~=nil then
return ball.row
end
return 0
end


function ballTable:calculateMoveRow1(delBalls,dropBalls,dropRow,dropCol,color)



local lp={}
for idx_,ball_ in pairs(self.ballsLookup)do
lp[idx_]=ball_
end
if delBalls~=nil then
for _,idx_ in ipairs(delBalls)do
lp[idx_]=nil
end
elseif dropRow~=nil then
local idx_=self:mergeIndex(dropRow,dropCol)
local ball_=self:createBallEx(idx_,dropRow,dropCol,color)
self:initBallNeighbor(ball_)
lp[idx_]=ball_
end
if dropBalls~=nil then
for _,idx_ in ipairs(dropBalls)do
lp[idx_]=nil
end
end
local maxRow=self:calculateMaxRow(lp)
local newBalls
local moveRow=self.moveRow
if maxRow==3 then



newBalls=bubbleShooterModel:getLevelBalls(self.groupid,self.level)
local addRow=self:calculateMaxRow2(newBalls)
if addRow%2==1 then
for i=1,#newBalls do
table.insert(newBalls,bubbleShooterModel:getKeyOffsetRow(newBalls[i],addRow))
end
addRow=addRow+addRow
end
maxRow=maxRow+addRow
moveRow=moveRow+addRow
end
return self:calculateMoveRow(maxRow,moveRow),newBalls
end


function ballTable:calculateMoveRow2(balls)
local maxRow=self:calculateMaxRow2(balls)
return self:calculateMoveRow(maxRow,0)
end


function ballTable:calculateMoveRow(maxRow,moveRow)
local bottomRow=maxRow-moveRow
if bottomRow<1 then bottomRow=1 end
local move=0
local lerp
lerp=bottomRow-self.sCfg.backLine
if lerp>0 then
move=bottomRow-self.sCfg.standardLine
end
lerp=bottomRow-self.sCfg.bornLine
if lerp<0 then
move=bottomRow-self.sCfg.standardLine
end
move=moveRow+move
if move<0 then move=0 end
return move
end


function ballTable:calculateShowRow()
local maxRow=self:calculateMaxRow3()
local lerp=maxRow-self.moveRow
if lerp<0 then lerp=0 end
return lerp
end

function ballTable:calculateRowLinePosY(row)
local r=self.sCfg.ballRadius
return self.halfHeight-r*(2+(row-1)*MATH_SQRT_3)
end






function ballTable:initShootColor(waitBalls)
local waitBalls_=self.waitBalls
if waitBalls_==nil then
waitBalls_={}
self.waitBalls=waitBalls_
end
waitBalls_[1]=waitBalls[1]
waitBalls_[2]=waitBalls[2]
end


function ballTable:getShootColor(idx)
idx=idx or 1
return self.waitBalls[idx]
end


function ballTable:changeShootColor(idx,color)
self.waitBalls[idx]=color
end


function ballTable:swapShootColor()
local list=self.waitBalls
local temp=list[1]
list[1]=list[2]
list[2]=temp
end



return ballTable