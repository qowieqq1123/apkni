







def_class("UIMingYuanZhuSha_LingLiEffectPartWin",UIWindowBase)









function UIMingYuanZhuSha_LingLiEffectPartWin:bindComponents()

self.centerLayout=UIObject.get(self,0)
self.effectTxt=UIText.get(self,1)
self.mask=UIButton.get(self,2)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIMingYuanZhuSha_LingLiEffectPartWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.effectTxt);self.effectTxt=nil;
_UIObject_release(self.mask);self.mask=nil;
end



















function UIMingYuanZhuSha_LingLiEffectPartWin:onLoaded(...)
self:bindComponents()
end


function UIMingYuanZhuSha_LingLiEffectPartWin:__delete()
self:unbindComponents()
end




function UIMingYuanZhuSha_LingLiEffectPartWin:onShow(argtable,afterOnloaded)
local llPercentVal=argtable.llPercentVal

local item=argtable.item
local move_pos=argtable.node

if item then
self:showPosition(item,move_pos)
end

local discount=myzsModel:getFightDiscountForLingLi(llPercentVal)
local txt=myzsModel:getLingLiFightDefEffectDesc(discount)or"暂无效果影响"
self.effectTxt:setText(txt)
end


function UIMingYuanZhuSha_LingLiEffectPartWin:onHide()

end

function UIMingYuanZhuSha_LingLiEffectPartWin:showPosition(item,move_pos)

local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local selfTrans=self.centerLayout:getTransform()
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

rootPosY=rootPosY+130

self.winlua:SetChildLocalPosition(self.centerLayout:getID(),Vector3(rootPosX,rootPosY,0))
end





function UIMingYuanZhuSha_LingLiEffectPartWin:onMask()
self:closeSelf()
end

