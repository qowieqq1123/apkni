







def_class("UISubAct_tanbaoge_biHuPrizeWin",UIWindowBase)









function UISubAct_tanbaoge_biHuPrizeWin:bindComponents()

self.tipsText=UIText.get(self,0)
self.ScrollView=UIScrollView.get(self,1)
self.biHuItem=UIObject.get(self,2)
self.tips=UIText.get(self,3)
self.creater=UIGameobjectClone.new(self,4)
self.effect=UIObject.get(self,5)
self.bihuIcon=UIImage.get(self,6)
self.bihuTips=UIText.get(self,7)
self.Content=UIObject.get(self,8)



end


function UISubAct_tanbaoge_biHuPrizeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.biHuItem);self.biHuItem=nil;
_UIObject_release(self.tips);self.tips=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.bihuIcon);self.bihuIcon=nil;
_UIObject_release(self.bihuTips);self.bihuTips=nil;
_UIObject_release(self.Content);self.Content=nil;
end



















function UISubAct_tanbaoge_biHuPrizeWin:onLoaded(...)
self:bindComponents()

UIManager.setMoneyMsgShowState(false,true)
end


function UISubAct_tanbaoge_biHuPrizeWin:__delete()
self:unbindComponents()

UIManager.setMoneyMsgShowState(true,true)
end




function UISubAct_tanbaoge_biHuPrizeWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end

self.biHuIndex=argtable.biHuIndex
local list=argtable.list or{}
self.rewardItemCount=#list
if self.rewardItemCount>0 then
if list[1].sortWeight then
table.sort(list,function(a,b)
return a.sortWeight>b.sortWeight
end)
else
for i,v in pairs(list)do
local itemid=v.itemid
local itemguid=v.itemguid
if itemid==nil and itemguid then
itemid=itemsModel.getItem(itemguid).itemid
end
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color

local rareLv=itemsConfig.getRareLv(itemid)
local sortWeight=rareLv*10000
sortWeight=sortWeight+color*1000
if itemsConfig.isEquip(itemid)then
sortWeight=sortWeight+100
end
v.sortWeight=sortWeight
end
table.sort(list,function(a,b)
return a.sortWeight>b.sortWeight
end)
end
end

local colomn=5
local row=math.ceil(self.rewardItemCount/colomn)
self.ScrollView:freshGridsNum(self.rewardItemCount,row,colomn,true)
for i=1,self.rewardItemCount do
local widget=self.ScrollView:getGridObjectByindex(i-1)
self:freshItem(list[i],widget,i)
end

self.effect:setChildShowEffect(10014,true)

self:showBiHuItem()
end


function UISubAct_tanbaoge_biHuPrizeWin:onHide()

end

function UISubAct_tanbaoge_biHuPrizeWin:freshItem(item,widget,index)
local itemguid=item.itemguid
local itemid=item.itemid
local num=item.num or 1
local limit=item.conf or{}
local item
if itemguid then
item=itemsModel.getItem(itemguid)
if not item then
item={itemid=itemid}
end
else
item={itemid=itemid}
end
limit.itemcount=num<=1 and''or num
if item==nil then
loggerUtil.logErrFMT('没有找到显示的道具信息！itemid：{0} itemguid:{1}',itemid,tostring(itemguid))
end
local itemid=item.itemid
if limit.nomalname==nil then
limit.nomalname=true
end
limit.showCountBG=num>1
local porp=itemsComponentHelper.getCommonFillData(item,limit)
local itemConfig=itemsConfig.getConfig(itemid)
porp[PropIndex(DataPropKey.eWidgetActive,8)]=itemConfig.stage~=nil
widget:SetBaseItemClickEvent(-1,function(...)self:onItemClick(...)end)
widget:SetChildPropData(-1,porp)
self:delayDo(index*0.1,function()
widget:SetChildCanvasGroupDOFade(-1,1,0.2)
end)
end

function UISubAct_tanbaoge_biHuPrizeWin:showBiHuItem()
local isShowBiHuItem=self.rewardItemCount<=0
local biHuItemCfg=self.config.towerBiHuShow[self.biHuIndex]
local biHuDesc=biHuItemCfg[2]

self.tips:setActive(not isShowBiHuItem)
self.biHuItem:setActive(isShowBiHuItem)
if isShowBiHuItem then

local itemid=biHuItemCfg[1]
local iconName=iconHelper.getIconName(itemid)
self.bihuIcon:setImageIcon(iconName,false)
self.bihuTips:setText(biHuDesc)
else
self.tips:setText(biHuDesc)
end
end

function UISubAct_tanbaoge_biHuPrizeWin:onItemClick(itemid,index,itemguid,attach)
if itemid==-1 then
return
end
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end


