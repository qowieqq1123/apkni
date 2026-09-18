







def_class("UIChatDefineEmotInfoPanel",UIWindowBase)









function UIChatDefineEmotInfoPanel:bindComponents()

self.root=UIObject.get(self,0)
self.desc=UIText.get(self,1)
self.descBg=UIObject.get(self,2)
self.icon=UIImage.get(self,3)
self.btnTop=UIButton.get(self,4)
self.btnDelete=UIButton.get(self,5)
self.spritePlayer=UIObject.get(self,6)

self.btnTop:setButtonClick(function()self:onBtnTop()end)

self.btnDelete:setButtonClick(function()self:onBtnDelete()end)



end


function UIChatDefineEmotInfoPanel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.btnTop);self.btnTop=nil;
_UIObject_release(self.btnDelete);self.btnDelete=nil;
_UIObject_release(self.spritePlayer);self.spritePlayer=nil;
end


















function UIChatDefineEmotInfoPanel:onLoaded(...)
self:bindComponents()
end

function UIChatDefineEmotInfoPanel:__delete()
self:unbindComponents()
end

function UIChatDefineEmotInfoPanel:onShow(argtable,afterOnloaded)
local emotguid=argtable[1]
local posx=argtable[2]
local posy=argtable[3]
self.emotguid=emotguid
local emotInfo=chatEmotModel.getDefineEmotInfo(emotguid)
local emotid=emotInfo.param_2
local emotConfig=chatConfig.getDefineEmotConfigById(emotid)
local position=emotConfig.position
local size=emotConfig.size
local assetname=emotConfig.assetname
self.widget:SetChildLocalPos(self.descBg:getID(),position[1],position[2],0)
self.widget:SetChildSizeDelta(self.descBg:getID(),size[1],size[2])
self.desc:setText(chatEmotModel.getDefineEmotDesc(emotguid))
if assetname then
self.widget:SetChildAnimationStringID(self.spritePlayer:getID(),assetname,true)
else
self.icon:setImageIcon(iconHelper.getBigEmotIcon(emotid),true)
end
self.root:setChildUIScreenPosWithOffset(posx,posy,40,5)
end

function UIChatDefineEmotInfoPanel:onHide()

end



function UIChatDefineEmotInfoPanel:onBtnTop()
chatEmotControl.sendTopDefineEmot(self.emotguid)
self:closeSelf()
end

function UIChatDefineEmotInfoPanel:onBtnDelete()
local emotguid=self.emotguid
local func=function()
chatEmotControl.sendDeleteDefineEmot({emotguid})
if self and not self.isClose then
self:closeSelf()
end
end
self.dialogue=UIDialogManager.getConfirmDialog(self.dialogue,'提示','是否删除选中表情？')
self.dialogue.okcallback=func
self.dialogue:show()
end