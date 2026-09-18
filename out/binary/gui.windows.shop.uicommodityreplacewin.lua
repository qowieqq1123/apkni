







def_class("UICommodityReplaceWin",UIWindowBase)









function UICommodityReplaceWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.applyBtn=UIButton.get(self,1)
self.effectDesc=UIText.get(self,2)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)



end


function UICommodityReplaceWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.effectDesc);self.effectDesc=nil;
end
















local _this




function UICommodityReplaceWin:onLoaded(...)
self:bindComponents()

_this=self

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_click,nil)
end


function UICommodityReplaceWin:__delete()
if self.currIndex~=self.selectId then
UIShopControl:reqReplace(self.bdData.un_build_id,self.selectId+1)
end

self:unbindComponents()

_this=nil
end

function UICommodityReplaceWin:getMaxLevel(id)
local cfgs=cfgHelper.get1(cfg_shangpulevelconfig_get,id)
return#cfgs
end




function UICommodityReplaceWin:onShow(argtable,afterOnloaded)
local bdData=argtable
self.bdData=bdData
zongmenModel:countManufacturePercent(self.bdData)
local shopData=UIShopModel:getShopData(bdData.un_build_id)
self.currIndex=shopData.create_item_idx-1
local id=bdData.build_id
self.level=bdData.level
self.bdName=cfgHelper.get2(cfg_monijybuildconfig_get,id,'name')
local maxLevel=self:getMaxLevel(id)
local cfg=cfgHelper.get2(cfg_shangpulevelconfig_get,id,maxLevel)
local datas=cfg.item_create_conf
self.scrollview:setChildScrollViewCreateGrids(#datas,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
local percent=self.bdData.pcreatesubpercent or 0
for i=1,count do
local index=i-1
local item=grids[index]
local data=datas[i]
local icon=data.shop_item.icon
item:SetChildIcon(0,iconHelper.getItemIconName(icon),true)
item:SetChildText(1,data.shop_item.name)
local node=item:GetChildWidgetBase(2)
self:SetMoney(node,data.price[1],0)
node=item:GetChildWidgetBase(3)
self:SetMoney(node,data.cost_item[1],percent)
local cost=data.cost_item[2]
if cost then
item:SetChildActive(4,true)
node=item:GetChildWidgetBase(4)
self:SetMoney(node,cost,percent)
else
item:SetChildActive(4,false)
end
item:SetChildActive(5,false)










item:SetChildActive(9,self.currIndex==index)
local islock=i>self.level
item:SetChildActive(10,islock)
item:SetChildUIGray(11,islock)
end

self.scrollview:setChildScrollViewSelectItem(self.currIndex,false,true,false)


local scfg=cfgHelper.get1(cfg_shangpuconfig_get,id)
self.effectDesc:setText(scfg.effect_desc)
end





































function UICommodityReplaceWin.on_item_click(clicknum,index)
if index+1>_this.level then
UIManager.error(FMT.fmt('需<color=#D4A85D>{0}</color>升至{1}级',_this.bdName,index+1))
return
end
if _this.selectId then
local item=_this.scrollview:getChildScrollViewItemWidget(_this.selectId)
item:SetChildActive(5,false)
item:SetChildActive(9,false)
end

_this.selectId=index

local item=_this.scrollview:getChildScrollViewItemWidget(_this.selectId)
item:SetChildActive(5,true)
item:SetChildActive(9,true)
end

function UICommodityReplaceWin:SetMoney(item,data,percent)
local itemId=data[1]
local price=data[2]
if percent>0 then
if itemsConfig.isMoney(itemId)then
price=math.ceil(price*(1+percent/100))
end
end
item:SetChildIcon(0,iconHelper.getIconName(itemId),true)
item:SetChildText(1,price)
end


function UICommodityReplaceWin:onHide()

end



function UICommodityReplaceWin:onApplyBtn()



self:onCloseClick()
end

function UICommodityReplaceWin:onCloseClick()
self:closeSelf()
end