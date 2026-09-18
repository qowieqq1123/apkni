






local _MODULENAME="catEntrustController"

gameState.addListener(def_table(_MODULENAME))
catEntrustController.name=_MODULENAME
catEntrustController.data={}

function catEntrustController:onAppStart()

catEntrustModel:onAppStart()

socketManager:register_receiver(31,31,self.recv_31_31)
socketManager:register_receiver(31,32,self.recv_31_32)
socketManager:register_receiver(31,33,self.recv_31_33)
socketManager:register_receiver(31,34,self.recv_31_34)

end


function catEntrustController:onEnterState(isReconnect)
catEntrustModel:onEnterState()

notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)

notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:listenNotify(notifyConfig.onSystemZMSurrenderHanlde,self.onSystemZMSurrenderHanlde)
end


function catEntrustController:onProtocolReq(isReconnect)
catEntrustModel:onProtocolReq(isReconnect)
end


function catEntrustController:onLeaveState(isReconnect)
catEntrustModel:onLeaveState(isReconnect)

self.data={}

notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)

notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
notifySystem:removelistener(notifyConfig.onSystemZMSurrenderHanlde,self.onSystemZMSurrenderHanlde)

end


function catEntrustController:onLostConnection()

end


function catEntrustController:onReConnection(isInitPro)

end




function catEntrustController:reqStartCatEnstrust()
local entrustList=catEntrustModel:getReqStartWtArgsTable()


local isHasEquipEntrust=false
for index,entrustItem in ipairs(entrustList)do
if entrustItem[2]==Entrust_Type.EZMJ or entrustItem[2]==Entrust_Type.SGXD then
isHasEquipEntrust=true
end
end
if isHasEquipEntrust then
if bagControl.checkShowFullEquipBagTips()then return end
end

local len=#entrustList
if len>0 then
socketManager:send_31_32(len,entrustList)
else
UIManager.error('请先选择委托')
end
end

function catEntrustController:reqUnlockSlot(posID)
socketManager:send_31_34(posID)
end


function catEntrustController.recv_31_31(len,entrustDataList,exSlotUnlockFlag,miscDataListLen,miscDataList)
catEntrustModel:setExSlotUnLockFlag(exSlotUnlockFlag)
catEntrustModel:setServerData(len,entrustDataList)

catEntrustModel:setMiscDataList(miscDataListLen,miscDataList)

catEntrustModel:refreshStorageWin()
end

function catEntrustController.recv_31_32(len,entrustDataList)
if next(entrustDataList)then
local needdel={}
for k,v in ipairs(entrustDataList)do
if v.ret==1 then
UIManager.info("上古险地正在探索中无法扫荡")
len=len-1
needdel[#needdel+1]=k
end
end
if#needdel>0 then
for i=#needdel,1 do
table.remove(entrustDataList,needdel[i])
end
end
end
if not entrustDataList or not next(entrustDataList)then
return
end
for index,entrustItem in ipairs(entrustDataList)do
if entrustItem.entrust_id==Entrust_Type.LSMJ then
local num=entrustItem['param_list']['param_2']

mysteryZiYuanFuBenModel:reduceprobeNum(6,num)
end
end
catEntrustModel:updateServerData(len,entrustDataList)

catEntrustModel:refreshStorageWin()

catEntrustModel:writeFinishCatEntrustList(len,entrustDataList)

catEntrustModel:clearCatEntrustCostList()
end

function catEntrustController.recv_31_33(miscData)
catEntrustModel:updateMiscData(miscData)
end

function catEntrustController.recv_31_34(posID)
UIManager.info("解锁成功")
catEntrustModel:unlockSlot(posID)
end





function catEntrustController.onNewDay5am()
catEntrustModel:resetData()
catEntrustModel:SetToCurrentFlag(false)
catEntrustModel:refreshLocalizeCatEntrustDataListToCurrent()

UIManager:invokeUIMethod('UICatEntrustWin','refreshAll')
end

function catEntrustController.onShowPrize(prizeType,temp,effectData,temp2)

if prizeType==ePrizeType.eCatEntrust then

local tipsid=effectData.tipsid
table.sort(temp,function(a,b)
return a.sortWeight>b.sortWeight
end)
local tips=showPrizeControl.getTips(tipsid)
local lingshouList=effectData.lingshouList
if lingshouList then
for k,v in ipairs(lingshouList)do
lingshouController:addLingShou(v)
end
catEntrustModel:setLingShouInfo(lingshouList)
catEntrustModel:setRewardInfo({temp,tips})
else
catEntrustModel:setRewardInfo({temp,tips})
end
end
end

function catEntrustController.showPrize()
local showRewardInfo=catEntrustModel:getRewardInfo()
local showLingShouInfo=catEntrustModel:getLingShouInfo()
if showLingShouInfo then
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','ChangeDog',false)
local args={lslist=showLingShouInfo,lsindex=1,
closeCallBack=function()
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','ChangeDog',true)
end,}
yushoufangController:onShowLingShouInfoWin(args)
UIManager:invokeUIMethod('UICatEntrustWin','showPrizeCallBack')

elseif showRewardInfo then
local temp=showRewardInfo[1]
local tips=showRewardInfo[2]
UIManager:invokeUIMethod('UICatEntrustWin','showPrizeCallBack')
showPrizeControl.showWindow(temp,nil,{tips=tips})
end
end

function catEntrustController.onLimitActStateChange(actID,state,isNew)
if state==limitActivitiesModel.actFinishState then
if catEntrustConfig.checkLisenerLimitAct(actID)then
catEntrustModel:updateCatEntrustListTOPrepareState()
UIManager:invokeUIMethod("UICatEntrustWin","refreshAll")
end
end
end

function catEntrustController.onSystemZMSurrenderHanlde(serial,newFlag,discipleList,rewards)

if newFlag~=systemZongMenFightFlagType.eExpel then return end

local entrustSlotList=catEntrustModel:getSortEntrustSlotDataList()

for index,slotData in ipairs(entrustSlotList)do
if slotData.data~=nil and slotData.data.exclusiveData~=nil and slotData.state==Cat_Entrust_State_Type.Prepare then
if slotData.data.entrustType==Entrust_Type.ZMTY then
if slotData.data.exclusiveData.systemZmId==serial then
catEntrustModel:resetWtSlotData(slotData)
end
end
end
end
end


function catEntrustController.showSelectWin(titleName,extraWin,extraParams,noBlackBg)
noBlackBg=noBlackBg or false
local winParams={
titleName=titleName,
noBlackBg=noBlackBg,
extraWin=extraWin,
extraParams=extraParams,
}

UIManager:showWindow('UICommonDragonBoneWin',winParams)
end