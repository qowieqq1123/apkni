







def_class("xzsChildCangJingGe",UICloneObject)





xzsChildCangJingGe.abName="ui/windows/xiaozhushou/child/xzschildcangjingge.ab"

xzsChildCangJingGe.assetName="xzsChildCangJingGe"


function xzsChildCangJingGe:bindComponents()

self.costGridList=UIObject.get(self,0)
self.costPanel=UIObject.get(self,1)
self.descGridList=UIObject.get(self,2)
self.doingText=UIText.get(self,3)
self.errorPanel=UIObject.get(self,4)
self.errorTxt=UIText.get(self,5)
self.icon=UIImage.get(self,6)
self.infoPanel=UIObject.get(self,7)
self.progress=UIProgressBarAni.get(self,8)
self.title=UIText.get(self,9)

end


function xzsChildCangJingGe:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costGridList);self.costGridList=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.descGridList);self.descGridList=nil;
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.errorPanel);self.errorPanel=nil;
_UIObject_release(self.errorTxt);self.errorTxt=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.title);self.title=nil;
end






local _ab="ui/windows/xiaozhushou/xzsiconsmall_pak.ab"


function xzsChildCangJingGe:onLoaded(...)
self:bindComponents()
self._onProgressStepComplete=function(...)
self:onProgressStepComplete(...)
end
self.progress:setFinishAction(self._onProgressStepComplete)

self._onGongFaStudyLevelChange=function(...)
self:onGongFaStudyLevelChange(...)
end
self:addNotify(notifyConfig.onGongFaStudyLevelChange,self._onGongFaStudyLevelChange)
end


function xzsChildCangJingGe:__delete()
self:unbindComponents()
end


function xzsChildCangJingGe:onHide()

end




function xzsChildCangJingGe:onShow(argtable,afterOnloaded)
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
self.progress:setActive(false)
self.errorPanel:setActive(true)
self.errorTxt:setText(argtable.error or"")
if argtable.completeFunc then
argtable.completeFunc()
end
else
self.gflist=argtable.gflist
self.costlp=argtable.costlp
local time=self.detailCfg.time
self.interval=time[1]
self.overTime=time[2]
self.stepFunc=argtable.stepFunc
self.completeFunc=argtable.completeFunc

self.commonList={}
self.commonLookup={}
self.stepValue=0
self.maxValue=#self.gflist
self.perValue=10000/self.maxValue
self.desclist={}

self.costPanel:setActive(false)
self.infoPanel:setActive(false)
self.progress:setActive(true)
self.errorPanel:setActive(false)
self.doingText:setText(self.detailCfg.timeTxt)
self.progress:animateThreeParams(0,10000,0)
self:doNextStep()
end

end

function xzsChildCangJingGe:onGongFaStudyLevelChange(gfID,o_lv,n_lv,assistant)
if assistant==1 then
local d={}
d[1]=UIGongFaModel:getGFColorName(gfID,'《{0}》')
d[2]=FMT.fmt('研习到了<color=#CA631D>{0}</color>级',n_lv)
table.insert(self.desclist,d)
self:onProgressStepComplete()
end
end

function xzsChildCangJingGe:doNextStep()
self.stepValue=self.stepValue+1
if self.stepValue<=self.maxValue then
self.stepMark=0
local v=self.gflist[self.stepValue]
self.stepFunc(v[1])
self:setOverTime(true)
local value=math.floor(self.stepValue*self.perValue)
self.progress:animateThreeParams(value,10000,self.interval)
else
self.stepMark=nil
self:setOverTime(false)
self.costPanel:setActive(true)
self.infoPanel:setActive(true)
self.progress:setActive(false)
self.errorPanel:setActive(false)

local costlp=self.costlp
for _,v in ipairs(self.gflist)do
local lp=costlp[v[2]]
if lp then
for itemid,num in pairs(lp)do
showPrizeControl.insertCommon(self.commonList,self.commonLookup,nil,itemid,num,true)
end
end
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
self.descGridList:setChildLayoutGroupCreateItems(#self.desclist,function(index)
local item=self.descGridList:getChildLayoutGroupGridItem(index-1)
local d=self.desclist[index]
item:SetChildText(0,d[1])
item:SetChildText(1,d[2])
end)



if self.completeFunc then
self.completeFunc()
end
end
end

function xzsChildCangJingGe:onProgressStepComplete()
if self.stepMark~=nil then
self.stepMark=self.stepMark+1
if self.stepMark>=2 then
self.stepMark=nil
self:doNextStep()
end
end
end

function xzsChildCangJingGe:setOverTime(active)
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