







def_class("UIZhenFaStudyWin",UIWindowBase)









function UIZhenFaStudyWin:bindComponents()

self.root=UIObject.get(self,0)
self.infoPanel=UIObject.get(self,1)
self.zhenfa=UIObject.get(self,2)
self.dzEmpty=UIObject.get(self,3)
self.flyIcon=UIImage.get(self,4)
self.zhenfaBtn=UIButton.get(self,5)
self.imgPause=UIObject.get(self,6)
self.btnSwitch=UIObject.get(self,7)
self.btnSelect=UIObject.get(self,8)
self.imgState=UIImage.get(self,9)
self.qipao=UIObject.get(self,10)
self.diziLock=UIObject.get(self,11)
self.diziInfo=UIObject.get(self,12)
self.nameTx=UIText.get(self,13)
self.upList=UIObject.get(self,14)
self.timeProgress=UIProgress.get(self,15)
self.descTx=UIText.get(self,16)
self.clock=UIObject.get(self,17)
self.timeProgressTx=UIText.get(self,18)
self.timeProgressSp=UIObject.get(self,19)
self.rewardIcon=UIImage.get(self,20)
self.skill=UIText.get(self,21)
self.scrollView2=UIObject.get(self,22)
self.dzName=UIText.get(self,23)
self.rewardCount=UIText.get(self,24)
self.tzTips=UIText.get(self,25)
self.exTipsBtn1=UIButton.get(self,26)
self.exTipsIng1=UIObject.get(self,27)
self.exTipsBtn2=UIButton.get(self,28)
self.exTipsIng2=UIObject.get(self,29)
self.accelerateCost=UIObject.get(self,30)
self.costIcon=UIObject.get(self,31)
self.costValue=UIText.get(self,32)
self.accelerateBtn=UIButton.get(self,33)
self.accelerateRoot=UIObject.get(self,34)
self.accelerateTx=UIText.get(self,35)
self.zhenfaIcon=UIImage.get(self,36)

self.zhenfaBtn:setButtonClick(function()self:onZhenfaBtn()end)

self.exTipsBtn1:setButtonClick(function()self:onExTipsBtn1()end)

self.exTipsBtn2:setButtonClick(function()self:onExTipsBtn2()end)

self.accelerateBtn:setButtonClick(function()self:onAccelerateBtn()end)



end


function UIZhenFaStudyWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.zhenfa);self.zhenfa=nil;
_UIObject_release(self.dzEmpty);self.dzEmpty=nil;
_UIObject_release(self.flyIcon);self.flyIcon=nil;
_UIObject_release(self.zhenfaBtn);self.zhenfaBtn=nil;
_UIObject_release(self.imgPause);self.imgPause=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.imgState);self.imgState=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.diziLock);self.diziLock=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.upList);self.upList=nil;
_UIObject_release(self.timeProgress);self.timeProgress=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.clock);self.clock=nil;
_UIObject_release(self.timeProgressTx);self.timeProgressTx=nil;
_UIObject_release(self.timeProgressSp);self.timeProgressSp=nil;
_UIObject_release(self.rewardIcon);self.rewardIcon=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.rewardCount);self.rewardCount=nil;
_UIObject_release(self.tzTips);self.tzTips=nil;
_UIObject_release(self.exTipsBtn1);self.exTipsBtn1=nil;
_UIObject_release(self.exTipsIng1);self.exTipsIng1=nil;
_UIObject_release(self.exTipsBtn2);self.exTipsBtn2=nil;
_UIObject_release(self.exTipsIng2);self.exTipsIng2=nil;
_UIObject_release(self.accelerateCost);self.accelerateCost=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costValue);self.costValue=nil;
_UIObject_release(self.accelerateBtn);self.accelerateBtn=nil;
_UIObject_release(self.accelerateRoot);self.accelerateRoot=nil;
_UIObject_release(self.accelerateTx);self.accelerateTx=nil;
_UIObject_release(self.zhenfaIcon);self.zhenfaIcon=nil;
end
















local _initModel=false
local _this=nil
local upDescCmp={
before=0,
after=1,
tips=2,
}
local _effect=10140


local _check_additional_work={
[SLG_SYSTEM_TYPE.eTianGongGe]={
{
check=function(bdData)
return LZDiaoKeModel:isDKing(bdData.un_build_id)
end,
tips="灵阵雕刻期间不能更换或卸任弟子",
}
},
}


function UIZhenFaStudyWin:onLoaded(...)
self:bindComponents()
_this=self
self.infoShow=false
self:initAccelerateCfg()
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIZhenFaStudyWin:__delete()
self:unbindComponents()

uiAIManager:removeUIInstance(self.currDZ)
uiAIManager:clearUIWinData('UIZhenFaStudyWin')
self.currDZ=nil
_this=nil
_initModel=false
if self.tween then
self.tween:Kill()
self.tween=nil
end
self:stopSpeakTimer()
self:endStudyTick()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end




function UIZhenFaStudyWin:onShow(argtable,afterOnloaded)

if argtable==nil then return end
local entityId=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(entityId)
self.buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.dzId=self.bdData.dizi_id
self.ubdId=self.bdData.un_build_id

self.data=zhenfaModel:getStudyingData(self.ubdId)
self:refreshDzPanel()
self:refreshPanel()
end


function UIZhenFaStudyWin:onHide()

end




function UIZhenFaStudyWin:onExTipsBtn1()
local skill_id=DISCIPLE_PROSKILL_TYPE.eZhenFa
local param={
title={"阵法等级","缩减时间"},
info=cfgHelper.get2(cfg_discipleproskillconfig_get,skill_id,'tiangongge_discount_info'),
level=0,
callback=function()
if _this then
self.exTipsIng1:setActive(false)
end
end,
}
UIManager:showWindow("UIBuildingDiscountInfoTips",param)
self.exTipsIng1:setActive(true)
end

function UIZhenFaStudyWin:onExTipsBtn2()
local skill_id=DISCIPLE_PROSKILL_TYPE.eZhenFa
local param={
title={"阵法等级","缩减时间"},
info=cfgHelper.get2(cfg_discipleproskillconfig_get,skill_id,'tiangongge_discount_info'),
level=UIDiscipleModel:getDiscipleJobLevel(self.dzId,skill_id),
callback=function()
if _this then
self.exTipsIng2:setActive(false)
end
end,
}
UIManager:showWindow("UIBuildingDiscountInfoTips",param)
self.exTipsIng2:setActive(true)
end

function UIZhenFaStudyWin:onAddBtn()
if self.data then
UIManager.error('建筑已在研究中')
return
elseif self.bdData.dizi_id and
(UIDiscipleModel:checkDiscipleState(self.bdData.dizi_id,DISCIPLE_STATE_TYPE.edsDispatch)or
UIDiscipleModel:checkDiscipleState(self.bdData.dizi_id,DISCIPLE_STATE_TYPE.eChuiWei))then
UIManager.error('弟子状态无法研究')
return
end







UIManager:showWindow("UIZhenFaLevelUpWin",{sfId=self.sfId,bdData=self.bdData})
end

function UIZhenFaStudyWin:onClickSelect()
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
elseif self.bdData.plant_id>0 then
UIManager.error('建筑执行生产中, 不能更换弟子')
return
elseif self.data then
UIManager.error('建筑正在研究中, 不能更换弟子')
return
end
local check,tips=self:checkAdditionalWork()
if not check then
UIManager.error(tips)
return
end
end
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eZhenFa,dzSelectEffectType.eZhenFa,2)
end

function UIZhenFaStudyWin:checkAdditionalWork()
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

function UIZhenFaStudyWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.replaceDisciple then
_this.dzId=arg1
_this:refreshDzPanel()
end
end

function UIZhenFaStudyWin.on_item_changed(changeType,itemguid,itemid,lastcount,itemcount)
if _this.data then
for i,v in ipairs(_this.accListern)do
if v[2]==itemid then
_this:refreshAccelerateCost()
end
end
end
end

function UIZhenFaStudyWin.on_money_changed(moneyType,lastVal,val,changeType)
if _this.data then
for i,v in ipairs(_this.accListern)do
if v[2]==moneyType then
_this:refreshAccelerateCost()
end
end
end
end

function UIZhenFaStudyWin:refreshStudying(sfId,ubdId)
if sfId==self.sfId and ubdId==self.ubdId then
self.data=zhenfaModel:getStudyingData(self.ubdId)
self:refreshPanel()
end
end

function UIZhenFaStudyWin:refreshState(sfId,ubdId)
if sfId==self.sfId and ubdId==self.ubdId then
self.data=zhenfaModel:getStudyingData(self.ubdId)
self:refreshDzPanel()
self:refreshPanel()
end
end

function UIZhenFaStudyWin:refreshDzState(sfId,ubdId)
if sfId==self.sfId and ubdId==self.ubdId then
self:refreshDzPanel()
end
end


function UIZhenFaStudyWin:refreshDzPanel()
local dzId=self.dzId

local name=''
local haveDz=tostring(dzId)~='0'
local animState=haveDz and 0 or 1

self.diziLock:setActive(not haveDz)
self.diziInfo:setActive(haveDz)

self.btnSelect:setActive(not haveDz)
self.btnSwitch:setActive(haveDz)
if haveDz then

name=UIDiscipleModel:getDiscipleName(dzId)
local bd_tybe_cfg=cfg_monijybuildconfig_get(self.buildConfig.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
self.skill:setText(string.format('%s：%s级',skill_cfg.name,level))
end

self.dizi_speciality=discipleSelectController.getSpeciallistByBuild(dzId,bd_tybe_cfg.build_type)
local haveSpeciality=self.dizi_speciality~=nil and#self.dizi_speciality>0
self.tzTips:setActive(haveSpeciality)
self.scrollView2:setActive(haveSpeciality)
if haveSpeciality then
self.scrollView2:setChildScrollViewInit(0,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)
self.scrollView2:setChildScrollViewCreateGrids(#self.dizi_speciality,0)
local grids=self.scrollView2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.dizi_speciality[i]
UIDiscipleModel.refreshSpecialityItemEx(item,data)
end
end
else
self:stopSpeakTimer()
end

self.dzName:setText(FMT.fmt('执事弟子：<color=#7d3b17>{0}</color>',name))

if not _initModel then
_initModel=true
self:delayDo(1,function(...)
self:refreshDzModel()
end)
else
self:refreshDzModel()
end
end

function UIZhenFaStudyWin:refreshDzModel()
local dzId=self.dzId

uiAIManager:removeUIInstance(self.currDZ)
self.currDZ=nil
if tostring(dzId)~='0'then
self:createDZ(self.bdData.dizi_id,{-360,-226},function(bt)
self.currDZ=bt
end)
end
end

function UIZhenFaStudyWin:createDZ(dzId,pos,callback)

local state=UIDiscipleModel:checkDiscipleState2(self.dzId,DISCIPLE_STATE_TYPE.edsDispatch)
self.imgPause:setActive(state)
self.imgState:setActive(state)
if state then return end
local UIstateId=0



local initData={
speakHUDID=1,
speakTime=5,
speakHUDParent=1,
offset={0,0},
standPos=0,
leftPos={-310,-226},
rightPos={-150,-226},
UIstateId=UIstateId,
shanhuo=0,
firstright=1,
}
local tran=self.dzEmpty:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])




local otherData={
weaponslot='shanzislotname',
}
uiAIManager:createUIDisciple('UIZhenFaStudyWin','bt_ui_ldf',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end


function UIZhenFaStudyWin:createUIDisciple(fname,parent,dzId,pos,scale,data,callback)
_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDisciple,parent,function(id)
local dzWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
dzWidget:SetChildAnchoredPosition(0,pos)

local info=UIDiscipleModel:getDiscipleImageInfo(dzId)
local shanziSlot=cfgHelper.get2(cfg_disciplevocationconfig_get,info.job,'maobislotname')
local shanziId=shanziSlot[1]
local slotName=shanziSlot[2]
local modelParams
if slotName then
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
else
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo2(dzId,shanziId)
end
local dzScale=isometricMapSystem:getModelScale(modelParams.body,true)
dzWidget:SetChildUIModelShowTarget(0,modelParams.body,dzScale*scale,modelParams.componets,eAnimationID.stand)
if slotName and modelParams.hideWeapon==nil then
local outSide=cfgHelper.get2(cfg_discipleweaponimageconfig_get,shanziId,'out_side')
dzWidget:SetChildLoadSlot(0,slotName,outSide)
end

local initData={
dzId=dzId,
stId=id,
dzWidget=dzWidget,
dzIndex=0,
}
if data then
for k,v in pairs(data)do
initData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fname,nil,true,initData)
callback(bt)
end)
end


function UIZhenFaStudyWin:getSpeakText(bt,tkey)
local dzId=self.dzId
local txt=''
if tostring(dzId)~='0'then









end
bt:setSharedVar(tkey,txt)
end


function UIZhenFaStudyWin:getShanHuoSpeakText(bt,tkey)
local dzId=self.dzId
local txt=''
if tostring(dzId)~='0'then
local voc=UIDiscipleModel:getDiscipleJob(dzId)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'liandanfang')
local shanhuoSpeak=speakList[2]
local speakStr=shanhuoSpeak[math.random(1,#shanhuoSpeak)]or''
txt=speakStr
end
bt:setSharedVar(tkey,txt)

AudioManager.playAudio(448)
end

function UIZhenFaStudyWin:stopSpeakTimer()
if self.delayShowTimer then
self:stopTimerByID(self.delayShowTimer)
self.delayShowTimer=nil
end
if self.delayHideTimer then
self:stopTimerByID(self.delayHideTimer)
self.delayHideTimer=nil
end
end

function UIZhenFaStudyWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView2:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.dzId,config=data})
end


function UIZhenFaStudyWin:refreshPanel()
self.accelerateRoot:setActive(self.data~=nil)
if self.data then
self:refreshInfoPanel()

self:refreshAccelerate()
self.zhenfa:setChildShowEffect(_effect,true)
local cfg=cfgHelper.get1(cfg_zhenfaconfig_get,self.data.zfId)
self.zhenfaIcon:setImageIcon(cfg.icon,true)

else
self.zhenfaIcon:setImageIcon("",true)
self:endStudyTick()
self.infoShow=false
self.zhenfa:setChildShowEffect(_effect,false)

self:showInfoPanel()
end
end

function UIZhenFaStudyWin:refreshAccelerate()
if not self.data.running then
self:stopStudyTick()
else
self:startStudyTick()
end
end

function UIZhenFaStudyWin:refreshAccelerateCost(leastTime)
leastTime=leastTime or zhenfaModel.calculateLeastTime(self.data)
for i,v in ipairs(self.accListern)do
local mode=v[1]
local itemId=v[2]
local itemNum=v[3]
local accTime=v[4]
if mode==speedUpMode.eItem then
local haveNum=bagModel.getItemCountById(itemId)
if haveNum>=itemNum then
self.costIcon:setChildIcon(iconHelper.getIconName(itemId),false)
self.costValue:setText(haveNum)
self.accelerateTx:setText(FMT.fmt("加速{0}",timeHelper.format_time_stamp11(accTime)))
return
end
elseif mode==speedUpMode.eMoney then
itemNum=itemNum*math.ceil(leastTime/accTime)
if moneyModel.checkEnoughMoney(itemId,itemNum)then
self.costIcon:setChildIcon(iconHelper.getIconName(itemId),false)
self.costValue:setText(itemNum)
self.accelerateTx:setText("立即完成")
return
end
end
end

local v=self.accListern[#self.accListern]
local itemId=v[2]
local itemNum=v[3]
local accTime=v[4]
itemNum=itemNum*math.ceil(leastTime/accTime)
self.costIcon:setChildIcon(iconHelper.getIconName(itemId),false)
self.costValue:setText(FMT.fmt('<color=red>{0}</color>',itemNum))
self.accelerateTx:setText("立即完成")
end

function UIZhenFaStudyWin:refreshInfoPanel()

local zfId=self.data.zfId
local running=self.data.running
local cfg=cfgHelper.get1(cfg_zhenfaconfig_get,zfId)
local level=zhenfaModel:getZhenFaData(zfId)
local levelInfo=cfg.level[level]
local upDesc=cfg.updesc[level]

local onCreate=function(index)
local info=index>1 and upDesc[index-1]or{"等级: ",level,level+1}
local item=self.upList:getChildLayoutGroupGridItem(index-1)
item:SetChildText(upDescCmp.tips,FMT.fmt("{0}{1}",FMT.cfmt(FONT_COLOR.eOrangeDescColor,info[1]),info[2]))
item:SetChildText(upDescCmp.before,"")
item:SetChildText(upDescCmp.after,info[3])
end

self.upList:setChildLayoutGroupCreateItems(#upDesc+1,onCreate)

self.nameTx:setText(FMT.fmt("{0}（{1}级）",cfg.name,level))
self.descTx:setText(cfg.desc[level])


self:showInfoPanel()
end

function UIZhenFaStudyWin:refreshStudyCD(first)
if self.data then
local leastTime=zhenfaModel.calculateLeastTime(self.data)
local passTime=self.data.duration-leastTime
local progresPrecent=self.data.duration-leastTime
if first then
self.timeProgress:setProgressValue(passTime,self.data.duration)
else
self.timeProgress:setProgress(passTime,self.data.duration)
end
self.timeProgress:setChildProgressText(timeHelper.format_time_stamp2(leastTime))

if first or(leastTime%60==0)then
self:refreshAccelerateCost(leastTime)
end

return leastTime<0
else
return true
end
end

function UIZhenFaStudyWin:startStudyTick()
self:endStudyTick()
self:refreshStudyCD(true)
self.studyTick=self:setTimer(1,-1,function()
local finish=self:refreshStudyCD(false)
if finish then
self:endStudyTick()
end
end)
end

function UIZhenFaStudyWin:endStudyTick()
if self.studyTick then
self:stopTimerByID(self.studyTick)
self.studyTick=nil
end
end

function UIZhenFaStudyWin:stopStudyTick()
self:endStudyTick()
self.timeProgress:setProgressValue(100,100)
self.timeProgress:setChildProgressText("研究暂停")
end

function UIZhenFaStudyWin:initAccelerateCfg()
local accCfg=cfgHelper.get3(cfg_monijybasicconfig_get,1,"reduce_allow",speedUpType.eZhenFaStudy)
self.accPermission={}
for i,v in pairs(accCfg)do
table.insert(self.accPermission,i)
end
table.sort(self.accPermission)
self.accListern={}
for i=#self.accPermission,1,-1 do
local mode=self.accPermission[i]
if mode==speedUpMode.eItem then
local costCfg=cfgHelper.get3(cfg_monijybasicconfig_get,1,"reduce_times",2)
for itemId,itemCfg in pairs(costCfg)do
table.insert(self.accListern,{mode,itemId,itemCfg[1],itemCfg[2],itemCfg[3]})
end
elseif mode==speedUpMode.eMoney then
local costCfg=cfgHelper.get3(cfg_monijybasicconfig_get,1,"reduce_times",1)
table.insert(self.accListern,{mode,costCfg[1],costCfg[2],costCfg[3]})
end
end
end

function UIZhenFaStudyWin:onAccelerateBtn()
local leastTime=zhenfaModel.calculateLeastTime(self.data)
if leastTime<=0 then
return
end

for i,v in ipairs(self.accListern)do
local mode=v[1]
if mode==speedUpMode.eItem then
local costId=v[2]
local costNum=v[3]
local accTime=v[4]
local patchTime=v[5]
local haveNum=bagModel.getItemCountById(costId)
if haveNum>=costNum then
if leastTime>patchTime and haveNum>=(2*costNum)then
local desc='消耗<color=#7d3b17>{0}</color>张{2}\n加速<color=#7d3b17>{1}</color>'
local max=math.min(haveNum,math.ceil(leastTime/accTime))
local args={
currVal=max,
minVal=1,
maxVal=max,
itemData={costId,haveNum},
descFunc=function(val)
return FMT.fmt(desc,val,timeHelper.format_time_stamp11(accTime*val),itemsConfig.getItemName(costId))
end,
applyFunc=function(val)
if val>0 then
zongmenControl:reqSpeedup(mode,costNum*val,costId,speedUpType.eZhenFaStudy,self.sfId,self.ubdId)
end
end
}
UIManager:showWindow('UIBatchUseWin',args)
else
zongmenControl:reqSpeedup(mode,costNum,costId,speedUpType.eZhenFaStudy,self.sfId,self.ubdId)
end
return
end
elseif mode==speedUpMode.eMoney then
local costId=v[2]
local costNum=v[3]
local time=v[4]
local costNum=costNum*math.ceil(leastTime/time)
if moneyModel.checkEnoughMoney(costId,costNum)then
zongmenControl:reqSpeedup(mode,costNum,costId,speedUpType.eZhenFaStudy,self.sfId,self.ubdId)
return
end
end
end

local v=self.accListern[#self.accListern]
if v[1]==speedUpMode.eMoney then
UIManager.error('货币不足, 不能加速')
elseif v[1]==speedUpMode.eItem then
UIManager.error('道具不足, 不能加速')
end
gainControl:showGainWin(v[2])
end

function UIZhenFaStudyWin:onIconBtn()
self.infoShow=not self.infoShow

self:showInfoPanel()
end

function UIZhenFaStudyWin:onZhenfaBtn()
if self.data then
self:onIconBtn()
else
self:onAddBtn()
end
end

function UIZhenFaStudyWin:showInfoPanel()
self.infoPanel:setActive(self.infoShow)
if self.infoShow then
if self.tween then
self.tween:Kill()
end
local cId=self.infoPanel:getID()
local x=290
self.winlua:SetChildSizeDelta(cId,x,154)
self.tween=self.winlua:SetChildDOSizeDelta(cId,Vector2.New(x,485),0.25,function()
self.tween=nil
end)
end
end
