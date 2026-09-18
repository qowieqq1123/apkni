







def_class("UIWanBaoXunBaoDui_SpeicialWin",UIWindowBase)









function UIWanBaoXunBaoDui_SpeicialWin:bindComponents()

self.root=UIObject.get(self,0)
self.specialityIcon=UIImage.get(self,1)
self.specialityTypeTxt=UIText.get(self,2)
self.specialityDesc=UIText.get(self,3)
self.specialityInfo=UIText.get(self,4)
self.timeObj=UIObject.get(self,5)
self.specialityName=UIText.get(self,6)
self.timeTxt=UIText.get(self,7)
self.additionline=UIObject.get(self,8)
self.specialityAdditionTxt=UIText.get(self,9)
self.specialityNameEx=UIText.get(self,10)



end


function UIWanBaoXunBaoDui_SpeicialWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.specialityIcon);self.specialityIcon=nil;
_UIObject_release(self.specialityTypeTxt);self.specialityTypeTxt=nil;
_UIObject_release(self.specialityDesc);self.specialityDesc=nil;
_UIObject_release(self.specialityInfo);self.specialityInfo=nil;
_UIObject_release(self.timeObj);self.timeObj=nil;
_UIObject_release(self.specialityName);self.specialityName=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.additionline);self.additionline=nil;
_UIObject_release(self.specialityAdditionTxt);self.specialityAdditionTxt=nil;
_UIObject_release(self.specialityNameEx);self.specialityNameEx=nil;
end



















function UIWanBaoXunBaoDui_SpeicialWin:onLoaded(...)
self:bindComponents()
end


function UIWanBaoXunBaoDui_SpeicialWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_SpeicialWin:onShow(argtable,afterOnloaded)
local item=argtable.item
local move_pos=argtable.node

local spid=argtable.spid
local config=cfgHelper.get1(cfg_cattxconfig_get,spid)

if argtable.pivot then
self.root:setChildPivot(argtable.pivot)
end

if item then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.1,function()
self.root:setChildCanvasGroupAlpha(1)
self:showPosition(item,move_pos)
end)
else
self.root:setChildCanvasGroupAlpha(1)
end

self.specialityNameEx:setText(config.name)
self.specialityName:setText(config.name)
local desc=string.replaceSpace(config.desc or'')
local sp_desc=string.replaceSpace(config.sp_desc or'')
self.specialityInfo:setText(desc)

self.specialityTypeTxt:setActive(false)
self.additionline:setActive(config.sp_desc~=nil)
self.specialityDesc:setActive(config.sp_desc~=nil)
self.specialityDesc:setText(sp_desc)

local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(config.frame)
self.specialityIcon:setSprite(abName,frameIcon)

end


function UIWanBaoXunBaoDui_SpeicialWin:onHide()

end

function UIWanBaoXunBaoDui_SpeicialWin:showPosition(item,move_pos)

local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local selfTrans=self.root:getTransform()
local selfSize=selfTrans.sizeDelta

local offsetX=0
local offsetY=0
move_pos=move_pos or'bottom'

if move_pos=='bottom'then
offsetY=-itemSize.y*itemPivot.y
offsetX=-(itemPivot.x-0.5)*itemSize.x
elseif move_pos=='top'then
offsetY=-(itemPivot.y-1)*itemSize.y+selfSize.y
offsetX=-(itemPivot.x-0.5)*itemSize.x
elseif move_pos=='left'then
offsetY=-(itemPivot.y-0.5)*itemSize.y
offsetX=-itemPivot.x*itemSize.x

offsetX=offsetX-selfSize.x/2
offsetY=offsetY+selfSize.y/2
elseif move_pos=='right'then
offsetY=-(itemPivot.y-0.5)*itemSize.y
offsetX=-(itemPivot.x-1)*itemSize.x

offsetX=offsetX+selfSize.x/2
offsetY=offsetY+selfSize.y/2
end
local rootPosX=screenPoint.x+offsetX
local rootPosY=screenPoint.y+offsetY


local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
local itemHeight=selfSize.y
local halfHeight=UnityEngine.Screen.height/scaleFactor.y/2
if rootPosY-itemHeight<-halfHeight then
rootPosY=-halfHeight+itemHeight
end
if rootPosY>halfHeight then
rootPosY=halfHeight
end

self.winlua:SetChildLocalPosition(self.root:getID(),Vector3(rootPosX,rootPosY,0))
end



