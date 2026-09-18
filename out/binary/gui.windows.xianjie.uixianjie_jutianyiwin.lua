







def_class("UIXianJie_JuTianYiWin",UIWindowBase)








function UIXianJie_JuTianYiWin:bindComponents()

self.accelerateBtn=UIButton.get(self,0)
self.accelerateBtnReddot=UIObject.get(self,1)
self.animDog=UIObject.get(self,2)
self.animLdl=UIObject.get(self,3)
self.animRoot=UIObject.get(self,4)
self.bdLevel=UIText.get(self,5)
self.btnSelect=UIObject.get(self,6)
self.btnSelectReddot=UIObject.get(self,7)
self.btnSwitch=UIObject.get(self,8)
self.btnSwitchReddot=UIObject.get(self,9)
self.collectBg=UIObject.get(self,10)
self.detailBg=UIObject.get(self,11)
self.detailMask=UIButton.get(self,12)
self.diziInfo=UIObject.get(self,13)
self.diziLock=UIText.get(self,14)
self.dzModel=UIObject.get(self,15)
self.dzName=UIText.get(self,16)
self.dzSkill=UIText.get(self,17)
self.incrRatio=UISlider.get(self,18)
self.info_buildEffect=UIText.get(self,19)
self.info_gubaoMQEffect=UIText.get(self,20)
self.info_gubaoXQEffect=UIText.get(self,21)
self.info_mqEffect=UIText.get(self,22)
self.info_produce=UIText.get(self,23)
self.info_sceneEffect=UIText.get(self,24)
self.info_skillEffect=UIText.get(self,25)
self.info_specialityEffect=UIText.get(self,26)
self.info_statusEffect=UIText.get(self,27)
self.info_xingchen=UIText.get(self,28)
self.info_xingchen2=UIText.get(self,29)
self.info_xqEffect=UIText.get(self,30)
self.info_ydtEffect=UIText.get(self,31)
self.levelUpBtn=UIButton.get(self,32)
self.levelUpBtnText=UIText.get(self,33)
self.mbg=UIObject.get(self,34)
self.moIncr=UIText.get(self,35)
self.moMoneyBg=UIObject.get(self,36)
self.moMoneyIcon=UIObject.get(self,37)
self.moRate=UIObject.get(self,38)
self.MQEffect=UIText.get(self,39)
self.ratioText=UIText.get(self,40)
self.root=UIObject.get(self,41)
self.scrollView2=UIObject.get(self,42)
self.state=UIToggleButton.get(self,43)
self.talkObj=UIObject.get(self,44)
self.useItemBg=UIObject.get(self,45)
self.useItemContent=UIObject.get(self,46)
self.useItemMask=UIButton.get(self,47)
self.xianIncr=UIText.get(self,48)
self.xianMoneyBg=UIObject.get(self,49)
self.xianMoneyIcon=UIObject.get(self,50)
self.xianRate=UIObject.get(self,51)
self.XQEffect=UIText.get(self,52)

self.accelerateBtn:setButtonClick(function()self:onAccelerateBtn()end)

self.detailMask:setButtonClick(function()self:onDetailMask()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.useItemMask:setButtonClick(function()self:onUseItemMask()end)
self.info={
["buildEffect"]=self.info_buildEffect,
["gubaoMQEffect"]=self.info_gubaoMQEffect,
["gubaoXQEffect"]=self.info_gubaoXQEffect,
["mqEffect"]=self.info_mqEffect,
["produce"]=self.info_produce,
["sceneEffect"]=self.info_sceneEffect,
["skillEffect"]=self.info_skillEffect,
["specialityEffect"]=self.info_specialityEffect,
["statusEffect"]=self.info_statusEffect,
["xingchen"]=self.info_xingchen,
["xingchen2"]=self.info_xingchen2,
["xqEffect"]=self.info_xqEffect,
["ydtEffect"]=self.info_ydtEffect,
}


self.sprite_image_waichu=0
self.sprite_image_kongwei=1
self.sprite_button_zongshouhuo_1=2
self.sprite_button_zongshouhuo_2=3

end


function UIXianJie_JuTianYiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.accelerateBtn);self.accelerateBtn=nil;
_UIObject_release(self.accelerateBtnReddot);self.accelerateBtnReddot=nil;
_UIObject_release(self.animDog);self.animDog=nil;
_UIObject_release(self.animLdl);self.animLdl=nil;
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnSelectReddot);self.btnSelectReddot=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.btnSwitchReddot);self.btnSwitchReddot=nil;
_UIObject_release(self.collectBg);self.collectBg=nil;
_UIObject_release(self.detailBg);self.detailBg=nil;
_UIObject_release(self.detailMask);self.detailMask=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.diziLock);self.diziLock=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.dzSkill);self.dzSkill=nil;
_UIObject_release(self.incrRatio);self.incrRatio=nil;
_UIObject_release(self.info_buildEffect);self.info_buildEffect=nil;
_UIObject_release(self.info_gubaoMQEffect);self.info_gubaoMQEffect=nil;
_UIObject_release(self.info_gubaoXQEffect);self.info_gubaoXQEffect=nil;
_UIObject_release(self.info_mqEffect);self.info_mqEffect=nil;
_UIObject_release(self.info_produce);self.info_produce=nil;
_UIObject_release(self.info_sceneEffect);self.info_sceneEffect=nil;
_UIObject_release(self.info_skillEffect);self.info_skillEffect=nil;
_UIObject_release(self.info_specialityEffect);self.info_specialityEffect=nil;
_UIObject_release(self.info_statusEffect);self.info_statusEffect=nil;
_UIObject_release(self.info_xingchen);self.info_xingchen=nil;
_UIObject_release(self.info_xingchen2);self.info_xingchen2=nil;
_UIObject_release(self.info_xqEffect);self.info_xqEffect=nil;
_UIObject_release(self.info_ydtEffect);self.info_ydtEffect=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.moIncr);self.moIncr=nil;
_UIObject_release(self.moMoneyBg);self.moMoneyBg=nil;
_UIObject_release(self.moMoneyIcon);self.moMoneyIcon=nil;
_UIObject_release(self.moRate);self.moRate=nil;
_UIObject_release(self.MQEffect);self.MQEffect=nil;
_UIObject_release(self.ratioText);self.ratioText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.state);self.state=nil;
_UIObject_release(self.talkObj);self.talkObj=nil;
_UIObject_release(self.useItemBg);self.useItemBg=nil;
_UIObject_release(self.useItemContent);self.useItemContent=nil;
_UIObject_release(self.useItemMask);self.useItemMask=nil;
_UIObject_release(self.xianIncr);self.xianIncr=nil;
_UIObject_release(self.xianMoneyBg);self.xianMoneyBg=nil;
_UIObject_release(self.xianMoneyIcon);self.xianMoneyIcon=nil;
_UIObject_release(self.xianRate);self.xianRate=nil;
_UIObject_release(self.XQEffect);self.XQEffect=nil;
self.info=nil;
end


















local _this
local _format=string.format
local _helper=CS.UIHelper
local _moveSpeed=200


function UIXianJie_JuTianYiWin:onLoaded(...)
self:bindComponents()
_this=self

self.enterPos={-30,-288}
self.leftPos={-320,-288}
self.rightPos={-30,-288}
self.jumpPos={-60,-330}

self.dogLeftPos={-270,-355}
self.dogRightPos={0,-355}

self.abName='ui/sharedtextures/uiglobalspriteatlas_1.ab'
self.iconAB='ui/icons/manufacture/sharedtextures/icon_manufacture_pack1.ab'
self.imageAB='ui/windows/manufacture/sharedtextures/uimanufactureatlas.ab'
self.scrollView2:setChildScrollViewInit(0,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)

self.openUseItemBg=false

self.state:setToggleChange(function(name,isOn,data)
if isOn then
self:onState()
end
end)
self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_Money_Changed)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onDiscipleJobChange,self.on_skill_level_change)











end

function UIXianJie_JuTianYiWin:setStateButton(bActive)
self.state:setToggle(bActive)
end


function UIXianJie_JuTianYiWin:__delete()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onDiscipleJobChange,self.on_skill_level_change)

self:clear()

if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end

self:unbindComponents()
_this=nil
end

function UIXianJie_JuTianYiWin:clear()
self:clearInstances()

if self.ctimer then
self:stopTimerByID(self.ctimer)
self.ctimer=nil
end
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end
end

function UIXianJie_JuTianYiWin:clearInstances()
if self.eventTipsHUD then
_InstantiateManager.RemoveInstance(self.eventTipsHUD)
end

if self.dogSTID then
_InstantiateManager.RemoveInstance(self.dogSTID)
end

uiAIManager:clearUIWinData('UIXianJie_JuTianYiWin')
self.currDZ=nil
self.lastDZ=nil
self.dogBT=nil

self.workCheck1=nil
self.workCheck2=nil
end




function UIXianJie_JuTianYiWin:onShow(argtable,afterOnloaded)
if argtable==nil then
return
end
if afterOnloaded then
self.mbg:setChildUIModelShowTarget(6001,1,nil,eAnimationID.stand,false,false,0)
end
self.useItemBg:setActive(self.openUseItemBg)
self.useItemMask:setActive(self.openUseItemBg)
self:refresh(argtable,true)

self:refreshSpeakTimer()
end

function UIXianJie_JuTianYiWin:onShowArgRecv(argtable)
local oldId=self.entityId
local newId=argtable.entityId
if newId~=oldId then
self:__delete()
self:onLoaded()
self:onShow(argtable)
end
end

function UIXianJie_JuTianYiWin:refreshSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end
local speakInterval=cfgHelper.getdef1(cfg_jutianyiconfig,"speakInterval")
local speakRate=cfgHelper.getdef1(cfg_jutianyiconfig,"speakRate")
self.speakTimer=self:setTimer(speakInterval,0,function()
local r=math.random()
if r<speakRate then
self:setSelfSpeak()
end
end)
end

function UIXianJie_JuTianYiWin:refresh(argtable,isInit)
local guid=argtable.entityId
self.entityId=guid
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)

self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
UIManager:callWindowFunc('UIBottomMaskWin','setTitle',self.config.name)
UIManager:callWindowFunc('UIBottomMaskWin','refreshFrdRoot')

self.bdType=self.config.id
self.first_tick=true

self.lastTime=0

self:refreshLeftPanel()
self:refreshRightPanel(isInit)
self:refreshAccelerateItemPanel(isInit)
self:refreshDetailInfoPanel()

self:clearInstances()













self.ctimer=self:delayDo(0.5,function(...)
self:initAI(self.bdData.dizi_id)
end)

end

function UIXianJie_JuTianYiWin:showDzModel()
local dzId=self.bdData.dizi_id
if tostring(dzId)=='0'then
self.dzModel:setChildUIModelRemoveTarget()
return
end
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzId,true,nil,nil)
self.dzModel:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,0,false,false,0,nil)
end

function UIXianJie_JuTianYiWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if _this.bdData.un_build_id~=bdId then
return
end
if etype==buildingEvent.replaceDisciple then
_this:refreshAI(arg1,arg2)

_this:refreshLeftPanel()
_this:refreshRightInfoPanel()
_this:refreshDetailInfoPanel()
elseif etype==buildingEvent.levelUpComplete
or etype==buildingEvent.levelUpStart then
_this:refreshLeftPanel()
_this:refreshRightInfoPanel()
_this:refreshDetailInfoPanel()
end
end

function UIXianJie_JuTianYiWin:refreshLevelUpPanel()
self.bdLevel:setText(_format('%s级%s',self.bdData.level,self.config.name))
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id,true)
if cddata and cddata.complete then
self.levelUpBtnText:setText('完成升级')
return
end
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
self.levelUpBtnText:setText(nextLvCfg~=nil and'建筑升级'or'建筑信息')
end

function UIXianJie_JuTianYiWin:showBuffState()
self.state:setActive(tostring(self.bdData.dizi_id)~='0')
end

function UIXianJie_JuTianYiWin:refreshLeftPanel()
local dzId=self.bdData.dizi_id
local haveDz=tostring(dzId)~='0'
local state=haveDz and UIDiscipleModel:getDiscipleState(dzId)or nil
self:showBuffState()
self:refreshLevelUpPanel()

if self.bdData.flag==buildingStateType.eUpgrading then
self.animLdl:setActive(true)
self.animLdl:setChildUIModelShowTarget(2002,1,nil,eAnimationID.stand)
self.animLdl:setChildUIModelShowTargetOffset(-20,30)
self.animLdl:setChildModelAnimationState(eAnimationID.stand)
else
self.animLdl:setActive(false)
end

if haveDz then
local name=UIDiscipleModel:getDiscipleName(dzId)
self.dzName:setText(FMT.fmt('执事弟子：<color=#7d3b17>{0}</color>',name))
self.diziLock:setActive(false)
self.diziInfo:setActive(true)
self.btnSelect:setActive(false)
self.collectBg:setActive(true)

if self.bdData.flag~=buildingStateType.eUpgrading then
self.btnSwitch:setActive(true)
self.btnSwitch:setRotation(0,0,0)
local shake=changeManagerCheckModel:getBuildingReddot(self.bdData.un_build_id)
self.btnSwitchReddot:setActive(shake)
if shake then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.btnSwitch:getID())
else
self.winlua:SetChildDOTweenAnimation_DOPause(self.btnSwitch:getID())
end
else
self.btnSwitch:setActive(false)
end

local bd_tybe_cfg=cfg_monijybuildconfig_get(self.config.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local skill_effect=nil
if skill_cfg.jutianyi_effects then
skill_effect=skill_cfg.jutianyi_effects[level]
end

local content=_format('%s：%s级',skill_cfg.name,level)
self.dzSkill:setText(content)
end

local xq_effect=JuTianYiModel:getIncreaseAddition(1)
local xq_effect_content=FMT.fmt('仙气收集效率:{0}%',xq_effect)
self.XQEffect:setText(xq_effect_content)
local mq_effect=JuTianYiModel:getIncreaseAddition(2)
local mq_effect_content=FMT.fmt('魔气收集效率:{0}%',mq_effect)
self.MQEffect:setText(mq_effect_content)

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
self.diziLock:setActive(true)
self.diziInfo:setActive(false)
self.btnSwitch:setActive(false)
self.btnSelect:setActive(true)
self.collectBg:setActive(false)


end
end

function UIXianJie_JuTianYiWin:refreshRightPanel(isInit)
local curXianRate=JuTianYiModel:getXianQiRate()
local defCfg=cfgHelper.getdef(cfg_jutianyiconfig)
self.winlua:SetChildSlider(self.incrRatio:getID(),curXianRate,0,10,function(val)
self:refreshRightInfoPanel(val)
local xianRate=val
local moRate=10-val
JuTianYiController.reqChangeRate(moRate,xianRate)
end)
if isInit then
local xianIcon=iconHelper.getIconName(defCfg.money_id1)
self.xianMoneyIcon:setChildIcon(xianIcon,true)
local moIcon=iconHelper.getIconName(defCfg.money_id2)
self.moMoneyIcon:setChildIcon(moIcon,true)
end
self:refreshRightInfoPanel(curXianRate)
end

function UIXianJie_JuTianYiWin:refreshRightInfoPanel(xianRate)
if not xianRate then
xianRate=JuTianYiModel:getXianQiRate()
end
local level=self.bdData.level
local init_produce=cfgHelper.get2(cfg_jutianyiconfig_get,level,'init_produce')
local xianIncrRate=JuTianYiModel:getIncreaseAddition(1)
local moIncrRate=JuTianYiModel:getIncreaseAddition(2)
local defCfg=cfgHelper.getdef(cfg_jutianyiconfig)
local times=(3600/defCfg.interval)*defCfg.coefficient_a
local moRate=10-xianRate
self.ratioText:setText(_format("%d:%d",xianRate,moRate))


local xianIncrNumByHour=mathHelper.floor(init_produce*(xianIncrRate/100))*times*(xianRate/10)
xianIncrNumByHour=mathHelper.floor(xianIncrNumByHour)
self.xianIncr:setText(_format("%s/时",xianIncrNumByHour))
local moIncrNumByHour=mathHelper.floor(init_produce*(moIncrRate/100))*times*(moRate/10)
moIncrNumByHour=mathHelper.floor(moIncrNumByHour)
self.moIncr:setText(_format("%s/时",moIncrNumByHour))
self.xianRate:setChildIconFillAmount(xianRate/10)
self.moRate:setChildIconFillAmount(moRate/10)

local scale1=Mathf.Clamp((0.75+xianRate*0.05),0.75,1)
local scale2=Mathf.Clamp((0.75+moRate*0.05),0.75,1)
if xianRate<=0 then
self.xianMoneyBg:setChildDOScale(0,0.3)
self.moMoneyBg:setChildDOScale(1,0.3)
elseif moRate<=0 then
self.xianMoneyBg:setChildDOScale(1,0.3)
self.moMoneyBg:setChildDOScale(0,0.3)
else
self.xianMoneyBg:setChildDOScale(scale1,0.3)
self.moMoneyBg:setChildDOScale(scale2,0.3)
end

local minRate=5-math.min(xianRate,moRate)
if xianRate<=0 or moRate<=0 then
self.xianMoneyBg:setChildDOLocalMoveX(0,0.3)
self.moMoneyBg:setChildDOLocalMoveX(0,0.3)
else
self.xianMoneyBg:setChildDOLocalMoveX(-100+minRate*10,0.3)
self.moMoneyBg:setChildDOLocalMoveX(100-minRate*10,0.3)
end
end


function UIXianJie_JuTianYiWin:refreshAccelerateItemList()
local accelerateItems=cfgHelper.getdef(cfg_jutianyiconfig,'accelerateItems')
self.itemList={}
self.itemListLookup={}
for i,v in ipairs(accelerateItems)do
local itemId,itemDesc=v[1],v[2]
local itemCount=itemsModel.getCount(itemId)
table.insert(self.itemList,{itemId=itemId,itemDesc=itemDesc,itemCount=itemCount})
end
table.sort(self.itemList,function(a,b)
if a.itemCount<=0 and b.itemCount>0 then
return false
elseif a.itemCount>0 and b.itemCount<=0 then
return true
end
return a.itemId<b.itemId
end)



for idx,v in ipairs(self.itemList)do
self.itemListLookup[v.itemId]=idx
end
self:refreshAccelerateReddot()
end


function UIXianJie_JuTianYiWin:refreshAccelerateReddot()
local reddot=false
for idx,v in ipairs(self.itemList)do
local have=bagModel.getItemCountById(v.itemId)





if have>0 then
reddot=true
break
end
end
self.accelerateBtnReddot:setActive(reddot)
end


function UIXianJie_JuTianYiWin:refreshAccelerateItemPanel()
self:refreshAccelerateItemList()
local clickCount=0
local cb=function(idx)
clickCount=clickCount+1
if clickCount>1 then return end
clickCount=0
if not self or self.isClose then return end
self:onAccItemClick(idx)
end
local finishCb=function(idx)
self:onAccItemClick_fn(idx)
end
self.useItemContent:setChildLayoutGroupCreateItems(#self.itemList,function(i)
local item=self.useItemContent:getChildLayoutGroupGridItem(i-1)
local itemid=self.itemList[i].itemId
local itemDesc=self.itemList[i].itemDesc
local itemnum=self.itemList[i].itemCount
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
itemsComponentHelper.onItemClick(...)
end)
item:SetChildText(1,itemsConfig.getItemName(itemid))
item:SetChildText(2,itemDesc)
item:SetChildImageExGray(3,itemnum<=0)
item:SetChildLongPress(3,i,cb,finishCb)
item:SetChildText(4,itemnum>0 and'使用'or'获得')
end)
end

function UIXianJie_JuTianYiWin:refreshDetailInfoPanel()
local baseCfg=cfgHelper.getdef(cfg_jutianyiconfig)
local level=JuTianYiController:getBuildingLevel()or 1
local init_produce=cfgHelper.get2(cfg_jutianyiconfig_get,level,'init_produce')or 0
self.info.produce:setText(string.format("产出：<color=#AAE252>%d/每分钟</color>",init_produce))
local add1,lv_addition1,pro_skill_add1,zmState_add1,sp_add1,gubao_add1,ydt_add1,scene_add1,xc_add1=JuTianYiModel:getIncreaseAddition(1)
local add2,lv_addition2,pro_skill_add2,zmState_add2,sp_add2,gubao_add2,ydt_add2,scene_add2,xc_add2=JuTianYiModel:getIncreaseAddition(2)
self.info.xqEffect:setText(FMT.fmt("仙气收集效率：<color=#AAE252>{0}%</color>",add1))
self.info.mqEffect:setText(FMT.fmt("魔气收集效率：<color=#AAE252>{0}%</color>",add2))
self.info.buildEffect:setText(FMT.fmt("基础效率：<color=#AAE252>{0}%</color>",lv_addition1))
self.info.skillEffect:setActive(pro_skill_add1>0)
self.info.skillEffect:setText(pro_skill_add1>0 and FMT.fmt("阵法等级：效率+<color=#AAE252>{0}%</color>",pro_skill_add1)or"阵法等级：暂无")
self.info.specialityEffect:setActive(sp_add1>0)
self.info.specialityEffect:setText(sp_add1>0 and FMT.fmt("特质加成：效率+<color=#AAE252>{0}%</color>",sp_add1)or"特质加成：暂无")
self.info.statusEffect:setActive(zmState_add1>0)
self.info.statusEffect:setText(zmState_add1>0 and FMT.fmt("仙堡状态：效率+<color=#AAE252>{0}%</color>",zmState_add1)or"仙堡状态：暂无")
self.info.gubaoXQEffect:setActive(gubao_add1>0)
self.info.gubaoXQEffect:setText(gubao_add1>0 and FMT.fmt("古宝加成-仙气：效率+<color=#AAE252>{0}%</color>",gubao_add1)or"古宝加成-仙气：暂无")
self.info.gubaoMQEffect:setActive(gubao_add2>0)
self.info.gubaoMQEffect:setText(gubao_add2>0 and FMT.fmt("古宝加成-魔气：效率+<color=#AAE252>{0}%</color>",gubao_add2)or"古宝加成-魔气：暂无")
self.info.ydtEffect:setActive(ydt_add1>0)
self.info.ydtEffect:setText(ydt_add1>0 and FMT.fmt("衍道台加成：效率+<color=#AAE252>{0}%</color>",ydt_add1)or"衍道台加成：暂无")
self.info.sceneEffect:setActive(scene_add1>0)
self.info.sceneEffect:setText(scene_add1>0 and FMT.fmt("场景加成：效率+<color=#AAE252>{0}%</color>",scene_add1)or"场景加成：暂无")
self.info.xingchen:setActive(xc_add1>0)
self.info.xingchen:setText(xc_add1>0 and FMT.fmt("星辰加成-仙气：效率+<color=#AAE252>{0}%</color>",xc_add1)or"星辰加成-仙气：暂无")
self.info.xingchen2:setActive(xc_add2>0)
self.info.xingchen2:setText(xc_add2>0 and FMT.fmt("星辰加成-魔气：效率+<color=#AAE252>{0}%</color>",xc_add2)or"星辰加成-魔气：暂无")

end

function UIXianJie_JuTianYiWin:onAccItemClick(idx)
local dzId=self.bdData.dizi_id
local haveDz=tostring(dzId)~='0'
if not haveDz then
UIManager.info("请先安排弟子")
return
end

















local itemid=self.itemList[idx].itemId
local have=bagModel.getItemCountById(itemid)
if have<=0 then
self:stopItemLongPress(idx)
gainControl:showGainWin(itemid)
return
end
local num=1
if self.useGoodTime~=nil then
local cur=Time.realtimeSinceStartup
local lerp=cur-self.useGoodTime
if lerp>=10 then
num=10
elseif lerp>=6 then
num=5
elseif lerp>=3 then

num=3
elseif lerp>=2 then

num=2
end
else
self.useGoodTime=Time.realtimeSinceStartup
end
if num>have then
num=have
end
local cb=function()

local datas=JuTianYiController:getBuildingData()
if datas and datas.un_build_id then
JuTianYiModel:recordLastRate()
zongmenControl:reqSpeedup(speedUpMode.eItemBuilding,num,itemid,speedUpType.eJuTianYi,mapIdType.fort,datas.un_build_id)
end
end
local isMaxProtectionCapacity=TaiXuCangModel:checkAboveProtectMoney()
if isMaxProtectionCapacity then
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eJuTianYiAcc)
if not check then
self:stopItemLongPress(idx)
local content='当前太虚仓已达到最大保护容量，是否继续加速？'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=cb,
showclosebtn=true,
choosetext="今日不再提示",
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eJuTianYiAcc,flag)
end,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else
cb()
end
else
cb()
end
end

function UIXianJie_JuTianYiWin:onAccItemClick_fn(idx)
self.useGoodTime=nil
self:recordClickCount()
end

function UIXianJie_JuTianYiWin:stopItemLongPress(idx)
local item=self.useItemContent:getChildLayoutGroupGridItem(idx-1)
if item then
item:SetChildLongPressStop(3)
end
end

function UIXianJie_JuTianYiWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
if _this.itemListLookup[itemid]then
if newcount>0 then
local idx=_this.itemListLookup[itemid]
local item=_this.useItemContent:getChildLayoutGroupGridItem(idx-1)
if item then
item:SetChildItemData(0,PropIndex(DataPropKey.eWidgetActive,2),newcount>1)
item:SetChildItemData(0,PropIndex(DataPropKey.eWidgetText,3),newcount>1 and tostring(newcount)or'')
end
else
local idx=_this.itemListLookup[itemid]
_this:stopItemLongPress(idx)
_this:refreshAccelerateItemPanel()
end
end
end

function UIXianJie_JuTianYiWin.on_Money_Changed(moneyType,lastVal,val,isIncrPost)
if _this==nil then return end
if not isIncrPost then return end
if moneyType~=eMoneyType.mtXianQi and moneyType~=eMoneyType.mtMoQi then
return
end
local changeVal=val-lastVal
local str=string.format("%s+%d",moneyType==eMoneyType.mtXianQi and"仙气"or"魔气",changeVal)
local nowTime=timeHelper.getServerShortTime()
if _this.thownTime and(nowTime-_this.thownTime)<0.3 then
local passTime=0.3-(nowTime-_this.thownTime)
_this.thownTime=nowTime+passTime
_this:delayDo(passTime,function()
commonTipsHelper.addThrowOutAndSliderTips(1,str)
end)
else
_this.thownTime=nowTime
commonTipsHelper.addThrowOutAndSliderTips(1,str)
end
end

function UIXianJie_JuTianYiWin.on_gnosis_callback()













end

function UIXianJie_JuTianYiWin:recordClickCount()
if self.clickTime==nil or(Time.realtimeSinceStartup-self.clickTime<0.5)then
self.clickCount=self.clickCount==nil and 1 or(self.clickCount+1)
else
self.clickCount=0
end
if self.clickCount>=5 then
self.clickCount=0


self:showTalk('长按可批量使用物品')
end
self.clickTime=Time.realtimeSinceStartup
end

function UIXianJie_JuTianYiWin:showTalk(talkStr)
self:clearTalk()

self.talkObj:setActive(true)
local talkWidget=self.talkObj:getChildWidgetBase()
talkWidget:SetChildText(0,talkStr)
self.talkObj:setChildCanvasGroupAlpha(0)
self.talkObj:setChildCanvasGroupDOFade(1,0.1,nil)
self.talkObj:setScale(Vector3.New(0,0,0))
self.talkObj:setChildDOScale(1,0.2,nil)

local func=function()
self:clearTalk()
end
self.talkTimer=self:delayDo(5,func)
end

function UIXianJie_JuTianYiWin:clearTalk()
if self.talkTimer~=nil then
self.talkObj:setActive(false)
self:stopTimerByID(self.talkTimer)
self.talkTimer=nil
end
end

function UIXianJie_JuTianYiWin:initDzModel(model)
model.transform=self.winlua:GetChildGameObject(model:getID()).transform
model.canvasGroup=_helper.GetCanvasGroup(model.transform.gameObject)
end

function UIXianJie_JuTianYiWin:getPlantEffects(dzId)
local configs=discipleSelectController.getSpeciallistByBuild(dzId,self.bdType)
return configs
end

function UIXianJie_JuTianYiWin:onClickSelect()




if tostring(self.bdData.dizi_id)~='0'then
if self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能更换弟子')
return
end




end

zongmenControl:showSelectManagerWin(self.sfId,self.bdData,nil,dzSelectEffectType.eJuTianYi)
end

function UIXianJie_JuTianYiWin:onClickClose()
self:closeSelf()
end

function UIXianJie_JuTianYiWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView2:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.bdData.dizi_id,config=data})
end

function UIXianJie_JuTianYiWin.on_skill_level_change(dzId,skillId)
if tostring(_this.bdData.dizi_id)==tostring(dzId)then
_this:refreshLeftPanel()
_this:refreshRightInfoPanel()
_this:refreshDetailInfoPanel()
end
end

function UIXianJie_JuTianYiWin:onDog()
xianChongControl:showFastManufactureWin()
end

function UIXianJie_JuTianYiWin:onState()
self.openDetailBg=not self.openDetailBg
self.detailBg:setActive(self.openDetailBg)
self.detailMask:setActive(self.openDetailBg)
end

function UIXianJie_JuTianYiWin:onLevelUpBtn()
if buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)then
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
else
UIManager:showWindow('UIXJBuildingInfoWin',self.bdData)
end
end

function UIXianJie_JuTianYiWin:onAccelerateBtn()
self.openUseItemBg=not self.openUseItemBg
self.useItemBg:setActive(self.openUseItemBg)
self.useItemMask:setActive(self.openUseItemBg)
end

function UIXianJie_JuTianYiWin:onUseItemMask()
self.openUseItemBg=false
self.useItemBg:setActive(self.openUseItemBg)
self.useItemMask:setActive(self.openUseItemBg)
end

function UIXianJie_JuTianYiWin:onDetailMask()
self.openDetailBg=false
self.detailBg:setActive(self.openDetailBg)
self.detailMask:setActive(self.openDetailBg)
self:setStateButton(false)
end

function UIXianJie_JuTianYiWin:getDZId()
local dzid=self.bdData.dizi_id
if dzId=='0'then return end
return dzid
end

function UIXianJie_JuTianYiWin:initAI(dzId)
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











end)
end

function UIXianJie_JuTianYiWin:createDZ(dzId,pos,callback)
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
uiAIManager:createUIDisciple('UIXianJie_JuTianYiWin','bt_ui_common_move',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end

function UIXianJie_JuTianYiWin:setSelfSpeak()
if not self.currDZ then
return
end
local lib=cfgHelper.getdef1(cfg_jutianyiconfig,"speakLib")
local r=math.random(1,#lib)
local content=lib[r]
local widget=self.currDZ:getSharedVar('dzWidget')
local index=self.currDZ:getSharedVar('speakHUDParent')
local parent=widget:GetCommonComponent(index,'Transform')
if self.sHUD then
local hudWidget=_InstantiateManager.GetComponent(self.sHUD,'CSGUIWidgetBase')
local txt=chatEmotHelper.decodeEmot(content)or''
hudWidget:SetChildText(0,txt)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
else
self.sHUD=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleSpeak,parent,function(id)
if self.sHUD==id then
local hudWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local offsetVal=Vector2.New(0,-15)
hudWidget:SetChildAnchoredPosition(2,offsetVal)
local txt=chatEmotHelper.decodeEmot(content)or''
hudWidget:SetChildText(0,txt)
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(1)
hudWidget:SetChildCSImageSprite(1,abName,skinName)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
else
hudControl:removeHUD(id)
self.sHUD=nil
end
end)
end
local speakDuration=cfgHelper.getdef1(cfg_jutianyiconfig,"speakDuration")
self:delayDo(speakDuration,function()
self:removeSelfSpeak()
end)
end

function UIXianJie_JuTianYiWin:removeSelfSpeak()
if self.sHUD then
_InstantiateManager.RemoveInstance(self.sHUD)
self.sHUD=nil
end
end

function UIXianJie_JuTianYiWin:createDog(pos,callback)
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
self.dogSTID=uiAIManager:createUIObject('UIXianJie_JuTianYiWin','bt_ui_dog',INSTANCE_TYPE.eUIDog,440011,
tran,vpos,initData,otherData,function(bt)
local stWidget=bt:getSharedVar('stWidget')
stWidget:SetChildButtonClick(2,function()
self:onDog()
end)
stWidget:SetChildNewBieComponentId(2,'UIXianJie_JuTianYiWin.UIDog.click')
callback(bt)
end)
end

function UIXianJie_JuTianYiWin:startWork(bt)
self.workCheck1=false
end

function UIXianJie_JuTianYiWin:endWork()

uiAIManager:removeUIInstance(self.lastDZ)
self.lastDZ=nil
self.workCheck2=false
end


function UIXianJie_JuTianYiWin:getSpeakText(bt,tkey,stype)
local cfg=cfgHelper.get1(cfg_aiplanworkconfig_get,1)
local speaks=cfg[string.format('uispeak%d',stype)]
local txt=speaks[math.random(1,#speaks)]
bt:setSharedVar(tkey,txt)
end


function UIXianJie_JuTianYiWin:getDogSpeakText(bt,tkey,stype)



bt:setSharedVar(tkey,'祖师，我可以帮您快速安排生产哦')
end


function UIXianJie_JuTianYiWin:getDogMovePos(bt,pkey)
local dx=self.dogRightPos[1]-self.dogLeftPos[1]
local px=self.dogLeftPos[1]+dx*math.random()
local pos={px,self.dogLeftPos[2]}
bt:setSharedVar(pkey,pos)
end

function UIXianJie_JuTianYiWin:refreshAI(newDzId,oldDzId)
local newDzIdStr=tostring(newDzId)
local oldDzIdStr=tostring(oldDzId)





if oldDzIdStr~='0'and self.currDZ then












self:removeSelfSpeak()
uiAIManager:removeUIInstance(self.currDZ)
self.currDZ=nil
end
if newDzIdStr~='0'then
self.currDZ=self:createDZ(self.bdData.dizi_id,self.enterPos,function(bt)
self.currDZ=bt
self.currDZ:setSharedVar('UIstateId',1)
self.currDZ:tick(0.5)
end)
self:refreshSpeakTimer()
self.workCheck1=true
end
end

function UIXianJie_JuTianYiWin:changeWorkState(sId)
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