






local _MODULENAME="LittleWorldController"

gameState.addListener(def_table(_MODULENAME))
LittleWorldController.name=_MODULENAME
LittleWorldController.data={}

function LittleWorldController:onAppStart()

LittleWorldModel:onAppStart()




socketManager:register_receiver(37,66,self.recv_37_66)
socketManager:register_receiver(37,67,self.recv_37_67)
socketManager:register_receiver(37,68,self.recv_37_68)
socketManager:register_receiver(37,69,self.recv_37_69)
socketManager:register_receiver(37,70,self.recv_37_70)

socketManager:register_receiver(37,71,self.recv_37_71)

socketManager:register_receiver(37,73,self.recv_37_73)
socketManager:register_receiver(37,74,self.recv_37_74)
socketManager:register_receiver(37,75,self.recv_37_75)
socketManager:register_receiver(37,76,self.recv_37_76)






end


function LittleWorldController:onEnterState(isReconnect)
LittleWorldModel:onEnterState()

eventTextNotifyControl.register(EVENT_TYPE.eNomal,{EVENT_NORMAL_SUB_TYPE.eLittleWorld},self.onRecvEventMesg)


end


function LittleWorldController:onProtocolReq()
LittleWorldModel:onProtocolReq()

notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)

LittleWorldModel:hideBuilding(true)
end


function LittleWorldController:onLeaveState(isReconnect)
LittleWorldModel:onLeaveState(isReconnect)

eventTextNotifyControl.unregister(EVENT_TYPE.eNomal,{EVENT_NORMAL_SUB_TYPE.eLittleWorld},self.onRecvEventMesg)

notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)

self.data={}
end


function LittleWorldController:onLostConnection()

end


function LittleWorldController:onReConnection(isInitPro)

end

function LittleWorldController.onRecvEventMesg(mesg,eventid,paramList,timeStamp)
LittleWorldModel:recordEvent(mesg,eventid,paramList,timeStamp)

UIManager:callWindowFunc("UIXJLittleWorldInfoWin","refreshEventPanel")
end


function LittleWorldController.on_building_event(etype,id,bdId,args)
if etype==buildingEvent.buildStart then
if systemModel.isOpen(SYSTEM_DEFINE.eSmallWorld)then
local data=zongmenModel:getBuildingData(bdId)
local build_id=data.build_id
if SLG_SYSTEM_TYPE.eLittleWorld==build_id then
local build_sf=cfgHelper.get2(cfg_monijybuildconfig_get,build_id,'build_sf')
zongmenControl:reqBuildComplete(build_sf[1],bdId)
end
end
end
end


function LittleWorldController.on_system_open(sysId)

if sysId==SYSTEM_DEFINE.eSmallWorld then
local Un_build_id=LittleWorldModel:getBuildingData()
if not Un_build_id then
LittleWorldController.repairWorld()
end
end
end


function LittleWorldController.checkLittleWorldRepair(mapId)
if systemModel.isOpen(SYSTEM_DEFINE.eSmallWorld)then
local bdData=LittleWorldModel:getBuildingData()
if not bdData then
LittleWorldController.repairWorld(mapId)
else
if bdData.flag==1 then
local build_sf=cfgHelper.get2(cfg_monijybuildconfig_get,bdData.build_id,'build_sf')
zongmenControl:reqBuildComplete(build_sf[1],bdData.un_build_id)
end
end
end
end

function LittleWorldController.repairWorld(mapId)
mapId=mapId or zongmenModel:getMountainId()

if mapId==mapIdType.fort then
local buildId=SLG_SYSTEM_TYPE.eLittleWorld
local build_sf=cfgHelper.get2(cfg_monijybuildconfig_get,buildId,'build_sf')
local data=isometricMapSystem:getRepairDataByID(build_sf[1],buildId)
if data then
zongmenControl:reqBuild(build_sf[1],data.id,data.x,data.y,0)
end
end
end






function LittleWorldController:doPunchRotation(win,widget,componentIndex,reddotIndex,isReddot)
if isReddot then
if win.reddotTweenerList==nil then
win.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#win.reddotTweenerList+1
end
widget:SetChildActive(componentIndex,true)
if win.reddotTweenerList[reddotIndex]==nil then

widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
win.reddotTweenerList[reddotIndex]={}
win.reddotTweenerList[reddotIndex].tweener=tweener
win.reddotTweenerList[reddotIndex].widget=widget
win.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
widget:SetChildActive(componentIndex,false)
if win.reddotTweenerList==nil or not next(win.reddotTweenerList)then
return nil
end
if win.reddotTweenerList[reddotIndex]~=nil then
win.reddotTweenerList[reddotIndex].tweener:Complete()
win.reddotTweenerList[reddotIndex].tweener:Kill()
win.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function LittleWorldController:endAllReddotPunchRotation(win)
if win.reddotTweenerList==nil or not next(win.reddotTweenerList)then
return
end
for i,v in pairs(win.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)
win.reddotTweenerList[i]=nil
end
end
end




function LittleWorldController.req_37_67()
socketManager:send_37_67()
end


function LittleWorldController.req_37_68(is_assistant)
socketManager:send_37_68(is_assistant or 0)
end


function LittleWorldController.req_37_70(order_id)
local wddFunc=function()
local flConfig=cfgHelper.get(cfg_smallworldorderconfig_get,order_id)
local addVal=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eFaLingCostChange)
local cost=mathHelper.floor(flConfig.cost*(1-(addVal/100)))
local desc=FMT.fmt("确认消耗{0}{1}颁布法令？",chatEmotHelper.getIconEmotMesg(moneyModel.getIconNameEx(eMoneyType.mtIncense),30),cost)
local func=function()
socketManager:send_37_70(order_id)
end
LittleWorldController.dialog_37_70=UIDialogManager.getConfirmDialog(LittleWorldController.dialog_37_70,'提示',desc)
LittleWorldController.dialog_37_70.okcallback=func
LittleWorldController.dialog_37_70:show()
end
if order_id==3 then
local getNum=LittleWorldModel:getLittleWorldStability()
local getMax=LittleWorldModel.getStabilityMax()
if getNum+50>getMax then
local func=function()
wddFunc()
end
local desc=FMT.fmt("稳定度最高只会达到{0}，是否确认颁布？",getMax)
LittleWorldController.dialog_37_70_wdd=UIDialogManager.getConfirmDialog(LittleWorldController.dialog_37_70_wdd,'提示',desc)
LittleWorldController.dialog_37_70_wdd.okcallback=func
LittleWorldController.dialog_37_70_wdd:show()
else
wddFunc()
end
else
wddFunc()
end

end

function LittleWorldController.req_37_73(block_id,town_id)
socketManager:send_37_73(block_id,town_id)
end

function LittleWorldController.req_37_74(block_id)
socketManager:send_37_74(block_id)
end

function LittleWorldController.req_37_76(town_id)
socketManager:send_37_76(town_id)
end


function LittleWorldController.recv_37_66(args)
local world_lv,xh_val,p_val,s_val,money_start_sec,item_start_sec,len0,orderList,len1,xiuShiList,len2,zw_slot,len3,zwDataList,len4,starsList,len5,posList=unpack(args)

LittleWorldModel:initLittleWorldInfo(world_lv,xh_val,p_val,s_val)
LittleWorldModel:setMoneyStartSec(money_start_sec)
LittleWorldModel:setItemStartSec(item_start_sec)

LittleWorldModel:initFaLingInfo(orderList)

LittleWorldModel:setXiuShiInfo(xiuShiList)

LittleWorldModel:initZhenWuSlot(zw_slot)

LittleWorldModel:initZhenWuData(zwDataList,zw_slot)

xingChenBagModel:initEquipData(starsList)

xingChenBagModel:initPos(posList)

LittleWorldModel:dirtyAllDiscipleAttribute()

taskModel:disposeClientCheckTaskTypeEvent(clientCheckTaskTypeEventType.eLittleWorldLvChange)

local bdData=LittleWorldModel:getBuildingData()
if bdData then
buildingCDControl:addCDData(buildingCDType.littleworld,bdData)
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end



function LittleWorldController.recv_37_67(new_lv)
LittleWorldModel:setLittleWorldLevel(new_lv)

LittleWorldModel:dirtyAllDiscipleAttribute()

taskModel:disposeClientCheckTaskTypeEvent(clientCheckTaskTypeEventType.eLittleWorldLvChange)

UIManager:callWindowFunc("UIXJLittleWorldInfoWin","onRecvUp",new_lv)

local lv=cfgHelper.get(cfg_smallworldconfig_get,1,"need_small_lv")
if new_lv==lv then
eventLittleWorldControl:triggerEvent()
end
end

function LittleWorldController.recv_37_68(money_start_sec,item_start_sec,is_assistant)
LittleWorldModel:setMoneyStartSec(money_start_sec)
LittleWorldModel:setItemStartSec(item_start_sec)

local bdData=LittleWorldModel:getBuildingData()
if bdData then
buildingCDControl:addCDData(buildingCDType.littleworld,bdData)
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
UIManager:callWindowFunc("UIXJLittleWorldInfoWin","onRecvReward")

end


function LittleWorldController.recv_37_69(p_val,xh_val,len,xiuShiList)
LittleWorldModel:setLittleWorldPopulation(p_val)
LittleWorldModel:setLittleWorldInfo(eLittleWorldDataKey.xh_val,xh_val)

LittleWorldModel:setXiuShiInfo(xiuShiList)

UIManager:callWindowFunc("UIXJLittleWorldInfoWin","refreshPeoplePanel")
UIManager:callWindowFunc("UIXJLittleWorldFaLingWin","refreshMoney")

end


function LittleWorldController.recv_37_70(order_id,start_sec)
LittleWorldModel:setFaLingInfo(order_id,start_sec)
UIManager:callWindowFunc("UIXJLittleWorldInfoWin","refreshAddOrderPanel")
UIManager:callWindowFunc("UIXJLittleWorldFaLingWin","onListFresh")
end

function LittleWorldController.recv_37_71(push_type,push_value)
if push_type==1 then
local old=LittleWorldModel:getLittleWorldStability()
if old then
UIManager.info(FMT.fmt("稳定度 {0}{1}",old>push_value and''or'+',push_value-old))
end
LittleWorldModel:setLittleWorldInfo(eLittleWorldDataKey.s_val,push_value)
end
UIManager:callWindowFunc("UIXJLittleWorldInfoWin","onRecvPeople")
end

function LittleWorldController.recv_37_73(block_id,town_id)
LittleWorldModel:setZhenWuSlot(block_id,town_id)
UIManager:callWindowFunc("UIXJLittleWorldZhenWuBagWin","refreshBagListPanel")
UIManager:callWindowFunc("UIXJLittleWorldZhenWuWin","recvEquiped")
UIManager:callWindowFunc("UIPlanent","refreshSlot",block_id)
notifySystem:postNotify(notifyConfig.onZWEquipChange)
UIManager.info("镇物已更换")
end

function LittleWorldController.recv_37_74(town_id,star)
LittleWorldModel:setZhenWuStar(town_id,star)
UIManager:callWindowFunc("UIXJLittleWorldZhenWuBagWin","recvEquip")
UIManager:callWindowFunc("UIXJLittleWorldZhenWuWin","refreshRight")
notifySystem:postNotify(notifyConfig.onZWEquipChange)
end

function LittleWorldController.recv_37_75()

end

function LittleWorldController.recv_37_76(town_id)
UIManager.info("镇物激活成功")
LittleWorldModel:setZhenWuStar(town_id,0)

UIManager:callWindowFunc("UIXJLittleWorldInfoWin","refreshZhenWuBtn")
UIManager:callWindowFunc("UIXJLittleWorldZhenWuWin","refreshLeft")

UIManager:callWindowFunc("UIXJLittleWorldZhenWuBagWin","checkEquip",town_id)
end


