







function xianjieController:handlePathPosData(sceneidx,gridX,gridZ)

local data={}
data.sceneidx=sceneidx
data.gridX=gridX
data.gridZ=gridZ
data.areaID=xianjieModel:checkMapGridDataAreaID(sceneidx,math.floor(gridX),math.floor(gridZ))
local worldX,worldY,worldZ=xianjieController:worldGridPos2WorldPos3(gridX,gridZ,sceneidx)
data.worldX=worldX
data.worldY=worldY
data.worldZ=worldZ
data.getWorldPos=function(self_)
return Vector3(self_.worldX,self_.worldY,self_.worldZ)
end
data.getWorldPos_1=function(self_)
return xianjieController:worldGridPos2WorldPos41(self_.gridX,self_.gridZ,self_.sceneidx)
end
return data
end

function xianjieController:checkTwoSceneHasPath(s_sceneidx,e_sceneidx)
if s_sceneidx~=e_sceneidx then
local transferData=xianjieModel:getTransfer(s_sceneidx,e_sceneidx)
return transferData~=nil
end
return true
end




function xianjieController:getMovePath(s_sceneidx,s_gridX,s_gridZ,e_sceneidx,e_gridX,e_gridZ,areaTransferSelects,isIgnoreArea)
local movePath=xianjieController:getMovePath2(s_sceneidx,s_gridX,s_gridZ,e_sceneidx,e_gridX,e_gridZ)

local rpos,epos,areaPath
for idx=#movePath,2,-1 do
epos=movePath[idx]
rpos=movePath[idx-1]
if rpos.sceneidx==epos.sceneidx and rpos.areaID~=epos.areaID and not isIgnoreArea then
areaPath=xianjieController:getAreaPath(rpos,epos,areaTransferSelects)
if areaPath~=nil and#areaPath>0 then
table.insertTable(movePath,areaPath,idx)
end
end
end
return movePath
end

function xianjieController:getMovePath2(s_sceneidx,s_gridX,s_gridZ,e_sceneidx,e_gridX,e_gridZ)
local movePath={}

local sposData=xianjieController:handlePathPosData(s_sceneidx,s_gridX,s_gridZ)
xianjieController:movePathAdd(movePath,sposData)

if s_sceneidx~=e_sceneidx then

local transferData1=xianjieModel:getTransfer(s_sceneidx,e_sceneidx)
local posData1=xianjieController:handlePathPosData(transferData1.sceneidx,transferData1.gridX,transferData1.gridZ)
xianjieController:movePathAdd(movePath,posData1)
local transferData2=xianjieModel:getTransfer(e_sceneidx,s_sceneidx)
local posData2=xianjieController:handlePathPosData(transferData2.sceneidx,transferData2.gridX,transferData2.gridZ)
xianjieController:movePathAdd(movePath,posData2)
end

local eposData=xianjieController:handlePathPosData(e_sceneidx,e_gridX,e_gridZ)
xianjieController:movePathAdd(movePath,eposData)
return movePath
end

function xianjieController:getMovePath3(pathPosList)
local movePath={}
for i,pathPos in ipairs(pathPosList)do
local sceneidx=pathPos.sceneidx
local gridX=pathPos.gridX
local gridZ=pathPos.gridZ

local posData=xianjieController:handlePathPosData(sceneidx,gridX,gridZ)
xianjieController:movePathAdd(movePath,posData)
end
return movePath
end





function xianjieController:checkMovePath(bornAreaID,s_sceneidx,s_gridX,s_gridZ,e_sceneidx,e_gridX,e_gridZ,isWarning,isPvP,isMove)
local rpos,epos,g_list
local isMJ=xianjienSceneIndexType:isMoJie(s_sceneidx)
local isMG=xianjienSceneIndexType:isMoGongZhengDuo(s_sceneidx)
local movePath=xianjieController:getMovePath2(s_sceneidx,s_gridX,s_gridZ,e_sceneidx,e_gridX,e_gridZ)

local isBornAreaPath=true
for idx=#movePath,2,-1 do
epos=movePath[idx]
rpos=movePath[idx-1]
if rpos.sceneidx==epos.sceneidx then
if rpos.areaID~=epos.areaID then
isBornAreaPath=false

if isMJ or isMG then
if isMove then

if bornAreaID>0 and epos.areaID>0 and bornAreaID~=epos.areaID then
if isWarning then
UIManager.error('无法迁移至其他仙域本阵')
end
return false,nil
end
else
local errorParams={
isSelfInNeutralArea=rpos.areaID<=0,
isTargetInNeutralArea=epos.areaID<=0,
}
return false,nil,errorParams
end






















end

local flag,v=xianjieModel:checkAreaTransfers(rpos.sceneidx,rpos.gridX,rpos.gridZ,rpos.areaID,epos.gridX,epos.gridZ,epos.areaID)
if v~=nil then
if g_list==nil then g_list={}end
table.insert(g_list,v[4])
end
if not flag and(not isMG)then
if isWarning then
UIManager.error('前往此处的关口尚未打通，无法前往')
end
return false,g_list
end
else
if isMG then
if epos.areaID>0 or rpos.areaID>0 then
isBornAreaPath=true
elseif epos.areaID~=bornAreaID or rpos.areaID~=bornAreaID then
isBornAreaPath=false
end
else
if epos.areaID~=bornAreaID or rpos.areaID~=bornAreaID then
isBornAreaPath=false
end
end
end
else
isBornAreaPath=false
end

if(isMJ or isMG)and isPvP and isBornAreaPath then
local errorParams={
isBornAreaPath=isBornAreaPath
}
return false,nil,errorParams
end
end
return true,g_list
end


function xianjieController:getAreaPath(rpos,epos,areaTransferSelects)
local v=xianjieModel:getAreaTransfers(rpos,epos,areaTransferSelects)
if v then
local list={}
local gridX,gridZ=xianjieController:worldGridCenterPos(v[1][1],v[1][2],1,1)
local posData=xianjieController:handlePathPosData(rpos.sceneidx,gridX,gridZ)
list[1]=posData
gridX,gridZ=xianjieController:worldGridCenterPos(v[2][1],v[2][2],1,1)
posData=xianjieController:handlePathPosData(rpos.sceneidx,gridX,gridZ)
list[2]=posData
return list
end
end

function xianjieController:movePathAdd(movePath,pos)
local n=#movePath
if n>0 then
local eposData=movePath[n]
if eposData.sceneidx~=pos.sceneidx or eposData.gridX~=pos.gridX or eposData.gridZ~=pos.gridZ then
movePath[n+1]=pos
end
else
movePath[n+1]=pos
end
end

function xianjieController:getMovePathToPosList(movePath,sceneidx,isIgnoreArea)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local poslist={}
local linePos={}
local n=#movePath
for i=1,n do
local posData1=movePath[i]
if posData1.sceneidx==sceneidx then
local pos1=posData1:getWorldPos_1()
table.insert(poslist,pos1)
if i<n then
local posData2=movePath[i+1]
if posData2.sceneidx==posData1.sceneidx and(isIgnoreArea or posData2.areaID==posData1.areaID)then
local pos2=posData2:getWorldPos_1()
table.insert(linePos,pos1)
table.insert(linePos,pos2)
end
end
end
end
return poslist,linePos
end

function xianjieController:getMovePathToLinePosList(movePath,sceneidx,isIgnoreArea)
sceneidx=sceneidx or xianjieModel:getSceneIndex()
local linePos={}
for i=1,#movePath-1 do
local posData1=movePath[i]
local posData2=movePath[i+1]
if posData1.sceneidx==sceneidx and posData2.sceneidx==posData1.sceneidx and(isIgnoreArea or posData2.areaID==posData1.areaID)then
local pos1=posData1:getWorldPos_1()
local pos2=posData2:getWorldPos_1()
table.insert(linePos,pos1)
table.insert(linePos,pos2)
end
end
return linePos
end

function xianjieController:getMovePathClickPos(movePath,hitpos,isIgnoreArea)
local linePos=xianjieController:getMovePathToLinePosList(movePath,isIgnoreArea)
for i=1,#linePos-1 do
local pos1=linePos[i]
local pos2=linePos[i+1]
local errVal=2
local flag,x,z=mathHelper.posInLine(hitpos.x,hitpos.z,pos1.x,pos1.z,pos2.x,pos2.z,errVal)
if flag then
return true,pos1,pos2,Vector3(x,pos1.y,z)
end
end
return false,nil,nil,nil
end

function xianjieController:getMovePathDistance(movePath,isIgnoreArea)
local dis=0
if movePath then
local n=#movePath
for i=1,#movePath-1 do
local posData1=movePath[i]
local posData2=movePath[i+1]

if posData1.sceneidx==posData2.sceneidx and(isIgnoreArea or posData1.areaID==posData2.areaID)then
local dis_=mathHelper.distance(posData1.gridX,posData1.gridZ,posData2.gridX,posData2.gridZ)
dis=dis+dis_
end
end
end
return dis
end

function xianjieController:getMovePathWayTime(movePath,speed,isIgnoreArea)
local dis=xianjieController:getMovePathDistance(movePath,isIgnoreArea)
local wayTime=dis/speed
return wayTime
end

function xianjieController:getMovePathWayTime2(movePath,speedlist,isBack,battleTime,isIgnoreArea)
local resdis=xianjieController:getMovePathDistance(movePath,isIgnoreArea)
local dis=resdis
local time=0
local sData1,sData2,speed
local n=#speedlist
if n==1 then
sData1=speedlist[1]
speed=sData1.param_2
time=dis/speed
dis=0
elseif n>1 then
local idx
for i=2,n do
idx=i-1
sData1=speedlist[idx]
sData2=speedlist[i]
local lerpTime=sData2.param_1-sData1.param_1
speed=sData1.param_2
local dis_=speed*lerpTime
if dis_>=dis then
time=time+dis/speed
dis=0
break
else
time=time+lerpTime
dis=dis-dis_
end
end
if dis>0 then
idx=n
speed=speedlist[idx].param_2
time=time+dis/speed
dis=0
end
if isBack then
battleTime=battleTime or 0
local bTime=speedlist[1].param_1+time+battleTime
time=0
dis=resdis
if idx>=n then
time=dis/speed
dis=0
else
for i=idx+1,n do
idx=i-1
sData1=speedlist[idx]
sData2=speedlist[i]
local lerpTime=sData2.param_1-bTime
speed=sData1.param_2
local dis_=speed*lerpTime
if dis_>=dis then
time=time+dis/speed
dis=0
break
else
time=time+lerpTime
dis=dis-dis_
bTime=bTime+lerpTime
end
end
if dis>0 then
idx=n
speed=speedlist[idx].param_2
time=time+dis/speed
dis=0
end
end
end
end
return time
end

function xianjieController:getMoveTagList(movePath,bTime,speedlist,isIgnoreArea)

local speedIndex
local n=#speedlist
for i=n,1,-1 do
if bTime>=speedlist[i].param_1 then
speedIndex=i
break
end
end
if speedIndex==nil then
speedIndex=1
end

local movelist={}
for i=speedIndex,n do
local sData1=speedlist[i]
local speed_=sData1.param_2
local move_={speed_}
if i>speedIndex then
move_[2]=sData1.param_1
else
move_[2]=bTime
end
if i<n then
local sData2=speedlist[i+1]
move_[3]=sData2.param_1
move_[4]=speed_*(move_[3]-move_[2])
end
table.insert(movelist,move_)
end

local movePathNum=#movePath
local taglist={}
for i=1,movePathNum-1 do
local posData1=movePath[i]
local posData2=movePath[i+1]

if posData1.sceneidx==posData2.sceneidx and(isIgnoreArea or posData1.areaID==posData2.areaID)then
local tag={posData1:getWorldPos(),posData2:getWorldPos(),posData1.sceneidx}
tag[4]=mathHelper.distance(posData1.gridX,posData1.gridZ,posData2.gridX,posData2.gridZ)
table.insert(taglist,tag)
end
end

local taglist2={}
local moveMaxIndex=#movelist
local moveIndex=1
local move=movelist[moveIndex]
if move then
for i,tag in ipairs(taglist)do
while tag[4]>0 do
local speed_=move[1]
local st=move[2]
local et=move[3]
local moveDis=move[4]
if moveDis~=nil then

if moveDis==tag[4]then

move[4]=0
tag[4]=0
local tag2={tag[1],tag[2],tag[3],st,et,speed_}
table.insert(taglist2,tag2)
if moveIndex<moveMaxIndex then
moveIndex=moveIndex+1
move=movelist[moveIndex]
end
elseif moveDis>tag[4]then

moveDis=moveDis-tag[4]
move[4]=moveDis
local t1=st
local t2=t1+tag[4]/speed_
move[2]=t2
tag[4]=0
local tag2={tag[1],tag[2],tag[3],t1,t2,speed_}
table.insert(taglist2,tag2)
else

move[4]=0
local rate_=moveDis/tag[4]

local m_x_,m_y_=mathHelper.calculateMovePos3(tag[1].x,tag[1].z,tag[2].x,tag[2].z,nil,rate_)
local spos_=tag[1]
local epos_=Vector3(m_x_,tag[1].y,m_y_)
local t1=st
local t2=et
tag[1]=epos_
tag[4]=tag[4]-moveDis
local tag2={spos_,epos_,tag[3],t1,t2,speed_}
table.insert(taglist2,tag2)
if moveIndex<moveMaxIndex then
moveIndex=moveIndex+1
move=movelist[moveIndex]
end
end
else

local t1=st
local t2=t1+tag[4]/speed_
move[2]=t2
tag[4]=0
local tag2={tag[1],tag[2],tag[3],t1,t2,speed_}
table.insert(taglist2,tag2)
end
end
end
end
return taglist2
end

function xianjieController:getMoveTagListIndex(taglist)

local cTime=gameUtilityModel.getServerShortTime2()
if cTime<taglist[1][4]then
return 0
else
for i,tag in ipairs(taglist)do
if cTime>=tag[4]and cTime<tag[5]then
return i
end
end
return#taglist
end
end
















































function xianjieController:getMoveTagLerpMovePos(taglist,idx,maskHeight,atkSize,atkOffset)

local cTime=gameUtilityModel.getServerShortTime2()
local max=#taglist
local isLast=idx>=max
local calEnd=isLast and atkSize~=nil
local tag
if idx<=0 then
tag=taglist[1]
else
tag=taglist[idx]
end
local sceneidx=tag[3]
local lTime,sPos,ePos,cpos,speed,sPos2,ePos2
if maskHeight then
sPos=tag[1]
ePos=tag[2]
else
sPos=xianjieController:worldPos2worldPos(tag[1].x,tag[1].z,sceneidx)
ePos=xianjieController:worldPos2worldPos(tag[2].x,tag[2].z,sceneidx)

local maxH=math.max(sPos.y,ePos.y)
sPos.y=maxH
ePos.y=maxH
end
sPos2=sPos
ePos2=ePos
if calEnd then

local rot=math.atan2(sPos.z-ePos.z,sPos.x-ePos.x)
local atkOffsetX=atkOffset[1]
local atkOffsetZ=atkOffset[2]
local ox=(atkSize.x+atkOffsetX)*math.cos(rot)
local oy=(atkSize.y+atkOffsetZ)*math.sin(rot)
local oz=(atkSize.y+atkOffsetZ)*math.sin(rot)
ePos=Vector3.New(ox+ePos.x,ePos.y,oz+ePos.z)
end
local lerp=tag[5]-tag[4]
local lTime=tag[5]-cTime
if lTime<0 then lTime=0 end
local rate=(cTime-tag[4])/lerp
local m_x,m_y=mathHelper.calculateMovePos3(sPos.x,sPos.z,ePos.x,ePos.z,nil,rate)
if rate>1 then
rate=1
elseif rate<0 then
rate=0
end
local height=sPos.y+(ePos.y-sPos.y)*rate
local cpos=Vector3(m_x,height,m_y)
local speed=tag[6]





return sceneidx,cpos,lTime,sPos,ePos,speed,isLast,sPos2,ePos2
end

















































































































































