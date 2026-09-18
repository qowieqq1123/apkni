







local _MODULENAME="mysteryFogController"
gameState.addListener(def_table(_MODULENAME))
mysteryFogController.name=_MODULENAME

local _HexMapManager=CS.HexagonMapManagerInterface

local SetTileColor=_HexMapManager.SetTileColor


local fogTimer={}
local fogColor={}



mysteryFogController.effectType=
{
cloud=0,
bg=1,
}

mysteryFogController.fogType=
{
2,3,
}

local fogAnimDirect=
{
right=0,
left=1,
}

local cloudSize={3.85,4.6,1}
local cloudRandomSize={11,14}


function mysteryFogController.get_direct(originPos,targetPos)
local direct=fogAnimDirect.right
if originPos.x<targetPos.x and originPos.y==targetPos.y then
direct=fogAnimDirect.right
elseif originPos.x<targetPos.x and originPos.y<targetPos.y then
direct=fogAnimDirect.right
elseif originPos.x<targetPos.x and originPos.y>targetPos.y then
direct=fogAnimDirect.right
elseif originPos.x>targetPos.x and originPos.y==targetPos.y then
direct=fogAnimDirect.left
elseif originPos.x>=targetPos.x and originPos.y<targetPos.y then
direct=fogAnimDirect.left
elseif originPos.x>=targetPos.x and originPos.y>targetPos.y then
direct=fogAnimDirect.left
end
return direct
end


function mysteryFogController:onAppStart()
socketManager:register_receiver(4,24,mysteryFogController.recv_4_24)
end

function mysteryFogController:onEnterState()
mysteryFogModel:init_data()
end

function mysteryFogController:onLeaveState()
end


function mysteryFogController:initFog(fbID,needSetTile,fogWhiteList,playerPos)
if not fbID then
fbID=MysteryModel:get_cur_fbid()
end
if not fbID then
return
end


local cfg_fb=cfg_secretscenefubenconfig_get(fbID)
if not cfg_fb then
return
end

if not fogWhiteList then
fogWhiteList=cfg_fb.fogWhite
end

local view=MysteryModel:get_fog_view()
if not view then
return
end

local whiteList={}
if fogWhiteList then
for i,v in ipairs(fogWhiteList)do
local key=table.concat(v,'-')
whiteList[key]=true
end
end

local gridsize=cfg_fb.gridsize
local random=nil
local cloudScale=nil
local player_pos=playerPos or mysteryPlayerModel:get_player_pos()
local fogList={}
local walkList={}

local fogTypeList=cfg_fb.cloudGroup

local roomID=mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)
local map_data={}
if roomID==0 then
map_data=MysteryModel:get_all_main_grid_data()
else
map_data=mysteryRoomModel:get_room_grid_list_data(roomID)
end
if map_data then

for y,yv in pairs(map_data)do
local bx1=1000
local bx2=-1000
for x,v in pairs(yv)do
if x<bx1 then
bx1=x
end
if x>bx2 then
bx2=x
end
local key=table.concat({x,y},'-')

if((x>=player_pos.x-view and x<=player_pos.x+view)and(y>=player_pos.y-view and y<=player_pos.y+view)and math.abs((x-player_pos.x)-(y-player_pos.y))<=view)or whiteList[key]then
mysteryFogModel:set_update_fog_data(roomID,x,y,true)
mysteryFogModel:set_fog_data(roomID,x,y,true)
table.insert(walkList,{x,y})
else
if(not mysteryFogModel:get_fog_data(roomID,x,y))then
table.insert(fogList,{x,y})
local ve3Pos=Vector3(x,y,0)
if needSetTile then

if cfg_fb.surfacedark then
SetTileColor(ve3Pos,groundLayer,(85+(255-85)/4)/255,(85+(255-85)/4)/255,(85+(255-85)/4)/255,1)
end
end
if fogTypeList then

local fogObj=mysteryFogModel:get_room_fog_object_id(roomID,key)
if not fogObj then
local fogType=fogTypeList[math.random(1,#fogTypeList)]
random=math.random(cloudRandomSize[1],cloudRandomSize[2])/10
cloudScale=Vector3(gridsize[1]/cloudSize[1]*random,gridsize[2]/cloudSize[2]*random,1)

local loadFogCB=function(_guid)
local direct=mysteryFogController.get_direct(player_pos,ve3Pos,true)
mysteryFogController.setFogEffectAnimationFloat(_guid,"fBlend",direct)
mysteryFogController.setFogEffectAnimationInt(_guid,"nStateID",0,2.2,nil,true)
mysteryFogModel:insert_room_fog_object(roomID,key,_guid)
end
local isRightward=mysteryPosHelper.is_rightward(ve3Pos,player_pos)
mysteryFogController.loadFogEffect(fogType,ve3Pos,groundLayer,false,cloudScale,loadFogCB,isRightward and Vector3(-1,0,0)or Vector3(1,0,0))


end
end
end
end
end
if bx1~=1000 and bx2~=-1000 then
if fogTypeList then
local add=view>4 and 4 or view
add=add<1 and 1 or add
for x=bx1-add,bx1-1 do
if not((x>=player_pos.x-view and x<=player_pos.x+view)and(y>=player_pos.y-view and y<=player_pos.y+view)and math.abs((x-player_pos.x)-(y-player_pos.y))<=view)then
if(not mysteryFogModel:get_fog_data(roomID,x,y))then
random=math.random(cloudRandomSize[1],cloudRandomSize[2])/10
cloudScale=Vector3(gridsize[1]/cloudSize[1]*random,gridsize[2]/cloudSize[2]*random,1)
if not(map_data and map_data[y-1]and map_data[y-1][x-1])then
self.createFog(roomID,x,y,fogTypeList,cloudScale,true,Vector3(-1,0,0))
end
end
end
end
for x=bx2+1,bx2+add do
if not((x>=player_pos.x-view and x<=player_pos.x+view)and(y>=player_pos.y-view and y<=player_pos.y+view)and math.abs((x-player_pos.x)-(y-player_pos.y))<=view)then
if(not mysteryFogModel:get_fog_data(roomID,x,y))then
random=math.random(cloudRandomSize[1],cloudRandomSize[2])/10
cloudScale=Vector3(gridsize[1]/cloudSize[1]*random,gridsize[2]/cloudSize[2]*random,1)
if not(map_data and map_data[y-1]and map_data[y-1][x])then
self.createFog(roomID,x,y,fogTypeList,cloudScale,true,Vector3(1,0,0))
end
end
end
end
end
end
end
end


end

function mysteryFogController:updateFog(fbID,player_pos,extraView)
local cfg_fb=cfg_secretscenefubenconfig_get(fbID)
if cfg_fb then
local view=MysteryModel:get_fog_view()
if not view then
return
end

if extraView then
view=extraView
end
if not player_pos then
return
end
local roomID=mysteryRoomModel:get_cur_roomID()
local mapType=mysteryRoomModel:get_mapType_by_roomID(roomID)
local groundLayer=MysteryController.MapLayerLookUp[mapType].GroundLayer
local walkList={}
local tempPos

for round=0,view do
local posList=mysteryPosHelper.get_round_pos_list(player_pos,round)
for i,v in ipairs(posList)do
local color
if round>view then
if not mysteryFogModel:get_fog_data(roomID,v.x,v.y)then
color={r=85/255,g=85/255,b=85/255,a=1}
else
color={r=(85+(255-85)/4)/255,g=(85+(255-85)/4)/255,b=(85+(255-85)/4)/255,a=1}
end
else
if not mysteryFogModel:get_fog_data(roomID,v.x,v.y)then
if v.x>0 and v.y>0 then
mysteryFogModel:set_update_fog_data(roomID,v.x,v.y,true)
end
end

mysteryFogModel:set_fog_data(roomID,v.x,v.y,true)
tempPos=Vector3(v.x,v.y,0)
local checkMapData=roomID~=0 and mysteryRoomModel:get_room_grid_data(roomID,v.x,v.y)or MysteryModel:get_main_grid_data(v.x,v.y)
if checkMapData then
mysteryFogController:set_entity_active(tempPos,roomID)
if not MysteryModel:is_border(roomID,tempPos)then
table.insert(walkList,{v.x,v.y})
end
end


if round>1 then
color={r=(85+(4-round)*(255-85)/4)/255,g=(85+(4-round)*(255-85)/4)/255,b=(85+(4-round)*(255-85)/4)/255,a=1}
else
color={r=1,g=1,b=1,a=1}
end


local key=table.concat({v.x,v.y},'-')
local fogObj=mysteryFogModel:get_room_fog_object_id(roomID,key)
if v.x==11 and v.y==4 then

end
if fogObj then
local direct=mysteryFogController.get_direct(player_pos,v,true)

mysteryFogController.playFogEffectAnimationId(fogObj,direct==fogAnimDirect.left and"LeaveL"or"LeaveR",0,nil)

timeEventController.delayDo(1,function()
if MysteryModel:is_enter_Mystery()then
mysteryFogController.removeFogEffectId(fogObj)
end
_HexMapManager.SetFogObjectAnimatorEnable(fogObj,false)
end)
mysteryFogModel:remove_room_fog_object(roomID,key)
end
mysteryFogModel:set_round_fog_cloud_data(roomID,v.x,v.y,true)


end

if cfg_fb.surfacedark then

local pos=table.concat({v.x,v.y},'-')

fogColor[pos]=_HexMapManager.GetTileColor(Vector3Int(v.x,v.y,0),groundLayer)
local cb=function()
if fogColor[pos].r>=color.r and fogColor[pos].g>=color.g and fogColor[pos].b>=color.b then
fogTimer[pos]:cancel()
fogTimer[pos]=nil
fogColor[pos]=color
else
fogColor[pos]={r=fogColor[pos].r<color.r-10/255 and fogColor[pos].r+10/255 or color.r,
g=fogColor[pos].g<color.g-10/255 and fogColor[pos].g+10/255 or color.g,
b=fogColor[pos].b<color.b-10/255 and fogColor[pos].b+10/255 or color.b,
a=1}
end
SetTileColor(Vector3(v.x,v.y),groundLayer,fogColor[pos].r,fogColor[pos].g,fogColor[pos].b,fogColor[pos].a)
end
if fogTimer[pos]then
fogTimer[pos]:cancel()
fogTimer[pos]=nil
end
fogTimer[pos]=timer.new()
fogTimer[pos]:start(0.05,cb)
end

end
end

UIManager:invokeUIMethod("UIMysteryMiniWin","paintGroundList",walkList,MapDataType.Walkable)
end
end

function mysteryFogController.createFog(roomID,x,y,fogTypeList,scale,entry,worldPosOffset)
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)
local ve3Pos=Vector3(x,y,0)
local key=table.concat({x,y},'-')
local fogObj=mysteryFogModel:get_room_fog_object_id(roomID,key)
local haveFlag=mysteryFogModel:get_round_fog_cloud_data(roomID,x,y)
if(not fogObj)and(not haveFlag)then
local fogType=fogTypeList[math.random(1,#fogTypeList)]
mysteryFogController.loadFogEffect(fogType,ve3Pos,groundLayer,false,scale,function(_guid)
mysteryFogModel:insert_room_fog_object(roomID,key,_guid)
if entry then
local player_pos=mysteryPlayerModel:get_player_pos()
local direct=mysteryFogController.get_direct(player_pos,ve3Pos,true)
mysteryFogController.setFogEffectAnimationFloat(_guid,"fBlend",direct)
mysteryFogController.setFogEffectAnimationInt(_guid,"nStateID",0,2.2,nil,true)
end
end,worldPosOffset)
end
end


function mysteryFogController:set_entity_active(pos,roomId)
local entityList=mysteryEntityController.invokeAllModelsFunc("get_all_entity_list_by_pos",pos,roomId)
if entityList then
for i,v in pairs(entityList)do
for i2,v2 in ipairs(v)do
mysteryEntityController.invokeFuncByMysteryEntityType(v2.entityType,"update_visible",v2.guid)
end
end
end
end

function mysteryFogController:createMapFogEffect(typo,roomID)
local fbid=MysteryModel:get_cur_fbid()
local cloudId=cfgHelper.get(cfg_secretscenefubenconfig_get,fbid,"groundCloud")
if not cloudId then
return
end
local map_size
map_size=mysteryRoomModel:get_room_map_area(roomID)
local layer=mysteryRoomModel:get_GroundLayer(roomID)
if map_size then
local x=math.floor(map_size[1]/2)-1
local y=0
while(y<=map_size[2]-1)do
local id=self.loadFogEffect(cloudId,Vector3(x,y,0),layer)
if id~=-1 then
mysteryFogModel:insert_room_fog_effect(roomID,id)
end
y=y+2
end
end
end

function mysteryFogController:removeMapFogEffect(roomID)
local fogEffectList=mysteryFogModel:get_room_fog_effect(roomID)
if fogEffectList then
for _,id in ipairs(fogEffectList)do
self.removeFogEffectId(id)
end
mysteryFogModel:clear_room_fog_effect(roomID)
end

local fogList=mysteryFogModel:get_room_fog_object(roomID)
if fogList then
for _,id in pairs(fogList)do
self.removeFogEffectId(id)
end
mysteryFogModel:clear_room_fog_object_list(roomID)
end
end





function mysteryFogController.createFogEffect(typo,gridPos,layer,notAddOffset,scale)
layer=layer or HexMapLayer.Ground
scale=scale or Vector3(1,1,1)
local worldPos=_HexMapManager.GetCellCenterWorld(gridPos,layer,notAddOffset)
local id=_HexMapManager.CreateFogObject(typo,worldPos)
mysteryFogModel:set_fog_effect_id(id,gridPos,layer)
local go=mysteryFogController.getFogObject(id)
GameObject.SetScale(go,scale)

_HexMapManager.SetFogObjectAnimatorInt(id,"nStateID",0)
return id
end

function mysteryFogController.loadFogEffect(id,gridPos,layer,notAddOffset,scale,callback,worldPosOffset)
layer=layer or HexMapLayer.Ground
scale=scale or Vector3(1,1,1)
local worldPos=_HexMapManager.GetCellCenterWorld(gridPos,layer,notAddOffset)
if worldPosOffset then
worldPos=worldPos+worldPosOffset
end
local fogConfig=cfgHelper.get1(cfg_secretscenecloudconfig_get,id)

if not fogConfig then
return-1
end

local cb=function(_guid)
mysteryFogModel:set_fog_effect_id(_guid,gridPos,layer)
local go=mysteryFogController.getFogObject(_guid)
GameObject.SetScale(go,scale)
_HexMapManager.SetFogObjectAnimatorInt(_guid,"nStateID",0)

if callback then
callback(_guid)
end
end
local guid=_HexMapManager.CreateFogObjectAbName(fogConfig.abname,fogConfig.assetname,worldPos,cb)
return guid
end

function mysteryFogController.getFogObject(id)
return _HexMapManager.GetFogObject(id)
end

function mysteryFogController.playFogEffectAnimation(gridPos,mapLayer,state,aniLayer,action)
local id=mysteryFogModel:get_fog_effect_id(gridPos,mapLayer)
if id~=-1 then
_HexMapManager.RunFogObjectAnimator(id,state,aniLayer,action)
end
end

function mysteryFogController.setFogEffectAnimationInt(id,keyName,index,time,afterAnim,stopAnim)
_HexMapManager.SetFogObjectAnimatorInt(id,keyName,index)
if time and time>0 then
local timer=timeEventController.delayDo(time,function()
if afterAnim then
afterAnim()
end
if stopAnim then
_HexMapManager.SetFogObjectAnimatorEnable(id,false)
end
end)
end
end

function mysteryFogController.setFogEffectAnimationFloat(id,keyName,index,time,afterAnim,stopAnim)
_HexMapManager.SetFogObjectAnimatorFloat(id,keyName,index)
if time and time>0 then
local timer=timeEventController.delayDo(time,function()
if afterAnim then
afterAnim()
end
if stopAnim then
_HexMapManager.SetFogObjectAnimatorEnable(id,false)
end
end)
end
end

function mysteryFogController.playFogEffectAnimationId(id,state,aniLayer,action)
_HexMapManager.RunFogObjectAnimator(id,state,aniLayer,action)
end

function mysteryFogController.removeFogEffectId(id)
_HexMapManager.RemoveFogObject(id)
end

function mysteryFogController.removeFogEffect(gridPos,layer)
local id=mysteryFogModel:get_fog_effect_id(gridPos,layer)
if id~=-1 then
_HexMapManager.RemoveFogObject(id)
end
end

function mysteryFogController:createEffect(typo,gridPos,layer,time,removeCB)
layer=layer or HexMapLayer.Ground
local worldPos=_HexMapManager.GetCellCenterWorld(gridPos,layer)
local id=_HexMapManager.PlayEffect(typo,worldPos)
if time>0 then
local timer=timer.new()
timer:start(time,function()
if removeCB then
removeCB()
end
end,1)
end
return id
end




function mysteryFogController.send_4_24(fogList)
socketManager:send_4_24(#fogList,fogList)
end


function mysteryFogController.recv_4_24(result)
if result==0 then
end
end


