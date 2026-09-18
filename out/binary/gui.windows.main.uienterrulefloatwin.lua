







def_class("UIEnterRuleFloatWin",UIWindowBase)









function UIEnterRuleFloatWin:bindComponents()

self.root=UIObject.get(self,0)
self.ruleTxt=UIText.get(self,1)
self.uiRoot=UIObject.get(self,2)



end


function UIEnterRuleFloatWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleTxt);self.ruleTxt=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIEnterRuleFloatWin:onLoaded(...)
self:bindComponents()
end


function UIEnterRuleFloatWin:__delete()
self:unbindComponents()
end




function UIEnterRuleFloatWin:onShow(argtable,afterOnloaded)

local ruleStr=argtable.ruleStr

self.ruleTxt:setText(ruleStr)


local canvasIdx=argtable.canvasIdx
if canvasIdx then
self:setCanvasIndex(-1,canvasIdx)
end

if argtable.pivot then
self.root:setChildPivot(argtable.pivot)
end

local item=argtable.item
if item then
self.customPos=true
self:showPosition(item,argtable.move_pos)
end
end


function UIEnterRuleFloatWin:onHide()

end

function UIEnterRuleFloatWin:showPosition(item,move_pos)

local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local selfTrans=self.root:getTransform()
local selfSize=selfTrans.sizeDelta
local selfPivot=selfTrans.pivot

local offsetX=0
local offsetY=0
move_pos=move_pos or'top'

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
offsetY=-(itemPivot.y-1)*itemSize.y
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



