







def_class("UIAirGamePrepareWin",UIWindowBase)









function UIAirGamePrepareWin:bindComponents()

self.animationClickMask=UIObject.get(self,0)
self.attrDetailBtn=UIButton.get(self,1)
self.attrRoot=UIObject.get(self,2)
self.attrScroll=UIObject.get(self,3)
self.baowuBtn=UIButton.get(self,4)
self.baowuReddot=UIObject.get(self,5)
self.btnSelect=UIObject.get(self,6)
self.btnSelect2=UIButton.get(self,7)
self.chengjiuBtn=UIButton.get(self,8)
self.chengjiuReddot=UIObject.get(self,9)
self.closeBtn=UIButton.get(self,10)
self.closetitle=UIText.get(self,11)
self.cost=UILinkImageText.get(self,12)
self.costInfo=UIObject.get(self,13)
self.countInfo=UIText.get(self,14)
self.diziRoot=UIObject.get(self,15)
self.dzmodel=UIObject.get(self,16)
self.dzVoc=UIImage.get(self,17)
self.enterBtn=UIButton.get(self,18)
self.enterEffect=UIObject.get(self,19)
self.fadeRoot1=UIObject.get(self,20)
self.fadeRoot2=UIObject.get(self,21)
self.jobBwIcon=UIImage.get(self,22)
self.jobbwitem=UIBaseItem.get(self,23)
self.jobitembg=UIObject.get(self,24)
self.jobskill=UIButton.get(self,25)
self.jobweaponitem=UIBaseItem.get(self,26)
self.leftButton=UIButton.get(self,27)
self.leftRoot=UIObject.get(self,28)
self.levelSpine=UIObject.get(self,29)
self.lockbg=UIObject.get(self,30)
self.mountitem=UIBaseItem.get(self,31)
self.mountReddot=UIObject.get(self,32)
self.mountskill=UIButton.get(self,33)
self.mountskillRoot=UIObject.get(self,34)
self.name=UIText.get(self,35)
self.nameRoot=UIObject.get(self,36)
self.rewardBg=UIObject.get(self,37)
self.rewardScrollView=UIObject.get(self,38)
self.rightButton=UIButton.get(self,39)
self.selectMountBtn=UIButton.get(self,40)
self.ship=UIImage.get(self,41)
self.spineBg=UIObject.get(self,42)
self.title=UIText.get(self,43)
self.unlockTip=UIText.get(self,44)
self.yitongguan=UIObject.get(self,45)
self.spDzFlag=UIObject.get(self,46)

self.attrDetailBtn:setButtonClick(function()self:onAttrDetailBtn()end)

self.baowuBtn:setButtonClick(function()self:onBaowuBtn()end)

self.btnSelect2:setButtonClick(function()self:onBtnSelect2()end)

self.chengjiuBtn:setButtonClick(function()self:onChengjiuBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.enterBtn:setButtonClick(function()self:onEnterBtn()end)

self.jobskill:setButtonClick(function()self:onJobskill()end)

self.leftButton:setButtonClick(function()self:onLeftButton()end)

self.mountskill:setButtonClick(function()self:onMountskill()end)

self.rightButton:setButtonClick(function()self:onRightButton()end)

self.selectMountBtn:setButtonClick(function()self:onSelectMountBtn()end)



end


function UIAirGamePrepareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animationClickMask);self.animationClickMask=nil;
_UIObject_release(self.attrDetailBtn);self.attrDetailBtn=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.attrScroll);self.attrScroll=nil;
_UIObject_release(self.baowuBtn);self.baowuBtn=nil;
_UIObject_release(self.baowuReddot);self.baowuReddot=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnSelect2);self.btnSelect2=nil;
_UIObject_release(self.chengjiuBtn);self.chengjiuBtn=nil;
_UIObject_release(self.chengjiuReddot);self.chengjiuReddot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closetitle);self.closetitle=nil;
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.costInfo);self.costInfo=nil;
_UIObject_release(self.countInfo);self.countInfo=nil;
_UIObject_release(self.diziRoot);self.diziRoot=nil;
_UIObject_release(self.dzmodel);self.dzmodel=nil;
_UIObject_release(self.dzVoc);self.dzVoc=nil;
_UIObject_release(self.enterBtn);self.enterBtn=nil;
_UIObject_release(self.enterEffect);self.enterEffect=nil;
_UIObject_release(self.fadeRoot1);self.fadeRoot1=nil;
_UIObject_release(self.fadeRoot2);self.fadeRoot2=nil;
_UIObject_release(self.jobBwIcon);self.jobBwIcon=nil;
_UIObject_release(self.jobbwitem);self.jobbwitem=nil;
_UIObject_release(self.jobitembg);self.jobitembg=nil;
_UIObject_release(self.jobskill);self.jobskill=nil;
_UIObject_release(self.jobweaponitem);self.jobweaponitem=nil;
_UIObject_release(self.leftButton);self.leftButton=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.levelSpine);self.levelSpine=nil;
_UIObject_release(self.lockbg);self.lockbg=nil;
_UIObject_release(self.mountitem);self.mountitem=nil;
_UIObject_release(self.mountReddot);self.mountReddot=nil;
_UIObject_release(self.mountskill);self.mountskill=nil;
_UIObject_release(self.mountskillRoot);self.mountskillRoot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.nameRoot);self.nameRoot=nil;
_UIObject_release(self.rewardBg);self.rewardBg=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.rightButton);self.rightButton=nil;
_UIObject_release(self.selectMountBtn);self.selectMountBtn=nil;
_UIObject_release(self.ship);self.ship=nil;
_UIObject_release(self.spineBg);self.spineBg=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.unlockTip);self.unlockTip=nil;
_UIObject_release(self.yitongguan);self.yitongguan=nil;
_UIObject_release(self.spDzFlag);self.spDzFlag=nil;
end



















function UIAirGamePrepareWin:onLoaded(...)
self:bindComponents()


self:addNotify(notifyConfig.onAirBaoWuUpdate,function(...)self:onAirBaoWuUpdate(...)end)
self:addNotify(notifyConfig.onAirChenJiuUpdate,function(...)self:onAirChenJiuUpdate(...)end)
end


function UIAirGamePrepareWin:__delete()
self:unbindComponents()

if self.btTree then
behaviorManager:removeBehaviorTree(self.btTree)
self.btTree=nil
end
end




function UIAirGamePrepareWin:onShow(argtable,afterOnloaded)
self.curGroup=airGameEnterModel:getGroup()
self.curLevel=airGameEnterModel:getCurGameIdx()

self:refreshAll()


local bg_spine=cfgHelper.get2(cfg_airgamepushmapgroupconfig_get,self.curGroup,'bg_info')
self.spineBg:setChildUIModelShowTarget(bg_spine,1,{},eAnimationID.stand)

local stageName=cfgHelper.get2(cfg_airgamepushmapgroupconfig_get,self.curGroup,'name')
self.closetitle:setText(stageName)


local levelStateSpineId=cfgHelper.get2(cfg_airgamepushmapgroupconfig_get,self.curGroup,'enter_spineid')
self.levelSpine:setChildUIModelShowTarget(levelStateSpineId,1,{},eAnimationID.stand,false,false,0.2,nil)


local shipResInfo=cfgHelper.get2(cfg_airgamepushmapgroupconfig_get,self.curGroup,'ship_res_info')
self.ship:setCSImageSprite(shipResInfo[1],shipResInfo[2])


self:refreshMoneyBar()

self.animationClickMask:setActive(false)
end


function UIAirGamePrepareWin:onHide()

end

function UIAirGamePrepareWin:onShowArgRecv()
self:onShow()
end

function UIAirGamePrepareWin:refreshMoneyBar()
UIFullAirGameEnterController:showWindow("UITopMoneyWin2",{{eMoneyType.mtLingYu},{eMoneyType.mtBaiLianHuo}})
end

function UIAirGamePrepareWin:refreshAll()

self:refreshLeft()

self:refreshRight()

self:refreshBtns()
end

function UIAirGamePrepareWin:refreshLeft()
self.selectDisciple=airGameEnterModel:getSelectDisciple()

self:refreshRoleModel()

self:refreshInitAttrListPanel()

local isShow=self.selectDisciple==nil
self.btnSelect:setActive(isShow)
end

function UIAirGamePrepareWin:refreshRight()

local levelInfo=FMT.fmt("第{0}关",self.curLevel)
self.title:setText(levelInfo)



local levelRewardList=airGameEnterConfig.getLevelShowReward(self.curGroup,self.curLevel)or{}



local levelfinishState=airGameEnterModel:checkLevelFinish(self.curGroup,self.curLevel)
local propDataList={}
local rewardLen=#levelRewardList
for rindex,levelReward in ipairs(levelRewardList or{})do
local itemId=levelReward[1]
local itemCount=levelReward[2]
local isShowCount=itemCount>1
local itemCountStr=isShowCount and itemCount or""
local graynum=levelfinishState and 1 or 0

local conf={itemid=itemId,itemcount=itemCountStr,showCountBG=isShowCount,showStage=true,gray=graynum}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
propDataList[#propDataList+1]=propData
end
self.yitongguan:setActive(levelfinishState)

self.rewardScrollView:setChildScrollViewCreateGrids(rewardLen,rewardLen)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
local gridLen=grids.Count
for gIndex=1,gridLen do
local item=grids[gIndex-1]
local data=levelRewardList[gIndex]
local propData=propDataList[gIndex]
item:SetChildPropData(0,propData)
item:SetBaseItemClickEvent(0,function()
local clickItemId=data[1]
itemsComponentHelper.onItemClick(clickItemId)
end)
end

self.rewardScrollView:setChildScrollRectEnable(rewardLen>4)


local isUnlock,locktip=airGameEnterModel:checkChallenge(self.curGroup,self.curLevel)
local isShowLock=not isUnlock
self.lockbg:setActive(isShowLock)
if isShowLock then
self.unlockTip:setText(locktip)
end

self.enterBtn:setActive(isUnlock)


self:refreshCountAndCost()


local isShowLeftArrow=self.curLevel>1
local isShowRightArrow=not airGameEnterModel:checkStageFinish(self.curGroup,self.curLevel)
self.leftButton:setActive(isShowLeftArrow)
self.rightButton:setActive(isShowRightArrow)
end

function UIAirGamePrepareWin:refreshCountAndCost()

local costInfo=airGameEnterModel:getCostInfo(self.curGroup,self.curLevel)
local isShowCost=costInfo~=nil and not airGameEnterModel:getLevelFirstFlag(self.curLevel)
self.costInfo:setActive(isShowCost)
if isShowCost then
self.cost:setText(costInfo)
end
local countInfo=airGameEnterModel:getCountInfo("今日挑战次数：<color={2}>{0}</color>/{1}")
local plevel=airGameEnterModel:getPlayLevel()
if plevel==self.curLevel then
if airGameEnterModel:getLevelFirstFlag(self.curLevel)then
countInfo="本次免费"
end
end

self.countInfo:setText(countInfo)
end

function UIAirGamePrepareWin:refreshBtns()
local baoWuReddot=airGameEnterModel:checkBaoWuoReddot()
self.baowuReddot:setActive(baoWuReddot)

local chengjiuReddot=airGameEnterModel:checkChengJiuReddot()
self.chengjiuReddot:setActive(chengjiuReddot)
end

function UIAirGamePrepareWin:refreshInitAttrListPanel()
local isShowAttrList=self.selectDisciple~=nil
self.attrRoot:setActive(isShowAttrList)
if isShowAttrList then
local mainShowAttrCfgList=airGameEnterConfig.getPrepareShowAttrCfgList()
local initAttrList=airGameEnterModel:getGameInitAttrShowList(self.selectDisciple,mainShowAttrCfgList)

local attrLen=#initAttrList
self.attrScroll:setChildScrollViewCreateGrids(attrLen,1)

local grids=self.attrScroll:getChildScrollViewItemWidgets()
local gridsLen=grids.Count

for aindex=1,gridsLen do
local item=grids[aindex-1]
local attrData=initAttrList[aindex]

item:SetChildText(0,attrData[1])
item:SetChildText(1,attrData[2])
item:SetChildText(2,attrData[3])
end
end
end

function UIAirGamePrepareWin:refreshRoleInfo()
local baseRoleInfo=airGameEnterModel:getGameBaseRoleInfo(self.selectDisciple)


local equipItemId=baseRoleInfo.equipItemId


local vocSkillId=baseRoleInfo.vocSkillId


self:refreshRoleInitEquip(equipItemId,vocSkillId)

self:refreshRoleInitBwItem(baseRoleInfo.bwitemid)



local mountItemGuid=baseRoleInfo.mountItemGuid


local mountSkillId=baseRoleInfo.mountSkillId


self:refreshRoleMount(mountItemGuid,mountSkillId)
end

function UIAirGamePrepareWin:refreshRoleInitEquip(equipItemId,vocSkillId)

local prop={}
local equipCfg=cfgHelper.get1(cfg_airweaponconfig_get,equipItemId)
local iconName=iconHelper.getEquipIconName(equipCfg.icon)
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=equipCfg.color
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetText,3)]=""
prop[PropIndex(DataPropKey.eWidgetText,4)]=""
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false

self.jobweaponitem:setChildPropData(prop)

local vocSkillIcon=cfgHelper.get2(cfg_airskillconfig_get,vocSkillId,'icon')
if vocSkillIcon==nil then
logErr("缺少 职业技能图标",vocSkillId)
vocSkillIcon=1
end
local vocSkillIconName=iconHelper.getSkillIcon(vocSkillIcon)
self.jobskill:setChildIcon(vocSkillIconName,false)

self.jobweaponitem:setBaseItemClickEvent(function()
self:showWindow("UIAirMiniGame_itemTipsWin",{itemId=equipItemId,itemType=1,fromType=1,inOutOpen=true})
end)
end

function UIAirGamePrepareWin:refreshRoleInitBwItem(bwitemid)
local isShowBwItem=bwitemid~=nil
self.jobitembg:setActive(isShowBwItem)

if isShowBwItem then
local prop={}
local equipCfg=cfgHelper.get1(cfg_airitemconfig_get,bwitemid)
local iconName=iconHelper.getItemIconName(equipCfg.icon)

prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=4
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetText,3)]=""
prop[PropIndex(DataPropKey.eWidgetText,4)]=""
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false



self.jobBwIcon:setActive(false)

self.jobbwitem:setChildPropData(prop)

self.jobbwitem:setBaseItemClickEvent(function()
self:showWindow("UIAirMiniGame_itemTipsWin",{itemId=bwitemid,itemType=2,fromType=1})
end)
end
end

function UIAirGamePrepareWin:refreshRoleMount(mountItemGuid,mountSkillId)
local mountData=mountModel:getMount(mountItemGuid)or itemsModel.getItem(mountItemGuid)
local isShowMount=mountItemGuid~=nil and mountData~=nil
self.mountitem:setActive(isShowMount)
self.mountskillRoot:setActive(isShowMount)
self.selectMountBtn:setActive(not isShowMount)
if isShowMount then
local mountItemId=mountData.itemid
local equipConf={itemid=mountItemId,itemcount="",showCountBG=false,showStage=true,showname=false}
local equipItemPropData=itemsComponentHelper.getCommonFillDataSmall(equipConf)
self.mountitem:setChildPropData(equipItemPropData)
self.mountitem:setBaseItemClickEvent(function()
self:onSelectMountBtn()
end)

else

local showReddot=airGameEnterModel:checkHasMount()
self.mountReddot:setActive(showReddot)
end

local isShowMountSkillId=mountSkillId~=nil
self.mountskillRoot:setActive(isShowMountSkillId)
if isShowMountSkillId then
local icon=cfgHelper.get2(cfg_airskillconfig_get,mountSkillId,'icon')
if icon==nil then
logErr("缺少 坐骑技能缺少图标",mountSkillId)
icon=1
end
local vocSkillIconName=iconHelper.getSkillIcon(icon)
self.mountskill:setChildIcon(vocSkillIconName,false)
end
end

function UIAirGamePrepareWin:refreshRoleModel()
local isShowModel=self.selectDisciple~=nil
self.diziRoot:setActive(isShowModel)
if isShowModel then

local dzguid=self.selectDisciple
local args={
tmLv=UIDiscipleModel:getTianMingLevel(dzguid),
}
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid,false,1,args)

modelParams.anim=mountHelper.getMountAni(dzguid,modelParams.anim)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.dzmodel:getID(),true,false,true)
self.dzmodel:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false,0)
self.dzmodel:setChildUIModelShowFlipX(true)


local dzName=UIDiscipleModel:getDiscipleName(self.selectDisciple)
self.name:setText(dzName)


local jobicon=UIDiscipleModel:getJobIconNameX(self.selectDisciple)
self.dzVoc:setCSImageSprite(globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(self.selectDisciple)
self.spDzFlag:setActive(isSpDz)


self:refreshRoleInfo()
end
end

function UIAirGamePrepareWin:playEnterAnimation(callback)

if self.btTree then
behaviorManager:removeBehaviorTree(self.btTree)
self.btTree=nil
end

local mountId,mountSlots,mountHp,mountScale,mountOffset=self:getMountArgs()
local levelSpinePos=self.levelSpine:getChildLocalPosition()
UIManager:closeWindow('UITopMoneyWin2')
local dzwb=self.dzmodel:getWidgetBase()

local initData={
model=dzwb,

fade1=self.fadeRoot1,
fade2=self.fadeRoot2,
hideDuration=0.2,


upMountTarget=-1,
mountBodyId=mountId,
mountSlots=mountSlots,
mountHp=mountHp,
mountScale=mountScale,
mountOffset=mountOffset,


inPos={levelSpinePos.x-100,levelSpinePos.y-80},
speed=30,
power=2,
moveDuration=2,


scaleDuration=2,
toScale=0.5,


waitTime=2,
enterFunc=callback,


effectObj=self.enterEffect,
enterEffectid=10378,

upMountWaitTime=0.1
}

self.btTree=behaviorManager:addBehaviorTree('bt_ui_air_game_enter',{},true,initData)
end

function UIAirGamePrepareWin:modelToTargetLocalPos(bt)
local model=bt:getSharedVar('model')
local inPos=bt:getSharedVar('inPos')
local moveDuration=bt:getSharedVar('moveDuration')


model:SetChildDOLocalMove(-1,Vector3(inPos[1],inPos[2],0),moveDuration,nil)
end

function UIAirGamePrepareWin:hidePart()
self.fadeRoot1:setChildCanvasGroupDOFade(0,0.2,nil)
self.fadeRoot2:setChildCanvasGroupDOFade(0,0.2,nil)
self.animationClickMask:setActive(true)
end

function UIAirGamePrepareWin:resetAnimation()
self.fadeRoot1:setChildCanvasGroupAlpha(1)
self.fadeRoot2:setChildCanvasGroupAlpha(1)

self.dzmodel:setChildAnchoredPos(270.1,102.7)
self.dzmodel:setScale(Vector3(1,1,1))
end

function UIAirGamePrepareWin:getMountArgs()

local mountItemGuid=airGameEnterModel:getMount()
local modelId
local mountScale
local offsetV
local guadian
if mountItemGuid~=nil then
local mountItemData=mountModel:getMount(mountItemGuid)or itemsModel.getItem(mountItemGuid)
local mountItemId=mountItemData.itemid
local mountItemCfg=itemsConfig.getConfig(mountItemId)
local modelParams=mountItemCfg.model
modelId=modelParams.model
local offset=modelParams.offset
guadian=mountItemCfg.node or'zuoqidian'
mountScale=0.4

local airMountCfg=cfgHelper.get1(cfg_airmountconfig_get,mountItemId)

if airMountCfg then
mountScale=airMountCfg.p_model_scale or mountScale
offset=airMountCfg.p_model_offset or offset
end
offsetV=Vector3.New(offset[1],offset[2],offset[3])
else
modelId=1110010
mountScale=2
offsetV=Vector3.New(0,0,0.1)
end

return modelId,{},guadian,mountScale,offsetV
end


function UIAirGamePrepareWin:onAirBaoWuUpdate()
self:refreshBtns()
end

function UIAirGamePrepareWin:onAirChenJiuUpdate()
self:refreshBtns()
end





function UIAirGamePrepareWin:onBaowuBtn()
self:showWindow("UIAirGameBaoWuWin")
end



function UIAirGamePrepareWin:onChengjiuBtn()
self:showWindow("UIAirGameChenJiuWin")
end



function UIAirGamePrepareWin:onCloseBtn()
UIFullAirGameEnterController:showMainWindow()
end



function UIAirGamePrepareWin:onEnterBtn()




local _this=self

local checkEnterCount=function(cb)
if airGameEnterModel:checkNeedCostStart(_this.curLevel)then
airGameEnterController:showCostDialougeWin(cb)
return false
else
cb()
end
end

local enterFunc=function()

airGameEnterController:enterGame(_this.curGroup,_this.curLevel,_this.selectDisciple)

end

local continueFunc=function()
self:playEnterAnimation(function()
local fbId=cfgHelper.get3(cfg_airgamepushmaplevelconfig_get,_this.curGroup,_this.curLevel,'fbid')
airController:continueEnterGame(fbId)
end)
end

local restartFunc=function()

airController:reqRestartGame()

end

local restartBeforeLevel=function()

airGameEnterModel:setCachePrepareEnterInfo(_this.curGroup,_this.curLevel,_this.selectDisciple)
airController:clearActorDataAndProcessData()

end

local checkEnterFunc=function()
local playLevel=airGameEnterModel:getCurGameIdx()
if playLevel==self.curLevel then
if airGameEnterModel:checkShowChangeInfoDialouge()then
local curPlayIdx=airGameEnterModel:getCurPlayIdx()
local continueInfo=FMT.fmt(' 是否继续第{0}关未完成的战斗？',curPlayIdx)
local showdata=
{
type='UIDialouge',
title='提示',
content=continueInfo,
oktext='确定',
canceltext='重新开始',
allowclickBG=true,
okcallback=function()
continueFunc()
end,
cancelcallback=function()


airGameEnterController:checkShowBuyCountDialouge(restartFunc,_this.curLevel,true)
end,
showclosebtn=true,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()
else
airGameEnterController:checkShowBuyCountDialouge(enterFunc,_this.curLevel,true)
end
elseif self.curLevel~=playLevel then
if airGameEnterModel:checkShowChangeInfoDialouge()then
local curPlayIdx=airGameEnterModel:getCurPlayIdx()
local continueInfo=FMT.fmt(' 是否继续第{0}关未完成的战斗？',curPlayIdx)
local showdata=
{
type='UIDialouge',
title='提示',
content=continueInfo,
oktext='确定',
canceltext='挑战本关',
allowclickBG=true,
okcallback=function()
continueFunc()
end,
cancelcallback=function()


airGameEnterController:checkShowBuyCountDialouge(restartBeforeLevel,_this.curLevel,true)
end,
showclosebtn=true,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()
else
airGameEnterController:checkShowBuyCountDialouge(enterFunc,_this.curLevel,true)
end
end
end

if self.selectDisciple==nil then
UIManager.error("还未安排弟子")
return
end

local challengeState,tip=airGameEnterModel:checkChallenge(self.curGroup,self.curLevel)
if not challengeState then
UIManager.error(tip)
end

local mount=airGameEnterModel:getMount()
if mount==nil and(not self.isIgnoralMount)and airGameEnterModel:checkHasMount()and(not airGameEnterModel:checkShowChangeInfoDialouge())then
local content="您未选择坐骑，直接前往吗？"
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='true',
okcallback=function()
_this.isIgnoralMount=true
checkEnterFunc()
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
return
end

checkEnterFunc()
end



function UIAirGamePrepareWin:onJobskill()

local vocId=UIDiscipleModel:getDiscipleJob(self.selectDisciple)
local airVocCfg=cfg_airvocationconfig_get(vocId)
local vocSkillId=airVocCfg.skill
local args={
skillid=vocSkillId,
skilllv=1,
}
self:showWindow("UIAirGameSkillTipsWin",args)
end



function UIAirGamePrepareWin:onLeftButton()
self.curLevel=self.curLevel-1
self:refreshRight()

end



function UIAirGamePrepareWin:onMountskill()

local mountItemGuid=airGameEnterModel:getMount()
local mountItemData=mountModel:getMount(mountItemGuid)or itemsModel.getItem(mountItemGuid)
local mountItemId=mountItemData.itemid
local itemConfig=itemsConfig.getConfig(mountItemId)

if not itemConfig or not itemConfig.airgameMountSkillid then return end

local mountSkillId=itemConfig.airgameMountSkillid
local args={
skillid=mountSkillId,
skilllv=1,
}
self:showWindow("UIAirGameSkillTipsWin",args)
end



function UIAirGamePrepareWin:onRightButton()
self.curLevel=self.curLevel+1
self:refreshRight()
end



function UIAirGamePrepareWin:onSelectMountBtn()
local showFunc=function()
local selectMount=airGameEnterModel:getMount()
local args={}
args.titleName='选择坐骑'
args.pos=2
args.extraWin='UIAirGameSelectMountWin'
local extraParams={}
extraParams.selectMount=selectMount
extraParams.callback=function()

end
args.extraParams=extraParams
self:showWindow('UICommonPageWin',args)
end
showFunc()
end

function UIAirGamePrepareWin:onBtnSelect2()
airGameEnterController:showDiscipleSelectWin()
end

function UIAirGamePrepareWin:onClickSelect()
airGameEnterController:showDiscipleSelectWin()
end

function UIAirGamePrepareWin:onAttrDetailBtn()
local params={}
params.discipleGuid=self.selectDisciple

self:showWindow('UIAirGameInitAttrDetailWin',params)
end

