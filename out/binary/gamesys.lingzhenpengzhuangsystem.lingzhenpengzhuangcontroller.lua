






local _MODULENAME="lingZhenPengZhuangController"

gameState.addListener(def_table(_MODULENAME))
lingZhenPengZhuangController.name=_MODULENAME
lingZhenPengZhuangController.data={}

function lingZhenPengZhuangController:onAppStart()

lingZhenPengZhuangModel:onAppStart()



socketManager:register_receiver(248,71,self.recv_248_71)
socketManager:register_receiver(248,72,self.recv_248_72)
socketManager:register_receiver(248,73,self.recv_248_73)

socketManager:register_receiver(248,75,self.recv_248_75)
socketManager:register_receiver(248,76,self.recv_248_76)
socketManager:register_receiver(248,81,self.recv_248_81)






end


function lingZhenPengZhuangController:onEnterState(isReconnect)
lingZhenPengZhuangModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:listenNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
end


function lingZhenPengZhuangController:onProtocolReq()
lingZhenPengZhuangModel:onProtocolReq()
if lingZhenPengZhuangController:isActOpen()then
if not lingZhenPengZhuangModel:checkIsInit()then

lingZhenPengZhuangController:reqDatas()
end
end
end


function lingZhenPengZhuangController:onLeaveState(isReconnect)
lingZhenPengZhuangModel:onLeaveState(isReconnect)
notifySystem:removelistener(notifyConfig.onLimitActOpen,self.onLimitActOpen)
notifySystem:removelistener(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)

self.data={}
end


function lingZhenPengZhuangController:onLostConnection()
end


function lingZhenPengZhuangController:onReConnection(isInitPro)

end



function lingZhenPengZhuangController:reqDatas()
socketManager:send_248_71()
end


function lingZhenPengZhuangController:reqUseSkill(ftype)
socketManager:send_248_72(ftype)
end


function lingZhenPengZhuangController:reqSetScore(score)
local topScore=lingZhenPengZhuangModel:getTopScore()
if score>topScore then

lingZhenPengZhuangModel:setTopScore(score)

socketManager:send_248_73(score)
end
end









function lingZhenPengZhuangController:reqSelectCampById()
socketManager:send_248_75()
end


function lingZhenPengZhuangController:reqGetCampScoreDataList()
socketManager:send_248_76()
end

function lingZhenPengZhuangController.recv_248_71(camp,score)
lingZhenPengZhuangModel:setLingZhenCamp(camp)
lingZhenPengZhuangModel:setTopScore(score)

lingZhenPengZhuangModel:setIsInit(true)


lingZhenPengZhuangModel:setNextUpdateDataTime()


UIManager:callWindowFunc('UILingZhenPZMainWin','refresh')


notifySystem:postNotify(notifyConfig.onLingZengPengZhuangScoreChange,score)
end

function lingZhenPengZhuangController.recv_248_72(ftype)
UIManager:callWindowFunc('UILingZhenPZGameExWin','handleSkill',ftype)
end

function lingZhenPengZhuangController.recv_248_73(score)
lingZhenPengZhuangModel:setTopScore(score)

notifySystem:postNotify(notifyConfig.onLingZengPengZhuangScoreChange,score)
end








function lingZhenPengZhuangController.recv_248_75(camp)
lingZhenPengZhuangModel:setLingZhenCamp(camp)


UIManager:invokeUIMethod("UILingZhenPZMainWin","refreshStartGamePanel",true)
end

function lingZhenPengZhuangController.recv_248_76(len,dataList)
lingZhenPengZhuangModel:setLingZhenCampScoreData(len,dataList)


UIManager:callWindowFunc('UILingZhenPZMainWin','refresh')
end

function lingZhenPengZhuangController.recv_248_81(time)

end



function lingZhenPengZhuangController:isActOpen()
local data=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eLingZhenPengZhuang)
if data and data.state==2 then
return true
end
return false
end

function lingZhenPengZhuangController.onLimitActOpen(actID,flag)
if actID==LIMIT_ACT_TYPE.eLingZhenPengZhuang and flag then
lingZhenPengZhuangController:reqDatas()
end
end

function lingZhenPengZhuangController.onLimitActStateChange(actID,state)
if actID~=LIMIT_ACT_TYPE.eLingZhenPengZhuang then return end
if state==limitActivitiesModel.actPreviewState then


elseif state==limitActivitiesModel.actDoingState or state==limitActivitiesModel.actIdleState then


local func=function()
lingZhenPengZhuangController:reqDatas()
end
timeEventController.delayDo(1,func)
end
end
