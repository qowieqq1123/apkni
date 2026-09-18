







def_class("UIChatDefineEditorChildItem",UICloneObject)





UIChatDefineEditorChildItem.abName="ui/windows/chat/child/uichatdefineeditorchilditem.ab"

UIChatDefineEditorChildItem.assetName="UIChatDefineEditorChildItem"


function UIChatDefineEditorChildItem:bindComponents()

self.click=UIButton.get(self,0)
self.emotcon=UIImage.get(self,1)
self.spritePlayer=UIObject.get(self,2)
self.demandRoot=UIObject.get(self,3)
self.bg=UIObject.get(self,4)
self.demand=UIText.get(self,5)
self.desc=UIText.get(self,6)

self.click:setButtonClick(function()self:onClick()end)

end


function UIChatDefineEditorChildItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.emotcon);self.emotcon=nil;
_UIObject_release(self.spritePlayer);self.spritePlayer=nil;
_UIObject_release(self.demandRoot);self.demandRoot=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.demand);self.demand=nil;
_UIObject_release(self.desc);self.desc=nil;
end








function UIChatDefineEditorChildItem:onLoaded(...)
self:bindComponents()
end

function UIChatDefineEditorChildItem:__delete()
self:unbindComponents()
end

function UIChatDefineEditorChildItem:onShow(argtable,afterOnloaded)
local defineEmotConfig=argtable
local emotid=defineEmotConfig.id
self.emotid=emotid
local size=defineEmotConfig.size
local unlock=defineEmotConfig.unlock
local position=defineEmotConfig.position
local assetname=defineEmotConfig.assetname
local iconname=iconHelper.getBigEmotIcon(defineEmotConfig.icon)
self.widget:SetChildLocalPos(self.bg:getID(),position[1],position[2],0)
self.widget:SetChildSizeDelta(self.bg:getID(),size[1],size[2])
self.desc:setText('')
self.emotcon:setImageIcon(iconname,true)
local isUnlock=chatEmotHelper.isEnoughUnlock(emotid)
self.demandRoot:setActive(not isUnlock)
self.emotcon:setImageExGray(not isUnlock)
if not isUnlock then
local unlockType=unlock[1]
local val=unlock[2]
local demandTxt=''
if CHAT_EMOT_UNLOCK_CND_TYPE.eZongmenLv==unlockType then
demandTxt=FMT.fmt('宗门{0}级解锁',val)
end
self.demandTxt=demandTxt
self.demand:setText(demandTxt)
else
self.demandTxt=''
self.demand:setText('')
end
end

function UIChatDefineEditorChildItem:onHide()

end




function UIChatDefineEditorChildItem:onClick()
if self.demandTxt and self.demandTxt~=''then
UIManager.error(self.demandTxt)
return
end
if chatEmotHelper.isMaxDefineEmot()then
UIManager.error('自定义表情已达到上限')
return
end
UIManager:showWindow('UIChatDefineEmotDetailEditorPanel',self.emotid)
end