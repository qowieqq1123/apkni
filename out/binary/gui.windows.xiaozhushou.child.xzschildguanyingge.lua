







def_class("xzsChildGuanYingGe",UICloneObject)





xzsChildGuanYingGe.abName="ui/windows/xiaozhushou/child/xzschildguanyingge.ab"

xzsChildGuanYingGe.assetName="xzsChildGuanYingGe"


function xzsChildGuanYingGe:bindComponents()

self.countPanel=UIObject.get(self,0)
self.countText=UIText.get(self,1)
self.doingText=UIText.get(self,2)
self.icon=UIImage.get(self,3)
self.progress=UIProgressBarAni.get(self,4)
self.rewardContent=UIObject.get(self,5)
self.rewardPanel=UIObject.get(self,6)
self.title=UIText.get(self,7)

end


function xzsChildGuanYingGe:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.countPanel);self.countPanel=nil;
_UIObject_release(self.countText);self.countText=nil;
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.title);self.title=nil;
end









function xzsChildGuanYingGe:onLoaded(...)
self:bindComponents()
end


function xzsChildGuanYingGe:__delete()
self:unbindComponents()
end




function xzsChildGuanYingGe:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))

local showTips=argtable.showTips
if showTips then
self.progress:setActive(false)

self.rewardPanel:setActive(false)
self.countPanel:setActive(true)
self.countText:setText(argtable.tips)
xiaoZhuShouController:setIdleState()
return
end

local min_t,max_t=detailCfg.time[1],detailCfg.time[2]
local time=math.min(argtable.time or min_t,max_t)
self.progress:animateFiveParams(0,1,1,time,false)
self.doingText:setText(detailCfg.timeTxt)
self.rewards=argtable.rewards or{}
self.count=argtable.count or 0
self:delayDo(time,function()
xiaoZhuShouController:setIdleState()
self.progress:setActive(false)
self:refreshRewards()
end)
end


function xzsChildGuanYingGe:onHide()

end

function xzsChildGuanYingGe:refreshRewards()
self.countPanel:setActive(true)
self.countText:setText(FMT.fmt('消耗了<color=#ca631d>{0}</color>观影券获得以下奖励',self.count))
self.rewardPanel:setActive(true)
local rewards=self.rewards
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


