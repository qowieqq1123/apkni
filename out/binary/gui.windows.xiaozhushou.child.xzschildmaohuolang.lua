







def_class("xzsChildMaoHuoLang",UICloneObject)





xzsChildMaoHuoLang.abName="ui/windows/xiaozhushou/child/xzschildmaohuolang.ab"

xzsChildMaoHuoLang.assetName="xzsChildMaoHuoLang"


function xzsChildMaoHuoLang:bindComponents()

self.costContent=UIObject.get(self,0)
self.costPanel=UIObject.get(self,1)
self.countPanel=UIObject.get(self,2)
self.countText=UIText.get(self,3)
self.doingText=UIText.get(self,4)
self.icon=UIImage.get(self,5)
self.progress=UIProgressBarAni.get(self,6)
self.rewardContent=UIObject.get(self,7)
self.rewardPanel=UIObject.get(self,8)
self.title=UIText.get(self,9)

end


function xzsChildMaoHuoLang:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costContent);self.costContent=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.countPanel);self.countPanel=nil;
_UIObject_release(self.countText);self.countText=nil;
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.title);self.title=nil;
end









function xzsChildMaoHuoLang:onLoaded(...)
self:bindComponents()
end


function xzsChildMaoHuoLang:__delete()
self:unbindComponents()
end




function xzsChildMaoHuoLang:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))

local showTips=argtable.showTips
if showTips then
self.progress:setActive(false)
self.costPanel:setActive(false)
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
self:delayDo(time,function()
xiaoZhuShouController:setIdleState()
self.progress:setActive(false)
self:refreshRewards()
end)
end


function xzsChildMaoHuoLang:onHide()

end

function xzsChildMaoHuoLang:getAllFinishCount()
local datas=UICatShopControl:getDatas()
local count=0
for k,v in pairs(datas)do
if v.accept then
count=count+1
end
end
return count
end

function xzsChildMaoHuoLang:refreshRewards()
self.countPanel:setActive(true)
local costDatas,count=UICatShopControl:getCatShopAutoBuyInfo()
if count>0 then
self.countText:setText(FMT.fmt('还有<color=#ca631d>{0}</color>个猫货郎订单未完成',count))
else
count=xzsChildMaoHuoLang:getAllFinishCount()
self.countText:setText(FMT.fmt('已完成<color=#ca631d>{0}</color>次交易',count))
end
self.costPanel:setActive(true)
self.costContent:setChildLayoutGroupCreateItems(#costDatas,function(index)
local rewardItem=self.costContent:getChildLayoutGroupGridItem(index-1)
local data=costDatas[index]
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


