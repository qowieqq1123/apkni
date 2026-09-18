local _recordList={}

function isometricMapSystem:createRandomObject(data)
local id=data.randItemId
local guid=data.randItemGuid
if data.posData==nil then
zongmenModel:placeRandomObject(guid)
end
local pos=_MapManager.ToVector3Int(data.posData.x,data.posData.y,0)
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,id)






local placeId=cfg.placeId or conditionConfig.default
local flip=false
local mapId=mapIdType.zhufeng
local sx=cfg.size[1]
local sy=cfg.size[2]
local offset=self:countOffset(sx,sy)
local model=cfg.model[1]
local slots=cfg.model[2]
local scale=self:getModelScale(model)
local obj=self:createPlaceObjectEntity(objectType.eStillSundrise,mapId,id,model,slots,SortingLayers.ITBuilding,flip,scale,pos,offset,placeId)
local hudOffset=_MapManager.GetObjectHeadOffset(obj)
local hud=hudControl:addHUD(INSTANCE_TYPE.eClick,obj,hudOffset,true,true,function(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildButtonClick(0,function()
local objType=_MapManager.GetObjectType(obj)
isometricMapSystem:checkTouchRandomObject(obj,objType)
end)
end)
local rect=_MapManager.GetObjectRectInMap(obj)
local rx=rect[1]+rect[3]-1
local ry=rect[2]+rect[4]-1
local record={
guid=guid,
obj=obj,
x=data.posData.x,
y=data.posData.y,
rx=rx,
ry=ry,
mapId=mapId,
type=cfg.type,
hud=hud,
}

_recordList[tostring(guid)]=record
end

function isometricMapSystem:removeRandomObject(guid)
local key=tostring(guid)
local record=_recordList[key]
if record then
hudControl:removeHUD(record.hud)
_MapManager.PickUpFromMap(record.obj)
_MapManager.RemoveTilemapObject(record.obj)
_recordList[key]=nil
end
end

function isometricMapSystem:cleanAllRandomObject()
for i,v in pairs(_recordList)do
self:removeRandomObject(v.guid)
end
end

function isometricMapSystem:reCreateAllRandomObject()
isometricMapSystem:cleanAllRandomObject()
local datas=zongmenModel:getAllRandomObject()
for i,v in pairs(datas)do
isometricMapSystem:createRandomObject(v)
end
end

function isometricMapSystem:findRandomObject(objGuid)
for i,v in pairs(_recordList)do
if v.obj==objGuid then
return v
end
end
end

function isometricMapSystem:findRandomObjectInArea(mapId,sx,sy,ex,ey)
local list={}
for k,v in pairs(_recordList)do
if mapId==v.mapId and self:checkOverlap(sx,sy,ex,ey,v.x,v.y,v.rx,v.ry)then
table.insert(list,v)
end
end
return list
end

function isometricMapSystem:getRandomObject(guid)
local key=tostring(guid)
return _recordList[key]
end

function isometricMapSystem:checkTouchRandomObject(guid,objType)
if objType==objectType.eStillSundrise then
local obj=self:findRandomObject(guid)

if obj~=nil then
self:onTouchRandomObject(obj)
return true
end
end
return false
end

function isometricMapSystem:onTouchRandomObject(objData)
local data=zongmenModel:getRandomObject(objData.guid)
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,data.randItemId)
if cfg.type==sundriseType.eStillSundrise then


self:startClearSundriesAI(objData,2)
elseif cfg.type==sundriseType.eRewardBox then
self:getRandomObjectReward(objData)
end
end

function isometricMapSystem:createSundriseAIRecord(data,typo)
local record={
typo=typo,
data=data,
dzId=nil,
hudId=nil,
}
if typo==1 then
record.mapId=_MapManager.GetObjectMapID(data.guid)
record.x=data.x
record.y=data.y
record.guid=data.guid
elseif typo==2 then
record.mapId=data.mapId
record.x=data.x
record.y=data.y
record.guid=data.obj
end
return record
end

function isometricMapSystem:createMonsterAIRecord(data)
local record={
data=data,
dzId=nil,
}
record.mapId=_MapManager.GetObjectMapID(data.guid or data.stId)
record.x=data.x
record.y=data.y
record.guid=data.guid or data.stId
return record
end

function isometricMapSystem:findRandomObjectInRange(mapId,x,y,radius,type)
local datas={}
if mapId==mapIdType.zhufeng then
local bx=x-radius
local by=y-radius
local ex=x+radius
local ey=y+radius
for k,v in pairs(_recordList)do
if type==nil or v.type==type then
local dx=v.x
local dy=v.y

if dx>=bx and dx<=ex and dy>=by and dy<=ey then
table.insert(datas,v)
end
end
end
end
return datas
end

function isometricMapSystem:getRandomObjectReward(objData)
if objData.type==sundriseType.eRewardBox then

AudioManager.playAudio(431)
end
zongmenControl:reqRewardRandomObject(objData.guid)
end

function isometricMapSystem:startClearSundriesAI(data,typo,isWarning)
if isWarning==nil then isWarning=true end

local record=self:createSundriseAIRecord(data,typo)
local mapId=record.mapId
if mapId==nil or mapId<=0 then
return-1
end
local cfg=cfgHelper.get1(cfg_disciplecollectconfig_get,1)
if self:isInOtherCollectArea(record.mapId,record.x,record.y,cfg.radius)then
if isWarning then
UIManager.info('弟子正前来清除杂物')
end
return 1
end

local pos=_MapManager.ToVector3Int(record.x,record.y,0)
local dzId=aiManager:getNearbyDisciple(mapId,pos,eAIDZType.eDefault)
if not dzId then
if isWarning then
UIManager.info('弟子都在忙碌，无暇前来清除杂物')
end
return 2
end

if self.sundriseAIRecord[record.guid]then
return 3
end

_MapManager.DrawInRange(mapId,1,pos,cfg.radius,TILE_TYPE.eCollect,mapLayer.DrawCollect)
_MapManager.SetTileColor(mapId,1,pos,cfg.radius,Color.New(1,1,1,0),-1,mapLayer.DrawCollect)
local tweener=_MapManager.SetTileColor(mapId,1,pos,cfg.radius,Color.New(1,1,1,1),0.5,mapLayer.DrawCollect)
tweener:SetLoops(3,_LoopType.Yoyo)
tweener:OnComplete(function()
_MapManager.SetTileColor(mapId,1,pos,cfg.radius,Color.New(1,1,1,0),0.5,mapLayer.DrawCollect)
end)
local hudId=hudControl:addHUD(INSTANCE_TYPE.eCollect,data.guid,Vector3.New(0,0.5,0),false,true,function(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildAnimationStringID(0,'chucao')
end)

record.exDZId=dzId
record.hudId=hudId
self.sundriseAIRecord[record.guid]=record
notifySystem:postNotify(notifyConfig.onSundriseAIRecord,record.guid,true)


local rdatas={}
local oDatas=self:getUnlockSundriesInRange(mapId,record.x,record.y,cfg.radius)
for i,v in ipairs(oDatas)do
if v.type==sundriseType.eStillSundrise or v.type==sundriseType.eMovementSundrise then
if v.guid~=data.guid then
local r=self:createSundriseAIRecord(v,1)
table.insert(rdatas,r)
end
end
end
local nDatas=self:findRandomObjectInRange(mapId,record.x,record.y,cfg.radius,sundriseType.eStillSundrise)
for i,v in ipairs(nDatas)do
if v.obj~=data.obj then
local r=self:createSundriseAIRecord(v,2)
table.insert(rdatas,r)
end
end
table.insert(rdatas,1,record)

local count=#rdatas
local cmdData={
type=eAIType.eSundrise,
initData={pos={record.x,record.y},hudId=hudId,rdatas=rdatas,sindex=1,
sfId=mapId,scount=count,ctime=cfg.time,radius=cfg.radius},
restorePreviousAI=true,
endCallback=function(diziId,stId,bt,interrupt)
self.sundriseAIRecord[record.guid]=nil
notifySystem:postNotify(notifyConfig.onSundriseAIRecord,record.guid,false)
end,
removeCallback=function(diziId,stId,bt)

local sds=bt:getSharedVar('rdatas')
for i,v in ipairs(sds or{})do
self:aiRewardSundries(mapId,v)
end
end
}
aiManager:addCommandToDisciple(dzId,cmdData)
end

function isometricMapSystem:setAINextClearSundriesPos(bt)
local rdatas=bt:getSharedVar('rdatas')
local sdata=bt:getSharedVar('sdata')
if sdata then
for i,v in ipairs(rdatas)do
v.dis=math.abs(v.x-sdata.x)+math.abs(v.y-sdata.y)
end
table.sort(rdatas,function(a,b)
return a.dis<b.dis
end)
end

local data=table.remove(rdatas,1)
if data then
data.dis=nil
bt:setSharedVar('spos',{data.x,data.y})
bt:setSharedVar('sdata',data)
end
end

function isometricMapSystem:checkAIClearSundries(bt,isPlayAudio)
local data=bt:getSharedVar('sdata')
local pass=false
if data then
local pdata=nil
if data.typo==1 then
pdata=self:getSundries(data.guid)
elseif data.typo==2 then
pdata=self:findRandomObject(data.guid)
end
pass=pdata~=nil
end
bt:setSharedVar('canCollect',pass)
if isPlayAudio then


end
end

function isometricMapSystem:aiRewardSundries(sfId,record)
if record.typo==1 then
self:getMountRandomReward(sfId,record.data)
elseif record.typo==2 then
self:getRandomObjectReward(record.data)
end
end

function isometricMapSystem:checkMonsterAIRecord(guid)
if self.monsterAIRecord and self.monsterAIRecord[guid]then
return true
end
return false
end

function isometricMapSystem:checkMonsterAIDz(dzId)
for i,v in pairs(self.monsterAIRecord or{})do
if mathHelper.compareInt64(v.exFightDZId,dzId)then
return true
end
end
return false
end


function isometricMapSystem:startClearMonsterAI(data)
local record=self:createMonsterAIRecord(data)
local mapId=record.mapId

local pos=_MapManager.ToVector3Int(record.x,record.y,0)
local dzId=aiManager:getNearbyDisciple(mapId,pos,eAIDZType.eDefault)
if not dzId then
return 2
end
if isometricMapSystem:checkMonsterAIRecord(record.guid)then

return 3
end
if isometricMapSystem:checkMonsterAIDz(dzId)then

return 4
end
record.exFightDZId=dzId
local discipleName=UIDiscipleModel:getDiscipleName(dzId)

platformSDK.printSDK(FMT.fmt('ClearMonsterAI 生成清除怪物ai 怪物guid:{0} 弟子名字：{1} 弟子id：{2}',record.guid,discipleName,dzId))
self.monsterAIRecord[record.guid]=record

local cmdData={
type=eAIType.eFightMonster,
initData={pos={record.x,record.y},monData=record,
sfId=mapId,fightTime=5,canClearMon=1},
restorePreviousAI=true,
endCallback=function(diziId,stId,bt,interrupt)
self.monsterAIRecord[record.guid]=nil

end,
removeCallback=function(diziId,stId,bt)
self.monsterAIRecord[record.guid]=nil

end
}
aiManager:addCommandToDisciple(dzId,cmdData)
end

function isometricMapSystem:checkClearMonster(bt,monData)
local setup,cfg=guildOrderModel:getSetupData(GUILD_ORDER_TYPE.eAutoFightMonster)
if not setup.isOpen then
bt:setSharedVar('canClearMon',0)
self.monsterAIRecord[monData.guid]=nil
else
if monData.data.mId then
if not emergenciesControl:getEventMonsterData(monData.guid)then
bt:setSharedVar('canClearMon',0)
self.monsterAIRecord[monData.guid]=nil
end
else
if not isometricMapSystem:getSundries(monData.guid)then
bt:setSharedVar('canClearMon',0)
self.monsterAIRecord[monData.guid]=nil
end
end
end
end

function isometricMapSystem:checkDZClearMonsterAI()
if not self.monsterAIRecord then
return
end
for k,v in pairs(self.monsterAIRecord)do
local dzId=v.exFightDZId
if dzId then
local replace=false
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
if bt then
local cmdType=bt:getSharedVar('cmdType')
if cmdType~=eAIType.eFightMonster then
replace=true
end
else
replace=true
end
if replace then
self.monsterAIRecord[k]=nil
isometricMapSystem:startClearMonsterAI(v.data)
logWarn('除妖弟子未在工作，切换弟子执行')
local discipleName=UIDiscipleModel:getDiscipleName(dzId)
platformSDK.printSDK(FMT.fmt('ClearMonsterAI 除妖弟子未在工作,切换弟子执行 怪物guid:{0} 弟子名字：{1} 弟子id：{2}',v.guid,discipleName,dzId))
return
end
end
end
end

function isometricMapSystem:startClearMonster(monData,dzStId)
local monGuid=monData.guid
local monEntity=_EntityManager:GetEntity(monGuid)
if monEntity then
monEntity:PlayEffect(20009,Vector3.zero,Vector3(0.6,0.6,0.6),true,true)
monEntity:SetColor(Color.New(1,1,1,0))
monEntity:ShowShadow(false)
end
if monData.data.hudId then
hudControl:removeHUD(monData.data.hudId)
end

local dzEntity=_EntityManager:GetEntity(dzStId)
if dzEntity then
dzEntity:SetColor(Color.New(1,1,1,0))
dzEntity:ShowShadow(false)
end
end

function isometricMapSystem:endClearMonster(dzStId)
local dzEntity=_EntityManager:GetEntity(dzStId)
if dzEntity then
dzEntity:SetColor(Color.New(1,1,1,1))
dzEntity:ShowShadow(true)
end
end

function isometricMapSystem:aiRewardMonster(sfId,monData)
if monData.data.mId then

guildOrderController:send_3_248(2,monData.data.mId)
self.monsterAIRecord[monData.guid]=nil
else

guildOrderController:send_3_248(1,monData.data.serverGuid)
self.monsterAIRecord[monData.guid]=nil
end
end
