







def_class("xzsChildYIYuHuiYou",UICloneObject)





xzsChildYIYuHuiYou.abName="ui/windows/xiaozhushou/child/xzschildyiyuhuiyou.ab"

xzsChildYIYuHuiYou.assetName="xzsChildYIYuHuiYou"


function xzsChildYIYuHuiYou:bindComponents()

self.doingText=UIText.get(self,0)
self.icon=UIImage.get(self,1)
self.progress=UIProgressBarAni.get(self,2)
self.rewardContent=UIObject.get(self,3)
self.rewardPanel=UIObject.get(self,4)
self.title=UIText.get(self,5)
self.yydesc=UIText.get(self,6)

end


function xzsChildYIYuHuiYou:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.yydesc);self.yydesc=nil;
end









function xzsChildYIYuHuiYou:onLoaded(...)
self:bindComponents()
end


function xzsChildYIYuHuiYou:__delete()
self:unbindComponents()
end




function xzsChildYIYuHuiYou:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
local min_t,max_t=detailCfg.time[1],detailCfg.time[2]
local time=math.min(argtable.time or min_t,max_t)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
self.doingText:setText(detailCfg.timeTxt)
self.rewards=argtable.rewards or{}
self.count=argtable.count or 0
self.flag=argtable.flag
if self.flag and self.flag==1 then
self.progress:setActive(false)
self.rewardPanel:setActive(false)
else
self.yydesc:setText('')
self.progress:animateFiveParams(0,1,1,time,false)
end
self:delayDo(time,function()
xiaoZhuShouController:setIdleState()
self.progress:setActive(false)
self:refreshRewards()
end)
end


function xzsChildYIYuHuiYou:onHide()

end

function xzsChildYIYuHuiYou:refreshRewards()
if self.flag and self.flag==1 then
self.yydesc:setActive(true)
self.yydesc:setText('以渔会友暂无奖励可领取')
else
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
end


