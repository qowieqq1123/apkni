







def_class("xzsChildHouShan",UICloneObject)





xzsChildHouShan.abName="ui/windows/xiaozhushou/child/xzschildhoushan.ab"

xzsChildHouShan.assetName="xzsChildHouShan"


function xzsChildHouShan:bindComponents()

self.costIcon_1=UIObject.get(self,0)
self.costIcon_2=UIObject.get(self,1)
self.costNum_1=UIText.get(self,2)
self.costNum_2=UIText.get(self,3)
self.costPanel=UIObject.get(self,4)
self.costTitle=UIText.get(self,5)
self.doingText=UIText.get(self,6)
self.icon=UIImage.get(self,7)
self.progress=UIProgressBarAni.get(self,8)
self.rewardContent=UIObject.get(self,9)
self.rewardPanel=UIObject.get(self,10)
self.rewardText=UIText.get(self,11)
self.rewardTextLayout=UIObject.get(self,12)
self.tipsText=UIText.get(self,13)
self.title=UIText.get(self,14)
self.costIcon={
self.costIcon_1,
self.costIcon_2,
}
self.costNum={
self.costNum_1,
self.costNum_2,
}

end


function xzsChildHouShan:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costIcon_1);self.costIcon_1=nil;
_UIObject_release(self.costIcon_2);self.costIcon_2=nil;
_UIObject_release(self.costNum_1);self.costNum_1=nil;
_UIObject_release(self.costNum_2);self.costNum_2=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costTitle);self.costTitle=nil;
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.rewardTextLayout);self.rewardTextLayout=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.title);self.title=nil;
self.costIcon=nil;
self.costNum=nil;
end









function xzsChildHouShan:onLoaded(...)
self:bindComponents()
end


function xzsChildHouShan:__delete()
self:unbindComponents()
end




function xzsChildHouShan:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
self.doingText:setText(detailCfg.timeTxt)
local min_t,max_t=detailCfg.time[1],detailCfg.time[2]

self.args=xiaoZhuShouModel:getDetailDataArgs(detailId)
self.progress:animate(0)
self.rewardText:setText("")

if argtable.errCode then
if argtable.errCode==1 then
local type=argtable.type or 1
local nameTab={"金","木","水","火","土"}
local tipStr=string.format("%s属性阵灵未开启扫荡，无法进行扫荡",nameTab[type])
self.tipsText:setText(tipStr)
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_2,tipStr)
elseif argtable.errCode==2 then
self.tipsText:setText("剩余扫荡次数不足")
elseif argtable.errCode==3 then
self.tipsText:setText("后山阵灵未开启")
elseif argtable.errCode==4 then
local type=argtable.type or 1
local nameTab={"金","木","水","火","土"}
local tipStr=string.format("%s属性阵灵已跳过扫荡",nameTab[type])
self.tipsText:setText(tipStr)
end

local time=math.min(argtable.time or min_t,max_t)
self.progress:animateFiveParams(0,1,1,time,false)
self.progress:setFinishAction(function()
self.progress:setActive(false)
self.tipsText:setActive(true)
xiaoZhuShouController:setIdleState()
end)
end
end

function xzsChildHouShan:onCreatedFinish()
if self.delayFunc then
self.delayFunc()
self.delayFunc=nil
end
end

function xzsChildHouShan:updateDetailProgress(target,max,duration)
local func=function()
self.progress:animateThreeParams(target,max,duration)
if target>=max then
self.progress:setFinishAction(function()
self.progress:setActive(false)
self:refreshRewards()
self:refreshCostPanel()
xiaoZhuShouController:setIdleState()
end)
end
end
if self.progress then
func()
else
self.delayFunc=func
end
end

function xzsChildHouShan:refreshRewards()
self.rewardPanel:setActive(true)
local args=self.args
local rewards=args.rewards or{}
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
local sdNum=args.sdNum or 0
local buyNum=args.buyNum or 0
local buyStr=string.format("已扫荡%s次阵灵",sdNum+buyNum)
local buyErrType=args.buyErrType
if buyErrType==1 then
buyStr=string.format("%s<color=#7d3b17>（剩余购买次数不足，未购买扫荡次数）</color>",buyStr)
elseif buyErrType==2 then
buyStr=string.format("%s<color=#7d3b17>（灵玉不足，未购买扫荡次数）</color>",buyStr)
end
self.rewardText:setText(buyStr)
end

function xzsChildHouShan:refreshCostPanel()
local cost=self.args.cost or{}
if#cost>0 then
self.costPanel:setActive(true)
self.costTitle:setText("购买次数消耗:")
for i,v in ipairs(self.costIcon)do
if cost[i]then
local itemid,itemnum=unpack(cost[i])
self.costIcon[i]:setChildIcon(iconHelper.getIconName(itemid),false)
self.costNum[i]:setText(itemnum)
self.costIcon[i]:setActive(true)
self.costNum[i]:setActive(true)
else
self.costIcon[i]:setActive(false)
self.costNum[i]:setActive(false)
end
end
else
self.costPanel:setActive(false)
end
end