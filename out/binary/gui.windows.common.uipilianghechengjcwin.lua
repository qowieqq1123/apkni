







def_class("UIPiLiangHeChengJCWin",UIWindowBase)









function UIPiLiangHeChengJCWin:bindComponents()

self.cost=UILinkImageText.get(self,0)
self.ltFrame=UIObject.get(self,1)
self.oneKeyBtn=UIButton.get(self,2)
self.scrollView=UIObject.get(self,3)

self.oneKeyBtn:setButtonClick(function()self:onOneKeyBtn()end)



end


function UIPiLiangHeChengJCWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.ltFrame);self.ltFrame=nil;
_UIObject_release(self.oneKeyBtn);self.oneKeyBtn=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end



















function UIPiLiangHeChengJCWin:onLoaded(...)
self:bindComponents()

self._onMaxButtonClick=function(id)
self:onMaxButtonClick(id)
end
self._onCutButtonClick=function(id)
self:onCutButtonClick(id)
end
self._onAddButtonClick=function(id)
self:onAddButtonClick(id)
end

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIPiLiangHeChengJCWin:__delete()
self:unbindComponents()
end




function UIPiLiangHeChengJCWin:onShow(argtable,afterOnloaded)
self.nlist=argtable.list
self:refresh()
end


function UIPiLiangHeChengJCWin:onHide()

end

function UIPiLiangHeChengJCWin:setCost()
if not self.bInit then
return
end
local moneyCost=0
local len=#self.nlist
for i=1,len do
if self.hcDatas[i].currVal>0 then
local data=self.hcDatas[i]
local cost=data.cfg.cost[1]
if moneyConfig.isMoney(cost[1])then
moneyCost=moneyCost+cost[2]*data.currVal
end
end
end
local costId=1
local costName=iconHelper.getIconName(costId)
local iconStr=chatEmotHelper.getIconEmotMesg(costName,32)
local have=0
if moneyConfig.isMoney(costId)then
have=moneyModel.getMoney(costId)
else
have=bagControl.invokeFuncByItemId(costId,'getItemCountByItemID',costId)
end
local colorStr=have<moneyCost and'red'or'black'
local costStr=FMT.fmt("消耗:{0}<color={1}>{2}</color>",iconStr,colorStr,moneyCost)
self.cost:setText(costStr)
if moneyConfig.isMoney(costId)then
self:showWindow('UITopMoneyWin2',{{costId}})
end
end

function UIPiLiangHeChengJCWin:refresh()
self.bInit=false
self.hcDatas={}
local len=#self.nlist
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.nlist[i]
local hcItemId=data[1]
local need=data[2]
local have=itemsModel.getCount(hcItemId)

item:SetChildText(1,itemsConfig.getItemName(hcItemId))

local hcId=heChengLianHuaModel:getItemIdToHCConfigId(hcItemId)
local hcCfg=cfgHelper.get1(cfg_lianqigeconfig_get,hcId)
local sindex=#hcCfg.cost
local cdata=hcCfg.cost[sindex]

local max=heChengLianHuaModel:getMaxLianHuaCount_quick(hcCfg)
local min=1
local sdata={
cfg=hcCfg,
currVal=need-have,
minVal=min,
maxVal=max
}
self.hcDatas[i]=sdata

if max<2 then
min=0
item:SetChildImageRaycast(9,false)
item:SetChildSliderInit(4,1,1,1,function(val)
sdata.currVal=val
item:SetChildText(8,val)
widgetHelper.setNormalRewardItem(item,3,{cdata[1],cdata[2]*val,showStage=true,checkAmount=true})
widgetHelper.setNormalRewardItem(item,0,{hcItemId,val,countText=val,showStage=true})
if val<need-have then
item:SetChildText(2,FMT.fmt('需要：<color=red>{0}</color>/{1}',val,need-have))
else
item:SetChildText(2,FMT.fmt('需要：<color=green>{0}/{1}</color>',val,need-have))
end
self:setCost()
end)
else
item:SetChildImageRaycast(9,false)
item:SetChildSliderInit(4,need-have,min,max,function(val)
sdata.currVal=val
item:SetChildText(8,val)
widgetHelper.setNormalRewardItem(item,3,{cdata[1],cdata[2]*val,showStage=true,checkAmount=true})
widgetHelper.setNormalRewardItem(item,0,{hcItemId,val,countText=val,showStage=true})
if val<need-have then
item:SetChildText(2,FMT.fmt('需要：<color=red>{0}</color>/{1}',val,need-have))
else
item:SetChildText(2,FMT.fmt('需要：<color=green>{0}/{1}</color>',val,need-have))
end
self:setCost()
end)
item:SetChildButtonClickWithID(7,self._onMaxButtonClick,i)
item:SetChildLongPress(5,i,self._onCutButtonClick,nil)
item:SetChildLongPress(6,i,self._onAddButtonClick,nil)
end
item:SetChildSliderValue(4,need-have)


end
self.bInit=true
self:setCost()
end

function UIPiLiangHeChengJCWin:onMaxButtonClick(id)
local data=self.hcDatas[id]
local index=id-1
local item=self.scrollView:getChildScrollViewItemWidget(index)
item:SetChildSliderValue(4,data.maxVal)
end

function UIPiLiangHeChengJCWin:onCutButtonClick(id)
local data=self.hcDatas[id]
local index=id-1
local item=self.scrollView:getChildScrollViewItemWidget(index)
data.currVal=data.currVal-1
if data.currVal<data.minVal then
data.currVal=data.minVal
end
item:SetChildSliderValue(4,data.currVal)
end

function UIPiLiangHeChengJCWin:onAddButtonClick(id)
local data=self.hcDatas[id]
local index=id-1
local item=self.scrollView:getChildScrollViewItemWidget(index)
data.currVal=data.currVal+1
if data.currVal>data.maxVal then
data.currVal=data.maxVal
end
item:SetChildSliderValue(4,data.currVal)
end




function UIPiLiangHeChengJCWin:checkEnough()
local dict={}
local len=#self.nlist
for i=1,len do
local data=self.hcDatas[i]
local cost=data.cfg.cost
for ii,vv in ipairs(cost)do
local c=dict[vv[1]]or 0
c=c+vv[2]*data.currVal
dict[vv[1]]=c
end
end
for k,v in pairs(dict)do
local have=itemsModel.getCount(k)
if have<v then
local name=itemsConfig.getItemName(k)
UIManager.error(FMT.fmt('{0}不足',name))
gainControl:showGainWin(k)
return false
end
end
return true
end

function UIPiLiangHeChengJCWin:onOneKeyBtn()
local sfId=mapIdType.zhufeng
local bdData=zongmenModel:findBuildingDataByType(sfId,SLG_SYSTEM_TYPE.eBaGuaLu1)
if not bdData then
return UIManager.error("请先建造八卦炉")
end

local sum=0
for i=#self.nlist,1,-1 do
local data=self.hcDatas[i]
if data then
if data.currVal<=0 then
table.remove(self.hcDatas,i)
end
sum=sum+data.currVal
end
end
if sum<=0 then
return
end

if not self:checkEnough()then
return
end
local list={}
for i,v in ipairs(self.hcDatas)do
list[i]={v.cfg.id,v.currVal}
end
heChengLianHuaController:reqPiLiangHeChengItem(sfId,bdData.un_build_id,#list,list)
end

function UIPiLiangHeChengJCWin:onCloseClick()
self:closeSelf()
end