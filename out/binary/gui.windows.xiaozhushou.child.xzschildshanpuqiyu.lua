







def_class("xzsChildShanPuQiYu",UICloneObject)





xzsChildShanPuQiYu.abName="ui/windows/xiaozhushou/child/xzschildshanpuqiyu.ab"

xzsChildShanPuQiYu.assetName="xzsChildShanPuQiYu"


function xzsChildShanPuQiYu:bindComponents()

self.costPanel=UIObject.get(self,0)
self.descPanel=UIObject.get(self,1)
self.descText=UIText.get(self,2)
self.doingText=UIText.get(self,3)
self.errorTx=UIText.get(self,4)
self.icon=UIImage.get(self,5)
self.progress=UIProgressBarAni.get(self,6)
self.rewardContent=UIObject.get(self,7)
self.rewardPanel=UIObject.get(self,8)
self.rewardText=UIText.get(self,9)
self.title=UIText.get(self,10)

end


function xzsChildShanPuQiYu:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.descPanel);self.descPanel=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.errorTx);self.errorTx=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.title);self.title=nil;
end






local _ab="ui/windows/xiaozhushou/xzsiconsmall_pak.ab"




function xzsChildShanPuQiYu:onLoaded(...)
self:bindComponents()

self._onProgressStepComplete=function(...)
self:onProgressStepComplete(...)
end
self.progress:setFinishAction(self._onProgressStepComplete)

self._onShowShopEventPrize=function(...)
self:onShowShopEventPrize(...)
end
self:addNotify(notifyConfig.onShowShopEventPrize,self._onShowShopEventPrize)
end


function xzsChildShanPuQiYu:__delete()
self:unbindComponents()
end




function xzsChildShanPuQiYu:onShow(argtable,afterOnloaded)
self.descList={}
self.rewardList={}
self.costList={}
self.orderID=argtable.orderID
self.detailId=argtable.detailId
self.detailCfg=cfg_xiaozhushoudetailconfig_get(self.detailId)
self.title:setText(self.detailCfg.name)
local iconName=string.format("image_zsjztps_%d",self.detailCfg.icon)
self.icon:setSprite(_ab,iconName)

self.state=argtable.state
if self.state==-1 then
self.rewardPanel:setActive(false)
self.costPanel:setActive(false)
self.descPanel:setActive(false)
self.progress:setActive(false)
self.errorTx:setActive(true)
self.errorTx:setText(argtable.error or"")
self.widget:ForceLayoutRect(-1)
if argtable.completeFunc then
argtable.completeFunc()
end
else
self.excutes=argtable.excutes
self.interval=argtable.interval or 1
self.overPass=argtable.overPass or 5
self.stepFunc=argtable.stepFunc
self.completeFunc=argtable.completeFunc
self.errorStr=argtable.error

self.commonList={}
self.commonLookup={}
self.currentStep=0
self.dataCount=0
self.maxValue=#self.excutes
self.perValue=10000/self.maxValue

self.rewardPanel:setActive(false)
self.costPanel:setActive(false)
self.descPanel:setActive(false)
self.progress:setActive(true)
self.errorTx:setActive(false)
self.doingText:setText(self.detailCfg.timeTxt)
self.progress:animateThreeParams(0,10000,0)
self.rewardText:setText(argtable.tipsStr or"获得奖励：")
self:doNextStep()
self.widget:ForceLayoutRect(-1)
end
end


function xzsChildShanPuQiYu:onHide()

end





function xzsChildShanPuQiYu:onShowShopEventPrize(args,otherArgs)
if self and self.isClose then return end
self.descList=self.descList or{}
if args~=nil then
local ubdId=args[1]
local eventId=args[2]
local plen=args[3]
local effectList=args[4]
local xinqing=args[5]
local assistant=args[6]

self.rewardList=self.rewardList or{}
self.costList=self.costList or{}
local data=zongmenModel:getBuildingData(ubdId)
local cfg=cfgHelper.get1(cfg_shangpueventconfig_get,eventId)
local funparam=cfg.funparam[#cfg.funparam][3]
local level=zongmenModel:getLevel()
for i,v in ipairs(cfg.funparam)do
if level>=v[1]and level<=v[2]then
funparam=v[3]
end
end

local copyParams={}
for i,v in ipairs(funparam)do
table.insert(copyParams,v)
end
for i,v in ipairs(effectList)do
local etype=v.effect
local param1=v.param_1
if etype==1 then
local edata=self:getEffectDataChange(copyParams,etype)
local mId=edata[2]
local val=param1
self.rewardList[mId]=(self.rewardList[mId]or 0)+val
elseif etype==2 then
local edata=self:getEffectDataChange(copyParams,etype)
local mId=edata[2]
local val=param1
local itemName=itemsConfig.getItemName(mId)
local name=UIDiscipleModel:getDiscipleName(data.dizi_id)
local str=FMT.fmt('执事弟子：<color=#ca631d>{0}</color>触发消耗奇遇，消耗<color=#ca631d>{1}</color>{2}',name,val,itemName)
table.insert(self.descList,str)
elseif etype==3 then
local name=UIDiscipleModel:getDiscipleName(data.dizi_id)
local buffCfg=cfgHelper.get1(cfg_guildstateconfig_get,param1)
local str=FMT.fmt('执事弟子：<color=#ca631d>{0}</color>获得宗门增益：<color=#ca631d>{1}</color>',name,buffCfg.name)
table.insert(self.descList,str)
elseif etype==4 then
for idx=1,#v.paramList do
local rd=v.paramList[idx]
local itemid=rd.param_1
local itemCount=rd.param_2

self.rewardList[itemid]=(self.rewardList[itemid]or 0)+itemCount
end
elseif etype==5 then
local name=UIDiscipleModel:getDiscipleName(data.dizi_id)
local mdata=v.paramList[1]
local str=FMT.fmt('执事弟子：<color=#ca631d>{0}</color>触发怪物奇遇，坐标<color=#ca631d>({1},{2})</color>刷出怪物',name,mdata.param_1,mdata.param_2)
table.insert(self.descList,str)
elseif etype==6 then
local edata=funparam[1]
for ii,vv in ipairs(funparam)do
if vv[1]==etype then
edata=vv
end
end

local sktype=edata[2]
local name=UIDiscipleModel:getDiscipleName(data.dizi_id)
local skname=cfgHelper.get2(cfg_discipleproskillconfig_get,sktype,'name')

local str=FMT.fmt('执事弟子：<color=#ca631d>{0}</color> {1}经验<color=#ca631d>+{2}</color>',name,skname,param1)
table.insert(self.descList,str)
elseif etype==7 then
local name=UIDiscipleModel:getDiscipleName(data.dizi_id)
local str=FMT.fmt('执事弟子：<color=#ca631d>{0}</color>捕捉到俘虏 <color=#ca631d>牢狱俘虏+1</color>',name)
table.insert(self.descList,str)
end
end
else
local ubdId=otherArgs.ubdId
local errStr=otherArgs.errStr
local data=zongmenModel:getBuildingData(ubdId)
local name=UIDiscipleModel:getDiscipleName(data.dizi_id)
local str=FMT.fmt('执事弟子：<color=#ca631d>{0}</color>所在商铺<color=#ca631d>{1}</color>，无法使用',name,errStr)
table.insert(self.descList,str)
end

self.dataCount=self.dataCount+1
if self.animComplete then
if self.currentStep>=self.maxValue then
self:showResult()
elseif self.overTick then
self:doNextStep()
end
end
end

function xzsChildShanPuQiYu:getEffectDataChange(pdata,effect)
for i,v in ipairs(pdata)do
if v[1]==effect then
table.remove(pdata,i)
return v
end
end
return pdata[1]
end

function xzsChildShanPuQiYu:doNextStep()
self:stopOverTick()
self.animComplete=false

if self.currentStep<self.maxValue then
self.currentStep=self.currentStep+1
local isJump,ubdId,errStr=self.stepFunc(self.excutes[self.currentStep])
self:doProgressAnim()

if isJump then
self:onShowShopEventPrize(nil,{ubdId=ubdId,errStr=errStr})
end
elseif self.dataCount>=self.maxValue then
self.progress:setActive(false)
self:showResult()
if self.completeFunc then
self.completeFunc()
end
end
end

function xzsChildShanPuQiYu:doProgressAnim()
local value=math.floor(self.currentStep*self.perValue)
self.progress:animateThreeParams(value,10000,self.interval)
end

function xzsChildShanPuQiYu:showResult()
local rewards={}
for id,count in pairs(self.rewardList)do
table.insert(rewards,{id,count})
end

local costs={}
for id,count in pairs(self.costList)do
table.insert(costs,{id,count})
end

local descStr=nil
for i,desc in pairs(self.descList)do
if not descStr then
descStr=desc
else
descStr=FMT.fmt("{0}\n{1}",descStr,desc)
end
end

self.descPanel:setActive(descStr~=nil)
self.descText:setText(descStr)

self.costPanel:setActive(#costs>0)
if#costs>0 then
local cost_widget=self.costPanel:getChildWidgetBase()
for i=1,4 do
local cost=costs and costs[i]or nil
local widget=cost_widget:GetChildWidgetBase(i-1)
widget:SetChildActive(-1,cost~=nil)
if cost~=nil then
local itemid=cost[1]
local count=cost[2]
widget:SetChildText(0,count)
widget:SetChildIcon(1,iconHelper.getIconName(itemid),false)
widget:SetChildButtonClick(1,function(...)
itemsComponentHelper.onItemClick(itemid)
end)
end
end
self.widget:ForceLayoutRect(self.costPanel:getID())
end

self.rewardPanel:setActive(#rewards>0)
if#rewards>0 then
self.rewardContent:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local itemid=data[1]
local itemNum=data[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
end)
self.widget:ForceLayoutRect(self.rewardContent:getID())
end
self.widget:ForceLayoutRect(-1)
end

function xzsChildShanPuQiYu:onProgressStepComplete()
self.animComplete=true
if self.dataCount>=self.currentStep then
self:doNextStep()
else
self:stopOverTick()
self:startOverTick()
end
end

function xzsChildShanPuQiYu:startOverTick()
if not self.overTick then
self.overTick=self:setTimer(self.overPass,1,function()
self:doNextStep()
end)
end
end

function xzsChildShanPuQiYu:stopOverTick()
if self.overTick then
self:stopTimerByID(self.overTick)
self.overTick=nil
end
end