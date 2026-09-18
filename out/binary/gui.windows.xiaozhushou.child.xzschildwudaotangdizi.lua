







def_class("xzsChildWuDaoTangDizi",UICloneObject)





xzsChildWuDaoTangDizi.abName="ui/windows/xiaozhushou/child/xzschildwudaotangdizi.ab"

xzsChildWuDaoTangDizi.assetName="xzsChildWuDaoTangDizi"


function xzsChildWuDaoTangDizi:bindComponents()

self.doingText=UIText.get(self,0)
self.icon=UIImage.get(self,1)
self.progress=UIProgressBarAni.get(self,2)
self.rewardContent=UIObject.get(self,3)
self.rewardPanel=UIObject.get(self,4)
self.title=UIText.get(self,5)
self.wddesc=UIText.get(self,6)

end


function xzsChildWuDaoTangDizi:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.wddesc);self.wddesc=nil;
end









function xzsChildWuDaoTangDizi:onLoaded(...)
self:bindComponents()
end


function xzsChildWuDaoTangDizi:__delete()
self:unbindComponents()
end




function xzsChildWuDaoTangDizi:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
local min_t,max_t=detailCfg.time[1],detailCfg.time[2]
local time=math.min(argtable.time or min_t,max_t)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
self.progress:animateFiveParams(0,1,1,time,false)
self.doingText:setText(detailCfg.timeTxt)
self.rewardlists=argtable.rewards or{}
self.flag=argtable.flag
self.rewards={}

self:delayDo(time,function()
self.progress:setActive(false)
if self.flag and self.flag==1 then
self.wddesc:setText("暂无入魔弟子")
elseif self.flag and self.flag==2 then
self.wddesc:setText("已唤醒入魔弟子")
else
self.wddesc:setText("")
self:refreshRewards()
end
xiaoZhuShouController:setIdleState()
end)
end


function xzsChildWuDaoTangDizi:onHide()

end

function xzsChildWuDaoTangDizi:refreshRewards()
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
