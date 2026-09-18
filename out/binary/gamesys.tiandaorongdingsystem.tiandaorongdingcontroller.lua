






local _MODULENAME="tianDaoRongDingController"

gameState.addListener(def_table(_MODULENAME))
tianDaoRongDingController.name=_MODULENAME
tianDaoRongDingController.data={}

function tianDaoRongDingController:onAppStart()
tianDaoRongDingModel:onAppStart()

socketManager:register_receiver(3,186,self.recv_3_186)
socketManager:register_receiver(3,187,self.recv_3_187)
socketManager:register_receiver(3,188,self.recv_3_188)
notifySystem:listenNotify(notifyConfig.onNewWeek,self.eNewWeek)
end


function tianDaoRongDingController:onEnterState(isReconnect)
tianDaoRongDingModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onShowPrize,self.showPrize)
end


function tianDaoRongDingController:onProtocolReq()
end


function tianDaoRongDingController:onLeaveState(isReconnect)
tianDaoRongDingModel:onLeaveState(isReconnect)

self.data={}
notifySystem:removelistener(notifyConfig.onShowPrize,self.showPrize)
end


function tianDaoRongDingController:onLostConnection()

end


function tianDaoRongDingController:onReConnection(isInitPro)

end


function tianDaoRongDingController.recv_3_186(id,len,array,beginstamp,cnt)
tianDaoRongDingModel:initData(id,len,array,beginstamp,cnt)
end

function tianDaoRongDingController.recv_3_187(id,cnt,fangAnID)
tianDaoRongDingModel:onLianZhi(id,cnt)
UIManager:callWindowFunc('UITianDaoRongDingWin','onLianZhi',id,cnt)
UIManager:closeWindow('UITianDaoRongDingPeIFangWin')
end

function tianDaoRongDingController.recv_3_188(id)
tianDaoRongDingModel:clearFanganInfo()
UIManager:callWindowFunc('UITianDaoRongDingWin','onPrize',id)

end

function tianDaoRongDingController.eNewWeek()
tianDaoRongDingModel:resetCnt()
UIManager:callWindowFunc('UITianDaoRongDingPeIFangWin','freshLianZhiCnt')
end

function tianDaoRongDingController.reqPrize()
socketManager:send_3_188()
end

function tianDaoRongDingController.reqLianZhi(id,cnt,fangAnID)
socketManager:send_3_187(id,cnt,fangAnID)
end

function tianDaoRongDingController.showPrize(prizeType,prizelist,effectData)
if prizeType==ePrizeType.eTianDaoDing then
local rewards={}
for i,v in ipairs(prizelist)do



table.insert(rewards,{itemid=v.itemid,num=v.num})
end
local args={
list=rewards,
tips='',
btnData={},
closeTips="点击屏幕领取奖励",
effect='',
}
UIManager:showWindow('UICommonShowPrizeThreeWin',args)
end
end