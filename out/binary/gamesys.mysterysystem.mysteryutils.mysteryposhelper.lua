







mysteryPosHelper={}

local _HexMapManager=CS.HexagonMapManagerInterface
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int
local IsCanMove=_HexMapManager.IsCanMove

mysteryPosHelper.ArrowType=
{
Left=1,
Right=2,
LeftTop=3,
RightTop=4,
LeftBottom=5,
RightBottom=6,
}



local function checkRange(originPos,targetPos,range,originRoom,targetRoom)
local posList=mysteryPosHelper.get_passable_near_pos_list(originPos,1)
if range==1 then
if mysteryPosHelper.is_same_pos(originPos,targetPos,originRoom,targetRoom)then
return true
end
for i,v in ipairs(posList)do
if mysteryPosHelper.is_same_pos(targetPos,v,originRoom,targetRoom)then
return true
end
end
return false
elseif range==0 then
if mysteryPosHelper.is_same_pos(originPos,targetPos,originRoom,targetRoom)then
return true
end
return false
end
for i,v in ipairs(posList)do
if checkRange(v,targetPos,range-1)then
return true
end
end
return false
end


function mysteryPosHelper.is_in_check_range(originPos,targetPos,range,originRoom,targetRoom)
if mysteryPosHelper.is_same_pos(originPos,targetPos,originRoom,targetRoom)then
return true
end

local isIn=checkRange(originPos,targetPos,range)

return isIn
end


function mysteryPosHelper.is_same_pos(pos1,pos2,room1,room2)
room1=room1 or 0
room2=room2 or 0
if room1==room2 and pos1.x==pos2.x and pos1.y==pos2.y then
return true
end
return false
end


















function mysteryPosHelper.ToFixPos(pos)
return Vector3(pos.x+(pos.y+(pos.y%2))/2,pos.y,pos.z)
end

function mysteryPosHelper.ToOriPos(pos)
return Vector3(pos.x-(pos.y+(pos.y%2))/2,pos.y,pos.z)
end


function mysteryPosHelper.get_cube_pos(pos)
return{x=-pos.x,y=pos.x-pos.y,z=pos.y,}
end


function mysteryPosHelper.get_cube_pos_distance(pos1,pos2)
return(math.abs(pos1.x-pos2.x)+math.abs(pos1.y-pos2.y)+math.abs(pos1.z-pos2.z))/2
end


function mysteryPosHelper.get_pos_distance(pos1,pos2)
local cubePos1=mysteryPosHelper.get_cube_pos(pos1)
local cubePos2=mysteryPosHelper.get_cube_pos(pos2)
return mysteryPosHelper.get_cube_pos_distance(cubePos1,cubePos2)
end


function mysteryPosHelper.get_round_pos_list(pos,round)
local posList={}
local targetPos
for x=pos.x-round,pos.x+round do
for y=pos.y-round,pos.y+round do
targetPos={x=x,y=y}
if mysteryPosHelper.get_pos_distance(targetPos,pos)==round then
table.insert(posList,Vector3(x,y,0))
end
end
end
return posList
end


function mysteryPosHelper.get_all_round_pos_list(pos,round)
local posList={}
for i=0,round do
for x=pos.x-i,pos.x+i do
for y=pos.y-i,pos.y+i do
local target=Vector3(x,y,0)
if mysteryPosHelper.get_pos_distance(target,pos)==i then
table.insert(posList,target)
end
end
end
end
return posList
end

function mysteryPosHelper.check_in_round(pos,targetPos,round,originRoom,targetRoom)
local roundList={}
for i=0,round do
roundList=mysteryPosHelper.get_round_pos_list(pos,i)
for i,v in ipairs(roundList)do
if mysteryPosHelper.is_same_pos(v,targetPos,originRoom,targetRoom)then
return true
end
end
end
end

function mysteryPosHelper.isCanMove(pos,roomId)
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local surface=mysteryRoomModel:get_grid_pos_data(roomId,pos.x,pos.y)
if not surface then
return false
end

if mysteryObstacleModel:is_obstacle_pos(roomId,pos)then
return false
end

local surfaceId=surface.surfaceId
local surfaceCfg=cfgHelper.get(cfg_secretscentsurfaceconfig_get,surfaceId)
if not surfaceCfg then
return false
end
return surfaceCfg.allowPass
end

local function checkPassableNearPosList(originPos,range,roomId)



local nearPosList=mysteryPosHelper.get_round_pos_list(originPos,1)
if range<=1 then
local passPosList={}

for i,v in ipairs(nearPosList)do

if mysteryPosHelper.isCanMove(Vector3(v.x,v.y,0),roomId)then
passPosList[#passPosList+1]=v
end
end

return passPosList
end

local allPosList={}
for i,v in ipairs(nearPosList)do
for j,w in ipairs(checkPassableNearPosList(v,range-1),roomId)do
allPosList[#allPosList+1]=w
end
end
return allPosList
end


function mysteryPosHelper.get_passable_near_pos_list(originPos,range,roomId)
roomId=roomId or mysteryRoomModel:get_cur_roomID()
local allPosList=checkPassableNearPosList(originPos,range,roomId)

local sortPoslist={}
for i,v in ipairs(allPosList)do
local has=false
for j,w in ipairs(sortPoslist)do
if mysteryPosHelper.is_same_pos(v,w)then
has=true
end
end
if has==false then
sortPoslist[#sortPoslist+1]=v
end
end
return sortPoslist
end


function mysteryPosHelper.is_near_pos(oriPos,nearPos,round)



local nearPosList=mysteryPosHelper.get_round_pos_list(oriPos,round or 1)

for i,v in pairs(nearPosList)do
if nearPos.x==v.x and nearPos.y==v.y then
return true
end
end

return false
end


local function checkRangeSixPosList(originPos,range)
local posList={
[mysteryPosHelper.ArrowType.Left]=Vector3(originPos.x-range,originPos.y,0),
[mysteryPosHelper.ArrowType.Right]=Vector3(originPos.x+range,originPos.y,0),
[mysteryPosHelper.ArrowType.LeftTop]=Vector3(originPos.x,originPos.y+range,0),
[mysteryPosHelper.ArrowType.RightTop]=Vector3(originPos.x+range,originPos.y+range,0),
[mysteryPosHelper.ArrowType.LeftBottom]=Vector3(originPos.x-range,originPos.y-range,0),
[mysteryPosHelper.ArrowType.RightBottom]=Vector3(originPos.x,originPos.y-range,0),
}

return posList
end

function mysteryPosHelper.getRangeSixPosList(originPos,range)
local sortPoslist={}
for i=1,range do
local posList=checkRangeSixPosList(originPos,i)
for a,v in pairs(posList)do
if mysteryPosHelper.isCanMove(v)then
sortPoslist[a]=sortPoslist[a]or{}
sortPoslist[a][i]=v
end
end
end
return sortPoslist
end


function mysteryPosHelper.getLinePosList(originPos,arrow,range,checkCanMove)
local sortPoslist={}
local pos,posList
for i=1,range do
posList=checkRangeSixPosList(originPos,i)
pos=posList[arrow]
if pos and((not checkCanMove)or mysteryPosHelper.isCanMove(pos))then
table.insert(sortPoslist,pos)
end
end
return sortPoslist
end




function mysteryPosHelper.is_rightward(originPos,targetPos)
originPos=mysteryPosHelper.ToOriPos(originPos)
targetPos=mysteryPosHelper.ToOriPos(targetPos)
if originPos.y%2==0 then
return originPos.x<=targetPos.x
else
return originPos.x<targetPos.x
end















end




function mysteryPosHelper.is_invalid_path(pathLen)
return pathLen<2
end


function mysteryPosHelper.get_shuffle_path(originPos,range,layer)

local nearList=mysteryPosHelper.get_passable_near_pos_list(originPos,range)

local shuffleList=mysteryPosHelper.shuffle(nearList,os.time())

local posList={shuffleList[1]}
local addPosFunc=function(beginPos,endPos)
local tempPath=MysteryController:getPath(beginPos,endPos,0,layer)
for j=2,#tempPath do
if not mysteryPosHelper.is_same_pos(posList[#posList],tempPath[j])then
posList[#posList+1]=tempPath[j]
end
end
end
for i,v in ipairs(shuffleList)do
addPosFunc(originPos,v)
addPosFunc(v,originPos)
end
return posList
end




function mysteryPosHelper.shuffle(t,seed)
if type(t)~="table"then
return
end
if seed then
math.randomseed(seed)
end
local tab={}
local index=1
while#t~=0 do
local n=math.random(1,#t)
if t[n]~=nil then
tab[index]=t[n]
table.remove(t,n)
index=index+1
end
end
return tab
end



function mysteryPosHelper.get_pos_key(gridPos)
local posList={gridPos.x,gridPos.y,gridPos.z}
local posKey=table.concat(posList,"_")
return posKey
end



function mysteryPosHelper.serializePos(pos)
return pos and string.format("(x=%s,y=%s)",pos.x,pos.y)or"nil"
end

