







def_class("UIShanMenDaZhen_mainWin",UIWindowBase)









function UIShanMenDaZhen_mainWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.teamItemList=UIObject.get(self,1)
self.progressBar=UIProgress.get(self,2)
self.showPatchBtn=UIButton.get(self,3)
self.levelUpBtn=UIButton.get(self,4)
self.normalPanel=UIObject.get(self,5)
self.repairPanel=UIObject.get(self,6)
self.repairBtn=UIButton.get(self,7)
self.costScrollView=UIObject.get(self,8)
self.patchPanel=UIObject.get(self,9)
self.patchShieldBar=UIProgress.get(self,10)
self.patchBtn=UIButton.get(self,11)
self.patchCostItem=UIObject.get(self,12)
self.patchCostText=UIText.get(self,13)
self.patchAddBar=UIObject.get(self,14)
self.closePatchPanelMask=UIButton.get(self,15)
self.zmLvBtn=UIButton.get(self,16)
self.recordBtn=UIButton.get(self,17)
self.lvPreviewBtn=UIButton.get(self,18)
self.helpBtn=UIButton.get(self,19)
self.patchHandle=UIObject.get(self,20)
self.patchAddText=UIText.get(self,21)
self.skillIconList=UIObject.get(self,22)
self.skillPanel=UIObject.get(self,23)
self.patchShieldBarReverse=UIProgress.get(self,24)
self.buffPanel=UIObject.get(self,25)
self.buffIcon=UIButton.get(self,26)
self.recordReddot=UIObject.get(self,27)
self.daZhenRoot=UIObject.get(self,28)
self.buildDaZhenPanel=UIObject.get(self,29)
self.buildBtn=UIButton.get(self,30)
self.daZhenLevelText=UIText.get(self,31)
self.attrPanel=UIObject.get(self,32)
self.attrLayout=UIObject.get(self,33)
self.effect=UIObject.get(self,34)
self.breakTipsPanel=UIObject.get(self,35)
self.bgModel=UIObject.get(self,36)
self.patchReddot=UIObject.get(self,37)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.showPatchBtn:setButtonClick(function()self:onShowPatchBtn()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.repairBtn:setButtonClick(function()self:onRepairBtn()end)

self.patchBtn:setButtonClick(function()self:onPatchBtn()end)

self.closePatchPanelMask:setButtonClick(function()self:onClosePatchPanelMask()end)

self.zmLvBtn:setButtonClick(function()self:onZmLvBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.lvPreviewBtn:setButtonClick(function()self:onLvPreviewBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.buffIcon:setButtonClick(function()self:onBuffIcon()end)

self.buildBtn:setButtonClick(function()self:onBuildBtn()end)



end


function UIShanMenDaZhen_mainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.teamItemList);self.teamItemList=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.showPatchBtn);self.showPatchBtn=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.normalPanel);self.normalPanel=nil;
_UIObject_release(self.repairPanel);self.repairPanel=nil;
_UIObject_release(self.repairBtn);self.repairBtn=nil;
_UIObject_release(self.costScrollView);self.costScrollView=nil;
_UIObject_release(self.patchPanel);self.patchPanel=nil;
_UIObject_release(self.patchShieldBar);self.patchShieldBar=nil;
_UIObject_release(self.patchBtn);self.patchBtn=nil;
_UIObject_release(self.patchCostItem);self.patchCostItem=nil;
_UIObject_release(self.patchCostText);self.patchCostText=nil;
_UIObject_release(self.patchAddBar);self.patchAddBar=nil;
_UIObject_release(self.closePatchPanelMask);self.closePatchPanelMask=nil;
_UIObject_release(self.zmLvBtn);self.zmLvBtn=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.lvPreviewBtn);self.lvPreviewBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.patchHandle);self.patchHandle=nil;
_UIObject_release(self.patchAddText);self.patchAddText=nil;
_UIObject_release(self.skillIconList);self.skillIconList=nil;
_UIObject_release(self.skillPanel);self.skillPanel=nil;
_UIObject_release(self.patchShieldBarReverse);self.patchShieldBarReverse=nil;
_UIObject_release(self.buffPanel);self.buffPanel=nil;
_UIObject_release(self.buffIcon);self.buffIcon=nil;
_UIObject_release(self.recordReddot);self.recordReddot=nil;
_UIObject_release(self.daZhenRoot);self.daZhenRoot=nil;
_UIObject_release(self.buildDaZhenPanel);self.buildDaZhenPanel=nil;
_UIObject_release(self.buildBtn);self.buildBtn=nil;
_UIObject_release(self.daZhenLevelText);self.daZhenLevelText=nil;
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.attrLayout);self.attrLayout=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.breakTipsPanel);self.breakTipsPanel=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.patchReddot);self.patchReddot=nil;
end
















local _this
local btnCmpIndex={
btnBg1=0,
btnBg2=1,
textLayout=2,
cndFinishText=3,
btnText=4,
timePanel=5,
timeText=6,
reddot=7
}




function UIShanMenDaZhen_mainWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.building_event,function(...)self:on_building_event(...)end)
end


function UIShanMenDaZhen_mainWin:__delete()
self:clearLevelUpTimer()

self:closeWindow("UITopMoneyWin2")
_this=nil
self:unbindComponents()
end




function UIShanMenDaZhen_mainWin:onShow(argtable,afterOnloaded)

self:showWindow("UITopMoneyWin2",{moneys={{eMoneyType.mtZhenShi}},offsetX=0,offsetY=-24})
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5419,1,{},eAnimationID.stand)
end
self:refresh(true)
end

function UIShanMenDaZhen_mainWin:onShowArgRecv(argtable,afterOnloaded)
self:refresh(true)
end


function UIShanMenDaZhen_mainWin:onHide()
self:clearLevelUpTimer()

self:closeWindow("UITopMoneyWin2")
end

function UIShanMenDaZhen_mainWin:refresh(isInit)
self:refreshDaZhenEffect(isInit)
self:refreshTeamPanel(isInit)
self:refreshBottomPanel(isInit)
self:refreshAttrPanel(isInit)
self:refreshBuffPanel(isInit)
self:refreshSkillPanel(isInit)
self:refreshRecordBtn()
end

function UIShanMenDaZhen_mainWin:refreshDaZhenEffect(isInit)

local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local daZhenLv=buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local state=shanMenDaZhenModel:getDaZhenState()
local isBreak=state==3
local effectId
if not isBreak then

effectId=daZhenLvCfg.dazhenUIEffectId[1]
else

effectId=daZhenLvCfg.dazhenUIEffectId[2]
end
if effectId then
if not self.effectId or effectId~=self.effectId then
self.effectId=effectId
self.effect:setChildShowEffect(effectId,true)
end
else
self.effect:setChildShowEffect(0,false)
end
end

function UIShanMenDaZhen_mainWin:refreshTeamPanel(isInit)
local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local daZhenLv=buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local unlockTeamCount=daZhenLvCfg.team
local teamGrids=self.teamItemList:getChildCommonLayoutGroupWidgetList()
local defaultPos={[1]={0,-80},[2]={250,140},[3]={-250,140}}
local teamShowParam=daZhenLvCfg.teamShowParam or{}
local showTeamCount=teamShowParam.showCount or 3
for i=1,teamGrids.Count do
local gridsIndex=teamGrids.Count-i+1
local widget=teamGrids[gridsIndex-1]
if i<=showTeamCount then
widget:SetChildActive(-1,true)

local pos=teamShowParam.pos and teamShowParam.pos[i]or defaultPos[i]
widget:SetChildAnchoredPos(-1,pos[1],pos[2])

local teamDzList=shanMenDaZhenModel:getShanMenDaZhenTeamDiziListByTeamIndex(i)
local isLock=i>unlockTeamCount
local isTeamEmpty=shanMenDaZhenModel:checkDaZhenIsTeamEmptyByTeamIdx(i)
widget:SetChildActive(1,isLock)
if teamDzList and next(teamDzList)then
local dzGuid
local firstDzGuid
local maxInjury
for posIdx=1,5 do
if teamDzList[posIdx]and teamDzList[posIdx]~=0 and not mathHelper.compareInt64(teamDzList[posIdx],int64.new('0'))then
dzGuid=teamDzList[posIdx]
if not firstDzGuid then
firstDzGuid=dzGuid
end
local injury=UIDiscipleModel:getDiscipleInjury(dzGuid)
if not maxInjury or maxInjury<injury then
maxInjury=injury
end
end
end

if isInit then

local dzModelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(firstDzGuid,true,nil,nil)
widget:SetChildUIModelShowTarget(2,dzModelParams.body,0.9,dzModelParams.componets,eAnimationID.stand,false,false,0)
widget:SetChildUIModelShowFlipX(2,true)
end

local injury_icon=eInjuryType:getIcon(maxInjury)
local showinjury=injury_icon~=nil
widget:SetChildActive(4,showinjury)
if showinjury then
local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
widget:SetChildCSImageSprite(4,globalab,injury_icon)
end
widget:SetChildActive(6,false)
else
widget:SetChildUIModelRemoveTarget(2)
widget:SetChildActive(6,not isLock)
end


widget:SetChildActive(3,true)
if not isLock then
widget:SetChildButtonClick(3,function()

return self:openTeamWin(i)
end,true)
else
local teamUnlockLevelList=self:getTeamUnlockLevelList()
local unlockDaZhenLevel=teamUnlockLevelList[i]
local cfg=cfgHelper.get(cfg_shanmendazhenconfig_get,unlockDaZhenLevel)
widget:SetChildButtonClick(3,function()
UIManager.error(FMT.fmt("山门大阵{0}级解锁",unlockDaZhenLevel))
end,true)
end


widget:SetChildActive(5,not isLock and isTeamEmpty)
else
widget:SetChildActive(-1,false)
end
end
end

function UIShanMenDaZhen_mainWin:refreshBottomPanel(isInit)
local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local isHasDaZhen=buildLv>1
self.daZhenRoot:setActive(isHasDaZhen)
self.buildDaZhenPanel:setActive(not isHasDaZhen)
self.daZhenLevelText:setActive(isHasDaZhen)
self.progressBar:setActive(isHasDaZhen)
if isHasDaZhen then


local daZhenLevel=buildLv-1

local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLevel)
local nowShieldValue=shanMenDaZhenModel:getShanMenDaZhenShieldValue()
local maxShieldValue=daZhenLvCfg.shield
self.progressBar:setProgressValue(nowShieldValue,maxShieldValue)
self.progressBar:setChildProgressText(FMT.fmt("大阵护盾值：{0}/{1}",nowShieldValue,maxShieldValue))


local state=shanMenDaZhenModel:getDaZhenState()
local isFull=state==1
local isBreak=state==3
local beginTime=bdData.begintime

self.normalPanel:setActive(not isBreak and not self.isShowPatch)
self.repairPanel:setActive(isBreak)
self.skillPanel:setActive(not isBreak and not self.isShowPatch)
self.breakTipsPanel:setActive(isBreak)
self.closePatchPanelMask:setActive(self.isShowPatch)

if isBreak then

local costList=daZhenLvCfg.repair or{}
local costCount=#costList
self.costScrollView:setChildScrollViewCreateGrids(costCount,costCount)
local costGrids=self.costScrollView:getChildScrollViewItemWidgets()
for index=1,costGrids.Count do
local item=costGrids[index-1]
local costCfg=costList[index]
if costCfg then
local itemId=costCfg[1]
local itemNum=costCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local hasCount=itemsModel.getCount(itemId)
if showCountBG and hasCount<itemNum then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)

self:onClickCostItem(...)
end)
end
end
else
self.patchPanel:setActive(self.isShowPatch==true)
if not self.isShowPatch then
self.showPatchBtn:setActive(not isFull)
if not isFull then

local checkPatchRate=cfgHelper.getdef1(cfg_shanmendazhenconfig,'checkPatch')
local checkPatchValue=math.floor(maxShieldValue*checkPatchRate/100)
local isNeedPatch=nowShieldValue<=checkPatchValue
self.patchReddot:setActive(isNeedPatch)
end
local lvUpBtnStr="升级大阵"
local btnWidget=self.levelUpBtn:getWidgetBase()
if bdData.flag==buildingStateType.eUpgrading then
btnWidget:SetChildActive(btnCmpIndex.reddot,false)
local isComplete=buildingCDControl:isComplete(buildingCDType.build,bdData.un_build_id)
if not isComplete then

btnWidget:SetChildActive(btnCmpIndex.btnBg1,false)
btnWidget:SetChildActive(btnCmpIndex.btnBg2,true)
btnWidget:SetChildActive(btnCmpIndex.textLayout,false)
btnWidget:SetChildActive(btnCmpIndex.timePanel,true)


local cdd=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
btnWidget:SetChildText(btnCmpIndex.timeText,timeHelper.format_time_stamp10(cdd.cd,true))
self:setLevelUpTimer()
else

btnWidget:SetChildActive(btnCmpIndex.btnBg1,true)
btnWidget:SetChildActive(btnCmpIndex.btnBg2,false)
btnWidget:SetChildActive(btnCmpIndex.textLayout,true)
btnWidget:SetChildActive(btnCmpIndex.cndFinishText,false)
btnWidget:SetChildActive(btnCmpIndex.timePanel,false)
lvUpBtnStr="升级完成"
btnWidget:SetChildText(btnCmpIndex.btnText,lvUpBtnStr)
end
else

btnWidget:SetChildActive(btnCmpIndex.btnBg1,true)
btnWidget:SetChildActive(btnCmpIndex.btnBg2,false)
btnWidget:SetChildActive(btnCmpIndex.textLayout,true)
btnWidget:SetChildActive(btnCmpIndex.timePanel,false)
btnWidget:SetChildText(btnCmpIndex.btnText,lvUpBtnStr)
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)
if nextLvCfg then
local cndFinishCount,cndCount=zongmenControl:getBuildConditionFinishCount(nextLvCfg)
if cndCount>0 then
btnWidget:SetChildActive(btnCmpIndex.cndFinishText,true)
btnWidget:SetChildText(btnCmpIndex.cndFinishText,FMT.fmt("进度：{0}/{1}",cndFinishCount,cndCount))
else
btnWidget:SetChildActive(btnCmpIndex.cndFinishText,false)
end
else

btnWidget:SetChildActive(btnCmpIndex.cndFinishText,false)
end
local reddot=shanMenDaZhenModel:checkDaZhenCanLevelUp()
btnWidget:SetChildActive(btnCmpIndex.reddot,reddot)
end
else
self:refreshPatchPanel()
end
end
else
self.closePatchPanelMask:setActive(false)
self.normalPanel:setActive(false)

local buildBtnStr="修复大阵"
local btnWidget=self.buildBtn:getWidgetBase()
if bdData.flag==buildingStateType.eUpgrading then
btnWidget:SetChildActive(btnCmpIndex.reddot,false)
local isComplete=buildingCDControl:isComplete(buildingCDType.build,bdData.un_build_id)
if not isComplete then

btnWidget:SetChildActive(btnCmpIndex.btnBg1,false)
btnWidget:SetChildActive(btnCmpIndex.btnBg2,true)
btnWidget:SetChildActive(btnCmpIndex.textLayout,false)
btnWidget:SetChildActive(btnCmpIndex.timePanel,true)


local cdd=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
btnWidget:SetChildText(btnCmpIndex.timeText,timeHelper.format_time_stamp10(cdd.cd,true))
self:setLevelUpTimer()
else

btnWidget:SetChildActive(btnCmpIndex.btnBg1,true)
btnWidget:SetChildActive(btnCmpIndex.btnBg2,false)
btnWidget:SetChildActive(btnCmpIndex.textLayout,true)
btnWidget:SetChildActive(btnCmpIndex.cndFinishText,false)
btnWidget:SetChildActive(btnCmpIndex.timePanel,false)
buildBtnStr="修复完成"
btnWidget:SetChildText(btnCmpIndex.btnText,buildBtnStr)
end
else

btnWidget:SetChildActive(btnCmpIndex.btnBg1,true)
btnWidget:SetChildActive(btnCmpIndex.btnBg2,false)
btnWidget:SetChildActive(btnCmpIndex.textLayout,true)
btnWidget:SetChildActive(btnCmpIndex.timePanel,false)
btnWidget:SetChildText(btnCmpIndex.btnText,buildBtnStr)
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)
local cndFinishCount,cndCount=zongmenControl:getBuildConditionFinishCount(nextLvCfg)
if cndCount>0 then
btnWidget:SetChildActive(btnCmpIndex.cndFinishText,true)
btnWidget:SetChildText(btnCmpIndex.cndFinishText,FMT.fmt("进度：{0}/{1}",cndFinishCount,cndCount))
else
btnWidget:SetChildActive(btnCmpIndex.cndFinishText,false)
end
local reddot=shanMenDaZhenModel:checkDaZhenCanLevelUp()
btnWidget:SetChildActive(btnCmpIndex.reddot,reddot)
end
end

end

function UIShanMenDaZhen_mainWin:refreshAttrPanel(isInit)
local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local daZhenLv=buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)

self.daZhenLevelText:setText(FMT.fmt("{0}级大阵",daZhenLv))

local attrList=daZhenLvCfg.attr
local isShowAttrPanel=false
local state=shanMenDaZhenModel:getDaZhenState()
local isBreak=state==3
if not isBreak and attrList and next(attrList)then
isShowAttrPanel=true
end
self.attrPanel:setActive(isShowAttrPanel)

local attrAddRate=daZhenLvCfg.percent or 0
local attrRate=1+attrAddRate/100

if isShowAttrPanel then
local attrCount=#attrList
self.attrLayout:setChildLayoutGroupCreateItems(attrCount,function(index)
local attrItem=self.attrLayout:getChildLayoutGroupGridItem(index-1)
local attrCfg=attrList[index]
if attrCfg then
attrItem:SetChildActive(-1,true)
local attrId=attrCfg[1]
local attrCfgVal=attrCfg[2]
local attrVal=math.floor(attrCfgVal*attrRate+0.00001)
local name,valstr=equipsHelper.getAttr(attrId,attrVal)
attrItem:SetChildText(0,FMT.fmt("{0}：{1}",name,valstr))
else
attrItem:SetChildActive(-1,false)
end
end)
end
end

function UIShanMenDaZhen_mainWin:refreshBuffPanel(isInit)
local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local daZhenLv=buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)

local nowBuffId=daZhenLvCfg.buff
local isShowBuffPanel=nowBuffId~=nil
self.buffPanel:setActive(isShowBuffPanel)
if isShowBuffPanel then
local cfg=cfgHelper.get1(cfg_guildstateconfig_get,nowBuffId)
local buffIconName=iconHelper.getzmStateIcon(cfg.icon)
self.buffIcon:setChildIcon(buffIconName,false)
end
end

function UIShanMenDaZhen_mainWin:refreshSkillPanel(isInit)

local skillList=self:getAllSkillList()
self.skillIconList:setChildLayoutGroupCreateItems(#skillList,function(index)
if _this==nil then return end
local item=_this.skillIconList:getChildLayoutGroupGridItem(index-1)
local skillData=skillList[index]

item:SetChildButtonClick(2,function()
local pos=self:getSkillPosByIndex(index)
self:showWindow("UIShanMenDaZhen_skillTipsWin",{id=skillData.id,level=skillData.level,isClientSkill=skillData.isClientSkill,needDaZhenLv=skillData.needDaZhenLv,pivotType=2,pos=pos})
end)
item:SetChildActive(1,skillData.isLock==true)
local icon=skillData.icon
item:SetChildIcon(0,icon,false)






end)
end

function UIShanMenDaZhen_mainWin:refreshRecordBtn()
local reddot=systemZongMenModel:checkValidNewFightReport()
self.recordReddot:setActive(reddot)
end

function UIShanMenDaZhen_mainWin:getSkillPosByIndex(index)
local item=self.skillIconList:getChildLayoutGroupGridItem(index-1)
local listWidth=self.skillIconList:getChildSizeDeltaX()
local listPos=self.skillIconList:getChildAnchoredPosition()
local panelPos=self.skillPanel:getChildAnchoredPosition()
local rootPos=self.daZhenRoot:getChildAnchoredPosition()
local tipsPosBase=panelPos+listPos+rootPos
tipsPosBase.x=tipsPosBase.x-listWidth/2
local itemPos=item:GetChildAnchoredPosition(-1)
local tipsPos={tipsPosBase.x+itemPos.x,tipsPosBase.y+itemPos.y+70}
return tipsPos
end

function UIShanMenDaZhen_mainWin:getAllSkillList()
local allDaZhenCfg=cfg_shanmendazhenconfig()
local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local daZhenLv=buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local nowSkillList=daZhenLvCfg.fazeShow
local showSkillList={}
local showSkillList_lookup={}

for _,v in ipairs(nowSkillList)do
local id=v[1]
local level=v[2]
local isLock=false
local fazeCfg=cfgHelper.getSSlawRule(id)
local icon=fazeCfg.image
local skillItem={
id=id,
level=level,
isLock=isLock,
icon=icon,
needDaZhenLv=daZhenLv,
}
showSkillList[#showSkillList+1]=skillItem
showSkillList_lookup[id]=true
end



















for i=daZhenLvCfg.id+1,#allDaZhenCfg do
local cfg=allDaZhenCfg[i]
local skillList=cfg.fazeShow
if skillList and next(skillList)then
for _,v in ipairs(skillList)do
local id=v[1]
local level=v[2]
if not showSkillList_lookup[id]then
local isLock=true
local fazeCfg=cfgHelper.getSSlawRule(id)
local icon=fazeCfg.image
local skillItem={
id=id,
level=level,
isLock=isLock,
icon=icon,
needDaZhenLv=cfg.id,
}
showSkillList[#showSkillList+1]=skillItem
showSkillList_lookup[id]=true
end
end
end



















end

return showSkillList
end

function UIShanMenDaZhen_mainWin:refreshPatchPanel(isCallBack)

local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local daZhenLv=buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local nowShieldValue=shanMenDaZhenModel:getShanMenDaZhenShieldValue()
local maxShieldValue=daZhenLvCfg.shield
self.patchShieldBar:setProgressValue(nowShieldValue,maxShieldValue)
self.patchShieldBar:setChildProgressText(FMT.fmt("大阵护盾值：<color=#aae252>{0}</color>/{1}",nowShieldValue,maxShieldValue))


local maxPatchCount=maxShieldValue-nowShieldValue
local patchParam=cfgHelper.getdef1(cfg_shanmendazhenconfig,'fix')
local singleCount=patchParam[1]
local mixCount=0

if not self.selectCnt or self.selectCnt<mixCount then
self.selectCnt=mixCount
elseif self.selectCnt>maxPatchCount then
self.selectCnt=maxPatchCount
end

local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.patchHandle:getID(),maxPatchCount>mixCount)
if not isCallBack then
self.patchAddBar:setChildSliderInit(self.selectCnt,mixCount,maxPatchCount,func)
self.patchAddBar:setChildSliderValue(self.selectCnt)
end
self.patchAddText:setText(FMT.fmt("<color=#f1ce78>恢复护盾值：</color><color=#aae252>{0}</color>/{1}",mathHelper.formatNumber(self.selectCnt),mathHelper.formatNumber(maxPatchCount)))

local reverseValue=nowShieldValue+self.selectCnt
self.patchShieldBarReverse:setProgressValue(reverseValue,maxShieldValue)


local widget=self.patchCostItem:getWidgetBase()
local itemId=patchParam[2][1][1]
local costNum=patchParam[2][1][2]
local itemNum=math.ceil(self.selectCnt/singleCount)*costNum
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or""
local hasNum=itemsModel.getCount(itemId)
local hasNumStr=mathHelper.formatNumber(hasNum)
local conf={itemid=itemId,itemcount="",showCountBG=false,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickCostItem(...)
end)

local str
if itemNum>1 then
str=FMT.fmt("{0}/{1}",countStr,hasNumStr)
else
str=FMT.fmt("{0}/{1}",itemNum,hasNumStr)
end

if hasNum<itemNum then
self.patchCostText:setText(FMT.cfmt(FONT_COLOR.eRedColor,str))
else
self.patchCostText:setText(str)
end
end

function UIShanMenDaZhen_mainWin:onSliderChange(value)
self.selectCnt=value
self:refreshPatchPanel(true)
end

function UIShanMenDaZhen_mainWin:getTeamUnlockLevelList()
if self.teamUnlockLevelList then
return self.teamUnlockLevelList
end

local allDaZhenCfg=cfg_shanmendazhenconfig()
self.teamUnlockLevelList={}
local lastTeamCount=0
for i=0,#allDaZhenCfg do
local v=allDaZhenCfg[i]
if v.team>lastTeamCount then
self.teamUnlockLevelList[v.team]=v.id
lastTeamCount=v.team
end
end

return self.teamUnlockLevelList
end

function UIShanMenDaZhen_mainWin:setLevelUpTimer()
self:clearLevelUpTimer()
local func=function()
local bdData=shanMenDaZhenModel:getShanMenBdData()
local cdd=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
local btnWidget
if bdData.level>1 then
btnWidget=self.levelUpBtn:getWidgetBase()
else
btnWidget=self.buildBtn:getWidgetBase()
end
btnWidget:SetChildText(btnCmpIndex.timeText,timeHelper.format_time_stamp10(cdd.cd,true))
if cdd.cd<=0 then

self:clearLevelUpTimer()
return self:refreshBottomPanel()
end
end

self.levelUpTimer=self:setTimer(1,0,func)

func()
end

function UIShanMenDaZhen_mainWin:clearLevelUpTimer()
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end




function UIShanMenDaZhen_mainWin:onCloseBtn()
UIFullShanMenControl:closeUI()
end



function UIShanMenDaZhen_mainWin:onShowPatchBtn()
self.isShowPatch=true
self.selectCnt=nil
self:refreshBottomPanel()
end



function UIShanMenDaZhen_mainWin:onLevelUpBtn()
local bdData=shanMenDaZhenModel:getShanMenBdData()

if bdData.flag==buildingStateType.eUpgrading then

local isComplete=buildingCDControl:isComplete(buildingCDType.build,bdData.un_build_id)
if not isComplete then
UIManager.error("山门大阵升级中")
else

zongmenControl:reqBuildingLevelUpComplete(mapIdType.zhufeng,bdData.un_build_id)
end

return
end


local buildLv=bdData.level
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,buildLv+1)
if not nextLvCfg then

return UIManager.error("山门大阵当前已达最高级")
end

local isCanBatchLevelUp=shanMenDaZhenModel:checkDaZhenCanBatchLevelUp()
if isCanBatchLevelUp then

UIFullShanMenControl:showDaZhenBatchLevelUpWindow()
else

UIFullShanMenControl:showDaZhenLevelUpWindow()
end

end



function UIShanMenDaZhen_mainWin:onRepairBtn()

local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local daZhenLv=buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local costList=daZhenLvCfg.repair or{}
if self:checkCost(costList)then

shanMenDaZhenController:reqShanMenDaZhenRepair()
end
end



function UIShanMenDaZhen_mainWin:onPatchBtn()

local state=shanMenDaZhenModel:getDaZhenState()
local isFull=state==1
if isFull then
UIManager.error("山门大阵已自然恢复，不需要修补")
return self:onClosePatchPanelBtn()
end

if not self.selectCnt or self.selectCnt<=0 then
UIManager.error("未选择修补的护盾值")
return
end


local patchParam=cfgHelper.getdef1(cfg_shanmendazhenconfig,'fix')
local singleCount=patchParam[1]
local itemId=patchParam[2][1][1]
local costNum=patchParam[2][1][2]
local needItemNum=math.ceil(self.selectCnt/singleCount)*costNum
local patchValue=self.selectCnt
local func=function()

shanMenDaZhenController:reqShanMenDaZhenPatch(patchValue)
end
moneySystem:useMoney(itemId,needItemNum,func,WARNING_TYPE.eWarning)
end



function UIShanMenDaZhen_mainWin:onClosePatchPanelMask()
self.isShowPatch=false
self:refreshBottomPanel()
end



function UIShanMenDaZhen_mainWin:onZmLvBtn()
UIManager:showWindow('UIZongmenInfoWin',{showback=true})
end



function UIShanMenDaZhen_mainWin:onRecordBtn()

self:showWindow("UISystemZongMenFightRecordWin")

end



function UIShanMenDaZhen_mainWin:onLvPreviewBtn()
UIFullShanMenControl:showDaZhenLevelPreviewWindow()
end



function UIShanMenDaZhen_mainWin:onHelpBtn()
local langId=cfgHelper.getdef1(cfg_shanmendazhenconfig,'ruleLangId')or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end

function UIShanMenDaZhen_mainWin:onBuildBtn()
local bdData=shanMenDaZhenModel:getShanMenBdData()

if bdData.flag==buildingStateType.eUpgrading then

local isComplete=buildingCDControl:isComplete(buildingCDType.build,bdData.un_build_id)
if not isComplete then
UIManager.error("山门大阵升级中")
else

zongmenControl:reqBuildingLevelUpComplete(mapIdType.zhufeng,bdData.un_build_id)
end

return
end


local buildLv=bdData.level
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,buildLv+1)
if not nextLvCfg then

return UIManager.error("山门大阵当前已达最高级")
end


UIFullShanMenControl:showDaZhenLevelUpWindow()
end

function UIShanMenDaZhen_mainWin:onBuffIcon()
local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local daZhenLv=buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local buffId=daZhenLvCfg.buff
if buffId then
local level=cfgHelper.get2(cfg_guildstateconfig_get,buffId,'level')
local tipsPosBase={0,210}
self:showWindow("UIShanMenDaZhen_buffTipsWin",{id=buffId,level=level,pos=tipsPosBase})
end
end


function UIShanMenDaZhen_mainWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,showModel=true,})
end


function UIShanMenDaZhen_mainWin:onClickCostItem(itemId)
if itemId==-1 then
return
end


gainControl:showGainWin(itemId)
end

function UIShanMenDaZhen_mainWin:openTeamWin(openTeamIndex)
local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local daZhenLv=buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local multipleTeams={}
local teamUnlockLevelList=self:getTeamUnlockLevelList()
local maxTeamCount=#teamUnlockLevelList
local nowUnlockTeamCount=daZhenLvCfg.team
local teamUnlockCNDFuncList={}
for teamIdx=1,maxTeamCount do
local defTeam=shanMenDaZhenModel:getShanMenDaZhenTeamDiziListByTeamIndex(teamIdx)or{}
multipleTeams[teamIdx]={}
for posIdx,dis_guid in pairs(defTeam)do
if mathHelper.validInt64(dis_guid)then
multipleTeams[teamIdx][tostring(dis_guid)]={posIdx,eTeamEntityType.dizi,dis_guid}
end
end

local unlockDaZhenLevel=teamUnlockLevelList[teamIdx]
local cfg=cfgHelper.get(cfg_shanmendazhenconfig_get,unlockDaZhenLevel)
teamUnlockCNDFuncList[teamIdx]=function()

local buildLv=zongmenModel:getBuildingLevel(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eShanMen)or 1
local daZhenLv=buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
if daZhenLv<unlockDaZhenLevel then
local lockTipsStr=FMT.fmt("山门大阵\n{0}级解锁",unlockDaZhenLevel)
local lockClickFun=function()
UIManager.error(FMT.fmt("山门大阵{0}级解锁",unlockDaZhenLevel))
end
return false,lockTipsStr,lockClickFun
else
return true
end
end
end

local winArgs=
{
enterTxt="山门大阵",
skipShouYuanCheck=true,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
isCheckInjuryState=true,
statePriorityCheck=false,
monsterFight=nil,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
notNeedDealOverTime=true,
editorTeam=false,
needSaveTeam=false,
showZhenFa=false,
showDefTeamTips=true,
isSortByTeamSelect=true,
mapId=818002,
defaultSelectTeamIndex=openTeamIndex or 1,
multipleTeams=multipleTeams,
teamUnlockCNDFuncList=teamUnlockCNDFuncList,
sortTypeList={{eDiscipleSortType.eShangShi,eDiscipleSortType.eFightSort},
{eDiscipleSortType.eShangShi,eDiscipleSortType.eJingJieSort},
{eDiscipleSortType.eShangShi,eDiscipleSortType.eLianTiSort},
{eDiscipleSortType.eShangShi,eDiscipleSortType.eColorSort},},
sortOrderList={{eSortOrder.eUp,eSortOrder.eDown},
{eSortOrder.eUp,eSortOrder.eDown},
{eSortOrder.eUp,eSortOrder.eDown},
{eSortOrder.eUp,eSortOrder.eDown},},
isUseFusionSort=true,
cancelCallBack=function()

UIFullShanMenControl:showDaZhenWindow()
end,
enterCallBack=function(teamList,zfId)
local guidList={}
for teamIdx,v in ipairs(teamList)do
for posIdx,vv in ipairs(v[2])do
local dis_guid=vv[2]
table.insert(guidList,dis_guid)
end

if teamIdx>=nowUnlockTeamCount then
break
end
end

shanMenDaZhenController:reqShanMenDaZhenChangeTeam(guidList)


UIFullShanMenControl:showDaZhenWindow()
end,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.shanMenDaZhenDefense,winArgs)
end

function UIShanMenDaZhen_mainWin:on_building_event(eType,param1,param2)
if eType==buildingEvent.levelUpComplete or eType==buildingEvent.levelUpStart then
local ubdId=param2
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData.build_id==SLG_SYSTEM_TYPE.eShanMen then

self:refresh()
end
end
end

function UIShanMenDaZhen_mainWin:checkCost(costList)
for i,v in ipairs(costList)do
local itemId=v[1]
local itemCount=v[2]
local itemConfig=itemsConfig.getConfig(itemId)
local have=itemsModel.getCount(itemId)
if have<itemCount then
UIManager.error(FMT.fmt('{0}不足',itemConfig.name))
gainControl:showGainWin(itemId)
return false
end
end
return true
end