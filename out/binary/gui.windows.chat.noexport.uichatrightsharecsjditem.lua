







def_class("UIChatRightShareCSJDItem",UICloneObject)





UIChatRightShareCSJDItem.abName=""

UIChatRightShareCSJDItem.assetName="UIChatRightShareCSJDItem"


function UIChatRightShareCSJDItem:bindComponents()

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

self.bg:setButtonClick(function()self:onBg()end)

end


function UIChatRightShareCSJDItem:unbindComponents()
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
end





local _abName="ui/windows/activities/sub_caishenjiadao/caishenjiadao_atlas_pak.ab"



function UIChatRightShareCSJDItem:onLoaded(...)
self:bindComponents()
self._onCSJDGuildDataChange=function(...)
self:onCSJDGuildDataChange(...)
end
self:addNotify(notifyConfig.onCSJDGuildDataChange,self._onCSJDGuildDataChange)
end


function UIChatRightShareCSJDItem:__delete()
self:unbindComponents()
self.data=nil
self.timeStamp=nil
end




function UIChatRightShareCSJDItem:onShow(argtable,afterOnloaded)
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


function UIChatRightShareCSJDItem:onHide()

end




function UIChatRightShareCSJDItem:onBg()
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

if guildData.status==eCSJDRedPacketStatus.eNormal then
call_activitiesHandle_func("activitiesHandle_caishenjiadao","reqReceiveRedPacket",info.act_id,info.sub_act_id,guildData.guid)
elseif guildData.status==eCSJDRedPacketStatus.eGetted then
UIManager.error("红包已领取")
elseif guildData.status==eCSJDRedPacketStatus.eNotTimes then
UIManager.error("本日红包领取次数已达到上限")
elseif guildData.status==eCSJDRedPacketStatus.eNotLeast then
UIManager.error("红包已领完")
end
end

function UIChatRightShareCSJDItem:refreshStatus()
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

local hb_conf=info:getSubActConfig("hb_conf",guildData.id)
local bless_conf=hb_conf.blessing[guildData.bless]
self.bg:setSprite(_abName,bless_conf[4])
self.black:setActive(guildData.status~=eCSJDRedPacketStatus.eNormal and guildData.status~=eCSJDRedPacketStatus.eGetted)
self.normal:setActive(guildData.status==eCSJDRedPacketStatus.eNormal)
self.getted:setActive(guildData.status==eCSJDRedPacketStatus.eGetted)
self.noLeast:setActive(guildData.status==eCSJDRedPacketStatus.eNotLeast)
self.noTime:setActive(guildData.status==eCSJDRedPacketStatus.eNotTimes)
self.overTime:setActive(false)
self.redpacket:setSprite(_abName,guildData.status==eCSJDRedPacketStatus.eNormal and"image_caishenjiadao_7"or"image_caishenjiadao_8")
end

function UIChatRightShareCSJDItem:setOverTimeState()
self.bg:setSprite(_abName,"image_caishenjiadao_hbdb1")
self.black:setActive(true)
self.normal:setActive(false)
self.getted:setActive(false)
self.noLeast:setActive(false)
self.noTime:setActive(false)
self.overTime:setActive(true)
self.redpacket:setSprite(_abName,"image_caishenjiadao_8")
end

function UIChatRightShareCSJDItem:onCSJDGuildDataChange(actId,subType,subId,guid,reSort)
if self.data.actId==actId and self.data.subType==subType and self.data.subId==subId and reSort and(self.data.hbGuid==guid or guid==nil)then
self:refreshStatus()
end
end

function UIChatRightShareCSJDItem:onSubActivityStateChange(actId,subType,subId)
if self.data.actId==actId and self.data.subType==subType and self.data.subId==subId then
self:refreshStatus()
end
end


function UIChatRightShareCSJDItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=115
local size=timeY+topY+bottomY+50
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end
