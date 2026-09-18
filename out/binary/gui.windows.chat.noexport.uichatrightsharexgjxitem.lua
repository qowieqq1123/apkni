







def_class("UIChatRightShareXGJXItem",UICloneObject)





UIChatRightShareXGJXItem.abName=""

UIChatRightShareXGJXItem.assetName="UIChatRightShareXGJXItem"


function UIChatRightShareXGJXItem:bindComponents()

self.bg=UIButton.get(self,0)
self.content=UIText.get(self,1)
self.flagImg=UIImage.get(self,2)
self.flagTx=UIText.get(self,3)
self.head=UIObject.get(self,4)
self.name=UIText.get(self,5)
self.time=UIText.get(self,6)
self.timeRoot=UIObject.get(self,7)

self.bg:setButtonClick(function()self:onBg()end)

end


function UIChatRightShareXGJXItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.flagImg);self.flagImg=nil;
_UIObject_release(self.flagTx);self.flagTx=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
end





local _this

local _regexType2Act={
[CHAT_REGEX_TYPE.csOfficerElectionHelp]={
actId=LIMIT_ACT_TYPE.eXianGuanWenXuan,
getInfo=chatEmotHelper.getXGWXInfoByRegex1,
jump=function(timeStamp,info,actorID)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)then
UIManager.info("暂时无法参与，需要开启仙官")
return
end

local shortTime=timeHelper.convertShortStamp(timeStamp)
local activityData
local isInBwMatch=xianguanController:isInMatchStage_WenXuan_BW()
if isInBwMatch then
activityData=xianguanModel:getActivityData_WenXuan_BW()
else
activityData=xianguanModel:getWenXuanActivityData()
end
if activityData and((activityData.thisWeek and timeHelper.checkInSameWeek4(shortTime))or isInBwMatch)then
local nowTime=timeHelper.getServerShortTime()
if activityData.voteBTime<=nowTime and nowTime<activityData.voteETime then
local args={
jobId=info.jobId,
declaration=info.declaration,
actorId=actorID,
bwFlag=info.bwFlag,
}
UIManager:showWindow("UIXianGuanWenXuanInspireWin",args)
return
end
end
UIManager.error("分享时效已过")
end,
},
[CHAT_REGEX_TYPE.csOfficerElection2Help]={
actId=LIMIT_ACT_TYPE.eXianGuanWuXuan,
getInfo=chatEmotHelper.getXGWXInfoByRegex2,
jump=function(timeStamp,info)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)then
UIManager.info("暂时无法参与，需要开启仙官")
return
end

local shortTime=timeHelper.convertShortStamp(timeStamp)
local activityData
local isInBwMatch=xianguanController:isInMatchStage_WuXuan_BW()
if isInBwMatch then
activityData=xianguanModel:getActivityData_WuXuan_BW()
else
activityData=xianguanModel:getWuXuanActivityData()
end
if activityData and((activityData.thisWeek and timeHelper.checkInSameWeek4(shortTime))or isInBwMatch)then
local nowTime=timeHelper.getServerShortTime()
if activityData.prepareBTime<=nowTime and nowTime<activityData.prepareETime then
local args={
job=info.jobId,
playerIdx=info.actorIdx,
bwFlag=info.bwFlag,
}
UIManager:showWindow("UIXianGuanWuXuanInspireWin",args)
return
end
end
UIManager.error("分享时效已过")
end,
}
}




function UIChatRightShareXGJXItem:onLoaded(...)
self:bindComponents()
_this=self
end


function UIChatRightShareXGJXItem:__delete()
self:unbindComponents()
_this=nil
end




function UIChatRightShareXGJXItem:onShow(argtable,afterOnloaded)
local widget=self.widget
local chatInfo=argtable.chatInfo
local channelId=chatInfo.channelId
local timeStamp=chatInfo.timeStamp
local msgType=chatInfo.msgType
local mesg=chatInfo.mesg
local isSelf=chatInfo:isSelfActor()
local actorInfo=chatInfo.actorInfo or{}
local actorID=actorInfo.actorId
local actorName=actorInfo.actorName
local actorLevel=actorInfo.actorLevel
local serverId=actorInfo.serverId
local chatId=actorInfo.chatId
local iconInfo=actorInfo.iconInfo
self:freshRect()

local timeFlag=chatInfo.timeFlag or false
self.timeFlag=timeFlag
self.timeRoot:setActive(timeFlag)
if timeFlag then
local txt=''
if timeHelper.isTodayStamp(timeStamp)then
txt=timeHelper.getTwoFormatByStamp(timeStamp)
else
txt=timeHelper.getFourFormatByStamp(timeStamp)
end
self.time:setText(txt)
end

if channelId~=CHAT_CHANNNEL.eKuafu then
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'{0}',actorName))
else
self.name:setText(FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}]{1}',loginModel:getServerName(serverId),actorName))
end

playerController:setRawImageHeadIcon(self.widget,self.head:getID(),{iconInfo=iconInfo,scale=HEAD_SCALE_TYPE.e60x60})

local regexType=chatInfo.regexType
local regexInfo=chatInfo.regexInfo
if regexType and regexInfo then
local handle=_regexType2Act[regexType]
if handle then
local info=handle.getInfo(regexInfo)

local actName=limitActivitiesModel:getActConfig(handle.actId,"name")
local contentStr
if info.bwFlag and info.bwFlag==1 then
contentStr=FMT.fmt("帮帮我，我正在参加 <color=#ca631d>{0}补位</color>",actName)
else
contentStr=FMT.fmt("帮帮我，我正在参加 <color=#ca631d>{0}</color>",actName)
end
self.content:setText(contentStr)

local jobCfg=cfgHelper.get1(cfg_xianguanconfig_get,info.jobId)
self.flagTx:setText(jobCfg.name)
local icon=chatModel:getSignIcon(jobCfg.chatFlagId)
if icon then
self.flagImg:setImageIcon(icon,false)
end

if handle.jump~=nil then
self.bg:setButtonClick(function()
local shortTime=timeHelper.convertShortStamp(timeStamp)
if info.bwFlag==nil or info.bwFlag==0 then
if not timeHelper.checkInSameWeek4(shortTime)then
UIManager.info("分享时效已过")
return
end
elseif info.bwFlag~=nil and info.bwFlag==1 then

end
handle.jump(timeStamp,info,actorID)
end)
end
else
loggerUtil.logErrFMT("没有处理对应类型regexType：{0}",regexType)
end
end
end


function UIChatRightShareXGJXItem:onHide()

end




function UIChatRightShareXGJXItem:onHeadBg()

end

function UIChatRightShareXGJXItem:onBg()

end

function UIChatRightShareXGJXItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=175
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end
