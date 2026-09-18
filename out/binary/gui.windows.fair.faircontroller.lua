







fairController=gameState.addListener({})

function fairController:onAppStart()
socketManager:register_receiver(3,116,fairController.recv_3_116)
socketManager:register_receiver(3,117,fairController.recv_3_117)
socketManager:register_receiver(3,118,fairController.recv_3_118)
socketManager:register_receiver(3,119,fairController.recv_3_119)
end

function fairController:onEnterState()
fairModel:init_data()
notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.on_level_change)
end

function fairController:onLeaveState()
fairModel:saveGuiShiCheckTimeMark()
notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)
notifySystem:removelistener(notifyConfig.onZongMengLevelChange,self.on_level_change)
end

function fairController:onPlayerCreate(...)

end

function fairController:onLostConnection()

end

function fairController.on_home_event(etype)
if etype==homeEvent.eEnterHome then
fairController:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
fairController:onLeaveHome()
end
end

function fairController.on_level_change(level,exp)
if level==fairModel.get_black_market_level()then

local nowTime=timeHelper.getServerLongTime()
local data={
checkTime=nowTime,
isOpenWin=false,
}
fairModel:setGuiShiCheckTimeMark(data)

reddotControl.on_change_catch_type(CATCH_TYPE.eFair)
end
end

function fairController:onEnterHome()
timeEventController.addNormalTimerHandler(1,'fairController',fairController)
end

function fairController:onLeaveHome()
timeEventController.removeNormalTimerHandler(1,'fairController')
end

function fairController:onNormalUpdate(delay)
local pass=timeHelper.getServerTodayPass()
local flushTime=fairModel:getFlushTimeList()
for i,v in ipairs(flushTime)do
if pass==v*3600 then
local record=fairModel:getRecordGuiShi()
if not record then
fairModel:setRecordGuiShi(true)
self:refreshBuildHud()
end
local reddot=fairModel:checkGuiShiReddot()
if reddot then
if UIManager:isActive('UIGuiShiWin')then

local data=fairModel:getGuiShiCheckTimeMark()
data.isOpenWin=true
fairModel:setGuiShiCheckTimeMark(data)
end
end

reddotControl.on_change_catch_type(CATCH_TYPE.eFair)
if not reddot then
fairModel:updateGuiShiCheckTimeMark()
end
end
end
if fairModel:getRecordFair()and fairModel:checkBoothReddot()then
fairModel:setRecordGFair()
self:refreshBuildHud()
end
end




function fairController:req_data()
socketManager:send_3_116()
end


function fairController:req_buy(fairType,gridId)
socketManager:send_3_117(fairType,gridId)
end

function fairController:req_buylist(fairType,len,gridlist)
if not len then
len=#gridlist
end
if#gridlist<=0 then
return
end
socketManager:send_3_119(fairType,len,gridlist)
end


function fairController:req_refresh(refreshType)

if not fairModel:GetBeginXiaoZhuShouFlag()then

if guildOrderModel:isOrderSetupOpenEx(GUILD_ORDER_TYPE.eAutoBuy)then
if fairModel:GetReqBuyFlag()then
UIManager.info("刷新冷却中，请稍候")
return
end
fairModel:SetReqBuyFlag(true)
end
end

socketManager:send_3_118(refreshType)
end




function fairController.recv_3_116(argstable)
local lastnum=fairModel:get_free_flush_count()
local isInit=fairModel:isInit()
fairModel:set_data(argstable)

UIManager:invokeUIMethod("UIGuiShiWin","refreshGoods")
local num=fairModel:get_free_flush_count()
if isInit and num~=lastnum and num>lastnum then
chatGGControl.onFangshiFresh()
end
end


function fairController.recv_3_117(fairType,gridId)

AudioManager.playAudio(514)

fairModel:set_goods_data(fairType,gridId,true)
if fairType==eFairType.eBooth then
UIManager:invokeUIMethod("UIFairWin","refreshGoodsUI")
elseif fairType==eFairType.eBlackMarket then
UIManager:invokeUIMethod("UIGuiShiWin","refreshGoods")
elseif fairType==eFairType.eBlackSpeGoods then
UIManager:invokeUIMethod("UIGuiShiWin","refreshGoods")
end

end

function fairController.recv_3_119(fairType,len,gridlist)
if len>0 then
for k,v in ipairs(gridlist)do
fairModel:set_goods_data(fairType,v,true)
end
end
if fairType==eFairType.eBooth then
UIManager:invokeUIMethod("UIFairWin","refreshGoodsUI")
end

if fairModel:GetBeginXiaoZhuShouFlag()and fairType==eFairType.eBooth then
if len>0 then
fairModel:RecordItem(gridlist)
end
if not fairModel:GetBeginNotmoneyFlag()then
fairModel:req_refreshByXiaoZhuShou()
else

fairModel:OverXiaoZhuShou(2)
end
end

end


function fairController.recv_3_118(refreshType,beginTime,totalTime)
fairModel:set_refresh_data(refreshType,beginTime,totalTime)
if not fairModel:checkBoothReddot()then
fairModel:setRecordGFair(true)
fairController:refreshBuildHud()
end

UIManager:invokeUIMethod("UIFairWin","playBoothItemDotween")
if not fairModel:GetBeginXiaoZhuShouFlag()then

guildOrderController:checkAddAI_delay(GUILD_ORDER_TYPE.eAutoBuy,1,true)
else
fairModel:ChangeBeginXiaoZhuShouNum(refreshType)
fairModel:AutoBuyItem()
end

end




function fairController:refreshBuildHud()
local sfId=zongmenModel:getMountainId()
local bdData=zongmenModel:findBuildingDataByType(sfId,SLG_SYSTEM_TYPE.eFangShi)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end