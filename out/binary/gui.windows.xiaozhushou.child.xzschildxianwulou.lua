







def_class("xzsChildXianWuLou",UICloneObject)





xzsChildXianWuLou.abName="ui/windows/xiaozhushou/child/xzschildxianwulou.ab"

xzsChildXianWuLou.assetName="xzsChildXianWuLou"


function xzsChildXianWuLou:bindComponents()

self.costGridList=UIObject.get(self,0)
self.costPanel=UIObject.get(self,1)
self.doingText=UIText.get(self,2)
self.errorPanel=UIObject.get(self,3)
self.errorTxt=UIText.get(self,4)
self.icon=UIImage.get(self,5)
self.infoDescTxt=UIText.get(self,6)
self.infoPanel=UIObject.get(self,7)
self.progress=UIProgressBarAni.get(self,8)
self.rewardGridList=UIObject.get(self,9)
self.rewardPanel=UIObject.get(self,10)
self.title=UIText.get(self,11)

end


function xzsChildXianWuLou:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costGridList);self.costGridList=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.errorPanel);self.errorPanel=nil;
_UIObject_release(self.errorTxt);self.errorTxt=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.infoDescTxt);self.infoDescTxt=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardGridList);self.rewardGridList=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.title);self.title=nil;
end






local _ab="ui/windows/xiaozhushou/xzsiconsmall_pak.ab"


function xzsChildXianWuLou:onLoaded(...)
self:bindComponents()
self._onProgressStepComplete=function(...)
self:onProgressStepComplete(...)
end
self.progress:setFinishAction(self._onProgressStepComplete)
self._onXianWuLouSubmit=function(...)
self:onXianWuLouSubmit(...)
end
self:addNotify(notifyConfig.onXianWuLouSubmit,self._onXianWuLouSubmit)
end


function xzsChildXianWuLou:__delete()
self:unbindComponents()
end


function xzsChildXianWuLou:onHide()

end




function xzsChildXianWuLou:onShow(argtable,afterOnloaded)
self.orderID=argtable.orderID
self.detailId=argtable.detailId
self.detailCfg=cfg_xiaozhushoudetailconfig_get(self.detailId)
self.title:setText(self.detailCfg.name)
local iconName=string.format("image_zsjztps_%d",self.detailCfg.icon)
self.icon:setSprite(_ab,iconName)

self.state=argtable.state
if self.state==-1 then
self.costPanel:setActive(false)
self.infoPanel:setActive(false)
self.rewardPanel:setActive(false)
self.progress:setActive(false)
self.errorPanel:setActive(true)
self.errorTxt:setText(argtable.error or"")
if argtable.completeFunc then
argtable.completeFunc()
end
else
local time=self.detailCfg.time
self.interval=time[1]
self.overTime=time[2]
self.stepFunc=argtable.stepFunc
self.completeFunc=argtable.completeFunc

self.commonList={}
self.commonLookup={}


self.stepValue=0

local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local typo=setupData[xzsDataKey.xwlAutoSubmitType]or 2
local selects={}
selects[1]=bitHelper.check_pos(typo,0)
selects[2]=bitHelper.check_pos(typo,1)
self.selects=selects
local num=xianmengModel:getXWL_tjNum()
self.maxValue=num
self.curNum=0
self.perValue=10000/self.maxValue
self.costLookup={}


self.costPanel:setActive(false)
self.infoPanel:setActive(false)
self.rewardPanel:setActive(false)
self.progress:setActive(true)
self.errorPanel:setActive(false)
self.doingText:setText(self.detailCfg.timeTxt)
self.progress:animateThreeParams(0,10000,0)
self:doNextStep()
end

end

function xzsChildXianWuLou:onXianWuLouSubmit(tjItemConfId,cnt,assistant)
if assistant==1 then
self.curNum=self.curNum+cnt
local goodcfg=cfgHelper.get1(cfg_xianwuloutijiaowupinconfig_get,tjItemConfId)





local itemid=goodcfg.item[1]
local itemnum=goodcfg.item[2]
self.costLookup[itemid]=self.costLookup[itemid]or 0
self.costLookup[itemid]=self.costLookup[itemid]+itemnum*cnt

self:onProgressStepComplete()
end
end

function xzsChildXianWuLou:doReq()
local typo,tjId,cnt,num,hasTask
local check0=false
if xianmengModel:checkXWLInit()then
hasTask=xianmengModel:checkXWLHasTask()
num=xianmengModel:getXWL_tjNum()
if num>0 then
if hasTask then
local data=xianmengModel:getXWLData()
local curlun=data.lunshuId
local maxexp=cfgHelper.get2(cfg_xianwuloutasklunshuconfig_get,curlun,'progressBarMax')
local curexp=data.jinduVal
if curexp<maxexp then
check0=true
end
else
check0=true
end
end
end
if check0 then
local tjGoods=xianmengModel:getTJGoods()
for idx,goodid in ipairs(tjGoods)do
local goodcfg=cfgHelper.get1(cfg_xianwuloutijiaowupinconfig_get,goodid)
local itemid=goodcfg.item[1]
local check=false
if self.selects[1]then
if itemid~=eMoneyType.mtLingYu then
check=true
end
else
if itemid==eMoneyType.mtLingYu then
check=true
end
end
if check then
local need=goodcfg.item[2]
local hasnum=itemsModel.getCount(itemid)
local c=math.floor(hasnum/need)
if c>0 then
cnt=1
typo=hasTask and 1 or 2
tjId=goodid
break
end
end
end
end
if typo then
return self.stepFunc(typo,tjId,cnt)
end
return false
end

function xzsChildXianWuLou:doNextStep()
self:setOverTime(false)
self.stepValue=self.stepValue+1
if self.stepValue<=self.maxValue then
local flag=self:doReq()
local value=math.floor(self.stepValue*self.perValue)
if flag then
self.stepMark=0
self:setOverTime(true)
self.progress:animateThreeParams(value,10000,self.interval)
else
self.stepMark=1
self.progress:animateThreeParams(value,10000,0)
self:delayDo(0.1,function()
self:onProgressStepComplete()
end)
end
else
self.stepMark=nil
self.progress:setActive(false)

local isshow=self.curNum>0
self.costPanel:setActive(isshow)
self.rewardPanel:setActive(isshow)
self.infoPanel:setActive(isshow)
self.errorPanel:setActive(not isshow)
if isshow then
for itemid,num in pairs(self.costLookup)do
showPrizeControl.insertCommon(self.commonList,self.commonLookup,nil,itemid,num,true)
end
local count=#self.commonList
self.costGridList:setChildLayoutGroupCreateItems(count,function(index)
local item=self.costGridList:getChildLayoutGroupGridItem(index-1)
local itemData=self.commonList[index]
local itemId=itemData.itemid
local itemNum=itemData.num
local itemGuid=itemData.itemguid
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(-1,itemProp)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)



self.commonList2=xiaoZhuShouModel:popWaitReward(XIAOZHUSHUDETAIL_ENUM.xzs_sub_xwl)
local count2=#self.commonList2
self.rewardGridList:setChildLayoutGroupCreateItems(count2,function(index)
local item=self.rewardGridList:getChildLayoutGroupGridItem(index-1)
local itemData=self.commonList2[index]
local itemId=itemData.itemid
local itemNum=itemData.num
local itemGuid=itemData.itemguid
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
item:SetChildPropData(-1,itemProp)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)



local lerp=self.maxValue-self.curNum
local str
if lerp>0 then
str=FMT.fmt('已捐献<color=#7D3B17>{0}</color>次，剩余<color=#7D3B17>{1}</color>次物资不足无法捐献',self.curNum,lerp)
xiaoZhuShouModel:addReportData(self.detailId,str)
else
str=FMT.fmt('已捐献<color=#7D3B17>{0}</color>次',self.curNum)
end
self.infoDescTxt:setText(str)
else
local str='捐献所需物资不足，无法捐献'
self.errorTxt:setText(str)
xiaoZhuShouModel:addReportData(self.detailId,str)
end


if self.completeFunc then
self.completeFunc()
end
end
end

function xzsChildXianWuLou:onProgressStepComplete()
if self.stepMark~=nil then
self.stepMark=self.stepMark+1
if self.stepMark>=2 then
self.stepMark=nil
self:doNextStep()
end
end
end

function xzsChildXianWuLou:setOverTime(active)
if self.overTimer then
self:stopTimerByID(self.overTimer)
self.overTimer=nil
end
if active then
self.overTimer=self:delayDo(self.overTime,function()
self:doNextStep()
end)
end
end