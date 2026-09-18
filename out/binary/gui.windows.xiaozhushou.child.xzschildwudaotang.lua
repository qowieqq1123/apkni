







def_class("xzsChildWuDaoTang",UICloneObject)





xzsChildWuDaoTang.abName="ui/windows/xiaozhushou/child/xzschildwudaotang.ab"

xzsChildWuDaoTang.assetName="xzsChildWuDaoTang"


function xzsChildWuDaoTang:bindComponents()

self.doingText=UIText.get(self,0)
self.icon=UIImage.get(self,1)
self.progress=UIProgressBarAni.get(self,2)
self.rewardContent=UIObject.get(self,3)
self.rewardPanel=UIObject.get(self,4)
self.title=UIText.get(self,5)
self.wddesc=UIText.get(self,6)

end


function xzsChildWuDaoTang:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.wddesc);self.wddesc=nil;
end









function xzsChildWuDaoTang:onLoaded(...)
self:bindComponents()
end


function xzsChildWuDaoTang:__delete()
self:unbindComponents()
end




function xzsChildWuDaoTang:onShow(argtable,afterOnloaded)
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
local temprewards={}
for k,v in ipairs(self.rewardlists)do
local data=v
if data and#data.reward>0 then
for i=1,#data.reward do
table.insert(temprewards,data.reward[i])
end
end
end

local temp2={}
for k,v in ipairs(temprewards)do
if v.itemguid then
local key=tostring(v.itemguid)
if temp2[key]then
temp2[key].num=temp2[key].num+v.num
else
temp2[key]=v
end
end
end
for k,v in pairs(temp2)do
table.insert(self.rewards,v)
end
self:delayDo(time,function()
self.progress:setActive(false)
if self.flag and self.flag==1 then
self.wddesc:setText("暂无奖励可领取")
else
self.wddesc:setText("")
self:refreshRewards()
end
xiaoZhuShouController:setIdleState()
end)
end


function xzsChildWuDaoTang:onHide()

end

function xzsChildWuDaoTang:refreshRewards()
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


