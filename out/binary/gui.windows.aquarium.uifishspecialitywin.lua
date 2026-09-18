







def_class("UIFishSpecialityWin",UIWindowBase)









function UIFishSpecialityWin:bindComponents()

self.root=UIObject.get(self,0)
self.posBL=UIObject.get(self,1)
self.posTR=UIObject.get(self,2)
self.specialityIcon=UIImage.get(self,3)
self.specialityTypeTxt=UIText.get(self,4)
self.specialityInfo=UIText.get(self,5)
self.specialityDesc=UIText.get(self,6)
self.specialityName=UIText.get(self,7)
self.info=UIObject.get(self,8)
self.specialityNameEx=UIText.get(self,9)



end


function UIFishSpecialityWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.posBL);self.posBL=nil;
_UIObject_release(self.posTR);self.posTR=nil;
_UIObject_release(self.specialityIcon);self.specialityIcon=nil;
_UIObject_release(self.specialityTypeTxt);self.specialityTypeTxt=nil;
_UIObject_release(self.specialityInfo);self.specialityInfo=nil;
_UIObject_release(self.specialityDesc);self.specialityDesc=nil;
_UIObject_release(self.specialityName);self.specialityName=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.specialityNameEx);self.specialityNameEx=nil;
end



















function UIFishSpecialityWin:onLoaded(...)
self:bindComponents()
end


function UIFishSpecialityWin:__delete()
self:unbindComponents()
end




function UIFishSpecialityWin:onShow(argtable,afterOnloaded)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(argtable.color)
self.root:setChildCanvasGroupAlpha(0)
self.specialityNameEx:setText(argtable.name)
self.specialityName:setText(argtable.name)
self.specialityDesc:setText(argtable.desc or'')
self.specialityTypeTxt:setText(argtable.type)
self.specialityIcon:setSprite(abName,frameIcon)
self.specialityInfo:setText(argtable.info)

self:delayDo(0.001,function()
self:refresh(argtable)
end)
end

function UIFishSpecialityWin:refresh(argtable)
local widget=argtable.target
if widget then
local stype=argtable.stype
self:autoSetPos(widget,stype)

local cpos=self.root:getChildLocalPosition()
if stype==1 then
local width=self.info:getChildSizeDeltaX()
local tpos=self.posBL:getChildLocalPosition()
if(cpos.x-width)<tpos.x then
self:autoSetPos(widget,2)
end
elseif stype==2 then
local width=self.info:getChildSizeDeltaX()
local tpos=self.posTR:getChildLocalPosition()
if(cpos.x+width)>tpos.x then
self:autoSetPos(widget,1)
end
elseif stype==3 then
local height=self.info:getChildSizeDeltaY()
local tpos=self.posTR:getChildLocalPosition()
if(cpos.y+height)>tpos.y then
self:autoSetPos(widget,4)
end
elseif stype==4 then
local height=self.info:getChildSizeDeltaY()
local tpos=self.posBL:getChildLocalPosition()
if(cpos.y-height)<tpos.y then
self:autoSetPos(widget,3)
end
end
end

self.root:setChildCanvasGroupAlpha(1)
end

function UIFishSpecialityWin:autoSetPos(widget,stype)
local width=widget:GetChildSizeDeltaX(-1)
local height=widget:GetChildSizeDeltaY(-1)

local pivot
local offset={0,0}
if stype==1 then
pivot=Vector2.New(1,0.5)
offset[1]=-width/2-5
elseif stype==2 then
pivot=Vector2.New(0,0.5)
offset[1]=width/2+5
elseif stype==3 then
pivot=Vector2.New(0.5,0)
offset[2]=height/2+5
elseif stype==4 then
pivot=Vector2.New(0.5,1)
offset[2]=-height/2-5
end
self.info:setChildPivot(pivot)
local wpos=widget:GetChildPosition(-1)
self.root:setChildPosition(wpos)
local apos=self.root:getChildAnchoredPosition()
apos.x=apos.x+offset[1]
apos.y=apos.y+offset[2]
self.root:setChildAnchoredPosition(apos)
end


function UIFishSpecialityWin:onHide()

end



