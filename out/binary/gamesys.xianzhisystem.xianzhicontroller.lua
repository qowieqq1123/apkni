






local _MODULENAME="xianzhiController"

gameState.addListener(def_table(_MODULENAME))
xianzhiController.name=_MODULENAME
xianzhiController.data={}

function xianzhiController:onAppStart()

xianzhiModel:onAppStart()


socketManager:register_receiver(37,41,self.recv_37_41)
socketManager:register_receiver(37,42,self.recv_37_42)
socketManager:register_receiver(37,43,self.recv_37_43)
socketManager:register_receiver(37,44,self.recv_37_44)
socketManager:register_receiver(37,45,self.recv_37_45)
socketManager:register_receiver(37,46,self.recv_37_46)

end


function xianzhiController:onEnterState(isReconnect)
xianzhiModel:onEnterState()


notifySystem:listenNotify(notifyConfig.on_money_changed,xianzhiController.on_money_changed)
notifySystem:listenNotify(notifyConfig.onGuBaoSkillLevelChange,xianzhiController.onGuBaoSkillLevelChange)
notifySystem:listenNotify(notifyConfig.onNewDay5am,xianzhiController.onNewDay5am)
end


function xianzhiController:onProtocolReq()
xianzhiModel:onProtocolReq()
end


function xianzhiController:onLeaveState(isReconnect)
xianzhiModel:onLeaveState(isReconnect)

self.data={}


notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.onGuBaoSkillLevelChange,self.onGuBaoSkillLevelChange)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
end


function xianzhiController:onLostConnection()

end


function xianzhiController:onReConnection(isInitPro)

end



function xianzhiController:reqOpenXianZhi()
socketManager:send_37_42()
end


function xianzhiController:reqUpXianZhiLevel()
socketManager:send_37_43()
end


function xianzhiController:reqUpXianBaoLevel()
socketManager:send_37_44()
end

function xianzhiController:reqReceiveDayWages()
socketManager:send_37_45()
end

function xianzhiController:reqReceiveXGReward()
socketManager:send_37_46()
end


function xianzhiController.recv_37_41(args)

local xzid=args[1]
local openFlag=args[2]
local xgRwMaxId=args[3]
local rewardXzId=args[4]
local rewardXbLevel=args[5]
local rewardXbPercent=args[6]
local rewardFlag=args[7]

xianzhiModel:setServerData(xzid,openFlag,xgRwMaxId,rewardXzId,rewardXbLevel,rewardXbPercent,rewardFlag)
end

function xianzhiController.recv_37_42(openFlag)
xianzhiModel:changeXianZhiOpenFlag(openFlag)

local openFunc=function()
UIFullXianTuChengJiuControl:showWindow_XianZhi()

UIManager:invokeUIMethod("UIXTCJForeGroundWin",'refreshMenu')
end
UIFullXianTuChengJiuControl:showWindowByCloud(openFunc)
end

function xianzhiController.recv_37_43(xzId,xbLevel)
local oldXzId=xianzhiModel:getXianZhiId()

xianzhiModel:changeXzId(xzId)
xianzhiModel:changeXbLevel(xbLevel)

local args={
curXzId=xzId,
oldXzId=oldXzId,
}

UIFullXianTuChengJiuControl:showWindow("UIXianZhiLevelUpWin",args)

xianzhiController.checkUnlockImage(oldXzId,xzId)

notifySystem:postNotify(notifyConfig.onXianZhiLevelChange,xzId)

reddotControl.on_change_catch_type(CATCH_TYPE.eXianZhi)
end

function xianzhiController.recv_37_44(xbLevel)
xianzhiModel:changeXbLevel(xbLevel)

notifySystem:postNotify(notifyConfig.onXianZhiXianBaoLevelChange,xbLevel)

reddotControl.on_change_catch_type(CATCH_TYPE.eXianZhi)
end

function xianzhiController.recv_37_45(flag)
xianzhiModel:changeRewardXzId()
xianzhiModel:changeRewardXbLevel()
xianzhiModel:changeRewardFlag(flag)

notifySystem:postNotify(notifyConfig.onXianZhiWagesReceive)

reddotControl.on_change_catch_type(CATCH_TYPE.eXianZhi)
end

function xianzhiController.recv_37_46(xgRwMaxId)
xianzhiModel:changeXgRwMaxId(xgRwMaxId)

notifySystem:postNotify(notifyConfig.onXianZhiTaskStateChange,xgRwMaxId)

reddotControl.on_change_catch_type(CATCH_TYPE.eXianZhi)
end


function xianzhiController.getXianZhiChongTian()
local xzId=xianzhiModel:getXianZhiId()
local xianzhiCfgs=cfg_xianzhiconfig()
if xianzhiCfgs[xzId]then
return xianzhiCfgs[xzId].jctian
end
return 0
end

function xianzhiController.getGBSKil_XianZhiWagesRate()
local xzId=xianzhiModel:getXianZhiId()
local xianzhiCfgs=cfg_xianzhiconfig()
if xianzhiCfgs[xzId]then
local flPercent=xianzhiCfgs[xzId].flPercent
return flPercent*100
end
return 0
end

function xianzhiController.getChangeXianZhiWagesRateJCT()
local xzId=xianzhiModel:getXianZhiId()
local xianzhiCfgs=cfg_xianzhiconfig()
local curRate=xianzhiCfgs[xzId].flPercent
local jct=0
for index=xzId,#xianzhiCfgs do
local cfg=xianzhiCfgs[index]
local cfgRate=cfg.flPercent
if cfgRate>curRate then
jct=cfg.jctian
break
end
end
return jct
end



function xianzhiController.on_money_changed(mtype)
if mtype==eMoneyType.mtDaoXun then
reddotControl.on_change_catch_type(CATCH_TYPE.eXianZhi)
end
end

function xianzhiController.onGuBaoSkillLevelChange(gbid,skilllv,oldLv)
local sgbid=xianzhiConfig.getBaseInfo('gbid')
if gbid==sgbid then
reddotControl.on_change_catch_type(CATCH_TYPE.eXianZhi)
notifySystem:postNotify(notifyConfig.onXianZhiXianBaoLevelChange)
end
end


function xianzhiController.onNewDay5am()
xianzhiModel:resetNewDayRewardFlag()

wagesMsgController:checkShowWages()
end


function xianzhiController.checkShowActiveBeishi(oldXzId,curXzId)
local oldactiveItem=cfgHelper.get2(cfg_xianzhiconfig_get,oldXzId,'activeItem')
local curactiveItem=cfgHelper.get2(cfg_xianzhiconfig_get,curXzId,'activeItem')

if oldactiveItem~=curactiveItem then
UIManager:showWindow('UICommonShowPrizeFiveWin',{itemid=curactiveItem})
end
end

function xianzhiController.checkUnlockImage(oldXzId,curXzId)
local totalXzLevelCfgs=cfg_xianzhiconfig()
local oldBeishiList=totalXzLevelCfgs[oldXzId].beishiId
local oldActiveItem=totalXzLevelCfgs[oldXzId].activeItem

local sex=playerModel:getActorSex()
sex=sex==1 and 1 or 2
local oldBeishiId=oldBeishiList[sex]

local imageList={}

for xzid=oldXzId+1,curXzId do
if totalXzLevelCfgs[xzid]~=nil then
local curBeishiList=totalXzLevelCfgs[xzid].beishiId
if curBeishiList then
local curActiveItem=totalXzLevelCfgs[xzid].activeItem
local curBeishiId=curBeishiList[sex]
if oldActiveItem~=curActiveItem then
oldActiveItem=curActiveItem
imageList[#imageList+1]={param_1=PLAYER_IMAGE_TYPE.eBodyOrnament,param_2=curBeishiId}
end
end
end
end
local imageLen=#imageList
if imageLen>0 then

playerImageModel:onUnlockImage(imageLen,imageList,0)
end
end
