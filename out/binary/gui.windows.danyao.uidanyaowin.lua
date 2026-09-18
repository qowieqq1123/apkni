







def_class("UIDanYaoWin",UIWindowBase)









function UIDanYaoWin:bindComponents()

self.btnSelect=UIObject.get(self,0)
self.btnSelectReddot=UIObject.get(self,1)
self.btnSwitch=UIObject.get(self,2)
self.btnSwitchReddot=UIObject.get(self,3)
self.canGetReddot=UIObject.get(self,4)
self.changeBtn=UIButton.get(self,5)
self.closePanelBtn=UIButton.get(self,6)
self.danFangItem=UIObject.get(self,7)
self.ddCount=UIText.get(self,8)
self.ddCountP=UIText.get(self,9)
self.ddCRoot=UIObject.get(self,10)
self.ddIcon=UIButton.get(self,11)
self.ddInfo=UIObject.get(self,12)
self.ddPanel=UIObject.get(self,13)
self.ddPBG=UIObject.get(self,14)
self.ddScrollView=UIObject.get(self,15)
self.dfItemNameBg=UIObject.get(self,16)
self.dftemName=UIText.get(self,17)
self.diziInfo=UIObject.get(self,18)
self.diziLock=UIText.get(self,19)
self.dzEmpty=UIObject.get(self,20)
self.dzName=UIText.get(self,21)
self.flyIcon=UIImage.get(self,22)
self.help=UIToggleButton.get(self,23)
self.imgPause=UIObject.get(self,24)
self.imgState=UIImage.get(self,25)
self.leftArrow=UIButton.get(self,26)
self.leftArrowImg=UIObject.get(self,27)
self.liandanlu=UIObject.get(self,28)
self.liandanluEffect=UIObject.get(self,29)
self.lianZhiBtn=UIButton.get(self,30)
self.lianzhiComplete=UIObject.get(self,31)
self.lianzhiRunning=UIObject.get(self,32)
self.limitText=UIText.get(self,33)
self.materials=UIObject.get(self,34)
self.materialsItem_1=UIBaseItem.get(self,35)
self.materialsItem_2=UIBaseItem.get(self,36)
self.materialsItem_3=UIBaseItem.get(self,37)
self.materialsItem_4=UIBaseItem.get(self,38)
self.materialsItem_5=UIBaseItem.get(self,39)
self.newImg=UIObject.get(self,40)
self.pauseTimeImg=UIObject.get(self,41)
self.progressValue=UIObject.get(self,42)
self.qipao=UIObject.get(self,43)
self.receiveDDBtn=UIButton.get(self,44)
self.rewardBtn=UIButton.get(self,45)
self.rewardCount=UIText.get(self,46)
self.rewardIcon=UIImage.get(self,47)
self.rightArrow=UIButton.get(self,48)
self.rightArrowImg=UIObject.get(self,49)
self.root=UIObject.get(self,50)
self.scrollView2=UIObject.get(self,51)
self.selectDanFangBtn=UIButton.get(self,52)
self.selectedDangFang=UIObject.get(self,53)
self.skill=UIText.get(self,54)
self.stopDDBtn=UIButton.get(self,55)
self.timeProgressbar=UIObject.get(self,56)
self.timeProgressText=UIText.get(self,57)
self.timeText=UIText.get(self,58)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.closePanelBtn:setButtonClick(function()self:onClosePanelBtn()end)

self.ddIcon:setButtonClick(function()self:onDdIcon()end)

self.leftArrow:setButtonClick(function()self:onLeftArrow()end)

self.lianZhiBtn:setButtonClick(function()self:onLianZhiBtn()end)

self.receiveDDBtn:setButtonClick(function()self:onReceiveDDBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.rightArrow:setButtonClick(function()self:onRightArrow()end)

self.selectDanFangBtn:setButtonClick(function()self:onSelectDanFangBtn()end)

self.stopDDBtn:setButtonClick(function()self:onStopDDBtn()end)
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
self.materialsItem_3,
self.materialsItem_4,
self.materialsItem_5,
}



end


function UIDanYaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnSelectReddot);self.btnSelectReddot=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.btnSwitchReddot);self.btnSwitchReddot=nil;
_UIObject_release(self.canGetReddot);self.canGetReddot=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.closePanelBtn);self.closePanelBtn=nil;
_UIObject_release(self.danFangItem);self.danFangItem=nil;
_UIObject_release(self.ddCount);self.ddCount=nil;
_UIObject_release(self.ddCountP);self.ddCountP=nil;
_UIObject_release(self.ddCRoot);self.ddCRoot=nil;
_UIObject_release(self.ddIcon);self.ddIcon=nil;
_UIObject_release(self.ddInfo);self.ddInfo=nil;
_UIObject_release(self.ddPanel);self.ddPanel=nil;
_UIObject_release(self.ddPBG);self.ddPBG=nil;
_UIObject_release(self.ddScrollView);self.ddScrollView=nil;
_UIObject_release(self.dfItemNameBg);self.dfItemNameBg=nil;
_UIObject_release(self.dftemName);self.dftemName=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.diziLock);self.diziLock=nil;
_UIObject_release(self.dzEmpty);self.dzEmpty=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.flyIcon);self.flyIcon=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.imgPause);self.imgPause=nil;
_UIObject_release(self.imgState);self.imgState=nil;
_UIObject_release(self.leftArrow);self.leftArrow=nil;
_UIObject_release(self.leftArrowImg);self.leftArrowImg=nil;
_UIObject_release(self.liandanlu);self.liandanlu=nil;
_UIObject_release(self.liandanluEffect);self.liandanluEffect=nil;
_UIObject_release(self.lianZhiBtn);self.lianZhiBtn=nil;
_UIObject_release(self.lianzhiComplete);self.lianzhiComplete=nil;
_UIObject_release(self.lianzhiRunning);self.lianzhiRunning=nil;
_UIObject_release(self.limitText);self.limitText=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.materialsItem_3);self.materialsItem_3=nil;
_UIObject_release(self.materialsItem_4);self.materialsItem_4=nil;
_UIObject_release(self.materialsItem_5);self.materialsItem_5=nil;
_UIObject_release(self.newImg);self.newImg=nil;
_UIObject_release(self.pauseTimeImg);self.pauseTimeImg=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.receiveDDBtn);self.receiveDDBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardCount);self.rewardCount=nil;
_UIObject_release(self.rewardIcon);self.rewardIcon=nil;
_UIObject_release(self.rightArrow);self.rightArrow=nil;
_UIObject_release(self.rightArrowImg);self.rightArrowImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.selectDanFangBtn);self.selectDanFangBtn=nil;
_UIObject_release(self.selectedDangFang);self.selectedDangFang=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.stopDDBtn);self.stopDDBtn=nil;
_UIObject_release(self.timeProgressbar);self.timeProgressbar=nil;
_UIObject_release(self.timeProgressText);self.timeProgressText=nil;
_UIObject_release(self.timeText);self.timeText=nil;
self.materialsItem=nil;
end


















local runningType={
notDanFang=1,
haveDanFang=2,
lzZhong=3,
lzComplete=4,
lzPause=5,
}

local _this=nil

local _initModel


local sixAttrType=DISCIPLE_BASE_ATTR_TYPE.eCongHui
local _pathType=DG.Tweening.PathType
local _Ease=DG.Tweening.Ease


function UIDanYaoWin:onLoaded(...)
self:bindComponents()
_this=self

self.ddPBG:setChildUIModelShowTarget(4730,1,nil,eAnimationID.stand)
self.ddInfo:setChildCanvasGroupAlpha(0)
self.ddPanel:setActive(false)
local isSysOpen=UIDanYaoController:isDingDanSystemOpen()
self.ddCRoot:setActive(isSysOpen)
local slevel=cfgHelper.getdef1(cfg_danfangconfig,'showIconLevel')
local bShowIcon=isSysOpen or zongmenModel:getLevel()>=slevel
self.ddIcon:setActive(bShowIcon)
if isSysOpen then
self.ddIcon:setChildNewBieComponentId('UIDanYaoWin.dingDanIcon')
end

self.maxDDNum=cfgHelper.getdef1(cfg_danfangconfig,'queueMaxCnt')

self.help:setToggleChange(function(name,isOn,data)
if isOn then
self:onHelp()
end
end)

local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.root:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)

self.ddScrollView:setChildScrollViewInit(0.5,true,function(...)self:onDingDanSelect(...)end,nil)

notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end

function UIDanYaoWin:onHelp()
self:showWindow('UICommonHelpB',{content='弟子的丹道等级越高，炼制出高品质丹药的概率越大',closeCB=function()
self.help:setToggle(false)
end})
end


function UIDanYaoWin:__delete()
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end
self:clear()
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end

function UIDanYaoWin:clear()
uiAIManager:clearUIWinData('UIDanYaoWin')
self.currDZ=nil
if self.tweener~=nil then
self.tweener:Kill(false)
self.tweener=nil
end
if self.ctimer then
self:stopTimerByID(self.ctimer)
self.ctimer=nil
end
_initModel=nil
roleAudioController:stopRoleSpeak()
self.prizeState=nil


end




function UIDanYaoWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end
self:refresh(argtable)
end

function UIDanYaoWin:refresh(argtable)
local entityId=argtable.entityId
self.entityId=entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(entityId)
self.buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.dzId=self.bdData.dizi_id
self.ubdId=self.bdData.un_build_id
self:initRunningType()
self:refreshDzPanel()
self:refreshPanel()
local lzZhong=self.runningType==runningType.lzZhong
local animationID=lzZhong and eAnimationID.stand or 2057
self.liandanlu:setChildUIModelShowTarget(2040,1,{},animationID)

local ddopen=UIDanYaoController:isDingDanSystemOpen()
if ddopen then
self:setDingDanIcon()
end

if self.isDDPanelOpen then
self:setDingDanList()
else
local check=self:checkANdShowNBDialogue()
if not check and ddopen then
local data=UIDanYaoModel:getBatchData(self.ubdId)
if data and#data.ddList>0 then
self:onDdIcon()
end
end
end

self:checkAndShowArrowBtn()
UIManager:callWindowFunc('UIBottomMaskWin','refreshFrdRoot')
end

function UIDanYaoWin:checkAndShowArrowBtn()
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

function UIDanYaoWin:toNextWin(arrow)
if self.isPlaying then
return
end
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

local bdData=self.otherBDData[index]

local otherubdId=bdData.un_build_id

if jctjDuJieXianDanModel:isInRepairTime(otherubdId)then
local currtime=gameUtilityModel.getServerShortTime()
local endtime=jctjDuJieXianDanModel:getRepairTime(otherubdId)
UIManager.info(FMT.fmt('丹炉被天劫损毁，正在修复中（{0})',timeHelper.format_time_stamp(endtime-currtime,true)))
return
end

local check,least=UIDanYaoModel:checkZhaLu(otherubdId,DANYAO_ZHALU_SEASON.eDiscipleSpecial)
if check then
UIManager.info(FMT.fmt('丹炉已损毁，正在修复中（{0})',timeHelper.format_time_stamp(least,true)))
return
end

self.leftArrow:setActive(false)
self.rightArrow:setActive(false)

self:clear()
local args={entityId=bdData.entityId}
fullScreenUI.activeUI:setAttach(args)
self:refresh(bdData)
end


function UIDanYaoWin:onHide()

end

function UIDanYaoWin:initRunningType()
local data=UIDanYaoModel:get_danYaodata(self.ubdId)
local dfId=data.dfId
local cnt=data.cnt
local serTime=timeHelper.getServerShortTime()
self.selectCnt=cnt
self.runningType=runningType.notDanFang
if dfId~=0 then
local danFangCfg=cfgHelper.get1(cfg_danfangconfig_get,dfId)
local need=UIDanYaoModel:getDanFangNeedTime(dfId,self.dzId)
local needTime=need*cnt
local beginTime=data.beginTime
if cnt>0 then
if data.isPause then
self.runningType=runningType.lzPause
elseif serTime>=beginTime+needTime then
self.runningType=runningType.lzComplete
else
self.runningType=runningType.lzZhong
end
end
self.danFangCfg=danFangCfg
end
if tostring(self.dzId)=='0'then
self.runningType=runningType.notDanFang
end
end

function UIDanYaoWin:showDanFangWin(dfId,selectCnt)
UIFullLianDanFangControl:showWindow('UIDanFangWin',{entityId=self.entityId,danFangId=dfId,selectCnt=selectCnt,dzId=self.dzId})
end





function UIDanYaoWin:onSelectDanFangBtn()
if tostring(self.dzId)=='0'then
zongmenControl:showSelectManagerWin(self.sfId,self.bdData)
return
end
local isZL,zlTime,zlType=UIDanYaoModel:get_zhalu_time(self.ubdId)
if isZL then
if zlType==DANYAO_ZHALU_SEASON.eDiscipleSpecial then
UIManager.error(FMT.fmt('丹炉已损毁，正在修复中（{0})',timeHelper.format_time_stamp(zlTime,true)))
else
UIManager.error(FMT.fmt('炼丹炉炸了，{0}后再来炼制',timeHelper.format_time_stamp4(zlTime)))
end
return
end
local state=UIDiscipleModel:getDiscipleState(self.dzId)
local isPause=UIDanYaoModel:checkIsPause(self.ubdId)or state==DISCIPLE_STATE_TYPE.edsDispatch
if isPause then
UIManager.error('弟子已外出，无法炼丹')
return
end
if state==DISCIPLE_STATE_TYPE.eChuiWei then
UIManager.error('弟子垂危，无法炼丹')
return
end

if UIDiscipleModel:checkDiscipleState2(self.dzId,DISCIPLE_STATE_TYPE.eDuJieXianDan)then
UIManager.error("弟子正在炼制渡劫仙丹")
return
end

self:showDanFangWin()
end


function UIDanYaoWin:onChangeBtn()
















end


function UIDanYaoWin:onLianZhiBtn()
local danFangCfg=cfgHelper.get1(cfg_danfangconfig_get,self.selectDanFang)
local selectCnt=self.selectCount or 1

if tostring(self.dzId)=='0'then
UIManager.info('未安排弟子')
return
end

if not UIDiscipleModel:checkDZStateToDoSomething(self.dzId,eCheckDiscipleStateOpType.eLianDan,true)then
return
end

if UIDiscipleModel:checkDiscipleState2(self.dzId,DISCIPLE_STATE_TYPE.eDuJieXianDan)then
UIManager.error("弟子正在炼制渡劫仙丹")
return
end

local isZL,zlTime,zlType=UIDanYaoModel:get_zhalu_time(self.ubdId)
if isZL then
if zlType==DANYAO_ZHALU_SEASON.eDiscipleSpecial then
UIManager.error(FMT.fmt('丹炉已损毁，正在修复中（{0})',timeHelper.format_time_stamp(zlTime,true)))
else
UIManager.error(FMT.fmt('炼丹炉炸了，{0}后再来炼制',timeHelper.format_time_stamp4(zlTime)))
end
return
end
local cost=danFangCfg.cost
zongmenModel:countManufacturePercent(self.bdData)
local percent=self.bdData.pcreatesubpercent or 0
local isCan,itemid=UIDanYaoModel:isCanLianZhi(cost,selectCnt,percent)
if isCan then
local fangan=self.selectFangAn or 0
self:reqLianZhi(self.sfId,self.ubdId,danFangCfg.id,selectCnt,fangan)
else
UIManager.error('材料不足')
gainControl:showGainWin(itemid)
end
end

function UIDanYaoWin:reqLianZhi(sfId,ubdId,dfId,count,fangan)
if not UIDanYaoController:isDingDanSystemOpen()then
UIDanYaoController:req_lianzhi(sfId,ubdId,dfId,count,fangan)
else
fangan=fangan or 0
UIDanYaoController:req_lianzhi_batch(sfId,ubdId,1,{{dfId,count,fangan}})
end
end


function UIDanYaoWin:onRewardBtn()
UIDanYaoController:req_danYao_reward(self.sfId,self.ubdId)
end


function UIDanYaoWin:onBeforeCompleteReward()
local cddata=buildingCDControl:getCDData(buildingCDType.liandan,self.ubdId)
local rewardCnt=self:countRewardNum(cddata.fCount)
if rewardCnt>0 then
UIDanYaoController:req_danYao_reward(self.sfId,self.ubdId)
else
UIManager.info('没有可领取奖励')
end
end

function UIDanYaoWin:onClickSelect()




local check=UIDanYaoModel:get_zhalu_time(self.ubdId)
if check then
UIManager.error('炼丹炉损坏期间, 不能安排或更换弟子')
return
end

if tostring(self.bdData.dizi_id)~='0'then
local isPause=UIDanYaoModel:checkIsPause(self.ubdId)
if isPause then
UIManager.error('弟子已外出战斗, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eBuilding then
UIManager.error('建筑正在建造中, 不能更换弟子')
return
elseif self.bdData.flag==buildingStateType.eUpgrading then
UIManager.error('建筑正在升级中, 不能更换弟子')
return
end




end
zongmenControl:showSelectManagerWin(self.sfId,self.bdData)
end

function UIDanYaoWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.replaceDisciple then
_this.dzId=arg1
if tostring(arg1)=='0'then
_this.runningType=runningType.notDanFang
end
_this:refreshDzPanel()
_this:refreshPanel()
end
end


function UIDanYaoWin:refreshSwitchReddot()
local haveDz=tostring(self.dzId)~='0'
if haveDz then
if self.runningType==runningType.notDanFang then
local shake=changeManagerCheckModel:getBuildingReddot(self.bdData.un_build_id)
self.btnSwitchReddot:setActive(shake)
if shake then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.btnSwitch:getID())
else
self.winlua:SetChildDOTweenAnimation_DOPause(self.btnSwitch:getID())
self.btnSwitch:setRotation(0,0,0)
end
else
self.btnSwitchReddot:setActive(false)
self.winlua:SetChildDOTweenAnimation_DOPause(self.btnSwitch:getID())
self.btnSwitch:setRotation(0,0,0)
end
else
local reddot=changeManagerCheckModel:getBuildingReddot(self.bdData.un_build_id)
self.btnSelectReddot:setActive(reddot)
end
end


function UIDanYaoWin:refreshDzPanel()
local dzId=self.dzId

local name=''
local haveDz=tostring(dzId)~='0'
local state=haveDz and UIDiscipleModel:getDiscipleState(dzId)or nil
local isPause=false
local animState=haveDz and 0 or 1
self.root:setAnimatorInteger('state',animState)
self.diziLock:setActive(not haveDz)
self.diziInfo:setActive(haveDz)
self.btnSelect:setActive(not haveDz)
self.btnSwitch:setActive(haveDz)

self:refreshSwitchReddot()

self.imgState:setActive(isPause)
self.imgPause:setActive(isPause)
self.help:setActive(haveDz)
if haveDz then
name=UIDiscipleModel:getDiscipleName(dzId)
local bd_tybe_cfg=cfg_monijybuildconfig_get(self.buildConfig.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)


local sixAttrCfg=cfgHelper.getglobal1('discipleattr')
local sixAttrName=sixAttrCfg[sixAttrType].name
local sixAttrValue=UIDiscipleModel:getDiscipleBaseAttr(dzId,sixAttrType)
self.skill:setText(string.format('%s：%s级（%s %s）',skill_cfg.name,level,sixAttrName,sixAttrValue))
end

self.dizi_speciality=discipleSelectController.getSpeciallistByBuild(dzId,bd_tybe_cfg.build_type)
local haveSpeciality=self.dizi_speciality~=nil and#self.dizi_speciality>0
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


end
self.dzName:setText(FMT.fmt('执事弟子：<color=#7d3b17>{0}</color>',name))
if not isPause then
if not _initModel then
_initModel=true
self.ctimer=self:delayDo(1,function(...)
self:refreshDzModel()
end)
else
self:refreshDzModel()
end
end
end

function UIDanYaoWin:refreshDzModel()
local dzId=self.dzId

uiAIManager:removeUIInstance(self.currDZ)
self.currDZ=nil
if tostring(dzId)~='0'then

self:createDZ(self.bdData.dizi_id,{-360,-226},function(bt)
if self and not self.isClose then
self.currDZ=bt
end
end)

end
end

function UIDanYaoWin:createDZ(dzId,pos,callback)
local UIstateId=0
if self.runningType==runningType.notDanFang or self.runningType==runningType.lzZhong then
UIstateId=1
end
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
order=1001,
weaponslot='shanzislotname',
}
uiAIManager:createUIDisciple('UIDanYaoWin','bt_ui_ldf',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end


function UIDanYaoWin:getSpeakText(bt,tkey)
local dzId=self.dzId
local txt=''
if tostring(dzId)~='0'then
local voc=UIDiscipleModel:getDiscipleJob(dzId)
local speakList=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,voc,'liandanfang')
local state=UIDiscipleModel:getDiscipleState(dzId)
if state==DISCIPLE_STATE_TYPE.eChuiWei then
local chuiweiSpeak=speakList[3]
local speakStr=chuiweiSpeak[math.random(1,#chuiweiSpeak)]or''
txt=speakStr
elseif self.runningType==runningType.notDanFang then
txt='请选择合适的丹方'
elseif self.runningType==runningType.lzZhong then
local normal=speakList[1]
local speakStr=normal[math.random(1,#normal)]or''
txt=speakStr
end
end
bt:setSharedVar(tkey,txt)
end


function UIDanYaoWin:getShanHuoSpeakText(bt,tkey)
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












function UIDanYaoWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.scrollView2:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.dzId,config=data})
end



function UIDanYaoWin:refreshPanel()
self:initRunningType()

self.selectDanFangBtn:setActive(self.runningType==runningType.notDanFang)
self.danFangItem:setActive(self.runningType~=runningType.notDanFang)
self.dfItemNameBg:setActive(self.runningType~=runningType.notDanFang)

self.lianzhiRunning:setActive(self.runningType==runningType.lzZhong or self.runningType==runningType.lzPause)
self.lianzhiComplete:setActive(self.runningType==runningType.lzComplete)
self.qipao:setActive(self.runningType==runningType.lzComplete)
self.pauseTimeImg:setActive(self.runningType==runningType.lzPause)

self.liandanlu:setChildModelAnimationState(2057)
if self.runningType~=runningType.notDanFang then
self:refreshDanFangItem()
else
self:refreshNewImg()
self:refreshCanGetReddot()
end
self:stopLianZhiTimer()
local UIstateId=1
local shanhuo=0
if self.runningType==runningType.haveDanFang then

elseif self.runningType==runningType.lzZhong then
UIstateId=1
shanhuo=2
self.liandanlu:setChildModelAnimationState(eAnimationID.stand)
self:refreshLianZhiProgress()
self:showRewarIcon()
elseif self.runningType==runningType.lzComplete then
UIstateId=0
self:showRewarIcon()
self:refreshDanFangName()
elseif self.runningType==runningType.lzPause then
UIstateId=0
self:showRewarIcon()
self:stopLianZhiTimer()
self:refreshLianZhiPause()
end

if self.currDZ then
self.currDZ:setSharedVar('UIstateId',UIstateId)
self.currDZ:setSharedVar('shanhuo',shanhuo)
self.currDZ:setSharedVar('firstright',1)
end
end

function UIDanYaoWin:refreshNewImg()
local haveNew=UIDanYaoModel:checkHaveDanFangNew()
self.newImg:setActive(haveNew)
end

function UIDanYaoWin:refreshCanGetReddot()
local reddot=UIDanYaoModel.checkUpLevelUnlockReddot()
self.canGetReddot:setActive(reddot)
end

function UIDanYaoWin:refreshDanFangItem()

local widget=self.danFangItem:getWidgetBase()
local iconName=iconHelper.getIconName(self.danFangCfg.itemid)
widget:SetChildCSImageIcon(3,iconName,false)
local config=itemsConfig.getConfig(self.danFangCfg.itemid)
widget:SetChildQulaity(2,config.color)
widget:SetChildButtonClick(3,function(...)
self:onClickDanFangItem(...)
end)
self:refreshDanFangName()
end

function UIDanYaoWin:refreshSelectDanFang()

local need=UIDanYaoModel:getDanFangNeedTime(self.danFangCfg.id,self.dzId)
local needTime=need*self.selectCnt
self.timeText:setText(timeHelper.format_time_stamp4(needTime))


local costList=self.danFangCfg.cost
for i=0,#self.materialsItem-1 do
local item=self.materialsItem[i+1]
item:setActive(i<#costList)
if i<#costList then
local mat=costList[i+1]
local matItemId=mat[1]
local needCount=mat[2]*self.selectCnt
local countStr=UIDanYaoModel:getItemCountStr(matItemId,needCount)
local have=UIDanYaoModel:getHaveItemCount(matItemId)
local showStage=not moneyConfig.isMoney(matItemId)

local conf={itemid=matItemId,itemcount=countStr,showCountBG=true,showStage=showStage}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
prop[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
prop[PropIndex(DataPropKey.eWidgetActive,7)]=have<needCount
item:setChildPropData(prop)

local widget=self.winlua:GetChildWidgetBase(item:getID())
widget:SetChildActive(5,showStage)

local _onClickMaterialItem=function(...)
self:onClickMaterialItem(...)
end
item:setBaseItemChildID(matItemId)
item:setBaseItemClickEvent(_onClickMaterialItem)
end
end


local limitLv=self.danFangCfg.need_dd_lvl
local proType=DISCIPLE_PROSKILL_TYPE.eDanDao
local proLevel=UIDiscipleModel:getDiscipleJobLevel(self.dzId,proType)
self.lianZhiBtn:setActive(proLevel>=limitLv)
self.limitText:setActive(proLevel<limitLv)
if proLevel<limitLv then
local proName=cfgHelper.get2(cfg_discipleproskillconfig_get,proType,'name')
self.limitText:setText(FMT.fmt('{0}等级需达到{1}级',proName,limitLv))
end
end

function UIDanYaoWin:onClickDanFangItem(id,index,guid,attach)
self:onChangeBtn()
end

function UIDanYaoWin:onClickMaterialItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UIDanYaoWin:showRewarIcon()
local iconName
if UIDanYaoController:isDingDanSystemOpen()then
local bdata=UIDanYaoModel:getBatchData(self.ubdId)
local dd=bdata.ddList[1]
local dfcfg=cfgHelper.get1(cfg_danfangconfig_get,dd.dfId)
iconName=iconHelper.getIconName(dfcfg.itemid)
else
iconName=iconHelper.getIconName(self.danFangCfg.itemid)
end
self.rewardIcon:setImageIcon(iconName,false)
end

function UIDanYaoWin:refreshDanFangName()
self.dftemName:setText(self.danFangCfg.name)
end

function UIDanYaoWin:refreshLianZhiProgress()






















local cddata=buildingCDControl:getCDData(buildingCDType.liandan,self.ubdId)
self.timeProgressbar:setChildUIProgressbar(cddata.stepDTime,cddata.dfTime,false)

local rewardCnt=self:countRewardNum(cddata.fCount)
self.qipao:setActive(rewardCnt>0)
self.rewardCount:setText(rewardCnt)





self.timeProgressText:setText(timeHelper.format_time_stamp11(cddata.cd))



local iconName=iconHelper.getIconName(self.danFangCfg.itemid)
self.flyIcon:setImageIcon(iconName,false)

local rcTime=0
local func=function()















local cddata=buildingCDControl:getCDData(buildingCDType.liandan,self.ubdId)
local reset=cddata.stepDTime<rcTime
if reset then
self.timeProgressbar:setChildUIProgressbar(cddata.stepDTime,cddata.dfTime,false)
end
rcTime=cddata.stepDTime
if reset or cddata.complete then
self:playFlyIcon()
end
self.timeProgressbar:setChildUIProgressbar(cddata.stepDTime+1,cddata.dfTime,true)
self.timeProgressText:setText(timeHelper.format_time_stamp11(cddata.cd))



local nameStr=FMT.fmt('{0} {1}/{2}',self.danFangCfg.name,cddata.fCount,cddata.dyCount)
self.dftemName:setText(nameStr)











end

self:addCDUpdateFunc('UPLD',func)
func()
end

function UIDanYaoWin:playFlyIcon()
self:flyItemIcon()
local cddata=buildingCDControl:getCDData(buildingCDType.liandan,self.ubdId)
local rewardCnt=self:countRewardNum(cddata.fCount)
self.qipao:setActive(rewardCnt>0)
self.rewardCount:setText(rewardCnt)
end

function UIDanYaoWin:getRewardAllCount(completeCnt)
local data=UIDanYaoModel:get_danYaodata(self.ubdId)
local cntList=data.cntList
local count=0
local left=#cntList-data.cnt+1
local right=left+completeCnt-1
for i=left,right do
count=count+(cntList[i]or 0)
end
return count
end

function UIDanYaoWin:countRewardNum(cc)
local count=0
if not UIDanYaoController:isDingDanSystemOpen()then
local data=UIDanYaoModel:get_danYaodata(self.ubdId)
for ii=1,cc do
count=count+data.cntList[ii]
end
else
local data=UIDanYaoModel:getBatchData(self.ubdId)
local index=data.currIndex
for i,v in ipairs(data.ddList)do
if i<index then
for ii,vv in ipairs(v.cntList)do
count=count+vv
end
elseif i==index then
for ii=1,cc do
count=count+v.cntList[ii]
end
else
break
end
end
end
return count
end

function UIDanYaoWin:stopLianZhiTimer()




self:removeCDUpdateFunc('UPLD')
end

function UIDanYaoWin:refreshLianZhiPause()
local data=UIDanYaoModel:get_danYaodata(self.ubdId)
local cnt=data.cnt
local passTime=data.passTime
local needTime=UIDanYaoModel:getDanFangNeedTime(self.danFangCfg.id,self.dzId)
local completeCnt=math.floor(passTime/needTime)
completeCnt=completeCnt<0 and 0 or completeCnt
self.qipao:setActive(completeCnt>0)

self.timeProgressText:setText('炼丹暂停中')
local nameStr=FMT.fmt('{0} {1}/{2}',self.danFangCfg.name,completeCnt,cnt)
self.dftemName:setText(nameStr)
if completeCnt>0 then
local rewardCnt=self:getRewardAllCount(completeCnt)
self.rewardCount:setText(rewardCnt)
end
end

function UIDanYaoWin:flushNotHaveDanFang()
self.runningType=runningType.notDanFang


self:refreshPanel()
self:refreshSwitchReddot()
self:setDingDanList()
end

function UIDanYaoWin:flushLianZhiZhong()
self.runningType=runningType.lzZhong
self:refreshPanel()
self:refreshSwitchReddot()
self:setDingDanList()
end

function UIDanYaoWin:flushLianZhiComplete(rtype)
self.runningType=rtype or runningType.lzComplete





self:refreshPanel()
self:refreshSwitchReddot()
self:setDingDanList()
self:playFlyIcon()
end

function UIDanYaoWin:flushLianZhiPause(ubdId)
self.runningType=runningType.lzPause
self:refreshPanel()
self:refreshSwitchReddot()

end

function UIDanYaoWin:checkAndCallFunc(bdId,fName,...)
if self.ubdId==bdId then
self[fName](self,...)
end
end


function UIDanYaoWin:flyItemIcon()
self.flyIcon:setActive(true)
local tran=self.flyIcon:getTransform()
local spos=self.flyIcon:getChildPosition()
local tpos=self.rewardIcon:getChildPosition()
if self.tweener~=nil then
self.tweener:Kill(false)
self.tweener=nil
end
self.tweener=_DOTweenProxy.DoPath(tran,{tpos,Vector3(spos.x-3,spos.y+2,0),tpos},1,_pathType.CubicBezier)
self.tweener:SetEase(_Ease.InSine)
self.tweener:OnComplete(function()
self.flyIcon:setChildPosition(spos)
self.flyIcon:setActive(false)
self.tweener:Kill(false)
self.tweener=nil
end)
end

function UIDanYaoWin:playDanLuEffect()
self.liandanluEffect:setChildShowEffect(10046,true)
end

function UIDanYaoWin:actionLianZhi(dfId,cnt,fangan)




self.selectDanFang=dfId
self.selectCount=cnt
self.selectFangAn=fangan or 0
self:onLianZhiBtn()
end

function UIDanYaoWin:onDingDanSelect(cnum,index)
if UIDanYaoModel:isDingDanComplete(self.bdData.un_build_id)then
return
end
if index==#self.ddList then
self:onSelectDanFangBtn()
end
end

function UIDanYaoWin:setDingDanList()
if not UIDanYaoController:isDingDanSystemOpen()then
return
end

self:stopDDTimer()

self:setDingDanIcon()

local ubdId=self.bdData.un_build_id
local data=UIDanYaoModel:getBatchData(ubdId)
local ddlist=data and data.ddList or{}
local currIndex=data and data.currIndex
self.ddList=ddlist
local curr=#ddlist
local isFull=curr>=self.maxDDNum
local color=isFull and'#f36666'or'#aae252'
self.ddCountP:setText(FMT.fmt('炼丹订单(<color={2}>{0}/{1}</color>)',curr,self.maxDDNum,color))

local showStop=curr>0
local len=curr
local complete=UIDanYaoModel:isDingDanComplete(self.bdData.un_build_id)
local showAdd=not complete and not isFull
if showAdd then
len=len+1
end

self.stopDDBtn:setActive(showStop and not complete)
self.receiveDDBtn:setActive(complete)

self.ddScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.ddScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local select=false
if showAdd and i==count then
item:SetChildActive(1,true)
item:SetChildActive(2,false)
item:SetChildNewBieComponentId(-1,'UIDanYaoWin.dingDanItemAdd')
else
local dd=ddlist[i]
local dfcfg=cfgHelper.get1(cfg_danfangconfig_get,dd.dfId)
item:SetChildActive(1,false)
item:SetChildActive(2,true)
local countText
item:SetChildText(4,dfcfg.name)
if i<currIndex then
item:SetChildText(5,'<color=#549327>炼制完成</color>')
countText=FMT.fmt('{0}/{1}',dd.cnt,dd.cnt)
item:SetChildActive(6,false)
elseif i==currIndex then
item:SetChildText(5,dd.complete and'<color=#549327>炼制完成</color>'or'<color=#ca631d>炼制中</color>')
local cddata=buildingCDControl:getCDData(buildingCDType.liandan,ubdId)
countText=FMT.fmt('{0}/{1}',cddata.fCount,dd.cnt)
item:SetChildActive(6,not dd.complete)
if not dd.complete then
item:SetChildUIProgressbar(6,cddata.dtime,cddata.ntime,false)
self:startDDTimer(item,dfcfg.itemid,ubdId,cddata.fCount,dd.cnt)
end
select=true
else
item:SetChildText(5,'<color=#c82c2c>等待炼制</color>')
countText=FMT.fmt('{0}/{1}',0,dd.cnt)
item:SetChildActive(6,true)
item:SetChildUIProgressbar(6,0,1,false)
local needTime=UIDanYaoModel:getDanFangNeedTime(dfcfg.id,self.dzId)
item:SetChildText(7,timeHelper.format_time_stamp11(needTime*dd.cnt))
end
widgetHelper.setNormalRewardItem(item,3,{dfcfg.itemid,0,countText=countText})
item:SetChildNewBieComponentId(-1,'UIDanYaoWin.dingDanItem_'..i)
end
item:SetChildActive(0,select)
end
end

function UIDanYaoWin:stopDDTimer()




self:removeCDUpdateFunc('UPDD')
end

function UIDanYaoWin:startDDTimer(item,itemid,ubdId,curr,max)
local tick=function()
local cddata=buildingCDControl:getCDData(buildingCDType.liandan,ubdId)
if curr~=cddata.fCount then
curr=cddata.fCount
local countText=FMT.fmt('{0}/{1}',curr,max)
widgetHelper.setNormalRewardItem(item,3,{itemid,0,countText=countText})
end
item:SetChildUIProgressbar(6,cddata.dtime+1,cddata.ntime,true)
item:SetChildText(7,timeHelper.format_time_stamp11(cddata.cd))
end

self:addCDUpdateFunc('UPDD',tick)
tick()
end

function UIDanYaoWin:setDingDanIcon()
local ubdId=self.bdData.un_build_id
local data=UIDanYaoModel:getBatchData(ubdId)
local curr=data and#data.ddList or 0
local isFull=curr>=self.maxDDNum
local color=isFull and'#f36666'or'#549327'
self.ddCount:setText(FMT.fmt('炼丹订单(<color={2}>{0}/{1}</color>)',curr,self.maxDDNum,color))
end

function UIDanYaoWin:onDdIcon()
if not UIDanYaoController:isDingDanSystemOpen()then
self:showJumpDialogue()
return
end

if self.isPlaying then
return
end
self.isPlaying=true
self.ddPanel:setActive(true)
self.ddIcon:setChildCanvasGroupDOFade(0,0.25)
self.ddPBG:setChildModelAnimationState(eAnimationID.enter,1,nil)
local tweener=self.ddInfo:setChildCanvasGroupDOFade(1,0.25,function()
self.isPlaying=false
self.isDDPanelOpen=true
end)
tweener:SetDelay(0.5)
self:setDingDanList()
end

function UIDanYaoWin:showJumpDialogue()
local args={
content=cfgHelper.getlang('ui_liandan_dingdan_tips'),
oktext='前往进阶',
okcb=function()
jumpManager:jump({id=JUMP_TYPE.eXianTuChengJiu,args={tab=1}})
end
}
local dialog=UIDialogManager.getConfirmDialogEx(nil,args)
dialog:show()
end

function UIDanYaoWin:checkANdShowNBDialogue()
if not UIDanYaoController:isDingDanSystemOpen()then
return false
end
if not UIDanYaoController:isFirstUseDingDan()then
return false
end
local dzId=self.bdData.dizi_id
if tostring(dzId)=='0'then
local dzData=UIDiscipleModel:getDiscipleByFightIndex(1)
dzId=dzData.discipleguid
end
local func=function()
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.FirstUseDingDanFunc)
end
gameplotController:showPlotBoard({dis_guid=dzId,groupid=90010,callback=func,isFullOpen=false})
UIDanYaoController:recordFirstUseDingDan()
return true
end

function UIDanYaoWin:onReceiveDDBtn()
UIDanYaoController:req_danYao_reward(self.sfId,self.ubdId)
end

function UIDanYaoWin:onStopDDBtn()
UIDanYaoController:req_danYao_reward(self.sfId,self.ubdId,1)
end

function UIDanYaoWin:onClosePanelBtn()
if self.isPlaying then
return
end
self.isPlaying=true
self.ddInfo:setChildCanvasGroupDOFade(0,0.25,function()
self.ddPBG:setChildModelAnimationState(eAnimationID.ui_close,1,function()
self.ddPanel:setActive(false)
self.ddIcon:setChildCanvasGroupDOFade(1,0.25)
self.isPlaying=false
self.isDDPanelOpen=false
end)
end)
end

function UIDanYaoWin:onLeftArrow()
self:toNextWin(-1)
end

function UIDanYaoWin:onRightArrow()
self:toNextWin(1)
end
