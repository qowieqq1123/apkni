







def_class("UIMysteryMiniWin",UIWindowBase)









function UIMysteryMiniWin:bindComponents()

self.root=UIObject.get(self,0)
self.miniMapRoot=UIObject.get(self,1)
self.Name=UIText.get(self,2)
self.Precent=UIText.get(self,3)
self.helpButton=UIButton.get(self,4)
self.decoraButton=UIObject.get(self,5)
self.showButton=UIButton.get(self,6)
self.hideButton=UIButton.get(self,7)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.showButton:setButtonClick(function()self:onShowButton()end)

self.hideButton:setButtonClick(function()self:onHideButton()end)



end


function UIMysteryMiniWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.miniMapRoot);self.miniMapRoot=nil;
_UIObject_release(self.Name);self.Name=nil;
_UIObject_release(self.Precent);self.Precent=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.decoraButton);self.decoraButton=nil;
_UIObject_release(self.showButton);self.showButton=nil;
_UIObject_release(self.hideButton);self.hideButton=nil;
end

















local eMiniEntityType=
{
[eMysteryEntityType.ePlayer]={eType=0,nType=0},
[eMysteryEntityType.eTreasure]={eType=1,nType=0},
[eMysteryEntityType.eMonster]={eType=2,nType=0},
}

local _this=nil


function UIMysteryMiniWin:onLoaded(...)
self:bindComponents()

_this=self



end


function UIMysteryMiniWin:__delete()
_this=nil
self:unbindComponents()
end



















local abName="ui/icons/mystery/sharedtextures/iconmysteryminimapsprite.ab"

function UIMysteryMiniWin.createEntityCb(guid,pos,entityType,entityId)
local entity=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,"get_entity",guid)
if entityType~=eMysteryEntityType.ePlayer then
local room=mysteryRoomModel:get_cur_roomID()
if entity.roomId~=room then
return
end
end

local cfg=nil
if entityId then
cfg=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,"get_config",entityId)
end
if cfg and cfg.miniMapAsset then
if entityType==eMysteryEntityType.eTriggerPoint then
if not(cfg.hide and entity.data.status>=cfg.hide)then
_this:addItemByAsset(guid,pos,cfg.miniMapAsset)
end
else
_this:addItemByAsset(guid,pos,cfg.miniMapAsset)
end
else
local miniEntityType=eMiniEntityType[entityType]
if not miniEntityType then

end
if miniEntityType then
if entity.data.obstacle then
_this:addItem(guid,pos,3,2)
else
_this:addItem(guid,pos,miniEntityType.eType,miniEntityType.nType)
end
end
end
end

function UIMysteryMiniWin.removeEntityCb(guid)
_this:removeItem(guid)
end




function UIMysteryMiniWin:onShow(argtable,afterOnloaded)

local fbid=MysteryModel:get_cur_fbid()
if fbid then
local roomId=mysteryRoomModel:get_cur_roomID()
local mainMapData=mysteryRoomModel:get_grid_data(roomId)
if mainMapData then
self:initMiniMap(mainMapData)
self:initRoomMapItem(roomId)
end

self:initPlayer()
self:focusPlayer(100)

self:setFBTitle(fbid)

local entity_cache=MysteryModel:get_mini_entity_cache()
if next(entity_cache)then
for guid,value in pairs(entity_cache)do
self.createEntityCb(guid,value[1],value[2])
MysteryModel:remove_mini_entity_cache(guid)
end
end
end

end

function UIMysteryMiniWin:initMiniMap(MapData)
self:ClearMiniMap()
local pos
local cfg_surface=cfg_secretscentsurfaceconfig()
local curRoomId=mysteryRoomModel:get_cur_roomID()
for y,yv in pairs(MapData)do
for x,v in pairs(yv)do
pos=Vector3(x,y,0)
if cfg_surface[v.surfaceId]then
if not mysteryFogModel:get_fog_data(curRoomId,x,y)then
self:paintGround(pos,MapDataType.Fog)
else
self:paintGround(pos,MapDataType.Walkable)
end
end
end
end
end

function UIMysteryMiniWin:initPlayer()
local playerPos=mysteryPlayerModel:get_player_pos()
local playerGUID=mysteryPlayerModel:get_player_guid()
if playerGUID then
self.createEntityCb(playerGUID,playerPos,eMysteryEntityType.ePlayer)
end
end

function UIMysteryMiniWin:focusPlayer(cameraSpeed,playerPos,playerSpeed)
playerPos=playerPos or mysteryPlayerModel:get_player_pos()
cameraSpeed=cameraSpeed or 0.5
local playerGUID=mysteryPlayerModel:get_player_guid()
if playerGUID then
self.winid:MoveMiniMapItem(self.root:getID(),playerGUID,playerPos,playerSpeed or 0)
if cameraSpeed>=0 then
self.winid:MoveMiniMapCamera(self.root:getID(),playerPos,nil,cameraSpeed or 0.5)
end
end
end

local cameraIndex=0
function UIMysteryMiniWin:playerMovePath(posList,cameraSpeed)
self.currentPosList=posList
cameraIndex=1
self:moveCamera(self.currentPosList[cameraIndex],cameraSpeed or 0.05)
end

function UIMysteryMiniWin:moveCamera(playerPos,cameraSpeed)
self.winid:MoveMiniMapCamera(self.root:getID(),playerPos,function()
if self and not self.isClose then
cameraIndex=cameraIndex+1
if self.currentPosList and self.currentPosList[cameraIndex]then
self:moveCamera(self.currentPosList[cameraIndex],cameraSpeed)
else
self.currentPosList={}
end
end
end,cameraSpeed or 0.5)
end

function UIMysteryMiniWin:stopCameraMove()
self.currentPosList={}
end

function UIMysteryMiniWin:paintGround(pos,data)
self.winid:PaintMiniMap(self.root:getID(),pos,data)
end

function UIMysteryMiniWin:paintGroundList(posList,data)
if#posList>0 then
for i,v in ipairs(posList)do
self:paintGround(Vector3(v[1],v[2],0),data)
end
end
end

function UIMysteryMiniWin:moveItem(GUID,Pos,speed)
self.winid:MoveMiniMapItem(self.root:getID(),GUID,Pos,speed and 0)
end

function UIMysteryMiniWin:addItem(GUID,Pos,eType,nType)
nType=nType==nil and 0 or nType
self.winid:AddMiniMapItem(self.root:getID(),GUID,Pos,eType,nType)
end

function UIMysteryMiniWin:addItemByAsset(GUID,Pos,asset)
self.winid:AddMiniMapAssetItem(self.root:getID(),GUID,Pos,abName,asset)
end

function UIMysteryMiniWin:removeItem(GUID)
self.winid:RomoveMiniMapItem(self.root:getID(),GUID)
end

function UIMysteryMiniWin:initRoomMapItem(roomID)
local entityList={}
for _,entityType in pairs(eMysteryEntityType)do
if entityType~=eMysteryEntityType.ePlayer then
entityList=mysteryEntityController.invokeFuncByMysteryEntityType(entityType,"get_entity_list")
if entityList then
for i,v in pairs(entityList)do
if roomID==v.roomId and v.isVisible then
self.createEntityCb(v.guid,v.pos,v.entityType,v.id)
end
end
end
end
end
end

function UIMysteryMiniWin:createEntity(guid,pos,entityType,entityId)
self.createEntityCb(guid,pos,entityType,entityId)
end

function UIMysteryMiniWin:removeEntity(guid)
self.removeEntityCb(guid)
end

function UIMysteryMiniWin:refreshPercent(percent)
self.Precent:setText(FMT.fmt("当前进度：<color=#76d81e>{0}%</color>",percent or 0))
end

function UIMysteryMiniWin:setFBTitle(fbid)
local cfg=cfg_secretscenefubenconfig_get(fbid)
self.Name:setText(cfg.name)
end

function UIMysteryMiniWin:ClearMiniMap()
self.winid:ClearMiniMap(self.root:getID())
end


function UIMysteryMiniWin:OnEnable()

end


function UIMysteryMiniWin:OnDisable()

end

function UIMysteryMiniWin:onShowButton()
self:onButtonArrow()
end

function UIMysteryMiniWin:onHideButton()
self:onButtonArrow()
end

function UIMysteryMiniWin:onButtonArrow()






end

function UIMysteryMiniWin:onHelpButton()





UIManager:showWindow('UMysteryTipsWin')
end


