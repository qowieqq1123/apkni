







def_class("UIManufactureWin",UIWindowBase)








function UIManufactureWin:bindComponents()

self.animRoot=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.specialityPanel=UIObject.get(self,2)
self.rightArrowImg=UIObject.get(self,3)
self.checkCostBtn=UIButton.get(self,4)
self.checkSpecialtyBtn=UIButton.get(self,5)
self.costIcon=UIObject.get(self,6)
self.costValue=UIText.get(self,7)
self.discipleDesc=UIText.get(self,8)
self.txtExecuteBar=UIText.get(self,9)
self.pcutText=UIText.get(self,10)
self.stepTime=UIText.get(self,11)
self.specBtns=UIObject.get(self,12)
self.infoBtns=UIObject.get(self,13)
self.iconAds=UIImage.get(self,14)
self.speedUpBtnText=UIText.get(self,15)
self.suCost=UIObject.get(self,16)
self.adItemClick=UIButton.get(self,17)
self.payAds=UIText.get(self,18)
self.btnSwitchReddot=UIObject.get(self,19)
self.btnSelectReddot=UIObject.get(self,20)
self.discipleDescBg=UIButton.get(self,21)
self.txtUpgradeBtn=UIText.get(self,22)
self.dzName=UIText.get(self,23)
self.skill=UIText.get(self,24)
self.scrollView2=UIObject.get(self,25)
self.specialityName=UIText.get(self,26)
self.scrollView=UIObject.get(self,27)
self.pageBtns=UIObject.get(self,28)
self.chaji=UIObject.get(self,29)
self.imgExecuteBg=UIImage.get(self,30)
self.stepProgressBar=UIObject.get(self,31)
self.totalBtn=UIButton.get(self,32)
self.txtExecuteTime=UIText.get(self,33)
self.pcutPanel=UIObject.get(self,34)
self.sliderExecute=UIObject.get(self,35)
self.rewardScrollview=UIObject.get(self,36)
self.produceTips=UIText.get(self,37)
self.animLiandan=UIObject.get(self,38)
self.levelUpBtnText=UIText.get(self,39)
self.btnAdsSpeedup=UIButton.get(self,40)
self.imgExcuteReword=UIImage.get(self,41)
self.discipleDescObj=UIObject.get(self,42)
self.btnSwitch=UIObject.get(self,43)
self.imgState=UIImage.get(self,44)
self.animDog=UIObject.get(self,45)
self.techan=UIButton.get(self,46)
self.animLdl=UIObject.get(self,47)
self.mbg=UIObject.get(self,48)
self.imgPause=UIObject.get(self,49)
self.btnSelect=UIObject.get(self,50)
self.btnUpgrade=UIButton.get(self,51)
self.diziLock=UIText.get(self,52)
self.diziInfo=UIObject.get(self,53)
self.state=UIToggleButton.get(self,54)
self.specialityInfo=UIText.get(self,55)
self.specialityDesc=UIText.get(self,56)
self.specialityIcon=UIImage.get(self,57)
self.executePanel=UIObject.get(self,58)
self.allPlantPanel=UIObject.get(self,59)
self.levelUpBtn=UIButton.get(self,60)
self.bdLevel=UIText.get(self,61)
self.posFloatMark=UIObject.get(self,62)
self.btnGetRewards=UIButton.get(self,63)
self.speedupPanel=UIObject.get(self,64)
self.txtExcuteCount=UIText.get(self,65)
self.imgExcuteIcon=UIImage.get(self,66)
self.leftArrow=UIButton.get(self,67)
self.rightArrow=UIButton.get(self,68)
self.txtCurLevel=UIText.get(self,69)
self.timeIcon=UIObject.get(self,70)
self.leftArrowImg=UIObject.get(self,71)

self.checkCostBtn:setButtonClick(function()self:onCheckCostBtn()end)

self.checkSpecialtyBtn:setButtonClick(function()self:onCheckSpecialtyBtn()end)

self.adItemClick:setButtonClick(function()self:onAdItemClick()end)

self.discipleDescBg:setButtonClick(function()self:onDiscipleDescBg()end)

self.totalBtn:setButtonClick(function()self:onTotalBtn()end)

self.btnAdsSpeedup:setButtonClick(function()self:onBtnAdsSpeedup()end)

self.techan:setButtonClick(function()self:onTechan()end)

self.btnUpgrade:setButtonClick(function()self:onBtnUpgrade()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.btnGetRewards:setButtonClick(function()self:onBtnGetRewards()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)


self.sprite_image_waichu=0
self.sprite_image_kongwei=1
self.sprite_button_zongshouhuo_1=2
self.sprite_button_zongshouhuo_2=3

end


function UIManufactureWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.specialityPanel);self.specialityPanel=nil;
_UIObject_release(self.rightArrowImg);self.rightArrowImg=nil;
_UIObject_release(self.checkCostBtn);self.checkCostBtn=nil;
_UIObject_release(self.checkSpecialtyBtn);self.checkSpecialtyBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costValue);self.costValue=nil;
_UIObject_release(self.discipleDesc);self.discipleDesc=nil;
_UIObject_release(self.txtExecuteBar);self.txtExecuteBar=nil;
_UIObject_release(self.pcutText);self.pcutText=nil;
_UIObject_release(self.stepTime);self.stepTime=nil;
_UIObject_release(self.specBtns);self.specBtns=nil;
_UIObject_release(self.infoBtns);self.infoBtns=nil;
_UIObject_release(self.iconAds);self.iconAds=nil;
_UIObject_release(self.speedUpBtnText);self.speedUpBtnText=nil;
_UIObject_release(self.suCost);self.suCost=nil;
_UIObject_release(self.adItemClick);self.adItemClick=nil;
_UIObject_release(self.payAds);self.payAds=nil;
_UIObject_release(self.btnSwitchReddot);self.btnSwitchReddot=nil;
_UIObject_release(self.btnSelectReddot);self.btnSelectReddot=nil;
_UIObject_release(self.discipleDescBg);self.discipleDescBg=nil;
_UIObject_release(self.txtUpgradeBtn);self.txtUpgradeBtn=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.specialityName);self.specialityName=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.pageBtns);self.pageBtns=nil;
_UIObject_release(self.chaji);self.chaji=nil;
_UIObject_release(self.imgExecuteBg);self.imgExecuteBg=nil;
_UIObject_release(self.stepProgressBar);self.stepProgressBar=nil;
_UIObject_release(self.totalBtn);self.totalBtn=nil;
_UIObject_release(self.txtExecuteTime);self.txtExecuteTime=nil;
_UIObject_release(self.pcutPanel);self.pcutPanel=nil;
_UIObject_release(self.sliderExecute);self.sliderExecute=nil;
_UIObject_release(self.rewardScrollview);self.rewardScrollview=nil;
_UIObject_release(self.produceTips);self.produceTips=nil;
_UIObject_release(self.animLiandan);self.animLiandan=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.btnAdsSpeedup);self.btnAdsSpeedup=nil;
_UIObject_release(self.imgExcuteReword);self.imgExcuteReword=nil;
_UIObject_release(self.discipleDescObj);self.discipleDescObj=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.imgState);self.imgState=nil;
_UIObject_release(self.animDog);self.animDog=nil;
_UIObject_release(self.techan);self.techan=nil;
_UIObject_release(self.animLdl);self.animLdl=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.imgPause);self.imgPause=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnUpgrade);self.btnUpgrade=nil;
_UIObject_release(self.diziLock);self.diziLock=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.state);self.state=nil;
_UIObject_release(self.specialityInfo);self.specialityInfo=nil;
_UIObject_release(self.specialityDesc);self.specialityDesc=nil;
_UIObject_release(self.specialityIcon);self.specialityIcon=nil;
_UIObject_release(self.executePanel);self.executePanel=nil;
_UIObject_release(self.allPlantPanel);self.allPlantPanel=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.posFloatMark);self.posFloatMark=nil;
_UIObject_release(self.btnGetRewards);self.btnGetRewards=nil;
_UIObject_release(self.speedupPanel);self.speedupPanel=nil;
_UIObject_release(self.txtExcuteCount);self.txtExcuteCount=nil;
_UIObject_release(self.imgExcuteIcon);self.imgExcuteIcon=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.txtCurLevel);self.txtCurLevel=nil;
_UIObject_release(self.timeIcon);self.timeIcon=nil;
_UIObject_release(self.leftArrowImg);self.leftArrowImg=nil;
end


















local _this
local _format=string.format
local _helper=CS.UIHelper

local _item_cmp_index={
img_icon_panel=0,
img_icon=1,
txt_rewards=2,
go_costs=3,
cost1=4,
cost2=5,
txt_time=6,
txt_lock=7,
btn_zhixing=8,
btn_select=9,
txt_time2=10,
name=11,
unlock=12,
lock=13,
tiao=14,
info=15,
specialty=16,
scrollView=17,
}
local _check_additional_work={
[SLG_SYSTEM_TYPE.eTianGongGe]={
{
check=function(bdData)
return zhenfaModel:isStartStudying(bdData.un_build_id)
end,
tips="阵法研究期间不能更换或卸任弟子",
},
{
check=function(bdData)
return LZDiaoKeModel:isDKing(bdData.un_build_id)
end,
tips="灵阵雕刻期间不能更换或卸任弟子",
}
},
[SLG_SYSTEM_TYPE.eLianQiGe]={
{
check=function(bdData)
return fabaoModel.lianzhiTimer[bdData.un_build_id]~=nil
end,
tips="法宝炼制期间不能更换或卸任弟子",
},
}
}


local sixAttrType=DISCIPLE_BASE_ATTR_TYPE.eCongHui
local _moveSpeed=200
local _activities={
[SUB_ACTIVITY_TYPE.eFuZheXinLing]="produce"
}


function UIManufactureWin:onLoaded(...)
self:bindComponents()
_this=self

self.enterPos={550,-330}
self.leftPos={-320,-278}
self.rightPos={-140,-278}
self.jumpPos={-60,-330}

self.dogLeftPos={-270,-355}
self.dogRightPos={0,-355}

self.abName='ui/sharedtextures/uiglobalspriteatlas_1.ab'
self.iconAB='ui/icons/manufacture/sharedtextures/icon_manufacture_pack1.ab'
self.imageAB='ui/windows/manufacture/sharedtextures/uimanufactureatlas.ab'
self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.scrollView2:setChildScrollViewInit(0,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)
self.rewardScrollview:setChildScrollViewInit(0.5,true,nil,nil)

self.bgModels={[2]=2025,[3]=2026,[4]=2034,[7]=2027,[8]=2028,[9]=2029}
self.exImages={
[2]="image_shengchanbg_1",
[3]="image_shengchanbg_2",
[4]="image_shengchanbg_4",
[7]="image_shengchanbg_3",
[8]="image_shengchanbg_5",
[9]="image_shengchanbg_6",
}

self.state:setToggleChange(function(name,isOn,data)
if isOn then
self:onState()
end
end)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onDiscipleJobChange,self.on_skill_level_change)
notifySystem:listenNotify(notifyConfig.adRefresh,self.on_ad_refresh)

self.on_money_changed=function(mtype,last,curr)
if mtype==self.checkType then
self:refreshRightPanel()
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)


local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.animRoot:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)

self:showPageBtns(1)
end

function UIManufactureWin:setStateButton(bActive)
self.state:setToggle(bActive)
end


function UIManufactureWin:__delete()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onDiscipleJobChange,self.on_skill_level_change)
notifySystem:removelistener(notifyConfig.adRefresh,self.on_ad_refresh)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)

self:clear()

if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end

self:unbindComponents()
_this=nil
end

function UIManufactureWin:clear()
self:stopLevelUpTimer()




self:clearSpeedupItemExpireTimer()
self:clearInstances()

if self.ctimer then
self:stopTimerByID(self.ctimer)
self.ctimer=nil
end

self.scrollView:setChildScrollViewStopGridCreate()
end

function UIManufactureWin:clearInstances()
if self.eventTipsHUD then
_InstantiateManager.RemoveInstance(self.eventTipsHUD)
end

if self.dogSTID then
_InstantiateManager.RemoveInstance(self.dogSTID)
end

uiAIManager:clearUIWinData('UIManufactureWin')
self.currDZ=nil
self.lastDZ=nil
self.dogBT=nil

self.workCheck1=nil
self.workCheck2=nil
end

function UIManufactureWin:showPageBtns(page)
if page==1 then
self.infoBtns:setActive(true)
self.specBtns:setActive(false)
else
self.infoBtns:setActive(false)
self.specBtns:setActive(true)
end
end




function UIManufactureWin:onShow(argtable,afterOnloaded)
if argtable==nil then
return
end

self:refresh(argtable,true)
end

function UIManufactureWin:onShowArgRecv(argtable)
local oldId=self.entityId
local newId=argtable.entityId
if newId~=oldId then
self:__delete()
self:onLoaded()
self:onShow(argtable)
end
end

function UIManufactureWin:refreshAfterItemUse(utype,arg1,arg2)
self:refreshRightPanel()
end

function UIManufactureWin:refresh(argtable,isInit)
local guid=argtable.entityId
self.entityId=guid
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)

self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
UIManager:callWindowFunc('UIBottomMaskWin','setTitle',self.config.name)
UIManager:callWindowFunc('UIBottomMaskWin','refreshFrdRoot')
self.baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
local spcfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_allow')
self.mspData=spcfg[4]

self.feedTime=self.baseCfg[speedUpMode.eFree][1]
self.bdType=self.config.id
self.first_tick=true

self.lastTime=0

self:refreshLeftPanel()
self:refreshRightPanel(isInit)

self:clearInstances()

if systemModel.isOpen(SYSTEM_DEFINE.eBatch)then
self:createDog(self.dogLeftPos,function(bt)
self.dogBT=bt
if newbieControl.isInNewbie()then
self.dogBT:setSharedVar('UIstateId',2)
else
self.dogBT:setSharedVar('UIstateId',0)
end
bt:quicklyTick()
end)
end

self.ctimer=self:delayDo(0.5,function(...)
self:initAI(self.bdData.dizi_id)
end)

self:checkAndShowArrowBtn()
end

function UIManufactureWin:checkAndShowArrowBtn()
local bdId=self.bdData.build_id
local bdDatas=zongmenModel:getAllBuildingData(self.sfId)
local list={}
for k,v in pairs(bdDatas)do
if v.build_id==bdId and v.isLinkRoad then
table.insert(list,v)
end
end
local len=#list
local showArrow=len>1
self.otherBDData=list
self.leftArrow:setActive(showArrow)
self.rightArrow:setActive(showArrow)
if showArrow and not self.showArrowAnim then
self.showArrowAnim=true
local tween1=self.leftArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween1:SetEase(_Ease.InOutSine)
tween1:SetLoops(-1,_LoopType.Yoyo)
local tween2=self.rightArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween2:SetEase(_Ease.InOutSine)
tween2:SetLoops(-1,_LoopType.Yoyo)
end
end

function UIManufactureWin:toNextWin(arrow)
local ubdId=self.bdData.un_build_id
local index
for i,v in ipairs(self.otherBDData)do
if v.un_build_id==ubdId then
index=i
break
end
end

if not index then
return
end

index=index+arrow
local len=#self.otherBDData
if index>len then
index=index-len
elseif index<1 then
index=index+len
end

self.leftArrow:setActive(false)
self.rightArrow:setActive(false)

local bdData=self.otherBDData[index]
self:clear()
local args={entityId=bdData.entityId}
fullScreenUI.activeUI:setAttach(args)
self:refresh(args)
end

function UIManufactureWin:getDZId()
local dzid=self.bdData.dizi_id
if dzId=='0'then return end
return dzid
end

function UIManufactureWin:initAI(dzId)
dzId=tostring(dzId)
if dzId=='0'then
return
end

local state=UIDiscipleModel:getDiscipleState(dzId)or nil
if state==nil or state==DISCIPLE_STATE_TYPE.edsDispatch then
return
end

self:createDZ(self.bdData.dizi_id,self.rightPos,function(bt)
self.currDZ=bt
local stateId=0

if self.bdData.flag==buildingStateType.eUpgrading then
stateId=3

elseif self.bdData.plant_id>0 then
stateId=3

end
self.currDZ:setSharedVar('UIstateId',stateId)
self.currDZ:setSharedVar('working',stateId==3)
end)
end

function UIManufactureWin:createDZ(dzId,pos,callback)
local cfg=cfgHelper.get1(cfg_aiplanworkconfig_get,1)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=0,
working=false,
leftPos=self.leftPos,
rightPos=self.rightPos,
enterPos=self.enterPos,
jumpPos=self.jumpPos,
uispeakrate=cfg.uispeakrate,
uimoverate=cfg.uimoverate,
}
local tran=self.root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])

local otherData={
order=1001
}
uiAIManager:createUIDisciple('UIManufactureWin','bt_ui_plan_work',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end

function UIManufactureWin:createDog(pos,callback)
local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
leftPos=self.dogLeftPos,
rightPos=self.dogRightPos,
uispeakrate=0.5,
uimoverate=0.5,
}
local tran=self.root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])








local otherData={
order=1002,
scale=1,
}
self.dogSTID=uiAIManager:createUIObject('UIManufactureWin','bt_ui_dog',INSTANCE_TYPE.eUIDog,440011,
tran,vpos,initData,otherData,function(bt)
local stWidget=bt:getSharedVar('stWidget')
stWidget:SetChildButtonClick(2,function()
self:onDog()
end)
stWidget:SetChildNewBieComponentId(2,'UIManufactureWin.UIDog.click')
callback(bt)
end)
end

function UIManufactureWin:startWork(bt)
self:showEventTips(bt)
self.workCheck1=false
end

function UIManufactureWin:endWork()

uiAIManager:removeUIInstance(self.lastDZ)
self.lastDZ=nil
self.workCheck2=false
end


function UIManufactureWin:getSpeakText(bt,tkey,stype)
local cfg=cfgHelper.get1(cfg_aiplanworkconfig_get,1)
local speaks=cfg[string.format('uispeak%d',stype)]
local txt=speaks[math.random(1,#speaks)]
bt:setSharedVar(tkey,txt)
end


function UIManufactureWin:getDogSpeakText(bt,tkey,stype)



bt:setSharedVar(tkey,'祖师，我可以帮您快速安排生产哦')
end


function UIManufactureWin:getDogMovePos(bt,pkey)
local dx=self.dogRightPos[1]-self.dogLeftPos[1]
local px=self.dogLeftPos[1]+dx*math.random()
local pos={px,self.dogLeftPos[2]}
bt:setSharedVar(pkey,pos)
end


function UIManufactureWin:showEventTips(bt)
if self.eventTipsHUD then
return
end
if zongmenModel:isHaveNewManufactureEvent(self.config.build_type)then
local widget=bt:getSharedVar('dzWidget')
local index=bt:getSharedVar('speakHUDParent')
local parent=widget:GetCommonComponent(index,'Transform')
self.eventTipsHUD=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleTipsHUD,parent,function(hudId)
local hudWidget=_InstantiateManager.GetComponent(hudId,'CSGUIWidgetBase')
hudWidget:SetChildAnchoredPosition(0,Vector2.New(-20,-30))
hudWidget:SetChildButtonClick(0,function()
UIManager:showWindow('UIManufactureEventWin',self.bdData)
_InstantiateManager.RemoveInstance(hudId)
self.eventTipsHUD=nil
end)
self.eventTipsHUD=hudId
end)
end
end

function UIManufactureWin:refreshAI(newDzId,oldDzId)
local newDzIdStr=tostring(newDzId)
local oldDzIdStr=tostring(oldDzId)
if self.lastDZ then
uiAIManager:removeUIInstance(self.lastDZ)
self.lastDZ=nil
self.workCheck2=false
end
if oldDzIdStr~='0'and self.currDZ then
if self.eventTipsHUD then
_InstantiateManager.RemoveInstance(self.eventTipsHUD)
self.eventTipsHUD=nil
end
self.lastDZ=self.currDZ
self.currDZ=nil
self.lastDZ:setSharedVar('UIstateId',2)
self.lastDZ:broke()
self.lastDZ:reset()
self.lastDZ:tick(0.5)

self.workCheck2=true
end
if newDzIdStr~='0'and not self.currDZ then
self.currDZ=self:createDZ(self.bdData.dizi_id,self.enterPos,function(bt)
self.currDZ=bt
self.currDZ:setSharedVar('UIstateId',1)
self.currDZ:tick(0.5)
end)
self.workCheck1=true
end
end

function UIManufactureWin:changeWorkState(sId)
if not self.currDZ then
return
end
if sId==4 then
self.currDZ:setSharedVar('working',true)
local csId=self.currDZ:getSharedVar('UIstateId')
if csId~=1 then
self.currDZ:setSharedVar('UIstateId',sId)
self.currDZ:reset()
end
elseif sId==5 then
self.currDZ:setSharedVar('working',false)
self.currDZ:setSharedVar('UIstateId',sId)
self.currDZ:reset()
end
end

function UIManufactureWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if _this.bdData.un_build_id~=bdId then
return
end
if etype==buildingEvent.buildDataChange then
_this:refreshRightPanel()
elseif etype==buildingEvent.replaceDisciple then

_this:refreshAI(arg1,arg2)
_this:refreshLeftPanel()
_this:refreshRightPanel()
elseif etype==buildingEvent.planStart then
_this.speedUpMode=-1
_this:refreshLeftPanel()
_this:refreshRightPanel()

_this:changeWorkState(4)

if _this.bdType==3 then


AudioManager.playAudio(440)
elseif _this.bdType==7 then


AudioManager.playAudio(444)
elseif _this.bdType==8 then


AudioManager.playAudio(441)
end
elseif etype==buildingEvent.planComplete
or etype==buildingEvent.planCancel
or etype==buildingEvent.planCollect
or etype==buildingEvent.planChange then
_this:refreshLeftPanel()
_this:refreshRightPanel()

_this:changeWorkState(5)
if etype==buildingEvent.planComplete
or etype==buildingEvent.planCollect then
_this:flyIcon()
if _this.bdType==2 then


AudioManager.playAudio(436)
elseif _this.bdType==3 then


AudioManager.playAudio(438)
elseif _this.bdType==7 then


AudioManager.playAudio(445)
elseif _this.bdType==8 then


AudioManager.playAudio(442)
end
end
elseif etype==buildingEvent.levelUpComplete
or etype==buildingEvent.levelUpStart then
_this:refreshLeftPanel()
_this:refreshRightPanel()
elseif etype==buildingEvent.speedUpComplete then
_this:refreshRightPanel()
end
end

function UIManufactureWin.on_ad_refresh()
_this:refreshRightPanel()
end

function UIManufactureWin:flyIcon()
local spos=self.imgExcuteReword:getChildPosition()
UIManager:invokeUIMethod('UITopMoneyWin','flyMoneyIcon',spos,self.currRewardType)
end

function UIManufactureWin:refreshRightPanel(isInit)
self.curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
self.nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)

local plant=self.bdData.plant_id
if plant>0 then
self.allPlantPanel:setActive(false)
self.speedupPanel:setActive(true)
self.executePanel:setActive(true)
self:refreshExecutePanel(plant,isInit)
self:refreshSpeedPanel(speedUpType.eExecutePlant)

else
self:stopPlanTimer()
self.executePanel:setActive(false)
self.allPlantPanel:setActive(true)
local showPage=self.curLvCfg.specialty~=nil
self.pageBtns:setActive(showPage)
self.chaji:setActive(not showPage)
self:refreshPlantPanel()
end

self:refreshLevelUpPanel()

local isComplete=buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)
local imgName=isComplete and'button_tyanniu_3'or'button_tyanniu_1'
self.btnUpgrade:setSprite(self.abName,imgName)
end

function UIManufactureWin:refreshExecutePanel(plantId,isInit)
local plants=zongmenModel:getBuildingAllPlant(self.curLvCfg.build_id,self.curLvCfg.level)
local plantCfg=plants[plantId]
local rewards=plantCfg.rewards[1]

local reap_percent=self.bdData.pcreateaddpercent/100+1
self.currRewardType=rewards[1]
self.imgExcuteIcon:setChildIcon(iconHelper.getIconName(rewards[1]),true)
self.imgExcuteReword:setChildIcon(iconHelper.getIconName(rewards[1]),true)
self.txtExcuteCount:setText(_format('+%s',math.floor(rewards[2]*reap_percent)))
local cdd=buildingCDControl:getCDData(buildingCDType.plan,self.bdData.un_build_id)







self.imgExecuteBg:setSprite(self.imageAB,self.exImages[self.config.build_type])

if self.isPause then
self:stopPlanTimer()
self.txtExecuteTime:setText('生产暂停')
self.produceTips:setText('生产暂停')
self.btnGetRewards:setActive(false)
self.speedupPanel:setActive(false)


self.stepTime:setText('已暂停')
else
if not cdd.complete then
self.produceTips:setText('生产中')
local ctime=zongmenControl:getPlanTimeRemaining(self.bdData)
local endtime=os.time()+ctime
local showSetp=cdd.currStep
local tick=function()
cdd=buildingCDControl:getCDData(buildingCDType.plan,self.bdData.un_build_id)
local dtime=endtime-os.time()

self.lastTime=dtime
if dtime>=0 then
self.txtExecuteTime:setText(timeHelper.format_time_stamp4(dtime))
self.stepTime:setText(timeHelper.format_time_stamp4(cdd.stepCD))

if self.first_tick then
self.first_tick=nil

self.stepProgressBar:setChildUIProgressbar(cdd.stepDTime,cdd.stepNeedTime,false)
else

self.stepProgressBar:setChildUIProgressbar(cdd.stepDTime+1,cdd.stepNeedTime,true)
end
if dtime<=self.feedTime and self.speedUpMode~=0 then
self:refreshSpeedPanel(self.speedup_type)
end
else
self:stopPlanTimer()
self:refreshExecutePanel(plantId)
end

if(cdd.finishStep>self.bdData.hasExNum and self.showSetpPB)or showSetp~=cdd.currStep then
self.showSetpPB=false
self:stopPlanTimer()
self:refreshExecutePanel(plantId)
end
end
tick()
self:stopPlanTimer()
self.planTimer=self:setTimer(1,0,tick)
self.btnGetRewards:setActive(true)
self.speedupPanel:setActive(true)



else
self:stopPlanTimer()
if not isInit then

AudioManager.playAudio(435)
end
self.txtExecuteTime:setText('生产完成')
self.produceTips:setText('已完成')

self.winlua:SetChildUIProgressbar(self.sliderExecute:getID(),1,1,false)
self.first_tick=true
self.btnGetRewards:setActive(true)
self.speedupPanel:setActive(false)


end
end





local datas=zongmenControl:getPlanStepReward(self.bdData,true)
local len=#datas
self.rewardScrollview:setChildScrollViewCreateGrids(len,len)
local grids=self.rewardScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datas[i]
widgetHelper.setNormalRewardItem(item,0,data)
end
local cut_value=emergenciesModel:getProductionCutValue(self.bdData.un_build_id)
self.pcutPanel:setActive(cut_value~=nil)
if cut_value then
self.pcutText:setText(FMT.fmt('受火烧影响，本次产量降低{0}%',cut_value))
end

self.showSetpPB=len<=0
self.stepProgressBar:setActive(self.showSetpPB)
end
















function UIManufactureWin:refreshUpgradePanel()
self:stopLevelUpTimer()
local beginTime=self.bdData.begintime
if beginTime>0 then
self.upgrade_need_time=self.nextLvCfg.uplevel_times


local isComplete=buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)
if not isComplete then

local tick=function()

local dtime=buildingCDControl:getCD(buildingCDType.build,self.bdData.un_build_id)
if dtime>0 then
self.txtCurLevel:setText(timeHelper.format_time_stamp4(dtime))
else
self:stopLevelUpTimer()
self:refreshUpgradePanel()
end
end
tick()
self.txtUpgradeBtn:setText('加速升级')
self.levelUpTimer=self:setTimer(1,0,tick)
self.timeIcon:setActive(true)
else
self:stopLevelUpTimer()
self.txtUpgradeBtn:setText('完成升级')
self.txtCurLevel:setText('完成升级')
self.levelUpBtnText:setText('完成升级')
self.btnUpgrade:setSprite(self.abName,'button_tyanniu_3')
self.timeIcon:setActive(false)
end
end
end

function UIManufactureWin:refreshPlantPanel()
local build_id=self.curLvCfg.build_id





zongmenModel:refreshBuildingEffect(self.bdData)


self.timeIcon:setActive(false)

self.open_lvs=zongmenModel:getBuildingPlantOpenLv(build_id)
self.have_disciple=tostring(self.bdData.dizi_id)~='0'
self.cur_lv=self.bdData.level

if self.nextLvCfg then
if self.bdData.flag==buildingStateType.eUpgrading then
self:refreshUpgradePanel()
else


end
else


end


self.scrollView:setChildScrollViewDelayCreateGrids(4,1,0.02,1,false,false,function(id,item)
self:refreshItem(id,item)
end)
end

function UIManufactureWin:refreshLevelUpPanel()
self.bdLevel:setText(_format('%s级%s',self.bdData.level,self.config.name))
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id,true)
if cddata and cddata.complete then
self.levelUpBtnText:setText('完成升级')
return
end
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
self.levelUpBtnText:setText(nextLvCfg~=nil and'建筑升级'or'建筑信息')
end





















function UIManufactureWin:getSpecialtyReward(index)
if not self.curLvCfg.specialty then
return nil
end

local spdata=self.curLvCfg.specialty[index]
local level=zongmenModel:getLevel()
for i,v in ipairs(spdata)do
if level>=v[1]and level<=v[2]then
return v[3]
end
end

return nil
end

function UIManufactureWin:refreshItem(i,item)
local index=i+1
local open_lv=self.open_lvs[index]
local isUnlock=self.cur_lv>=open_lv
item:SetChildActive(_item_cmp_index.tiao,index<4)
item:SetChildActive(_item_cmp_index.unlock,isUnlock)
item:SetChildActive(_item_cmp_index.lock,not isUnlock)
if isUnlock then
local allPlantCfg=zongmenModel:getBuildingAllPlant(self.curLvCfg.build_id,self.cur_lv)
local plantCfg=allPlantCfg[index]
local times=plantCfg.groups[1]

self:setCosts(item,_item_cmp_index.cost1,plantCfg.cost[1],self.bdData.pcreatesubpercent)
self:setCosts(item,_item_cmp_index.cost2,plantCfg.cost[2],self.bdData.pcreatesubpercent)

self:setNeedTime(_item_cmp_index.txt_time,item,plantCfg[1],self.bdData.pcreatetimepercent,times)



self:setRewards(_item_cmp_index.txt_rewards,item,plantCfg.rewards[1][2],plantCfg.display[2],self.bdData.pcreateaddpercent,times)
item:SetChildText(_item_cmp_index.name,plantCfg.display[1])
item:SetChildText(_item_cmp_index.txt_lock,'')
item:SetChildActive(_item_cmp_index.go_costs,true)
item:SetChildActive(_item_cmp_index.btn_zhixing,true)
item:SetChildActive(_item_cmp_index.btn_select,not self.have_disciple)
item:SetChildNewBieComponentId(_item_cmp_index.btn_zhixing,FMT.fmt('UIManufactureWin.UIManufactureItem_{0}.btnZhixing',index))
item:SetChildNewBieComponentId(_item_cmp_index.btn_select,FMT.fmt('UIManufactureWin.UIManufactureItem_{0}.btnSelect',index))
item:SetChildWeakGuideComponentId(_item_cmp_index.btn_zhixing,FMT.fmt('UIManufactureWin.UIManufactureItem_{0}.btnZhixing_wg',index))
item:SetChildWeakGuideComponentId(_item_cmp_index.btn_select,FMT.fmt('UIManufactureWin.UIManufactureItem_{0}.btnSelect_wg',index))
item:SetChildButtonClickWithID(_item_cmp_index.btn_zhixing,function(id)
self:onExecutePlant(id)
end,index)
item:SetChildButtonClickWithID(_item_cmp_index.btn_select,function(id)
self:onClickSelect()
end,index)

local rewards=self:getSpecialtyReward(index)or{}
local actRewards={}
for subType,col in pairs(_activities)do
local subActs=activitiesModel:getActSubList_subType_doing(subType)
for index,subAct in ipairs(subActs)do
local colData=subAct:getSubActConfig(col)
if type(colData)=="number"then
table.insert(actRewards,1,{colData,0,huodong=true})
elseif type(colData)=="table"then
local colData=colData[self.curLvCfg.build_id]and colData[self.curLvCfg.build_id][index]

if colData then
for index,data in ipairs(colData)do
table.insert(actRewards,index,{data[1],0,huodong=true})
end
end
end
end
end

local len=#rewards+#actRewards
item:SetChildScrollViewInit(_item_cmp_index.scrollView,0.5,true,nil,nil)
item:SetChildScrollViewCreateGrids(_item_cmp_index.scrollView,len,len)
local grids=item:GetChildScrollViewItemWidgets(_item_cmp_index.scrollView)
local count=grids.Count
for ii=1,count do
local rwitem=grids[ii-1]
local data=actRewards[ii]or rewards[ii-#actRewards]
widgetHelper.setNormalRewardItem(rwitem,0,data)
rwitem:SetChildActive(1,data.huodong==true)
end
else
local allPlantCfg=zongmenModel:getBuildingAllPlant(self.curLvCfg.build_id,open_lv)
local plantCfg=allPlantCfg[index]
local times=plantCfg.groups[1]
self:setRewards(_item_cmp_index.txt_rewards,item,plantCfg.rewards[1][2],plantCfg.display[2],self.bdData.pcreateaddpercent,times)
item:SetChildText(_item_cmp_index.name,plantCfg.display[1])
item:SetChildText(_item_cmp_index.txt_lock,_format('%s %s 级解锁',self.config.name,self.open_lvs[index]))
item:SetChildActive(_item_cmp_index.go_costs,false)
item:SetChildActive(_item_cmp_index.btn_zhixing,false)
item:SetChildActive(_item_cmp_index.btn_select,false)
end
end

function UIManufactureWin:refreshSpeedPanel(typo)
self.speedup_type=typo

local mspData=self.mspData

self.iconAds:setActive(false)
self.payAds:setActive(false)

if mspData[4]and self.lastTime<=self.feedTime then
self.speedUpMode=0
self.speedUpBtnText:setText('免费加速')
self.suCost:setActive(false)
weakGuideController:beginGuide(1183)
return
end

self.suCost:setActive(true)

if mspData[2]then
local have
local itemId
local data

















local speedupItemList=self:getSortSpeedupItemList()
local selectSpeedupItem=speedupItemList[1]
itemId=selectSpeedupItem.itemId
data=selectSpeedupItem.data
have=selectSpeedupItem.itemNotExpireCount

self.speedup_item_id=nil
if data then
local cfg=itemsConfig.getConfig(itemId)
self.costIcon:setChildIcon(iconHelper.getIconName(cfg.id),true)
local enough=have>=data[1]
self.costValue:setText(enough and have or FMT.fmt('<color=red>{0}</color>',have))
self.speedUpBtnText:setText(FMT.fmt('加速{0}',timeHelper.format_time_stamp11(data[2],true)))
self.speedup_item_count=data[1]
self.speedup_item_id=itemId
self.speedup_time=data[2]
self.speedUpMode=1
self.batchTime=data[3]

local nowTime=timeHelper.getServerShortTime()
local nearestExpireTime=selectSpeedupItem.nearestExpireTime
if nearestExpireTime>=0 and nearestExpireTime-nowTime>0 then
self:setSpeedupItemExpireTimer(nearestExpireTime)
end

local level=zongmenModel:getLevel()
if level<=10 and have>100 then
weakGuideController:beginGuide(1183)
end
end
end
end





function UIManufactureWin:getSortSpeedupItemList()
local sortItemList={}
local itemcfg=self.baseCfg[2]
local nowTime=timeHelper.getServerShortTime()
for k,v in pairs(itemcfg)do
local itemId=k
local needCount=v[1]
local itemNotExpireCount,itemAllCount=bagModel.getNotExpireItemCountById(itemId)
local nearestExpireTime=bagModel.getNearestExpireTimeById(itemId)

local isExpire=nearestExpireTime>=0 and nearestExpireTime-nowTime<=0
local nearestExpireLerp=math.abs(nowTime-nearestExpireTime)

local weight=0
if itemNotExpireCount>=needCount then
weight=weight+100
end
if itemAllCount>=needCount then
weight=weight+1000
end
if not isExpire then
weight=weight+10000
end

local item={
itemId=itemId,
itemNotExpireCount=itemNotExpireCount,
itemAllCount=itemAllCount,
nearestExpireLerp=nearestExpireLerp,
nearestExpireTime=nearestExpireTime,
weight=weight,
data=v,
}
sortItemList[#sortItemList+1]=item
end

table.sort(sortItemList,function(a,b)
if a.weight==b.weight then
if a.nearestExpireLerp==b.nearestExpireLerp then
return a.itemId<b.itemId
else
return a.nearestExpireLerp<b.nearestExpireLerp
end
else
return a.weight>b.weight
end
end)

return sortItemList
end

function UIManufactureWin:startAdTimer()
local btime=adControl:getBeginCDTime()
if not btime then
return
end
local rtime=adControl:getRefreshTime()
local stime=gameUtilityModel.getServerShortTime()
local count=rtime-stime
if count>0 then
self:clearAdTimer()
self.speedUpBtnText:setText(FMT.fmt('等待{0}',timeHelper.format_time_stamp11(count,true)))
self.adtimer=self:setTimer(1,count+3,function()
stime=gameUtilityModel.getServerShortTime()
if stime>=rtime then
self:clearAdTimer()
return
end
self.speedUpBtnText:setText(FMT.fmt('等待{0}',timeHelper.format_time_stamp11(rtime-stime,true)))
end)
end
end

function UIManufactureWin:clearAdTimer()
if self.adtimer then
self:stopTimerByID(self.adtimer)
self.adtimer=nil
end
end

function UIManufactureWin:stopNaturalTimer()
if self.naturalTimer then
self:stopTimerByID(self.naturalTimer)
self.naturalTimer=nil
end
end

function UIManufactureWin:stopPlanTimer()
if self.planTimer then
self:stopTimerByID(self.planTimer)
self.planTimer=nil
end
end

function UIManufactureWin:stopLevelUpTimer()
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end

function UIManufactureWin:stopAdsTimer()
if self.adsTimer then
self:stopTimerByID(self.adsTimer)
self.adsTimer=nil
end
end


function UIManufactureWin:setSpeedupItemExpireTimer(expireTime)
self:clearSpeedupItemExpireTimer()

local timeFun=function()
local nowTime=timeHelper.getServerShortTime()
local lerp=expireTime-nowTime
if lerp<=0 then
self:clearSpeedupItemExpireTimer()

self:refreshSpeedPanel(self.speedup_type)
return
end
end

self.speedupItemExpireTimer=self:setTimer(1,0,timeFun)
timeFun()
end


function UIManufactureWin:clearSpeedupItemExpireTimer()
if self.speedupItemExpireTimer then
self:stopTimerByID(self.speedupItemExpireTimer)
self.speedupItemExpireTimer=nil
end
end

function UIManufactureWin:setCosts(item,index,cost,percent)
if cost then
item:SetChildActive(index,true)
local note=item:GetChildWidgetBase(index)
local mtype=cost[1]
local mval=cost[2]
local have=moneyModel.getMoney(mtype)
local change=math.ceil(mval*percent/100)
local need=mval+change
local text
if have<need then
text=_format('<color=#c82c2c>%s</color>',mathHelper.formatNumber(need))
else
text=mathHelper.formatNumber(need)
end
note:SetChildIcon(0,iconHelper.getIconName(mtype),true)
note:SetChildText(1,text)
else
item:SetChildActive(index,false)
end
end

function UIManufactureWin:setRewards(index,item,rewards,icon,percent,times)
local count=0
for i=1,times do
count=count+math.floor(rewards*(percent*0.01+1))
end
local text=_format('%s',mathHelper.formatNumber(count))
item:SetChildText(index,text)
item:SetChildCSImageSprite(_item_cmp_index.img_icon,self.iconAB,icon)
end

function UIManufactureWin:setNeedTime(index,item,need_time,percent,times)
local count=0
for i=1,times do
count=count+math.floor(need_time*(percent*0.01+1))
end
local text=timeHelper.format_time_stamp4(count)
item:SetChildText(index,text)
item:SetChildActive(index,true)
end

function UIManufactureWin:showTeChan()






end

function UIManufactureWin:showBuffState()
local edatas=zongmenModel:getManufactureEffect(self.bdData)
self.state:setActive(tostring(self.bdData.dizi_id)~='0'and#edatas>0)
end

function UIManufactureWin:refreshPos()
local guid=self.bdData.dizi_id
if guid=='0'then
self.discipleDescObj:setActive(false)
return
end

local state=UIDiscipleModel:getDiscipleState(guid)
if state~=DISCIPLE_STATE_TYPE.edsDispatch then
self.discipleDescObj:setActive(false)
return
end

self.discipleDescObj:setActive(true)

local posStr=UIDiscipleModel:getDiscipleStateDesc2(guid)


self.discipleDesc:setText(posStr)
local len=#posStr/3


local hight=len*22+5+35
if pfwindowslController:checkIsGameVersion_yuenan()then
self.discipleDescObj:setActive(false)
hight=45
end
local width=self.discipleDescBg:getChildSizeDeltaX()
self.discipleDescBg:setChildSizeDelta(width,hight)




end

function UIManufactureWin:onDiscipleDescBg()
local guid=self.bdData.dizi_id
local closeUICallBack=function()
fullScreenUI.closeActiveUI()
end

UIDiscipleController:jumpToDiscipleStatePos(guid,closeUICallBack)
end

function UIManufactureWin:refreshLeftPanel()
local dzId=self.bdData.dizi_id
local haveDz=tostring(dzId)~='0'
local state=haveDz and UIDiscipleModel:getDiscipleState(dzId)or nil
self.isPause=haveDz and state==DISCIPLE_STATE_TYPE.edsDispatch or false
self:showTeChan()
self:showBuffState()

self:refreshPos()

if self.bdData.flag==buildingStateType.eUpgrading then
self.animLdl:setActive(true)
self.animLdl:setChildUIModelShowTarget(2002,1,nil,eAnimationID.stand)
self.animLdl:setChildUIModelShowTargetOffset(-20,30)
self.animLdl:setChildModelAnimationState(eAnimationID.stand)
else
self.animLdl:setActive(false)
end


local model=self.bgModels[self.config.build_type]
if model then
local anim=self.bdData.plant_id>0 and eAnimationID.produce or eAnimationID.stand
if self.model~=model then
self.mbg:setChildUIModelShowTarget(model,1,nil,anim,false,false,0,function()
self.model=model
self.anim=anim
end)
else
self.anim=anim
self.mbg:setChildModelAnimationState(anim)
end
end

if haveDz then
if self.isPause then
local canshow=self.bdData.flag==0
self.imgPause:setActive(canshow)
self.imgState:setActive(true)
self.imgState:setImageSprite(self.sprite_image_waichu,true)
else
self.imgPause:setActive(false)
self.imgState:setActive(false)
self.imgState:setImageSprite(self.sprite_image_kongwei,true)
end
local name=UIDiscipleModel:getDiscipleName(dzId)
self.dzName:setText(FMT.fmt('执事弟子：<color=#7d3b17>{0}</color>',name))
self.diziLock:setActive(false)
self.diziInfo:setActive(true)
self.btnSwitch:setActive(true)
self.btnSwitch:setRotation(0,0,0)
self.btnSelect:setActive(false)

local shake=changeManagerCheckModel:getBuildingReddot(self.bdData.un_build_id)
self.btnSwitchReddot:setActive(shake)
if shake then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.btnSwitch:getID())
else
self.winlua:SetChildDOTweenAnimation_DOPause(self.btnSwitch:getID())
end

local bd_tybe_cfg=cfg_monijybuildconfig_get(self.config.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local effect=nil
if skill_cfg.buildplant_effects then
effect=skill_cfg.buildplant_effects[level]
end

local sixAttrCfg=cfgHelper.getglobal1('discipleattr')
local sixAttrName=sixAttrCfg[sixAttrType].name
local sixAttrValue=UIDiscipleModel:getDiscipleBaseAttr(dzId,sixAttrType)
local content=_format('%s：%s级（%s %s）',skill_cfg.name,level,sixAttrName,sixAttrValue)
self.skill:setText(content)
end
self.dizi_speciality=self:getPlantEffects(dzId)
if self.dizi_speciality then
self.scrollView2:setActive(true)
self.scrollView2:setChildScrollViewCreateGrids(#self.dizi_speciality,0)
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
else
self.imgState:setActive(false)
self.imgPause:setActive(false)
self.diziLock:setActive(true)
self.diziInfo:setActive(false)
self.btnSwitch:setActive(false)
self.btnSelect:setActive(true)
local reddot=changeManagerCheckModel:getBuildingReddot(self.bdData.un_build_id)
self.btnSelectReddot:setActive(reddot)
end
end

function UIManufactureWin:getMoveDuration(posA,posB,speed)
speed=speed or _moveSpeed
return math.abs(posB-posA)/speed
end

function UIManufactureWin:killAllDoTween(model)
if model.moveTween then
model.moveTween:Kill(false)
end
if model.jumpTween then
model.jumpTween:Kill(false)
end
if model.fadeTween then
model.fadeTween:Kill(false)
end
end

function UIManufactureWin:initDzModel(model)
model.transform=self.winlua:GetChildGameObject(model:getID()).transform
model.canvasGroup=_helper.GetCanvasGroup(model.transform.gameObject)
end

function UIManufactureWin:getPlantEffects(dzId)
local configs=discipleSelectController.getSpeciallistByBuild(dzId,self.bdType)
return configs
end

function UIManufactureWin:checkCost(cost)
for i,v in ipairs(cost)do
local change=math.ceil(v[2]*self.bdData.pcreatesubpercent/100)
local nedd=v[2]+change
if moneyModel.getMoney(v[1])<nedd then
local name=moneyModel.getMoneyName(v[1])
UIManager.error(_format('%s不足',name))
gainControl:showGainWin(v[1])
return false,v[1],v[2]
end
end
return true
end

function UIManufactureWin:checkAdditionalWork()
local checkConfig=_check_additional_work[self.bdData.build_id]
if checkConfig then
for i,v in ipairs(checkConfig)do
if v.check(self.bdData)then
return false,v.tips
end
end
end
return true
end

function UIManufactureWin:onClickSelect()
if self.workCheck1 or self.workCheck2 then
UIManager.error('工作交接中')
return
end
if tostring(self.bdData.dizi_id)~='0'then
if self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能更换弟子')
return
end




end

local check,tips=self:checkAdditionalWork()
if not check then
UIManager.error(tips)
return
end

zongmenControl:showSelectManagerWin(self.sfId,self.bdData)
end

function UIManufactureWin:onClickClose()
self:closeSelf()
end

function UIManufactureWin:onBtnUpgrade()
if buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)then
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
else
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end
end

function UIManufactureWin:checkPlant()
local flag=self.bdData.flag
if flag==buildingStateType.eBuilding or flag==buildingStateType.eUpgrading then
return false
end

local dzId=self.bdData.dizi_id
if tostring(dzId)=='0'then return false end

if self.bdData.plant_id>0 then return false end

if not UIDiscipleModel:checkDZStateToDoSomething(dzId,eCheckDiscipleStateOpType.eProduce,false)then
return false
end
return true
end

function UIManufactureWin:onExecutePlant(index)
local flag=self.bdData.flag
if flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能进行生产')
return
elseif flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能进行生产')
return
end

local dzId=self.bdData.dizi_id

if self.bdData.plant_id>0 then
UIManager.error('正在进行生产')
return
end

if not UIDiscipleModel:checkDZStateToDoSomething(dzId,eCheckDiscipleStateOpType.eProduce,true)then
return
end

local plan=self.curLvCfg.produce_plans[index]
local costFlag,costType,costNum=self:checkCost(plan.cost)
if not costFlag then
self.checkType=costType

UIDiscipleController.doTriggerSomething(dzTriggerDoSomething.ePrivateMoney,{costType,costNum})
return
end

if tostring(dzId)~='0'then

zongmenControl:reqSchemePlantEx(self.sfId,1,{{index,self.bdData.un_build_id}},self.bdData)
else
self.wait_building_plant_mgr=index
zongmenControl:showSelectManagerWin(self.sfId,self.bdData)
end
end

function UIManufactureWin:onBtnGetRewards()
local canReceive=buildingCDControl:isCanReceive(buildingCDType.plan,self.bdData.un_build_id)
if canReceive then
zongmenControl:getPlantRewards(self.sfId,self.bdData)
else
UIManager.error('暂无产出，请祖师静候')
end
end

function UIManufactureWin:onCleanPlant(index)
if not self.clean_plant_dialog then
local show_data={
type='UIDialouge',
title='提示',
content='是否清除方案生产资源',
oktext='确定',
canceltext='取消',
okcallback=function()
zongmenControl:reqCleanPlantReward(self.sfId,self.bdData.un_build_id)
end
}
self.clean_plant_dialog=UIDialogManager.newDialog(show_data)
end
self.clean_plant_dialog:show()
end

function UIManufactureWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView2:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.bdData.dizi_id,config=data})
end

function UIManufactureWin:onClickSpecialityPanel()
self.specialityPanel:setActive(false)
end

function UIManufactureWin:onBtnAdsSpeedup()
zongmenModel:refreshBuildingEffect(self.bdData)
if self.speedUpMode==0 then
zongmenControl:reqSpeedup(speedUpMode.eFree,1,0,self.speedup_type,self.sfId,self.bdData.un_build_id)
elseif self.speedUpMode==1 then

local have=bagModel.getNotExpireItemCountById(self.speedup_item_id)
if have<self.speedup_item_count then

gainControl:showGainWin(self.speedup_item_id)
return
end
local cc=math.floor(have/self.speedup_item_count)
if self.lastTime>self.batchTime and cc>1 then
local desc='消耗<color=#7d3b17>{0}</color>张加速符\n加速<color=#7d3b17>{1}</color>'
local desc2='消耗<color=#7d3b17>{0}</color>张加速仙符加速<color=#7d3b17>{1}</color>'
local max=math.min(have,math.ceil(self.lastTime/self.speedup_time))
local speedupItemId=self.speedup_item_id
local speedupItemCount=self.speedup_item_count
local speedupType=self.speedup_type
local speedupTime=self.speedup_time
local sfId=self.sfId
local ubdid=self.bdData.un_build_id
local allPlantCfg=zongmenModel:getBuildingAllPlant(self.curLvCfg.build_id,self.curLvCfg.level)

local plantCfg=allPlantCfg[self.bdData.plant_id]
local pcreateaddpercent=self.bdData.pcreateaddpercent
local pcreatesubpercent=self.bdData.pcreatesubpercent
local pcreatetimepercent=self.bdData.pcreatetimepercent
local hasExNum=self.bdData.hasExNum
local un_build_id=self.bdData.un_build_id
local plant_id=self.bdData.plant_id
local sfid=self.sfId
local args={
plant_id=plant_id,
un_build_id=un_build_id,
hasExNum=hasExNum,
speedupTime=speedupTime,
plantCfg=plantCfg,
sfid=sfid,
firsttime=self.lastTime,
pcreateaddpercent=pcreateaddpercent,
pcreatesubpercent=pcreatesubpercent,
pcreatetimepercent=pcreatetimepercent,
currVal=max,
minVal=1,
maxVal=max,
itemData={speedupItemId,have},
descFunc=function(val)
return FMT.fmt(desc,val,timeHelper.format_time_stamp11(speedupTime*val))
end,
descFunc2=function(val)
return FMT.fmt(desc2,val,timeHelper.format_time_stamp11(speedupTime*val))
end,
applyFunc=function(val)
if val>0 then

local notExpireCount=bagModel.getNotExpireItemCountById(speedupItemId)
local useCount=val*speedupItemCount
if notExpireCount<useCount then
UIManager.error(FMT.fmt('{0}已过期',itemsConfig.getItemName(speedupItemId)))
return
end
zongmenControl:reqSpeedup(speedUpMode.eItem,val,speedupItemId,speedupType,sfId,ubdid)
end
end
}
if systemModel.isOpen(SYSTEM_DEFINE.eBatchProduceAccelerate)then
UIManager:showWindow('UIManufacture_addSpeedWin',args)
else
UIManager:showWindow('UIBatchUseWin',args)
end

else
zongmenControl:reqSpeedup(speedUpMode.eItem,self.speedup_item_count,self.speedup_item_id,self.speedup_type,self.sfId,self.bdData.un_build_id)
end
else









end
end

function UIManufactureWin.on_skill_level_change(dzId,skillId)
if tostring(_this.bdData.dizi_id)==tostring(dzId)then
_this:refreshLeftPanel()
end
end

function UIManufactureWin:onDog()
xianChongControl:showFastManufactureWin()
end

function UIManufactureWin:onState()
UIManager:showWindow('UIBuffStateWin',self.bdData)
end

function UIManufactureWin:onTechan()
UIManager:showWindow('UISpecialty',self.bdData)
end

function UIManufactureWin:onAdItemClick()
if self.speedup_item_id then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=self.speedup_item_id})
end
end

function UIManufactureWin:onCheckSpecialtyBtn()
self:showPageBtns(2)
local widgets=self.scrollView:getChildScrollViewItemWidgets()
local len=widgets.Count
for i=0,len-1 do
local widget=widgets[i]
widget:SetChildActive(_item_cmp_index.info,false)
widget:SetChildActive(_item_cmp_index.specialty,true)
end
end

function UIManufactureWin:onCheckCostBtn()
self:showPageBtns(1)
local widgets=self.scrollView:getChildScrollViewItemWidgets()
local len=widgets.Count
for i=0,len-1 do
local widget=widgets[i]
widget:SetChildActive(_item_cmp_index.info,true)
widget:SetChildActive(_item_cmp_index.specialty,false)
end
end

function UIManufactureWin:setTotalBtnImage(isOn)
self.totalBtn:setImageSprite(isOn and self.sprite_button_zongshouhuo_2 or self.sprite_button_zongshouhuo_1)
end

function UIManufactureWin:onTotalBtn()
self:setTotalBtnImage(true)
UIManager:showWindow('UIManufactureRewardWin',self.bdData)
end

function UIManufactureWin:onLevelUpBtn()
self:onBtnUpgrade()
end

function UIManufactureWin:onLeftArrow()
self:toNextWin(-1)
end

function UIManufactureWin:onRightArrow()
self:toNextWin(1)
end
