

UIShopControl=gameState.addListener(fullScreenUI.create())

local _fightLog
local _this=UIShopControl
function UIShopControl:onAppStart()
socketManager:register_receiver(9,1,self.recv_9_1)
socketManager:register_receiver(9,2,self.recv_9_2)
socketManager:register_receiver(9,3,self.recv_9_3)
socketManager:register_receiver(9,4,self.recv_9_4)
socketManager:register_receiver(9,5,self.recv_9_5)
socketManager:register_receiver(9,6,self.recv_9_6)
socketManager:register_receiver(9,7,self.recv_9_7)

socketManager:register_receiver(9,9,self.recv_9_9)
socketManager:register_receiver(9,10,self.recv_9_10)
socketManager:register_receiver(9,11,self.recv_9_11)
socketManager:register_receiver(9,13,self.recv_9_13)
socketManager:register_receiver(9,14,self.recv_9_14)
socketManager:register_receiver(9,15,self.recv_9_15)
socketManager:register_receiver(9,16,self.recv_9_16)
socketManager:register_receiver(9,17,self.recv_9_17)
socketManager:register_receiver(9,18,self.recv_9_18)
socketManager:register_receiver(9,20,self.recv_9_20)
UIShopModel:onAppStart()
local menulist=
{
{tabType=FULL_TAB_TYPE.eShop,callback=function(...)self:showShopWindow(...)end,
sendCallback=function()end,},
{tabType=FULL_TAB_TYPE.eShopProduction,callback=function(...)self:showShopProductionWindow(...)end,
reddotType=REDDIT_SUB_TYPE.sShopCreate,checkOpen=function(...)return self:checkCreateSys()end,},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eShangPu,
skinType=fullScreenSkinType.eSkin21,
attachName={'entityId'}
}
self:initUI(args)

end

function UIShopControl:onEnterState(isReconnect)
if isReconnect then
return
end
UIShopModel:onEnterState()


self.simulateBuyerList={}
self.reddotFlagList={}
self.randomDzIdIndexList={}
self.reqTimeList={}
self.shopDzList={}
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onDiscipleNewID,self.onDiscipleNewID)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end

function UIShopControl:onLeaveState(isReconnect)
if isReconnect then
return
end
UIShopModel:onLeaveState()
self.rcReward=nil
_fightLog=nil
self.simulateBuyerList=nil
self.reddotFlagList=nil
self.randomDzIdIndexList=nil
self.reqTimeList=nil
self.shopDzList=nil
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.onDiscipleNewID,self.onDiscipleNewID)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
end

function UIShopControl:onProtocolReq(isReconnet)
_this.protocolFinishFlag=true
_this.setDataEx()
end

function UIShopControl:onLostConnection()
_this.protocolFinishFlag=false
local datas=UIShopModel:getAllShopData()
for k,v in pairs(datas)do
local list=_this.randomDzIdIndexList[v.un_build_id]
if list and list[2]then
aiManager:endBuyerAI(list[2])
end
end
_this.randomDzIdIndexList={}
end

function UIShopControl:addSimulateBuyerBT(data)
local bt=behaviorManager:addBehaviorTree('ai_dz_buyer_simulation',nil,true,data)
self.simulateBuyerList[tostring(data.dzId)]=bt
end

function UIShopControl:removeSimulateBuyerBT(bt)
local dzId=bt:getSharedVar('dzId')
self.simulateBuyerList[tostring(dzId)]=nil
behaviorManager:removeBehaviorTree(bt)
end

function UIShopControl:getSimulateBuyerBT(dzId)
return self.simulateBuyerList[tostring(dzId)]
end

function UIShopControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
UIShopControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
UIShopControl:onLeaveHome()
end
end

function UIShopControl:refreshShopSlot(data)
if isometricMapSystem:isInGroundModel()then
return
end

if isometricMapSystem:getDesignMode()then
return
end

if data.sellItemList then

local bdData=zongmenModel:getBuildingData(data.un_build_id)

local ftype=zongmenModel:getBDFlagType(bdData.flag)
if ftype~=bdFlagType.normal then

return
end

local cfg=cfgHelper.get2(cfg_shangpulevelconfig_get,bdData.build_id,bdData.level)











for i,v in ipairs(data.sellItemList)do
if v>0 then
local slot=cfg.slots[i]
if not slot then
logErr('商铺商品超出配置范围',i,v)
slot=cfg.slots[1]
end
isometricMapSystem:changeSlot(bdData.entityId,string.format('cai%d',i),slot)
else
isometricMapSystem:changeSlot(bdData.entityId,string.format('cai%d',i),-1)
end
end
end
end

function UIShopControl:hideSlotByIndex(bdId,index)
if index>0 then

local bdData=zongmenModel:getBuildingData(bdId)
isometricMapSystem:changeSlot(bdData.entityId,FMT.fmt('cai{0}',index),-1)
end
end

function UIShopControl:onEnterHome()

self.is_in_home=true

local datas=UIShopModel:getAllShopData()
for k,v in pairs(datas)do
self:refreshShopSlot(v)

v.clientNum=UIShopControl:getCurReward(v)
end
timeEventController.addNormalTimerHandler(3,'UIShopControl',self)
end

function UIShopControl:onLeaveHome()
timeEventController.removeNormalTimerHandler(3,'UIShopControl')

self.is_in_home=false
end

function UIShopControl:isInHome()
return self.is_in_home
end

function UIShopControl:onNormalUpdate(delay)















if not self.protocolFinishFlag then
return
end
local curTime=timeHelper.getServerShortTime()
local datas=UIShopModel:getAllShopData()
local ubdId
local bdData
local reddotFlag
local startTime
local finishInterval
local needFinishCount
local curFinishCount
local diziLen
local dzId
local recvState
local FlagList
for k,v in pairs(datas)do
ubdId=k

bdData=zongmenModel:getBuildingData(ubdId)
reddotFlag=UIShopControl:checkReddot(bdData)
recvState=UIShopControl:checkRcvState(bdData)
FlagList=self.reddotFlagList[ubdId]or{}
if FlagList[1]~=reddotFlag or FlagList[2]~=recvState then
FlagList[1]=reddotFlag
FlagList[2]=recvState
self.reddotFlagList[ubdId]=FlagList
hudControl:refreshBuildingStatusHUD(ubdId)
end


diziLen=v.dizi_len

if diziLen and diziLen>0 then


startTime=v.rewardInfo.param_1
finishInterval=v.rewardInfo.param_2
needFinishCount=v.rewardInfo.param_3
curFinishCount=math.floor((curTime-startTime)/finishInterval)
if curFinishCount~=0 and curFinishCount<=needFinishCount and curTime==(startTime+curFinishCount*finishInterval)then

dzId=self:getRandomDzId(ubdId)
if dzId then

aiManager:beginBuyerAI(dzId,2,bdData.build_id,ubdId)
end
end
if curFinishCount>=needFinishCount then

self:reqShopAutoReward(ubdId,false)
end

else

self:reqShopAutoReward(ubdId,false)
end


end
end


function UIShopControl:getRandomDzId(ubdId)

if self.randomDzIdIndexList and self.randomDzIdIndexList[ubdId]and self.randomDzIdIndexList[ubdId][2]then
return
end

if deviceHelper.isRunWeiXin()or deviceHelper.isRunEditor()then
local wxDZLen=cfgHelper.get(cfg_shangpubasicconfig_get,1,"wxDZLen")
local count=0
for k,v in pairs(self.randomDzIdIndexList or{})do
if v and v[2]then
count=count+1
end
end
if count>=wxDZLen then
return
end
end

local data=UIShopModel:getShopData(ubdId)
local diziLen=data.dizi_len
if diziLen and diziLen<=0 then
loggerUtil.logErrFMT("商铺没有随机子弟列表却来获取 ubdId = {0}",ubdId)
return
end
local diziList=data.diziList or{}
local list=self.randomDzIdIndexList[ubdId]or{}
local index=list[1]or 1
index=index+1>diziLen and 1 or index+1
list[1]=index
for i=index,diziLen do
local dzId=diziList[i]
if dzId and discipleStateManager:enableCreateRole(dzId)then
list[1]=i
list[2]=dzId
self.randomDzIdIndexList[ubdId]=list
return dzId
end
end
return
end


function UIShopControl:reqShopAutoReward(ubdId,skipReqInterval)
local data=UIShopModel:getShopData(ubdId)
if not data then
return
end




local limitDatas=zongmenModel:getWarehouseAllLimitDict()
local num=1
local reqInterval=60
local bdData=zongmenModel:getBuildingData(ubdId)





local shopDzflag=self.shopDzList[ubdId]or{}

if shopDzflag[1]~=bdData.dizi_id then
shopDzflag[1]=bdData.dizi_id
if tostring(bdData.dizi_id)=='0'then
shopDzflag[2]=false
else
shopDzflag[2]=true
end
end
self.shopDzList[ubdId]=shopDzflag
if not shopDzflag[2]then
return
end
if not self:isCanProduce(data,limitDatas,num)then

return
end
if self:checkRewardMax(data)then

return
end
local curTime=timeHelper.getServerShortTime()
if not skipReqInterval then
local lastReqTime=self.reqTimeList[ubdId]or 0
if(curTime-lastReqTime)<reqInterval then
return
end
end
self.reqTimeList[ubdId]=curTime
socketManager:send_9_21(ubdId)
end

function UIShopControl:checkRewardMax(data)


local curNum=UIShopControl:getClientCurReward(data)
local bdData=zongmenModel:getBuildingData(data.un_build_id)
local maxNum=UIShopControl:getRewardMax(bdData)
return curNum>=maxNum
end


function UIShopControl:getCurReward(data,isPrint)
local curTime=timeHelper.getServerShortTime()
local diziLen=data.dizi_len
local curNum=0
local bdData=zongmenModel:getBuildingData(data.un_build_id)
if diziLen and diziLen>0 then
local startTime=data.rewardInfo.param_1
local finishInterval=data.rewardInfo.param_2
local needFinishCount=data.rewardInfo.param_3
local rate=1+data.rewardInfo.param_4*0.01

local curFinishCount=math.floor((curTime-startTime)/finishInterval)
curFinishCount=curFinishCount>needFinishCount and needFinishCount or curFinishCount
curFinishCount=isPrint and needFinishCount or curFinishCount
local cfg=cfgHelper.get2(cfg_shangpulevelconfig_get,bdData.build_id,bdData.level)
local price=cfg.item_create_conf[data.create_item_idx].price


local singleprice=0
for i,v in ipairs(price)do
singleprice=singleprice+math.floor(v[2]*rate)
end
curNum=curNum+singleprice*curFinishCount
end
for i,v in ipairs(data.getRewardList or{})do
curNum=curNum+v.param_2
end
return curNum
end


function UIShopControl:getClientCurReward(data)
return data.clientNum
end


function UIShopControl:getRewardMax(bdData)
local cfg=cfgHelper.get2(cfg_shangpulevelconfig_get,bdData.build_id,bdData.level)
local max_rewards_limit=cfgHelper.get(cfg_shangpubasicconfig_get,1,"max_rewards_limit")
return max_rewards_limit[bdData.level][2]
end

function UIShopControl:checkRcvState(bdData)
local ubdId=bdData.un_build_id
local data=UIShopModel:getShopData(ubdId)
if not data then
return false,3
end
local curCount=self:getClientCurReward(data)
if curCount<=0 then
return false,1
end
local get_rewards_cd=cfgHelper.get(cfg_shangpubasicconfig_get,1,"get_rewards_cd")
local lastrecvtime=data.last_getautorewards_times or 0
local curTime=timeHelper.getServerShortTime()
if(curTime-lastrecvtime)<get_rewards_cd then
return false,2
end
return true
end



function UIShopControl:reqAutoCreateRecv(ubdId)
if ubdId==0 then
if UIManager:isActive("UIShopWin")or UIManager:isActive("UIFastManagerWin")then
socketManager:send_9_20(ubdId)
else
local datas=UIShopModel:getAllShopData()
for un_build_id,v in pairs(datas)do
socketManager:send_9_20(un_build_id)
end
end
else
socketManager:send_9_20(ubdId)
end
end

function UIShopControl:reqReplenMent(ubdId)
local data=UIShopModel:getShopData(ubdId)
self:refreshShopSlot(data)
self:reqShopData(ubdId)
end

function UIShopControl:getReplenMentCD(bt,ubdId,okey)
local currTime=timeHelper.getServerShortTime()
local data=UIShopModel:getShopData(ubdId)
local cd=data.supplement_times-currTime
bt:setSharedVar(okey,cd)
end

function UIShopControl:isCanReplenMent(bt,ubdId,okey)
local data=UIShopModel:getShopData(ubdId)
local limitDatas=zongmenModel:getWarehouseAllLimitDict()
local check=not UIShopModel:isShopItemFull(data.un_build_id)and self:isCanProduce(data,limitDatas)
bt:setSharedVar(okey,check)
end

function UIShopControl:isCanProduce(data,limitDatas,num)

local bdData=zongmenModel:getBuildingData(data.un_build_id)
local cfg=cfgHelper.get2(cfg_shangpulevelconfig_get,bdData.build_id,bdData.level)
local cost=cfg.item_create_conf[data.create_item_idx].cost_item
local num=num or 1
for i,v in ipairs(cost)do
local key=v[1]
local have=moneyModel.getMoney(key)
local consumeRate=UIShopModel:getConsumeRate(key)
if not consumeRate then
return false
end
local rate=consumeRate*0.01
if have<v[2]*num or have<limitDatas[key]*rate then
return false
end
end
return true
end

function UIShopControl:init(tabType)
local menulist=
{
{tabType=tabType,callback=function(...)self:showShopWindow(...)end},
{tabType=FULL_TAB_TYPE.eShopProduction,callback=function(...)self:showShopProductionWindow(...)end,},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eShangPu,
skinType=fullScreenSkinType.eSkin21,
attachName={'entityId'}
}
self:initUI(args)
end

function UIShopControl:showShopWindow(argstable)
local id=argstable.build_id
if not id and argstable.entityId then
local bdData=zongmenModel:findBuildingByEntityId(argstable.entityId)
id=bdData.build_id
argstable=bdData
end

local cfg=cfgHelper.get1(cfg_shangpuconfig_get,id)
local tabType=FULL_TAB_TYPE[cfg.page_type]

local viewName='UIShopWin'
local args=
{
tabType=FULL_TAB_TYPE.eShop,
showBg=true,
subFullType=fullScreenUI.getSubFullType(viewName,id),
viewNames={viewName},
viewArgs={[viewName]=argstable},
moneyArgs=fullScreenModel.getFullTabMoneyByConfig(tabType)
}
self:initReddotConfig(args)
self:showUI(args)
end

function UIShopControl:showShopProductionWindow(argstable)

local id=argstable.build_id
if not id and argstable.entityId then
local bdData=zongmenModel:findBuildingByEntityId(argstable.entityId)
id=bdData.build_id
argstable=bdData
end

local cfg=cfgHelper.get1(cfg_shangpuconfig_get,id)
local tabType=FULL_TAB_TYPE[cfg.page_type]

local viewName='UIShopProductionWin'
local args=
{
tabType=FULL_TAB_TYPE.eShopProduction,
showBg=true,
subFullType=fullScreenUI.getSubFullType(viewName,id),
viewNames={viewName},
viewArgs={[viewName]=argstable},
moneyArgs=fullScreenModel.getFullTabMoneyByConfig(tabType)
}
self:initReddotConfig(args)
self:showUI(args)
end




function UIShopControl:reqDatas()
socketManager:send_9_1()
end

function UIShopControl:reqShopData(bdId)
socketManager:send_9_2(bdId)
end

function UIShopControl:reqSetConsumeRate(mtype,rate)
socketManager:send_9_3(mtype,rate)
end

function UIShopControl:reqTransformation(bdId,toId)
socketManager:send_9_4(bdId,toId)
end

function UIShopControl:reqReplace(bdId,index)
socketManager:send_9_5(bdId,index)
end

function UIShopControl:reqHandleShopEvent(ubdId,assistant)
socketManager:send_9_7(ubdId,assistant or 0)
end

function UIShopControl:reqExtract()


end

function UIShopControl:reqSelectShop(dzId)

end

function UIShopControl:reqBuy(dzId,ubdId)


local data=UIShopModel:getShopData(ubdId)
if not data then
return
end
local index=data.create_item_idx
local rate=1+data.rewardInfo.param_4*0.01

UIShopControl.recv_9_10(dzId,ubdId,index,nil,nil,rate)
end

function UIShopControl:reqSellCount()
socketManager:send_9_13()
end



function UIShopControl.Req_9_14(ubdId)
socketManager:send_9_14(ubdId)
end




function UIShopControl.Req_9_15(ubdId,idx)
socketManager:send_9_15(ubdId,idx)
end



function UIShopControl.Req_9_16(ubdId,assistant)
socketManager:send_9_16(ubdId,assistant or 0)
end



function UIShopControl.Req_9_17(ubdId)
socketManager:send_9_17(ubdId)
end



function UIShopControl.recv_9_1(datas)
UIShopModel:setDatas(datas,_this.protocolFinishFlag)
if _this.protocolFinishFlag then
if datas[5]>0 then
for i,v in ipairs(datas[6])do
hudControl:refreshBuildingStatusHUD(v.un_build_id)

local list=_this.randomDzIdIndexList[v.un_build_id]
if list and list[2]then
aiManager:endBuyerAI(list[2])
end
end
end
_this.randomDzIdIndexList={}
end
end


function UIShopControl.setDataEx()
local datas=UIShopModel:getAllShopData()
for k,v in pairs(datas)do
v.clientNum=UIShopControl:getCurReward(v)
local list=_this.randomDzIdIndexList[k]
if list and list[2]then
aiManager:endBuyerAI(list[2])
end
end
_this.randomDzIdIndexList={}
end

function UIShopControl.recv_9_2(data)

UIShopModel:setShopData(data)

if UIShopControl:isInHome()then
UIShopControl:refreshShopSlot(data)
end

UIShopModel:setEventState(data.un_build_id,data.event_id>0)
hudControl:refreshBuildingStatusHUD(data.un_build_id)
UIManager:invokeUIMethod('UIShopWin','refreshEventTips')
UIManager:invokeUIMethod("UIShopWin","refresProbar")

if UIManager:findActiveWindow('UIFastManagerWin')then
buildingCDControl:updateCDData(buildingCDType.shangpu,data.un_build_id)
UIManager:callWindowFunc("UIFastManagerWin","refreshComplete")
local rewards=UIShopControl:getRecordReward()or{}
local len=#rewards
UIShopControl:setRecordReward(nil)
if len>0 then
UIManager:invokeUIMethod('UIFastManagerWin','addShangPuRewards',data.un_build_id,rewards)
end
local sfId=zongmenModel:getMountainId()
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.shangpuComplete,sfId,data.un_build_id)
end
end

function UIShopControl.recv_9_3(mtype,rate)
UIShopModel:setConsumeRate(mtype,rate)

end

function UIShopControl.recv_9_4(bdId,toId)

local sfId=1
local bdData=zongmenModel:getBuildingData(bdId)
isometricMapSystem:changeModelById(sfId,bdId)
hudControl:changeTarget(sfId,bdId)
if not UIShopModel:getTransUnShopID()then
UIManager:showWindow('UIShopWin',bdData)
UIShopControl:showShopWindow(bdData)
end
UIManager.info('商铺转型成功')
local oldbuid=UIShopModel:getTransShopID()
if oldbuid then
zongmenModel:deleteBuildIdData(sfId,bdData,oldbuid)
UIShopModel:setTransShopID(nil)
end
zongmenModel:addBuildIdData(sfId,bdData,toId)
end

function UIShopControl.recv_9_5(bdId,index)
UIShopModel:replaceCommodity(bdId,index)
UIManager:invokeUIMethod('UIShopWin','refreshRightPanel')
UIManager.info('更换商品成功')
end

function UIShopControl.recv_9_6(ubdId)

UIShopModel:setEventState(ubdId,true)
hudControl:refreshBuildingStatusHUD(ubdId)
UIManager:invokeUIMethod('UIShopWin','refreshEventTips')
end

function UIShopControl.recv_9_7(args)
local ubdId=args[1]
local eventId=args[2]
local plen=args[3]
local paramArr=args[4]
local xinqing=args[5]
local assistant=args[6]

UIShopModel:setMoodValue(xinqing)

UIShopModel:setEventState(ubdId,false)
hudControl:refreshBuildingStatusHUD(ubdId)

if assistant~=1 then
local args={ubdId,eventId,plen,paramArr}






UIManager:showWindow('UIShopEventWin',args)
end
UIManager:invokeUIMethod('UIShopWin','refresEventInfo')

notifySystem:postNotify(notifyConfig.onShowShopEventPrize,args)
end

function UIShopControl.recv_9_8(next,len,arr)










end

function UIShopControl.recv_9_9(len,datas)













end

function UIShopControl.recv_9_10(dzId,ubdId,index,flag,xinqing,rate)
if xinqing then
UIShopModel:setMoodValue(xinqing)
end
local sfId=mapIdType.zhufeng
local bdData=zongmenModel:getBuildingData(ubdId)
local inhome=UIShopControl:isInHome()
if inhome then
local bt=aiManager:getDiscipleCurrentCMDBT(dzId)
if bt and bt:getSharedVar('cmdType')==eAIType.eBuyer then
if index>0 then
bt:setSharedVar('buyer',3)
discipleStateManager:checkNeedRemove(dzId)
elseif index==0 then

bt:setSharedVar('buyer',4)
discipleStateManager:checkNeedRemove(dzId)
else

bt:setSharedVar('buyer',5)
end
bt:reset()
end
else
local bt=UIShopControl:getSimulateBuyerBT(dzId)
if bt then
if index>0 then
bt:setSharedVar('buyer',3)
elseif index==0 then

bt:setSharedVar('buyer',4)
else

bt:setSharedVar('buyer',5)
end
bt:reset()
end
end

if not inhome then
return
end

UIShopControl:hideSlotByIndex(ubdId,index)

UIManager:invokeUIMethod('UIShopWin','refresEventInfo')

if index>0 then
eventProductControl:onBuySuccess(dzId,sfId,ubdId)
local cfg=cfgHelper.get2(cfg_shangpulevelconfig_get,bdData.build_id,bdData.level)
local sdata=UIShopModel:getShopData(ubdId)
local sv=sdata.sellItemList[index]

local price=cfg.item_create_conf[index].price







local rate=rate or UIShopModel:getShopBenefitRate(bdData)
for i,v in ipairs(price)do
hudControl:showRewardTips(bdData.entityId,v[1],math.floor(v[2]*rate))
sdata.clientNum=sdata.clientNum+math.floor(v[2]*rate)
end
local list=_this.randomDzIdIndexList[ubdId]
if list and list[2]then
list[2]=nil
end
UIManager:invokeUIMethod("UIShopWin","refresProbar")
hudControl:refreshBuildingStatusHUD(ubdId)

end
end

function UIShopControl.recv_9_11(result,fightLog)
_fightLog=fightLog
end

function UIShopControl.recv_9_13(datas)


UIManager:showWindow('UIShopSellCount',datas)
end









function UIShopControl.recv_9_14(ubdId,len,createList)







UIShopModel:setCreateList(ubdId,createList)
UIManager:invokeUIMethod("UIShopProductionWin","refreshRightPanel")
end





function UIShopControl.recv_9_15(ubdId,idx,begin_times)





UIShopModel:addCreateData(ubdId,{param_1=idx,param_2=begin_times})
UIManager:invokeUIMethod("UIShopProductionWin","refreshQueueItemList")
UIManager:invokeUIMethod("UIShopProductionWin","refreshCostItemList")
UIManager:invokeUIMethod("UIShopProductionWin","refreshCancelProduceBtn")
UIManager.info("开始生产")
UIManager:invokeUIMethod("UIShopProductionWin","refreshRightPanel")
end

function UIShopControl.recv_9_16(ubdId,assistant)
UIManager:invokeUIMethod("UIShopProductionWin","refreshAnim")
if ubdId~=0 then
UIShopModel:refreshCreateData(ubdId)
UIManager:invokeUIMethod("UIShopHuoCangWin","refresh")
hudControl:refreshBuildingStatusHUD(ubdId)
if UIManager:findActiveWindow('UIFastManagerWin')then
buildingCDControl:updateCDData(buildingCDType.shangpu,ubdId)
UIManager:callWindowFunc("UIFastManagerWin","refreshComplete")
local rewards=UIShopControl:getRecordReward()or{}
local len=#rewards
UIShopControl:setRecordReward(nil)
if len>0 then
UIManager:invokeUIMethod('UIFastManagerWin','addShangPuRewards',ubdId,rewards)
end
local sfId=zongmenModel:getMountainId()
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.shangpuComplete,sfId,ubdId)
end
else
if assistant~=1 then
if not(UIManager:isActive("UIShopWin")or UIManager:isActive("UIShopProductionWin")or UIManager:isActive('UIFastManagerWin'))then
local rewards=UIShopControl:getRecordReward()or{}
local len=#rewards
if len>0 then
showPrizeControl.showWindow(rewards)
end
end
end
end
reddotControl.on_change_catch_type(CATCH_TYPE.eShopCreate)
UIManager:invokeUIMethod("UIShopProductionWin","delayRefresh")
UIManager:invokeUIMethod("UIShopProductionWin","refreshRightPanel")
end


function UIShopControl.recv_9_17(ubdId)
UIManager:invokeUIMethod("UIShopProductionWin","refreshAnim")
UIShopModel:setCreateList(ubdId,{})
reddotControl.on_change_catch_type(CATCH_TYPE.eShopCreate)
hudControl:refreshBuildingStatusHUD(ubdId)
UIManager:invokeUIMethod("UIShopProductionWin","delayRefresh")
UIManager:invokeUIMethod("UIShopProductionWin","refreshCostItemList")
UIManager:invokeUIMethod("UIShopProductionWin","refreshRightPanel")
end

function UIShopControl.recv_9_18(un_build_id,itemId,cnt)

end

function UIShopControl.recv_9_20(ubdId,len,rewardList)
if ubdId~=0 and len>0 then
if not(UIManager:isActive("UIShopWin")or UIManager:isActive("UIFastManagerWin"))then
local sfId=zongmenModel:getBuildingLocationMapId(ubdId)or mapIdType.zhufeng
local rwlist={}
for i,v in ipairs(rewardList)do
table.insert(rwlist,{v.param_1,v.param_2})
end
zongmenControl:showPlanReward(sfId,ubdId,rwlist)
end
end
end


















function UIShopControl:getSellArgsInShop(ubdId)
local bdData=zongmenModel:getBuildingData(ubdId)
local id=bdData.build_id
local level=bdData.level
local cfg=cfgHelper.get2(cfg_shangpulevelconfig_get,id,level)
local shopData=UIShopModel:getShopData(bdData.un_build_id)
local data=cfg.item_create_conf[shopData.create_item_idx]
return{id,data.shop_item.name}
end

function UIShopControl:handleEvent(bdData)
if tostring(bdData.dizi_id)~='0'then
UIShopControl:reqHandleShopEvent(bdData.un_build_id)
else
UIManager.error('尚未安排执事弟子')
end
end

function UIShopControl:simulateSelectShop(bt,bdId,okey,ignore)
local ignoreStates={DISCIPLE_STATE_TYPE.eChuiWei,DISCIPLE_STATE_TYPE.edsDispatch}
local datas=zongmenModel:getBuildingDataByBdIdEx(1,bdId,ignore,ignoreStates)
local bdData=datas[math.random(1,#datas)]
if not bdData then
bt:setSharedVar('found',false)
return
end
bt:setSharedVar('found',true)
bt:setSharedVar(okey,bdData.un_build_id)
end


function UIShopControl:checkCreating(bdData)
if not self:checkCreateSys()then
return false
end
local bdId=bdData.build_id
if not UIShopModel:isShop(bdId)then
return false
end
local ubdId=bdData.un_build_id
local level=bdData.level
local createList=UIShopModel:getCreateList(ubdId)
local isCreating=false
local productionItemTimeList=UIShopModel:getProductionItemTimeList(bdId,level)
local curTime=timeHelper.getServerShortTime()
for i,v in ipairs(createList)do
local finish_times=v.param_2+productionItemTimeList[v.param_1]
if(finish_times-curTime)>0 then
isCreating=true
break
end
end
return isCreating
end



function UIShopControl:getShopCreateState(bdData)
local bdId=bdData.build_id
if not UIShopModel:isShop(bdId)then
return SHOP_CREATE_TYPE.eNone
end
if not self:checkCreateSys()then
local data=UIShopModel:getShopData(bdData.un_build_id)
if not data then
return SHOP_CREATE_TYPE.eNone
end
if not self:checkRewardMax(data)then
return SHOP_CREATE_TYPE.eNone
end
local get_rewards_cd=cfgHelper.get(cfg_shangpubasicconfig_get,1,"get_rewards_cd")
local lastrecvtime=data.last_getautorewards_times or 0
local curTime=timeHelper.getServerShortTime()
if(curTime-lastrecvtime)<get_rewards_cd then
return SHOP_CREATE_TYPE.eNone
end
return SHOP_CREATE_TYPE.eAutoFinish
end
local bdId=bdData.build_id
local ubdId=bdData.un_build_id
local level=bdData.level
local createList=UIShopModel:getCreateList(ubdId)
local state=SHOP_CREATE_TYPE.eNull
local productionItemTimeList=UIShopModel:getProductionItemTimeList(bdId,level)
local curTime=timeHelper.getServerShortTime()
local sumTime=nil
local isCteateing=false
local starttime=nil
local finish_times
for i,v in ipairs(createList)do
state=SHOP_CREATE_TYPE.eFinish
finish_times=v.param_2+productionItemTimeList[v.param_1]
if not starttime then
starttime=v.param_2
sumTime=starttime
end
sumTime=sumTime+productionItemTimeList[v.param_1]
if(finish_times-curTime)>0 then
isCteateing=true
end
end
state=isCteateing and SHOP_CREATE_TYPE.eCreating or state

if state==SHOP_CREATE_TYPE.eNull then
local data=UIShopModel:getShopData(bdData.un_build_id)
if not data then
return SHOP_CREATE_TYPE.eNone
end
local get_rewards_cd=cfgHelper.get(cfg_shangpubasicconfig_get,1,"get_rewards_cd")
local lastrecvtime=data.last_getautorewards_times or 0
if self:checkRewardMax(data)and(curTime-lastrecvtime)>=get_rewards_cd then
return SHOP_CREATE_TYPE.eAutoFinish
end
end
return state,sumTime,starttime,curTime
end

function UIShopControl:checkReddot(bdData)
if not self:checkCreateSys()then
return false
end
if not bdData then
return false
end
local bdId=bdData.build_id
local ubdId=bdData.un_build_id
local level=bdData.level
local createList=UIShopModel:getCreateList(ubdId)
local hasfinish=false
local productionItemTimeList=UIShopModel:getProductionItemTimeList(bdId,level)
local curTime=timeHelper.getServerShortTime()
for i,v in ipairs(createList)do
local finish_times=v.param_2+productionItemTimeList[v.param_1]
if(finish_times-curTime)<=0 then
hasfinish=true
break
end
end
return hasfinish
end

function UIShopControl:initReddotConfig(args)
local attach=self:tryGetAttachArgs(args)
local entityId=attach.entityId
local sfId=zongmenModel:getMountainId()
local bdData=zongmenModel:findBuildingByEntityId(entityId)
local ubdId=bdData.un_build_id
local key=shopProductionSheetReddot.addConfig(ubdId)
self:reviseSubMenuValue(FULL_TAB_TYPE.eShopProduction,'reddotType',key)
end

function UIShopControl:checkCreateSys()
return systemModel.isOpen(SYSTEM_DEFINE.eShopCreate)
end

function UIShopControl.on_building_event(etype,sfId,ubdId,arg1,arg2)
if etype==buildingEvent.replaceDisciple then
local bdData=zongmenModel:getBuildingData(ubdId)
local bdId=bdData.build_id
if not UIShopModel:isShop(bdId)then
return false
end
_this:reqShopAutoReward(ubdId,true)
end
end


function UIShopControl.onDiscipleNewID(disguid,dzid)
local datas=UIShopModel:getAllShopData()
for k,v in pairs(datas)do
local diziLen=v.dizi_len
if diziLen and diziLen==0 then
_this:reqShopAutoReward(k,true)
end
end
end


function UIShopControl.onShowPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eShopCreate then
UIShopControl:setRecordReward(prizelist)
if(UIManager:isActive("UIShopWin")or UIManager:isActive("UIShopProductionWin"))and not UIManager:findActiveWindow('UIFastManagerWin')then
local tipsid=effectData.tipsid
table.sort(prizelist,function(a,b)
return a.sortWeight>b.sortWeight
end)
local tips=showPrizeControl.getTips(tipsid)
local callback=function()
local bdId=UIShopModel:getTransUnShopID()
if not bdId then
return
end
local bdData=zongmenModel:getBuildingData(bdId)
if not bdData then
return
end
UIManager:showWindow('UIShopWin',bdData)
UIShopControl:showShopWindow(bdData)
UIShopModel:setTransUnShopID(nil)
end
showPrizeControl.showWindow(prizelist,callback,{tips=tips})
end
end
end

function UIShopControl:setRecordReward(prizelist)
self.rcReward=prizelist
end

function UIShopControl:getRecordReward()
return self.rcReward
end

function UIShopControl:removeShopBuyer(id,bdId)
local list=_this.randomDzIdIndexList[id]
if list and list[2]then
aiManager:endBuyerAI(list[2])
list[2]=nil
end
end


function UIShopControl:checkCreatingEx(bdData)
if not self:checkCreateSys()then
return false
end
local bdId=bdData.build_id
if not UIShopModel:isShop(bdId)then
return false
end
local ubdId=bdData.un_build_id
local createList=UIShopModel:getCreateList(ubdId)
return#createList>0
end


function UIShopControl:checkCreatingFinish(bdData)
if self:checkCreating(bdData)then
return false
end
local ubdId=bdData.un_build_id
local createList=UIShopModel:getCreateList(ubdId)
return#createList>0
end

function UIShopControl:jumpToRechangeShop(build_id)
local datas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,24)
local len=#datas
local max

for i=1,len do
local data=datas[i]
local sdata=UIShopModel:getShopData(data.un_build_id)

if not max then
if not sdata.is_in_event then
max=i
end
else
local maxData=datas[max]
if data.level>maxData.level and not sdata.is_in_event then
max=i
end
end
end

if max then
local index
local bddata=datas[max]
local list=UIShopControl:GetBuildingConfigs(bddata.build_id)
for k,v in ipairs(list)do
if v.id==build_id then
index=k-1
end
end

if index then
isometricMapSystem:openBuildingWin(bddata)
UIManager:showWindow('UIShopSelectWin',{bddata,index})
end
else
UIManager.error('当前没有可以转型的店铺')
end
end

function UIShopControl:GetBuildingConfigs(build_id)
local cfgs=cfg_monijybuildconfig()
local level=zongmenModel:getLevel()
local stype=build_id
local list={}
for k,v in pairs(cfgs)do
if level>=v.show_level and v.build_type==24 then
table.insert(list,v)
end
end
if not self.likeDatas then
self.likeDatas=zongmenControl:countLikeDatas(list)
end
for i,v in ipairs(list)do
if v.id==stype then
table.remove(list,i)
break
end
end
table.sort(list,function(a,b)
local v1=self.likeDatas[a.id]
local v2=self.likeDatas[b.id]
if v1>v2 then
return true
elseif v1==v2 then
return a.id<b.id
else
return false
end
end)
return list
end
