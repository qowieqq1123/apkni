







def_class("UIXianZhanNoteWin",UIWindowBase)









function UIXianZhanNoteWin:bindComponents()

self.itemCreater=UIObject.get(self,0)



end


function UIXianZhanNoteWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemCreater);self.itemCreater=nil;
end

















function UIXianZhanNoteWin:onLoaded(...)
self:bindComponents()
end


function UIXianZhanNoteWin:__delete()
self:unbindComponents()
end


function UIXianZhanNoteWin:onHide()

end




function UIXianZhanNoteWin:onShow(argtable,afterOnloaded)
self.datalist=argtable.datalist
local c=#self.datalist
if c>1 then
table.sort(self.datalist,function(a,b)
return a.time>b.time
end)
end
local func=function(idx)
local noteItem=self.itemCreater:getChildLayoutGroupGridItem(idx-1)
self:refreshNoteItem(noteItem,idx)
end
self.itemCreater:setChildLayoutGroupCreateItems(c,func)
end

function UIXianZhanNoteWin:refreshNoteItem(noteItem,idx)
local data=self.datalist[idx]

local notecfg=cfgHelper.get1(cfg_xianzhannoteconfig_get,data.noteId)
local year=gameUtilityModel.getGameYearPass(data.time)
local name=xianzhanModel.getFangKeName(data.customerId)
local desc=FMT.fmt(notecfg.desc,year,name)
noteItem:SetChildText(0,desc)

local rewardlist={}
if data.cost then
table.insert(rewardlist,{eMoneyType.mtLingShi,data.cost})
end
if data.haogandu and data.haogandu~=0 then
table.insert(rewardlist,{xianzhanModel.showItemid,data.haogandu})
end
if data.manyidu and data.manyidu~=0 then
table.insert(rewardlist,{eMoneyType.mtManYiDu,data.manyidu})
end
noteItem:SetChildLayoutGroupCreateItems(1,#rewardlist)
local grid=noteItem:GetChildLayoutGroupGridList(1)
for i=1,#rewardlist do
local rwdItem=grid[i-1]
local rwd=rewardlist[i]
local itemId=rwd[1]
rwdItem:SetChildCSImageIcon(0,iconHelper.getIconName(itemId),false)
local numstr
if rwd[2]>0 then
numstr=FMT.fmt('<color=#549327>+{0}</color>',rwd[2])
elseif rwd[2]==0 then
numstr=tostring(rwd[2])
else
numstr=FMT.fmt('<color=#c82c2c>{0}</color>',rwd[2])
end
rwdItem:SetChildText(1,numstr)
rwdItem:SetChildButtonClick(-1,function()
itemsComponentHelper.onItemClick(itemId,nil,nil,nil)
end)
end
end