







def_class("xzsChildFangShi",UICloneObject)





xzsChildFangShi.abName="ui/windows/xiaozhushou/child/xzschildfangshi.ab"

xzsChildFangShi.assetName="xzsChildFangShi"


function xzsChildFangShi:bindComponents()

self.doingText=UIText.get(self,0)
self.icon=UIImage.get(self,1)
self.moneyContent=UIObject.get(self,2)
self.moneyPanel=UIObject.get(self,3)
self.progress=UIProgressBarAni.get(self,4)
self.rewardContent=UIObject.get(self,5)
self.rewardPanel=UIObject.get(self,6)
self.showtext=UIText.get(self,7)
self.title=UIText.get(self,8)

end


function xzsChildFangShi:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.moneyContent);self.moneyContent=nil;
_UIObject_release(self.moneyPanel);self.moneyPanel=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.showtext);self.showtext=nil;
_UIObject_release(self.title);self.title=nil;
end









function xzsChildFangShi:onLoaded(...)
self:bindComponents()
self._onShowPrize=function(...)
self:onShowPrize(...)
end
self:addNotify(notifyConfig.onShowPrize,self._onShowPrize)
end


function xzsChildFangShi:__delete()
self:unbindComponents()
end




function xzsChildFangShi:onShow(argtable,afterOnloaded)

self.orderID=18
local detailId=argtable.detailId
local refreshnum=argtable.num
self.progress:setActive(true)
self.rewardPanel:setActive(false)
self.progress:animate(0)
local showtext=argtable.showtext
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
local min_t,max_t=detailCfg.time[1],detailCfg.time[2]
local time=math.min(argtable.time or min_t,max_t)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
self.progress:animateFiveParams(0,9.8,10,time,false)
self.doingText:setText(detailCfg.timeTxt)
self.args=xiaoZhuShouModel:getDetailDataArgs(detailId)

if showtext and showtext~=""then
self.showtext:setText("")
self.showtext:setActive(showtext~="")
self:delayDo(time,function()
self.progress:setActive(false)
self.showtext:setText(showtext)
xiaoZhuShouController:setIdleState()
end)
end
self.commonList={}
self.commonLookup={}

if refreshnum and refreshnum>0 then

fairModel:SetBeginXiaoZhuShouFlag(true)


fairModel:SetBeginXiaoZhuShouNum(refreshnum)
fairModel:SetAllxiaozhushouNum(refreshnum)
fairModel:AutoBuyItem()
end

end

function xzsChildFangShi:refreshRewards()
self.rewardPanel:setActive(true)
local rewards=self.commonList or{}
if not rewards or#rewards<=0 then
self.rewardPanel:setActive(false)
return
end
self.rewardContent:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local itemData=self.commonList[index]
local itemId=itemData.itemid
local itemNum=itemData.num
local itemGuid=itemData.itemguid
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,itemguid=itemGuid}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
rewardItem:SetChildPropData(0,prop)
end)
end

function xzsChildFangShi:refreshMoney()
local UseMoneydata=self.args.UseMoneydata or{}
if not UseMoneydata or#UseMoneydata<=0 then
self.moneyPanel:setActive(false)
return
end
self.moneyPanel:setActive(true)
self.moneyContent:setChildLayoutGroupCreateItems(#UseMoneydata+1,function(index)
local moneyItem=self.moneyContent:getChildLayoutGroupGridItem(index-1)
moneyItem:SetChildActive(0,index~=1)
moneyItem:SetChildActive(2,index==1)
moneyItem:SetChildActive(3,index~=1)
if index>1 then
local data=UseMoneydata[index-1]
local itemid=data[1]
local itemNum=data[2]
moneyItem:SetChildCSImageIcon(0,iconHelper.getIconName(itemid),false)
moneyItem:SetChildText(3,itemNum)
end
end)
end
function xzsChildFangShi:refreshShowText()
local args=self.args
local showtext=args.showtext or""
self.showtext:setActive(showtext~="")
if showtext~=""then
self.showtext:setText(showtext)
end
end

function xzsChildFangShi:updateDetailProgress(target,max,duration)

if target>=max then
self.progress:setActive(false)
self:refreshRewards()
self:refreshMoney()
self:refreshShowText()
xiaoZhuShouController:setIdleState()


end
end


function xzsChildFangShi:onHide()

end


function xzsChildFangShi:onShowPrize(prizeType,temp,effectData,temp2)

if prizeType==ePrizeType.eXZS_Common and effectData.sub_effecttype==self.orderID then
if self.sub_effecttype2 and effectData.sub_effecttype2~=self.sub_effecttype2 then

return
end
for i,v in ipairs(temp)do
showPrizeControl.insertCommon(self.commonList,self.commonLookup,v.itemguid,v.itemid,v.num,true)
end
end
end

