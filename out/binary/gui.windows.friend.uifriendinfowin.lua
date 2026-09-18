







def_class("UIFriendInfoWin",UIWindowBase)









function UIFriendInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.name=UIText.get(self,1)
self.fight=UIText.get(self,2)
self.zmName=UIText.get(self,3)
self.closeButton=UIButton.get(self,4)
self.chatBtn=UIButton.get(self,5)
self.viewBtn=UIButton.get(self,6)
self.addPartyBtn=UIButton.get(self,7)
self.deleteBtn=UIButton.get(self,8)
self.addFriendBtn=UIButton.get(self,9)
self.blackBtn=UIButton.get(self,10)
self.removeblackBtn=UIButton.get(self,11)
self.level=UIText.get(self,12)
self.head=UIObject.get(self,13)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIFriendInfoWin")end)

self.chatBtn:setButtonClick(function()self:onChatBtn()end)

self.viewBtn:setButtonClick(function()self:onViewBtn()end)

self.addPartyBtn:setButtonClick(function()self:onAddPartyBtn()end)

self.deleteBtn:setButtonClick(function()self:onDeleteBtn()end)

self.addFriendBtn:setButtonClick(function()self:onAddFriendBtn()end)

self.blackBtn:setButtonClick(function()self:onBlackBtn()end)

self.removeblackBtn:setButtonClick(function()self:onRemoveblackBtn()end)



end


function UIFriendInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.fight);self.fight=nil;
_UIObject_release(self.zmName);self.zmName=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.chatBtn);self.chatBtn=nil;
_UIObject_release(self.viewBtn);self.viewBtn=nil;
_UIObject_release(self.addPartyBtn);self.addPartyBtn=nil;
_UIObject_release(self.deleteBtn);self.deleteBtn=nil;
_UIObject_release(self.addFriendBtn);self.addFriendBtn=nil;
_UIObject_release(self.blackBtn);self.blackBtn=nil;
_UIObject_release(self.removeblackBtn);self.removeblackBtn=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.head);self.head=nil;
end

















local _pos=
{
[eWatchFriendFromType.eChatWin]=300
}


function UIFriendInfoWin:onLoaded(...)
self:bindComponents()
end


function UIFriendInfoWin:__delete()
self:unbindComponents()
end




function UIFriendInfoWin:onShow(argtable,afterOnloaded)
self:updateData(argtable)
self:refreshUI()
end


function UIFriendInfoWin:onHide()

end






function UIFriendInfoWin:updateData(argtable)
self.actorId=argtable.actorId
local dataType=nil
if argtable.dataType then
self.info=friendModel:getFromList(argtable.dataType,self.actorId)
else
self.info,dataType=friendModel:getActorInfo(self.actorId)
end
self.dataType=argtable.dataType or dataType
if self.info==nil then
self.info=self.info or argtable.info
self.dataType=eFriendDataType.eAddable
end
self.formType=argtable.formType

if self.dataType==eFriendDataType.eApply then

self.deleteBtn:setActive(false)
elseif self.dataType==eFriendDataType.eAddable then
self.deleteBtn:setActive(false)
self.addFriendBtn:setActive(true)
elseif self.dataType==eFriendDataType.eBlack then
self.chatBtn:setActive(false)
self.deleteBtn:setActive(false)
self.blackBtn:setActive(false)
self.removeblackBtn:setActive(true)
end
if self.formType then
local pos=_pos[self.formType]
if pos then
self.winlua:SetChildLocalPosX(self.root:getID(),pos)
end
end
end




function UIFriendInfoWin:refreshUI()
self:refreshInfo()
self:refreshBtns()
end


function UIFriendInfoWin:refreshInfo()

self.name:setText(self.info.playerName)

self.fight:setText(self.info.fight or 0)

self.zmName:setText(self.info.zmName==""and"无"or self.info.zmName)

self.level:setText(self.info.zmLevel or 0)








playerController:setHeadIcon(self.winlua,self.head:getID(),{iconInfo=self.info.iconInfo})
end


function UIFriendInfoWin:refreshBtns()

end




function UIFriendInfoWin:onChatBtn()
local formType
if self.dataType==eFriendDataType.eLocal or self.dataType==eFriendDataType.eCross then
formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend
else
formType=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent
end
local info=self.info
local actorInfo=chatActorInfo.convertByFriendInfo(info)

local args=
{
channelId=CHAT_CHANNNEL.ePrivate,
actorInfo=actorInfo,
formType=formType,
}
UIManager:showWindow('UIChatWin',args)
self:closeSelf()
end


function UIFriendInfoWin:onViewBtn()
end


function UIFriendInfoWin:onDeleteBtn()

local playerIdList={self.actorId}
friendProtocolController.req_remove_friend(playerIdList)
self:closeSelf()
end


function UIFriendInfoWin:onBlackBtn()
local data=self.info
local myServerID=playerModel:getActorServerID()
if data.serverId~=myServerID then
friendProtocolController.req_black_kuafu_list(data.serverId,data.actorId,data.iconInfo,data.playerName,data.zmLevel,data.zmName)
else
friendProtocolController.req_black_list(eFriendBlackOper.eAdd,self.actorId)
end
self:closeSelf()
end


function UIFriendInfoWin:onRemoveblackBtn()
friendProtocolController.req_black_list(eFriendBlackOper.eRemove,self.actorId)
self:closeSelf()
end


function UIFriendInfoWin:onAddPartyBtn()

end


function UIFriendInfoWin:onAddFriendBtn()
local data=self.info
local playerIdList={data.actorId}
local friendType=data.crossServerName==""and eFriendListType.eLocal or eFriendListType.eCross

if data.sqFlag~=1 then
friendProtocolController.req_add_friend(friendType,playerIdList)
self:closeSelf()
else
UIManager.info("已发送")
end
end
