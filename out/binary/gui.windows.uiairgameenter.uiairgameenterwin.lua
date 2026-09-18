







def_class("UIAirGameEnterWin",UIWindowBase)









function UIAirGameEnterWin:bindComponents()

self.allFinishBtn=UIButton.get(self,0)
self.baowuBtn=UIButton.get(self,1)
self.baowuReddot=UIObject.get(self,2)
self.beforeSpine=UIObject.get(self,3)
self.beforeSpine2=UIObject.get(self,4)
self.btnRoot=UIObject.get(self,5)
self.chengjiuBtn=UIButton.get(self,6)
self.chengjiuReddot=UIObject.get(self,7)
self.closeBtn=UIButton.get(self,8)
self.closetitle=UIText.get(self,9)
self.content=UIObject.get(self,10)
self.costBg=UIObject.get(self,11)
self.costInfo=UILinkImageText.get(self,12)
self.countInfo=UIText.get(self,13)
self.enterBtn=UIButton.get(self,14)
self.groupBg=UIImage.get(self,15)
self.leveltitle=UIText.get(self,16)
self.lockBtn=UIButton.get(self,17)
self.lockTip=UIText.get(self,18)
self.mainPanel=UIObject.get(self,19)
self.nextBtn=UIButton.get(self,20)
self.rewardBg=UIObject.get(self,21)
self.rewardScrollView=UIObject.get(self,22)
self.scrollView=UIObject.get(self,23)
self.testBtn=UIButton.get(self,24)
self.testReddot=UIObject.get(self,25)
self.txzBtn=UIButton.get(self,26)
self.txzReddot=UIObject.get(self,27)
self.unlockSpine=UIObject.get(self,28)
self.unlockVocRoot=UIObject.get(self,29)

self.allFinishBtn:setButtonClick(function()self:onAllFinishBtn()end)

self.baowuBtn:setButtonClick(function()self:onBaowuBtn()end)

self.chengjiuBtn:setButtonClick(function()self:onChengjiuBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.enterBtn:setButtonClick(function()self:onEnterBtn()end)

self.lockBtn:setButtonClick(function()self:onLockBtn()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)

self.testBtn:setButtonClick(function()self:onTestBtn()end)

self.txzBtn:setButtonClick(function()self:onTxzBtn()end)



end


function UIAirGameEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.allFinishBtn);self.allFinishBtn=nil;
_UIObject_release(self.baowuBtn);self.baowuBtn=nil;
_UIObject_release(self.baowuReddot);self.baowuReddot=nil;
_UIObject_release(self.beforeSpine);self.beforeSpine=nil;
_UIObject_release(self.beforeSpine2);self.beforeSpine2=nil;
_UIObject_release(self.btnRoot);self.btnRoot=nil;
_UIObject_release(self.chengjiuBtn);self.chengjiuBtn=nil;
_UIObject_release(self.chengjiuReddot);self.chengjiuReddot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closetitle);self.closetitle=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.costInfo);self.costInfo=nil;
_UIObject_release(self.countInfo);self.countInfo=nil;
_UIObject_release(self.enterBtn);self.enterBtn=nil;
_UIObject_release(self.groupBg);self.groupBg=nil;
_UIObject_release(self.leveltitle);self.leveltitle=nil;
_UIObject_release(self.lockBtn);self.lockBtn=nil;
_UIObject_release(self.lockTip);self.lockTip=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.rewardBg);self.rewardBg=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.testBtn);self.testBtn=nil;
_UIObject_release(self.testReddot);self.testReddot=nil;
_UIObject_release(self.txzBtn);self.txzBtn=nil;
_UIObject_release(self.txzReddot);self.txzReddot=nil;
_UIObject_release(self.unlockSpine);self.unlockSpine=nil;
_UIObject_release(self.unlockVocRoot);self.unlockVocRoot=nil;
end
















local _this
local _ab

local _scrollViewWidthPad=400
local _scrollViewHeight=630

local _defaultDiscipleId=2001

local _modelOffset={2.3,45}

local CmpLevelGridIndex={
select=0,
line=1,
boss=2,
reward=3,
clear=4,
materialsItem=5,
model=6,
shan=7,
finalBoss=8,
}




function UIAirGameEnterWin:onLoaded(...)
self:bindComponents()

_this=self
_ab="ui/windows/uiairgameenter/air_enter_atlas_pak.ab"
self:addNotify(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)

self.groupBg:setChildSizeDelta(UnityEngine.Screen.width,750)

self.dtList={}


self:addNotify(notifyConfig.onAirBaoWuUpdate,function(...)self:onAirBaoWuUpdate()end)
self:addNotify(notifyConfig.onAirChenJiuUpdate,function(...)self:onAirChenJiuUpdate()end)
end


function UIAirGameEnterWin:__delete()
self:unbindComponents()

self:clearAllDT()

_this=nil
end




function UIAirGameEnterWin:onShow(argtable,afterOnloaded)
self.isShowModelMove=argtable and argtable.isShowModelMove

self:refreshAll()


self:refreshMoneyBar()
end


function UIAirGameEnterWin:onHide()

end


function UIAirGameEnterWin:onShowArgRecv()
self:onShow()
end

function UIAirGameEnterWin.onTYTXZRewardChange(tzxGuid)
local txzId=UITYTongXingZhengModel:getTXZId(tzxGuid)
local config=cfg_airgamepushmapgroupconfig()
for i,v in ipairs(config)do
if v.passport_id==txzId then
_this:refreshTXZReddot()
return
end
end
end

function UIAirGameEnterWin:refreshAll()

self:refreshTestWin()

self:refreshSceneRes()

self:refreshMain()

self:refreshRewardShow()


end

function UIAirGameEnterWin:refreshSceneRes()
local group=airGameEnterModel:getGroup()
local cloudSpine=cfgHelper.get2(cfg_airgamepushmapgroupconfig_get,group,'cloud_spineid')
local birdSpine=cfgHelper.get2(cfg_airgamepushmapgroupconfig_get,group,'bird_spineid')
self.beforeSpine:setChildUIModelShowTarget(cloudSpine,1,{},eAnimationID.stand)
self.beforeSpine2:setChildUIModelShowTarget(birdSpine,1,{},eAnimationID.stand)
local bgResInfo=cfgHelper.get2(cfg_airgamepushmapgroupconfig_get,group,'bg_res_info')
self.groupBg:setCSImageSprite(bgResInfo[1],bgResInfo[2])
end

function UIAirGameEnterWin:refreshMain()

local group=airGameEnterModel:getGroup()

local curLevel
if self.isShowModelMove then
curLevel=airGameEnterModel:getLevel()
else
curLevel=airGameEnterModel:getPlayLevel()
end


local stageName=cfgHelper.get2(cfg_airgamepushmapgroupconfig_get,group,'name')
self.closetitle:setText(stageName)


local levelTitleInfo=FMT.fmt("第{0}关",curLevel)
self.leveltitle:setText(levelTitleInfo)


self:refreshLevelScroll(group,curLevel)

self:jumpToScrollViewIndex(group,curLevel)

if self.isShowModelMove then
self:playModelMove()
end

self:refreshBtns(group,curLevel)
end

function UIAirGameEnterWin:refreshRewardShow()

local group=airGameEnterModel:getGroup()

local curLevel=airGameEnterModel:getCurGameIdx()
local levelRewardList=airGameEnterConfig.getLevelShowReward(group,curLevel)or{}
local propDataList={}
local rewardLen=#levelRewardList
for rindex,levelReward in ipairs(levelRewardList or{})do
local itemId=levelReward[1]
local itemCount=levelReward[2]
local isShowCount=itemCount>1
local itemCountStr=isShowCount and itemCount or""

local conf={itemid=itemId,itemcount=itemCountStr,showCountBG=isShowCount,showStage=true}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
propDataList[#propDataList+1]=propData
end
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
end

function UIAirGameEnterWin:refreshTXZReddot()
local txzReddot=airGameEnterModel:checkTXZReddot()
self.txzReddot:setActive(txzReddot)
end

function UIAirGameEnterWin:refreshBtns(group,curLevel)
self:refreshTXZReddot()

local baoWuReddot=airGameEnterModel:checkBaoWuoReddot()
self.baowuReddot:setActive(baoWuReddot)

local chengjiuReddot=airGameEnterModel:checkChengJiuReddot()
self.chengjiuReddot:setActive(chengjiuReddot)

local stageState=airGameEnterModel:getStageState()


local isShowCost=stageState==airGameEnterConfig.stageStateEnum.BuyTimes
local isShowFree=stageState==airGameEnterConfig.stageStateEnum.FreeTimes
local isFirstFree=stageState==airGameEnterConfig.stageStateEnum.FirstFree
local isShowLockBtn=stageState==airGameEnterConfig.stageStateEnum.LockCondition
local isShowNextStageBtn=stageState==airGameEnterConfig.stageStateEnum.FinishStage
local isShowFinishAllBtn=stageState==airGameEnterConfig.stageStateEnum.FinishAllStage

local isShowEnterBtn=isShowCost or isShowFree or isFirstFree or isShowLockBtn

local isShowCostBg=isShowCost or isFirstFree
self.costBg:setActive(isShowLockBtn or isShowEnterBtn)
if isShowCostBg then
local costInfo=airGameEnterModel:getCostInfo(group,curLevel)
self.costInfo:setText(costInfo)
end
self.enterBtn:setActive(isShowEnterBtn)

local isShowCountInfo=not airGameEnterModel:getLevelFirstFlag(group,curLevel)
self.countInfo:setActive(isShowCountInfo)
if isShowCountInfo then
local countInfo=airGameEnterModel:getCountInfo("<color={2}>({0}/{1})</color>")
self.countInfo:setText(countInfo)
end

self.lockBtn:setActive(false)
if isShowLockBtn then
if group and curLevel then
local lockTip=airGameEnterConfig.checkOpenConditionDescEx(group,curLevel)

self.costInfo:setText(lockTip)
end
end
self.nextBtn:setActive(isShowNextStageBtn)
self.allFinishBtn:setActive(isShowFinishAllBtn)

local isShowTxz=UITYTongXingZhengModel:checkHasTxzBySystem(SYSTEM_DEFINE.eAirGame)

if verifyManager:isHideBusinessActivity()then
isShowTxz=false
end
self.txzBtn:setActive(isShowTxz)
end


function UIAirGameEnterWin:refreshLevelScroll(group,curLevel)
local groupCfg=cfgHelper.get1(cfg_airgamepushmaplevelconfig_get,group)

local levelLen=#groupCfg

self.scrollViewContentWidth=0
for index,levelCfg in ipairs(groupCfg)do
if levelCfg.level_point[1]>self.scrollViewContentWidth then
self.scrollViewContentWidth=levelCfg.level_point[1]
end
end

self.groupBgWidth=self.scrollViewContentWidth+UnityEngine.Screen.width
self.scrollViewContentWidth=self.scrollViewContentWidth+_scrollViewWidthPad

self.content:setChildSizeDelta(self.scrollViewContentWidth,_scrollViewHeight)

if self.scrollViewContentWidth>UnityEngine.Screen.width then
self.groupBg:setChildSizeDelta(self.groupBgWidth,750)
end

local layoutCreateCallBack=function(index)
local item=self.content:getChildLayoutGroupGridItem(index-1)
local levelCfg=groupCfg[index]
local levelPoint=levelCfg.level_point

local isFinish=airGameEnterModel:checkLevelFinish(group,index)
item:SetChildActive(CmpLevelGridIndex.clear,isFinish)

local isSelect=index==curLevel
item:SetChildActive(CmpLevelGridIndex.select,isSelect)

local isHasNext=index<levelLen
item:SetChildActive(CmpLevelGridIndex.line,isHasNext)
if isHasNext then

local nextLevelPoint=groupCfg[index+1].level_point

local curPoint=Vector2(0,0)
item:SetLineRendererPos(CmpLevelGridIndex.line,0,curPoint)

local nextPoint=Vector2(nextLevelPoint[1]-levelPoint[1],nextLevelPoint[2]-levelPoint[2])
item:SetLineRendererPos(CmpLevelGridIndex.line,1,nextPoint)
end

item:SetChildAnchoredPos(-1,levelPoint[1],levelPoint[2])


local isBossLevel=levelCfg.isboss
local isFinalBoss=airGameEnterModel:checkStageFinish(group,levelCfg.levelid)
item:SetChildActive(CmpLevelGridIndex.boss,isBossLevel and not isFinalBoss)
item:SetChildActive(CmpLevelGridIndex.finalBoss,isBossLevel and isFinalBoss)


local shanCfg=cfgHelper.get1(cfg_airgamepushmaplevelshowconfig_get,levelCfg.showtype)
item:SetChildCSImageSprite(CmpLevelGridIndex.shan,_ab,shanCfg.shan_info)


item:SetChildAnchoredPos(CmpLevelGridIndex.shan,shanCfg.shan_offset[1],shanCfg.shan_offset[2])


item:SetChildAnchoredPos(CmpLevelGridIndex.boss,shanCfg.boss_pos[1],shanCfg.boss_pos[2])
item:SetChildAnchoredPos(CmpLevelGridIndex.finalBoss,shanCfg.boss_pos[1],shanCfg.boss_pos[2])

item:SetChildAnchoredPos(CmpLevelGridIndex.reward,shanCfg.rewardpos[1],shanCfg.rewardpos[2])

if _this.dtList[index]then
_this.dtList[index]:Kill()
_this.dtList[index]=nil
end

if shanCfg.float_dt_param then
local tweener=item:SetChildDOLocalMoveY(CmpLevelGridIndex.shan,shanCfg.float_dt_param[1],shanCfg.float_dt_param[2],nil)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Yoyo)
_this.dtList[index]=tweener
end


local showSuccReward=levelCfg.show_reward_list
local isHasReward=showSuccReward~=nil
item:SetChildActive(CmpLevelGridIndex.reward,isHasReward)
if isHasReward then
local wb=item:GetChildWidgetBase(CmpLevelGridIndex.reward)

local rlen=#showSuccReward
wb:SetChildActive(3,rlen>=1)
wb:SetChildActive(4,rlen>=2)

local isShowBtn=false

if rlen>0 then
for index=1,rlen do
local rewardData=showSuccReward[index]
local type=rewardData[1]
local list=rewardData[2]
local showRewardData=list[1]

local itemId=showRewardData
local itemCfg,itemType=airGameEnterConfig.getAirItemCfg(itemId)

local iconName=iconHelper.getItemIconName(itemCfg.icon)

local prop={}
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=itemCfg.color
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetText,3)]=""
prop[PropIndex(DataPropKey.eWidgetText,4)]=""
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false

prop[DataPropKey.eItemID]=itemId
wb:SetChildPropData(index-1,prop)

wb:SetBaseItemClickEvent(index-1,function()
self:showWindow("UIAirMiniGame_itemTipsWin",{itemId=itemId,itemType=itemType,fromType=1})
end)


local typeIconName=type==1 and'icon_zhuyao_1'or'image_bao_1'
wb:SetChildCSImageSprite(4+index,globalABLookup.global,typeIconName)

isShowBtn=#list>1 or isShowBtn
end

wb:SetChildActive(2,isShowBtn)
if isShowBtn then
wb:SetChildButtonClick(2,function()
local args={}
args.titleName='解锁道具'
args.pos=2
args.extraWin='UIAirGamePreShowLevelRewardWin'
local extraParams={}
extraParams.callback=function()

end
extraParams.list=showSuccReward
args.extraParams=extraParams
self:showWindow('UICommonPageWin',args)
end,true)
end
end



local rewardPos=shanCfg.rewardpos
item:SetChildAnchoredPos(CmpLevelGridIndex.reward,rewardPos[1],rewardPos[2])
end

item:SetChildActive(CmpLevelGridIndex.model,isSelect)
if isSelect then
_this:setItemModel(item)
end
end

self.content:setChildLayoutGroupCreateItems(levelLen,layoutCreateCallBack)
end

function UIAirGameEnterWin:jumpToScrollViewIndex(group,level)
local level_point=cfgHelper.get3(cfg_airgamepushmaplevelconfig_get,group,level,'level_point')

local posX=level_point[1]

local scrollViewWidth=UnityEngine.Screen.width

local contentX=0
local contentXMax=self.scrollViewContentWidth-scrollViewWidth

if posX>scrollViewWidth/2 then
if posX>=contentXMax then
contentX=contentXMax
else
contentX=posX-scrollViewWidth/2
end
end

self.content:setChildAnchoredPos(-contentX,0)
end

function UIAirGameEnterWin:refreshMoneyBar()
UIFullAirGameEnterController:showWindow("UITopMoneyWin2",{{eMoneyType.mtLingYu},{eMoneyType.mtBaiLianHuo}})
end


function UIAirGameEnterWin:setItemModel(item)


local imageInfo=UIDiscipleModel:getDiscipleDataByDiziId(_defaultDiscipleId).imageInfo
local modelParams2=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
item:SetChildUIModelShowTarget(CmpLevelGridIndex.model,modelParams2.body,0.5,modelParams2.componets,eAnimationID.stand,false,false,0.1)
item:SetChildUIModelShowFlipX(CmpLevelGridIndex.model,true)
item:SetChildUIModelShowTargetOffset(CmpLevelGridIndex.model,_modelOffset[1],_modelOffset[2])
item:SetChildUIModelMount(CmpLevelGridIndex.model,1110010,
{},
nil,
1,
Vector3.New(0,0,0.1),
nil)
end


function UIAirGameEnterWin:refreshUnlockVocShow()

self.unlockVocRoot:setActive(false)

local unlockVocList=airGameEnterModel:getNowUnlockVocList()
local len=#unlockVocList
local isShowVocRoot=len>0
self.unlockVocRoot:setActive(isShowVocRoot)
if isShowVocRoot then

self:delayDo(1,function()
self.unlockVocRoot:setActive(false)
end)
end
end


function UIAirGameEnterWin:playModelMove()

local func=function()
local group=airGameEnterModel:getGroup()
local level=airGameEnterModel:getLevel()
local curLevelPoint=cfgHelper.get3(cfg_airgamepushmaplevelconfig_get,group,level,"level_point")
local nextLevelPoint=cfgHelper.get3(cfg_airgamepushmaplevelconfig_get,group,level+1,'level_point')

local toX=nextLevelPoint[1]-curLevelPoint[1]
local toY=nextLevelPoint[2]-curLevelPoint[2]

local item=self.content:getChildLayoutGroupGridItem(level-1)
local nextItem=self.content:getChildLayoutGroupGridItem(level)
local endCallBack=function()
_this.isShowModelMove=false

item:SetChildActive(CmpLevelGridIndex.model,false)
item:SetChildActive(CmpLevelGridIndex.select,false)

nextItem:SetChildActive(CmpLevelGridIndex.model,true)
nextItem:SetChildActive(CmpLevelGridIndex.select,true)
_this:setItemModel(nextItem)

_this:refreshMain()
end
item:SetChildActive(CmpLevelGridIndex.model,true)
_this:setItemModel(item)
item:SetChildDOAnchorPos(CmpLevelGridIndex.model,Vector2.New(toX,toY),3,endCallBack)
end

self:delayDo(0.2,func)
end

function UIAirGameEnterWin:clearAllDT()
for index,dt in pairs(self.dtList)do
dt:Kill()
end
self.dtList={}
end

function UIAirGameEnterWin:onAirBaoWuUpdate()
self:refreshBtns()
end

function UIAirGameEnterWin:onAirChenJiuUpdate()
self:refreshBtns()
end






function UIAirGameEnterWin:onTxzBtn()
local args={
parentWin=self,
}
self:showWindow("UIAirGameTXZWin",args)
end



function UIAirGameEnterWin:onBaowuBtn()
self:showWindow("UIAirGameBaoWuWin",{parent=self})
end



function UIAirGameEnterWin:onChengjiuBtn()
self:showWindow("UIAirGameChenJiuWin",{parent=self})
end



function UIAirGameEnterWin:onCloseBtn()


if mainControl:isInScene(eSceneType.eZongmen)then
UIFullAirGameEnterController:closeUI()
else
mainControl:enterHome(nil,function()
UIFullAirGameEnterController:closeUI()
end)
end
end



function UIAirGameEnterWin:onEnterBtn()



local enterFunc=function()
UIFullAirGameEnterController:showPrepareWindow()
end
local lv=airGameEnterModel:getCurPlayIdx()
if airGameEnterModel:checkNeedCostStart(lv)then
if airGameEnterModel:checkCostEnoughStartGame(true)then
enterFunc()
end
else
enterFunc()
end
end



function UIAirGameEnterWin:onNextBtn()



local startCallback=function()
airGameEnterModel:toNextStage()

self:refreshAll()

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end

function UIAirGameEnterWin:onLockBtn()

local group=airGameEnterModel:getGroup()

local curLevel=airGameEnterModel:getPlayLevel()
local lockInfoStr=airGameEnterConfig.checkOpenConditionDescEx(group,curLevel)
UIManager.error(lockInfoStr)
end

function UIAirGameEnterWin:onAllFinishBtn()
UIManager.info("已全部完成")
end


function UIAirGameEnterWin:onTestBtn()
local systemIndexType=UISettingModel:getSystemIndexType()
UIManager:showWindow("UITestTagBtnWin",{systemId=systemIndexType.KongZhan,})
end

function UIAirGameEnterWin:refreshTestWin()
local checkReddot
local systemIndexType=UISettingModel:getSystemIndexType()
local checkBtn=UISettingModel:checkIsOpenTest(systemIndexType.KongZhan)
if checkBtn then
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1
checkBtn=showModel==1
end
if not checkBtn then
UIManager:invokeUIMethod("UITestTagBtnWin",'closeWin')
else
checkReddot=UISettingModel:checkTestTagReddot(systemIndexType.KongZhan)
self.winlua:SetChildActive(self.testReddot:getID(),checkReddot)
end

self.winlua:SetChildActive(self.testBtn:getID(),checkBtn)
end
