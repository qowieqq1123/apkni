







def_class("UIShopSellCount",UIWindowBase)









function UIShopSellCount:bindComponents()

self.scrollerView=UIObject.get(self,0)
self.notEarnings=UIText.get(self,1)
self.resourceList=UIObject.get(self,2)



end


function UIShopSellCount:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.notEarnings);self.notEarnings=nil;
_UIObject_release(self.resourceList);self.resourceList=nil;
end
















local showMoneyType={6,4,8,5,10,9}




function UIShopSellCount:onLoaded(...)
self:bindComponents()

self.scrollerView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIShopSellCount:__delete()
self:unbindComponents()
end




function UIShopSellCount:onShow(argtable,afterOnloaded)
local datas=argtable
self:showSellCount(datas)
self:refreshCost(datas)
end


function UIShopSellCount:onHide()

end




function UIShopSellCount:showSellCount(datas)
local list={}
if datas.income_len>0 then
for i,v in ipairs(datas.incomeList)do
local rw=v.incomeList[1]
table.insert(list,{param_1=v.build_id,param_2=rw.param_1,param_3=rw.param_2})
end
end
self:flushShangpuEarnings(list)
end

function UIShopSellCount:flushShangpuEarnings(datas)
local notEarningsStr=#datas>0 and''or'当前无商铺收益'
self.notEarnings:setText(notEarningsStr)

self.scrollerView:setChildScrollViewCreateGrids(#datas,2)
self.grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=datas[i]
local ubdId=data.param_1
local moneyType=data.param_2
local moneyCnt=data.param_3

local model=cfgHelper.get3(cfg_monijybuildconfig_get,ubdId,'model',1)
item:SetChildUIModelShowTarget(0,model,0.32,nil,eAnimationID.bd_stand)
item:SetChildUIModelShowTargetOffset(0,0,-30)

local buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,ubdId)
local moneyName=moneyModel.getMoneyName(moneyType)
local iconName=iconHelper.getIconName(moneyType)
item:SetChildText(1,FMT.fmt('{0}',buildConfig.name))
item:SetChildCSImageIcon(2,iconName,false)
item:SetChildText(3,FMT.fmt('{0}+{1}',moneyName,moneyCnt))
end
end

function UIShopSellCount:getSellCost(datas)
local list={}
if datas.cost_len>0 then
for i,v in ipairs(datas.costList)do
for ii,vv in ipairs(v.incomeList)do
local c=list[vv.param_1]or 0
c=c-vv.param_2
list[vv.param_1]=c
end
end
end
return list
end

function UIShopSellCount:refreshCost(datas)
local costDatas=self:getSellCost(datas)
local num=#showMoneyType
self.resourceList:setChildLayoutGroupCreateItems(num)
local gridlist=self.resourceList:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]

local moneyType=showMoneyType[i]
local moneyName=moneyModel.getMoneyName(moneyType)
local moneyCnt
moneyCnt=costDatas[moneyType]or 0
local str=''
if moneyCnt>=0 then
str=FMT.fmt('{0}+{1}',moneyName,moneyCnt)
else
str=FMT.fmt('<color=#c82c2c>{0}{1}</color>',moneyName,moneyCnt)
end
local iconName=iconHelper.getIconName(moneyType)
item:SetChildCSImageIcon(0,iconName,false)
item:SetChildText(1,str)
end
end

function UIShopSellCount:onCloseClick()
self:closeSelf()
end