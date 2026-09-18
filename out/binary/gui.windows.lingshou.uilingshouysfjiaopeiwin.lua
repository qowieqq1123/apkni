







def_class("UILingShouYSFJiaoPeiWin",UIWindowBase)









function UILingShouYSFJiaoPeiWin:bindComponents()

self.root=UIObject.get(self,0)
self.progressBar=UIProgress.get(self,1)
self.babyModel=UIObject.get(self,2)
self.motherModel=UIObject.get(self,3)
self.fatherModel=UIObject.get(self,4)
self.getBtn=UIButton.get(self,5)
self.costRoot=UIObject.get(self,6)
self.workState=UIObject.get(self,7)
self.dzModel=UIObject.get(self,8)
self.btnDiziAdd=UIButton.get(self,9)
self.btnDiziChange=UIButton.get(self,10)
self.flow=UIObject.get(self,11)
self.babyEffect=UIObject.get(self,12)
self.motherAdd=UIButton.get(self,13)
self.fatherAdd=UIButton.get(self,14)
self.costBtn=UIButton.get(self,15)
self.costTime=UIText.get(self,16)
self.costList=UIObject.get(self,17)
self.scrollView2=UIObject.get(self,18)
self.skill=UIText.get(self,19)
self.dzName=UIText.get(self,20)
self.additionTipsSelected=UIObject.get(self,21)
self.flowTx=UIText.get(self,22)
self.motherHUD=UIObject.get(self,23)
self.babyHUD=UIObject.get(self,24)
self.fatherHUD=UIObject.get(self,25)
self.additionTipsBtn=UIButton.get(self,26)
self.diziInfo=UIObject.get(self,27)
self.diziLock=UIText.get(self,28)
self.spepanel=UIObject.get(self,29)
self.fbSlot1=UIBaseItem.get(self,30)
self.onchange=UIButton.get(self,31)
self.ffpos=UIObject.get(self,32)
self.mmpos=UIObject.get(self,33)
self.progressBar2=UIProgress.get(self,34)
self.babyModel2=UIObject.get(self,35)
self.babyHUD2=UIObject.get(self,36)
self.babyEffect2=UIObject.get(self,37)
self.npcModel=UIObject.get(self,38)
self.speakObj=UIObject.get(self,39)
self.speakText=UIText.get(self,40)
self.npcClicker=UIButton.get(self,41)
self.closeBtn=UIButton.get(self,42)
self.wfjsbtn=UIButton.get(self,43)
self.costpanel=UIObject.get(self,44)
self.costbg1=UIObject.get(self,45)
self.spine1=UIObject.get(self,46)
self.spine2=UIObject.get(self,47)
self.fuhuaeffect=UIObject.get(self,48)
self.feffect=UIObject.get(self,49)
self.meffect=UIObject.get(self,50)
self.fatherclick=UIButton.get(self,51)
self.motherclick=UIButton.get(self,52)
self.fmhand=UIObject.get(self,53)
self.arrowPanel=UIObject.get(self,54)
self.rightArrow=UIButton.get(self,55)
self.leftArrow=UIButton.get(self,56)
self.spine3=UIObject.get(self,57)
self.handpos=UIObject.get(self,58)
self.bypanel=UIObject.get(self,59)
self.bytxt=UIText.get(self,60)
self.bybtn=UIButton.get(self,61)
self.spine4=UIObject.get(self,62)
self.mmhand=UIObject.get(self,63)
self.handpos2=UIObject.get(self,64)
self.babylist=UIObject.get(self,65)

self.getBtn:setButtonClick(function()self:onGetBtn()end)

self.btnDiziAdd:setButtonClick(function()self:onBtnDiziAdd()end)

self.btnDiziChange:setButtonClick(function()self:onBtnDiziChange()end)

self.motherAdd:setButtonClick(function()self:onMotherAdd()end)

self.fatherAdd:setButtonClick(function()self:onFatherAdd()end)

self.costBtn:setButtonClick(function()self:onCostBtn()end)

self.additionTipsBtn:setButtonClick(function()self:onAdditionTipsBtn()end)

self.onchange:setButtonClick(function()self:onOnchange()end)

self.npcClicker:setButtonClick(function()self:onNpcClicker()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.wfjsbtn:setButtonClick(function()self:onWfjsbtn()end)

self.fatherclick:setButtonClick(function()self:onFatherclick()end)

self.motherclick:setButtonClick(function()self:onMotherclick()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.bybtn:setButtonClick(function()self:onBybtn()end)



end


function UILingShouYSFJiaoPeiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.babyModel);self.babyModel=nil;
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
_UIObject_release(self.spepanel);self.spepanel=nil;
_UIObject_release(self.fbSlot1);self.fbSlot1=nil;
_UIObject_release(self.onchange);self.onchange=nil;
_UIObject_release(self.ffpos);self.ffpos=nil;
_UIObject_release(self.mmpos);self.mmpos=nil;
_UIObject_release(self.progressBar2);self.progressBar2=nil;
_UIObject_release(self.babyModel2);self.babyModel2=nil;
_UIObject_release(self.babyHUD2);self.babyHUD2=nil;
_UIObject_release(self.babyEffect2);self.babyEffect2=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.npcClicker);self.npcClicker=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.wfjsbtn);self.wfjsbtn=nil;
_UIObject_release(self.costpanel);self.costpanel=nil;
_UIObject_release(self.costbg1);self.costbg1=nil;
_UIObject_release(self.spine1);self.spine1=nil;
_UIObject_release(self.spine2);self.spine2=nil;
_UIObject_release(self.fuhuaeffect);self.fuhuaeffect=nil;
_UIObject_release(self.feffect);self.feffect=nil;
_UIObject_release(self.meffect);self.meffect=nil;
_UIObject_release(self.fatherclick);self.fatherclick=nil;
_UIObject_release(self.motherclick);self.motherclick=nil;
_UIObject_release(self.fmhand);self.fmhand=nil;
_UIObject_release(self.arrowPanel);self.arrowPanel=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.spine3);self.spine3=nil;
_UIObject_release(self.handpos);self.handpos=nil;
_UIObject_release(self.bypanel);self.bypanel=nil;
_UIObject_release(self.bytxt);self.bytxt=nil;
_UIObject_release(self.bybtn);self.bybtn=nil;
_UIObject_release(self.spine4);self.spine4=nil;
_UIObject_release(self.mmhand);self.mmhand=nil;
_UIObject_release(self.handpos2);self.handpos2=nil;
_UIObject_release(self.babylist);self.babylist=nil;
end
















local _this
local _tick={}
local _state={
eUnStart=0,
eEgg=1,
eBreakEgg=2,
eBaby=3,
eFinish=4,
}
local _temp={}
local fpos_init={-280,-65,0}
local mpos_init={280,-65,0}
local fpos_cs={-870,-80,0}
local mpos_cs={870,-80,0}
local scaleTable={0.3,0.5,0.7,1}
local babyidx=
{
fumo=3,
chengzhang=4,
kaixin=5,
}
local hanposarry=
{
[1]={handy=50,posy=120,scale=0.9,time=1},
[2]={handy=40,posy=90,scale=0.9,time=1},
[3]={handy=40,posy=70,scale=0.7,time=0.5},
[4]={handy=20,posy=50,scale=0.5,time=0.5},
}
local babyItemIndex=
{
selfitem=0,
hudtarget=1,
click=2,
bmspine=3,
babyhud=4,
babyeffect=5,
fmhand=6,
handpos=7,
}




function UILingShouYSFJiaoPeiWin:onLoaded(...)
self:bindComponents()
_this=self
self.ysfbdDatas={}
self.selectid=1
self.oldScale=1
self.isanfuing=false
self.chooseds=0
self.choosecolor=0
self.chooserace=0
self.onethree=1/3
self.twothree=2/3
self.have_new_lsdata2=false
self.isplayfy=false
self.isplayfumo=false
self.bianyilookup={}
self.babyLsWidgetList={}
self.babyLsHUDWidgetList={}
self.babyLsTreeList={}

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)


self.fatherModelWidget=self.fatherModel:getWidgetBase()
self.fatherHUDWidget=self.fatherHUD:getWidgetBase()


self.motherModelWidget=self.motherModel:getWidgetBase()
self.motherHUDWidget=self.motherHUD:getWidgetBase()


self.babyModelWidget=self.babyModel:getWidgetBase()

self.babyModelWidget:SetChildButtonClick(2,function()self:onBabyModel(1)end)
self.babyHUDWidget=self.babyHUD:getWidgetBase()
self.babyHUDWidget:SetChildButtonClick(3,function()self:onBabyBubble(1)end)


self.babyModelWidget2=self.babyModel2:getWidgetBase()

self.babyModelWidget2:SetChildButtonClick(2,function()self:onBabyModel(2)end)
self.babyHUDWidget2=self.babyHUD2:getWidgetBase()
self.babyHUDWidget2:SetChildButtonClick(3,function()self:onBabyBubble(2)end)


local initBtData={
stateId=-1,
cmpWidget=self.babyModelWidget,
cmpIndex=0,
}
self.babyBt=behaviorManager:addBehaviorTree("bt_ui_ysf_baby",nil,true,initBtData)


local initBtData2={
stateId=-1,
cmpWidget=self.babyModelWidget2,
cmpIndex=0,
}
self.babyBt2=behaviorManager:addBehaviorTree("bt_ui_ysf_baby",nil,true,initBtData2)


self.fbSlot1:setBaseItemClickEvent(function(...)
self:onOnchange(...)
end)
self:showWindow("UITopMaskWin")
end


function UILingShouYSFJiaoPeiWin:__delete()
self:unbindComponents()
_temp={}
yushoufangModel:clearLSChooseSingleData(_this.un_build_id)
self:stopAllTick()
uiAIManager:removeUIInstance(self.dzBt)
for index,babyBt in ipairs(self.babyLsTreeList)do
if babyBt then
behaviorManager:removeBehaviorTree(babyBt)
end
end




notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
uiAIManager:clearUIWinData('UILingShouYSFJiaoPeiWin')
self:AnimatclearTimer()
if self.refreshTimeIdshop then
self:stopTimerByID(self.refreshTimeIdshop)
self.refreshTimeIdshop=nil
end
_this=nil
end


function UILingShouYSFJiaoPeiWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.replaceDisciple then
_this:refreshDisciple()
end
end

function UILingShouYSFJiaoPeiWin.on_item_changed(changeType,itemguid,itemid,lastcount,itemcount)
if _this.state==_state.eUnStart then
_this:refreshItemPanel()
end
end

function UILingShouYSFJiaoPeiWin.onDiscipleStateChange(discipleguid,stateType,old,cur)
local dzId=_this.bdData and _this.bdData.dizi_id
local haveDz=dzId and dzId~=int64.zero or false
if haveDz then
if mathHelper.compareInt64(dzId,discipleguid)then
local isPause=UIDiscipleModel:checkDiscipleState2(dzId,DISCIPLE_STATE_TYPE.edsDispatch)
if not isPause then
_this:refreshShopModel()
end
end
end
end


function UILingShouYSFJiaoPeiWin:onBybtn()
local lsid=self.bianyilookup[self.chooserace]
if lsid then
self:showWindow('UILingShouYSFbainyiWin',{lsid=lsid})
end
end

function UILingShouYSFJiaoPeiWin:onWfjsbtn()
local d={}
d.title='玩法介绍'
d.mode=3
d.name='ui_UILingShouYSFJiaoPeiWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UILingShouYSFJiaoPeiWin:onAdditionTipsBtn()
self.additionTipsSelected:setActive(true)
local haveDz=self.bdData.dizi_id and self.bdData.dizi_id~=int64.zero
local skill_id=DISCIPLE_PROSKILL_TYPE.eSiYang
local param={
title={"饲养等级","成长耗时"},
info=cfgHelper.get2(cfg_discipleproskillconfig_get,skill_id,'yushoufang_effect_info'),
level=haveDz and UIDiscipleModel:getDiscipleJobLevel(self.bdData.dizi_id,skill_id)or 0,
callback=function()
if _this then
self.additionTipsSelected:setActive(false)
end
end,
posItem=self.additionTipsBtn,
pos={x=464,y=-142},
}

UIManager:showWindow("UIYSFDZInfoTips",param)
end

function UILingShouYSFJiaoPeiWin:onBtnDiziChange()
self:selectDisciple()
end

function UILingShouYSFJiaoPeiWin:onBtnDiziAdd()
self:selectDisciple()
end

function UILingShouYSFJiaoPeiWin:onWinItemClick()
local itemid=yushoufangModel:getLSItemId()
if itemid~=0 then
tipsManager.showTips({itemid=itemid,itemguid=nil})
else
self:showWindow('UILingShouYSFitemWin')
end
end
function UILingShouYSFJiaoPeiWin:onOnchange(itemid)
UIManager:showWindow('UILingShouYSFitemWin')
end

function UILingShouYSFJiaoPeiWin:onLeftArrow()
if self.changeLock then return end
if self.isplayfumo then
UIManager.info('安抚中，不可切换')
return
end
local similarIndex=self.selectid
if similarIndex then
if similarIndex-1<=0 then
similarIndex=#self.ysfbdDatas
else
similarIndex=similarIndex-1
end
end
self.selectid=similarIndex
local bdData=self.ysfbdDatas[similarIndex]
self.bdData=bdData
self.un_build_id=self.bdData.un_build_id
self:refreshDisciple()

self:BrokeBabyLSTree()








_temp={}
self:refreshLingShouList()
yushoufangModel:clearLSChooseData()

self.changeLock=true
self:delayDo(0.5,function()
self.changeLock=false
end)
end

function UILingShouYSFJiaoPeiWin:onRightArrow()
if self.changeLock then return end
if self.isplayfumo then
UIManager.info('安抚中，不可切换')
return
end
local similarIndex=self.selectid
if similarIndex then
if similarIndex+1>#self.ysfbdDatas then
similarIndex=1
else
similarIndex=similarIndex+1
end
end
self.selectid=similarIndex
local bdData=self.ysfbdDatas[similarIndex]
self.bdData=bdData
self.un_build_id=self.bdData.un_build_id
self:refreshDisciple()

self:BrokeBabyLSTree()








_temp={}
self:refreshLingShouList()
yushoufangModel:clearLSChooseData()

self.changeLock=true
self:delayDo(0.5,function()
self.changeLock=false
end)
end

function UILingShouYSFJiaoPeiWin:onFatherAdd()
if self.state==_state.eUnStart then
self:onParentAdd(1)
end
end

function UILingShouYSFJiaoPeiWin:onMotherAdd()
if self.state==_state.eUnStart then
self:onParentAdd(2)
end
end

function UILingShouYSFJiaoPeiWin:onParentModel(index)

if self.state==_state.eUnStart then
self:onParentAdd(index)
end
end

function UILingShouYSFJiaoPeiWin:onFatherclick()
if self.state==_state.eUnStart then
self:onParentAdd(1)
end
end
function UILingShouYSFJiaoPeiWin:onMotherclick()
if self.state==_state.eUnStart then
self:onParentAdd(2)
end
end

function UILingShouYSFJiaoPeiWin:onParentAdd(posSelidx)
if self.isplayfy then
return
end
local num=lingshouModel:getLSCount()
local maxnum=lingshouModel:getLSMaxCount()
if num>maxnum-self.new_ls_cnt then
return UIManager.error("灵兽数量已满")
end
if tostring(self.bdData.dizi_id)=='0'then
self:onBtnDiziAdd()
return UIManager.error("请先安排弟子")
end
local args={
un_build_id=self.un_build_id,
posSelidx=posSelidx,
callback=function(fGuid,mGuid)
UIManager.info("选择成功")
self:refreshParentsInUnStart(self.un_build_id)
end
}
UIManager:showWindow("UILingShouYSFSelectWin",args)
end

function UILingShouYSFJiaoPeiWin:onBabyModel(index)
if self.state==_state.eBaby or self.state==_state.eFinish then
local isreddot,flag=yushoufangModel.hasReddotInfo(self.un_build_id)
if isreddot and flag==2 then
self:onBabyBubble()
else
local new_lsdatas=yushoufangModel:getLSNewDataByBuildID(self.un_build_id)
local new_lsdata=new_lsdatas[index]
if new_lsdata.word_len and new_lsdata.word_len>0 and new_lsdata.wordList then
new_lsdata.wordList=table.deepCopy(new_lsdata.wordList)
end
new_lsdata.guid_str=tostring(new_lsdata.guid)
lingshouModel:applyLingShouAllWord(new_lsdata)

local temp=
{
lslist={new_lsdata},
lsindex=1,
titleTxt='灵兽详情',
}
yushoufangController:onShowLingShouInfoWin(temp)
end
end
end

function UILingShouYSFJiaoPeiWin:onBabyBubble(index)
if self.state==_state.eBaby then

yushoufangController:send_3_226(_this.un_build_id)
end
end

function UILingShouYSFJiaoPeiWin:onCostBtn()
local num=lingshouModel:getLSCount()
local maxnum=lingshouModel:getLSMaxCount()
if num>maxnum-self.new_ls_cnt then
return UIManager.error("灵兽数量已满")
end
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

local state=UIDiscipleModel:getDiscipleState(self.bdData.dizi_id)
if state==DISCIPLE_STATE_TYPE.eChuiWei then
UIManager.error('弟子垂危中，不可繁衍')
return
end
else
UIManager.error('请先选择饲养弟子')
return
end


local fGuid=self:getLSChooseGuid(1)
local mGuid=self:getLSChooseGuid(2)
if fGuid and mGuid then
local fData=lingshouModel:getLingShouData(fGuid)
local mData=lingshouModel:getLingShouData(mGuid)



local need_love=self.config.need_love
local fxinqing=lingshouModel:getLSXinQingValueEx(fData)or 0
local mxinqing=lingshouModel:getLSXinQingValueEx(mData)or 0
if fxinqing<need_love or mxinqing<need_love then
UIManager.info('灵兽数据有更新')
yushoufangModel:clearLSChooseData()
self:refreshLingShouList()
return
end

local fCfg=fData.cfg
local mCfg=mData.cfg

if fCfg.race==mCfg.race then
local cost_items=self:getLSCostList()
for i,v in ipairs(cost_items)do
local itemCount=itemsModel.getCount(v[1])
if itemCount<v[2]then

local itemName=itemsConfig.getColorName(v[1])
UIManager.info(FMT.fmt("{0}不足",itemName))
gainControl:showCommonGainWin_item(v[1])
return
end
end

local lslist={fGuid,mGuid}
local item_id=yushoufangModel:getLSItemId()
yushoufangController:send_3_224(_this.un_build_id,#lslist,lslist,item_id)
UIManager.info("开始繁衍")
else
UIManager.error('繁衍双亲必须同一种族')
end
else
UIManager.error('请先选择需要繁衍的双亲')
end
end

function UILingShouYSFJiaoPeiWin:onGetBtn()
if self.state==_state.eFinish then
local temp={self.un_build_id}
yushoufangController:send_3_227(#temp,temp)
end
end





function UILingShouYSFJiaoPeiWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end
self.spine1:setChildUIModelShowTarget(5903,1,{},eAnimationID.stand)
self.spine2:setChildUIModelShowTarget(5902,1,{},eAnimationID.stand)
local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end
local entityId=argtable.entityId
self.sfId=zongmenModel:getMountainId()



self.allconfig=cfg_lingshouconfig()
self.config=cfg_lingshoubabybasicconfig_get(1)
self.afjiange=self.config.soothe_conf[1]
self.aftime=self.config.soothe_conf[2]
self.new_ls_cnt=self.config.new_ls_cnt
self.bdData=zongmenModel:findBuildingByEntityId(entityId)
self.un_build_id=self.bdData.un_build_id
self.ysfbdDatas=yushoufangModel:getLSBuildingData()
for k,v1 in ipairs(self.ysfbdDatas)do
if v1.un_build_id==self.un_build_id then
self.selectid=k
break
end
end
self.arrowPanel:setActive(#self.ysfbdDatas>1)

local tabConfig=fullScreenModel.getFullTabConfig(FULL_TAB_TYPE.eYuShouFang)
local money=tabConfig.money
if money then
self:showWindow('UITopMoneyWin',money)
end
self:setBianYiList()
self:refreshDisciple()
self:refreshLingShouList()
end

function UILingShouYSFJiaoPeiWin:onHide()

end
function UILingShouYSFJiaoPeiWin:onCloseBtn()
UIFullYuShouFangControl:closeUI()
end

function UILingShouYSFJiaoPeiWin:doFadeIn(delay,duration)
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



function UILingShouYSFJiaoPeiWin:refreshDisciple()
local dzId=self.bdData.dizi_id
local haveDz=dzId and dzId~=int64.zero or false
local isPause=UIDiscipleModel:checkDiscipleState2(dzId,DISCIPLE_STATE_TYPE.edsDispatch)
self.diziLock:setText("<color=#c82c2c>未安排弟子，无法进行繁衍</color>\n<color=#7d3b17>(饲养等级越高，成长耗时越短)</color>")
self.diziLock:setActive(not haveDz)
self.additionTipsBtn:setActive(haveDz)
self.diziInfo:setActive(haveDz)
self.btnDiziAdd:setActive(not haveDz)
self.btnDiziChange:setActive(haveDz or isPause)

if haveDz then
local name=UIDiscipleModel:getDiscipleName(dzId)
self.dzName:setText(FMT.fmt("执事弟子：<color=#7d3b17>{0}</color>",name))

local skill_id=DISCIPLE_PROSKILL_TYPE.eSiYang
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
self.skill:setText(FMT.fmt("{0}：<color=#ca631d>{1}级</color>",skill_cfg.name,level))

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


self:stopbubble()
else
self:refreshShopModel()
end
else

self:stopbubble()
self.workState:setActive(true)

end
end
function UILingShouYSFJiaoPeiWin:createDiscipleModel()
local UIstateId=0
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=1,
leftPos={0,-40},
rightPos={100,-40},
waitspeak=1,
winName="UILingShouYSFJiaoPeiWin",
}
local tran=self.dzModel:getCommonComponent('Transform')
local vpos=Vector2.New(0,-40)
uiAIManager:createUIDisciple('UILingShouYSFJiaoPeiWin','bt_ui_buiding_dizi',self.bdData.dizi_id,tran,vpos,initData,nil,function(bt)
self.dzBt=bt
end)
end
function UILingShouYSFJiaoPeiWin:getSpeakText(bt,tkey)
local diziGuid=self.bdData.dizi_id
local hasDizi=diziGuid and diziGuid~=int64.zero or false
local txt=nil
if hasDizi then
if self.state==_state.eUnStart then
local fGuid=self:getLSChooseGuid(1)
local mGuid=self:getLSChooseGuid(2)
local haveFather=fGuid and true
local haveMother=mGuid and true
local selected=haveFather and haveMother
if not selected then
txt="请选择灵兽"
end
elseif self.state==_state.eEgg then

elseif self.state==_state.eBreakEgg then

elseif self.state==_state.eBaby then
txt=self:getBuildSpeakConfig(diziGuid,"yushou_baby_speak")
elseif self.state==_state.eFinish then
txt=self:getBuildSpeakConfig(diziGuid,"yushou_egg_speak")
end
end
if txt then
bt:setSharedVar(tkey,txt)
end
end
function UILingShouYSFJiaoPeiWin:getBuildSpeakConfig(diziguid,colName)
local voc=UIDiscipleModel:getDiscipleJob(diziguid)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,colName)
if speakList and next(speakList)then
local txt=speakList[math.random(1,#speakList)]or''
return txt
else
return nil
end
end

function UILingShouYSFJiaoPeiWin:selectDisciple()
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
elseif self.state==_state.eBaby then
UIManager.error('灵兽成长中，不可更换')
return
end
end
zongmenControl:showSelectManagerWin(self.sfId,self.bdData)
end

function UILingShouYSFJiaoPeiWin:refreshShopModel()
local dzguid=self.bdData.dizi_id
local state=UIDiscipleModel:getDiscipleState(dzguid)
local chuiwei=state==DISCIPLE_STATE_TYPE.eChuiWei
self.npcModel:setActive(true)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid)
modelParams.anim=mountHelper.getMountAni(dzguid,modelParams.anim)
if chuiwei then
modelParams.body=UIDiscipleModel:getDiscipleSex(dzguid)==1 and 1114103 or 1114104
modelParams.componets=nil
self.npcModel:setChildUIModelShowTarget(modelParams.body,1.5,modelParams.componets,modelParams.anim,false,false)
self.npcModel:setChildUIModelShowFlipX(true)
if self.refreshTimeIdshop then
self:stopTimerByID(self.refreshTimeIdshop)
self.refreshTimeIdshop=nil
end
else
self.npcModel:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,modelParams.anim,false,false)
self.npcModel:setChildUIModelShowFlipX(true)

self:refreshShopbubble()
end
end

function UILingShouYSFJiaoPeiWin:stopbubble()
if self.refreshTimeIdshop then
self:stopTimerByID(self.refreshTimeIdshop)
self.refreshTimeIdshop=nil
end
self.npcModel:setActive(false)
end

function UILingShouYSFJiaoPeiWin:refreshShopbubble()
if self.refreshTimeIdshop then
self:stopTimerByID(self.refreshTimeIdshop)
self.refreshTimeIdshop=nil
end
self.refreshTimeFunshop=function()
_this:doSpeaking_player()
end
self.refreshTimeFunshop()
local shoptime=10
self.refreshTimeIdshop=self:setTimer(shoptime,0,self.refreshTimeFunshop)
end

function UILingShouYSFJiaoPeiWin:doSpeaking_player()
local speakStr=nil
local diziGuid=self.bdData.dizi_id
local state=_state.eUnStart
local data=yushoufangModel:getLSDataByBuildID(self.un_build_id)
if data then
local nowTime=timeHelper.getServerShortTime()
local group_end_time=data.group_end_time
if group_end_time==0 then
state=_state.eUnStart
elseif group_end_time>nowTime then
state=_state.eBaby
else
state=_state.eFinish
end
else
state=_state.eUnStart
end

if state==_state.eUnStart then
local fGuid=self:getLSChooseGuid(1)
local mGuid=self:getLSChooseGuid(2)
local haveFather=fGuid and true
local haveMother=mGuid and true
local selected=haveFather and haveMother
if not selected then
speakStr="请选择灵兽"
end
elseif state==_state.eFinish then
speakStr=self:getBuildSpeakConfig(diziGuid,"yushou_egg_speak")

elseif state==_state.eBaby then
speakStr=self:getBuildSpeakConfig(diziGuid,"yushou_baby_speak")
end
if speakStr then
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim_player()
end
end

function UILingShouYSFJiaoPeiWin:doTalkAnim_player()
if self.talkTween2~=nil then
self.talkTween2:Kill()
self.talkTween2=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.2,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween2=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
self.talkTween2=nil
self.talkTween2=self.speakObj:setChildDOScale(0.9,0.1,function()
if _this==nil then return end
self.talkTween2=nil
return self:talkEnd()
end)
end)
end)
end
function UILingShouYSFJiaoPeiWin:talkEnd()
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
self.speakShowTimer=self:delayDo(3.5,function()

if _this==nil then return end
self.speakObj:setScale(Vector3.zero)
self.speakObj:setChildCanvasGroupAlpha(0)

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end)
end



function UILingShouYSFJiaoPeiWin:getLSChooseGuid(posidx)
return yushoufangModel:getLSChooseData(self.un_build_id,posidx)
end

function UILingShouYSFJiaoPeiWin:setLSChooseGuid(posidx,lsguid)
yushoufangModel:setLSChooseData(self.un_build_id,posidx,lsguid)
end

function UILingShouYSFJiaoPeiWin:setModelByGuid(cmp,lsGuid,flip)
local index=flip and 1 or 2
if lsGuid then
if _temp[index]~=lsGuid then
local modelParams=lingshouModel:getModelParams(lsGuid)
cmp:SetChildUIModelShowTarget(0,modelParams.body,1,modelParams.componets,0,false,true)
cmp:SetChildUIModelShowTargetOffset(0,0,-50)
cmp:SetChildUIModelShowFlipX(0,flip or false)
_temp[index]=lsGuid
end
else
cmp:SetChildUIModelRemoveTarget(0)
_temp[index]=nil
end
end

function UILingShouYSFJiaoPeiWin:setModelById(_index,guid_key,flip,_scale,id)

local scale=_scale or 1
if id then
if not _temp[guid_key]then
local babyCfg=cfgHelper.get1(cfg_lingshouconfig_get,id)
if _index==1 then
self.babyModelWidget:SetChildUIModelShowTarget(0,babyCfg.model,scale,{},0)
self.babyModelWidget:SetChildUIModelShowTargetOffset(0,0,0)
elseif _index==2 then
self.babyModelWidget2:SetChildUIModelShowTarget(0,babyCfg.model,scale,{},0)
self.babyModelWidget2:SetChildUIModelShowTargetOffset(0,0,0)
end
_temp[guid_key]=true
end
else
if _index==1 then
self.babyModelWidget:SetChildUIModelRemoveTarget(0)
elseif _index==2 then
self.babyModelWidget2:SetChildUIModelRemoveTarget(0)
end
_temp[guid_key]=nil
end
end

function UILingShouYSFJiaoPeiWin:startTick(index,callback)
if callback then
self:stopTick(index)
_tick[index]=self:setTimer(1,0,callback)
end
end
function UILingShouYSFJiaoPeiWin:stopTick(index)
if _tick[index]then
self:stopTimerByID(_tick[index])
_tick[index]=nil
end
end
function UILingShouYSFJiaoPeiWin:stopAllTick()
for i,v in pairs(_tick)do
self:stopTick(i)
end
end

function UILingShouYSFJiaoPeiWin:getScale(group_begin_time,group_end_time)
local nowtime=timeHelper.getServerShortTime()
local maxtime=group_end_time-group_begin_time
local expiretime=group_end_time-nowtime
local passtime=maxtime-expiretime
local chatiem=group_end_time-group_begin_time

if nowtime>group_end_time then
return scaleTable[4]
else
local value=passtime/chatiem

if value>0 and value<=self.onethree then
return scaleTable[1]
elseif value>self.onethree and value<=self.twothree then
return scaleTable[2]
elseif value>self.twothree and value<=0.9 then
return scaleTable[3]
elseif value>0.9 and value<=1 then
return scaleTable[4]
end
end
return scaleTable[1]
end

function UILingShouYSFJiaoPeiWin:getLSCostList()
local maxcolor=3
local fGuid=self:getLSChooseGuid(1)
local mGuid=self:getLSChooseGuid(2)
local tmep={}
local lsdata1=lingshouModel:getLingShouData(fGuid)
if lsdata1 then
maxcolor=lsdata1.cfg.color
local born_cost=table.weakCopy(lsdata1.cfg.born_cost)
if born_cost then
for index,data in ipairs(born_cost)do
local itemID=data[1]
local itemCount=data[2]
local rate1=lingshouModel.getLingShouPropertyVal(lsdata1,lingshouPropertyType.FANYAN_COST_ITEM_RATE,itemID)or 0
itemCount=mathHelper.safe_ceil(itemCount*(1+rate1))

table.insert(tmep,{itemID,itemCount})
end
end
end
local lsdata2=lingshouModel:getLingShouData(mGuid)
if lsdata2 then
if maxcolor<lsdata2.cfg.color then
maxcolor=lsdata2.cfg.color
end
local born_cost=table.weakCopy(lsdata2.cfg.born_cost)
if born_cost then
for index,data in ipairs(born_cost)do
local itemID=data[1]
local itemCount=data[2]
local rate2=lingshouModel.getLingShouPropertyVal(lsdata2,lingshouPropertyType.FANYAN_COST_ITEM_RATE,itemID)or 0
itemCount=mathHelper.safe_ceil(itemCount*(1+rate2))

table.insert(tmep,{itemID,itemCount})
end
end
end
local cost_items=self.config.cost_items[self.chooseds][maxcolor]
if cost_items then
local cost_items2=table.weakCopy(cost_items)
for k,v in ipairs(cost_items2)do
table.insert(tmep,v)
end
end

local temp2={}
local templook2={}
for k,v in ipairs(tmep)do
local itemId=v[1]
local num=v[2]
if templook2[itemId]then

templook2[itemId][2]=templook2[itemId][2]+num
else

temp2[#temp2+1]={itemId,num}
templook2[itemId]=temp2[#temp2]
end
end



















return temp2
end



function UILingShouYSFJiaoPeiWin:freshsever_FanYan()
if _this==nil then return end

_this:showLingShou_Animat()
end

function UILingShouYSFJiaoPeiWin:freshsever_LingQu()
if _this==nil then return end

_this.state=_state.eUnStart
_this:refreshLingShouList()
end

function UILingShouYSFJiaoPeiWin:freshsever_FuMo()
if _this==nil then return end
_this.isanfuing=false

_this:playfumoAnimat()
end

function UILingShouYSFJiaoPeiWin:refreshParentsInUnStart(ubdId)
if self.un_build_id==ubdId and self.state==_state.eUnStart then
self:refreshLingShou_UnStart()
end
end



function UILingShouYSFJiaoPeiWin:refreshItemPanel()
local fGuid=self:getLSChooseGuid(1)
local mGuid=self:getLSChooseGuid(2)
if fGuid and mGuid then
local cost_items=self:getLSCostList()
local num=cost_items and#cost_items or 0

self.costList:setChildLayoutGroupCreateItems(num,function(index)
local itemCfg=cost_items[index]
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
end
end

function UILingShouYSFJiaoPeiWin:refreshSpeSlot()
local itemID=yushoufangModel:getLSItemId()
local item
if itemID~=0 then
item={itemid=itemID,itemguid=nil}
end
local prop={}

if item then
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stage=itemConfig.stage and FMT.fmt('{0}阶',itemConfig.stage)or''
local iconName=itemsModel.getIconName(item)
local name=""
local reddot=false
prop[PropIndex(DataPropKey.eWidgetQuality,0)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetActive,3)]=false
prop[PropIndex(DataPropKey.eWidgetText,4)]=stage
prop[PropIndex(DataPropKey.eWidgetActive,5)]=reddot
prop[PropIndex(DataPropKey.eWidgetText,6)]=name
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid or-1
_this.onchange:setActive(true)
else

local showAdd=true
local name=''
local reddot=false
prop[PropIndex(DataPropKey.eWidgetActive,0)]=false
prop[PropIndex(DataPropKey.eWidgetActive,1)]=false
prop[PropIndex(DataPropKey.eWidgetActive,2)]=showAdd
prop[PropIndex(DataPropKey.eWidgetActive,3)]=false
prop[PropIndex(DataPropKey.eWidgetActive,5)]=reddot
prop[PropIndex(DataPropKey.eWidgetText,6)]=name
prop[DataPropKey.eItemID]=-1
prop[DataPropKey.eItemSeries]=-1
_this.onchange:setActive(false)
end
_this.fbSlot1:setChildPropData(prop)
end

function UILingShouYSFJiaoPeiWin:refreshLingShouList()
self.have_new_lsdata2=false
self.isplayfumo=false
self.progressBar2:setActive(false)
self.feffect:setChildShowEffect(0,false)
self.meffect:setChildShowEffect(0,false)
local nowTime=timeHelper.getServerShortTime()
local data=yushoufangModel:getLSDataByBuildID(self.un_build_id)

if data then
local group_end_time=data.group_end_time
if group_end_time==0 then
self:refreshLingShou_UnStart()
elseif group_end_time>nowTime then
self:refreshLingShou_Baby()
else
self:refreshLingShou_Finish()
end
else
self:refreshLingShou_UnStart()
end
end

function UILingShouYSFJiaoPeiWin:showLingShou_Animat()



self.isplayfy=true
self.feffect:setChildShowEffect(0,false)
self.meffect:setChildShowEffect(0,false)
self.fuhuaeffect:setChildShowEffect(0,false)

self.arrowPanel:setChildCanvasGroupDOFade(0,0.3,nil)
self.costRoot:setChildCanvasGroupDOFade(0,0.3,nil)
self.fatherModel:setChildCanvasGroupDOFade(0,0.3,nil)
self.motherModel:setChildCanvasGroupDOFade(0,0.3,nil)


self.fatherModel:setLocalPos(fpos_cs[1],fpos_cs[2],fpos_cs[3])
self.motherModel:setLocalPos(mpos_cs[1],mpos_cs[2],mpos_cs[3])
self.fatherModelWidget:SetChildModelAnimationState(0,eAnimationID.run,1)
self.motherModelWidget:SetChildModelAnimationState(0,eAnimationID.run,1)

self:delayDo(0.5,function()
if _this==nil then return end
self.costRoot:setActive(false)
self.costRoot:setChildCanvasGroupAlpha(1)
self.arrowPanel:setActive(false)
self.arrowPanel:setChildCanvasGroupAlpha(1)
self.fatherModel:setChildCanvasGroupAlpha(1)
self.motherModel:setChildCanvasGroupAlpha(1)

self:AnimatstartTimer()


local fpos=self.ffpos:getChildPosition()
local tweener=_this.winlua:SetChildDOMove(_this.fatherModel:getID(),fpos,2.5,function()
if _this==nil then return end
self.fatherModelWidget:SetChildModelAnimationState(0,eAnimationID.stand,1)
end)
tweener:SetEase(_Ease.Linear)
local mpos=self.mmpos:getChildPosition()
local tweener2=_this.winlua:SetChildDOMove(_this.motherModel:getID(),mpos,2.5,function()
if _this==nil then return end
self.motherModelWidget:SetChildModelAnimationState(0,eAnimationID.stand,1)
end)
tweener2:SetEase(_Ease.Linear)
end)
self:delayDo(3,function()
if _this==nil then return end
self.spine4:setActive(true)
self.spine4:setChildUIModelShowTarget(5904,1,{},3670)
end)
self:delayDo(7.3,function()
if _this==nil then return end
self.fuhuaeffect:setChildShowEffect(10684,true)
end)
end

function UILingShouYSFJiaoPeiWin:AnimatstartTimer()
self:AnimatclearTimer()
self.progressBar2:setActive(true)
local endsec=8+timeHelper.getServerShortTime()
local num2=8
local num=0
local tick=function()
local stamp=timeHelper.getServerShortTime()
if endsec>=stamp then
num=num+0.2
self.progressBar2:setProgressValue(num*100,num2*100)
else
self:AnimatclearTimer()
self.progressBar2:setActive(false)


self.fatherModel:setChildCanvasGroupDOFade(0,0.7,function()
self.fuhuaeffect:setChildShowEffect(0,false)
self.fatherModel:setActive(false)
self.fatherModel:setChildCanvasGroupAlpha(1)
end)
self.motherModel:setChildCanvasGroupDOFade(0,0.7,function()
self.motherModel:setActive(false)
self.motherModel:setChildCanvasGroupAlpha(1)
end)
self:delayDo(0.9,function()
if _this==nil then return end
self:refreshLingShou_Baby()
end)
end
end
tick()
self.timera=self:setTimer(0.2,0,tick)
end
function UILingShouYSFJiaoPeiWin:AnimatclearTimer()
if self.timera then
self:stopTimerByID(self.timera)
self.timera=nil
end
end

function UILingShouYSFJiaoPeiWin:refreshLingShou_UnStart()
self.state=_state.eUnStart
self.fatherModel:setActive(true)
self.motherModel:setActive(true)
self.babyModel:setActive(false)
self.babyModel2:setActive(false)
self.babylist:setActive(false)
self.arrowPanel:setActive(#self.ysfbdDatas>1)
self.spine3:setActive(false)


self.fatherModel:setLocalPos(fpos_init[1],fpos_init[2],fpos_init[3])
self.motherModel:setLocalPos(mpos_init[1],mpos_init[2],mpos_init[3])
self.feffect:setLocalPos(fpos_init[1],fpos_init[2]-50,fpos_init[3])
self.meffect:setLocalPos(mpos_init[1],mpos_init[2]-50,mpos_init[3])

local fGuid=self:getLSChooseGuid(1)
local mGuid=self:getLSChooseGuid(2)
self.chooseds=0
self.choosecolor=0
self.chooserace=0
if fGuid then
local lsdata=lingshouModel:getLingShouData(fGuid)
self.chooseds=lsdata.generation
self.choosecolor=lsdata.cfg.color
self.chooserace=lsdata.cfg.race
end
if mGuid then
local lsdata=lingshouModel:getLingShouData(mGuid)
self.chooseds=lsdata.generation
self.choosecolor=lsdata.cfg.color
self.chooserace=lsdata.cfg.race
end
self:setModelByGuid(self.fatherModelWidget,fGuid,true)
self:setModelByGuid(self.motherModelWidget,mGuid,false)

local haveFather=fGuid and true
local haveMother=mGuid and true
self.fatherAdd:setActive(not haveFather)
self.motherAdd:setActive(not haveMother)
self.fatherclick:setActive(haveFather)
self.motherclick:setActive(haveFather)
self.fatherHUDWidget:SetChildActive(1,false)
self.motherHUDWidget:SetChildActive(1,false)


local selected=haveFather and haveMother
self.costRoot:setActive(selected)
self.progressBar:setActive(false)
self.getBtn:setActive(false)

self.bybtn:setActive(false)
local lsid=self.bianyilookup[self.chooserace]
if lsid then
local config=cfgHelper.get(cfg_lingshouconfig_get,lsid)
if config and config.ysfbianyi then
self.bybtn:setActive(true)
end
end

if haveFather then
self.feffect:setChildShowEffect(10683,true)
else
self.feffect:setChildShowEffect(0,false)
end
if haveMother then
self.meffect:setChildShowEffect(10683,true)
else
self.meffect:setChildShowEffect(0,false)
end

if selected then

self:refreshSpeSlot()

local bianyi=self.config.bianyi
if bianyi and bianyi[self.chooseds]and bianyi[self.chooseds][self.choosecolor]then
local flsdata=lingshouModel:getLingShouData(fGuid)
local fnum=lingshouModel.getLingShouPropertyVal(flsdata,lingshouPropertyType.FANYAN_SINGLE_BIANYI_RATE)or 0
local mlsdata=lingshouModel:getLingShouData(mGuid)
local mnum=lingshouModel.getLingShouPropertyVal(mlsdata,lingshouPropertyType.FANYAN_SINGLE_BIANYI_RATE)or 0
local num=math.max(fnum,mnum)
if num>0 then
num=num/100
end
if num>100 then
num=100
end
self.bypanel:setActive(true)
self.bytxt:setText(num)
else
self.bypanel:setActive(false)
end

local cost_items=self:getLSCostList()
local num=cost_items and#cost_items or 0
if num>2 then
self.spepanel:setLocalPosX(295)
self.costpanel:setLocalPosX(-145)
self.costbg1:setChildSizeDelta(390,81)
else
self.spepanel:setLocalPosX(270)
self.costpanel:setLocalPosX(-71)
self.costbg1:setChildSizeDelta(300,81)
end


self.costList:setChildLayoutGroupCreateItems(num,function(index)
local itemCfg=cost_items[index]
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





end
self:stopAllTick()
end

function UILingShouYSFJiaoPeiWin:refreshLingShou_Baby()
self.state=_state.eBaby
self.isplayfy=false
self.fatherModel:setActive(false)
self.motherModel:setActive(false)
self.fatherAdd:setActive(false)
self.motherAdd:setActive(false)
self.fatherclick:setActive(false)
self.motherclick:setActive(false)
self.babyModel:setActive(true)
self.babyModel2:setActive(true)
self.babylist:setActive(true)
self:setModelByGuid(self.fatherModelWidget,nil,true)
self:setModelByGuid(self.motherModelWidget,nil,false)
self.arrowPanel:setActive(#self.ysfbdDatas>1)
self.spine3:setActive(true)
self.spine3:setChildUIModelShowTarget(5905,1,{},eAnimationID.enter)
self.spine4:setActive(false)


self:initBabyLSlist()
self:iniBabyLSHudList()
self:iniBabyLSTreelist()


self.babyHUDWidget:SetChildActive(babyidx.fumo,false)
self.babyHUDWidget:SetChildActive(babyidx.kaixin,false)
self:checkfumo()


self.costRoot:setActive(false)
self.getBtn:setActive(false)
self.progressBar:setActive(true)


local data=yushoufangModel:getLSDataByBuildID(self.un_build_id)
local group_end_time=0
local group_begin_time=0
if data then
group_end_time=data.group_end_time
group_begin_time=data.group_begin_time
end
local scale=self:getScale(group_begin_time,group_end_time)
self.oldScale=scale


self:setBabyLSBehavior()






























local nowtime=timeHelper.getServerShortTime()
if group_end_time>0 and group_end_time>nowtime then
local maxtime=group_end_time-group_begin_time
local expiretime=group_end_time-nowtime
local passtime=maxtime-expiretime
self.progressBar:setProgressValue(passtime,maxtime)
self.progressBar:setChildProgressText(timeHelper.format_time_stamp2(group_end_time-nowtime))

local soothe_time=data.soothe_time
local canfm=soothe_time+self.afjiange
if canfm<nowtime then

self:setBabyLSCanFuMo(1)






end


self:startTick(2,function()
self:refreshUpdate_Baby(group_end_time,group_begin_time)
end)
else
self.progressBar:setProgressValue(100,100)
self.progressBar:setChildProgressText("已完成")
self.babyHUDWidget:SetChildActive(1,false)
self:refreshLingShou_Finish()
self:stopAllTick()
end
end

function UILingShouYSFJiaoPeiWin:refreshUpdate_Baby(group_end_time,group_begin_time)
local scale=self:getScale(group_begin_time,group_end_time)
if self.oldScale~=scale then














self:setBabyLSScaleBehavior(scale)
self.oldScale=scale
end
local endtime=group_end_time
local begintime=group_begin_time
local nowtime=timeHelper.getServerShortTime()
if endtime>0 then
self:checkfumo()
local maxtime=endtime-begintime
local expiretime=endtime-nowtime
local passtime=maxtime-expiretime
self.progressBar:setProgressValue(passtime,maxtime)
self.progressBar:setChildProgressText(timeHelper.format_time_stamp2(endtime-nowtime))

if nowtime>=endtime then
self:stopTick(2)
self.progressBar:setProgressValue(100,100)
self.progressBar:setChildProgressText("已完成")
self:refreshLingShou_Finish()
end
end
end

function UILingShouYSFJiaoPeiWin:refreshLingShou_Finish()
self.state=_state.eFinish

self.fatherModel:setActive(false)
self.motherModel:setActive(false)
self.fatherAdd:setActive(false)
self.motherAdd:setActive(false)
self.fatherclick:setActive(false)
self.motherclick:setActive(false)
self.babyModel:setActive(true)
self.babyModel2:setActive(true)
self.babylist:setActive(true)

self:setModelByGuid(self.fatherModelWidget,nil,true)
self:setModelByGuid(self.motherModelWidget,nil,false)
self.arrowPanel:setActive(#self.ysfbdDatas>1)
self.spine3:setActive(false)
self.spine4:setActive(false)


self:initBabyLSlist()
self:iniBabyLSHudList()
self:iniBabyLSTreelist()


self:setBabyLSInitFuMo(1)






self.costRoot:setActive(false)
self.getBtn:setActive(true)
self.progressBar:setActive(true)
self.progressBar:setProgressValue(100,100)
self.progressBar:setChildProgressText("灵兽已成长")


self:setBabyLSBehavior_Finish()























self:stopAllTick()
end

function UILingShouYSFJiaoPeiWin:setBianYiList()
for k,v in pairs(self.allconfig)do
if v.bianyi==1 then
self.bianyilookup[v.race]=v.id
end
end
end



function UILingShouYSFJiaoPeiWin:initBabyLSlist()
self.babyLsWidgetList={}
local new_lsdatas=yushoufangModel:getLSNewDataByBuildID(self.un_build_id)
if new_lsdatas then
local Allwidget=self.babylist:getWidgetBase()
for index=1,8 do
local babywidget=Allwidget:GetChildWidgetBase(index-1)
local new_lsdata=new_lsdatas[index]
if new_lsdata then
babywidget:SetChildActive(babyItemIndex.selfitem,true)
babywidget:SetChildButtonClick(2,function()self:onBabyModel(index)end)
self.babyLsWidgetList[#self.babyLsWidgetList+1]=babywidget
else
babywidget:SetChildActive(babyItemIndex.selfitem,false)
end
end
end
end

function UILingShouYSFJiaoPeiWin:iniBabyLSHudList()
self.babyLsHUDWidgetList={}
for index,widget in ipairs(self.babyLsWidgetList)do
local babyHUDWidget=widget:GetChildWidgetBase(babyItemIndex.babyhud)
babyHUDWidget:SetChildButtonClick(3,function()self:onBabyBubble(index)end)
self.babyLsHUDWidgetList[#self.babyLsHUDWidgetList+1]=babyHUDWidget
end
end

function UILingShouYSFJiaoPeiWin:iniBabyLSTreelist()
if self.babyLsTreeList then
for index,babyBt in ipairs(self.babyLsTreeList)do
if babyBt then
behaviorManager:removeBehaviorTree(babyBt)
end
end
end
self.babyLsTreeList={}
for index,widget in ipairs(self.babyLsWidgetList)do

local initBtData={
stateId=-1,
cmpWidget=widget,
cmpIndex=0,
}
local babyBt=behaviorManager:addBehaviorTree("bt_ui_ysf_baby",nil,true,initBtData)
self.babyLsTreeList[#self.babyLsTreeList+1]=babyBt
end
end

function UILingShouYSFJiaoPeiWin:setNewModelById(babyWidget,guid_key,_scale,id)
local scale=_scale or 1
if id then
if not _temp[guid_key]then
local babyCfg=cfgHelper.get1(cfg_lingshouconfig_get,id)
babyWidget:SetChildUIModelShowTarget(0,babyCfg.model,scale,{},0)
babyWidget:SetChildUIModelShowTargetOffset(0,0,0)
_temp[guid_key]=true
end
else
babyWidget:SetChildUIModelRemoveTarget(0)
_temp[guid_key]=nil
end
end

function UILingShouYSFJiaoPeiWin:setBabyLSBehavior()
local new_lsdatas=yushoufangModel:getLSNewDataByBuildID(self.un_build_id)
for index,widget in ipairs(self.babyLsWidgetList)do
local new_lsdata=new_lsdatas[index]
if new_lsdata then

local babyBt=self.babyLsTreeList[index]
local guid_key=tostring(new_lsdata.guid)
local lsid=new_lsdata.id
local scale=self.oldScale
if scale<=0.5 then
widget:SetChildLocalPosY(babyItemIndex.babyhud,0)
elseif scale<=0.7 then
widget:SetChildLocalPosY(babyItemIndex.babyhud,-20)
else
widget:SetChildLocalPosY(babyItemIndex.babyhud,-60)
end

self:setNewModelById(widget,guid_key,scale,lsid)

behaviorManager:setSharedValues(babyBt,{["stateId"]=1})
babyBt:broke()
babyBt:reset()
babyBt:tick(0.5)
end
end
end

function UILingShouYSFJiaoPeiWin:setBabyLSScaleBehavior(scale)
for index,widget in ipairs(self.babyLsWidgetList)do
if scale<=0.5 then
widget:SetChildLocalPosY(babyItemIndex.babyhud,0)
elseif scale<=0.7 then
widget:SetChildLocalPosY(babyItemIndex.babyhud,-20)
else
widget:SetChildLocalPosY(babyItemIndex.babyhud,-60)
end
widget:SetChildUIModelShowScale(babyItemIndex.selfitem,scale)
end
end

function UILingShouYSFJiaoPeiWin:setBabyLSBehavior_Finish()
local new_lsdatas=yushoufangModel:getLSNewDataByBuildID(self.un_build_id)
local len=#self.babyLsWidgetList
for index,widget in ipairs(self.babyLsWidgetList)do
local new_lsdata=new_lsdatas[index]
if new_lsdata then
local babyBt=self.babyLsTreeList[index]
local guid_key=tostring(new_lsdata.guid)
local lsid=new_lsdata.id

self:setNewModelById(widget,guid_key,1,lsid)

if len==1 then
behaviorManager:setSharedValues(babyBt,{["stateId"]=0})
else
behaviorManager:setSharedValues(babyBt,{["stateId"]=1})
end
babyBt:broke()
babyBt:reset()
babyBt:tick(0.5)
end
end
end

function UILingShouYSFJiaoPeiWin:hideBabyLSWidget(flag)
for index,widget in ipairs(self.babyLsWidgetList)do
widget:SetChildActive(babyItemIndex.selfitem,flag)
end
end

function UILingShouYSFJiaoPeiWin:BrokeBabyLSTree()
for index,babyBt in ipairs(self.babyLsTreeList)do
if babyBt then
babyBt:broke()
end
end
end

function UILingShouYSFJiaoPeiWin:BrokeBabyLSTreeSingle(index)
local babyBt=self.babyLsTreeList[index]
if babyBt then
babyBt:broke()
end
end

function UILingShouYSFJiaoPeiWin:ResetBabyLSTreeSingle(index)
local babyBt=self.babyLsTreeList[index]
if babyBt then
babyBt:reset()
babyBt:tick(0.5)
end
end

function UILingShouYSFJiaoPeiWin:showBabyLSFuMoSingle(index,hanarry)
local widget=self.babyLsWidgetList[index]
if widget then
widget:SetChildLocalPosX(babyItemIndex.fmhand,0)
widget:SetChildLocalPosY(babyItemIndex.fmhand,hanarry.handy)
widget:SetChildScale(babyItemIndex.fmhand,Vector3.New(hanarry.scale,hanarry.scale,hanarry.scale))
widget:SetChildLocalPosY(babyItemIndex.handpos,hanarry.posy)
local pos=widget:GetChildPosition(babyItemIndex.handpos)
self.tweener=widget:SetChildDOMove(babyItemIndex.fmhand,pos,hanarry.time)
self.tweener:SetEase(_Ease.Linear)
self.tweener:SetLoops(-1,_LoopType.Yoyo)
widget:SetChildCanvasGroupDOFade(babyItemIndex.fmhand,1,0.2,nil)
end
end

function UILingShouYSFJiaoPeiWin:stopBabyLSFuMoSingle(index,hanarry)
local widget=self.babyLsWidgetList[index]
if widget then
widget:SetChildCanvasGroupDOFade(babyItemIndex.fmhand,0,0.2,function()
if _this==nil then return end
if self.tweener~=nil then
self.tweener:Kill()
self.tweener=nil
widget:SetChildLocalPosY(babyItemIndex.fmhand,hanarry.handy)
end
end)
end
end

function UILingShouYSFJiaoPeiWin:setBabyLSInitFuMo(index)
local HUDWidget=self.babyLsHUDWidgetList[index]
if HUDWidget then
HUDWidget:SetChildActive(babyidx.fumo,false)
HUDWidget:SetChildActive(babyidx.kaixin,false)
end
end

function UILingShouYSFJiaoPeiWin:setBabyLSCanFuMo(index)
local HUDWidget=self.babyLsHUDWidgetList[index]
if HUDWidget then
HUDWidget:SetChildActive(babyidx.fumo,true)
HUDWidget:SetChildActive(babyidx.kaixin,false)
self.isanfuing=true
end
end

function UILingShouYSFJiaoPeiWin:setBabyLSNoFuMo(index)
local HUDWidget=self.babyLsHUDWidgetList[index]
if HUDWidget then
HUDWidget:SetChildActive(babyidx.fumo,false)
HUDWidget:SetChildActive(babyidx.kaixin,true)
end
end




function UILingShouYSFJiaoPeiWin:checkfumo()
if not self.isanfuing and self.state==_state.eBaby then
local data=yushoufangModel:getLSDataByBuildID(self.un_build_id)
if data then
local soothe_time=data.soothe_time
local nowtime=timeHelper.getServerShortTime()
local canfm=soothe_time+self.afjiange
if canfm<nowtime then

self:setBabyLSCanFuMo(1)






end
end
end
end

function UILingShouYSFJiaoPeiWin:playfumoAnimat()


self.isplayfumo=true


self:BrokeBabyLSTreeSingle(1)





local hanarry=hanposarry[1]
local data=yushoufangModel:getLSDataByBuildID(self.un_build_id)
if data then
local group_end_time=data.group_end_time
local group_begin_time=data.group_begin_time
local scale=self:getScale(group_begin_time,group_end_time)
if scale<=0.3 then
hanarry=hanposarry[4]
elseif scale<=0.5 then
hanarry=hanposarry[3]
elseif scale<=0.7 then
hanarry=hanposarry[2]
elseif scale<=1 then
hanarry=hanposarry[1]
end
end


self:showBabyLSFuMoSingle(1,hanarry)














self:delayDo(2.5,function()
if _this==nil then return end


self:stopBabyLSFuMoSingle(1,hanarry)










local timestr=timeHelper.formatSimpleTime(self.aftime)
local str=FMT.fmt('-{0}',timestr)
yushoufangModel.addThrowOutAndSliderTipsEx({2,str})

local group_end_time=0
local group_begin_time=0
if data then
group_end_time=data.group_end_time
group_begin_time=data.group_begin_time
self:startTick(2,function()
self:refreshUpdate_Baby(group_end_time,group_begin_time)
end)
end


self:setBabyLSNoFuMo(1)




self:delayDo(2,function()
if _this==nil then return end

self.isplayfumo=false


self:ResetBabyLSTreeSingle(1)







if _this.state==_state.eBaby then

self:setBabyLSInitFuMo(1)




end
end)
end)
end


function UILingShouYSFJiaoPeiWin:testttt()
_this:showLingShou_Animat()
end
function UILingShouYSFJiaoPeiWin:testttt2()
_this:playfumoAnimat()
end
function UILingShouYSFJiaoPeiWin:testttt3()
_this.spine4:setActive(true)
_this.spine4:setChildUIModelShowTarget(5904,1,{},3670)
end
function UILingShouYSFJiaoPeiWin:testttt4()
local oldlist={}
oldlist.lsindex=1
oldlist.lslist={}
local lsguidList=
{
{
param_2=466,
},
{
param_2=467,
}
}
for k,v in ipairs(lsguidList)do
local data=yushoufangModel:getLSDataByBuildID(v.param_2)
if data then
local nowTime=timeHelper.getServerShortTime()
local group_end_time=data.group_end_time
if group_end_time>0 and group_end_time<nowTime then
local new_data=yushoufangModel:getLSNewDataByBuildID(v.param_2)

for k,new_lsdata in ipairs(new_data)do
if new_lsdata.word_len and new_lsdata.word_len>0 and new_lsdata.wordList then
new_lsdata.wordList=table.deepCopy(new_lsdata.wordList)
end
new_lsdata.guid_str=tostring(new_lsdata.guid)
oldlist.lslist[#oldlist.lslist+1]=new_lsdata
lingshouModel:applyLingShouAllWord(new_lsdata)
end
end
end
end

yushoufangController:onShowLingShouInfoWin(oldlist)
end

