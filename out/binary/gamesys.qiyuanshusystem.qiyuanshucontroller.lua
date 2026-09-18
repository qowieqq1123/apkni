






local _MODULENAME="qiYuanShuController"

gameState.addListener(def_table(_MODULENAME))
qiYuanShuController.name=_MODULENAME
qiYuanShuController.data={}

function qiYuanShuController:onAppStart()

qiYuanShuModel:onAppStart()



socketManager:register_receiver(6,116,qiYuanShuController.recv_6_116)
socketManager:register_receiver(6,117,qiYuanShuController.recv_6_117)
socketManager:register_receiver(6,118,qiYuanShuController.recv_6_118)
socketManager:register_receiver(6,119,qiYuanShuController.recv_6_119)







end


function qiYuanShuController:onEnterState(isReconnect)
qiYuanShuModel:onEnterState()
self:clearQiYuanStateChangeTimer()
notifySystem:listenNotify(notifyConfig.onCommonShopData,self.onCommonShopData)
notifySystem:listenNotify(notifyConfig.onCommonShopChange,self.onCommonShopChange)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
end


function qiYuanShuController:onProtocolReq()
qiYuanShuModel:onProtocolReq()
end


function qiYuanShuController:onLeaveState(isReconnect)
qiYuanShuModel:onLeaveState(isReconnect)
self:clearQiYuanStateChangeTimer()
notifySystem:removelistener(notifyConfig.onCommonShopData,self.onCommonShopData)
notifySystem:removelistener(notifyConfig.onCommonShopChange,self.onCommonShopChange)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)

self.data={}
end


function qiYuanShuController:onLostConnection()
self:clearQiYuanStateChangeTimer()
end


function qiYuanShuController:onReConnection(isInitPro)

end

function qiYuanShuController.onCommonShopData(shopId)
if shopId==eFuncShopType.eQiYuan then
local bdData=baoLingShuController:getBuildData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end


UIManager:invokeUIMethod("UIQiYuanShu_ShopWin","updateView")

reddotControl.on_change_catch_type(CATCH_TYPE.eQiYuanShu)

UIManager:invokeUIMethod("UIQiYuanShuWin","refreshPickUpShopBtnReddot")
end
end

function qiYuanShuController.onCommonShopChange(shopId)
if shopId==eFuncShopType.eQiYuan then
local bdData=baoLingShuController:getBuildData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end


UIManager:invokeUIMethod("UIQiYuanShu_ShopWin","updateView")

reddotControl.on_change_catch_type(CATCH_TYPE.eQiYuanShu)

UIManager:invokeUIMethod("UIQiYuanShuWin","refreshPickUpShopBtnReddot")
end
end

function qiYuanShuController.onNewDay5am(islogin)
if not islogin then

local bdData=baoLingShuController:getBuildData()
local isOpenSys=systemModel.isOpen(SYSTEM_DEFINE.eWishTree)
if bdData and isOpenSys then
qiYuanShuController:req_qiyuanshu_data()
end
end
end



function qiYuanShuController:req_qiyuanshu_data()
socketManager:send_6_116()
end


function qiYuanShuController:req_qiyuan(num)
socketManager:send_6_117(num)
end


function qiYuanShuController:req_qiyuanshu_wishgubao(gubaoId)
socketManager:send_6_118(gubaoId)
end


function qiYuanShuController:req_qiyuanshu_change(lib_id)
socketManager:send_6_119(lib_id)
end



function qiYuanShuController.recv_6_116(args)
qiYuanShuModel:initQiYuanShuData(args)

qiYuanShuModel:initQiYuanShuTime(args)
qiYuanShuController:setQiYuanStateChangeTimer()
qiYuanShuModel:setQiYuanShuOpenlist()

local bdData=baoLingShuController:getBuildData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end

funcShopController.send_23_1(eFuncShopType.eQiYuan)



reddotControl.on_change_catch_type(CATCH_TYPE.eQiYuanShu)

UIManager:callWindowFunc("UIQiYuanShuWin","refresh",true)
end


function qiYuanShuController.recv_6_117(args)
local itemListLen=args[1]
local itemList=args[2]
local bdNum=args[3]
local freeNum=args[4]
local gbfreeNum=args[5]
local todayNum=args[6]
local bdNum_orange=args[7]
local bdNum_red=args[8]
local data=qiYuanShuModel:get_qiyuanshu_data()
if data then
data.bdNum=bdNum
data.freeNum=freeNum
data.gbfreeNum=gbfreeNum
data.todayNum=todayNum
data.firstFlag=1

data.bdNum_red=bdNum_red
end
if itemListLen>0 then
qiYuanShuModel:saveRewardsTemp(itemList)
local checkPass=qiYuanShuModel:getQYSPassAniState()
if checkPass then
qiYuanShuController:showQiYuanShuPrize(itemList)
else
if baoLingShuController.fightStage then
local stageId=baoLingShuController.fightStage.stageID
local behaviorName=qiYuanShuModel:getShowBehaviorName()
baoLingShuController.fightStage:runBehavior(stageId+1,behaviorName,function(eventTypo)
if eventTypo==fBTEvent.ActiveSkillActions then
UIManager:invokeUIMethod("UIBaoLingShuMainHUD","showBigReward")
end

UIManager.setMoneyMsgShowState(true,true)
end)
end
end
else
UIManager.info('空空如也')
end
local bdData=baoLingShuController:getBuildData()
if bdData~=nil then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end


reddotControl.on_change_catch_type(CATCH_TYPE.eQiYuanShu)

UIManager:callWindowFunc("UIQiYuanShuWin","refresh")
end


function qiYuanShuController.recv_6_118(gubao_id)
qiYuanShuModel:setQiYuanShuWishGbId(gubao_id)


UIManager:invokeUIMethod("UIQiYuanShuWin","refreshWishGbPanel")

UIManager:invokeUIMethod("UIQiYuanShu_SelectWin","refresh")
end


function qiYuanShuController.recv_6_119(lib_id)
UIManager.info('切换成功')
qiYuanShuModel:setQiYuanShuId(lib_id)
qiYuanShuModel:resetwishGBId()
reddotControl.on_change_catch_type(CATCH_TYPE.eQiYuanShu)
UIManager:callWindowFunc("UIQiYuanShuWin","refresh",true)
end



function qiYuanShuController:showQiYuanShuPrize(itemList)
itemList=itemList or qiYuanShuModel:getRewardsTemp()
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
UIFullBaoLingShuControl:showWindow('UIQiYuanShuShowPrizeWin',{conf})

AudioManager.playAudio(407)
end



function qiYuanShuController:setQiYuanStateChangeTimer()
self:clearQiYuanStateChangeTimer()
self.qiYuanIsOpen=qiYuanShuModel:checkIsInQiYuanNow()
local func=function()
local sTime,eTime=qiYuanShuModel:getQiYuanTime()
local nowTime=timeHelper.getServerShortTime()
local isChange=false
if self.qiYuanIsOpen then
if eTime and eTime~=0 and nowTime>eTime then
isChange=true
end
else
if sTime and sTime~=0 and nowTime>sTime and eTime and eTime~=0 and nowTime<=eTime then
isChange=true
end
end

if isChange then
if self.qiYuanIsOpen then

self.qiYuanIsOpen=false

else

self.qiYuanIsOpen=true

end

qiYuanShuController:req_qiyuanshu_data()
end
end
self.qiYuanStateChangeTimer=timer.new()
self.qiYuanStateChangeTimer:start(1,func)
end


function qiYuanShuController:clearQiYuanStateChangeTimer()
if self.qiYuanStateChangeTimer then
self.qiYuanStateChangeTimer:cancel()
self.qiYuanStateChangeTimer=nil
self.qiYuanIsOpen=nil
end
end






