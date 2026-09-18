







def_class("UIChatRightShareXMHBItem",UICloneObject)





UIChatRightShareXMHBItem.abName=""

UIChatRightShareXMHBItem.assetName="UIChatRightShareXMHBItem"


function UIChatRightShareXMHBItem:bindComponents()

self.bg=UIButton.get(self,0)
self.black=UIObject.get(self,1)
self.getted=UIText.get(self,2)
self.head=UIObject.get(self,3)
self.name=UIText.get(self,4)
self.noLeast=UIText.get(self,5)
self.normal=UIText.get(self,6)
self.noTime=UIText.get(self,7)
self.overTime=UIText.get(self,8)
self.redpacket=UIImage.get(self,9)
self.time=UIText.get(self,10)
self.timeRoot=UIObject.get(self,11)
self.hbTipsText=UIText.get(self,12)
self.openhbBtn=UIButton.get(self,13)
self.hbInfoBtn=UIButton.get(self,14)

self.bg:setButtonClick(function()self:onBg()end)

self.openhbBtn:setButtonClick(function()self:onOpenhbBtn()end)

self.hbInfoBtn:setButtonClick(function()self:onHbInfoBtn()end)

end


function UIChatRightShareXMHBItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.black);self.black=nil;
_UIObject_release(self.getted);self.getted=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.noLeast);self.noLeast=nil;
_UIObject_release(self.normal);self.normal=nil;
_UIObject_release(self.noTime);self.noTime=nil;
_UIObject_release(self.overTime);self.overTime=nil;
_UIObject_release(self.redpacket);self.redpacket=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.hbTipsText);self.hbTipsText=nil;
_UIObject_release(self.openhbBtn);self.openhbBtn=nil;
_UIObject_release(self.hbInfoBtn);self.hbInfoBtn=nil;
end





local _abName="ui/windows/activities/sub_caishenjiadao/caishenjiadao_atlas_pak.ab"




function UIChatRightShareXMHBItem:onLoaded(...)
self:bindComponents()
self._onXMHBGuildDataChange=function(...)
self:onXMHBGuildDataChange(...)
end
self:addNotify(notifyConfig.onXMHBGuildDataChange,self._onXMHBGuildDataChange)
end


function UIChatRightShareXMHBItem:__delete()
self:unbindComponents()
self.data=nil
self.timeStamp=nil
end




function UIChatRightShareXMHBItem:onShow(argtable,afterOnloaded)
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
self.data=chatEmotHelper.getCSJDInfoByRegex(regexInfo)
self.timeStamp=timeStamp
self:refreshStatus()
end
end


function UIChatRightShareXMHBItem:onHide()

end




function UIChatRightShareXMHBItem:onBg()
local info=activitiesModel:getSubActInfo(self.data.actId,self.data.subType,self.data.subId)
if info==nil or not info:checkDoing()or self.timeStamp<info.start_time_l then
UIManager.error("太晚了，红包已过期")
return
end
local guildData=info:getGuildData(self.data.hbGuid)
if guildData==nil then
UIManager.error("太晚了，红包已过期")
return
end
local nowTime=timeHelper.getServerShortTime()
if nowTime>=guildData.endTime then
UIManager.error("太晚了，红包已过期")
return
end

local args={

act_id=self.data.actId,
sub_act_type=self.data.subType,
sub_act_id=self.data.subId,
guid=guildData.guid,
}
UIManager:showWindow("UISubAct_XMHB_detailWin",args)











end

function UIChatRightShareXMHBItem:refreshStatus()
local info=activitiesModel:getSubActInfo(self.data.actId,self.data.subType,self.data.subId)
if info==nil or not info:checkDoing()or self.timeStamp<info.start_time_l then
self:setOverTimeState()
return
end
local guildData=info:getGuildData(self.data.hbGuid)
if guildData==nil then
self:setOverTimeState()
return
end
local nowTime=timeHelper.getServerShortTime()
if nowTime>=guildData.endTime then
self:setOverTimeState()
return
end



local hbSkinId=guildData.hbSkinId
local hbSkinCfg=cfgHelper.get(cfg_guildhongbao2skinconfig_get,hbSkinId)
self.bg:setSprite(_abName,hbSkinCfg.hbBannerBg)
self.black:setActive(guildData.status~=eXMRedPacketStatus.eNormal and guildData.status~=eXMRedPacketStatus.eGetted)
self.normal:setActive(guildData.status==eXMRedPacketStatus.eNormal)
self.getted:setActive(guildData.status==eXMRedPacketStatus.eGetted)
self.noLeast:setActive(guildData.status==eXMRedPacketStatus.eNotLeast)
self.noTime:setActive(guildData.status==eXMRedPacketStatus.eNotTimes)
self.overTime:setActive(false)
self.redpacket:setSprite(_abName,guildData.status==eXMRedPacketStatus.eNormal and"image_caishenjiadao_7"or"image_caishenjiadao_8")



self.openhbBtn:setActive(false)
self.hbInfoBtn:setActive(false)
end

function UIChatRightShareXMHBItem:setOverTimeState()
self.bg:setSprite(_abName,"image_caishenjiadao_hbdb1")
self.black:setActive(true)
self.normal:setActive(false)
self.getted:setActive(false)
self.noLeast:setActive(false)
self.noTime:setActive(false)
self.overTime:setActive(true)
self.redpacket:setSprite(_abName,"image_caishenjiadao_8")
self.openhbBtn:setActive(false)
self.hbInfoBtn:setActive(false)
end

function UIChatRightShareXMHBItem:onXMHBGuildDataChange(actId,subType,subId,guid,reSort)
if self.data.actId==actId and self.data.subType==subType and self.data.subId==subId and(self.data.hbGuid==guid or guid==nil)then
self:refreshStatus()
end
end

function UIChatRightShareXMHBItem:onSubActivityStateChange(actId,subType,subId)
if self.data.actId==actId and self.data.subType==subType and self.data.subId==subId then
self:refreshStatus()
end
end


function UIChatRightShareXMHBItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=115
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end


function UIChatRightShareXMHBItem:onOpenhbBtn()
return self:onBg()
end

function UIChatRightShareXMHBItem:onHbInfoBtn()
return self:onBg()
end
