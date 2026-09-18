







def_class("UIShopSelectWin",UIWindowBase)









function UIShopSelectWin:bindComponents()

self.applyBtn=UIButton.get(self,0)
self.buildScrollview=UIObject.get(self,1)
self.leftIcon=UIObject.get(self,2)
self.need=UIObject.get(self,3)
self.productionItem1=UIBaseItem.get(self,4)
self.productionItem2=UIBaseItem.get(self,5)
self.productionItem3=UIBaseItem.get(self,6)
self.productionItem4=UIBaseItem.get(self,7)
self.productionItem5=UIBaseItem.get(self,8)
self.productionItem6=UIBaseItem.get(self,9)
self.rightIcon=UIObject.get(self,10)
self.stype=UIText.get(self,11)
self.ttype=UIText.get(self,12)
self.unlockImg=UIObject.get(self,13)
self.unlockText=UIText.get(self,14)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)



end


function UIShopSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.buildScrollview);self.buildScrollview=nil;
_UIObject_release(self.leftIcon);self.leftIcon=nil;
_UIObject_release(self.need);self.need=nil;
_UIObject_release(self.productionItem1);self.productionItem1=nil;
_UIObject_release(self.productionItem2);self.productionItem2=nil;
_UIObject_release(self.productionItem3);self.productionItem3=nil;
_UIObject_release(self.productionItem4);self.productionItem4=nil;
_UIObject_release(self.productionItem5);self.productionItem5=nil;
_UIObject_release(self.productionItem6);self.productionItem6=nil;
_UIObject_release(self.rightIcon);self.rightIcon=nil;
_UIObject_release(self.stype);self.stype=nil;
_UIObject_release(self.ttype);self.ttype=nil;
_UIObject_release(self.unlockImg);self.unlockImg=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
end
















local _this
local _itemIndex={
name=0,
icon=1,
need=2,
tips=3,
likecount=4,
}




function UIShopSelectWin:onLoaded(...)
self:bindComponents()

_this=self




self.buildScrollview:setChildScrollViewInit(1,true,self.on_item_click,nil)
self.productionItemListLeft={self.productionItem1,self.productionItem2,self.productionItem3}
self.productionItemListRight={self.productionItem4,self.productionItem5,self.productionItem6}
end


function UIShopSelectWin:__delete()
self:unbindComponents()
_this=nil
end

function UIShopSelectWin:refreshAfterItemUse(utype,arg1,arg2)
self:refreshCostText()
end




function UIShopSelectWin:onShow(argtable,afterOnloaded)
local bdData=argtable[1]
self.bdData=bdData

local index=0
if argtable and argtable[2]then index=argtable[2]end

self.sfId=zongmenModel:getMountainId()
self:InitBuildingList()

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
self:SetInfo(cfg,bdData.level,self.leftIcon,self.stype,self.productionItemListLeft,0)

self:OnSelectItem(index)
end


function UIShopSelectWin:onHide()

end

function UIShopSelectWin.on_item_click(clicknum,index)
_this:OnSelectItem(index)
end

function UIShopSelectWin:OnSelectItem(index)
if self.currSelect then
local item=self.buildScrollview:getChildScrollViewItemWidget(self.currSelect)

item:SetChildActive(6,false)
end
self.currSelect=index
local item=self.buildScrollview:getChildScrollViewItemWidget(self.currSelect)

item:SetChildActive(6,true)

local cfg=self.cfgs[index+1]

self.selectId=cfg.id
self:refreshCostText()

local text
local isGray
local condition
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,cfg.id,self.bdData.level)
condition=self:GetCondition(lcfg.uplevel_condition,1)
if condition and condition>zongmenModel:getLevel()then
text=string.format('<color=#db3f3f>需要宗门达到%s级</color>',condition)
else
condition=self:GetCondition(lcfg.uplevel_condition,3)
local sfId=zongmenModel:getMountainId()
local check,ncount=zongmenModel:checkBuildingWithCondition(sfId,condition)
if condition and not check then
text=string.format('%s级%s<color=#db3f3f>%s/%s</color>座',cnd[3],bdcfg.name,ncount,cnd[2])
end
end

if text then
isGray=1
self.unlockImg:setActive(true)
self.unlockText:setText(text)
else
isGray=0
self.unlockImg:setActive(false)
end

self:SetInfo(cfg,self.bdData.level,self.rightIcon,self.ttype,self.productionItemListRight,isGray)
end

function UIShopSelectWin:refreshCostText()
local cost=self:getSelectCost()
self:SetCostText(self.need:getID(),self.winlua,cost)
end

function UIShopSelectWin:SetInfo(cfg,level,icon,info,itemList,isGray)


local item=icon:getChildWidgetBase()

item:SetChildIcon(0,cfg.icon,true)
item:SetChildText(1,FMT.fmt('{0}({1}级)',cfg.name,level))
item:SetChildText(2,self.likeDatas[cfg.id])




local id=cfg.id
local productionItemList=UIShopModel:getProductionItemList(id,level)
for i,v in ipairs(itemList)do
local itemid=productionItemList[i][1]
if itemid then
v:setActive(true)
local conf={
showname=false,
showStageBg=false,
showCountBG=false,
itemcount="",
stage="",
select=false,
gray=isGray,
}
local item_data={itemid=itemid,itemcount=0}
local prop=itemsComponentHelper.getCommonFillData(item_data,conf)
v:setChildPropData(prop)
else
v:setActive(false)
end
end
end

function UIShopSelectWin:GetBuildingConfigs()
local cfgs=cfg_monijybuildconfig()
local level=zongmenModel:getLevel()
local stype=self.bdData.build_id
local list={}
for k,v in pairs(cfgs)do
if level>=v.show_level and v.build_type==24 then
table.insert(list,v)
end
end
if not self.likeDatas then
self.likeDatas=zongmenControl:countLikeDatas(list)
end
for i,v in ipairs(list)do
if v.id==stype then
table.remove(list,i)
break
end
end
table.sort(list,function(a,b)
local v1=self.likeDatas[a.id]
local v2=self.likeDatas[b.id]
if v1>v2 then
return true
elseif v1==v2 then
return a.id<b.id
else
return false
end
end)
return list
end

function UIShopSelectWin:GetCondition(data,ctype)
for i,v in ipairs(data)do
if v.type==ctype then
return v.param
end
end
end

function UIShopSelectWin:InitBuildingList()
self.cfgs=self:GetBuildingConfigs()
local len=#self.cfgs
self.buildScrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.buildScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
if i<len then
local cfg=self.cfgs[i+1]
local item=grids[i]
self:setShopItem(item,cfg)
end
end
end

function UIShopSelectWin:setShopItem(item,cfg)
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,cfg.id,self.bdData.level)
item:SetChildText(_itemIndex.name,cfg.name)



item:SetChildIcon(_itemIndex.icon,cfg.icon,true)
local cnd=lcfg.uplevel_condition[1]
local text
local condition

condition=self:GetCondition(lcfg.uplevel_condition,1)
if condition and condition>zongmenModel:getLevel()then
text=string.format('<color=#db3f3f>需要宗门达到%s级</color>',condition)
item:SetChildActive(_itemIndex.need,false)
item:SetChildText(_itemIndex.tips,text)
else
condition=self:GetCondition(lcfg.uplevel_condition,3)
local sfId=zongmenModel:getMountainId()
local check,ncount=zongmenModel:checkBuildingWithCondition(sfId,condition)
if condition and not check then
text=string.format('%s级%s<color=#db3f3f>%s/%s</color>座',cnd[3],bdcfg.name,ncount,cnd[2])
item:SetChildActive(_itemIndex.need,false)
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,cnd[1])
item:SetChildText(_itemIndex.tips,text)
else
local slcfg=cfgHelper.get2(cfg_shangpulevelconfig_get,cfg.id,self.bdData.level)
self:SetCostText(_itemIndex.need,item,slcfg.translate_cost[1])
item:SetChildText(_itemIndex.tips,'')
end
end
item:SetChildText(_itemIndex.likecount,self.likeDatas[cfg.id])
end

function UIShopSelectWin:SetCostText(index,item,cost)
if not cost then
item:SetChildActive(index,false)
return
end
item:SetChildActive(index,true)
local node=item:GetChildWidgetBase(index)
local mtype=cost[1]
local need=cost[2]
local have=moneyModel.getMoney(mtype)
local enough=have>=need
if enough then
node:SetChildText(0,need)
else
node:SetChildText(0,string.format('<color=red>%s</color>',need))
end
node:SetChildIcon(1,iconHelper.getIconName(mtype),true)
end



function UIShopSelectWin:getSelectCost()
local slcfg=cfgHelper.get2(cfg_shangpulevelconfig_get,self.selectId,self.bdData.level)
local cost=slcfg.translate_cost[1]
return cost
end

function UIShopSelectWin:onApplyBtn()
local cost=self:getSelectCost()
local currmoney=moneyModel.getMoney(cost[1])
if currmoney<cost[2]then
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(cost[1])))
gainControl:showGainWin(cost[1])
return
end
if self.bdData.flag~=0 then
UIManager.error('商铺升级中无法转型')
return
end
local sdata=UIShopModel:getShopData(self.bdData.un_build_id)
if not sdata.is_in_event then
if UIShopControl:checkCreatingFinish(self.bdData)then
UIShopModel:setTransUnShopID(self.bdData.un_build_id)
UIShopControl.Req_9_16(self.bdData.un_build_id)
end
UIShopControl:reqTransformation(self.bdData.un_build_id,self.selectId)
UIShopModel:setTransShopID(self.bdData.build_id)
self:onCloseClick()
else
UIManager.error('当前商铺存在事件，不可转型')
end
end

function UIShopSelectWin:onCloseClick()
self:closeSelf()
end