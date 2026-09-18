
function isometricMapSystem:initSundriesData()
self.sundriseDict={}
end

function isometricMapSystem:clearSundriesData()
self.sundriseDict=nil
end

function isometricMapSystem:resetSundriesList()
if self.unlockSundise~=nil then
for guid,v in pairs(self.unlockSundise)do
notifySystem:postNotify(notifyConfig.remove_sundrise,guid)
end
end
self.sundriseRecord={}
self.unlockSundise={}
self.sundriseAIRecord={}
self.monsterAIRecord={}
end

function isometricMapSystem:getSundries(guid)
return self.sundriseRecord[guid]
end

function isometricMapSystem:getAllSundriesDataByType(mapId,stype)
local list={}
for k,v in pairs(self.sundriseRecord)do
if(v.mapId==mapId or mapId<0)and v.type==stype then
table.insert(list,v)
end
end
return list
end

function isometricMapSystem:getAllSundriesGuidListByBatchBoxType(mapId,batchBoxType)
local list={}
for k,v in pairs(self.sundriseRecord)do
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,v.id)
if(v.mapId==mapId or mapId<0)and cfg.batchBoxType==batchBoxType then
table.insert(list,v.serverGuid)
end
end
return list
end

function isometricMapSystem:findUnlockSundriesBySType(mapId,stype)
local list={}
for k,v in pairs(self.unlockSundise)do
if(v.mapId==mapId or mapId<0)and v.type==stype then
table.insert(list,v)
end
end
return list
end

function isometricMapSystem:findMapLookupUnlockSundriesBySType(mapLookup,stype)
local list={}
for k,v in pairs(self.unlockSundise)do
if mapLookup[v.mapId]==true and v.type==stype then
table.insert(list,v)
end
end
return list
end

function isometricMapSystem:getUnlockSundriesInRange(mapId,x,y,radius)
local list={}

local bx=x-radius
local by=y-radius
local ex=x+radius
local ey=y+radius
for k,v in pairs(self.unlockSundise)do




if mapId==v.mapId and v.x>=bx and v.x<=ex and v.y>=by and v.y<=ey then
table.insert(list,v)
end
end
return list
end

function isometricMapSystem:removeSundries(guid)
local data=self.sundriseRecord[guid]
if data then
local hudId=data.hudId
if hudId then
hudControl:removeHUD(hudId)
end
end
self.sundriseRecord[guid]=nil
self.unlockSundise[guid]=nil



notifySystem:postNotify(notifyConfig.remove_sundrise,guid)
end

function isometricMapSystem:findSundries(mapId,x,y)





logErr('改功能已弃用，需联系前端程序修改',mapId,x,y)
end

function isometricMapSystem:findUnlockSundries(mapId,x,y)





logErr('改功能已弃用，需联系前端程序修改',mapId,x,y)
end

function isometricMapSystem:findUnlockSundriesByID(mapId,id)
for k,v in pairs(self.unlockSundise)do
if v.mapId==mapId and v.id==id then
return v
end
end
end

function isometricMapSystem:findUnlockSundriesByGuid(guid)
return self.unlockSundise[guid]
end

function isometricMapSystem:findSundriesByID(mapId,id)
for k,v in pairs(self.sundriseRecord)do
if v.mapId==mapId and v.id==id then
return v
end
end
end

function isometricMapSystem:getSundriesData(guid)
return self.sundriseRecord[guid]
end

function isometricMapSystem:getSundriesDataByServerGuid(guid)
return self.sundriseDict[guid]
end

function isometricMapSystem:setSundriesDataByServerGuid(guid,data)
self.sundriseDict[guid]=data
end

function isometricMapSystem:getSundriesDataByPos(mapId,x,y)


logErr('改功能已弃用，需联系前端程序修改',mapId,x,y)
end

function isometricMapSystem:findSundriesWithType(mapId,x,y,stype)
for k,v in pairs(self.sundriseRecord)do
if v.mapId==mapId and v.x==x and v.y==y and v.type==stype then
return v
end
end
end

function isometricMapSystem:findNoServerData(mapId,x,y,id)

if x==0 and y==0 then
return nil
end
for k,v in pairs(self.sundriseRecord)do
if not v.serverGuid and v.mapId==mapId and v.x==x and v.y==y and v.id==id then
return v
end
end
end

function isometricMapSystem:getMountRandomReward(sfId,data)









local guidList
local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,data.id)
if cfg.batchBoxType~=nil then
guidList=isometricMapSystem:getAllSundriesGuidListByBatchBoxType(sfId,cfg.batchBoxType)
else
guidList={data.serverGuid}
end

if data.type==sundriseType.eRewardBox then

AudioManager.playAudio(431)
end

zongmenControl:reqGetMountRandomReward(sfId,#guidList,guidList)
end

function isometricMapSystem:iseStillObject(stype)
return stype==objectType.eStillSundrise or stype==objectType.eStillPlaceObject
end

function isometricMapSystem:createSundries(args)
local id=args.id
local flip=args.flip
local pos=args.pos
local complete=args.complete
local areaId=args.areaId
local unlock=args.unlock
local level=args.level
local mapId=args.mapId
local end_times=args.end_times or 0
local auto_clear=args.auto_clear or 0

local cfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,id)

if not cfg then
if deviceHelper.isRunNoneOrEditor()then
logErr(FMT.fmt('杂物未配置 id:{0}',id))
else
platformSDK.printSDK("杂物未配置 id",id)
return
end
end

local placeId=cfg.placeId or conditionConfig.default
local guid
local stype=cfg.type

local btId
local sx=cfg.size[1]
local sy=cfg.size[2]
local zmScale=cfg.zmScale or 1
if stype==sundriseType.eMovementSundrise or stype==sundriseType.eMovementEnemy then
pos=_MapManager.FindAPosToStand(mapId,pos,3,conditionConfig.default)
local model=complete and cfg.reward_model[1]or cfg.model[1]
local slots=complete and cfg.reward_model[2]or cfg.model[2]
local scale=self:getModelScale(model)
guid=isometricMapSystem:createRoleEntity(objectType.eMovementSundrise,mapId,id,model,slots,SortingLayers.ITBuilding,zmScale*scale,pos)
if not complete then
btId=self:addSundriesBehaviorTree(guid)
end
elseif stype==sundriseType.eScenery then
local offset=self:countOffset(sx,sy)
local model=cfg.model[1]
local slots=cfg.model[2]
local scale=self:getModelScale(model)
guid=isometricMapSystem:createBuildingEntity(objectType.ePlaceObject,mapId,cfg.rewards_conf.buildid,model,slots,SortingLayers.ITBuilding,true,
flip,zmScale*scale,pos,offset,placeId)
else
local offset=self:countOffset(sx,sy)
local model=complete and cfg.reward_model[1]or cfg.model[1]
local slots=complete and cfg.reward_model[2]or cfg.model[2]
local scale=self:getModelScale(model)
local otype=stype==sundriseType.eStillSundrise and objectType.eStillSundrise or objectType.eStillPlaceObject
guid=isometricMapSystem:createPlaceObjectEntity(otype,mapId,id,model,slots,SortingLayers.ITBuilding,flip,zmScale*scale,pos,offset,placeId)
end
local pvals=_MapManager.Vector3IntToArray(pos)




if cfg.showShadow then
_MapManager.ShowShadow(guid,true)
end
local x=pvals[1]
local y=pvals[2]


local serverGuid=args.serverGuid

local data={
id=id,
guid=guid,
mapId=mapId,
x=x,
y=y,
type=stype,
btId=btId,
complete=complete,
areaId=areaId,
unlock=unlock,
level=level,

end_times=end_times,
serverGuid=serverGuid,
auto_clear=auto_clear,
}
self.sundriseRecord[guid]=data

local rect=_MapManager.GetObjectRectInMap(guid)
data.rx=rect[1]+rect[3]-1
data.ry=rect[2]+rect[4]-1

data.hudId=self:addMonsterHud(data)

if unlock then
self.unlockSundise[guid]=data
notifySystem:postNotify(notifyConfig.create_sundrise,id,guid,stype)
end


if serverGuid then
self:setSundriesDataByServerGuid(serverGuid,data)
end

return data
end






















function isometricMapSystem:unlockSundries(edata,rdata)
edata.end_times=rdata.end_times or 0
self.unlockSundise[edata.guid]=edata
if edata.type==sundriseType.eBrand then
self:getMountRandomReward(edata.mapId,edata)
end
edata.hudId=self:addMonsterHud(edata)
notifySystem:postNotify(notifyConfig.updata_sundrise,edata.id,edata.guid,edata.stype)
end

function isometricMapSystem:addSundriesBehaviorTree(guid)



end

function isometricMapSystem:removeSundriesBehaviorTree(guid)




end

function isometricMapSystem:addMonsterHud(data)
if data.stype==sundriseType.eMovementEnemy or data.stype==sundriseType.eStillEnemy then

if zongmenModel:isAreaUnlockInMap(data.mapId,data.areaId)then
local offset=_MapManager.GetObjectHeadOffset(data.guid)
local hudId=hudControl:addHUD(INSTANCE_TYPE.eMonsterMark,data.guid,offset,false,true,function(hudId)
local bw=hudControl:getHUDWidget(hudId)
bw:SetChildButtonClick(1,function()
if isometricMapSystem:getLayoutMode()==layoutMode.eDefault then
UIManager:showWindow('UIChallengeWin',isometricMapSystem:getSundriesData(data.guid))
end
end)
end)
return hudId
end
end
end


















function isometricMapSystem:receiveSundries(mapId,serverGuid,ignoreEnemy)

local data=isometricMapSystem:getSundriesDataByServerGuid(serverGuid)
if data then
local stype=data.type
if ignoreEnemy then
if stype==sundriseType.eMovementEnemy or stype==sundriseType.eStillEnemy then
return
end
end
local guid=data.guid

if stype==sundriseType.eBrand then
_MapManager.PickUpFromMap(guid)
_MapManager.SetFadeToColor(guid,Color.New(1,1,1,0),1,function()
_MapManager.RemoveTilemapObject(guid)
self:removeSundries(guid)
end)
return
end
if stype==sundriseType.eStillSundrise
or stype==sundriseType.eStillEnemy
or stype==sundriseType.eRewardBox
or stype==sundriseType.eMiJing then
_MapManager.PickUpFromMap(guid)
else
self:removeSundriesBehaviorTree(guid)
end
_MapManager.RemoveTilemapObject(guid)

self:removeSundries(guid)
else
if not mainControl:isInScene(eSceneType.eZongmen)then
logErr(FMT.fmt('找不到对应随机物数据 guid:{0}',guid))
end
end
end

function isometricMapSystem:receiveAllSundries()
local sfId=zongmenModel:getMountainId()
for k,v in pairs(self.sundriseRecord)do
if v.unlock and(v.type==sundriseType.eStillSundrise or v.type==sundriseType.eMovementSundrise)then

self:getMountRandomReward(sfId,v)
end
end
end

function isometricMapSystem:conversionSundries(mapId,x,y)
local data=self:findSundriesWithType(mapId,x,y,sundriseType.eScenery)
if data then
local guid=data.guid
self:removeSundries(guid)
return guid
end
end

function isometricMapSystem:isInOtherCollectArea(mapId,x,y,radius)

local bx=x-radius
local by=y-radius
local ex=x+radius
local ey=y+radius
for k,v in pairs(self.sundriseAIRecord)do




if mapId==v.mapId and v.x>=bx and v.x<=ex and v.y>=by and v.y<=ey then
return true
end
end

return false
end

function isometricMapSystem:startReceiveSundriesAI(data,isWarning)
if isWarning==nil then isWarning=true end
local mapId=_MapManager.GetObjectMapID(data.guid)

local cfg=cfgHelper.get1(cfg_disciplecollectconfig_get,1)
if self:isInOtherCollectArea(mapId,data.x,data.y,cfg.radius)then
if isWarning then
UIManager.info('弟子正前来清除杂物')
end
return 1
end

local pos=_MapManager.ToVector3Int(data.x,data.y,0)

local dzId=aiManager:getNearbyDisciple(mapId,pos,eAIDZType.eDefault)

if not dzId then
if isWarning then
UIManager.info('弟子都在忙碌，无暇前来清除杂物')
end
return 2
end

if self.sundriseAIRecord[data.guid]then
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
local rData={mapId=mapId,x=data.x,y=data.y,data=data}
self.sundriseAIRecord[data.guid]=rData
notifySystem:postNotify(notifyConfig.onSundriseAIRecord,data.guid,true)
local datas=self:getUnlockSundriesInRange(mapId,data.x,data.y,cfg.radius)
local sdatas={}
for i,v in ipairs(datas)do
if v~=data and(v.type==sundriseType.eStillSundrise or v.type==sundriseType.eMovementSundrise)then
table.insert(sdatas,v)
end
end
table.insert(sdatas,1,data)
local count=#sdatas
local cmdData={
type=eAIType.eSundrise,
initData={pos={data.x,data.y},hudId=hudId,sdatas=sdatas,sindex=1,
sfId=mapId,scount=count,ctime=cfg.time,radius=cfg.radius},
restorePreviousAI=true,
endCallback=function(diziId,stId,bt,interrupt)
self.sundriseAIRecord[data.guid]=nil
notifySystem:postNotify(notifyConfig.onSundriseAIRecord,data.guid,false)
end,
removeCallback=function(diziId,stId,bt)

local sds=bt:getSharedVar('sdatas')
for i,v in ipairs(sds or{})do
self:getMountRandomReward(mapId,v)
end
end
}
aiManager:addCommandToDisciple(dzId,cmdData)
rData.exDZId=dzId
rData.hudId=hudId
end

function isometricMapSystem:checkDZCollectAI()
if not self.sundriseAIRecord then
return
end
for k,v in pairs(self.sundriseAIRecord)do
local dzId=v.exDZId
if dzId then
local replace=false
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
if bt then
local cmdType=bt:getSharedVar('cmdType')
if cmdType~=eAIType.eSundrise then
replace=true
end
else
replace=true
end
if replace then
self.sundriseAIRecord[k]=nil
hudControl:removeHUD(v.hudId)
isometricMapSystem:startClearSundriesAI(v.data,v.typo)
logWarn('采集弟子未在工作，切换弟子执行')
return
end
end
end
end


function isometricMapSystem:hideCollectArea(bt)
local pos=bt:getSharedVar('pos')
local radius=bt:getSharedVar('radius')
local stId=bt:getSharedVar('stId')
local mapId=_MapManager.GetObjectMapID(stId)
_MapManager.DrawInRange(mapId,1,_MapManager.ToVector3Int(pos[1],pos[2],0),radius,-1,mapLayer.DrawCollect)
end


function isometricMapSystem:getNextCollectPos(bt,datas,index)
local sd=bt:getSharedVar('sdata')
if sd then
for i,v in ipairs(datas)do
v.dis=math.abs(v.x-sd.x)+math.abs(v.y-sd.y)
end
table.sort(datas,function(a,b)
return a.dis<b.dis
end)
end

local data=table.remove(datas,1)
if data then
data.dis=nil


bt:setSharedVar('spos',{data.x,data.y})
bt:setSharedVar('sdata',data)
end
end

function isometricMapSystem:isCanCollect(bt,data,isPlayAudio)
local pass=false
if data then
local pdata=self:getSundries(data.guid)
pass=pdata~=nil
end
bt:setSharedVar('canCollect',pass)
if isPlayAudio then


end
end

function isometricMapSystem:receiveSundriesOnArea(mapId,pos,radius)
local datas=self:getUnlockSundriesInRange(mapId,pos[1],pos[2],radius)
if datas then
local sfId=zongmenModel:getMountainId()
for k,v in pairs(datas)do
if v.type==sundriseType.eStillSundrise or v.type==sundriseType.eMovementSundrise then
self:getMountRandomReward(sfId,v)
end
end
end
end


function isometricMapSystem:getSundriesCollectSpeakText(bt,tkey,type)
local cfg=cfgHelper.get1(cfg_disciplecollectconfig_get,1)
local speakData=cfg[string.format('speak%d',type)]
local txt=speakData[math.random(1,#speakData)]
bt:setSharedVar(tkey,txt)
end


function isometricMapSystem:showStillSundriesRewardHud(mapId,x,y,rewards,hudOffset,guid)
local pos
if guid then
local data=isometricMapSystem:getSundriesDataByServerGuid(guid)
pos=_MapManager.ToVector3Int(data.x,data.y,0)
else
pos=_MapManager.ToVector3Int(x,y,0)
end
local offset=hudOffset or Vector3(0,0.2,0)
hudControl:addHUDWithPosition(INSTANCE_TYPE.eStillSundriseReward,mapId,pos,offset,false,true,function(hud)
local widget=hudControl:getHUDWidget(hud)
local func=function()
hudControl:removeHUD(hud)
end
local cb
local cnt=#rewards
local posList=cfgHelper.getglobal1('suijiwuhudoffset')
local optionTab={}
for i,v in ipairs(posList)do
table.insert(optionTab,v)
end
for i=1,5 do
widget:SetChildActive(i-1,i<=cnt)
local widget1=widget:GetChildWidgetBase(i-1)
if i<=cnt then
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local iconName=iconHelper.getIconName(itemid)
widget1:SetChildIcon(1,iconName,false)
widget1:SetChildText(2,FMT.fmt('+{0}',count))
if i==cnt then
cb=func
end
local rand=math.random(1,#optionTab)
local randPos=optionTab[rand]
table.remove(optionTab,rand)
local offsetX=randPos[1]
local offsetY=randPos[2]
widget1:SetCurveAniPlay(1,1,Vector3(0,offsetY,0),Vector3(offsetX,100+offsetY,0),cb)
widget1:SetCurveAniPlay(2,1,Vector3(0,0,0),Vector3(58,0,0),nil)
end
end
end)
end

function isometricMapSystem:receiveSundriesByEntityArea(guid)
local mapId=_MapManager.GetObjectMapID(guid)
local rect=_MapManager.GetObjectRectInMap(guid)
local sx=rect[1]
local sy=rect[2]
local ex=sx+rect[3]-1
local ey=sy+rect[4]-1








for k,v in pairs(self.unlockSundise)do
if v.type==sundriseType.eStillSundrise or v.type==sundriseType.eMovementSundrise then
if self:checkOverlap(sx,sy,ex,ey,v.x,v.y,v.rx,v.ry)then
self:getMountRandomReward(mapId,v)
end
end
end

local list=self:findRandomObjectInArea(mapId,sx,sy,ex,ey)
for i,v in ipairs(list)do
self:getRandomObjectReward(v)
end
end

function isometricMapSystem:receiveSundriesByPosList(mapId,posList)
for i,pos in ipairs(posList)do
local x,y=pos.x,pos.y
for k,v in pairs(self.unlockSundise)do
if v.type==sundriseType.eStillSundrise or v.type==sundriseType.eMovementSundrise then
if self:checkOverlap(x,y,x,y,v.x,v.y,v.rx,v.ry)then
self:getMountRandomReward(mapId,v)
end
end
end

local list=self:findRandomObjectInArea(mapId,x,y,x,y)
for i,v in ipairs(list)do
self:getRandomObjectReward(v)
end
end
end

function isometricMapSystem:checkOverlap(ax1,ay1,ax2,ay2,bx1,by1,bx2,by2)
return ax2>=bx1 and ay2>=by1 and ax1<=bx2 and ay1<=by2
end
