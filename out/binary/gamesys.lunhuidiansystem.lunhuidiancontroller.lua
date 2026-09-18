






local _MODULENAME="LunHuiDianController"

gameState.addListener(def_table(_MODULENAME))
LunHuiDianController.name=_MODULENAME
LunHuiDianController.data={}

function LunHuiDianController:onAppStart()

LunHuiDianModel:onAppStart()


socketManager:register_receiver(6,161,LunHuiDianController.recv_6_161)
socketManager:register_receiver(6,162,LunHuiDianController.recv_6_162)
socketManager:register_receiver(6,163,LunHuiDianController.recv_6_163)

socketManager:register_receiver(6,191,LunHuiDianController.recv_6_191)
socketManager:register_receiver(6,192,LunHuiDianController.recv_6_192)
socketManager:register_receiver(6,193,LunHuiDianController.recv_6_193)

















end


function LunHuiDianController:onEnterState(isReconnect)
LunHuiDianModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.enterXianJieFort,self.enterXianJieFort)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function LunHuiDianController:onProtocolReq()
LunHuiDianModel:onProtocolReq()
self:initMyMoneyList()

end


function LunHuiDianController:onLeaveState(isReconnect)
LunHuiDianModel:onLeaveState(isReconnect)

self.data={}
self.moneyList={}
self.moneyIdList={}

notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:removelistener(notifyConfig.enterXianJieFort,self.enterXianJieFort)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end


function LunHuiDianController:onLostConnection()

end


function LunHuiDianController:onReConnection(isInitPro)

end




function LunHuiDianController.recv_6_161()
end



function LunHuiDianController.recv_6_162(num)
end




function LunHuiDianController.recv_6_163(idx,num)
end


function LunHuiDianController.recv_6_191(len,soldierListToday,len2,soldierListTomorrow,showFlag)
LunHuiDianModel:setHQTdata(len,soldierListToday,len2,soldierListTomorrow,showFlag)
UIManager:invokeUIMethod("UIHunQiTaiWin","freshGhostNum")
UIManager:invokeUIMethod("UIFuncStorageWin","refreshHQTbtn")
end

function LunHuiDianController.recv_6_192(len,soldierListToday)
LunHuiDianModel:freshHQTdata(len,soldierListToday)
UIManager.info("还阳成功")
UIManager:invokeUIMethod("UIHunQiTaiWin","freshGhostNum")
UIManager:invokeUIMethod("UIFuncStorageWin","refreshHQTbtn")
end

function LunHuiDianController.recv_6_193(showFlag)
LunHuiDianModel:setShowFlag(showFlag)

end




function LunHuiDianController.send_6_162(len,array)
socketManager:send_6_162(len,array)
end




function LunHuiDianController.send_6_163(idx,num)
socketManager:send_6_163(idx,num)
end


function LunHuiDianController.send_6_192(len,soldierList)


socketManager:send_6_192(len,soldierList)
end

function LunHuiDianController.send_6_193()
socketManager:send_6_193()
end


function LunHuiDianController.onShowPrize(prizeType,prizelist,effectData)

if prizeType==ePrizeType.eLunHuiDian then
LunHuiDianModel:setPrizeData(prizelist)
end
end

function LunHuiDianController:showPrize()
local prizelist=LunHuiDianModel:getPrizeData()

if prizelist then




UIManager:showWindow('UILHDShowPrizeWin',{list=prizelist})
LunHuiDianModel:setPrizeData(nil)
end
end


function LunHuiDianController:showParamPrize(prizelist)
UIManager:showWindow('UILHDShowPrizeWin',{list=prizelist})
end

function LunHuiDianController:initMyMoneyList()
self.moneyList={}
self.moneyIdList={}
local cfg=cfg_fairylandsoldierconfig()

for k,v in ipairs(cfg)do
if v then
local moneyId=v.money[3]
if moneyId then
local temp={}
local moneyIdStr=tostring(moneyId)
temp.id=v.id
temp.moneyId=moneyId

self.moneyIdList[moneyIdStr]=true
table.insert(self.moneyList,temp)
end
end
end
end

function LunHuiDianController:getMyMoneyList()
return self.moneyList,self.moneyIdList
end

function LunHuiDianController:checkMyMoneyListIsMax()
local curNum=xianjieModel:getSoldierAllHurtNum(xjSoldierHurtType.eSeriousInjury)
local maxNum=YuLingZhaiModel:getSoldierMax()
local list=xianjieModel:getSoldierHurtList(xjSoldierHurtType.eSeriousInjury)

if curNum>maxNum then
local reqList={}
if list and next(list)then
local needCount=curNum-maxNum
if self.moneyList then
for k,v in ipairs(self.moneyList)do
if v then
local num=list[v.id]or 0
if needCount>0 then
if num>=needCount then
local temp={v.moneyId,needCount}
needCount=0
table.insert(reqList,temp)
elseif num>0 and num<needCount then
needCount=needCount-num
local temp={v.moneyId,num}
table.insert(reqList,temp)
end
else
break
end
end
end
end
end

if reqList and next(reqList)then
LunHuiDianController.send_6_162(#reqList,reqList)
end
end
end

function LunHuiDianController.enterXianJieFort()
LunHuiDianController:checkMyMoneyListIsMax()
end

function LunHuiDianController.on_money_changed(moneyType,lastVal,val)
local moneyIdStr=tostring(moneyType)
local moneyList,moneyIdList=LunHuiDianController:getMyMoneyList()

if moneyIdList and moneyIdList[moneyIdStr]and val>lastVal then
LunHuiDianController:checkMyMoneyListIsMax()
end
end
