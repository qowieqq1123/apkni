






local _MODULENAME="baoLingShuController"




gameState.addListener(def_table(_MODULENAME))












































function baoLingShuController:onAppStart()
baoLingShuModel:onAppStart()


socketManager:register_receiver(6,12,baoLingShuController.recv_6_12)
socketManager:register_receiver(6,13,baoLingShuController.recv_6_13)
socketManager:register_receiver(6,91,baoLingShuController.recv_6_91)
socketManager:register_receiver(6,92,baoLingShuController.recv_6_92)
socketManager:register_receiver(6,94,baoLingShuController.recv_6_94)

socketManager:register_receiver(6,93,baoLingShuController.recv_6_93)
socketManager:register_receiver(6,101,baoLingShuController.recv_6_101)

end


function baoLingShuController:onEnterState()
baoLingShuModel:onEnterState()
self:clearPickUpStateChangeTimer()
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
end


function baoLingShuController:onServerDataInitFinish()
baoLingShuModel:onServerDataInitFinish()
end


function baoLingShuController:onLeaveState()
baoLingShuModel:onLeaveState()
self:clearPickUpStateChangeTimer()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
end


function baoLingShuController:onLostConnection()
self:clearPickUpStateChangeTimer()
end

function baoLingShuController:onProtocolReq()
local bdData=baoLingShuController:getBuildData()
if bdData then

end
end

function baoLingShuController.onNewDay5am(islogin)

if not islogin then
local bdData=baoLingShuController:getBuildData()
if bdData then
baoLingShuController:req_baolingshu_data(1)
end
end
end

function baoLingShuController:getBuildData()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eBaoLingShu)
return bdDatas[1]
end

function baoLingShuController.on_building_event(etype,sfId,ubdId)
if etype==buildingEvent.buildComplete then
local bdData=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
if cfg.build_type==SLG_SYSTEM_TYPE.eBaoLingShu then
baoLingShuController:req_baolingshu_data(1)
end
end
end


function baoLingShuController:req_baolingshu_data(id)
socketManager:send_6_12(id)
end


function baoLingShuController:req_qifu(id,num,auto,isAssistant,isFree)
local assistantFlag=isAssistant and 1 or 0
local freeFlag=isFree and 1 or 0
socketManager:send_6_13(id,num,auto,assistantFlag,freeFlag)
end


function baoLingShuController:req_getBLSPickUpTargetReward()
socketManager:send_6_91()
end


function baoLingShuController:req_getOrBuyBLSPickUpLiBaoReward(libaoId,buyNum)
socketManager:send_6_92(libaoId,buyNum)
end


function baoLingShuController:req_getBLSPickUpExchangeGB(listIndex,gbIndex,buyCount)
socketManager:send_6_94(listIndex,gbIndex,buyCount)
end


function baoLingShuController:req_getBLSChangePickUpGB(listIndex)
socketManager:send_6_93(listIndex)
end









function baoLingShuController.recv_6_12(array)
baoLingShuModel:initBaoLingShuData(array)
baoLingShuModel:initPickUpTime()
UIManager:callWindowFunc("UIBaoLingShuWin","flushCost")
baoLingShuController:setPickUpStateChangeTimer()

local bdData=baoLingShuController:getBuildData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
pushGiftManager:onChanged(GIFT_CHECK_TYPE.eXuYuanCount)
pushGiftTwoManager:onChanged(GIFT_EX_CHECK_TYPE.eXuYuanCount)
pushGiftThreeManager:onChanged(GIFT_THREE_CHECK_TYPE.eXuYuanCount)

funcShopController.send_23_1(eFuncShopType.eXuYuan)

UIManager:invokeUIMethod("UIBaoLingShuPickUp_ShopWin","updateView")

reddotControl.on_change_catch_type(CATCH_TYPE.eBLSPickUp)

UIManager:invokeUIMethod("UIBaoLingShuWin","refreshPickUpShopBtnReddot")


baoLingShuController:checkShowPickUpTipsWin()
end










function baoLingShuController.recv_6_13(array)
local confId=array[1]
local itemListLen=array[2]
local itemList=array[3]
local bdNum=array[4]
local freeNum=array[5]
local gbfreeNum=array[6]
local todayNum=array[7]
local moneyChouJiangNum=array[8]
local totalGBDrawNum=array[9]
local redBdNum=array[10]
local assistantFlag=array[11]
local data=baoLingShuModel:get_baolingshu_data(confId)
if data then
data[2]=bdNum
data[3]=freeNum
data[4]=gbfreeNum
data[5]=todayNum
data[6]=1
data[7]=moneyChouJiangNum
data[11]=totalGBDrawNum
data[16]=redBdNum
end

if not assistantFlag or assistantFlag==0 then

if itemListLen>0 then
baoLingShuModel:saveRewardsTemp(confId,itemList)
local checkPass=baoLingShuModel:getBLSPassAniState()
if checkPass then
baoLingShuController:showBaoLingShuPrize(confId,itemList)
else
local stageId=baoLingShuController.fightStage.stageID
local behaviorName=baoLingShuModel:getShowBehaviorName()

baoLingShuController.fightStage:runBehavior(stageId+1,behaviorName,function(eventTypo)
if eventTypo==fBTEvent.ActiveSkillActions then
UIManager:invokeUIMethod("UIBaoLingShuMainHUD","showBigReward")
end

UIManager.setMoneyMsgShowState(true,true)
end)
end
else
UIManager.info('空空如也')
end
end

UIManager:callWindowFunc("UIBaoLingShuWin","flushCost")
local bdData=baoLingShuController:getBuildData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
pushGiftManager:onChanged(GIFT_CHECK_TYPE.eXuYuanCount)
pushGiftTwoManager:onChanged(GIFT_EX_CHECK_TYPE.eXuYuanCount)
pushGiftThreeManager:onChanged(GIFT_THREE_CHECK_TYPE.eXuYuanCount)


reddotControl.on_change_catch_type(CATCH_TYPE.eBLSPickUp)

UIManager:invokeUIMethod("UIBaoLingShuWin","refreshPickUpShopBtnReddot")
end


function baoLingShuController.recv_6_91(rewardId,cjTotalGuBaoAct)
baoLingShuModel:setGotTargetRewardMaxId(rewardId,cjTotalGuBaoAct)


local bdData=baoLingShuController:getBuildData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end

UIManager:invokeUIMethod("UIBaoLingShuPickUp_TargetWin","refresh",true)

reddotControl.on_change_catch_type(CATCH_TYPE.eBLSPickUp)

UIManager:invokeUIMethod("UIBaoLingShuWin","refreshPickUpShopBtnReddot")
end


function baoLingShuController.recv_6_92(libaoId,addBuyNum)
local oldBuyNum=baoLingShuModel:getBLSPickUpLiBaoBuyNum(libaoId)or 0
local newBuyNum=oldBuyNum+addBuyNum
baoLingShuModel:setBLSPickUpLiBaoBuyNumByLiBaoId(libaoId,newBuyNum)


local bdData=baoLingShuController:getBuildData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end

UIManager:invokeUIMethod("UIBaoLingShuPickUp_LiBaoWin","refresh",true)

reddotControl.on_change_catch_type(CATCH_TYPE.eBLSPickUp)

UIManager:invokeUIMethod("UIBaoLingShuWin","refreshPickUpShopBtnReddot")
end


function baoLingShuController.recv_6_94(listIndex,gbIndex,exchangeNum)
local showGBListIndex=baoLingShuModel:getPickUpShowGBListIndex()
if showGBListIndex~=listIndex then
return
end
local gbList=baoLingShuModel:getPickUpShowGBList()
local gbItem=gbList[gbIndex]
if not gbItem then
return
end
local gbItemId=gbItem[1]
baoLingShuModel:setBLSPickUpShopExchangeNumByGBItemId(gbItemId,exchangeNum)


local bdData=baoLingShuController:getBuildData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end

UIManager:invokeUIMethod("UIBaoLingShuPickUp_ShopWin","updateView")

reddotControl.on_change_catch_type(CATCH_TYPE.eBLSPickUp)

UIManager:invokeUIMethod("UIBaoLingShuWin","refreshPickUpShopBtnReddot")

end


function baoLingShuController.recv_6_93(listIndex)

baoLingShuModel:clearBLSPickUpShopAllExchangeNum()


baoLingShuModel:setPickUpShowGBListIndex(listIndex)

local bdData=baoLingShuController:getBuildData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end


UIManager:invokeUIMethod("UIBaoLingShuWin","flushPickUpPanel")

UIManager:invokeUIMethod("UIBaoLingShuPickUp_ShopWin","updateView")

reddotControl.on_change_catch_type(CATCH_TYPE.eBLSPickUp)

UIManager:invokeUIMethod("UIBaoLingShuWin","refreshPickUpShopBtnReddot")
end

function baoLingShuController.recv_6_101()

end



function baoLingShuController:showBaoLingShuPrize(confId,itemList)
if confId==nil then
confId,itemList=baoLingShuModel:getRewardsTemp()
end
local conf={}
for i,v in ipairs(itemList)do
local itemid=v.param_1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local weight=color*100
local colorEffect=itemsComponentHelper:checkItemShowColorEffect(itemid)
if colorEffect~=-1 then
weight=weight+colorEffect
end
table.insert(conf,{itemid=itemid,num=v.param_2,color=itemConfig.color,weight=weight})
end
table.sort(conf,function(a,b)return a.weight>b.weight end)
UIFullBaoLingShuControl:showWindow('UIBaoLingShuShowPrizeWin',{conf,confId})

AudioManager.playAudio(407)
end


function baoLingShuController:setPickUpStateChangeTimer()
self:clearPickUpStateChangeTimer()
self.pickUpIsOpen=baoLingShuModel:checkIsInPickUpNow()
local func=function()
local sTime,eTime,nsTime=baoLingShuModel:getGBPickUpTime()
local nowTime=timeHelper.getServerLongTime()
local isChange=false
if self.pickUpIsOpen then

if nowTime>=eTime then
isChange=true
end
else
if(sTime and nowTime>=sTime)or(nsTime and nowTime>=nsTime)then
isChange=true
end
end

if isChange then


baoLingShuModel:initPickUpTime()
if self.pickUpIsOpen then

self.pickUpIsOpen=false
notifySystem:postNotify(notifyConfig.onBaoLingShuPickUpStateChange,false)
else

self.pickUpIsOpen=true
notifySystem:postNotify(notifyConfig.onBaoLingShuPickUpStateChange,true)
end
end
end
self.pickUpStateChangeTimer=timer.new()
self.pickUpStateChangeTimer:start(1,func)
end


function baoLingShuController:clearPickUpStateChangeTimer()
if self.pickUpStateChangeTimer then
self.pickUpStateChangeTimer:cancel()
self.pickUpStateChangeTimer=nil
self.pickUpIsOpen=nil
end
end


function baoLingShuController:checkShowPickUpTipsWin()

if not baoLingShuModel:checkIsInPickUpNow()then
return
end


local configId=baoLingShuModel:getConfId()
local showUpTipsLevel=cfgHelper.get2(cfg_baolingtreeconfig_get,configId,'showUpTipsLevel')
if showUpTipsLevel then
local zmLevel=zongmenModel:getLevel()
if zmLevel<showUpTipsLevel then
return
end
end


local isShowed=false
local sTime,eTime,nsTime=baoLingShuModel:getGBPickUpTime()
local showPickUpStartTime=userActorArraySetting.get(ACTOR_SETTING_TYPE.eBaoLingShu,'showPickUpStartTime',nil)
if showPickUpStartTime and showPickUpStartTime==sTime then
isShowed=true
end
if not isShowed and not newbieControl.isInNewbie()then


msgWinControl:addMsgWin(msgWinType.eBLSPickUpTips)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eBaoLingShu,'showPickUpStartTime',sTime)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eBaoLingShu)
end
end


function baoLingShuController.test_clearShowPickUpTipsFlag()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eBaoLingShu,'showPickUpStartTime',nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eBaoLingShu)
end