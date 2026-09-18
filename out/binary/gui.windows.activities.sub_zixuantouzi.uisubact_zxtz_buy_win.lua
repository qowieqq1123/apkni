







def_class("UISubAct_ZXTZ_Buy_Win",UIWindowBase)









function UISubAct_ZXTZ_Buy_Win:bindComponents()

self.activateRewards=UIObject.get(self,0)
self.activateRewardsPanel=UIObject.get(self,1)
self.blackImg=UIObject.get(self,2)
self.buyGrid=UIObject.get(self,3)
self.buyScrollView=UIObject.get(self,4)
self.cancelBtn=UIButton.get(self,5)
self.finalRewards=UIObject.get(self,6)
self.finalRewardsPanel=UIObject.get(self,7)
self.root=UIObject.get(self,8)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UISubAct_ZXTZ_Buy_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activateRewards);self.activateRewards=nil;
_UIObject_release(self.activateRewardsPanel);self.activateRewardsPanel=nil;
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.buyGrid);self.buyGrid=nil;
_UIObject_release(self.buyScrollView);self.buyScrollView=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.finalRewards);self.finalRewards=nil;
_UIObject_release(self.finalRewardsPanel);self.finalRewardsPanel=nil;
_UIObject_release(self.root);self.root=nil;
end

















local itemCmp={
model=0,
title=1,
activateRewardsPanel=2,
finalRewardsPanel=3,
activateRewards=4,
finalRewards=5,
buyBtn=6,
cancelBtn=7,
cancelBtnTxt=8,
buyBtnTxt=9,
effectTip=10,
}


function UISubAct_ZXTZ_Buy_Win:onLoaded(...)
self:bindComponents()
end


function UISubAct_ZXTZ_Buy_Win:__delete()
self:unbindComponents()
if self.dialog then
self.dialog:hide()
end
end




function UISubAct_ZXTZ_Buy_Win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.selectId=argtable.selectId
self.list=argtable.list

self:refresh()
end


function UISubAct_ZXTZ_Buy_Win:refresh()
self.dataList=self.selectId and{self.list[self.selectId]}or self.list





local c=#self.dataList
self.buyScrollView:setChildScrollViewCreateGrids(c,c,true)

if c>0 then
local grids=self.buyScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
self:refreshBuyItem(item,i)
end
end
end

function UISubAct_ZXTZ_Buy_Win:refreshBuyItem(item,idx)
if item==nil then
item=self.buyGrid:getChildLayoutGroupGridItem(idx-1)
end
local data=self.dataList[idx]

item:SetChildText(itemCmp.title,data.title)

item:SetChildText(itemCmp.cancelBtnTxt,self.selectId and"取消"or"选择")
local recharge_id=data.recharge_id
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,recharge_id)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
item:SetChildText(itemCmp.buyBtnTxt,FMT.fmt("{0}购买",str))
item:SetChildText(itemCmp.effectTip,FMT.fmt("{0}%收益",data.effect))
item:SetChildButtonClick(itemCmp.cancelBtn,function()
local sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
if self.selectId then



self:closeSelf()
else
sub_actInfo:setSelectBuyId(data.id)
UIManager:invokeUIMethod("UISubAct_zixuantouzi_Win","refresh")
self:closeSelf()
end
end)

item:SetChildButtonClick(itemCmp.buyBtn,function()







local selectId=data.id
local actID,subType,subid=self.actID,self.subType,self.subid
local recharge_id=data.recharge_id
local func=function()
local info={selectId}
local params=payControl.getActivityPayParams(actID,subType,subid,info)
payControl.reqPay(recharge_id,1,params)
self:closeSelf()
end
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,recharge_id)
local rmbstr=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local fstr=FMT.fmt('是否花费<color=#ca631d>{0}</color>购买{1}？',rmbstr,data.title)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,fstr,func)
end)

item:SetChildLayoutGroupCreateItems(itemCmp.activateRewards,0)
local activateRewardsList={}
local finalRewardsList={}
local activateLookUp={}
local finalLookUp={}

for i,v in ipairs(data.list)do
for ii,itemData in ipairs(v.rmbRewards)do
local itmeId=itemData[1]
local num=itemData[2]
if finalLookUp[itmeId]then
finalLookUp[itmeId]=finalLookUp[itmeId]+num
else
finalLookUp[itmeId]=num
end







end
end
for i,itemData in ipairs(data.rechargeRewards)do
local itmeId=itemData[1]
local num=itemData[2]
if activateLookUp[itmeId]then
activateLookUp[itmeId]=activateLookUp[itmeId]+num
else
activateLookUp[itmeId]=num
end
end
for itmeId,num in pairs(activateLookUp)do
table.insert(activateRewardsList,{itmeId,num})
end
for itmeId,num in pairs(finalLookUp)do
table.insert(finalRewardsList,{itmeId,num})
end

if next(activateRewardsList)then

item:SetChildActive(itemCmp.activateRewardsPanel,true)
if#activateRewardsList>0 then
item:SetChildLayoutGroupCreateItems(itemCmp.activateRewards,#activateRewardsList)
local gridlist=item:GetChildLayoutGroupGridList(itemCmp.activateRewards)
local count=gridlist.Count
for i=1,count do
local widget=gridlist[i-1]
local reward=activateRewardsList[i]
local itemid=reward[1]
local itemCount=reward[2]
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end
end
else

item:SetChildActive(itemCmp.activateRewardsPanel,false)
end

item:SetChildLayoutGroupCreateItems(itemCmp.finalRewards,0)


if next(finalRewardsList)then

item:SetChildActive(itemCmp.finalRewardsPanel,true)
if#finalRewardsList>0 then
item:SetChildLayoutGroupCreateItems(itemCmp.finalRewards,#finalRewardsList)
local gridlist=item:GetChildLayoutGroupGridList(itemCmp.finalRewards)
local count=gridlist.Count
for i=1,count do
local widget=gridlist[i-1]
local reward=finalRewardsList[i]
local itemid=reward[1]
local itemCount=reward[2]
local countStr=''
local showCountBG=false
if itemCount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end
end
else

item:SetChildActive(itemCmp.finalRewardsPanel,false)
end
end


function UISubAct_ZXTZ_Buy_Win:onHide()

end



function UISubAct_ZXTZ_Buy_Win:onClickClose()
self:closeSelf()
end

function UISubAct_ZXTZ_Buy_Win:onCancelBtn()
self:closeSelf()
end
