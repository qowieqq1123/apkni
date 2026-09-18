









local xj2DEntity_arena={}

function xj2DEntity_arena:getIconName()
local sceneEnity=self:getSceneEnity()
local data=sceneEnity:getData()
local abname,iconname,desc,iconExtra

local entityType=self.entityType
if entityType==XJ_ENTITY_TYPE.eArena then

abname="ui/windows/xianjie/xianjiemap/xianjiemap_atlas_pak.ab"
iconname='image_xianjieditu_1'
desc={}
end
return abname,iconname,desc,iconExtra
end


function xj2DEntity_arena:onCreateWidget(widget)
local abname,iconname,desc,iconExtra=self:getIconName()
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
self.xjIconGUID=xianjieController:createXjIcon(abname,iconname,iconExtra,widget,0)
self:refreshXyName(widget)
widget:SetChildButtonClick(4,function()
self:onClick()
end)
end


function xj2DEntity_arena:onRemoveWidget(widget)
widget:SetChildIcon(0,'',false)
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
self.xjIconGUID=nil
self.arenaId=nil
end

function xj2DEntity_arena:onMyClick()
local sceneEnity=self:getSceneEnity()
local data=sceneEnity:getData()
local entityType=self.entityType
local check=false
if entityType==XJ_ENTITY_TYPE.eArena then
local arenaId=data[1]
local openWinFunc=function()
return xianjieController:openArenaInfoWin(arenaId)
end

local arenaData=xianjieModel:getArenaDataByArenaId(arenaId)
if not arenaData then
UIManager.error("找不到目标擂台")
return
end
local sceneidx=arenaData.sceneidx
local gridX_c=arenaData.gridX_c
local gridZ_c=arenaData.gridZ_c
xianjieController:jumpGrid(sceneidx,gridX_c,gridZ_c,openWinFunc,nil,0.6)

check=true
end
if check then
UIManager:invokeUIMethod('UIXianJie_mapWin','onCloseBtn2')
end
end

function xj2DEntity_arena:onUpdate()
local widget=self:getWidget()
if widget then
self:refreshXyName(widget)
end
end


function xj2DEntity_arena:onDelete()

end

function xj2DEntity_arena:refreshXyName(widget)
local xyName="暂无归属"
local arenaId=self:getArenaId()
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
local occupyNowServerId=arenaData.occupyServerId
if occupyNowServerId and occupyNowServerId~=0 then
xyName=xianjieController:getCrossServerNamebySCidx(arenaData.sceneidx)
local cross_sid=loginModel:getCrossServerId()
local isSelfXianYu=occupyNowServerId==cross_sid
if isSelfXianYu then
xyName=FMT.fmt("<color=#17c700>{0}</color>",xyName)
else
xyName=FMT.fmt("<color=#ff2323>{0}</color>",xyName)
end
end

widget:SetChildText(1,'')
widget:SetChildActive(2,true)
widget:SetChildText(3,xyName)
end

function xj2DEntity_arena:getArenaId()
if self.arenaId then
return self.arenaId
end

local sceneEnity=self:getSceneEnity()
local data=sceneEnity:getData()
self.arenaId=data[1]
return self.arenaId
end

return xj2DEntity_arena