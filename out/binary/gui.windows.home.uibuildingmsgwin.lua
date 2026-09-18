







def_class("UIBuildingMsgWin",UIWindowBase)









function UIBuildingMsgWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.msgItemSpe=UIObject.get(self,1)



end


function UIBuildingMsgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.msgItemSpe);self.msgItemSpe=nil;
end
















local _this
local _speItem_ChangeInterval=30






local _abName='ui/windows/main/main_sprite_atlas_pak.ab'
local _speItem={
[1]={
sort=3,

icon="icon_fangke",
desc="访客来访",
click=function()







zongmenVisitorController:moveCameraToVisitorEntity()
end,
check=function()
local name=playerModel:getActorName()
local playId=playerModel:getActorID()
local visitorData=zongmenVisitorModel:getVisitor(playId)
if visitorData and visitorData.id>0 then
local award=zongmenVisitorModel:checkAwarded(playId,name)
local num=zongmenVisitorModel:checkNum()
return num and not award
end
return false
end,
},
[2]={
sort=1,

icon="icon_weizhifangke",
desc="云游老道",
click=function()
yunyouMerchantController:moveCameraToVisitorEntity()
end,
check=function()
local data=yunyouMerchantModel:getData()
if data and not data.buyFlag then
return true
end
return false
end,
},
[3]={
sort=4,

icon="icon_jzxzxingeren_1",
desc="仙栈访客",
click=function()
xianzhanController:enterXianZhanMap(nil,function()
xianzhanController:moveCameraToYB()
end)
end,
check=function()
return xianzhanModel:hasYingBinRoom()
end,
},
[4]={
sort=0,

icon="icon_xiangongpingding_1",
desc="仙宫评定",
click=function()
xiangongpingdingController:moveCameraToEntity()
end,
check=function()
return xiangongpingdingModel:isPingDingChanged()
end,
},
[5]={
sort=2,

icon="icon_xiangongpingding_1",
desc="行脚商人",
click=function()
xingjiaoMerchantController:moveCameraToVisitorEntity()
end,
check=function()
return xingjiaoMerchantModel:hasData()
end,
},
[6]={
sort=1,

icon="icon_danling",
desc="应劫丹灵",
click=function()
local dlId=jctjDuJieXianDanModel:hasEntity()
UIManager:showWindow("UIDuJieDanLingWin",dlId)
end,
check=function()
return jctjDuJieXianDanModel:hasEntity()
end,
},
[7]={
sort=1,

icon="icon_dujiexiandan_1",
desc="丹药完成",
click=function()
UIFullLianDanFangControl:showDuJieXianDan()
end,
check=function()
return jctjDuJieXianDanController:checkReddot()
end,
},
[8]={
sort=-1,

icon="icon_caishenjiadao_1",
desc="财神驾到",
click=function()
local subList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCaiShenJiaDao)or{}
local list={}
for index,info in ipairs(subList)do
if info:checkEntityTime()and info:checkBuyCount()then
table.insert(list,info)
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.start_time<b.start_time
end)
end
if#list>0 then
UIManager:showWindow("UICaiShenJiaDaoRedPacketShareWin",{info=list[1]})
end
end,
check=function()
local subList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCaiShenJiaDao)or{}
for index,info in ipairs(subList)do
if info:checkEntityTime()and info:checkBuyCount()then
return true
end
end
return false
end,
},
[9]={
sort=2,

icon="icon_weizhifangke",
desc="云游仙商",
click=function()
local subList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eXingJiaoShangRen)or{}
local list={}
for index,info in ipairs(subList)do
if not info:checkFinish()then
table.insert(list,info)
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.start_time<b.start_time
end)
end
if#list>0 then
UIManager:showWindow("UIXingJiaoShangRenExchangeWin",{info=list[1]})
end
end,
check=function()
local subList=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eXingJiaoShangRen)or{}
for index,info in ipairs(subList)do
if not info:checkFinish()then
return true
end
end
return false
end,
},
}



function UIBuildingMsgWin:onLoaded(...)
self:bindComponents()

_this=self


local hudAB='ui/windows/hud/hud_sprite_atlas_pak.ab'
local globalAB='ui/sharedtextures/uiglobalspriteatlas_1.ab'
self.icons={
[zmMsgType.unlinkRoad]={hudAB,'icon_jzdaolulianjie'},
[zmMsgType.chuiwei]={hudAB,'icon_linghun_1'},
[zmMsgType.homeless]={hudAB,'icon_jzdongfu'},
[zmMsgType.xianZhanRepair]={hudAB,'icon_jzdongfu'},
[zmMsgType.areaUnlock]={hudAB,'icon_quyu'},
[zmMsgType.shanmenVisit]={globalAB,'icon_jzxzxingeren_1'},
[zmMsgType.xianZhanKeShang]={globalAB,'icon_jzxzxingeren_1'},
[zmMsgType.zmRelationPlot]={globalAB,'icon_jzxzxingeren_1'},
[zmMsgType.areaUnlockWaitEnd]={hudAB,'icon_quyu'},

}

self.msgTypeRecord={}
self.msgTypeList={}
self.descs={
[zmMsgType.unlinkRoad]='未连接道路',
[zmMsgType.chuiwei]='救治弟子',
[zmMsgType.homeless]='弟子无居所',
[zmMsgType.xianZhanRepair]='仙栈可修复',
[zmMsgType.areaUnlock]='解锁新区域',
[zmMsgType.shanmenVisit]='有人拜山',
[zmMsgType.xianZhanKeShang]='仙栈客商到访',
[zmMsgType.zmRelationPlot]='宗门访客',
[zmMsgType.areaUnlockWaitEnd]='区域探索完成',

}

self.sortVals={
[zmMsgType.unlinkRoad]=1,
[zmMsgType.chuiwei]=3,
[zmMsgType.homeless]=2,
[zmMsgType.xianZhanRepair]=4,
[zmMsgType.areaUnlock]=5,
[zmMsgType.shanmenVisit]=6,
[zmMsgType.xianZhanKeShang]=7,
[zmMsgType.zmRelationPlot]=8,
[zmMsgType.areaUnlockWaitEnd]=9,

}

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_click,nil)

self.slen=0

self.active_level=cfgHelper.get2(cfg_monijybasicconfig_get,1,'zm_tips_level')

notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
self:addNotify(notifyConfig.onZongMenAreaUnLock,self.on_area_unlock)
self:addNotify(notifyConfig.onZongMenAreaWaitUnLock,self.on_area_unlock)
self:addNotify(notifyConfig.onShanMenVisitChange,self.onShanMenVisitChange)
self:addNotify(notifyConfig.onCSJDPlayerDataChange,self.onCSJDPlayerDataChange)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
self:addProNotify(247,61,self.onXingJiaoShangRenDataChange)
self:addProNotify(247,62,self.onXingJiaoShangRenDataChange)
self:setTimer(1,-1,function()
self:updateMsg()
end)

self.speMsgList={}
end

function UIBuildingMsgWin:updateMsg()
self:showMsg(zmMsgType.xianZhanRepair,self:checkXianZhan())
end

function UIBuildingMsgWin:checkAndShow()
self:addMsg(zmMsgType.unlinkRoad,isometricMapSystem:hasUnlinkRoad())
self:addMsg(zmMsgType.chuiwei,self:checkChuiwei())
self:addMsg(zmMsgType.homeless,zongmenModel:hasHomeless())
self:addMsg(zmMsgType.xianZhanRepair,self:checkXianZhan())
self:addMsg(zmMsgType.areaUnlock,self:checkAreaUnlock())
self:addMsg(zmMsgType.shanmenVisit,self:checkShanmenVisit())
self:addMsg(zmMsgType.xianZhanKeShang,self:checkXianZhanKeShang())
self:addMsg(zmMsgType.zmRelationPlot,self:checkZmRelationPlot())
self:addMsg(zmMsgType.areaUnlockWaitEnd,self:checkAreaUnlockWaitEnd())

self:showNext()
end

function UIBuildingMsgWin:checkXianZhan()
local mode=1
local data=isometricMapSystem:getRepairDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
if not data then
data=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
mode=2
else
if not isometricMapSystem:isInUnlockArea(data.guid)then
return false
end
end
if not data or(data.flag and data.flag<10)then
return false
end
local rlevel=1
local id
if mode==2 then
if data.flag>20 then
rlevel=data.flag-19
else
rlevel=data.flag-10
return false
end
id=data.build_id
else
id=data.id
end

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local costs=cfg.repair_cost[rlevel]

for i,v in ipairs(costs)do
local nid=v[1]
local need=v[2]
if moneyConfig.isMoney(nid)then
local have=moneyModel.getMoney(nid)
if have<need then
return false
end
else
local have=bagModel.getItemCountById(nid)
if have<need then
return false
end
end
end

return true
end


function UIBuildingMsgWin:checkAreaUnlock()
local level=zongmenModel:getLevel()
local cfg=cfg_monijyareaconfig()
local checkUnlockAreaId_Start=self.nextUnlockAreaId or 1
for index=checkUnlockAreaId_Start,#cfg do
local areaCfg=cfg[index]
local areaId=areaCfg.id
if areaCfg.sf_id==mapIdType.zhufeng and not zongmenModel:isAreaUnlock(areaId)then

if isometricMapSystem:isNewMapArea(areaId)and not isometricMapSystem:isCanShowNewArea()then
return false
end


local areaData=zongmenModel:getAreaData(mapIdType.zhufeng,areaId)
if areaData and areaCfg.unlock_wait>0 and areaData.begintime>0 then
return false
end

local pass=true
for i,v in ipairs(areaCfg.unlock_condition)do
if v.type==1 then
if level<v.param then
pass=false
end
elseif v.type==2 then
if not taskModel:checkTaskFinish(v.param)then
pass=false
end
elseif v.type==3 then
if not zongmenModel:isAreaUnlock(v.param)then
pass=false
end
elseif v.type==4 then
if not zongmenModel:isCompleteBuildQiYu(v.param)then
pass=false
end
end

if not pass then
break
end
end

self.nextUnlockAreaId=areaId
return pass
end
end

return false
end


function UIBuildingMsgWin:checkAreaUnlockWaitEnd()
local cfg=cfg_monijyareaconfig()
local checkUnlockAreaId_Start=self.nextUnlockAreaId or 1
for index=checkUnlockAreaId_Start,#cfg do
local areaCfg=cfg[index]
local areaId=areaCfg.id
if areaCfg.sf_id==mapIdType.zhufeng and not zongmenModel:isAreaUnlock(areaId)then

if isometricMapSystem:isNewMapArea(areaId)and not isometricMapSystem:isCanShowNewArea()then
return false
end

local pass=false

local areaData=zongmenModel:getAreaData(mapIdType.zhufeng,areaId)
if areaData and areaCfg.unlock_wait>0 and areaData.begintime>0 then
local curTime=gameUtilityModel.getServerShortTime()
if areaData.begintime+areaCfg.unlock_wait<=curTime then
pass=true
self.nextUnlockAreaId=areaId
end
end

return pass
end
end

return false
end


function UIBuildingMsgWin:checkShanmenVisit()





return shanmenModel:isFullBaiShanDZ()
end


function UIBuildingMsgWin:checkXianZhanKeShang()
if xianzhanModel:checkHasNewKeShang()then
return true
end

return false
end


function UIBuildingMsgWin:checkZmRelationPlot()
if systemZongmenRelationController:checkShowMsg()then
return true
end

return false
end


function UIBuildingMsgWin:__delete()
self:stopMsgSpeTick()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function UIBuildingMsgWin.on_building_event(etype,arg1,arg2,arg3,arg4)
if etype==buildingEvent.switchRoomDizi then
_this:showMsg(zmMsgType.homeless,zongmenModel:hasHomeless())
elseif etype==buildingEvent.zongmenLevelUp then
if arg3<_this.active_level and arg1>=_this.active_level then
_this:checkAndShow()
end
end
end

function UIBuildingMsgWin.onDiscipleStateChange(discipleguid,stateType,old,cur)
if stateType==DISCIPLE_STATE_TYPE.eChuiWei then
_this:showMsg(zmMsgType.chuiwei,_this:checkChuiwei())
end
end

function UIBuildingMsgWin.on_area_unlock(sfId,areaId)
if areaId==_this.nextUnlockAreaId then
_this:checkAndShow()
end
end
function UIBuildingMsgWin.onShanMenVisitChange(shanmenType)
_this:checkAndShow()
end

function UIBuildingMsgWin.onCSJDPlayerDataChange(actId,subType,subId,hbId)
_this:checkMsgSpeShow(8)
end

function UIBuildingMsgWin.onSubActivityStateChange(actId,subType,subId,state)
if subType==SUB_ACTIVITY_TYPE.eXingJiaoShangRen then
_this:checkMsgSpeShow(9)
end
end

function UIBuildingMsgWin.onXingJiaoShangRenDataChange()
_this:checkMsgSpeShow(9)
end

function UIBuildingMsgWin:checkChuiwei()
local datas=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(datas)do
local dzId=v.netData.net.discipleguid
local state=UIDiscipleModel:getDiscipleState(dzId)
if state==DISCIPLE_STATE_TYPE.eChuiWei then
return true,dzId
end
end
return false
end

function UIBuildingMsgWin.on_item_click(clicknum,index)
local mtype=_this.msgTypeList[index+1]
if mtype==zmMsgType.unlinkRoad then
_this:onUnlinkPanel()
elseif mtype==zmMsgType.chuiwei then
_this:onDzChuiweiClick()
elseif mtype==zmMsgType.homeless then
_this:onHomelessClick()
elseif mtype==zmMsgType.xianZhanRepair then
_this:onXianZhanClick()
elseif mtype==zmMsgType.areaUnlock then
_this:onAreaUnlockClick()
elseif mtype==zmMsgType.shanmenVisit then
_this:onShanmenVisitClick()
elseif mtype==zmMsgType.xianZhanKeShang then
_this:onXZKSClick()
elseif mtype==zmMsgType.zmRelationPlot then
_this:onZmRelationPlotClick()
elseif mtype==zmMsgType.areaUnlockWaitEnd then
_this:onAreaUnlockClick()


end
end

function UIBuildingMsgWin:onXianZhanClick()
local guid
local data=isometricMapSystem:getRepairDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
if not data then
data=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
if data then
guid=data.entityId
end
else
guid=data.guid
end
if guid then
isometricMapSystem:moveCameraToObjectEx(guid,true,nil,0.5)
end
end

function UIBuildingMsgWin:onDzChuiweiClick()
local flag,guid=self:checkChuiwei()
local ret=false
if guid~=nil then
ret=UIDiscipleController.doTriggerSomething(dzTriggerDoSomething.eChuiWei,{guid})
end
if not ret then
UIFullDiscipleBatchTreatControl.showBatchZhiliaoWin(true)
end
end

function UIBuildingMsgWin:onHomelessClick()
local sfId=zongmenModel:getMountainId()
if sfId~=mapIdType.zhufeng then
mountainControl:loadAndswitchMapEx(mapIdType.zhufeng,true,function()
isometricMapSystem:enterLayoutModel({model=layoutMode.eBuild,sortType=BUILD_TAB_TYPE.eFunction})
end)
else
isometricMapSystem:enterLayoutModel({model=layoutMode.eBuild,sortType=BUILD_TAB_TYPE.eFunction})
end
end

function UIBuildingMsgWin:onAreaUnlockClick()
local sfId=zongmenModel:getMountainId()

if not self.nextUnlockAreaId then
logErr("当前未记录下一个解锁区域id 请检查前端代码中弹出提示逻辑是否正确")
return
end

local areaCfg=cfgHelper.get1(cfg_monijyareaconfig_get,self.nextUnlockAreaId)
local weakGuideId=areaCfg.weakGuide
if not weakGuideId then
logErr(FMT.fmt("找不到区域id为{0} 所对应的跳转弱指引id 请检查配置是否正确",areaCfg.id))
return
end
if sfId~=mapIdType.zhufeng then
mountainControl:loadAndswitchMapEx(mapIdType.zhufeng,true,function()
weakGuideController:beginGuide(weakGuideId)
end)
else
weakGuideController:beginGuide(weakGuideId)
end
end

function UIBuildingMsgWin:onShanmenVisitClick()






local shanmenType=SHANMEN_TYPE.eBaiShan
shanmenController:playSMAnim(shanmenType)
UIManager.info("有客前来拜访，请点击查看")
end

function UIBuildingMsgWin:onXZKSClick()
local guid
local data=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXianZhan)
if data then
guid=data.entityId
end
if guid then
isometricMapSystem:moveCameraToObjectEx(guid,true,nil,0.5)
end
end

function UIBuildingMsgWin:onZmRelationPlotClick()
systemZongmenRelationController:moveSelectEnt()
end




function UIBuildingMsgWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local msgType=argtable.msgType
local msgSpe=argtable.msgSpe
local showSpe=argtable.showSpe
if msgType then
self:addMsg(msgType,true)
else
self:checkAndShow()
end

if msgSpe then
if _speItem[msgSpe]and _speItem[msgSpe].check()then
self:showMsgSpe(msgSpe,true)
end
else
if showSpe==nil then showSpe=true end
if showSpe then
self:checkMsgSpe()
end
end
self:setAsLastSibling(-1)
end


function UIBuildingMsgWin:onHide()

end

function UIBuildingMsgWin:sortTypeList()
table.sort(self.msgTypeList,function(a,b)
local v1=self.sortVals[a]
local v2=self.sortVals[b]
return v1<v2
end)
end

function UIBuildingMsgWin:showMsg(msgType,bShow)
self:addMsg(msgType,bShow)
self:showNext()
end

function UIBuildingMsgWin:onClickSpeMsg()
local cType=self.forceMsgSpeType or self.speMsgList[self.speMsgShow or 1]
local cData=_speItem[cType]
cData.click()
end

function UIBuildingMsgWin:forceMsgSpe(iType)
self.forceMsgSpeType=iType
local widget=self.msgItemSpe:getChildWidgetBase()
local data=_speItem[iType]
self.msgItemSpe:setActive(true)
widget:SetChildText(1,data.desc)
widget:SetChildCSImageSprite(2,_abName,data.icon)
widget:SetChildButtonClick(3,function()
self:onClickSpeMsg()
end)
widget:SetChildShowEffect(4,10324,not webGLHelper:isHidePunchAni())
widget:SetChildActive(6,webGLHelper:isHidePunchAni())
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
self:stopMsgSpeTick()
end

function UIBuildingMsgWin:unforceMsgSpe()
self.forceMsgSpeType=nil
local iType=self.speMsgList[1]
if iType then
local widget=self.msgItemSpe:getChildWidgetBase()
local data=_speItem[iType]
self.msgItemSpe:setActive(true)
widget:SetChildText(1,data.desc)
widget:SetChildCSImageSprite(2,_abName,data.icon)
widget:SetChildButtonClick(3,function()
self:onClickSpeMsg()
end)
widget:SetChildShowEffect(4,10324,not webGLHelper:isHidePunchAni())
widget:SetChildActive(6,webGLHelper:isHidePunchAni())
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
if#self.speMsgList>1 then
self:startMsgSpeTick()
end
else
local widget=self.msgItemSpe:getChildWidgetBase()
widget:SetChildShowEffect(4,0,false)
widget:SetChildActive(6,false)
self.msgItemSpe:setActive(false)
self:stopMsgSpeTick()
end
end

function UIBuildingMsgWin:showMsgSpe(iType,iShow)

if iShow then
if not table.containsValue(self.speMsgList,iType)then
local widget=self.msgItemSpe:getChildWidgetBase()
local data=_speItem[iType]
if data then
local oType=self.speMsgList[1]
table.insert(self.speMsgList,iType)
table.sort(self.speMsgList,function(a,b)
return _speItem[a].sort<_speItem[b].sort
end)
if oType~=self.speMsgList[1]and not self.isForceMsgSpe then
self.msgItemSpe:setActive(true)
widget:SetChildText(1,data.desc)
widget:SetChildCSImageSprite(2,_abName,data.icon)
widget:SetChildButtonClick(3,function()
self:onClickSpeMsg()
end)
widget:SetChildShowEffect(4,10324,not webGLHelper:isHidePunchAni())
widget:SetChildActive(6,webGLHelper:isHidePunchAni())
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
end
if#self.speMsgList>1 then
self:startMsgSpeTick()
end
end
end
else
local index=table.findValue(self.speMsgList,iType)
if index then
table.remove(self.speMsgList,index)
if index==1 and not self.isForceMsgSpe then
local type=self.speMsgList[1]
local data=_speItem[type]
local widget=self.msgItemSpe:getChildWidgetBase()
if#self.speMsgList>0 then
self.msgItemSpe:setActive(true)
widget:SetChildText(1,data.desc)
widget:SetChildCSImageSprite(2,_abName,data.icon)
widget:SetChildButtonClick(3,function()
data.click()
end)
widget:SetChildShowEffect(4,10324,not webGLHelper:isHidePunchAni())
widget:SetChildActive(6,webGLHelper:isHidePunchAni())
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
else
local widget=self.msgItemSpe:getChildWidgetBase()
widget:SetChildShowEffect(4,0,false)
widget:SetChildActive(6,false)
self.msgItemSpe:setActive(false)
end
end
if#self.speMsgList<=1 then
self:stopMsgSpeTick()
end
end
end
end

function UIBuildingMsgWin:checkMsgSpe()
for i,v in ipairs(_speItem)do
local check=v.check()

if check then
self:showMsgSpe(i,true)
end
end
end

function UIBuildingMsgWin:checkMsgSpeShow(index)
local item=_speItem[index]
local check=item.check()
self:showMsgSpe(index,check)
end

function UIBuildingMsgWin:startMsgSpeTick()
if not self.speMsgTick then
self.speMsgTick=self:setTimer(_speItem_ChangeInterval,0,function()
self:onMsgSpeTick()
end)
self.speMsgShow=1
end
end

function UIBuildingMsgWin:stopMsgSpeTick()
if self.speMsgTick then
self:stopTimerByID(self.speMsgTick)
self.speMsgTick=nil
self.speMsgShow=nil
end
end

function UIBuildingMsgWin:onMsgSpeTick()
self.speMsgShow=self.speMsgShow+1
local count=#self.speMsgList
if self.speMsgShow>count then
self.speMsgShow=1
end
local iType=self.speMsgList[self.speMsgShow]
local data=_speItem[iType]
local widget=self.msgItemSpe:getChildWidgetBase()
self.msgItemSpe:setActive(true)
widget:SetChildText(1,data.desc)
widget:SetChildCSImageSprite(2,_abName,data.icon)
widget:SetChildButtonClick(3,function()
data.click()
end)
widget:SetChildShowEffect(4,10324,not webGLHelper:isHidePunchAni())
widget:SetChildActive(6,webGLHelper:isHidePunchAni())
widget:SetChildCanvasGroupAlpha(0,1)
widget:SetChildCanvasGroupAlpha(5,0)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
end

function UIBuildingMsgWin:addMsg(msgType,bShow)
local level=zongmenModel:getLevel()
if level<self.active_level then
return
end

local rc=self.msgTypeRecord[msgType]
if bShow then
if not rc then

table.insert(self.msgTypeList,1,msgType)
self:sortTypeList()
self.msgTypeRecord[msgType]=true

end
else
if rc then
local index
for i,v in ipairs(self.msgTypeList)do
if v==msgType then
index=i-1
table.remove(self.msgTypeList,i)
break
end
end

self.msgTypeRecord[msgType]=nil
end
end
end

function UIBuildingMsgWin:showNext()
if self.isPlaying then
return
end
local firstType=self.msgTypeList[1]
local addIndex
local removeIndex
if self.currType~=firstType then
if firstType then
addIndex=0
end
if self.currType then
removeIndex=firstType and 1 or 0
end
end
if addIndex or removeIndex then
self.isPlaying=true
local func=function()
if _this==nil then return end
_this.isPlaying=false
_this:showNext()
end
if addIndex then
self:addToList(addIndex,function()
if _this==nil then return end
if removeIndex then
self:removeFormList(removeIndex,func)
else
func()
end
end)
self:setMsgItem(addIndex,firstType)
elseif removeIndex then
self:removeFormList(removeIndex,func)
end
end

self.currType=firstType
end

function UIBuildingMsgWin:setMsgItem(index,msgType)
local widget=self.scrollview:getChildScrollViewItemWidget(index)
widget:SetChildText(1,self.descs[msgType])

local abName=self.icons[msgType][1]
local iconName=self.icons[msgType][2]
widget:SetChildCSImageSprite(2,abName,iconName)
end

function UIBuildingMsgWin:removeFormList(index,callback)
local widget=self.scrollview:getChildScrollViewItemWidget(index)
self.slen=self.slen-1
self.scrollview:setChildScrollViewResetContentSize(self.slen,0)

self:delayDo(0.2,function()
self.scrollview:setChildScrollViewChangeItemList(index,-1,false)
widget:SetChildShowEffect(4,0,false)
widget:SetChildActive(6,false)
local tc=self.slen-1
for i=index,tc do
local tweener=self.scrollview:setChildScrollViewMoveItemToIndexPos(i,0.5)
if i==tc and callback then
tweener:OnComplete(callback)
end
end
if tc<=0 then
callback()
end
end)
end

function UIBuildingMsgWin:addToList(index,callback)
self.slen=self.slen+1
self.scrollview:setChildScrollViewResetContentSize(self.slen,0)
self.scrollview:setChildScrollViewChangeItemList(-1,index,false)

self.scrollview:setChildScrollViewMoveItemToIndexPos(index,0)

local widget=self.scrollview:getChildScrollViewItemWidget(index)





widget:SetChildActive(-1,true)
widget:SetChildShowEffect(4,10324,not webGLHelper:isHidePunchAni())
widget:SetChildActive(6,webGLHelper:isHidePunchAni())
widget:SetChildCanvasGroupAlpha(5,0)
self:delayDo(0.2,function()
return widget:SetChildCanvasGroupDOFade(5,1,0.3)
end)
local tc=self.slen-1
for i=index,tc do
local tweener=self.scrollview:setChildScrollViewMoveItemToIndexPos(i,0.5)
if i==index and callback then
tweener:OnComplete(callback)
end
end
end












function UIBuildingMsgWin:onUnlinkPanel()
isometricMapSystem:ShowNextUnlinkEntity()
end






function UIBuildingMsgWin:onCloseClick()


self:closeSelf()
end





