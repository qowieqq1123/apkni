







def_class("UILingShouJiaoPeiWin",UIWindowBase)









function UILingShouJiaoPeiWin:bindComponents()

self.root=UIObject.get(self,0)
self.progressBar=UIProgress.get(self,1)
self.babyModel=UIObject.get(self,2)
self.eggModel=UIObject.get(self,3)
self.motherModel=UIObject.get(self,4)
self.fatherModel=UIObject.get(self,5)
self.getBtn=UIButton.get(self,6)
self.costRoot=UIObject.get(self,7)
self.workState=UIImage.get(self,8)
self.dzModel=UIObject.get(self,9)
self.btnDiziAdd=UIButton.get(self,10)
self.btnDiziChange=UIButton.get(self,11)
self.flow=UIObject.get(self,12)
self.babyEffect=UIObject.get(self,13)
self.motherAdd=UIButton.get(self,14)
self.fatherAdd=UIButton.get(self,15)
self.costBtn=UIButton.get(self,16)
self.costTime=UIText.get(self,17)
self.costList=UIObject.get(self,18)
self.scrollView2=UIObject.get(self,19)
self.skill=UIText.get(self,20)
self.dzName=UIText.get(self,21)
self.additionTipsSelected=UIObject.get(self,22)
self.flowTx=UIText.get(self,23)
self.motherHUD=UIObject.get(self,24)
self.babyHUD=UIObject.get(self,25)
self.fatherHUD=UIObject.get(self,26)
self.additionTipsBtn=UIButton.get(self,27)
self.diziInfo=UIObject.get(self,28)
self.diziLock=UIText.get(self,29)

self.getBtn:setButtonClick(function()self:onGetBtn()end)

self.btnDiziAdd:setButtonClick(function()self:onBtnDiziAdd()end)

self.btnDiziChange:setButtonClick(function()self:onBtnDiziChange()end)

self.motherAdd:setButtonClick(function()self:onMotherAdd()end)

self.fatherAdd:setButtonClick(function()self:onFatherAdd()end)

self.costBtn:setButtonClick(function()self:onCostBtn()end)

self.additionTipsBtn:setButtonClick(function()self:onAdditionTipsBtn()end)



end


function UILingShouJiaoPeiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.babyModel);self.babyModel=nil;
_UIObject_release(self.eggModel);self.eggModel=nil;
_UIObject_release(self.motherModel);self.motherModel=nil;
_UIObject_release(self.fatherModel);self.fatherModel=nil;
_UIObject_release(self.getBtn);self.getBtn=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.workState);self.workState=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.btnDiziAdd);self.btnDiziAdd=nil;
_UIObject_release(self.btnDiziChange);self.btnDiziChange=nil;
_UIObject_release(self.flow);self.flow=nil;
_UIObject_release(self.babyEffect);self.babyEffect=nil;
_UIObject_release(self.motherAdd);self.motherAdd=nil;
_UIObject_release(self.fatherAdd);self.fatherAdd=nil;
_UIObject_release(self.costBtn);self.costBtn=nil;
_UIObject_release(self.costTime);self.costTime=nil;
_UIObject_release(self.costList);self.costList=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.additionTipsSelected);self.additionTipsSelected=nil;
_UIObject_release(self.flowTx);self.flowTx=nil;
_UIObject_release(self.motherHUD);self.motherHUD=nil;
_UIObject_release(self.babyHUD);self.babyHUD=nil;
_UIObject_release(self.fatherHUD);self.fatherHUD=nil;
_UIObject_release(self.additionTipsBtn);self.additionTipsBtn=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.diziLock);self.diziLock=nil;
end
















local _this=nil
local _tick={}
local _state={
eUnStart=0,
eEgg=1,
eBreakEgg=2,
eBaby=3,
eFinish=4,
}
local _temp={}




function UILingShouJiaoPeiWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)

local eggCfg=yushoufangModel:getEggModel()
self.eggModelWidget=self.eggModel:getWidgetBase()
self.eggModelWidget:SetChildUIModelShowTarget(0,eggCfg[1],1,{},0)
self.eggModelWidget:SetChildUIModelShowFlipX(0,false)

self.fatherModelWidget=self.fatherModel:getWidgetBase()
self.fatherModelWidget:SetChildButtonClick(2,function()self:onParentModel(SEX_TYPE.eMale)end)
self.fatherHUDWidget=self.fatherHUD:getWidgetBase()
self.fatherHUDWidget:SetChildButtonClick(1,function()self:onParentBubble()end)

self.motherModelWidget=self.motherModel:getWidgetBase()
self.motherModelWidget:SetChildButtonClick(2,function()self:onParentModel(SEX_TYPE.eFeMale)end)
self.motherHUDWidget=self.motherHUD:getWidgetBase()
self.motherHUDWidget:SetChildButtonClick(1,function()self:onParentBubble()end)

self.babyModelWidget=self.babyModel:getWidgetBase()
self.babyModelWidget:SetChildUIModelShowFlipX(0,false)
self.babyModelWidget:SetChildButtonClick(2,function()self:onBabyModel()end)
self.babyHUDWidget=self.babyHUD:getWidgetBase()
self.babyHUDWidget:SetChildButtonClick(1,function()self:onBabyBubble()end)

local initBtData={
stateId=-1,
cmpWidget=self.babyModelWidget,
cmpIndex=0,
}
self.babyBt=behaviorManager:addBehaviorTree("bt_ui_ysf_baby",nil,true,initBtData)
end


function UILingShouJiaoPeiWin:__delete()
self:unbindComponents()
_this=nil
_temp={}
if not yushoufangModel:isStartMating(self.data)then
self.data.parents={}
end
self:stopAllTick()
uiAIManager:removeUIInstance(self.dzBt)
uiAIManager:removeUIInstance(self.babyBt)
self:killFlowCutTime()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)

uiAIManager:clearUIWinData('UILingShouJiaoPeiWin')
end




function UILingShouJiaoPeiWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end

local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end

local entityId=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(entityId)
self.data=yushoufangModel:getData(self.bdData.un_build_id)

self:refreshDisciple()
self:refreshLingShou()
end


function UILingShouJiaoPeiWin:onHide()

end




function UILingShouJiaoPeiWin:onAdditionTipsBtn()
self.additionTipsSelected:setActive(true)
local haveDz=self.bdData.dizi_id and self.bdData.dizi_id~=int64.zero
local skill_id=DISCIPLE_PROSKILL_TYPE.eSiYang
local param={
title={"饲养等级","缩减时间"},
info=cfgHelper.get2(cfg_discipleproskillconfig_get,skill_id,'yushoufang_effect_info'),
level=haveDz and UIDiscipleModel:getDiscipleJobLevel(self.bdData.dizi_id,skill_id)or 0,
callback=function()
if _this then
self.additionTipsSelected:setActive(false)
end
end,
}
UIManager:showWindow("UIBuildingDiscountInfoTips",param)
end


function UILingShouJiaoPeiWin:onBtnDiziChange()
self:selectDisciple()
end


function UILingShouJiaoPeiWin:onBtnDiziAdd()
self:selectDisciple()
end


function UILingShouJiaoPeiWin:onGetBtn()
local check=yushoufangModel:isFinishMating(self.data)
if check then
yushoufangController:send_3_227(self.bdData.un_build_id)
end
end


function UILingShouJiaoPeiWin:onCostBtn()
if tostring(self.bdData.dizi_id)~='0'then
if UIDiscipleModel:checkDiscipleState2(self.dzId,DISCIPLE_STATE_TYPE.edsDispatch)then
UIManager.error('弟子正在外出中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能更换弟子')
return
end
else
UIManager.error('请先选择饲养弟子')
return
end

local fGuid=self.data.parents[SEX_TYPE.eMale]
local mGuid=self.data.parents[SEX_TYPE.eFeMale]
if fGuid and mGuid then
local fData=lingshouModel:getLingShouData(fGuid)
local fCfg=cfgHelper.get1(cfg_lingshouconfig_get,fData.id)
local mData=lingshouModel:getLingShouData(fGuid)
local mCfg=cfgHelper.get1(cfg_lingshouconfig_get,mData.id)
if fCfg.race==mCfg.race then
local raceCfg=cfgHelper.get1(cfg_lingshouraceconfig_get,fCfg.race)
for i,v in ipairs(raceCfg.cost_items or{})do
local itemCount=itemsModel.getCount(v[1])
if itemCount<v[2]then
local itemName=itemsConfig.isMoney(v[1])and moneyModel.getMoneyName(v[1])or itemsConfig.getItemName(v[1])
UIManager.error(FMT.fmt("{0}不足",itemName))
gainControl:showCommonGainWin_item(v[1])
return
end
end
yushoufangController:send_3_224(self.bdData.un_build_id,self.data.parents)
else
UIManager.error('繁衍双亲必须同一种族')
end
else
UIManager.error('请先选择需要繁衍的双亲')
end
end

function UILingShouJiaoPeiWin:onBabyBubble()
if self.state==_state.eBaby then
if not yushoufangModel:canTouch(self.data)then
return UIManager.error("抚摸还在冷却中")
end

self:doTouch()
end
end

function UILingShouJiaoPeiWin:onParentBubble()
if self.state==_state.eEgg then
if not yushoufangModel:canFeed(self.data)then
return UIManager.error("喂养还在冷却中")
end

self:doFeed()
end
end

function UILingShouJiaoPeiWin:onParentModel(sType)
if self.state==_state.eUnStart then
local isStart=yushoufangModel:isStartMating(self.data)
if isStart then
if yushoufangModel:canFeed(self.data)then
self:doFeed()
end
else
if tostring(self.bdData.dizi_id)=='0'then
return
end
local args={
ubdID=self.bdData.un_build_id,
selects=self.data.parents,
sType=sType,
callback=function(fGuid,mGuid)
UIManager.info("选择成功")
self.data.parents={
[SEX_TYPE.eMale]=fGuid,
[SEX_TYPE.eFeMale]=mGuid,
}
self:refreshParentsInUnStart(self.bdData.un_build_id)
end
}
UIManager:showWindow("UILingShouJiaoPeiSelectWin",args)
end
elseif self.state==_state.eEgg then
if yushoufangModel:canFeed(self.data)then
self:doFeed()
end
end
end

function UILingShouJiaoPeiWin:onFatherAdd()
if self.state==_state.eUnStart then
self:onParentAdd(SEX_TYPE.eMale)
end
end

function UILingShouJiaoPeiWin:onMotherAdd()
if self.state==_state.eUnStart then
self:onParentAdd(SEX_TYPE.eFeMale)
end
end

function UILingShouJiaoPeiWin:onParentAdd(sType)
if tostring(self.bdData.dizi_id)=='0'then
return UIManager.error("未安排弟子，无法选择灵兽")
end
local args={
ubdID=self.bdData.un_build_id,
sType=sType,
selects=self.data.parents,
callback=function(fGuid,mGuid)
UIManager.info("选择成功")
self.data.parents={
[SEX_TYPE.eMale]=fGuid,
[SEX_TYPE.eFeMale]=mGuid,
}
self:refreshParentsInUnStart(self.bdData.un_build_id)
end
}
UIManager:showWindow("UILingShouJiaoPeiSelectWin",args)
end

function UILingShouJiaoPeiWin:onBabyModel()
if self.state==_state.eBaby then
if yushoufangModel:canTouch(self.data)then
self:doTouch()
end
end
end

function UILingShouJiaoPeiWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.replaceDisciple and _this.sfId==sfId and _this.bdData.un_build_id==bdId then
_this:refreshDisciple()
end
end

function UILingShouJiaoPeiWin.on_money_changed(moneyType,lastVal,val)
if _this.state==_state.eUnStart then
_this:refreshCostItem(moneyType)
end
end

function UILingShouJiaoPeiWin.on_item_changed(changeType,itemguid,itemid,lastcount,itemcount)
if _this.state==_state.eUnStart then
_this:refreshCostItem(itemid)
end
end

function UILingShouJiaoPeiWin:doFadeIn(delay,duration)
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,duration,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end

function UILingShouJiaoPeiWin:refreshCostItem(itemid)
local parents=_this.data.parents
local fGuid=parents[SEX_TYPE.eMale]
local mGuid=parents[SEX_TYPE.eFeMale]
local haveFather=fGuid~=nil
local haveMother=mGuid~=nil
local selected=haveFather and haveMother
if selected then
local data=lingshouModel:getLingShouData(fGuid or mGuid)
local cfg=cfgHelper.get1(cfg_lingshouconfig_get,data.id)
local race=cfg.race
local raceCfg=cfgHelper.get1(cfg_lingshouraceconfig_get,race)
for i,v in ipairs(raceCfg.cost_items or{})do
local itemId=v[1]
local itemnum=v[2]
local index=i
if itemid==itemId then
local itemCmp=_this.costList:getChildLayoutGroupGridItem(i-1)
local hasnum=0
local num_str=""
if itemsConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
num_str=tostring(itemnum)
else
hasnum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
num_str=string.format('%d/%d',hasnum,itemnum)
end
local grayNum=0
if hasnum<itemnum then
grayNum=mathHelper.setbit(grayNum,eGrayType.eMaskGray-1)
end
if grayNum~=0 then
num_str=FMT.fmt('<color=red>{0}</color>',num_str)
end
local conf={
itemid=itemid,
itemcount=num_str,
showname=false,
itemIndex=index,
gray=grayNum,
showStage=true,
showCountBG=true
}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemCmp:SetChildPropData(0,prop)
break
end
end
end
end

function UILingShouJiaoPeiWin:doFeed()
local costList=yushoufangModel:getFeedCost()
local args={
title='灵兽喂养',
desc1='喂养后可缩短灵兽培养时间',

rewards=costList,
rewardTitle='',
showCancel=true,
cancelName=nil,
commitName='喂养',
cancelCB=nil,
commitCB=function()
for i,v in ipairs(costList)do
if itemsConfig.isMoney(v[1])then
if not moneyModel.checkEnoughMoney(v[1],v[2])then
return UIManager.error("材料不足")
end
else
local itemCount=bagControl.invokeFuncByItemId(v[1],'getItemCountByItemID',v[1])
if itemCount<v[2]then
return UIManager.error("材料不足")
end
end
end
yushoufangController:send_3_225(self.bdData.un_build_id)
end,
}
UIManager:showWindow('UIDialougeRewardWin',args)
end

function UILingShouJiaoPeiWin:doTouch()
yushoufangController:send_3_226(self.bdData.un_build_id)
end

function UILingShouJiaoPeiWin:selectDisciple()
if tostring(self.bdData.dizi_id)~='0'then
if UIDiscipleModel:checkDiscipleState2(self.bdData.dizi_id,DISCIPLE_STATE_TYPE.edsDispatch)then
UIManager.error('弟子正在外出中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能更换弟子')
return
elseif yushoufangModel:isStartMating(self.data)then
UIManager.error('繁衍中, 不能更换弟子')
return
end
end
zongmenControl:showSelectManagerWin(self.sfId,self.bdData)
end

function UILingShouJiaoPeiWin:setModelByGuid(cmp,lsGuid,flip)
local index=flip and 1 or 2
if lsGuid then
if _temp[index]~=lsGuid then
local modelParams=lingshouModel:getModelParams(lsGuid)
cmp:SetChildUIModelShowTarget(0,modelParams.body,1,modelParams.componets,0,false,true)
cmp:SetChildUIModelShowTargetOffset(0,0,-100)
cmp:SetChildUIModelShowFlipX(0,flip or false)
_temp[index]=lsGuid
end
else
cmp:SetChildUIModelRemoveTarget(0)
_temp[index]=nil
end
end

function UILingShouJiaoPeiWin:setModelById(id)
local index=3
if id then
if _temp[index]~=id then
local babyCfg=cfgHelper.get1(cfg_lingshouconfig_get,id)
self.babyModelWidget:SetChildUIModelShowTarget(0,babyCfg.model,1,{},0)
self.babyModelWidget:SetChildUIModelShowTargetOffset(0,0,-100)
_temp[index]=id
end
else
cmp:SetChildUIModelRemoveTarget(0)
_temp[index]=nil
end
end

function UILingShouJiaoPeiWin:refreshDisciple()
local dzId=self.bdData.dizi_id
local haveDz=dzId and dzId~=int64.zero or false
local isPause=UIDiscipleModel:checkDiscipleState2(dzId,DISCIPLE_STATE_TYPE.edsDispatch)
self.diziLock:setActive(not haveDz)
self.diziInfo:setActive(haveDz)
self.btnDiziAdd:setActive(not haveDz)
self.btnDiziChange:setActive(haveDz and not isPause)

if haveDz then
local name=UIDiscipleModel:getDiscipleName(dzId)
self.dzName:setText(FMT.fmt("执事弟子：<color=#7d3b17>{0}</color>",name))

local skill_id=DISCIPLE_PROSKILL_TYPE.eSiYang
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
self.skill:setText(FMT.fmt("{0}：{1}",skill_cfg.name,level))

local bd_tybe_cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.dizi_speciality=discipleSelectController.getSpeciallistByBuild(dzId,bd_tybe_cfg.build_type)
if self.dizi_speciality then
self.scrollView2:setActive(true)
self.scrollView2:setChildScrollViewCreateGrids(#self.dizi_speciality,3)
local grids=self.scrollView2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.dizi_speciality[i]
UIDiscipleModel.refreshSpecialityItemEx(item,data)
end
else
self.scrollView2:setActive(false)
end


self.workState:setActive(isPause)
if isPause then
self.workState:setSprite(globalABLookup.global,"image_waichu")
uiAIManager:removeUIInstance(self.dzBt)
else
if not self.dzBt then
self:delayDo(1,function(...)
self:createDiscipleModel()
end)
else
uiAIManager:removeUIInstance(self.dzBt)
self:createDiscipleModel()
end
end
else
uiAIManager:removeUIInstance(self.dzBt)
self.workState:setActive(true)
self.workState:setSprite(globalABLookup.global,"image_kongwei")
end
end

function UILingShouJiaoPeiWin:createDiscipleModel()
local UIstateId=0
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=1,
leftPos={0,-40},
rightPos={500,-40},
waitspeak=1,
winName="UILingShouJiaoPeiWin",
}
local tran=self.dzModel:getCommonComponent('Transform')
local vpos=Vector2.New(0,-40)
uiAIManager:createUIDisciple('UILingShouJiaoPeiWin','bt_ui_buiding_dizi',self.bdData.dizi_id,tran,vpos,initData,nil,function(bt)
self.dzBt=bt
end)
end

function UILingShouJiaoPeiWin:getSpeakText(bt,tkey)
local diziGuid=self.bdData.dizi_id
local hasDizi=diziGuid and diziGuid~=int64.zero or false
local txt=nil
if hasDizi then
if self.state==_state.eUnStart then
local parents=_this.data.parents
local fGuid=parents[SEX_TYPE.eMale]
local mGuid=parents[SEX_TYPE.eFeMale]
local haveFather=fGuid~=nil
local haveMother=mGuid~=nil
local selected=haveFather and haveMother
if not selected then
txt="请选择灵兽"
end
elseif self.state==_state.eEgg then
txt=self:getBuildSpeakConfig(diziGuid,"yushou_egg_speak")
elseif self.state==_state.eBreakEgg then

elseif self.state==_state.eBaby then
txt=self:getBuildSpeakConfig(diziGuid,"yushou_baby_speak")
elseif self.state==_state.eFinish then

end
end

bt:setSharedVar(tkey,txt)
end

function UILingShouJiaoPeiWin:getBuildSpeakConfig(diziguid,colName)
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,colName)
local txt=speakList[math.random(1,#speakList)]or''
return txt
end

function UILingShouJiaoPeiWin:refreshLingShou()
local isStart=yushoufangModel:isStartMating(self.data)
if isStart then
local passTime=yushoufangModel:getPassDuration(self.data)
if passTime<self.data.duration then
local midPercent=yushoufangModel:getMidPercent()
if passTime<=midPercent*self.data.duration then
self:refreshLingShou_Egg()
else
self:refreshLingShou_Baby()
end
else
self:refreshLingShou_Finish()
end
else
self:refreshLingShou_UnStart()
end
end

function UILingShouJiaoPeiWin:refreshLingShou_UnStart()
self.state=_state.eUnStart

local parents=self.data.parents

self.fatherModel:setActive(true)
self.motherModel:setActive(true)

local fGuid=parents[SEX_TYPE.eMale]
local mGuid=parents[SEX_TYPE.eFeMale]

self:setModelByGuid(self.fatherModelWidget,fGuid,true)
self:setModelByGuid(self.motherModelWidget,mGuid,false)

local haveFather=fGuid~=nil
local haveMother=mGuid~=nil
self.fatherAdd:setActive(not haveFather)
self.motherAdd:setActive(not haveMother)

self.fatherHUDWidget:SetChildActive(1,false)
self.motherHUDWidget:SetChildActive(1,false)

local selected=haveFather and haveMother
self.costRoot:setActive(selected)

self.babyModel:setActive(false)
self.eggModel:setActive(false)

self.progressBar:setActive(false)
self.getBtn:setActive(false)

if selected then
local data=lingshouModel:getLingShouData(fGuid or mGuid)
local cfg=cfgHelper.get1(cfg_lingshouconfig_get,data.id)
local race=cfg.race
local raceCfg=cfgHelper.get1(cfg_lingshouraceconfig_get,race)
local num=raceCfg.cost_items and#raceCfg.cost_items or 0
self.costList:setChildLayoutGroupCreateItems(num,function(index)
local itemCfg=raceCfg.cost_items[index]
local itemCmp=self.costList:getChildLayoutGroupGridItem(index-1)
local itemid=itemCfg[1]
local itemnum=itemCfg[2]
local hasnum=0
local num_str=""
if itemsConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
num_str=tostring(itemnum)
else
hasnum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
num_str=string.format('%d/%d',hasnum,itemnum)
end
local grayNum=0
if hasnum<itemnum then
grayNum=mathHelper.setbit(grayNum,eGrayType.eMaskGray-1)
end
if grayNum~=0 then
num_str=FMT.fmt('<color=red>{0}</color>',num_str)
end
local conf={
itemid=itemid,
itemcount=num_str,
showname=false,
itemIndex=index,
gray=grayNum,
showStage=true,
showCountBG=true
}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemCmp:SetChildPropData(0,prop)
itemCmp:SetBaseItemClickEvent(0,function(itemid,index,guid,attach)
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end)
end)
local midPercent=yushoufangModel:getMidPercent()
local costTime=math.floor(raceCfg.cost_time*midPercent)
self.costTime:setText(timeHelper.format_time_stamp2(costTime))
end

self:stopAllTick()
end

function UILingShouJiaoPeiWin:refreshLingShou_Egg()
self.state=_state.eEgg

local parents=self.data.parents
self.fatherModel:setActive(true)
self.motherModel:setActive(true)



self:setModelByGuid(self.fatherModelWidget,parents[SEX_TYPE.eMale],true)
self:setModelByGuid(self.motherModelWidget,parents[SEX_TYPE.eFeMale],false)

self.fatherAdd:setActive(false)
self.motherAdd:setActive(false)
self.costRoot:setActive(false)
self.babyModel:setActive(false)
self.eggModel:setActive(true)
self.progressBar:setActive(true)
self.getBtn:setActive(false)

if not yushoufangModel:isStopMating(self.data)then
local pass=yushoufangModel:getPassDuration(self.data)
local midPercent=yushoufangModel:getMidPercent()
local duration=math.floor(self.data.duration*midPercent)
self.progressBar:setProgressValue(pass,duration)
self.progressBar:setChildProgressText(timeHelper.format_time_stamp2(duration-pass))

self:startTick(1,function()
self:refreshUpdate_Egg()
end)

if yushoufangModel:canFeed(self.data)then
local r=math.random(0,1)
local s=r>0
self.fatherHUDWidget:SetChildActive(1,s)
self.motherHUDWidget:SetChildActive(1,not s)
else
self.fatherHUDWidget:SetChildActive(1,false)
self.motherHUDWidget:SetChildActive(1,false)
end
else
self.progressBar:setProgressValue(100,100)
self.progressBar:setChildProgressText("暂停中")
self.fatherHUDWidget:SetChildActive(1,false)
self.motherHUDWidget:SetChildActive(1,false)
self:stopAllTick()
end
end

function UILingShouJiaoPeiWin:refreshLingShou_Baby()
self.state=_state.eBaby

self.fatherModel:setActive(false)
self.motherModel:setActive(false)
self:setModelByGuid(self.fatherModelWidget,nil,true)
self:setModelByGuid(self.motherModelWidget,nil,false)

self.costRoot:setActive(false)
self.babyModel:setActive(true)
self.eggModel:setActive(false)

self:setModelById(self.data.baby)
behaviorManager:setSharedValues(self.babyBt,{["stateId"]=1})

self.babyBt:broke()
self.babyBt:reset()
self.babyBt:tick(0.5)

self.progressBar:setActive(true)
self.getBtn:setActive(true)

local pass=yushoufangModel:getPassDuration(self.data)
local midPercent=yushoufangModel:getMidPercent()
local preTime=math.floor(self.data.duration*midPercent)
pass=pass-preTime
local duration=self.data.duration-preTime

local scaleCfg=yushoufangModel:getBabyScale()
local scalePart=math.floor((pass)/duration*scaleCfg[3])
local scale=(scaleCfg[2]-scaleCfg[1])*scalePart/scaleCfg[3]+scaleCfg[1]
self.winlua:SetChildUIModelShowScale(self.babyModel:getID(),scale)

if not yushoufangModel:isStopMating(self.data)then
self.progressBar:setProgressValue(pass,duration)
self.progressBar:setChildProgressText(timeHelper.format_time_stamp2(duration-pass))

self:startTick(2,function()
self:refreshUpdate_Baby()
end)

local show=yushoufangModel:canTouch(self.data)
self.babyHUDWidget:SetChildActive(1,show)
else
self.progressBar:setProgressValue(100,100)
self.progressBar:setChildProgressText("暂停中")
self.babyHUDWidget:SetChildActive(1,false)
self:stopAllTick()
end

self.getBtn:setButtonEnable(false,true)
end

function UILingShouJiaoPeiWin:refreshLingShou_Finish()
self.state=_state.eFinish

self.fatherModel:setActive(false)
self.motherModel:setActive(false)
self:setModelByGuid(self.fatherModelWidget,nil,true)
self:setModelByGuid(self.motherModelWidget,nil,false)

self.costRoot:setActive(false)
self.babyModel:setActive(true)
self.eggModel:setActive(false)

self:setModelById(self.data.baby)
self.babyHUDWidget:SetChildActive(1,false)
behaviorManager:setSharedValues(self.babyBt,{["stateId"]=0})

self.progressBar:setProgressValue(100,100)
self.progressBar:setChildProgressText("灵兽已成长")

self.getBtn:setActive(true)
self.getBtn:setButtonEnable(true,false)

self:stopAllTick()
end

function UILingShouJiaoPeiWin:startTick(index,callback)
if callback then
self:stopTick(index)
_tick[index]=self:setTimer(1,0,callback)
end
end

function UILingShouJiaoPeiWin:stopTick(index)
if _tick[index]then
self:stopTimerByID(_tick[index])
_tick[index]=nil
end
end

function UILingShouJiaoPeiWin:stopAllTick()
for i,v in pairs(_tick)do
self:stopTick(i)
end
end

function UILingShouJiaoPeiWin:doBreakEgg()
self.state=_state.eBreakEgg
local eggCfg=yushoufangModel:getEggModel()
local animation=eggCfg[2]
local duration=eggCfg[3]
local color=Color.New(1,1,1,0)

self.eggModelWidget:SetChildModelAnimationState(0,animation)
self.eggModelWidget:SetChildUIModelShowFadeToColor(0,color,1,duration,function()

self.eggModel:setActive(false)
self.eggModelWidget:SetChildUIModelShowColor(0,Color.white)

local babyScale=yushoufangModel:getBabyScale()
self.babyModel:setActive(true)
self:setModelById(self.data.baby)
self.winlua:SetChildUIModelShowScale(self.babyModel:getID(),babyScale[1])
self.babyModelWidget:SetChildUIModelShowColor(0,color)
self.babyModelWidget:SetChildUIModelShowFadeToColor(0,Color.white,1,0,function()
self:stopTick(3)
self:refreshLingShou_Baby()

end)
end)
self.fatherModelWidget:SetChildUIModelShowFadeToColor(0,color,1,0,function()
self.fatherModel:setActive(false)
self.fatherModelWidget:SetChildUIModelShowColor(0,Color.white)

end)
self.motherModelWidget:SetChildUIModelShowFadeToColor(0,color,1,0,function()
self.motherModel:setActive(false)
self.motherModelWidget:SetChildUIModelShowColor(0,Color.white)

end)

self:refreshUpdate_BreakEgg()
self:startTick(3,function()
self:refreshUpdate_BreakEgg()
end)
end

function UILingShouJiaoPeiWin:refreshUpdate_Egg()
local pass=yushoufangModel:getPassDuration(self.data)
local midPercent=yushoufangModel:getMidPercent()
local duration=math.floor(self.data.duration*midPercent)
self.progressBar:setProgressValue(pass,duration)
self.progressBar:setChildProgressText(timeHelper.format_time_stamp2(duration-pass))

local oFV=self.fatherHUDWidget:GetChildActiveSelf(1)
local oMV=self.motherHUDWidget:GetChildActiveSelf(1)
local nV=yushoufangModel:canFeed(self.data)
if(oFV or oMV)~=nV then
if nV then
local r=math.random(0,1)
local s=r>0
self.fatherHUDWidget:SetChildActive(1,s)
self.motherHUDWidget:SetChildActive(1,not s)
elseif oFV then
self.fatherHUDWidget:SetChildActive(1,false)
elseif omV then
self.motherHUDWidget:SetChildActive(1,false)
end
end

if pass>duration then
self:stopTick(1)
self:doBreakEgg()
end
end

function UILingShouJiaoPeiWin:refreshUpdate_Baby()

local pass=yushoufangModel:getPassDuration(self.data)
local midPercent=yushoufangModel:getMidPercent()
local preTime=math.floor(self.data.duration*midPercent)
pass=pass-preTime
local duration=self.data.duration-preTime
self.progressBar:setProgressValue(pass,duration)
self.progressBar:setChildProgressText(timeHelper.format_time_stamp2(duration-pass))

local oldV=self.babyHUDWidget:GetChildActiveSelf(1)
local newV=yushoufangModel:canTouch(self.data)
if oldV~=newV then
self.babyHUDWidget:SetChildActive(1,newV)
end

local scaleCfg=yushoufangModel:getBabyScale()
local oldV=math.floor((pass-1)/duration*scaleCfg[3])
local newV=math.floor((pass)/duration*scaleCfg[3])
if newV~=oldV then
local scale=(scaleCfg[2]-scaleCfg[1])*newV/scaleCfg[3]+scaleCfg[1]
self.winlua:SetChildUIModelShowScale(self.babyModel:getID(),scale)
end

if pass>duration then
self:stopTick(2)
self:refreshLingShou_Finish()
end
end

function UILingShouJiaoPeiWin:refreshUpdate_BreakEgg()
local pass=yushoufangModel:getPassDuration(self.data)
local midPercent=yushoufangModel:getMidPercent()
local preTime=math.ceil(self.data.duration*midPercent)
pass=math.max(pass-preTime,0)
local duration=self.data.duration-preTime
self.progressBar:setProgressValue(pass,duration)
self.progressBar:setChildProgressText(timeHelper.format_time_stamp2(duration-pass))
end

function UILingShouJiaoPeiWin:refreshParentsInUnStart(ubdId)
if self.bdData.un_build_id==ubdId and self.state==_state.eUnStart then
self:refreshLingShou_UnStart()
end
end

function UILingShouJiaoPeiWin:fromUnStartToEgg(ubdId)
if self.bdData.un_build_id==ubdId and self.state==_state.eUnStart then
self:refreshLingShou_Egg()
end
end

function UILingShouJiaoPeiWin:refreshFeed(ubdId)
if self.bdData.un_build_id==ubdId and self.state==_state.eEgg then
if not yushoufangModel:isStopMating(self.data)then

local emotTx,emotDuration,emotAnim=yushoufangModel:getFeedEmot()
local emot=chatEmotHelper.decodeEmot(emotTx)or''
if self.fatherHUDWidget:GetChildActiveSelf(1)then
self.fatherHUDWidget:SetChildActive(0,true)
self.fatherHUDWidget:SetChildText(2,emot)
self:delayDo(emotDuration,function()
self.fatherHUDWidget:SetChildActive(0,false)
end)
self.fatherModelWidget:SetChildModelAnimationState(0,emotAnim)
end

if self.motherHUDWidget:GetChildActiveSelf(1)then
self.motherHUDWidget:SetChildActive(0,true)
self.motherHUDWidget:SetChildText(2,emot)
self:delayDo(emotDuration,function()
self.motherHUDWidget:SetChildActive(0,false)
end)
self.motherModelWidget:SetChildModelAnimationState(0,emotAnim)
end

if yushoufangModel:canFeed(self.data)then
local r=math.random(0,1)
local s=r>0
self.fatherHUDWidget:SetChildActive(1,s)
self.motherHUDWidget:SetChildActive(1,not s)
else
self.fatherHUDWidget:SetChildActive(1,false)
self.motherHUDWidget:SetChildActive(1,false)
end

local feedTime=yushoufangModel:getFeedCutTime()
self:killFlowCutTime()
self:doFlowCutTime(feedTime)
end
end
end

function UILingShouJiaoPeiWin:refreshTouch(ubdId)
if self.bdData.un_build_id==ubdId and self.state==_state.eBaby then
if not yushoufangModel:isStopMating(self.data)then
local emotTx,emotDuration,emotAnim,effectEffect=yushoufangModel:getTouchEmot()
local emot=chatEmotHelper.decodeEmot(emotTx)or''
if self.babyHUDWidget:GetChildActiveSelf(1)then
self.babyHUDWidget:SetChildActive(0,true)
self.babyHUDWidget:SetChildText(2,emot)
self:delayDo(emotDuration,function()
self.babyHUDWidget:SetChildActive(0,false)
end)

local data={
["stateId"]=2,
["animDuration"]=emotDuration,
["animId"]=emotAnim,
}
behaviorManager:setSharedValues(self.babyBt,data)
self.babyBt:broke()
self.babyBt:reset()
self.babyBt:tick(0.5)
end

local show=yushoufangModel:canTouch(self.data)
self.babyHUDWidget:SetChildActive(1,show)

local touchTime=yushoufangModel:getTouchCutTime()
self:killFlowCutTime()
self:doFlowCutTime(touchTime)

self.babyEffect:setChildShowEffect(effectEffect,true)
end
end
end

function UILingShouJiaoPeiWin:killFlowCutTime()
if self.flowSeq then
self.flowSeq:Kill(true)
self.flowSeq=nil
end
end

function UILingShouJiaoPeiWin:doFlowCutTime(cTime)
self.winlua:SetChildCanvasGroupAlpha(self.flow:getID(),1)
self.winlua:SetChildAnchoredPosition(self.flow:getID(),Vector2.zero)
self.winlua:SetChildScale(self.flow:getID(),Vector3.zero)
self.flowTx:setText(timeHelper.format_time_stamp2(cTime))

local flowCmpIdx=self.flow:getID()
self.flowSeq=Lua.SequenceProxy.New()
local tweener1=self.winlua:SetChildDOAnchorPosY(flowCmpIdx,100,1.5)
local tweener2=Lua.SequenceProxy.New()
local tweener2_1=self.winlua:SetChildDOScale(flowCmpIdx,2,0.3)
local tweener2_2=self.winlua:SetChildDOScale(flowCmpIdx,1,0.5)
tweener2:Append(tweener2_1)
tweener2:Append(tweener2_2)
local tweener3=Lua.SequenceProxy.New()
local tweener3_1=self.winlua:SetChildCanvasGroupDOFade(flowCmpIdx,0,1.5)
tweener3:AppendInterval(0.5)
tweener3:Append(tweener3_1)
self.flowSeq:Join(tweener1)
self.flowSeq:Join(tweener2)
self.flowSeq:Join(tweener3)
end

function UILingShouJiaoPeiWin:fromFinishToUnStart(ubdId)
if self.bdData.un_build_id==ubdId and self.state==_state.eFinish then
self.data=yushoufangModel:getData(ubdId)
self:refreshLingShou_UnStart()
end
end

function UILingShouJiaoPeiWin:refreshDiscipleState(ubdId)
if self.bdData.un_build_id==ubdId then
self:refreshDisciple()
end
end

function UILingShouJiaoPeiWin:refreshWorkState(ubdId)
if self.bdData.un_build_id==ubdId then
self:refreshLingShou()
end
end

function UILingShouJiaoPeiWin:printData()

end
