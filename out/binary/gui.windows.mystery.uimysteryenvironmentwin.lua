







def_class("UIMysteryEnvironmentWin",UIWindowBase)









function UIMysteryEnvironmentWin:bindComponents()

self.root=UIObject.get(self,0)
self.specialityIcon=UIImage.get(self,1)
self.specialityDesc=UIText.get(self,2)
self.specialityInfo=UIText.get(self,3)
self.specialityName=UIText.get(self,4)



end


function UIMysteryEnvironmentWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.specialityIcon);self.specialityIcon=nil;
_UIObject_release(self.specialityDesc);self.specialityDesc=nil;
_UIObject_release(self.specialityInfo);self.specialityInfo=nil;
_UIObject_release(self.specialityName);self.specialityName=nil;
end



















function UIMysteryEnvironmentWin:onLoaded(...)
self:bindComponents()
end


function UIMysteryEnvironmentWin:__delete()
self:unbindComponents()
end




function UIMysteryEnvironmentWin:onShow(argtable,afterOnloaded)
local item=argtable.item
local move_pos=argtable.node
local config=argtable.config


if item then
self:showPosition(item,move_pos)
end


if config then
local name=UIDiscipleModel.getSpecialityNameStr(config.name)
self.specialityName:setText(name)
self.specialityDesc:setText(config.desc or'')
end
end


function UIMysteryEnvironmentWin:onHide()

end

function UIMysteryEnvironmentWin:showPosition(item,move_pos)

local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local selfTrans=self.root:getTransform()
local selfSize=selfTrans.sizeDelta

local itemOffx=0
local itemOffy=0
local offsetX=0
local offsetY=0
move_pos=move_pos or'bottom'
if move_pos=='bottom'or move_pos=='top'then
if itemPivot.x~=0.5 then
itemOffx=itemPivot.x==0 and itemSize.x/2 or-itemSize.x/2
end
offsetX=itemOffx
elseif move_pos=='left'or move_pos=='right'then
if itemPivot.y~=0.5 then
itemOffy=itemPivot.y==0 and itemSize.y/2 or-itemSize.y/2
end
offsetY=itemOffy
end

if move_pos=='bottom'then
if itemPivot.y~=0 then
itemOffy=itemPivot.y==0.5 and-itemSize.y/2 or-itemSize.y
end
offsetY=-selfSize.y/2+itemOffy
elseif move_pos=='top'then
if itemPivot.y~=1 then
itemOffy=itemPivot.y==0.5 and itemSize.y/2 or itemSize.y
end
offsetY=selfSize.y/2+itemOffy
elseif move_pos=='left'then
if itemPivot.x~=0 then
itemOffx=itemPivot.x==0.5 and-itemSize.x/2 or-itemSize.x
end
offsetX=-selfSize.x/2+itemOffx
elseif move_pos=='right'then
if itemPivot.x~=1 then
itemOffx=itemPivot.x==0.5 and itemSize.x/2 or itemSize.x
end
offsetX=selfSize.x/2+itemOffx
end
local rootPosX=screenPoint.x+offsetX
local rootPosY=screenPoint.y+offsetY

self.winlua:SetChildLocalPosition(self.root:getID(),Vector3(rootPosX,rootPosY,0))
end


