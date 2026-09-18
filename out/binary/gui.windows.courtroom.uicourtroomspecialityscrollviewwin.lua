







def_class("UICourtroomSpecialityScrollViewWin",UIWindowBase)









function UICourtroomSpecialityScrollViewWin:bindComponents()

self.descListPanel=UIObject.get(self,0)
self.Name=UIText.get(self,1)



end


function UICourtroomSpecialityScrollViewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descListPanel);self.descListPanel=nil;
_UIObject_release(self.Name);self.Name=nil;
end



















function UICourtroomSpecialityScrollViewWin:onLoaded(...)
self:bindComponents()
end


function UICourtroomSpecialityScrollViewWin:__delete()
self:unbindComponents()
end




function UICourtroomSpecialityScrollViewWin:onShow(argtable,afterOnloaded)
self.desclist=argtable.datas or{}

self.Name:setText(argtable.name or'')

local dataNum=#self.desclist
self.descListPanel:setChildLayoutGroupCreateItems(dataNum)
local gridlist=self.descListPanel:getChildLayoutGroupGridList()
local count=gridlist.Count
if count>0 then
for i=1,count do
local cfg=self.desclist[i]
local item=gridlist[i-1]
UIDiscipleModel.refreshSpecialityItemExx(item,cfg)
item:SetChildButtonClick(1,function()
self:onZlDescSlotClick(i)
end)
end
end
end

function UICourtroomSpecialityScrollViewWin:onZlDescSlotClick(idx)
local cfg=self.desclist[idx]
local item=self.descListPanel:getChildLayoutGroupGridItem(idx-1)
UIFullCourtroomControl:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.zlGuid,config=cfg})
end


function UICourtroomSpecialityScrollViewWin:onHide()

end



