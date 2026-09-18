







def_class("UIChatRightCangBaoGeSOSItem",UICloneObject)





UIChatRightCangBaoGeSOSItem.abName="ui/windows/chat/child/uichatrightcangbaogesositem.ab"

UIChatRightCangBaoGeSOSItem.assetName="UIChatRightCangBaoGeSOSItem"


function UIChatRightCangBaoGeSOSItem:bindComponents()

self.timeRoot=UIObject.get(self,0)
self.descTx=UIText.get(self,1)
self.symbol=UIImage.get(self,2)
self.item=UIBaseItem.get(self,3)
self.bottombg=UIImage.get(self,4)
self.head=UIObject.get(self,5)
self.name=UIText.get(self,6)
self.bg=UIButton.get(self,7)
self.time=UIText.get(self,8)

self.bg:setButtonClick(function()self:onBg()end)

end


function UIChatRightCangBaoGeSOSItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.symbol);self.symbol=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.bottombg);self.bottombg=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.time);self.time=nil;
end









function UIChatRightCangBaoGeSOSItem:onLoaded(...)
self:bindComponents()
self.symbol:setSprite(globalABLookup.cangbaotuchat,'image_jiugp_12')
self.bottombg:setSprite(globalABLookup.cangbaotuchat,'frame_jiugp_03')
end


function UIChatRightCangBaoGeSOSItem:__delete()
self:unbindComponents()
end




function UIChatRightCangBaoGeSOSItem:onShow(argtable,afterOnloaded)
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
local descStr=FMT.fmt("帮帮我，我需要{0}",itemName)
self.descTx:setText(descStr)

local conf={itemid=actArgs.itemId,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.item:setChildPropData(prop)
self.item:setBaseItemClickEvent(function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end


function UIChatRightCangBaoGeSOSItem:onHide()

end



function UIChatRightCangBaoGeSOSItem:onBg()
UIManager.info(FMT.fmt("祖师求助{0}的信息",itemsConfig.getColorName(self.itemId)))
end

function UIChatRightCangBaoGeSOSItem:freshRect()
self.widget:ForceLayoutVertical(-1)
local timeY=self.timeFlag and 35 or 0
local topY=45
local bottomY=175
local size=timeY+topY+bottomY+30
self.widget:SetChildSizeWithCurrentAnchors(-1,1,size)
end