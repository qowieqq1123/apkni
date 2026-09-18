







def_class("UILZDKMainWin",UIWindowBase)









function UILZDKMainWin:bindComponents()

self.root=UIObject.get(self,0)
self.bg=UIObject.get(self,1)
self.lockInfo=UIObject.get(self,2)
self.lockTipsBtn=UIButton.get(self,3)
self.diziInfo=UIObject.get(self,4)
self.dzName=UIText.get(self,5)
self.skill=UIText.get(self,6)
self.specialityScrollView=UIObject.get(self,7)
self.dzinfoTipsBtn=UIButton.get(self,8)
self.btnHecheng=UIButton.get(self,9)
self.btnSelect=UIObject.get(self,10)
self.btnSwitch=UIObject.get(self,11)
self.dzEmpty=UIObject.get(self,12)
self.btnDingzhi=UIButton.get(self,13)
self.btnReward=UIButton.get(self,14)
self.rewardReddot=UIObject.get(self,15)
self.progressBar=UIObject.get(self,16)
self.curBarValue=UIText.get(self,17)
self.maxBarValue=UIText.get(self,18)
self.minBarValue=UIText.get(self,19)
self.barTitle=UIText.get(self,20)
self.midBg=UIObject.get(self,21)
self.itemRoot=UIObject.get(self,22)
self.item1=UIObject.get(self,23)
self.item2=UIObject.get(self,24)
self.item3=UIObject.get(self,25)
self.item4=UIObject.get(self,26)
self.item5=UIObject.get(self,27)
self.animRoot=UIObject.get(self,28)
self.handleRoot=UIObject.get(self,29)
self.handleProgressBar=UIProgressBarAni.get(self,30)
self.handleCoolTime=UIText.get(self,31)
self.handleIconTime=UIObject.get(self,32)
self.handleDesc=UIText.get(self,33)
self.handleValue=UIText.get(self,34)
self.btnStart=UIButton.get(self,35)
self.helpBtn=UIButton.get(self,36)
self.Icon=UIObject.get(self,37)
self.sunhuiValue=UIText.get(self,38)
self.lvTips1=UIText.get(self,39)
self.lvTips2=UIText.get(self,40)
self.lvTips3=UIText.get(self,41)
self.lvValue1=UIText.get(self,42)
self.lvValue2=UIText.get(self,43)
self.lvValue3=UIText.get(self,44)
self.selectCntSlider=UIObject.get(self,45)
self.handleImg=UIObject.get(self,46)
self.handleImgCenter=UIObject.get(self,47)
self.subBtn=UIButton.get(self,48)
self.addBtn=UIButton.get(self,49)
self.btnStop=UIButton.get(self,50)
self.baoxiang=UIObject.get(self,51)
self.qipao=UIObject.get(self,52)
self.rewardIcon=UIImage.get(self,53)
self.rewardCount=UIText.get(self,54)
self.flyIcon=UIImage.get(self,55)
self.btnRcv=UIButton.get(self,56)
self.costRoot=UIObject.get(self,57)
self.costitem1=UIBaseItem.get(self,58)
self.costitem2=UIBaseItem.get(self,59)
self.selectCntText=UIText.get(self,60)
self.endingRoot=UIObject.get(self,61)
self.endingImage=UIImage.get(self,62)

self.lockTipsBtn:setButtonClick(function()self:onLockTipsBtn()end)

self.dzinfoTipsBtn:setButtonClick(function()self:onDzinfoTipsBtn()end)

self.btnHecheng:setButtonClick(function()self:onBtnHecheng()end)

self.btnDingzhi:setButtonClick(function()self:onBtnDingzhi()end)

self.btnReward:setButtonClick(function()self:onBtnReward()end)

self.btnStart:setButtonClick(function()self:onBtnStart()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.btnStop:setButtonClick(function()self:onBtnStop()end)

self.btnRcv:setButtonClick(function()self:onBtnRcv()end)



end


function UILZDKMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.lockInfo);self.lockInfo=nil;
_UIObject_release(self.lockTipsBtn);self.lockTipsBtn=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.specialityScrollView);self.specialityScrollView=nil;
_UIObject_release(self.dzinfoTipsBtn);self.dzinfoTipsBtn=nil;
_UIObject_release(self.btnHecheng);self.btnHecheng=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.dzEmpty);self.dzEmpty=nil;
_UIObject_release(self.btnDingzhi);self.btnDingzhi=nil;
_UIObject_release(self.btnReward);self.btnReward=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.curBarValue);self.curBarValue=nil;
_UIObject_release(self.maxBarValue);self.maxBarValue=nil;
_UIObject_release(self.minBarValue);self.minBarValue=nil;
_UIObject_release(self.barTitle);self.barTitle=nil;
_UIObject_release(self.midBg);self.midBg=nil;
_UIObject_release(self.itemRoot);self.itemRoot=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.item5);self.item5=nil;
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.handleRoot);self.handleRoot=nil;
_UIObject_release(self.handleProgressBar);self.handleProgressBar=nil;
_UIObject_release(self.handleCoolTime);self.handleCoolTime=nil;
_UIObject_release(self.handleIconTime);self.handleIconTime=nil;
_UIObject_release(self.handleDesc);self.handleDesc=nil;
_UIObject_release(self.handleValue);self.handleValue=nil;
_UIObject_release(self.btnStart);self.btnStart=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.sunhuiValue);self.sunhuiValue=nil;
_UIObject_release(self.lvTips1);self.lvTips1=nil;
_UIObject_release(self.lvTips2);self.lvTips2=nil;
_UIObject_release(self.lvTips3);self.lvTips3=nil;
_UIObject_release(self.lvValue1);self.lvValue1=nil;
_UIObject_release(self.lvValue2);self.lvValue2=nil;
_UIObject_release(self.lvValue3);self.lvValue3=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.handleImgCenter);self.handleImgCenter=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.btnStop);self.btnStop=nil;
_UIObject_release(self.baoxiang);self.baoxiang=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.rewardIcon);self.rewardIcon=nil;
_UIObject_release(self.rewardCount);self.rewardCount=nil;
_UIObject_release(self.flyIcon);self.flyIcon=nil;
_UIObject_release(self.btnRcv);self.btnRcv=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.costitem1);self.costitem1=nil;
_UIObject_release(self.costitem2);self.costitem2=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.endingRoot);self.endingRoot=nil;
_UIObject_release(self.endingImage);self.endingImage=nil;
end


















local _this
local _initModel=false
local abName="ui/windows/lingzhendiaoke/lingzhendk_atlas_pak.ab"
local imageNameList={"image_tggdiaoketp_1","image_tggdiaoketp_2","image_tggdiaoketp_3","image_tggdiaoketp_4","image_tggdiaoketp_5"}

function UILZDKMainWin:onLoaded(...)
self:bindComponents()

self.itemList={self.item1,self.item2,self.item3,self.item4,self.item5}
self.lvTipsList={self.lvTips1,self.lvTips2,self.lvTips3}
self.lvValueList={self.lvValue1,self.lvValue2,self.lvValue3}
self.costItemList={self.costitem1,self.costitem2}
for i,v in ipairs(self.costItemList)do
v:setBaseItemClickEvent(function(...)
self:costitemCilck(...)
end)
end
local longPressFunc=function(...)
self:onLongPressBtn(...)
end
self.winlua:SetChildLongPress(self.subBtn:getID(),1,longPressFunc,nil)
self.winlua:SetChildLongPress(self.addBtn:getID(),2,longPressFunc,nil)
_this=self
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
self.specialityScrollView:setChildScrollViewInit(0,true,function(clicknum,i)
self:onClickSpeciality(i)
end,nil)
end


function UILZDKMainWin:__delete()
hudControl:refreshBuildingStatusHUD(self.un_build_id)
self:clear()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)

end

function UILZDKMainWin:clear()
self:stopHandleTimer()
uiAIManager:clearUIWinData('UILZDKMainWin')
self.currDZ=nil
if self.tweener~=nil then
self.tweener:Kill(false)
self.tweener=nil
end
_initModel=nil
roleAudioController:stopRoleSpeak()
end




function UILZDKMainWin:onShow(argtable,afterOnloaded)
if afterOnloaded then



self.LGZMax=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"lgz")
self.minBarValue:setText("")
self.maxBarValue:setText(self.LGZMax)
self.handleDesc:setText("进度")
self.selectDKNum=1
self.firstFlag=true
self.animRoot:setChildUIModelShowTarget(5372,1,{},2104)
end


local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLZDKTips)
if not flag then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLZDKTips,true)
end

if argtable==nil then return end
local entityId=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(entityId)
self.buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.dzId=self.bdData.dizi_id
self.un_build_id=self.bdData.un_build_id

self:refresh()
end


function UILZDKMainWin:onHide()
self:clear()
end

function UILZDKMainWin:onShowArgRecv(argtable)
self:onShow(argtable)
end



function UILZDKMainWin:refresh()
self:refreshLeftPanel()
self:refreshMidPanel()
self:refreshRightPanel()
end


function UILZDKMainWin:refreshLeftPanel()
local dzId=self.dzId
local haveDz=tostring(dzId)~='0'
self.lockInfo:setActive(not haveDz)
self.btnSelect:setActive(not haveDz)
self.diziInfo:setActive(haveDz)
self.btnSwitch:setActive(haveDz)
self:refreshDZPanel(haveDz)
end

function UILZDKMainWin:refreshDZPanel(haveDz)
local dzId=self.dzId
local bd_tybe=self.config.id
if haveDz then
local name=UIDiscipleModel:getDiscipleName(dzId)
self.dzName:setText(FMT.fmt('执事弟子：<color=#7d3b17>{0}</color>',name))
local bd_tybe_cfg=cfg_monijybuildconfig_get(bd_tybe)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local effect=nil
if skill_cfg.buildplant_effects then
effect=skill_cfg.buildplant_effects[level]
end
local content=FMT.fmt('{0}：<color=#7d3b17>{1}级</color>',skill_cfg.name,level)
self.skill:setText(content)
end
local specialList=discipleSelectController.getSpeciallistByBuild(dzId,bd_tybe_cfg.build_type)
self.dizi_speciality=specialList
if specialList then
self.specialityScrollView:setActive(true)
self.specialityScrollView:setChildScrollViewCreateGrids(#specialList,0)
local grids=self.specialityScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=specialList[i]
UIDiscipleModel.refreshSpecialityItemEx(item,data)
end
else
self.specialityScrollView:setActive(false)
end
end

if not _initModel then
_initModel=true
self:delayDo(1,function(...)
self:refreshDzModel()
end)
else
self:refreshDzModel()
end
end

function UILZDKMainWin:refreshDzModel()
local dzId=self.dzId
uiAIManager:removeUIInstance(self.currDZ)
self.currDZ=nil
if tostring(dzId)~='0'then
self:createDZ(dzId,{-290,-226},function(bt)
self.currDZ=bt




end)
end
end

function UILZDKMainWin:createDZ(dzId,pos,callback)

local state=UIDiscipleModel:checkDiscipleState2(self.dzId,DISCIPLE_STATE_TYPE.edsDispatch)

if state then return end














































































local initData={
stateId=0,
minTime=5,
maxTime=5,
rightPos={-200,-226},
leftPos={-290,-226},
posDir=1,
rateValue=0,
winName="UILZDKMainWin",
winFunc="bTInoveFun",
speed=100,
animId=10,

minDuration=2,
maxDuration=5,
hudtarget=1,
moveFlag=1,
targetPos={-245,-226}
}
local tran=self.dzEmpty:getCommonComponent('Transform')
local vpos=Vector2.New(-245,-226)
uiAIManager:createUIDisciple('UILZDKMainWin','bt_ui_common',dzId,tran,vpos,initData,nil,function(bt)
callback(bt)
end)
end
function UILZDKMainWin:bTInoveFun(bt)







end

function UILZDKMainWin:changeState()




end





function UILZDKMainWin:refreshMidPanel()
self:refreshLGZVal()

local dkState,curNum,sumNum=LZDiaoKeModel:CheckDKState(self.sfId,self.un_build_id)

self.itemRoot:setActive(dkState==LZDKSTATE.eNotDk)
self.btnStart:setActive(dkState==LZDKSTATE.eNotDk)
self.animRoot:setActive(dkState==LZDKSTATE.eDKing)
self.handleRoot:setActive(dkState==LZDKSTATE.eDKing)
self.btnRcv:setActive(dkState==LZDKSTATE.eHoldDKReward)
self.endingRoot:setActive(dkState~=LZDKSTATE.eNotDk)
if dkState==LZDKSTATE.eDKing then
self:playAnim(true)
self:refreshDKHandleVal()
self:setEndingImage()
local alpha=curNum/sumNum
self.endingImage:setChildCanvasGroupAlpha(alpha==0 and 0.1 or alpha)
elseif dkState==LZDKSTATE.eNotDk then
self:playAnim(false)
self:refreshDKList()
elseif dkState==LZDKSTATE.eHoldDKReward then
self:setEndingImage()
self:playAnim(false)
self.endingImage:setChildCanvasGroupAlpha(1)
end
self:refreshBaoxiang()
end

function UILZDKMainWin:setEndingImage()
local dkItemList=LZDiaoKeModel:getJZData_DkItemList(self.sfId,self.un_build_id)
if not dkItemList then
return
end
local type
for i,v in ipairs(dkItemList)do
if itemsConfig.isLingZhen(v.param_1)then
local cfg=itemsConfig.getConfig(v.param_1)
type=cfg.type1
break
end
end
if type and type<=#imageNameList then
self.endingImage:setCSImageSprite(abName,imageNameList[type])
end
end

function UILZDKMainWin:refreshLGZVal()
local lgz=LZDiaoKeModel:getJZData_Lgz(self.sfId,self.un_build_id)

self.curBarValue:setText(lgz)
self.progressBar:setChildUIProgressbar(lgz>self.LGZMax and self.LGZMax or lgz,self.LGZMax)
self.rewardReddot:setActive(lgz>=self.LGZMax)
end

function UILZDKMainWin:playAnim(playFlag)

self.animRoot:setChildModelAnimationState(2104)
end

function UILZDKMainWin:refreshDKList()
local dzdkList=LZDiaoKeModel:getJZData_DzdkList(self.sfId,self.un_build_id)
for i,v in ipairs(self.itemList)do
local obj=v
obj:setActive(dzdkList[i]~=nil)
end
end

function UILZDKMainWin:refreshBaoxiang()
local dkState,curNum,sumNum=LZDiaoKeModel:CheckDKState(self.sfId,self.un_build_id)
if dkState==LZDKSTATE.eDKing then
self.endingImage:setChildCanvasGroupAlpha(curNum/sumNum)
elseif dkState==LZDKSTATE.eHoldDKReward then
reddotControl.on_change_catch_type(CATCH_TYPE.eLingZhenDiaoke)
end

self.qipao:setActive(curNum>0)
local dkItemList=LZDiaoKeModel:getJZData_DkItemList(self.sfId,self.un_build_id)

self.rewardIcon:setActive(curNum>0)
self.rewardCount:setText(curNum>0 and curNum or"")
local itemId=dkItemList[1]and dkItemList[1].param_1 or nil
if not itemId or curNum<=0 then
return
end
local iconName=iconHelper.getIconName(itemId)
self.rewardIcon:setImageIcon(iconName,false)
end

function UILZDKMainWin:refreshDKHandleVal()
local func=function()
local dkState,curNum,sumNum=LZDiaoKeModel:CheckDKState(self.sfId,self.un_build_id)
if dkState==LZDKSTATE.eDKing then
local startTime=LZDiaoKeModel:getJZData_StartTime(self.sfId,self.un_build_id)
local needTime=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"dktime")
local curTime=timeHelper.getServerShortTime()


local totalTime=needTime*sumNum
local showTime=startTime+totalTime-curTime
self.handleValue:setText(FMT.fmt("{0}/{1}",curNum,sumNum))
self.handleCoolTime:setText(timeHelper.format_time_stamp11(showTime))
local progressValue=curTime-startTime-curNum*needTime


if progressValue>=0 and self.firstFlag then
self.completeCnt=curNum
self.handleProgressBar:animateThreeParams(progressValue,needTime,0)
self.handleProgressBar:animateFourParams(needTime,needTime,needTime-progressValue,false)
end

if self.completeCnt~=curNum then
self.completeCnt=curNum
self:flyItemIcon(self.refreshBaoxiang)
self.handleProgressBar:animateThreeParams(0,needTime,0)
self.handleProgressBar:animateFourParams(needTime,needTime,needTime,false)




self:refreshLGZVal()
end
else

if self.completeCnt~=curNum then
self.completeCnt=curNum
self:flyItemIcon(self.refreshBaoxiang)



self:refreshLGZVal()

end
self:stopHandleTimer()
self:refreshMidPanel()
self:refreshBottom()
end
end
func()
self:startHandleTimer(func)
end

function UILZDKMainWin:startHandleTimer(func)
if not self.HandleTimer then
self.HandleTimer=self:setTimer(1,0,func)
end
self.firstFlag=false
end

function UILZDKMainWin:stopHandleTimer()
if self.HandleTimer then
self:stopTimerByID(self.HandleTimer)
self.HandleTimer=nil
end
self.firstFlag=true
end


function UILZDKMainWin:flyItemIcon(func)
local dkItemList=LZDiaoKeModel:getJZData_DkItemList(self.sfId,self.un_build_id)
local itemId=dkItemList[1]and dkItemList[1].param_1 or nil
local iconName=iconHelper.getIconName(itemId)
if not itemId then
return
end
self.flyIcon:setImageIcon(iconName,false)
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
if func then
func(self)
end
end)
end




function UILZDKMainWin:refreshRightPanel()
self:refreshTips()
self:refreshBottom()
self:refreshCostItem()
end

function UILZDKMainWin:refreshBottom()
local dkState,curNum,sumNum=LZDiaoKeModel:CheckDKState(self.sfId,self.un_build_id)
self.selectCntSlider:setActive(dkState~=LZDKSTATE.eDKing)
self.btnStop:setActive(dkState==LZDKSTATE.eDKing)
self:resetSliderInit(dkState~=LZDKSTATE.eDKing)
end



function UILZDKMainWin:refreshTips()
local dzId=self.dzId
local bd_tybe=self.config.id
local haveDz=tostring(dzId)~='0'
if haveDz then
local bd_tybe_cfg=cfg_monijybuildconfig_get(bd_tybe)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local cfg=cfg_lingzhendiaokeoddsconfig_get(level)
local levelOdds=cfg.levelOdds
local badOdds=levelOdds[0]
self.sunhuiValue:setText(FMT.fmt("{0}%",badOdds/100))
for i,v in ipairs(self.lvValueList)do
if levelOdds[i]then
v:setText(FMT.fmt("{0}%",levelOdds[i]/100))
else
v:setText("0%")
end
end
end
else
self.sunhuiValue:setText("0%")
for i,v in ipairs(self.lvValueList)do
v:setText("0%")
end
end
end

function UILZDKMainWin:refreshCostItem()
local dzlen=LZDiaoKeModel:getJZData_Dzlen(self.sfId,self.un_build_id)
local useItem=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"useItem")
local costItem=useItem[dzlen]
for i,v in ipairs(self.costItemList)do
if costItem[i]then
v:setActive(true)
local itemcfg=costItem[i]
local itemid=itemcfg[1]
local needCount=itemcfg[2]
local sumNeedCount=needCount*self.selectDKNum
local hasCount=itemsModel.getCount(itemid)
local itemfmtStr=hasCount<needCount and"<color=#C82C2C>{0}/{1}</color>"or"{0}/{1}"
local moneyfmtStr=hasCount<needCount and"<color=#C82C2C>{0}</color>"or"{0}"
local hasCountStr=mathHelper.formatNumber(hasCount)
local sumNeedCountStr=mathHelper.formatNumber(sumNeedCount)


local itemcountStr=itemsConfig.isMoney(itemid)and FMT.fmt(moneyfmtStr,sumNeedCountStr)or FMT.fmt(itemfmtStr,hasCountStr,sumNeedCountStr)
local conf={showname=false,showStageBg=true,showCountBG=true,itemcount=itemcountStr}
local item_data={itemid=itemid,itemcount=0}
local prop=itemsComponentHelper.getCommonFillData(item_data,conf)

v:setChildPropData(prop)
else
v:setActive(false)
end
end
end

function UILZDKMainWin:resetSliderInit(showSlider)
if not showSlider then
return
end
self.maxselectCnt=LZDiaoKeModel:getMaxDKCount(self.sfId,self.un_build_id)
local minCount=self.maxselectCnt==1 and 0 or 1
local curSeclet=self.selectDKNum
local maxCnt=self.maxselectCnt

if curSeclet<minCount then
curSeclet=minCount
self.selectDKNum=minCount
end
if curSeclet>maxCnt then
curSeclet=maxCnt
self.selectDKNum=maxCnt
end

self.winlua:SetChildImageRaycast(self.handleImg:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.handleImgCenter:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.subBtn:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.addBtn:getID(),maxCnt>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),curSeclet,minCount,maxCnt,self.on_slider_change)
end

function UILZDKMainWin.on_slider_change(value)
_this:onSliderChange(value)
end

function UILZDKMainWin:onSliderChange(value)
self.selectDKNum=value
self.selectCntText:setText(value)
self:refreshCostItem()
end





function UILZDKMainWin:onLockTipsBtn()
local d={}
d.title='未安排弟子说明'
d.mode=3
d.name='lzdk_weianpait_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UILZDKMainWin:onDzinfoTipsBtn()
local d={}
d.title='已有弟子说明'
d.mode=3
d.name='lzdk_anpait_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UILZDKMainWin:onBtnHecheng()



UIYuFuLingZhenControl:showCombineWin()
end

function UILZDKMainWin:onBtnDingzhi()






















local config=cfgHelper.get1(cfg_lingzhenpengzhuangconfig_get,1)
if config.shopId then
funcShopController:openShopWin({shopId=config.shopId})
end
end

function UILZDKMainWin:onBtnReward()
local lgz=LZDiaoKeModel:getJZData_Lgz(self.sfId,self.un_build_id)
if lgz<self.LGZMax then

local clientlgzItems=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"clientlgzItems")




UIManager:showWindow("UILZGRewardWin",{detail=clientlgzItems,titleTx="灵感奖励",tipsTx="消费100点灵感，可能获得的奖励"})
return
end
LZDiaoKeController:req_LingGanReward(self.sfId,self.un_build_id)
end

function UILZDKMainWin:onBtnStart()
local dzId=self.dzId
if tostring(dzId)=='0'then
UIManager.error('未安排弟子,无法进行雕刻')
return
end
local dkState=LZDiaoKeModel:CheckDKState(self.sfId,self.un_build_id)
if dkState~=LZDKSTATE.eNotDk then
return
end
local maxcnt,isCan,itemId=LZDiaoKeModel:getMaxDKCount(self.sfId,self.un_build_id)
if not isCan then
gainControl:showGainWin(itemId)
UIManager.error('材料不足')
return
end
LZDiaoKeController:req_StartDK(self.sfId,self.un_build_id,self.selectDKNum)
end

function UILZDKMainWin:onHelpBtn()
local d={}
d.title='雕刻说明'
d.mode=3
d.name='lzdk_Tips_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UILZDKMainWin:onSubBtn()

end

function UILZDKMainWin:onAddBtn()

end

function UILZDKMainWin:onBtnStop()
LZDiaoKeController:req_StopDK(self.sfId,self.un_build_id,1)
end

function UILZDKMainWin:onBtnRcv()
LZDiaoKeController:req_StopDK(self.sfId,self.un_build_id,1)
end

function UILZDKMainWin:onBeforeCompleteReward()
LZDiaoKeController:req_StopDK(self.sfId,self.un_build_id,2)
end

function UILZDKMainWin:onClickSelect()
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
elseif LZDiaoKeModel:isDKing(self.sfId,self.un_build_id)then
UIManager.error('弟子正在雕刻中, 不能更换弟子')
return
end
end
zongmenControl:showSelectManagerWin(self.sfId,self.bdData)
end

function UILZDKMainWin:costitemCilck(...)



itemsComponentHelper.onItemClick(...)
end

function UILZDKMainWin:onLongPressBtn(id)
if id==1 then
if self.selectDKNum<=1 then
return
end
self.selectDKNum=self.selectDKNum-1
else
if self.selectDKNum>=self.maxselectCnt then
return
end
self.selectDKNum=self.selectDKNum+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectDKNum)
end

function UILZDKMainWin:onClickSpeciality(i)
local data=self.dizi_speciality[i+1]
local item=self.specialityScrollView:getChildScrollViewItemWidget(i)
UIManager:showWindow('UISpecialityWin',{item=item,node='bottom',guid=self.bdData.dizi_id,config=data})
end

function UILZDKMainWin:openDingzhi()
local dkState=LZDiaoKeModel:CheckDKState(self.sfId,self.un_build_id)
if dkState==LZDKSTATE.eDKing then
UIManager.info("正在雕刻中")
return
elseif dkState==LZDKSTATE.eHoldDKReward then
UIManager.info("请先领取雕刻好的灵阵")
return
end

local dzId=self.dzId
local bd_tybe=self.config.id
local haveDz=tostring(dzId)~='0'
local level=1
if haveDz then
local bd_tybe_cfg=cfg_monijybuildconfig_get(bd_tybe)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
end
end
level=level==0 and 1 or level
UIManager:showWindow("UILZDKSubWin_Select",{level,self.sfId,self.un_build_id})
end



function UILZDKMainWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.replaceDisciple then
_this.dzId=arg1
_this:refreshLeftPanel()
_this:refreshTips()
end
end























