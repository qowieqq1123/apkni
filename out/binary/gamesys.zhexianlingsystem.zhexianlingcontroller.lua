






local _MODULENAME="zheXianLingController"




gameState.addListener(def_table(_MODULENAME))
zheXianLingController.name=_MODULENAME
zheXianLingController.data={}

function zheXianLingController:onAppStart()

zheXianLingModel:onAppStart()


socketManager:register_receiver(27,1,zheXianLingController.recv_27_1)
socketManager:register_receiver(27,4,zheXianLingController.recv_27_4)
socketManager:register_receiver(27,3,zheXianLingController.recv_27_3)
socketManager:register_receiver(27,2,zheXianLingController.recv_27_2)
socketManager:register_receiver(27,5,zheXianLingController.recv_27_5)
socketManager:register_receiver(27,6,zheXianLingController.recv_27_6)

















notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildEvent)
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
zheXianLingConfig.init()
end


function zheXianLingController:onEnterState(isReconnect)
zheXianLingModel:onEnterState()
end


function zheXianLingController:onProtocolReq()
zheXianLingModel:onProtocolReq()
end


function zheXianLingController:onLeaveState(isReconnect)
zheXianLingModel:onLeaveState(isReconnect)

self.data={}
end


function zheXianLingController:onLostConnection()

end


function zheXianLingController:onReConnection(isInitPro)

end









function zheXianLingController.recv_27_1(len,zxlInfo,jiyuantimes,jiyuanid,rewardflag)
zheXianLingModel:initData(len,zxlInfo,jiyuantimes,jiyuanid,rewardflag)
zheXianLingModel:checkEnterNextBook()
zheXianLingController:freshMainWindow('freshReddot')
end



function zheXianLingController.recv_27_4(idx)
zheXianLingModel:onRewardJiYuan(idx)
zheXianLingController:freshMainWindow('freshAllReddot')
zheXianLingController:freshJiYuanWindow('onPirze',idx)
zheXianLingController:freshTaskWindow('freshZheXianReward')
end




function zheXianLingController.recv_27_3(type,aim_id)
zheXianLingModel:onRewards(type,aim_id)
zheXianLingController:freshMainWindow('freshAllReddot')
if type==2 then
zheXianLingController:freshChapterWindow('onChapterPrize')
local weak_id=zheXianLingConfig.getChapterconfig(aim_id).weak_id
if weak_id then
weakGuideController:beginGuide(weak_id)
end
pfCommonHelper.zheXianLingPoint(aim_id)
elseif type==1 then
local function cb()
zheXianLingController:onBookPrize()
end
cb()
end
zheXianLingController:freshTaskWindow('freshZheXianReward')
notifySystem:postNotify(notifyConfig.onZheXianLingProgressChange)
end



function zheXianLingController.recv_27_2(book_id)
zheXianLingModel:onOpenNewBook(book_id)
zheXianLingController:freshMainWindow('freshAllReddot')
zheXianLingController:freshChapterWindow('freshInfo')
zheXianLingController:freshTaskWindow('refreshZheXianLing')
zheXianLingController:freshDaoTuWindow('freshInfo')
end


function zheXianLingController.recv_27_5(times)
zheXianLingModel:onJiYuanTimesChanged(times)
zheXianLingController:freshJiYuanWindow('freshOther')
zheXianLingController:freshTaskWindow('freshZheXianReward')
end

function zheXianLingController.recv_27_6(chapter_id)
zheXianLingModel:onOpenNewChapter(chapter_id)
pfwindowslController.checkBindAccountReddot(chapter_id)
zheXianLingController:freshTaskWindow('refreshZheXianLing')
zheXianLingController:freshChapterWindow('freshInfo')
zheXianLingController:freshMainWindow('freshAllReddot')
end

function zheXianLingController.onTaskChange(taskid,state)
if zheXianLingModel:isCurrentBookTask(taskid)then
if zheXianLingModel:isFinishCurrentChapterAllTask()then
zheXianLingModel:onFinishCurrentChapeter()
end
zheXianLingController:freshMainWindow('freshAllReddot')
zheXianLingController:freshTaskWindow('refreshZheXianLing')
end
end

function zheXianLingController.onBuildEvent(event,level,exp,lastLv)
if event==buildingEvent.zongmenLevelUp then
zheXianLingModel:checkEnterNextBook()
end
end

function zheXianLingController.onSystemOpen(sysid,openNew)
if not openNew then return end
if sysid==SYSTEM_DEFINE.eZeXianLing then
zheXianLingModel:checkEnterNextBook()
end
end

function zheXianLingController.onShowPrize(prizeType,temp,effectData,temp2)
if prizeType==ePrizeType.eZheXianLingJiYuan then
zheXianLingController.data=temp
end
end

function zheXianLingController.showJiYuanPrize()
local data=zheXianLingController.data
if data==nil then return end
showPrizeControl.showWindow(data)
zheXianLingController.data=nil
end

function zheXianLingController:freshMainWindow(funcname,...)
UIManager:callWindowFunc('UIZheXianLingWin',funcname,...)
end

function zheXianLingController:freshChapterWindow(funcname,...)
UIManager:callWindowFunc('UIZheXianLingZJWin',funcname,...)
end

function zheXianLingController:freshJiYuanWindow(funcname,...)
UIManager:callWindowFunc('UIZheXianLingJiYuanWin',funcname,...)
end

function zheXianLingController:freshDaoTuWindow(funcname,...)
UIManager:callWindowFunc('UIZheXianLingDaoTuWin',funcname,...)
end

function zheXianLingController:freshTaskWindow(funcname,...)
UIManager:callWindowFunc('UITaskListWin',funcname,...)
end

function zheXianLingController:onBookPrize()
zheXianLingModel:enterNextBook()
zheXianLingController:freshDaoTuWindow('freshInfo')
end

function zheXianLingController:isWaitNextOpen(onlyBook)
local isRewardBook=zheXianLingModel:isRewardCurrentBook()
local isRewardChapter=zheXianLingModel:isRewardCurrentChapter()
local desc=''
local ret=false
local args
if isRewardBook then
local data=zheXianLingModel:getData()
local book_id=data.book_id

local bookCfg=zheXianLingConfig.getBookconfig(book_id)
local nextid=bookCfg.nextid
if nextid then
local ret1,args1=zheXianLingModel:canOpenBook(nextid)
desc=zheXianLingModel:getOpenBookCnd(nextid)
args={1,args1}
else
args={1}
desc='已完成所有章节'
end
ret=true
else
if onlyBook then return ret,desc,args end
local chapter_id=zheXianLingModel:getChapter()
if isRewardChapter then
local chaptercfg=zheXianLingConfig.getChapterconfig(chapter_id)
local nextid=chaptercfg.nextid
if nextid then
local ret1,args1=zheXianLingModel:canOpenChapter(nextid)
args={2,args1}
ret,desc=zheXianLingModel:getOpenchapterCnd(nextid)
else
args={2}
desc='已完成所有章节'
end
else
local ret1,args1=zheXianLingModel:canOpenChapter(chapter_id)
if not ret1 then
args={2,args1}
ret,desc=zheXianLingModel:getOpenchapterCnd(chapter_id)
end

end
end
return ret,desc,args
end

function zheXianLingController:checkFly(sysid)
if systemConfig.getSystemConfig(sysid).fly then
if fullScreenUI.checkFull(UIFullZheXianControl)then
UIFullZheXianControl:closeUI()
end
end
end

function zheXianLingController:playFinishBookPlot(book_id)
local cfg=zheXianLingConfig.getBookconfig(book_id)
local screenParams=cfg.screenParams
local targetParams=cfg.targetParams
local params=cfg.playplot
if params==nil then return end
local plot_type=params[1]
local plot_name=params[2]
local isBehavier=plot_type==1
local check=true
if isBehavier then
check=zheXianLingController:checkZXLBookPlot(plot_name)
end
if check then
local callBack=function(flag_)
if flag_ then
local flag=gameplotController.activePlot(params)
if flag and isBehavier then
zheXianLingController:setZXLBookPlot(plot_name)
end
end
end
if screenParams~=nil then
cameraMoveController:Begin(screenParams,targetParams,callBack)
else
callBack(true)
end
return true
end
end

function zheXianLingController:checkZXLBookPlot(plot_name)
local marklist=userActorSetting.get('zxlBookPlot',{})
if marklist[plot_name]~=nil then
return false
end
return true
end

function zheXianLingController:setZXLBookPlot(plot_name)
local marklist=userActorSetting.get('zxlBookPlot',{})
marklist[plot_name]=true
userActorSetting.flushVal('zxlBookPlot',marklist,{})
end