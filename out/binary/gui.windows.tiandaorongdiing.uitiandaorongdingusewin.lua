







def_class("UITianDaoRongDingUseWin",UIWindowBase)









function UITianDaoRongDingUseWin:bindComponents()

self.Contect=UIObject.get(self,0)



end


function UITianDaoRongDingUseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Contect);self.Contect=nil;
end


















function UITianDaoRongDingUseWin:onLoaded(...)
self:bindComponents()
self.useItemIdx={}
self:addNotify(notifyConfig.on_item_list_changed,function(...)self:on_item_list_changed(...)end)
end

function UITianDaoRongDingUseWin:__delete()
self:unbindComponents()
end

function UITianDaoRongDingUseWin:onShow(argtable,afterOnloaded)
local list=cfgHelper.get2(cfg_tdrlbasicconfig_get,1,'itemlist')
local len=#list
self.Contect:setChildLayoutGroupCreateItems(len,function(i)
local item=self.Contect:getChildLayoutGroupGridItem(i-1)
local itemid=list[i]
local itemCfg=itemsConfig.getConfig(itemid)
local has=itemsModel.getCount(itemid)
local color=itemCfg.color
local gain=itemCfg.gain or{}
local count=gain[2]or 0
self.useItemIdx[itemid]=i


widgetHelper.setItemQulaity(item,itemid,0)
item:SetChildImageExGray(0,has<=0)
item:SetChildIcon(1,iconHelper.getIconName(itemid),false)
item:SetChildButtonClick(1,function()
tipsManager.showTips({itemid=itemid})
end)
item:SetChildImageExGray(1,has<=0)
item:SetChildText(2,itemCfg.name)
item:SetChildText(3,FMT.fmt('天火值+{0}',count))
item:SetChildButtonClick(4,function()
if itemsModel.getCount(itemid)>0 then
bagProtocolControl.req_use_item(itemid,1)
else
UIManager.error(FMT.fmt('{0}不足',itemCfg.name))



end
end)
item:SetChildActive(5,has>1)
item:SetChildText(6,has>1 and has or'')
end)
end

function UITianDaoRongDingUseWin:onHide()

end



function UITianDaoRongDingUseWin:on_item_list_changed(argstable)
for i,v in ipairs(argstable)do
local itemid=v[3]
if self.useItemIdx[itemid]then
self:freshBuyStatue(itemid)
end
end
end

function UITianDaoRongDingUseWin:freshBuyStatue(itemid)
local i=self.useItemIdx[itemid]
if i==nil then return end
local item=self.Contect:getChildLayoutGroupGridItem(i-1)
local has=itemsModel.getCount(itemid)
item:SetChildImageExGray(0,has<=0)
item:SetChildImageExGray(1,has<=0)
item:SetChildActive(5,has>1)
item:SetChildText(6,has>1 and has or'')
end