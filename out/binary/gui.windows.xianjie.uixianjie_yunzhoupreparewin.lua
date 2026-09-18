







def_class("UIXianJie_YunZhouPrepareWin",UIWindowBase)









function UIXianJie_YunZhouPrepareWin:bindComponents()

self.addDzBtn=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.buZhenBtn=UIButton.get(self,2)
self.cancelButton=UIButton.get(self,3)
self.changeShipPanel=UIButton.get(self,4)
self.changeTeamBtn=UIButton.get(self,5)
self.clickMask=UIObject.get(self,6)
self.confirmBtn=UIButton.get(self,7)
self.confirmBtnText=UIText.get(self,8)
self.costTimeText=UIText.get(self,9)
self.discipleScrollView=UIObject.get(self,10)
self.dragObject=UIObject.get(self,11)
self.fatigueDesc=UIText.get(self,12)
self.fatigueState=UIObject.get(self,13)
self.fightText=UIText.get(self,14)
self.gotoYJYBtn=UIButton.get(self,15)
self.helpButton=UIButton.get(self,16)
self.jobPanel=UIObject.get(self,17)
self.mask=UIObject.get(self,18)
self.moneyCost=UIObject.get(self,19)
self.moneyCostCountText=UIText.get(self,20)
self.moneyCostIcon=UIImage.get(self,21)
self.notSoldierTips=UIObject.get(self,22)
self.paibuBtn=UIButton.get(self,23)
self.ruleBtn=UIButton.get(self,24)
self.selectCntSlider=UIObject.get(self,25)
self.selectCntSliderPanel=UIObject.get(self,26)
self.selectCntText=UIText.get(self,27)
self.selectText=UIText.get(self,28)
self.shipName=UIText.get(self,29)
self.singleFight=UIObject.get(self,30)
self.soldierCountText=UIText.get(self,31)
self.soldierModel=UIObject.get(self,32)
self.targetFightBG=UIObject.get(self,33)
self.targetFightDesc=UIText.get(self,34)
self.targetFightText=UIText.get(self,35)
self.tipsTextImg=UIObject.get(self,36)
self.topMask=UIObject.get(self,37)
self.yzModel=UIObject.get(self,38)

self.addDzBtn:setButtonClick(function()self:onAddDzBtn()end)

self.buZhenBtn:setButtonClick(function()self:onBuZhenBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.changeShipPanel:setButtonClick(function()self:onChangeShipPanel()end)

self.changeTeamBtn:setButtonClick(function()self:onChangeTeamBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.gotoYJYBtn:setButtonClick(function()self:onGotoYJYBtn()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.paibuBtn:setButtonClick(function()self:onPaibuBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)



end


function UIXianJie_YunZhouPrepareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addDzBtn);self.addDzBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.buZhenBtn);self.buZhenBtn=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.changeShipPanel);self.changeShipPanel=nil;
_UIObject_release(self.changeTeamBtn);self.changeTeamBtn=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.confirmBtnText);self.confirmBtnText=nil;
_UIObject_release(self.costTimeText);self.costTimeText=nil;
_UIObject_release(self.discipleScrollView);self.discipleScrollView=nil;
_UIObject_release(self.dragObject);self.dragObject=nil;
_UIObject_release(self.fatigueDesc);self.fatigueDesc=nil;
_UIObject_release(self.fatigueState);self.fatigueState=nil;
_UIObject_release(self.fightText);self.fightText=nil;
_UIObject_release(self.gotoYJYBtn);self.gotoYJYBtn=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.jobPanel);self.jobPanel=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.moneyCost);self.moneyCost=nil;
_UIObject_release(self.moneyCostCountText);self.moneyCostCountText=nil;
_UIObject_release(self.moneyCostIcon);self.moneyCostIcon=nil;
_UIObject_release(self.notSoldierTips);self.notSoldierTips=nil;
_UIObject_release(self.paibuBtn);self.paibuBtn=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntSliderPanel);self.selectCntSliderPanel=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.shipName);self.shipName=nil;
_UIObject_release(self.singleFight);self.singleFight=nil;
_UIObject_release(self.soldierCountText);self.soldierCountText=nil;
_UIObject_release(self.soldierModel);self.soldierModel=nil;
_UIObject_release(self.targetFightBG);self.targetFightBG=nil;
_UIObject_release(self.targetFightDesc);self.targetFightDesc=nil;
_UIObject_release(self.targetFightText);self.targetFightText=nil;
_UIObject_release(self.tipsTextImg);self.tipsTextImg=nil;
_UIObject_release(self.topMask);self.topMask=nil;
_UIObject_release(self.yzModel);self.yzModel=nil;
end
















local _this
local _dzItemCmpIndex=
{
name=0,
fight=1,
stateName=2,
head=3,
color=4,
job=5,
mask=6,
root=7,
stateImg=8,
self=9,
panel=10,
state=11,
tianminObj=12,
banFlag=13,
ban=14,
leaderFlag=15,
back_xianmo=16,
spDzFlag=17,
}

local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local diziabname='ui/windows/disciple/sharedtextures/uidisciplecolorframeicons.ab'
local ColorToFrame={
[eQualityColor.eGreen]='frame_dzkplvse',
[eQualityColor.eBlue]='frame_dzkplanse',
[eQualityColor.ePurple]='frame_dzkpzise',
[eQualityColor.eOrange]='frame_dzkpchengse',
[eQualityColor.eRed]='frame_dzkphongse',
}

local _jobPanelCmpIndex={
jobIcon=0,
jobName=1,
playerName=2,
attrList=3,
attrTips=4,
attrPanel=5,
descPanel=6,
descText=7,
}




function UIXianJie_YunZhouPrepareWin:onLoaded(...)
_this=self
self:bindComponents()
self:addProNotify(40,1,self.on_40_1)
self:addNotify(notifyConfig.on_money_changed,function(...)
self:onMoneyChanged(...)
end)
end


function UIXianJie_YunZhouPrepareWin:__delete()
if self.isShowMoney then
self:closeWindow('UITopMoneyWin2')
end
_this=nil
self:unbindComponents()
end




function UIXianJie_YunZhouPrepareWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.bgModel:setChildUIModelShowTarget(5713,1,{},eAnimationID.stand)
end

self.closeByCloud=argtable.closeByCloud or false
self.closeByCloudDelay=argtable.closeByCloudDelay
self.closeByCloudAuto=argtable.closeByCloudAuto
self.dontCloseStage=argtable.dontCloseStage
self.isFullOpen=argtable.isFullOpen
self.cancelCallBack=argtable.cancelCallBack
self.actorTeam=argtable.actorTeam
self.enterTxt=argtable and argtable.enterTxt
self.callback=argtable and argtable.callback
local extraCost=argtable and argtable.extraCost or{}
local customCost=argtable and argtable.customCost or nil
self.wayTime=argtable and argtable.wayTime
self.orderType=argtable and argtable.orderType
self.minSoldierNum=argtable and argtable.minSoldierNum
self.maxSoldierNum=argtable and argtable.maxSoldierNum
self.minDzNum=argtable and argtable.minDzNum
self.maxDzNum=argtable and argtable.maxDzNum
self.selectYzIndex=argtable and argtable.selectYzIndex
self.defaultDzList=argtable and argtable.defaultDzList
self.defaultSoldierList=argtable and argtable.defaultSoldierList
self.extraSoldierList=argtable and argtable.extraSoldierList
self.isIgnoreCheckFreeTeam=argtable and argtable.isIgnoreCheckFreeTeam
self.isIgnoreCheckCost=argtable and argtable.isIgnoreCheckCost
self.confirmBtnStr=argtable and argtable.confirmBtnStr or"云舟出战"
self.isCheckSMDData=argtable and argtable.isCheckSMDData
self.smdId=argtable and argtable.smdId
self.isYBDSet=argtable and argtable.isYBDSet
self.targetFight=argtable and argtable.targetFight
self.confirmCheckFunc=argtable and argtable.confirmCheckFunc
if argtable and argtable.isCheckYBDData~=nil then
self.isCheckYBDData=argtable.isCheckYBDData
else
self.isCheckYBDData=true
end
self.isIgnoreYz=argtable and argtable.isIgnoreYz
self.isIgnoreYzOccupy=argtable and argtable.isIgnoreYzOccupy
self.isOnlyEditTeam=argtable and argtable.isOnlyEditTeam
if self.isOnlyEditTeam then
self.isIgnoreCheckFreeTeam=true
self.isIgnoreCheckCost=true
self.isCheckYBDData=false
end
if argtable and argtable.isShowMoney~=nil then
self.isShowMoney=argtable.isShowMoney
else
self.isShowMoney=true
end
if argtable and argtable.isAutoSetFirstTeam~=nil then
self.isAutoSetFirstTeam=argtable.isAutoSetFirstTeam
else
if self.isYBDSet or self.isOnlyEditTeam or self.isCheckSMDData or self.defaultDzList or self.selectYzIndex or self.isIgnoreYz then
self.isAutoSetFirstTeam=false
else
self.isAutoSetFirstTeam=true
end
end

if self.isAutoSetFirstTeam then
local req,yzId=xianjieModel:checkAndSetXJIsHasFirstTeam()
if req then
self.selectYzIndex=yzId
end
end

local soldierCountList,allSoldierCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy,self.extraSoldierList)
self.soldierCountList=soldierCountList
self.allSoldierCount=allSoldierCount

self.allCostList={}
if self.orderType and not self.isIgnoreCheckCost then
local orderCfg=xianjieModel:getOrderConfig(self.orderType)
local czCost=customCost or orderCfg[4]or defaultT
local costIndexLookup={}

for i,v in ipairs(czCost)do
local itemId=v[1]
local itemCount=v[2]
local index=costIndexLookup[itemId]
if index and self.allCostList[index]then
self.allCostList[index][2]=self.allCostList[index][2]+itemCount
else
index=#self.allCostList+1
self.allCostList[#self.allCostList+1]={itemId,itemCount}
costIndexLookup[itemId]=index
end
end
for i,v in ipairs(extraCost)do
local itemId=v[1]
local itemCount=v[2]
local index=costIndexLookup[itemId]
if index and self.allCostList[index]then
self.allCostList[index][2]=self.allCostList[index][2]+itemCount
else
index=#self.allCostList+1
self.allCostList[#self.allCostList+1]={itemId,itemCount}
costIndexLookup[itemId]=index
end
end
end

if self.isShowMoney then
local moneyTypeList={}
for i,v in ipairs(self.allCostList)do
local itemId=v[1]
moneyTypeList[#moneyTypeList+1]={itemId}
end
if next(moneyTypeList)then
local canvasIndex=5
self:showWindow("UITopMoneyWin2",{moneys=moneyTypeList,offsetX=0,offsetY=-25,canvasIndex=canvasIndex})
else
self.isShowMoney=false
end
end


self:initDefaultSelectYz()

self:refreshTeamDzList()

self:initDefaultSelectSoldier()

self:refresh()


self:refreshSoldierModel(true)


self:refreshFatigue()
end


function UIXianJie_YunZhouPrepareWin:onHide()

end

function UIXianJie_YunZhouPrepareWin:initDefaultSelectYz()
local needLoadLastSelectYz=self.selectYzIndex==nil and not self.isIgnoreYz

local lastSelectData=xianjieModel:getXJYZLastChuZhenTeamData()
if lastSelectData then
if needLoadLastSelectYz and lastSelectData.yzIndex then

local chuZhengDzList=xianjieModel:getXJYZChuZhenTeamList(lastSelectData.yzIndex)
local isUsing=chuZhengDzList~=nil and not next(chuZhengDzList)~=nil
if not isUsing and self.isCheckSMDData then

local yzSMDId=xianjieModel:GetYetYunzhou(lastSelectData.yzIndex)
if yzSMDId~=0 and yzSMDId~=self.smdId then
isUsing=true
end
end

if not isUsing then
self.selectYzIndex=lastSelectData.yzIndex
elseif not self.isCheckSMDData then

local freeYzId=xianjieModel:getXJFreeAndHasTeamYzIndex()
self.selectYzIndex=freeYzId
end
end
elseif not self.selectYzIndex and self.isAutoSetFirstTeam then

local freeYzId=xianjieModel:getXJFreeAndHasTeamYzIndex()
self.selectYzIndex=freeYzId
end
end

function UIXianJie_YunZhouPrepareWin:initDefaultSelectSoldier()
local needLoadLastSelectSoldier=true

if self.defaultSoldierList and next(self.defaultSoldierList)then
local soldierList={}
local selectCount=0
for soldierId,count in pairs(self.defaultSoldierList)do
if soldierList[soldierId]then
soldierList[soldierId]=soldierList[soldierId]+count
else
soldierList[soldierId]=count
end
selectCount=selectCount+count
end

if not self.maxSelectCount then
self:initMaxSelectCount()
end

if self.isYBDSet then

local isEnough=true
for soldierId,count in pairs(soldierList)do
local hasCount=self.soldierCountList[soldierId]
if hasCount<count then
isEnough=false
break
end
end

if not isEnough then
UIManager.error("修士不足，请重新设置")
soldierList={}
end
end

self.soldierSelectList=xianjieModel:getSoldierSelectListWithMaxSelectCnt(self.maxSelectCount,soldierList)

self.defaultSoldierList=nil
needLoadLastSelectSoldier=false
end

local lastSelectData=xianjieModel:getXJYZLastChuZhenTeamData()
if lastSelectData then
if needLoadLastSelectSoldier and lastSelectData.soldierSelectList and next(lastSelectData.soldierSelectList)then
local list={}
for soldierId,count in pairs(lastSelectData.soldierSelectList)do
local maxCount=self.soldierCountList[soldierId]
if count>0 then
if count>maxCount then
list[soldierId]=maxCount
else
list[soldierId]=count
end
end
end
self.soldierSelectList=list
end
end
end

function UIXianJie_YunZhouPrepareWin:refresh()

self:refreshTopPanel()


self:refreshBottomPanel(true)

self:refreshJobPanel()


if self.enterTxt then
self.selectText:setText(self.enterTxt)
end
end

function UIXianJie_YunZhouPrepareWin:refreshTopPanel()

local dzFightList={}
if self.teamDzList and next(self.teamDzList)then
for i,v in ipairs(self.teamDzList)do
local dzGuidStr=tostring(v.dzGuid)
local netdata=UIDiscipleModel:getDiscipleData(v.dzGuid)
local fightValue=0
if netdata then
fightValue=UIDiscipleModel:getDiscipleFightValue(v.dzGuid)
end
dzFightList[dzGuidStr]=fightValue
end
end
local soldierList={}
if self.soldierSelectList and next(self.soldierSelectList)then
for soldierIdx,count in pairs(self.soldierSelectList)do
if count>0 then
soldierList[soldierIdx]=count
end
end
end
local jzAttrList={}
local yzId=self.selectYzIndex
if yzId then
local yzAttrLookUp=XianYunGangModel:getYunZhouComponentsAttrsLookup(yzId)
for attrId,value in pairs(yzAttrLookUp)do
jzAttrList[attrId]=value
end
end

local attrTypeList={
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
}

local sceneIdx=xianjieModel:getSceneIndex()
for i,attrType in ipairs(attrTypeList)do
local value=xianjieModel:getJZAttrLookup(attrType,sceneIdx)
if value then
if jzAttrList[attrType]then
jzAttrList[attrType]=jzAttrList[attrType]+value
else
jzAttrList[attrType]=value
end
end
end

local fightValue=xianjieModel:getXJYZTeamFightValue(dzFightList,soldierList,jzAttrList)
self.fightText:setText(mathHelper.formatNumber3(fightValue))

self.targetFightBG:setActive(self.targetFight~=nil)
if self.targetFight~=nil then

local fightDesc=""
if self.targetFight<fightValue*0.7 then
fightDesc=FMT.cfmt1(FONT_COLOR.eGreenColor,"敌军不堪一击")
elseif self.targetFight<=fightValue*1.2 then
fightDesc=FMT.cfmt1(FONT_COLOR.eWhiteColor,"敌军势均力敌")
else
fightDesc=FMT.cfmt1(FONT_COLOR.eRedColor,"敌军不可力敌")
end
self.targetFightDesc:setText(fightDesc)
end

self:refreshYZModel()
end

function UIXianJie_YunZhouPrepareWin:refreshYZModel()

local yzId=self.selectYzIndex
if yzId and yzId>0 then
self.yzModel:setActive(true)
self.shipName:setActive(true)

local boatCfg=cfgHelper.get1(cfg_fairylandboatconfig_get,yzId)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.yzModel:getID(),false,true,false)
local scale=boatCfg.modelUIParams[1]
local selectId=UISettingModel:getCurSettingId_Type(KUANGE_TYPE.yunzhou)
local settingcfg=UISettingConfig.getCfg(KUANGE_TYPE.yunzhou,selectId)
self.yzModel:setChildUIModelShowTarget(settingcfg.modelId,scale*0.5,nil,eAnimationID.stand)

local buildName=boatCfg.name
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,boatCfg.build_id)
if bdData and bdData.name then
buildName=bdData.name
end
self.shipName:setText(buildName)
else
self.yzModel:setActive(false)
self.shipName:setActive(false)

end
end

function UIXianJie_YunZhouPrepareWin:refreshBottomPanel(isInit)

local teamDzList=self.teamDzList
local teamDzList_lookup=self.teamDzList_lookup
local originalMaxSelectCount=self.maxSelectCount
self:initMaxSelectCount()
if self.maxSelectCount~=originalMaxSelectCount and self.soldierSelectList then

self.soldierSelectList=xianjieModel:getSoldierSelectListWithMaxSelectCnt(self.maxSelectCount,self.soldierSelectList)
end

local dzCount=#teamDzList
local addDzFightValue=0
self.discipleScrollView:setChildScrollViewCreateGrids(dzCount,dzCount)
local grids=self.discipleScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local teamDzData=teamDzList[i]
local guid=teamDzData.dzGuid
local netdata=UIDiscipleModel:getDiscipleData(guid)
if not netdata then
widget:SetChildActive(-1,false)
else
widget:SetChildActive(-1,true)


widget:SetChildText(_dzItemCmpIndex.name,UIDiscipleModel:getDiscipleName(guid))

local fightValue=UIDiscipleModel:getDiscipleFightValue(guid)
addDzFightValue=addDzFightValue+fightValue
widget:SetChildText(_dzItemCmpIndex.fight,FMT.fmt('<color=#7d3b17>战</color> {0}',fightValue))



local dzState,stateStr=xianjieModel:getDZState(guid,true)
local isOccupy=dzState~=nil
if isOccupy and not self.isOnlyEditTeam then

widget:SetChildText(_dzItemCmpIndex.stateName,stateStr)
widget:SetChildActive(_dzItemCmpIndex.state,true)
else
widget:SetChildActive(_dzItemCmpIndex.state,false)
end

comHelper.setChildModelRawImage(widget,guid,_dzItemCmpIndex.head,0,eHeadCenterType.eHalf)

local color=UIDiscipleModel:getDiscipleColor(guid)
widget:SetChildCSImageSprite(_dzItemCmpIndex.color,diziabname,ColorToFrame[color])

local jobIcon=UIDiscipleModel:getJobIconNameX(guid)
widget:SetChildCSImageSprite(_dzItemCmpIndex.job,globalab,jobIcon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
widget:SetChildActive(_dzItemCmpIndex.spDzFlag,isSpDz)

UIDiscipleController.refreshCommonItemTianMing(widget,netdata,_dzItemCmpIndex.tianminObj)

UIDiscipleModel:setDiscipleXianMoBackImage(widget,_dzItemCmpIndex.back_xianmo,netdata)


widget:SetChildActive(_dzItemCmpIndex.leaderFlag,false)


widget:SetChildButtonClick(_dzItemCmpIndex.panel,function()
if not _this then return end

return self:onChangeTeamBtn()
end)
end
end


self:refreshSoldierSlider(isInit)









local isShowWayTime=self.wayTime~=nil and not self.isOnlyEditTeam
self.costTimeText:setActive(isShowWayTime)
if isShowWayTime then
local wayTime=math.ceil(self.wayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
self.costTimeText:setText(FMT.fmt("前往路程：\n{0}",time_str))
end





self:refreshCost()



local isHasDz=dzCount>0
self.buZhenBtn:setActive(not isHasDz)
self.confirmBtn:setActive(isHasDz)
self.confirmBtnText:setText(self.confirmBtnStr)

self.changeTeamBtn:setActive(isHasDz)
self.addDzBtn:setActive(not isHasDz)
self.tipsTextImg:setActive(not isHasDz)

self:refreshSoldierPanelShow()
end

function UIXianJie_YunZhouPrepareWin:refreshCost()
local isShowCost=self.allCostList and next(self.allCostList)~=nil or false
self.moneyCost:setActive(isShowCost)
if isShowCost then
local cost=self.allCostList[1]
local moneyType=cost[1]
local moneyCount=cost[2]
local hasCount=itemsModel.getCount(moneyType)


local countStr=mathHelper.formatNumber(moneyCount)
if hasCount<moneyCount then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
end
self.moneyCostCountText:setText(countStr)
self.moneyCostIcon:setIcon(iconHelper.getIconName(moneyType),false)
self.showCostMoneyType=moneyType
end
end

function UIXianJie_YunZhouPrepareWin:refreshSoldierSlider(isInit)
if not self.maxSelectCount then
self:initMaxSelectCount()
end

self.soldierSelectList=self:getSoldierSelectList()
local allSelectCnt=self:getAllSelectCnt()
local minSelectCount=0
local showMaxSelectCount=self.maxSelectCount
local canSelect=self.maxSelectCount>0
if not canSelect then
showMaxSelectCount=1
end


if isInit then
local func=function(...)
if not _this then return end
return _this:onSliderChange(...)
end
self.selectCntSlider:setChildSliderInit(allSelectCnt,minSelectCount,showMaxSelectCount,func)
else
self.selectCntSlider:setChildSliderValue(allSelectCnt)
end
self.clickMask:setActive(not canSelect)
self.selectCntText:setText(FMT.fmt("随队修士:{0}/{1}",mathHelper.formatNumber4(allSelectCnt,1),mathHelper.formatNumber4(showMaxSelectCount,1)))
end

function UIXianJie_YunZhouPrepareWin:onYunZhouTeamSelectRecv(selectYzIndex)
self.selectYzIndex=selectYzIndex
self:refreshTeamDzList()
self:refresh()
end

function UIXianJie_YunZhouPrepareWin:onSliderChange(value)
local allSelectCnt=self:getAllSelectCnt()
local showSoldierIdxList=self:getShowSoldierIdxList()
self.soldierSelectList=xianjieModel:getXJYunZhouTeamChangeSoldierSelectList(allSelectCnt,showSoldierIdxList,value,self.soldierSelectList,self.soldierCountList)


allSelectCnt=self:getAllSelectCnt()
local showMaxSelectCount=self.maxSelectCount
local canSelect=self.maxSelectCount>0
if not canSelect then
showMaxSelectCount=1
end

self.selectCntText:setText(FMT.fmt("随队修士:{0}/{1}",mathHelper.formatNumber4(allSelectCnt,1),mathHelper.formatNumber4(showMaxSelectCount,1)))

if self.delayRefreshTimer~=nil then
self:stopTimerByID(self.delayRefreshTimer)
self.delayRefreshTimer=nil
end

self.delayRefreshTimer=self:delayDo(0.2,function()
if not _this then return end

_this:refreshTopPanel()
end)


_this:refreshSoldierModel()
end

function UIXianJie_YunZhouPrepareWin:refreshSoldierCount()

local soldierCountList,allSoldierCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy,self.extraSoldierList)
self.soldierCountList=soldierCountList
self.allSoldierCount=allSoldierCount
self:initMaxSelectCount()
self.showSoldierIdxList=nil
self:refreshSoldierSlider(true)






self.soldierCountText:setText(mathHelper.formatNumber4(self.allSoldierCount,1))

self:refreshSoldierPanelShow()
end

function UIXianJie_YunZhouPrepareWin:refreshSoldierPanelShow()
local teamDzList=self.teamDzList
if teamDzList then
local dzCount=#teamDzList
local isHasDz=dzCount>0
local hasSoldier=self.maxSelectCount>0
self.selectCntSliderPanel:setActive(isHasDz and hasSoldier)
self.paibuBtn:setActive(isHasDz and hasSoldier)
self.notSoldierTips:setActive(isHasDz and not hasSoldier)
end
end

function UIXianJie_YunZhouPrepareWin:onPaiBuSetSelectListRecv(selectList)
self.soldierSelectList=table.weakCopy(selectList)


self:refreshSoldierCount()

self:refreshSoldierModel(true)
end

function UIXianJie_YunZhouPrepareWin:getSoldierSelectList()
if self.soldierSelectList then
return self.soldierSelectList
end
self.soldierSelectList=xianjieModel:getXJYunZhouTeamSoldierSelectList(self.maxSelectCount)
return self.soldierSelectList
end

function UIXianJie_YunZhouPrepareWin:getAllSelectCnt()
local allSelectCnt=0
for _,count in pairs(self.soldierSelectList)do
allSelectCnt=allSelectCnt+count
end
return allSelectCnt
end

function UIXianJie_YunZhouPrepareWin:getShowSoldierIdxList()
if self.showSoldierIdxList then
return self.showSoldierIdxList
end

local list={}
for soldierIdx,count in ipairs(self.soldierCountList)do
if count>0 then
list[#list+1]=soldierIdx
end
end

table.sort(list,function(a,b)
return a>b
end)

self.showSoldierIdxList=list
return self.showSoldierIdxList
end

function UIXianJie_YunZhouPrepareWin:checkIsEnoughCost(itemList)
if not itemList or not next(itemList)then
return true
end

for i,v in pairs(itemList)do
local itemId=v[1]
local needNum=v[2]
local haveNum=itemsModel.getCount(itemId)

if haveNum<needNum then
return false,itemId
end
end
return true
end

function UIXianJie_YunZhouPrepareWin:initMaxSelectCount()

local tsdMaxUseCount=xianjieModel:getJiJieAddCount()







if tsdMaxUseCount then
local dzCount=self.teamDzList and#self.teamDzList or 0
self.maxSelectCount=math.min(tsdMaxUseCount*dzCount,self.allSoldierCount)
else
self.maxSelectCount=self.allSoldierCount
end

if self.maxSoldierNum then
self.maxSelectCount=math.min(self.maxSelectCount,self.maxSoldierNum)
end
end

function UIXianJie_YunZhouPrepareWin:refreshSoldierModel(isInit)
local soldierList={}
local allSoldierCount=0
local maxSoldierLvId
if self.soldierSelectList and next(self.soldierSelectList)then
for soldierId,count in pairs(self.soldierSelectList)do
if count>0 then
allSoldierCount=allSoldierCount+count
if not maxSoldierLvId or soldierId>maxSoldierLvId then
maxSoldierLvId=soldierId
end
end
end
end
local showParam=cfgHelper.get(cfg_fairylandbaseconfig_get,1,"buzhenSoldierShow")
local maxShowNum=showParam[#showParam][2]
local allShowNum=0
local lastNeedCount=0
local lastShowNum=0
for i,v in ipairs(showParam)do
local needCount=v[1]
local showNum=v[2]
if allSoldierCount>=needCount then
allShowNum=showNum
lastNeedCount=needCount
lastShowNum=showNum
else
local deltaNum=showNum-lastShowNum
local deltaCount=needCount-lastNeedCount
local overCount=allSoldierCount-lastNeedCount
local overNum=overCount*deltaNum/deltaCount
allShowNum=allShowNum+overNum
break
end
end


local percent=allShowNum/maxShowNum
if percent>1 then
percent=1
end
if isInit then
maxSoldierLvId=maxSoldierLvId or 1
local jzCfg=cfgHelper.get(cfg_jzconfig_get,maxSoldierLvId)
local abName=jzCfg.uiModel
self.winlua:SetChildTroop(self.soldierModel:getID(),abName,maxShowNum,percent,function()
return
end)
else
self.winlua:SetChildTroopProgress(self.soldierModel:getID(),percent)
end

self.testValueParam={allShowNum=allShowNum,percent=percent}
end

function UIXianJie_YunZhouPrepareWin:onDzTeamSelectRecv(teamList)
local list={}
for posIdx,dzGuidStr in pairs(teamList)do
local dzGuid=int64.new(dzGuidStr)
list[posIdx]=dzGuid
end
self.defaultDzList=list
self:refreshTeamDzList()
self:refresh()
end

function UIXianJie_YunZhouPrepareWin:refreshTeamDzList()
local yzData
if self.selectYzIndex then

yzData=xianjieModel:getXJYunZhouDataByYzIdx(self.selectYzIndex)
end

local teamDzList={}
local teamDzList_lookup

if self.defaultDzList and next(self.defaultDzList)then
teamDzList_lookup={}
for poxIdx,dzGuid in ipairs(self.defaultDzList)do
if not mathHelper.compareInt64(dzGuid,Int64_0)then
teamDzList[#teamDzList+1]={
posIdx=poxIdx,
dzGuid=dzGuid,
}
local dzGuidStr=tostring(dzGuid)
teamDzList_lookup[poxIdx]=dzGuidStr
end
end
self.defaultDzList=nil
else
teamDzList_lookup=yzData and yzData.team or nil
local hasTeam=teamDzList_lookup~=nil and next(teamDzList_lookup)~=nil
if hasTeam then
for idx,dzGuidStr in pairs(teamDzList_lookup)do
local dzGuid=int64.new(dzGuidStr)
teamDzList[#teamDzList+1]={
posIdx=idx,
dzGuid=dzGuid,
}
end
end
end

self.teamDzList=teamDzList
self.teamDzList_lookup=teamDzList_lookup
end

function UIXianJie_YunZhouPrepareWin:onMoneyChanged(moneyType)
if moneyType==self.showCostMoneyType then
return self:refreshCost()
end
end




function UIXianJie_YunZhouPrepareWin:onCancelButton()





roleAudioController:stopRoleSpeak()
self:onCloseFunc()
end



function UIXianJie_YunZhouPrepareWin:onBuZhenBtn()
return self:onChangeTeamBtn()
end



function UIXianJie_YunZhouPrepareWin:onConfirmBtn(ignoreConfirmCheckFunc,sendArgs)


if#self.teamDzList<=0 then

return UIManager.error("当前未选择上阵弟子")
end

local soldierSelectList=self.soldierSelectList
local teamDzList_lookup=self.teamDzList_lookup
local orderCfg
local needYzType
local needSoldierType

if self.orderType and not self.isOnlyEditTeam then
orderCfg=xianjieModel:getOrderConfig(self.orderType)
needYzType=orderCfg[2]
needSoldierType=orderCfg[3]

if needYzType==0 and next(teamDzList_lookup)then
return UIManager.error("当前出征不能上阵弟子")
elseif needYzType==2 and not next(teamDzList_lookup)then
return UIManager.error("当前出征必须上阵弟子")
end
end

local hasYBDDz=false
local dzCount=0
local dzGuidList={}
for i=1,5 do
local guidStr=teamDzList_lookup[i]
local guid
if not guidStr or guidStr==""then
guid=Int64_0
else
guid=int64.new(guidStr)

local dzState,stateStr=xianjieModel:getDZState(guid,true)
local isOccupy=dzState~=nil
if isOccupy and not self.isOnlyEditTeam then
return UIManager.error(FMT.fmt("队伍中存在{0}弟子，无法出征",stateStr))
end

local isYBDDz=xianjieModel:checkJiJieYBDData_dzIsInYBD(guid)
if isYBDDz then
hasYBDDz=true
end
dzCount=dzCount+1
end
dzGuidList[i]=guid
end

local soldierCfgList=cfg_fairylandsoldierconfig()
local moneyList={}
local allSoldierCount=0
for soldierIdx,count in pairs(soldierSelectList)do
local cfg=soldierCfgList[soldierIdx]
if cfg and count>0 then
local moneyType=cfg.money[xjSoldierHurtType.eHealthy]

local hasCount=itemsModel.getCount(moneyType)
if hasCount>=count then
moneyList[#moneyList+1]={moneyType,count}
allSoldierCount=allSoldierCount+count
else
self.soldierSelectList={}
self:refreshSoldierCount()
self:refreshSoldierModel(true)
return UIManager.error("当前队伍修士不足，请重新设置")
end
end
end

if self.orderType and not self.isOnlyEditTeam then
if needSoldierType==0 and allSoldierCount>0 then
return UIManager.error("当前出征不能上阵修士")
elseif needSoldierType==2 and allSoldierCount<=0 then
return UIManager.error("当前出征必须上阵修士")
end
end

if self.minDzNum and dzCount<self.minDzNum then
return UIManager.error(FMT.fmt("最少上阵{0}名弟子",self.minDzNum))
end
if self.maxDzNum and dzCount>self.maxDzNum then
return UIManager.error(FMT.fmt("最多上阵{0}名弟子",self.maxDzNum))
end

if self.minSoldierNum and allSoldierCount<self.minSoldierNum then
return UIManager.error(FMT.fmt("至少上阵{0}个修士",mathHelper.formatNumber4(self.minSoldierNum,1)))
end

local needCheckFreeTeam=orderCfg and orderCfg[5]or nil
if needCheckFreeTeam==1 and not self.isIgnoreCheckFreeTeam then


local allTeamCount=xianjieModel:getWaiPaiTeamMaxNum()

local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
local doingTeamCount=#teamHandleList
local freeTeamCount=allTeamCount-doingTeamCount
if freeTeamCount<=0 then

local unlockTeamCount=xianjieModel:getWaiPaiTeamUnlockNum()
local maxExtraTeamCount=xianjieModel:getWaiPaiTeamMaxExtraNum()
if unlockTeamCount<maxExtraTeamCount then

local args={}
args.titleName='队伍拓展'
args.showClose=false
args.pos=2
args.extraWin='UIXianJie_extraTeamGainWin'


local extraParams={}
args.extraParams=extraParams

self:showWindow('UICommonPageWin',args)
end

return UIManager.error("当前没有空闲行军队列")
end
end

if not self.isIgnoreCheckCost then

local isEnough,itemId=self:checkIsEnoughCost(self.allCostList)
if not isEnough then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
return
end
end

local yzId=self.selectYzIndex
if not yzId and not self.isIgnoreYz then
return UIManager.error("当前未选择云舟")
end

local ybdYzLookup=xianjieModel:getJiJieYBDData_yzIdLookup()
local isYBDYz=ybdYzLookup and ybdYzLookup[yzId]or false

local func=function()
if not _this.isYBDSet and not _this.isOnlyEditTeam then

xianjieModel:setXJYZLastChuZhenTeamData(yzId,soldierSelectList)
xianjieModel:saveXJYZLastChuZhenTeamData()
end

if _this.callback then
local cb=_this.callback
cb(dzGuidList,moneyList,yzId,sendArgs)
return _this:onCancelButton()
end
end

if not ignoreConfirmCheckFunc and self.confirmCheckFunc then
local ccFunc=self.confirmCheckFunc
local ret,errType,param=ccFunc()
if not ret then
if errType==1 then

return self:onCancelButton()
elseif errType==2 then

local isEnough=param.isEnough
local showdata

























































































local okFunc=function()
if not _this then return end
return _this:onConfirmBtn(true)
end
showdata={
type='UIDialouge',
title='提示',
content="前往集结时间不足，前往集结将超时，是否参与集结？",
oktext='继续前往',
canceltext='取消',
allowclickBG=true,
okcallback=okFunc,
showclosebtn=true,
}

self.confirmDialog=UIDialogManager.newDialog(showdata)
self.confirmDialog:show()
end
return
end
end

if self.isCheckYBDData and(isYBDYz or hasYBDDz)then
local contentStr
if isYBDYz then
contentStr="当前云舟为预备队所使用的云舟\n出征后预备队将暂时失效\n是否确认继续？"
elseif hasYBDDz then
contentStr="存在预备队队伍弟子\n出征后预备队将暂时失效\n是否确认继续？"
end















UIDialogManager.getConfirmDialog3(nil,contentStr,func,REPEAT_TYPE.eXianJieJiJieEndGo)
else
return func()
end
end



function UIXianJie_YunZhouPrepareWin:onChangeTeamBtn()
local args={
isCheckSMDData=self.isCheckSMDData,
smdId=self.smdId,
}
if not self.isIgnoreYz then
local isHasYunZhou=xianjieModel:checkXJHasYunZhou()
if not isHasYunZhou then
UIManager.error("当前没有可用云舟")
local cb=function()
if not _this then return end
_this.cancelCallBack=nil
return _this:onCancelButton()
end

return jumpManager:jump({id=JUMP_TYPE.eBuilding,args={
type=SLG_SYSTEM_TYPE.eXianYunGang,
mapid=mapIdType.fort,
scenetype=eSceneType.eZongmen
}},cb)
end
args.isIgnoreYzOccupy=self.isIgnoreYzOccupy
args.isOnlyEditTeam=self.isOnlyEditTeam

self:showWindow("UIXianJie_YunZhouSelectWin",args)
else

args.isIgnoreYz=self.isIgnoreYz
args.isOnlyEditTeam=self.isOnlyEditTeam
self:showWindow("UIXianJie_yzTeamSelectWin",args)
end
end



function UIXianJie_YunZhouPrepareWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.eYunZhouTeam
local langId=ruleLangIdList and ruleLangIdList[ruleType]or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end



function UIXianJie_YunZhouPrepareWin:onPaibuBtn()
local selectList=table.weakCopy(self.soldierSelectList)
local extraSoldierList=table.weakCopy(self.extraSoldierList)
local orderType=self.orderType
local dzCount=self.teamDzList and#self.teamDzList or 0
local isYBDSet=self.isYBDSet
local maxSoldierNum=self.maxSoldierNum
self:showWindow("UIXianJie_yzSoldierPaiBuWin",{
selectList=selectList,
extraSoldierList=extraSoldierList,
orderType=orderType,
dzCount=dzCount,
isYBDSet=isYBDSet,
maxSoldierNum=maxSoldierNum,
})
end

function UIXianJie_YunZhouPrepareWin:onCloseFunc()
local closeByCloud=self.closeByCloud
local closeByCloudDelay=self.closeByCloudDelay
local closeByCloudAuto=self.closeByCloudAuto
if closeByCloudAuto==nil and closeByCloudDelay==nil then
closeByCloudDelay=1
end
local func=function()
if self and not self.isClose then
self:onCancelFunc()
end
end
if closeByCloud then
loadingControl.openCloud(func,closeByCloudDelay,closeByCloudAuto)
else
func()
end
end

function UIXianJie_YunZhouPrepareWin:onCancelFunc()
local isFullOpen_=self.isFullOpen
local cb=self.cancelCallBack
if isFullOpen_ and(not self.dontCloseStage)then
UIFullFightPrepareControl:closeActiveUI()

else
UIManager:closeWindow('UIXianJie_YunZhouPrepareWin')

end
if cb then
cb()
end
end

function UIXianJie_YunZhouPrepareWin:onAddDzBtn()
return self:onChangeTeamBtn()
end

function UIXianJie_YunZhouPrepareWin:onHelpButton()
instructionbookController:jumpTo(INSTRUCTIONBOOK_JUMP_TYPE.eUIJunZhenZhanDouWin)
end

function UIXianJie_YunZhouPrepareWin:onGotoYJYBtn()

local cb=function()
if not _this then return end
_this.cancelCallBack=nil
return _this:onCancelButton()
end
return jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eYunJiaYing,mapid=mapIdType.fort,scenetype=eSceneType.eZongmen}},cb)
end

function UIXianJie_YunZhouPrepareWin:onChangeShipPanel()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eSetting_YunZhou,{itemId=-1},true)
end


function UIXianJie_YunZhouPrepareWin.test_printSoliderShowNum()
if not _this then return end
local allShowNum=_this.testValueParam and _this.testValueParam.allShowNum or 0
local percent=_this.testValueParam and _this.testValueParam.percent or 0

end

function UIXianJie_YunZhouPrepareWin.test_printJzAttrList()
if not _this then return end
local jzAttrList={}
local yzId=_this.selectYzIndex
if yzId then
local yzAttrLookUp=XianYunGangModel:getYunZhouComponentsAttrsLookup(yzId)
for attrId,value in pairs(yzAttrLookUp)do
jzAttrList[attrId]=value
end
end

local attrTypeList={
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
}
local sceneIdx=xianjieModel:getSceneIndex()
for i,attrType in ipairs(attrTypeList)do
local value=xianjieModel:getJZAttrLookup(attrType,sceneIdx)
if value then
if jzAttrList[attrType]then
jzAttrList[attrType]=jzAttrList[attrType]+value
else
jzAttrList[attrType]=value
end
end
end


end

function UIXianJie_YunZhouPrepareWin:refreshJobPanel()
local jijieXianGuanList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"jijieXianGuan")
local showDatas={}
if jijieXianGuanList then










for _,v in ipairs(jijieXianGuanList)do
local jobType=v[1]
local privilegeId=v[2]
local jobInfoList=xianguanModel:getJobInfoListByJobType(jobType)
local isShowAttr=v[3]and v[3]==1 or false
local isBuZhenShow=self.orderType and table.containsValue(v[4],self.orderType)or false
if isBuZhenShow then
for _,jobInfo in ipairs(jobInfoList)do
local actorId=jobInfo.actorid
local jobId=jobInfo.jobId
if actorId then
local actorName=jobInfo.actorname

local isSelf=playerModel:checkActorId(actorId)
local isHasTq=xianguanConfig.checkJobCfgHasTeQuan(jobId,privilegeId)
if isHasTq and isSelf then

if xianguanHelper.checkTeQuanPlatformLimit(privilegeId)and xianguanHelper.checkSpecialUseCondition(jobId,privilegeId,false)then
table.insert(showDatas,{jobId,privilegeId,actorName,isShowAttr})
end
end
end
end
end
end
end
if#showDatas>0 then
self:showJobPanel(showDatas)
else
self.jobPanel:setActive(false)
end
end

function UIXianJie_YunZhouPrepareWin:showJobPanel(showDatas)
local jobId=showDatas[1][1]
local actorName=showDatas[1][3]
local attrList={}
local descStr=nil
for i,v in ipairs(showDatas)do
local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,v[2])
if v[4]then
attrList=privilegeCfg.attrDesc or{}
else
descStr=descStr and FMT.fmt("{0}\n{1}",descStr,privilegeCfg.descEx)or privilegeCfg.descEx
end
end

self.jobPanel:setActive(true)
local jobWidget=self.jobPanel:getChildWidgetBase()
local jobCfg=cfgHelper.get1(cfg_xianguanconfig_get,jobId)

local jobIconName=xianguanConfig.getJobIconName(jobCfg.jobIcon)
jobWidget:SetChildCSImageSprite(_jobPanelCmpIndex.jobIcon,globalABLookup.xianguan,jobIconName)
jobWidget:SetChildText(_jobPanelCmpIndex.jobName,FMT.fmt("【{0}】",jobCfg.name))
jobWidget:SetChildText(_jobPanelCmpIndex.playerName,actorName)

local showAttr=#attrList>0
jobWidget:SetChildActive(_jobPanelCmpIndex.attrPanel,showAttr)
if showAttr then
jobWidget:SetChildLayoutGroupCreateItems(_jobPanelCmpIndex.attrList,#attrList,function(index)
local item=jobWidget:GetChildLayoutGroupGridItem(3,index-1)
item:SetChildText(0,attrList[index])
end)
end
local showDesc=descStr~=nil
jobWidget:SetChildActive(_jobPanelCmpIndex.descPanel,showDesc)
if showDesc then
jobWidget:SetChildText(_jobPanelCmpIndex.descText,descStr)
end














end

function UIXianJie_YunZhouPrepareWin.on_40_1()
_this:refreshJobPanel()
end

function UIXianJie_YunZhouPrepareWin:refreshFatigue()
local isShow=self.orderType==xjOrderType.eAttackRole

local desc=''
local pvpNightBattleFatigue=cfg_globalconfig_get(1).pvpNightBattleFatigue
if pvpNightBattleFatigue and next(pvpNightBattleFatigue)then
local startHour,endHour=unpack(pvpNightBattleFatigue[2])
if not timeHelper.isCurrentHourBetween(startHour,endHour-1)then
isShow=false
end
local percent=pvpNightBattleFatigue[4]
desc=string.format("<color=#FF8D3E>【夜鏖不继】</color>夜间%d~%d点对其他祖师发起战争时，出征修士军阵攻击力<color=#f36666>-%d%%</color>",startHour,endHour,percent)
end
self.fatigueState:setActive(isShow)
if isShow then
self.fatigueDesc:setText(desc)
self.bgModel:setChildUIModelShowTarget(6359,1,{},eAnimationID.stand)
end
end
