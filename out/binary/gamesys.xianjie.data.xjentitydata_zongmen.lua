









local xjEntityData_zongmen={}


function xjEntityData_zongmen:onInit()
self.gridX=self.x
self.gridZ=self.y
self.x=nil
self.y=nil
self.gridWidth,self.gridHeight=xianjieModel:getZongMenSize()
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.isWaitingMove=nil

self.gridState=xjMapGridStateType.eZongMen

self.haloLookup={}
self.haloInfo={}
self.posTable={}
self:onInitExtraData()
end

function xjEntityData_zongmen:getZMData()
local zmData
if self.ismy then
zmData=xianjieModel:getMyZongMenData()
else
zmData=xianjieModel:getZongMenData(self.actorid)
end
return zmData
end

function xjEntityData_zongmen:compareKey(guid)
return self.actorid_str==tostring(guid)
end

function xjEntityData_zongmen:refreshData(d)
self:matchData(d)
local changePos=self.gridX~=d.x or self.gridZ~=d.y

xianjieModel:setGridState(self.sceneidx,self.gridX,self.gridZ,self.gridWidth,self.gridHeight,self.gridState,false)
self.gridX=d.x
self.gridZ=d.y
self.sceneidx=d.sceneidx
if d.actorname then
self.actorname=d.actorname
end
if d.fortresslv then
self.fortresslv=d.fortresslv
end
self.sectdress=d.sectdress
self.gridX_c,self.gridZ_c=xianjieController:worldGridCenterPos(self.gridX,self.gridZ,self.gridWidth,self.gridHeight)

self.guildid=d.guildid


xianjieModel:setGridState(self.sceneidx,self.gridX,self.gridZ,self.gridWidth,self.gridHeight,self.gridState,true)

if playerModel:checkActorId(self.actorid)then
UIManager:invokeUIMethod('UIXianJie_selfZmInfoWin','refreshView')
UIManager:invokeUIMethod('UIXianJie_otherZmInfoWin','refreshView')
else
UIManager:invokeUIMethod('UIXianJie_otherZmInfoWin','refreshActorInfo',self.actorid)
end
if changePos then
xianjieModel:refreshZmDataPos(self)
end

self:postDiff()
end

function xjEntityData_zongmen:postDiff()
notifySystem:postNotify(notifyConfig.onXianJieEntityDataChange,self.posTable,self.actorid)
end

function xjEntityData_zongmen:matchData(d)
if self.guildid~=d.guildid then
self.posTable[#self.posTable+1]={xjDataType.eZongMen,eXjDataChangeType.eXmChange,self.m_ID,self.guildid,d.guildid}
elseif self.gridX~=d.x or self.gridZ~=d.y then
self.posTable[#self.posTable+1]={xjDataType.eZongMen,eXjDataChangeType.ePosChange,self.m_ID,self.guildid,d.guildid}
end
end


function xjEntityData_zongmen:getBaoLeiLevel()
if self.isPlot then


return 1
else
return self.fortresslv
end
end

function xjEntityData_zongmen:getIconInfo()
if self.isPlot then
return playerModel:getActorIconInfo()
else
return self.iconInfo
end
end

function xjEntityData_zongmen:getActorName()
if self.isPlot then
return playerModel:getActorName()
else
return self.actorname
end
end

function xjEntityData_zongmen:getZMName()
if self.isPlot then
return UISettingModel:getZMName()
else
return self.sectname
end
end

function xjEntityData_zongmen:getFightValue()
if self.isPlot then
return playerModel:getActorFightValue()
else
return self.fightvalue
end
end

function xjEntityData_zongmen:getXMGuildid()
local guildid=xianmengModel:myXMGuildID()
if self.isPlot then
guildid=xianmengModel:myXMGuildID()
else
guildid=self.guildid
end
if mathHelper.validInt64(guildid)then
return guildid
end
return nil
end


function xjEntityData_zongmen:getXianYuSceneIndex()
if self.isPlot then
return xianjieModel:getXianYuSceneIndex()
else
return self.ownersceneidx
end
end


function xjEntityData_zongmen:getBornAreaID()
if xianjienSceneIndexType:isMoJie(self.sceneidx)or xianjienSceneIndexType:isMoGongZhengDuo(self.sceneidx)then

return self.ownersceneidx
else
return 0
end
end

function xjEntityData_zongmen:createEntity(needRefreshAOI)
if xianjieModel:checkSceneIndex(self.sceneidx)and self.ent_key==nil then
self.ent_key=xianjieController:addEntity(XJ_ENTITY_TYPE.eZongMen,{self.actorid,self.ismy,self:getActorName()},needRefreshAOI)
end
end

function xjEntityData_zongmen:setMoveFlag(flag)
self.isWaitingMove=flag
end

function xjEntityData_zongmen:getMoveFlag()
return self.isWaitingMove
end


function xjEntityData_zongmen:refreshHaloRange(entityId_,haloType,flag,args)
self.haloInfo[haloType]=args

local old=self.haloLookup[haloType]~=nil
self.haloLookup[haloType]=flag and entityId_ or nil
if old~=flag then
if self.ent_key==nil then return end
local ent=xianjieController:getEntity(self.ent_key)
if ent==nil then return end
if flag then
ent:enterHaloRange(haloType,entityId_)
else
ent:exitHaloRange(haloType,entityId_)
end
end
end

function xjEntityData_zongmen:getHaloRangeEntity(haloType)
return self.haloLookup[haloType]
end

function xjEntityData_zongmen:hasInHaloRange(haloType)
return self:getHaloRangeEntity(haloType)~=nil
end


function xjEntityData_zongmen:onDelete()

end

return xjEntityData_zongmen