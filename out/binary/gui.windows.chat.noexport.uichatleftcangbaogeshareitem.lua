







def_class("UIChatLeftCangBaoGeShareItem",UICloneObject)





UIChatLeftCangBaoGeShareItem.abName="ui/windows/chat/child/uichatleftcangbaogeshareitem.ab"

UIChatLeftCangBaoGeShareItem.assetName="UIChatLeftCangBaoGeShareItem"


function UIChatLeftCangBaoGeShareItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.headBg=UIButton.get(self,1)
self.head=UIObject.get(self,2)
self.name=UIText.get(self,3)
self.time=UIText.get(self,4)
self.bg=UIButton.get(self,5)
self.descTx=UIText.get(self,6)
self.item=UIBaseItem.get(self,7)
self.symbol=UIImage.get(self,8)
self.bottombg=UIImage.get(self,9)

self.headBg:setButtonClick(function()self:onHeadBg()end)

self.bg:setButtonClick(function()self:onBg()end)

end


function UIChatLeftCangBaoGeShareItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.headBg);self.headBg=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.symbol);self.symbol=nil;
_UIObject_release(self.bottombg);self.bottombg=nil;
end









function UIChatLeftCangBaoGeShareItem:onLoaded(...)
self:bindComponents()
self.symbol:setSprite(globalABLookup.cangbaotuchat,'image_jiugp_10')
self.bottombg:setSprite(globalABLookup.cangbaotuchat,'frame_jiugp_04')
end


function UIChatLeftCangBaoGeShareItem:__delete()
self:unbindComponents()
end




function UIChatLeftCangBaoGeShareItem:onShow(argtable,afterOnloaded)
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
widget:SetChildButtonClick(self.headBg:getID(),function()
local attach=nil
if channelId==CHAT_CHANNNEL.eKuafu then attach={serverid=serverId}end
otherPlayerController:openOtherPlayerInfoWin(actorID,nil,nil,attach)
end,true)

local actArgs=chatInfo.actArgs
local itemName=itemsConfig.getColorName(actArgs.itemId)
local descStr=FMT.fmt("{0}给祖师分享了{1}",actorName,itemName)
self.descTx:setText(descStr)

local conf={itemid=actArgs.itemId,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.item:setChildPropData(prop)
self.item:setBaseItemClickEvent(function(...)
itemsComponentHelper.onItemClickEx(...)
end)

self.bg:setButtonClick(function()
local info=activitiesModel:getSubActInfo(actArgs.actId,actArgs.subType,actArgs.subId)
if info==nil or not info:checkDoing()then
UIManager.error("活动已结束")
return
end
local args={
actId=actArgs.actId,
subType=actArgs.subType,
subId=actArgs.subId,
actorId=actArgs.actorId,
itemId=actArgs.itemId,
dzData=actArgs.dzData,
dzImage=actArgs.dzImage,
actorName=actorName,
}
UIManager:showWindow("UISubAct_CangBaoTuSharedTips",args)
end)
end


function UIChatLeftCangBaoGeShareItem:onHide()

end



function UIChatLeftCangBaoGeShareItem:onHeadBg()

end

function UIChatLeftCangBaoGeShareItem:onBg()

end

function UIChatLeftCangBaoGeShareItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=175
local size=timeY+topY+bottomY+30
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end