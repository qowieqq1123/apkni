







def_class("UIChatRightCangBaoGeShareItem",UICloneObject)





UIChatRightCangBaoGeShareItem.abName="ui/windows/chat/child/uichatrightcangbaogeshareitem.ab"

UIChatRightCangBaoGeShareItem.assetName="UIChatRightCangBaoGeShareItem"


function UIChatRightCangBaoGeShareItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.head=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.bg=UIButton.get(self,3)
self.descTx=UIText.get(self,4)
self.symbol=UIImage.get(self,5)
self.item=UIBaseItem.get(self,6)
self.bottombg=UIImage.get(self,7)
self.time=UIText.get(self,8)

self.bg:setButtonClick(function()self:onBg()end)

end


function UIChatRightCangBaoGeShareItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.symbol);self.symbol=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.bottombg);self.bottombg=nil;
_UIObject_release(self.time);self.time=nil;
end









function UIChatRightCangBaoGeShareItem:onLoaded(...)
self:bindComponents()
self.symbol:setSprite(globalABLookup.cangbaotuchat,'image_jiugp_09')
self.bottombg:setSprite(globalABLookup.cangbaotuchat,'frame_jiugp_03')
end


function UIChatRightCangBaoGeShareItem:__delete()
self:unbindComponents()
end




function UIChatRightCangBaoGeShareItem:onShow(argtable,afterOnloaded)
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

local actArgs=chatInfo.actArgs
self.itemId=actArgs.itemId
local itemName=itemsConfig.getColorName(actArgs.itemId)
local actorName=UIManager:invokeUIMethod("UIChatWin","getSelectActorName")
local descStr=FMT.fmt("我分享了{0}给{1}",itemName,actorName or"")
self.descTx:setText(descStr)

local conf={itemid=actArgs.itemId,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.item:setChildPropData(prop)
self.item:setBaseItemClickEvent(function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end


function UIChatRightCangBaoGeShareItem:onHide()

end



function UIChatRightCangBaoGeShareItem:onBg()
UIManager.info(FMT.fmt("祖师分享{0}的信息",itemsConfig.getColorName(self.itemId)))
end

function UIChatRightCangBaoGeShareItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=175
local size=timeY+topY+bottomY+30
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end