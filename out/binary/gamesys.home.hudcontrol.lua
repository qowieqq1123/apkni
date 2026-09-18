hudControl=gameState.addListener({})























































































local _usePoolType={
INSTANCE_TYPE.eDiscipleSpeak,
INSTANCE_TYPE.eRewardTips,
}

hudContainerType={
eDefault=0,
eStory=1,
}

local _tempList={}
local _len=0
local _startIdx=0
local _frameTimer=nil

function hudControl:onAppStart()


self.progressData={}
self.rewardTipsCounts={}
self.areaSearchHudLookup={}
self.areaSearchHudTimer={}
end

function hudControl:onEnterState(isReconnect)
_tempList={}
_len=0
_startIdx=0
hudControl:stopFrameTimer()
if isReconnect then
return
end

end

function hudControl:onLeaveState(isReconnect)
_tempList={}
_len=0
_startIdx=0
hudControl:stopFrameTimer()
if isReconnect then
self.isReconnect=true
return
end

end

function hudControl:onReConnection(isReconnect)
if isReconnect then
self.isReconnect=nil
end
end









function hudControl:showHUDWin()
UIManager:showWindow("UIHUDWin",_usePoolType)
end

function hudControl:showHUDWinRoot(show)
UIManager:invokeUIMethod('UIHUDWin','SetActive',show)
end

function hudControl:closeHUDWin()
UIManager:closeWindow("UIHUDWin")
end

function hudControl:onEnterHome()


end

function hudControl:onLeaveHome()

for k,v in pairs(self.progressData)do
if v.tweener then
v.tweener:Kill()
v.tweener=nil
end
end
self.progressData={}
self.rewardTipsCounts={}
self.areaSearchHudLookup={}
hudControl:stopAllAreaSearchTimer()
hudControl:stopFrameTimer()
_tempList={}
_len=0
_startIdx=0
end


function hudControl.ontick(all)
local max=#_tempList
local nextIdx=_startIdx+1
if nextIdx>max then return end

local tickNum=all and max or _len
local maxIdx=math.min(_startIdx+tickNum,max)
_startIdx=maxIdx

local time=gameUtilityModel.getServerShortTime()
for i=nextIdx,maxIdx do
local v=_tempList[i]
if v.hud then
local defData=hudControl:getHudDefineData(v.type)
if defData then
defData.update(v,time)
end
end
end
end

function hudControl:onNormalUpdate()
if reconnectState:isDisConnectOrReconnect()then
return
end

self.ontick(true)
_startIdx=0
_tempList={}
for _,v in pairs(self.progressData)do
if v.activeUpdate and v.type then
_insert(_tempList,v)
end
end
_len=math.ceil(#_tempList/40)
self:startFrameTimer()
end

function hudControl:startFrameTimer()
if _frameTimer==nil then
_frameTimer=FrameTimer.New(self.ontick,0,-1)
_frameTimer:Start()
end
end

function hudControl:stopFrameTimer()
if _frameTimer~=nil then
_frameTimer:Stop()
_frameTimer=nil
end
end



function hudControl:receiveReward(data)
local isbuild=data.type==hudType.build or data.type==hudType.levelUp
if data.complete and(isbuild or isometricMapSystem:getLayoutMode()==layoutMode.eDefault)then
local sfId=zongmenModel:getMountainId()
return isometricMapSystem:completeBuildingProgress(sfId,data.bdData)
end
return false
end

function hudControl:getLastTime(bdId)
local data=self.progressData[bdId]
if data then
local time=gameUtilityModel.getServerShortTime()
local dt=time-data.begintime
return data.needTime-dt
end
return 0
end

function hudControl:isComplete(bdId)
local data=self.progressData[bdId]
return data and data.complete
end

function hudControl:getHUDType(bdId)
local data=self.progressData[bdId]
return data and data.type
end

function hudControl:closeProgress(bdId)
local data=self.progressData[bdId]
if data then
data.showProgressBar=false
data.complete=false
if data.tweener then
data.tweener:Rewind()
data.tweener:Kill()
data.tweener=nil
end
end
end

function hudControl:addProgressData(sfId,bdId,refresh,bdData)
local data=self.progressData[bdId]or{}
self.progressData[bdId]=data
bdData=bdData or zongmenModel:getBuildingData(bdId)
data.bdData=bdData
data.showProgressBar=false
data.progress=0
if refresh then
self:refreshBuildingStatusHUD(bdId)
end

end

function hudControl:changeTarget(sfId,bdId)
local data=self.progressData[bdId]
if data then
local bdData=zongmenModel:getBuildingData(bdId)
data.bdData=bdData
if data.hud then
self:setHUDTarget(data.hud,bdData.entityId)
end
end
end

function hudControl:removeProgressData(bdId)
local data=self.progressData[bdId]
if data and data.hud then
self:removeHUD(data.hud)
data.hud=nil
data.status=nil
end
self.progressData[bdId]=nil
end

function hudControl:getProgressData(bdId)
local data=self.progressData[bdId]
return data
end

function hudControl:getHudType(bdId)
local data=self.progressData[bdId]
local bdData=data.bdData

if emergenciesModel:isInRepairTime(bdId)then
return hudType.repair
end
if jctjDuJieXianDanModel:isInRepairTime(bdId)then
return hudType.repair
end
if emergenciesControl:isBuildingOnFire(bdData.entityId)then
return hudType.mieHuo
end
if emergenciesModel:isCreeper(bdId)then
return hudType.creeper
end

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)

if not bdData.flag then
loggerUtil.debugErrFMT("hud flag异常 建筑id{0}",bdData.build_id)
end
local ftype=zongmenModel:getBDFlagType(bdData.flag)

if cfg.is_connect_road==1 and not bdData.isLinkRoad and ftype==bdFlagType.normal then
return hudType.unlinkRoad
end
if ftype==bdFlagType.normal then
local htype=self:getHudTypeByConditionFunction(cfg,bdData)
if not htype and tostring(bdData.dizi_id)~='0'then
local dzState=UIDiscipleModel:getDiscipleState(bdData.dizi_id)



if dzState==DISCIPLE_STATE_TYPE.eChuiWei then
return hudType.chuiwei
elseif cfg.win_type==sysWinType.eFangAn then
return hudType.konxian
end
end

if not htype then
if buildSkinModel:checkBuildSkinUnLockReddotByBuildId(bdData.build_id)then
return hudType.canUnlockSkin
end
end
return htype
elseif ftype==bdFlagType.undefine then
return self:getHudTypeByRCFunction(cfg,bdData)
else

if ftype==bdFlagType.build or ftype==bdFlagType.sectionBuildStart then
if bdData.build_id==SLG_SYSTEM_TYPE.eWanBaoShangHui then

local htype=self:getHudTypeByConditionFunction(cfg,bdData)
if htype then
return htype
end
end
local ltime=self:getBuildTime(cfg,ftype,bdData)
if ltime>0 then
return hudType.build
end
elseif ftype==bdFlagType.levelUp then
local ltime=self:getBuildTime(cfg,ftype,bdData)
if ltime>0 then
return hudType.levelUp
end
elseif ftype==bdFlagType.sectionBuildComplete then

if bdData.build_id==SLG_SYSTEM_TYPE.eFeiShengTai2 then

local htype=self:getHudTypeByConditionFunction(cfg,bdData)
if htype then
return htype
end
end
end
end
end

function hudControl:getBuildTime(cfg,ftype,bdData)
if ftype==bdFlagType.sectionBuildStart then
local ultime=cfg.repair_time[bdData.flag-10]
return ultime
end

if ftype==bdFlagType.build then
local ultime=cfgHelper.get3(cfg_monijybuilduplvlconfig_get,bdData.build_id,1,'uplevel_times')
return ultime
end

if ftype==bdFlagType.levelUp then
local ultime=cfgHelper.get3(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1,'uplevel_times')
return ultime
end
end

function hudControl:refreshHUDByBDID(mapId,bdId)
local datas=zongmenModel:getAllBuildingData(mapId)
for k,v in pairs(datas)do
if v.build_id==bdId then
self:refreshBuildingStatusHUD(k)
end
end
end

function hudControl:refreshBuildingStatusHUD(bdId)
local data=self.progressData[bdId]
if data==nil then return end

local hType=self:getHudType(bdId)

if hType then
if not data.hud then
if not data.loadType then
data.loadType=hType
local bdData=data.bdData
self:addHUD(INSTANCE_TYPE.eBuildingStatus,bdData.entityId,self:getHUDHeight(bdData.build_id),false,true,function(id)
local nowHType=self:getHudType(bdId)
if nowHType then
data.loadType=nil
data.hud=id
self:handleRefresh(data,nowHType)
else

data.loadType=nil
self:removeHUD(id)
end
end)
end
else
self:handleRefresh(data,hType)
end
else
self:removeStateHUD(data)
end
end

function hudControl:handleRefresh(data,hType)
local widget=self:getHUDWidget(data.hud)
if widget==nil then return end
if data.type~=hType or not data.status then
if data.status then
self:removeStateHUDTweener(data)
widget:RemoveStatusWidget(data.status)
end
local preId=cfgHelper.get2(cfg_buildinghudconfig_get,hType,'pre_id')
data.status=widget:AddStatusWidget(preId)
data.firstUpdate=false
end

local sw=widget:GetWidget(data.status)

local defData=self:getHudDefineData(hType)
if defData then
if not defData.showInLayoutMode then
if isometricMapSystem:isInLayoutMode()then
self:hideHUD(sw,data)
else
self:showHUD(sw)
end
else
self:showHUD(sw)
end
if not data.firstUpdate then
defData.init(sw,data)
data.activeUpdate=defData.activeUpdate
if data.activeUpdate then
defData.update(data,gameUtilityModel.getServerShortTime())
end
data.firstUpdate=true
else
if defData.reset then
defData.reset(sw,data)
end
end
else
self:hideHUD(sw,data)
data.activeUpdate=false
end

self:refreshHUDPosition(data.hud)

data.type=hType
end

function hudControl:refreshAllBuilding()
if self.isReconnect then

return
end

for k,v in pairs(self.progressData)do
self:refreshBuildingStatusHUD(k)
end
end

function hudControl:getHUDHeight(id)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
return Vector3(cfg.iconOffset or 0,cfg.height,0)
end

function hudControl:showRewardTipsToPos(mapId,pos,moneyType,count,offset,entity)
local opos
if offset then
opos=Vector3(offset[1],offset[2]+1.5,0)
else
opos=Vector3(0,1.5,0)
end
self:addHUDWithPosition(INSTANCE_TYPE.eRewardTips,mapId,pos,opos,false,true,function(id)

local node=self:getHUDWidget(id)
node:SetChildIcon(1,iconHelper.getIconName(moneyType),true)
local txt
if count>=0 then
txt=FMT.fmt('{0}{1}','+',count)
else
local col=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
txt=FMT.fmt('<color={0}>{1}</color>',col,count)
end
node:SetChildText(2,txt)
node:SetChildLocalPos(0,0,0,0)
node:SetChildCanvasGroupAlpha(0,0)
local tweener=node:SetChildCanvasGroupDOFade(0,1,0.05,function()
local tweener=node:SetChildDOLocalMoveY(0,80,2,function()
self:removeHUD(id)
if entity then
self:addRewardTipsCount(entity,-1)
end
end)
tweener:SetEase(_Ease.Linear)

tweener=node:SetChildCanvasGroupDOFade(0,0,2)
tweener:SetEase(_Ease.InQuart)
tweener=node:SetChildDOPunchScale(0,Vector3.New(0.35,0.35,0),0.5,1)
end)
if entity then
local tcount=self:getRewardTipsCount(entity)
if tcount>0 then
tweener:SetDelay(tcount*0.75)
end
self:addRewardTipsCount(entity,1)
end
end)
end

function hudControl:showRewardTips(entity,moneyType,count,offset)
local pos=_MapManager.GetTilemapObjectPosition(entity)
local mapId=_MapManager.GetObjectMapID(entity)
self:showRewardTipsToPos(mapId,pos,moneyType,count,offset,entity)
end

function hudControl:getRewardTipsCount(entity)
return self.rewardTipsCounts[entity]or 0
end

function hudControl:addRewardTipsCount(entity,addVal)
local count=self:getRewardTipsCount(entity)
count=count+addVal
self.rewardTipsCounts[entity]=count
end


function hudControl:showAreaSearchToPos(mapId,areaId,pos)
if self.areaSearchHudLookup[areaId]~=nil then
return
end
local cfg=cfgHelper.get1(cfg_monijyareaconfig_get,areaId)
if not pos then
if not cfg.pos then
pos=Vector3Int(0,0,0)
else
pos=Vector3Int(cfg.pos[1],cfg.pos[2],cfg.pos[3])
end
end

local opos=Vector3(0,0,0)
self:addHUDWithPosition(INSTANCE_TYPE.eAreaSearch,mapId,pos,opos,false,true,function(id)
local node=self:getHUDWidget(id)
self.areaSearchHudLookup[areaId]=id

local areaData=zongmenModel:getAreaData(mapId,areaId)
local endTime=areaData.begintime+cfg.unlock_wait
local callFunc=function()
local curTime=gameUtilityModel.getServerShortTime()
local left=endTime-curTime
if left>=0 then
node:SetChildText(1,FMT.fmt("探索中：{0}",timeHelper.format_time_stamp3(left)))
node:SetChildActive(2,true)
node:SetChildActive(3,false)
else
node:SetChildText(1,"")
node:SetChildActive(2,false)
node:SetChildActive(3,true)
hudControl:stopAreaSearchTimer(areaId)
notifySystem:postNotify(notifyConfig.onZongMenAreaWaitUnLock,id,areaId)
end
end
if not self.areaSearchHudTimer[areaId]then
self.areaSearchHudTimer[areaId]=FrameTimer.New(callFunc,1,-1)
self.areaSearchHudTimer[areaId]:Start()
end
end)
end

function hudControl:removeAreaSearch(areaId)
local id=self.areaSearchHudLookup[areaId]
if id~=nil then
self:removeHUD(id)
self.areaSearchHudLookup[areaId]=nil
end
end

function hudControl:stopAreaSearchTimer(areaId)
if self.areaSearchHudTimer[areaId]then
self.areaSearchHudTimer[areaId]:Stop()
self.areaSearchHudTimer[areaId]=nil
end
end
function hudControl:stopAllAreaSearchTimer()
for i,v in pairs(self.areaSearchHudTimer)do
v:Stop()
end
self.areaSearchHudTimer={}
end


function hudControl:addUIHUD(manager,htype,parent)
local hudId=manager:setChildAddInstance(htype,parent)
return hudId
end

function hudControl:getUIHUDWidget(manager,hudId)
local widget=manager:getChildInstanceComponent(hudId,'CSGUIWidgetBase')
return widget
end

function hudControl:removeUIHUD(manager,hudId)
manager:setChildRemoveInstance(hudId)
end



function hudControl:addHUD(index,entity,offset,refreshPos,worldSpace,callback)
return UIManager:invokeUIMethod('UIHUDWin','AddHUD',index,entity,offset,refreshPos,worldSpace,callback)
end

function hudControl:addHUDWithPosition(index,mapId,pos,offset,refreshPos,worldSpace,callback)
return UIManager:invokeUIMethod('UIHUDWin','AddHUDWithPosition',index,mapId,pos,offset,refreshPos,worldSpace,callback)
end

function hudControl:removeHUD(id)
if id then
UIManager:invokeUIMethod('UIHUDWin','RemoveHUD',id)
else



end
end

function hudControl:getHUDWidget(id)
return UIManager:invokeUIMethod('UIHUDWin','GetHUDWidget',id)
end

function hudControl:setHUDTarget(id,entityId)
return UIManager:invokeUIMethod('UIHUDWin','SetHUDTarget',id,entityId)
end

function hudControl:setHUDTargetPosition(id,mapId,pos)
UIManager:invokeUIMethod('UIHUDWin','SetHUDTargetPosition',id,mapId,pos)
end

function hudControl:getHUDTargetPosition(guid)
return UIManager:invokeUIMethod('UIHUDWin','GetHUDTargetPosition',guid)
end

function hudControl:refreshHUDPosition(id)
return UIManager:invokeUIMethod('UIHUDWin','RefreshHUDPosition',id)
end

function hudControl:setUsePoolType(hudType,usePool)
UIManager:invokeUIMethod('UIHUDWin','SetUsePoolType',hudType,usePool)
end

function hudControl:setHUDActive(guid,bActive)
UIManager:invokeUIMethod('UIHUDWin','SetHUDActive',guid,bActive)
end

function hudControl:setHUDActiveByTarget(entityId,bActive)
UIManager:invokeUIMethod('UIHUDWin','SetHUDActiveByTarget',entityId,bActive)
end

function hudControl:getHudComponent(guid,name)
UIManager:invokeUIMethod('UIHUDWin','GetHudComponent',guid,name)
end

function hudControl:setHUDParent(guid,parent)
UIManager:invokeUIMethod('UIHUDWin','SetHUDParent',guid,parent)
end

function hudControl:changeContainer(guid,cId)
UIManager:invokeUIMethod('UIHUDWin','ChangeContainer',guid,cId)
end

function hudControl:setContainerActive(cId,flag)
UIManager:invokeUIMethod('UIHUDWin','SetContainerActive',cId,flag)
end

function hudControl:setContainerScale(cId,scale)
UIManager:invokeUIMethod('UIHUDWin','SetContainerScale',cId,scale)
end

function hudControl:setContainerAlpha(cId,alpha)
UIManager:invokeUIMethod('UIHUDWin','SetContainerAlpha',cId,alpha)
end

function hudControl:setContainerRaycast(cId,enable)
UIManager:invokeUIMethod('UIHUDWin','SetContainerRaycast',cId,enable)
end

function hudControl:setContainerGRActive(cId,bActive)
UIManager:invokeUIMethod('UIHUDWin','SetContainerGRActive',cId,bActive)
end

function hudControl:clearHUDByEntityID(entityId)
zongmenModel:removeNameHud(entityId)
if entityId==nil then return end
UIManager:invokeUIMethod('UIHUDWin','ClearHUDByEntityID',entityId)
end

function hudControl:isNeedLoad(id)
return UIManager:invokeUIMethod('UIHUDWin','IsNeedLoad',id)
end

function hudControl:flowText(pos,offset,value)
return UIManager:invokeUIMethod('UIHUDWin','flowText',pos,offset,value)
end
