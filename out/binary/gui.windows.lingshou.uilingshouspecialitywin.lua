







def_class("UILingShouSpecialityWin",UIWindowBase)









function UILingShouSpecialityWin:bindComponents()

self.additionline=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.sixuObj=UIObject.get(self,2)
self.sixuObjTxt=UIText.get(self,3)
self.specialityAdditionTxt=UIText.get(self,4)
self.specialityDesc=UIText.get(self,5)
self.specialityIcon=UIImage.get(self,6)
self.specialityInfo=UIText.get(self,7)
self.specialityName=UIText.get(self,8)
self.specialityNameEx=UIText.get(self,9)
self.specialityTypeTxt=UIText.get(self,10)
self.timeObj=UIObject.get(self,11)
self.timeTxt=UIText.get(self,12)



end


function UILingShouSpecialityWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.additionline);self.additionline=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sixuObj);self.sixuObj=nil;
_UIObject_release(self.sixuObjTxt);self.sixuObjTxt=nil;
_UIObject_release(self.specialityAdditionTxt);self.specialityAdditionTxt=nil;
_UIObject_release(self.specialityDesc);self.specialityDesc=nil;
_UIObject_release(self.specialityIcon);self.specialityIcon=nil;
_UIObject_release(self.specialityInfo);self.specialityInfo=nil;
_UIObject_release(self.specialityName);self.specialityName=nil;
_UIObject_release(self.specialityNameEx);self.specialityNameEx=nil;
_UIObject_release(self.specialityTypeTxt);self.specialityTypeTxt=nil;
_UIObject_release(self.timeObj);self.timeObj=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
end



















function UILingShouSpecialityWin:onLoaded(...)
self:bindComponents()
end


function UILingShouSpecialityWin:__delete()
self:unbindComponents()
end




function UILingShouSpecialityWin:onShow(argtable,afterOnloaded)
local item=argtable.item
local move_pos=argtable.node
local guid=argtable.guid
local guidNetData=argtable.guidNetData
local config=argtable.config
local name=argtable.name or config.name
local specialityList=argtable.specialityList

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

self.isGuoFu=pfwindowslController:checkIsGameVersion_guofu()

if config then
self.specialityNameEx:setText(name)
self.specialityName:setText(name)
local effects_desc=config.effects_desc or''
if not self.isGuoFu and config.effects_desc_overseas then
local gameversion=pfwindowslController:getGameVersion()
effects_desc=config.effects_desc_overseas[gameversion]or config.effects_desc_overseas[2]
end
self.specialityDesc:setText(effects_desc)
self.specialityTypeTxt:setText("【特性】")

local abName,frameIcon=lingshouModel.getSpecialityColorFrame(config.framecolor)
self.specialityIcon:setSprite(abName,frameIcon)


local effect_adddesc=config.effects_adddesc
local infoStr=''
if effect_adddesc then
local effectDescList=effect_adddesc
if effectDescList then
infoStr=table.concat(effectDescList,"\n")
end
end
self.specialityInfo:setText(infoStr)

self.additionline:setActive(false)
self.specialityAdditionTxt:setActive(false)
end
end


function UILingShouSpecialityWin:onHide()

end


function UILingShouSpecialityWin:clearTimeDescTimer()






end

function UILingShouSpecialityWin:refreshTimeDesc()










end


function UILingShouSpecialityWin:showPosition(item,move_pos)

local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local selfTrans=self.root:getTransform()
local selfSize=selfTrans.sizeDelta
local selfPivot=selfTrans.pivot

local offsetX=0
local offsetY=0
move_pos=move_pos or'bottom'

if move_pos=='bottom'then
offsetY=-itemSize.y*itemPivot.y
offsetX=-(itemPivot.x-0.5)*itemSize.x
elseif move_pos=='top'then
offsetY=-(itemPivot.y-1)*itemSize.y
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
local itemWidth=selfSize.x
local itemHeight=selfSize.y
local halfWidth=UnityEngine.Screen.width/scaleFactor.x/2
local halfHeight=UnityEngine.Screen.height/scaleFactor.y/2

if rootPosX-itemWidth*(selfPivot.x)<-halfWidth then
rootPosX=-halfWidth+itemWidth*(selfPivot.x)
end

if rootPosX+itemWidth*(1-selfPivot.x)>halfWidth then
rootPosX=halfWidth-itemWidth*(1-selfPivot.x)
end

if rootPosY-itemHeight*(selfPivot.y)<-halfHeight then
rootPosY=-halfHeight+itemHeight*(selfPivot.y)
end

if rootPosY+itemHeight*(1-selfPivot.y)>halfHeight then
rootPosY=halfHeight-itemHeight*(1-selfPivot.y)
end

self.winlua:SetChildLocalPosition(self.root:getID(),Vector3(rootPosX,rootPosY,0))
end


