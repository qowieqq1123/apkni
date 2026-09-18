







def_class("UISectPalacePostDetailsWin",UIWindowBase)









function UISectPalacePostDetailsWin:bindComponents()

self.postlist=UIObject.get(self,0)



end


function UISectPalacePostDetailsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.postlist);self.postlist=nil;
end

















function UISectPalacePostDetailsWin:onLoaded(...)
self:bindComponents()
self.postlist:setChildScrollViewInit(0,true,nil,nil)
end


function UISectPalacePostDetailsWin:__delete()
self:unbindComponents()
end


function UISectPalacePostDetailsWin:onHide()

end




function UISectPalacePostDetailsWin:onShow(argtable,afterOnloaded)
self:refreshPostList()
end

function UISectPalacePostDetailsWin:refreshPostList()
self:getPostDataList()
local dataNum=#self.postDataList
self.postlist:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.postlist:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cfg=self.postDataList[i]
local bgicon,icon=UISectPalaceModel:getPostBigIcon(cfg.id)

item:SetChildCSImageSprite(0,globalABLookup.zongmendadian,icon)
item:SetChildCSImageSprite(4,globalABLookup.zongmendadian,bgicon)

item:SetChildText(1,cfg.pos_name)

local money_str=FMT.fmt('{0}灵石/年',cfg.wages)
if cfg.wages>0 then
money_str=FMT.fmt('{0}灵石/年',cfg.wages)
else
money_str='无'
end
item:SetChildText(2,money_str)


item:SetChildText(3,cfg.effects_desc2)
end
end

function UISectPalacePostDetailsWin:getPostDataList()
local lookup=cfg_guildposconfig()
local list={}
if lookup then
for i,v in ipairs(lookup)do
table.insert(list,v)
end
end
self.postDataList=list
end