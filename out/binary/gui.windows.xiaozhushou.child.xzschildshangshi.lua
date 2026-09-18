







def_class("xzsChildShangShi",UICloneObject)





xzsChildShangShi.abName="ui/windows/xiaozhushou/child/xzschildshangshi.ab"

xzsChildShangShi.assetName="xzsChildShangShi"


function xzsChildShangShi:bindComponents()

self.doingText=UIText.get(self,0)
self.icon=UIImage.get(self,1)
self.progress=UIProgressBarAni.get(self,2)
self.rewardContent=UIObject.get(self,3)
self.rewardPanel=UIObject.get(self,4)
self.showText=UIText.get(self,5)
self.title=UIText.get(self,6)

end


function xzsChildShangShi:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.showText);self.showText=nil;
_UIObject_release(self.title);self.title=nil;
end









function xzsChildShangShi:onLoaded(...)
self:bindComponents()
end


function xzsChildShangShi:__delete()
self:unbindComponents()
end




function xzsChildShangShi:onShow(argtable,afterOnloaded)
self.detailId=argtable.detailId
local state=argtable.state
if not self.ctimer then
local detailCfg=cfg_xiaozhushoudetailconfig_get(self.detailId)
local min_t,max_t=detailCfg.time[1],detailCfg.time[2]
local time=math.min(argtable.time or min_t,max_t)
if argtable.title then
self.title:setText(argtable.title)
else
self.title:setText(detailCfg.name)
end
if argtable.icon then
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",argtable.icon))
else
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
end

if state==-1 then
self.showText:setText(argtable.error)
self.progress:setActive(false)
self.rewardPanel:setActive(false)
if argtable.completeFunc then
argtable.completeFunc()
end
else
self.rewardPanel:setActive(false)
self.showText:setText("")
self.doingText:setText(detailCfg.timeTxt)
self.progress:animateFiveParams(0,1,1,time,false)
self.ctimer=self:delayDo(time,function()
self.progress:setActive(false)
self:refreshRewards()

self.ctimer=nil

xiaoZhuShouController:setIdleState()
end)
end

end
end


function xzsChildShangShi:onHide()

end


function xzsChildShangShi:refreshRewards()
local rewards=xiaoZhuShouModel:getWaitReward(self.detailId)
xiaoZhuShouModel:popWaitReward(self.detailId)
local showReward=rewards and#rewards>0
self.rewardPanel:setActive(showReward)
if showReward then
self.rewardContent:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local itemid=data.itemid
local itemNum=data.num
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
rewardItem:SetChildPropData(0,prop)
end)
end
end


