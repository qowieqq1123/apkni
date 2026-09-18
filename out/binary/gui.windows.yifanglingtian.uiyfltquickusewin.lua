







def_class("UIYFLTQuickUseWin",UIWindowBase)









function UIYFLTQuickUseWin:bindComponents()

self.empty=UIObject.get(self,0)
self.emptyTips=UIText.get(self,1)
self.oneKeyUse=UIButton.get(self,2)
self.panel=UIObject.get(self,3)
self.root=UIObject.get(self,4)
self.title=UIText.get(self,5)
self.useScrollView=UIObject.get(self,6)

self.oneKeyUse:setButtonClick(function()self:onOneKeyUse()end)



end


function UIYFLTQuickUseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.emptyTips);self.emptyTips=nil;
_UIObject_release(self.oneKeyUse);self.oneKeyUse=nil;
_UIObject_release(self.panel);self.panel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.useScrollView);self.useScrollView=nil;
end


















local _this=nil

function UIYFLTQuickUseWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onItemUse,self.onItemUse)
notifySystem:listenNotify(notifyConfig.onItemUseInBatch,self.onItemUseInBatch)

notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
end


function UIYFLTQuickUseWin:__delete()
notifySystem:removelistener(notifyConfig.onItemUse,self.onItemUse)
notifySystem:removelistener(notifyConfig.onItemUseInBatch,self.onItemUseInBatch)

notifySystem:removelistener(notifyConfig.on_item_list_changed,self.onItemListChanged)
self:unbindComponents()
_this=nil
end




function UIYFLTQuickUseWin:onShow(argtable,afterOnloaded)
local showBack=argtable.showBack

if showBack then
showBack(self)
end
self:SetShowData()
self:SetItemList()
end


function UIYFLTQuickUseWin:onHide()

end

function UIYFLTQuickUseWin:SetShowData()
self.title:setText("库存")

end


function UIYFLTQuickUseWin:SetItemList()
local lt_constcfg=cfg_yifanglintianconfig().const_def
local add_lingye_conf=lt_constcfg.add_lingye_conf
local itemid=add_lingye_conf[1]
local havenum=itemsModel.getCount(itemid)
self.empty:setActive(havenum==0)
self.emptyTips:setText("暂无道具")
self.useScrollView:setChildScrollViewCreateGrids(0,1)
if havenum>0 then
self.useScrollView:setChildScrollViewCreateGrids(1,1)
local grids=self.useScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
local hasOneKeyUseItem=false
for i=1,count do
local item=grids[i-1]
local itemId=itemid
local itemCount=havenum
widgetHelper.setNormalRewardItem(item,0,{itemId,itemCount,noClick=true})
local cfg=itemsConfig.getConfig(itemId)
item:SetChildText(1,cfg.name)
item:SetChildText(5,cfg.name)
local gain=cfg.gain
item:SetChildActive(1,gain~=nil)
item:SetChildActive(2,gain~=nil)
item:SetChildActive(4,gain~=nil)
item:SetChildActive(5,gain==nil)
if gain then
item:SetChildText(2,FMT.fmt('+{0}',mathHelper.formatNumber(gain[2])))
item:SetChildIcon(4,iconHelper.getIconName(gain[1]),true)
hasOneKeyUseItem=true
else
item:SetChildIcon(4,"",false)
end
item:SetChildButtonClick(3,function()

local num,maxnum=YiFangLingTianModel:GetLingYeNum()

YiFangLingTianController:req_3_86(1)



end)
end
end

end

function UIYFLTQuickUseWin.onItemUse(itemid,num)

end
function UIYFLTQuickUseWin.onItemUseInBatch()

end
function UIYFLTQuickUseWin.onItemListChanged()
_this:SetItemList()
end




function UIYFLTQuickUseWin:onOneKeyUse()
local num,maxnum=YiFangLingTianModel:GetLingYeNum()
local lt_constcfg=cfg_yifanglintianconfig().const_def
local add_lingye_conf=lt_constcfg.add_lingye_conf
local itemid=add_lingye_conf[1]
local itemideffect=add_lingye_conf[2]
local havenum=itemsModel.getCount(itemid)



YiFangLingTianController:req_3_86(havenum)




end

function UIYFLTQuickUseWin:onCloseClisk()
self:closeSelf()
end