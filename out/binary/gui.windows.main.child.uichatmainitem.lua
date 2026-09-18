







def_class("UIChatMainItem",UICloneObject)





UIChatMainItem.abName="ui/windows/main/child/uichatmainitem.ab"

UIChatMainItem.assetName="UIChatMainItem"


function UIChatMainItem:bindComponents()

self.mesg=UILinkImageText.get(self,0)
self.mesgCopy=UILinkImageText.get(self,1)
self.UIChatMainItem=UIObject.get(self,2)
self.bg1=UIObject.get(self,3)
self.bg2=UIObject.get(self,4)

end


function UIChatMainItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mesg);self.mesg=nil;
_UIObject_release(self.mesgCopy);self.mesgCopy=nil;
_UIObject_release(self.UIChatMainItem);self.UIChatMainItem=nil;
_UIObject_release(self.bg1);self.bg1=nil;
_UIObject_release(self.bg2);self.bg2=nil;
end








function UIChatMainItem:onLoaded(...)
self:bindComponents()
CS.BindWidget(self.widget,self)
self:setChildCanvasGroupAlpha(self.UIChatMainItem:getID(),0)
self.mesg:setLinkImageClickAction(function()
self:clickBg()
end)
end

function UIChatMainItem:__delete()
self.mesg:setLinkImageClickAction(nil)
self.mesg:setLinkImageTextReset()
self:unbindComponents()
self.isPlayAni=nil
end

function UIChatMainItem:onShow(argtable,afterOnloaded)
self:delayDo(2,function()
self:setChildAnimatorEnable(self.UIChatMainItem:getID(),false)
self.mesgCopy:setActive(false)
end)
local chatInfo=argtable
if chatInfo.msgID==0 then return end
local channelId=chatInfo.channelId
local timeStamp=chatInfo.timeStamp
local isVoice=chatInfo.isVoice
local msgType=chatInfo.msgType
local mesg=chatInfo.mesg
local actorInfo=chatInfo.actorInfo or{}
local actorID=actorInfo.actorId
local actorName=actorInfo.actorName or''
local actorLevel=actorInfo.actorLevel
local serverId=actorInfo.serverId
local headId=actorInfo.headId
local kuangId=actorInfo.kuangId
local isSelf=chatInfo:isSelfActor()
local isSystemMesg=msgType==CHAT_MESSAGE_TYPE.eSystem
local isJianwenChannel=channelId==CHAT_CHANNNEL.eJianwen
local channelName=CHAT_CHANNNEL_NAME[channelId]
local isBigEmot=chatEmotHelper.containsBigEmot(mesg)
local isShareDiscipleInfo=chatEmotHelper.containsShareDiscipleInfo(chatInfo)
local actArgs=chatInfo.actArgs
local regexType=chatInfo.regexType

if isBigEmot then
local packageId,emotid,defineDesc,type=chatEmotHelper.decodeBigEmot(mesg)
local isDefineEmot=chatEmotHelper.isDefineEmot(packageId)
if isDefineEmot then
local emotConfig=chatConfig.getDefineEmotConfigById(emotid)
mesg='【自定义表情】'
else



local emotConfig=chatConfig.getBigEmotConfigById(emotid)
mesg=emotConfig.content
end
elseif actArgs then
mesg=chatActivityHelper:getMainItemDesc(actArgs,isSelf)or'【活动信息】'
elseif isShareDiscipleInfo then
local str="[弟子信息]"
mesg=FMT.cfmt(FONT_COLOR.eNomalGrayColor,'{0}',str)
elseif regexType then
local str=''
if regexType==CHAT_REGEX_TYPE.eQieCuo then
str="[弟子切磋信息]"
elseif regexType==CHAT_REGEX_TYPE.eShareLXWJ then
str="[仙盟战战绩]"
elseif regexType==CHAT_REGEX_TYPE.eTianMoRuQin then
str="[天魔入侵分享]"
elseif regexType==CHAT_REGEX_TYPE.eTianMoJie then
str="[天魔劫分享]"
elseif regexType==CHAT_REGEX_TYPE.eZZSHPosShare then
str="[坐标分享]"
elseif regexType==CHAT_REGEX_TYPE.csFairyLand then
str="[坐标分享]"
elseif regexType==CHAT_REGEX_TYPE.csFairyLandHelp then
str="[求援分享]"
elseif regexType==CHAT_REGEX_TYPE.csOfficerElectionHelp then
str="[文选求援]"
elseif regexType==CHAT_REGEX_TYPE.csOfficerElection2Help then
str="[武选分享]"
elseif regexType==CHAT_REGEX_TYPE.csPuTongZhenJi then
str="[坐标分享]"
end
mesg=FMT.cfmt(FONT_COLOR.eNomalGrayColor,'{0}',str)
end
local name=FMT.cfmt(FONT_COLOR.eGreenColor,'{0}',isSystemMesg and''or
not isSelf and FMT.cfmt(FONT_COLOR.eOrangeColor,'[{0}] ',actorName)or
FMT.cfmt(FONT_COLOR.eGreenColor,'[我] '))



local desc=mesg
local txt=FMT.fmt('[{0}] {1}{2}',channelName,name,desc)
self.channelId=channelId
self.mesgCopy:setActive(true)
self.mesg:setText(txt)
self.mesgCopy:setText(txt)
self.bg1:setActive(not isSelf)
self.bg2:setActive(isSelf)
end

function UIChatMainItem:onHide()

end


function UIChatMainItem:playAni()
local pos=self:getChildLocalPosition(self.mesg:getID())
self:setChildLocalPosY(self.mesgCopy:getID(),pos.y)
self:setChildCanvasGroupAlpha(self.UIChatMainItem:getID(),1)

self:setChildAnimatorInteger(self.UIChatMainItem:getID(),'int',self.isPlayAni and 2 or 1,true)
self.isPlayAni=true
end

function UIChatMainItem:clickBg()
local _channelId=self.channelId
UIManager:showWindow('UIChatWin')
end

