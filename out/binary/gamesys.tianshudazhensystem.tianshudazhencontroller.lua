






local _MODULENAME="tianshudazhenController"

gameState.addListener(def_table(_MODULENAME))
tianshudazhenController.name=_MODULENAME
tianshudazhenController.data={}

function tianshudazhenController:onAppStart()

tianshudazhenModel:onAppStart()


socketManager:register_receiver(6,146,tianshudazhenController.recv_6_146)
socketManager:register_receiver(6,147,tianshudazhenController.recv_6_147)

socketManager:register_receiver(35,26,tianshudazhenController.recv_35_26)

socketManager:register_receiver(6,148,tianshudazhenController.recv_6_148)















notifySystem:listenNotify(notifyConfig.building_event,self.onBuildingEvent)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
notifySystem:listenNotify(notifyConfig.onNewWeek5am,self.onNewWeek5am)
notifySystem:listenNotify(notifyConfig.onTeQuanInfoChange,self.onTeQuanInfoChange)
end


function tianshudazhenController:onEnterState(isReconnect)
tianshudazhenModel:onEnterState()
tianshudazhenAttrsModel:initData()
end


function tianshudazhenController:onProtocolReq()
tianshudazhenModel:onProtocolReq()
tianshudazhenAttrsModel:onProtocolReq()
tianshudazhenController:startRefreshHDZTimer()
tianshudazhenController:refreshHUD()
end


function tianshudazhenController:onLeaveState(isReconnect)
tianshudazhenModel:onLeaveState(isReconnect)
tianshudazhenAttrsModel:initData()
tianshudazhenController:stoptRefreshFYZTimer()
end


function tianshudazhenController:onLostConnection()

end


function tianshudazhenController:onReConnection(isInitPro)

end





function tianshudazhenController.recv_6_146(times)
tianshudazhenModel:initData(times)
end




function tianshudazhenController.recv_6_147(idx,times)
tianshudazhenModel:onTimesResume(idx,times)
UIManager:callWindowFunc('UITianShuDaZhenWin','refreshMiddle')
end

function tianshudazhenController.recv_35_26(argstable)
tianshudazhenModel:onYunZhouSet(argstable)
UIManager:callWindowFunc('UITianShuDaZhenWin','refreshTop')
tianshudazhenController:refreshHUD()
end

function tianshudazhenController.recv_6_148(stamp)
tianshudazhenModel:onFYZStampRefreshSet(stamp)
end



function tianshudazhenController.reqSetTeam(yzid,dzlist,soldierlist,sortOrder)
local priority=sortOrder==eSortOrderEx.eDown and 1 or 2
socketManager:send_35_26(yzid,#dzlist,dzlist,#soldierlist,soldierlist,priority)
end

function tianshudazhenController.reqUseBuff(buffid,times)
local func=function()
socketManager:send_35_22(buffid,times or 1)
end

if tianshudazhenModel:isOpeningTianShuShenDun()then
local desc='已开启天枢神盾大阵，是否继续开启护山大阵？'
UIDialogManager.getConfirmDialog3(nil,desc,func)
else
func()
end
end

function tianshudazhenController.reqReconverHudun(index)
socketManager:send_6_147(index,1)
end

function tianshudazhenController:startRefreshHDZTimer()
if self.fyzTimer then return end
if tianshudazhenModel:getLevel()==0 then return end
if tianshudazhenModel:isMaxHDZ()then return end
self.fyzTimer=timer.new()
local autoResumeInfo=tianshudazhenConfig.getFYZResumeInterval()
local interval=autoResumeInfo[1]

local func=function()
if not tianshudazhenModel:refreshHDZAddVal()then
tianshudazhenController:stoptRefreshFYZTimer()
end
end
self.fyzTimer:start(math.floor(interval/2),function()
func()
end)
end

function tianshudazhenController:stoptRefreshFYZTimer()
if self.fyzTimer then
self.fyzTimer:cancel()
self.fyzTimer=nil
end
end

function tianshudazhenController.onBuildingEvent(etype,sfId,ubdId,arg1,arg2)
local data=tianshudazhenModel:getBuildData()
if data and ubdId==data.un_build_id then
tianshudazhenController:startRefreshHDZTimer()
tianshudazhenAttrsModel:calAttrs()
end
end


function tianshudazhenController.onMoneyChanged(moneyType)
if moneyType==eMoneyType.mtTSDZShield then
tianshudazhenModel:onFYZStampRefreshSet(timeHelper.getServerShortTime())
tianshudazhenController:startRefreshHDZTimer()
end
end

function tianshudazhenController.onNewWeek5am()
tianshudazhenModel:initData(0)
end

function tianshudazhenController:refreshHUD()
local bdData=tianshudazhenModel:getBuildData()
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end

function tianshudazhenController.onTeQuanInfoChange(data)
if data.tqid==XIANGUAN_PRIVILEGE_ENUM.eTqType_17 then
UIManager:callWindowFunc('UITianShuDaZhenOtherUseWin','refreshInfo')
UIManager:callWindowFunc('UITianShuDaZhenUseWin','refreshInfo')
UIManager:callWindowFunc('UIXianJie_selfZmInfoWin','refreshLeftBtns')

tianshudazhenController.onUseTeQuan()
end
end

function tianshudazhenController.onUseTeQuan()
UIFullTeQuanUseRangeEditorController.enterEditor=true
local xjdata
local actorid=tianshudazhenModel:getUseActorId()
if actorid then
local zmData=xianjieModel:getZongMenData(actorid)
if zmData then
xjdata=xianjieController:getXJClass(zmData:getID())
if xjdata then
local entity=xjdata:getMyEntity()
if entity then
entity:pauseMoveEffect()
entity:playTeQuanEditorEffect(20640)
end
end
end
end
timeEventController.delayDo(0.6,function()
UIFullTeQuanUseRangeEditorController.enterEditor=nil
if xjdata then
local entity=xjdata:getMyEntity()
if entity then
entity:resumeMoveEffect()
entity:playFangHuZhaoEffect()
end
end
end)
end