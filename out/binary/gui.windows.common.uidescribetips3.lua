







def_class("UIDescribeTips3",UIWindowBase)









function UIDescribeTips3:bindComponents()

self.root=UIObject.get(self,0)
self.titleTxt=UIText.get(self,1)
self.itemGreator=UIObject.get(self,2)



end


function UIDescribeTips3:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.itemGreator);self.itemGreator=nil;
end

















function UIDescribeTips3:onLoaded(...)
self:bindComponents()
end


function UIDescribeTips3:__delete()
self:unbindComponents()
end


function UIDescribeTips3:onHide()

end




function UIDescribeTips3:onShow(argtable,afterOnloaded)
self.title=argtable.title
self.descList=argtable.descList
self.selectIndex=argtable.selectIndex
local pos=argtable.pos

self:refreshView()

self.root:setLocalPos(pos.x,pos.y,0)
end

function UIDescribeTips3:refreshView()
self.titleTxt:setText(self.title)
local num=#self.descList
self.itemGreator:setChildLayoutGroupCreateItems(num)
local itemGrid=self.itemGreator:getChildLayoutGroupGridList()
for i=1,num do
local item=itemGrid[i-1]
local isSelect=i==self.selectIndex
item:SetChildActive(0,isSelect)
local desc_str=self.descList[i]
if isSelect then
desc_str=FMT.fmt('<color=#7d3b17>{0}</color>',desc_str)
end
item:SetChildText(1,desc_str)
end
end
