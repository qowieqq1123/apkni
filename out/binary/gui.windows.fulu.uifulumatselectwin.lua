







def_class("UIFuLuMatSelectWin",UIWindowBase)









function UIFuLuMatSelectWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.selectBtn=UIButton.get(self,1)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)



end


function UIFuLuMatSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
end
















local _this




function UIFuLuMatSelectWin:onLoaded(...)
self:bindComponents()

_this=self

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_select,nil)
end


function UIFuLuMatSelectWin:__delete()
self:unbindComponents()

_this=nil
end

function UIFuLuMatSelectWin.on_item_select(cnum,index)
if _this.selectIndex==index then
return
end
if _this.selectIndex then
local widget=_this.scrollview:getChildScrollViewItemWidget(_this.selectIndex)
widget:SetChildActive(1,false)
end

_this.selectIndex=index

local widget=_this.scrollview:getChildScrollViewItemWidget(_this.selectIndex)
widget:SetChildActive(1,true)
end




function UIFuLuMatSelectWin:onShow(argtable,afterOnloaded)
self.makeId=argtable.id
self.datas=self:getDatas()
self:setItemList()
self.on_item_select(1,0)
end


function UIFuLuMatSelectWin:onHide()

end

function UIFuLuMatSelectWin:getDatas()
local cfg=cfgHelper.get1(cfg_fubaofangbasicconfig_get,1)
local list={}
for k,v in pairs(cfg.supply_item)do
local itemcfg=itemsConfig.getConfig(k)
table.insert(list,{itemId=k,cfg=itemcfg,rate=v,desc=cfg.supply_item_desc[k]})
end
table.sort(list,function(a,b)
return a.cfg.color<b.cfg.color
end)
return list
end

function UIFuLuMatSelectWin:setItemList()
local cfg=cfgHelper.get1(cfg_yufufangconfig_get,self.makeId)
local len=#self.datas
self.scrollview:setChildScrollViewCreateGrids(len,0)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=self.datas[i]
local need=cfg.supply_costs[data.itemId]or 0
widgetHelper.setNormalRewardItem(item,0,{data.itemId,need,checkAmount=true})
item:SetChildActive(1,false)
item:SetChildText(2,data.cfg.name)
item:SetChildText(3,data.desc)
end
end





function UIFuLuMatSelectWin:onSelectBtn()
local data=self.datas[self.selectIndex+1]
local cfg=cfgHelper.get1(cfg_yufufangconfig_get,self.makeId)
local need=cfg.supply_costs[data.itemId]or 0
local have=bagModel.getItemCountById(data.itemId)
if have>=need then
UIManager:callWindowFunc('UIFuLuMixWin','setSPMatItem',data.itemId)
self:onCloseClick()
else
gainControl:showGainWin(data.itemId)
end
end

function UIFuLuMatSelectWin:onCloseClick()
self:closeSelf()
end