
xianChongControl=gameState.addListener({})

eXCType={
eGou=1,
}

function xianChongControl:onAppStart()

end

function xianChongControl:onEnterState(isReconnect)
if isReconnect then
return
end
self.xcCOunt=0
self.GUIDToXCID={}
self.GUIDToData={}
self.tempList={}
self.dogTitle=false
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
end

function xianChongControl:onLeaveState(isReconnect)
if isReconnect then
return
end
self.GUIDToXCID=nil
self.GUIDToData=nil
self.tempList={}
self.dogTitle=false
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
end

function xianChongControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
xianChongControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
xianChongControl:onLeaveHome()
end
end

function xianChongControl:onEnterHome()
self.isInHome=true
if systemModel.isOpen(SYSTEM_DEFINE.eBatch)then
self:addAXianChong(eXCType.eGou)
end
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end

function xianChongControl:onLeaveHome()
self.isInHome=nil
xianChongControl:addTitleHUD(false)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
timeEventController.removeQuickTimerHandler('xianChongControl')
end

function xianChongControl.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eBatch then
xianChongControl:addAXianChong(eXCType.eGou)
end
end

function xianChongControl:getXCGUID()
self.xcCOunt=self.xcCOunt-1
return self.xcCOunt
end

function xianChongControl:addAXianChong(xcType)
if not self.isInHome then
return
end

local xcId=self:getXCGUID()


local bpos=_MapManager.ToVector3Int(-6,-33,0)

local cfg=cfgHelper.get1(cfg_xianchongconfig_get,xcType)
local modelId=cfg.model
local scale=isometricMapSystem:getModelScale(modelId)
local stId=isometricMapSystem:createRoleEntity(objectType.eXianChong,mapIdType.zhufeng,0,modelId,nil,SortingLayers.ITBuilding,scale,bpos)
_MapManager.ShowShadow(stId,true)
aiManager:addDiscipleAI(xcId,stId,eAIDZType.eXianChong)

local data={
id=xcType,
stId=stId,
name=cfg.name,
homeType=SLG_SYSTEM_TYPE[cfg.home],
}
self.xcId=xcId
self.GUIDToData[xcId]=data
self.GUIDToXCID[stId]=xcId
self:freshDogTitle()
timeEventController.addQuickTimerHandler('xianChongControl',xianChongControl)
end

function xianChongControl:addTitleHUD(flag)
local has=self.dogTitleHudId~=nil
if has==flag then return end
if flag then
local xcId=self.xcId
local data=self.GUIDToData[xcId]
if data==nil then return end
local offset=_MapManager.GetObjectHeadOffset(data.stId)
self.dogTitleHudId=hudControl:addHUD(INSTANCE_TYPE.eDogTipsHUD,data.stId,offset,true,true,function(id)
local widget=hudControl:getHUDWidget(id)
widget:SetChildButtonClick(1,function()
xianChongControl:showFastManufactureWin()
end,true)
end)
else
hudControl:removeHUD(self.dogTitleHudId)
self.dogTitleHudId=nil
end
end

function xianChongControl:getXianChongData(xcId)
return self.GUIDToData[xcId]
end

function xianChongControl:onTouchXianChong(stId)
local xcId=self.GUIDToXCID[stId]
local data=self.GUIDToData[xcId]
if data.id==1 then
self:showFastManufactureWin()
end
end

function xianChongControl:getXianChongIdByStId(stId)
local xcId=self.GUIDToXCID[stId]
local data=xcId and self.GUIDToData[xcId]or nil
return data and data.id or nil
end

function xianChongControl:showFastManufactureWin()
local datas,topTypes=zongmenControl:fastManufacture({})

UIManager:showWindow('UIFastManufactureWin',{datas,topTypes})



end

function xianChongControl:freshDogTitle()
if self.nextRefreshStamp and self.nextRefreshStamp>timeHelper.getServerShortTime()then return end
local refresh=false
if#self.tempList>0 then
local len=20
while not self.dogTitle and#self.tempList>0 and len>0 do
len=len-1
local un_build_id=self.tempList[1]
local v=zongmenModel:getBuildingData(un_build_id)
if v and v.flag==0 and v.plant_id==0 and v.dzIdStr~='0'then
local dzguidStr=v.dzIdStr
local netData=UIDiscipleModel:getDiscipleDataByStr(dzguidStr)
if UIDiscipleModel:checkDZStateToDoSomethingByData(netData,eCheckDiscipleStateOpType.eProduce,false)then
local id=v.build_id
local cfg=cfg_monijybuildconfig_get(id)
if cfg.win_type==sysWinType.eFangAn then
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,v.level)
local plans=lcfg.produce_plans
for ii,vv in ipairs(plans)do
local costs=vv.cost
local pass=true
for iii,vvv in ipairs(costs)do
local have=moneyModel.getMoney(vvv[1])
if have<vvv[2]then
pass=false
break
end
end
if pass then
self.dogTitle=true
end
break
end
end
end
end

if not self.dogTitle then
_remove(self.tempList,1)
else
refresh=true
self.nextRefreshStamp=timeHelper.getServerShortTime()+2
end
end
else
refresh=true
local sfId=zongmenModel:getMountainId()
local datas=zongmenModel:getAllBuildingDataBySF(sfId)
if datas then
for k,v in pairs(datas)do
self.tempList[#self.tempList+1]=v.un_build_id
end
end
end

if refresh then
xianChongControl:addTitleHUD(self.dogTitle)
self.dogTitle=false
end
end

function xianChongControl:onQuickUpdate()
xianChongControl:freshDogTitle()
end
