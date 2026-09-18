








tianmingzengliController=gameState.addListener({})


tianmingzengliController.data={}

function tianmingzengliController:onAppStart()

tianmingzengliModel:onAppStart()



socketManager:register_receiver(2,80,tianmingzengliController.recv_2_80)
socketManager:register_receiver(2,84,tianmingzengliController.recv_2_84)
socketManager:register_receiver(2,85,tianmingzengliController.recv_2_85)






end


function tianmingzengliController:onEnterState(isReconnect)
tianmingzengliModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onDiscipleTianMingLvChange,self.onDiscipleTianMingLvChange)
notifySystem:listenNotify(notifyConfig.onDiscipleNewID,self.onDiscipleNewID)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end


function tianmingzengliController:onProtocolReq()
tianmingzengliModel:onProtocolReq()
tianmingzengliModel:checkTMZLAllData()
tianmingzengliController:checkEnter()
end


function tianmingzengliController:onLeaveState(isReconnect)
tianmingzengliModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onDiscipleTianMingLvChange,self.onDiscipleTianMingLvChange)
notifySystem:removelistener(notifyConfig.onDiscipleNewID,self.onDiscipleNewID)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)

if self.enterGuid then
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end
self.data={}
end


function tianmingzengliController:onLostConnection()

end


function tianmingzengliController:onReConnection(isInitPro)

end




function tianmingzengliController:reqTianMingZengLiGetFreeLibaoBatch(libaoList)
socketManager:send_2_80(#libaoList,libaoList)
end


function tianmingzengliController:reqTianMingZengLiGetFreeLibao(dzId,libaoId)
socketManager:send_2_85(dzId,libaoId,1)
end


function tianmingzengliController:reqTianMingZengLiBuyLibao(rechargeId,dzId,libaoId)
local buyCount=1
local param=FMT.fmt('{0}-{1}-{2}',dzId,libaoId,buyCount)
payControl.reqPay(rechargeId,buyCount,param)
end


function tianmingzengliController.recv_2_80(len,list)
if len>0 then
for i,v in ipairs(list)do
local dzId=v.param_1
local idx=v.param_2
local free=v.param_3 or 0
local recharge=v.param_4 or 0
tianmingzengliModel:setTMZLShowItemLibaoData(dzId,idx,free,recharge)
end
end


local win=UIManager:findActiveWindow('UITianmingSysWin')
if win then
win:refresh()
end


enterManager:freshFunc('freshReddot',ENTER_TYPE.eTianMingZengLi)
tianmingzengliController:on_change_catch_type()
reddotControl.on_change_catch_type(CATCH_TYPE.eTMZLsys)
end


function tianmingzengliController.recv_2_84(len,tmzlDataList)
tianmingzengliModel:setTMZLAllData(len,tmzlDataList)
if initProControl.isDone()then
tianmingzengliModel:checkTMZLAllData()

tianmingzengliController:checkEnter()
end


local win=UIManager:findActiveWindow('UITianmingSysWin')
if win then
win:refresh()
end


enterManager:freshFunc('freshReddot',ENTER_TYPE.eTianMingZengLi)
reddotControl.on_change_catch_type(CATCH_TYPE.eTMZLsys)
end


function tianmingzengliController.recv_2_85(dzId,idx,free,recharge)
tianmingzengliModel:setTMZLShowItemLibaoData(dzId,idx,free,recharge)


local win=UIManager:findActiveWindow('UITianmingSysWin')
if win then
win:refresh(nil,dzId)
end


enterManager:freshFunc('freshReddot',ENTER_TYPE.eTianMingZengLi)
tianmingzengliController:on_change_catch_type()
reddotControl.on_change_catch_type(CATCH_TYPE.eTMZLsys)
end




function tianmingzengliController:checkEnter()
if not systemModel.isOpen(SYSTEM_DEFINE.eTianMingZengLi)then

return false
end
local isShowEnter=tianmingzengliController:isEnterCanShow()


self:freshEnter(isShowEnter)


notifySystem:postNotify(notifyConfig.onTianMingZengliOpenChange,isShowEnter)


tianmingzengliController:on_change_catch_type()












end

function tianmingzengliController:isEnterCanShow()
if not systemModel.isOpen(SYSTEM_DEFINE.eTianMingZengLi)then

return false
end
local isShowEnter=false


local tmzlShowList=tianmingzengliModel:getTMZLShowItemList()
if tmzlShowList and next(tmzlShowList)then
isShowEnter=true
end
return isShowEnter
end

function tianmingzengliController:freshEnter(flag)

if verifyManager:isHideBusinessActivity()then
return false
end
if activitiesController:isAddSysTab(SUB_ACTIVITY_TYPE.eTianMingZengLi_sys)then
flag=false
end
if flag then
if not self.enterGuid then
self.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eTianMingZengLi})
end
else
self:removeEnter()
end
end


function tianmingzengliController:removeEnter()
if not self.enterGuid then return end
enterManager:freshFunc('onClose',ENTER_TYPE.eTianMingZengLi)
local ret=enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
if ret then
UIManager:callWindowFunc('UIMainEntryWin','freshInfo')
end
end


function tianmingzengliController:on_change_catch_type()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eTianMingZengLi_sys)
end


function tianmingzengliController:tryUpdateListDataAndEnter()

tianmingzengliModel:checkAndClearTMZLShowItemList()


tianmingzengliController:checkEnter()
end


function tianmingzengliController:checkIsCanOpenTMZLWin()
local tmzlShowList=tianmingzengliModel:getTMZLShowItemList()
if not tmzlShowList or not next(tmzlShowList)then
return false
end

return true
end

function tianmingzengliController.onDiscipleTianMingLvChange(dis_guid,oldtmlv,tmlv)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData then
local dzId=netData.id
if dzId then
local isShowDz=tianmingzengliModel:checkTMZLDzIsShowByDzId(dzId)
if isShowDz then

enterManager:freshFunc('freshReddot',ENTER_TYPE.eTianMingZengLi)
reddotControl.on_change_catch_type(CATCH_TYPE.eTMZLsys)
end
end
end
end

function tianmingzengliController.onDiscipleNewID(dis_guid,dzid)
tianmingzengliModel:checkTMZLAddDzDataByDzId(dzid)
tianmingzengliController:checkEnter()
end

function tianmingzengliController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eTianMingZengLi then
tianmingzengliController:checkEnter()
end
end