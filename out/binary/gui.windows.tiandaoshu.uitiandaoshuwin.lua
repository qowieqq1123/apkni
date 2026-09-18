







def_class("UITianDaoShuWin",UIWindowBase)









function UITianDaoShuWin:bindComponents()

self.animPart=UIObject.get(self,0)
self.attrBtn=UIButton.get(self,1)
self.attrBtnReddot=UIObject.get(self,2)
self.attrList=UIObject.get(self,3)
self.attrShow=UIObject.get(self,4)
self.backBtn=UIButton.get(self,5)
self.background_1=UIObject.get(self,6)
self.background_2=UIObject.get(self,7)
self.background_3=UIObject.get(self,8)
self.bottomBtn=UIButton.get(self,9)
self.bottomPart=UIObject.get(self,10)
self.cdTx=UIText.get(self,11)
self.cloud_1=UIObject.get(self,12)
self.cloud_2=UIObject.get(self,13)
self.cloud_3=UIObject.get(self,14)
self.completeTx=UIText.get(self,15)
self.constellation_1=UIObject.get(self,16)
self.constellation_2=UIObject.get(self,17)
self.constellation_3=UIObject.get(self,18)
self.costList=UIObject.get(self,19)
self.descTx=UIText.get(self,20)
self.effect=UIObject.get(self,21)
self.empty=UIButton.get(self,22)
self.fruitList=UIObject.get(self,23)
self.jfBtn=UIButton.get(self,24)
self.leftList=UIObject.get(self,25)
self.leftPart=UIObject.get(self,26)
self.lockTx=UIText.get(self,27)
self.lwBtn=UIButton.get(self,28)
self.model=UIObject.get(self,29)
self.moneyRoot=UIObject.get(self,30)
self.nextTips=UIText.get(self,31)
self.nextTipsRoot=UIText.get(self,32)
self.noneAttr=UIObject.get(self,33)
self.resetBtn=UIButton.get(self,34)
self.rightPanel=UIObject.get(self,35)
self.rightPart=UIObject.get(self,36)
self.rune_1=UIImage.get(self,37)
self.rune_10=UIImage.get(self,38)
self.rune_11=UIImage.get(self,39)
self.rune_12=UIImage.get(self,40)
self.rune_2=UIImage.get(self,41)
self.rune_3=UIImage.get(self,42)
self.rune_4=UIImage.get(self,43)
self.rune_5=UIImage.get(self,44)
self.rune_6=UIImage.get(self,45)
self.rune_7=UIImage.get(self,46)
self.rune_8=UIImage.get(self,47)
self.rune_9=UIImage.get(self,48)
self.sapling=UIObject.get(self,49)
self.selectIcon=UIImage.get(self,50)
self.star1_1=UIObject.get(self,51)
self.star1_2=UIObject.get(self,52)
self.star1_3=UIObject.get(self,53)
self.star2_1=UIObject.get(self,54)
self.star2_2=UIObject.get(self,55)
self.star2_3=UIObject.get(self,56)
self.statisticsList=UIObject.get(self,57)
self.statisticsPanel=UIObject.get(self,58)
self.topBtn=UIButton.get(self,59)
self.topReddot=UIObject.get(self,60)
self.treeList=UIObject.get(self,61)
self.treeView=UIButton.get(self,62)
self.unlockTips=UIObject.get(self,63)

self.attrBtn:setButtonClick(function()self:onAttrBtn()end)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.bottomBtn:setButtonClick(function()self:onBottomBtn()end)

self.empty:setButtonClick(function()self:onEmpty()end)

self.jfBtn:setButtonClick(function()self:onJfBtn()end)

self.lwBtn:setButtonClick(function()self:onLwBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)

self.topBtn:setButtonClick(function()self:onTopBtn()end)

self.treeView:setButtonClick(function()self:onTreeView()end)
self.background={
self.background_1,
self.background_2,
self.background_3,
}
self.cloud={
self.cloud_1,
self.cloud_2,
self.cloud_3,
}
self.constellation={
self.constellation_1,
self.constellation_2,
self.constellation_3,
}
self.rune={
self.rune_1,
self.rune_2,
self.rune_3,
self.rune_4,
self.rune_5,
self.rune_6,
self.rune_7,
self.rune_8,
self.rune_9,
self.rune_10,
self.rune_11,
self.rune_12,
}
self.star1={
self.star1_1,
self.star1_2,
self.star1_3,
}
self.star2={
self.star2_1,
self.star2_2,
self.star2_3,
}



end


function UITianDaoShuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animPart);self.animPart=nil;
_UIObject_release(self.attrBtn);self.attrBtn=nil;
_UIObject_release(self.attrBtnReddot);self.attrBtnReddot=nil;
_UIObject_release(self.attrList);self.attrList=nil;
_UIObject_release(self.attrShow);self.attrShow=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.background_1);self.background_1=nil;
_UIObject_release(self.background_2);self.background_2=nil;
_UIObject_release(self.background_3);self.background_3=nil;
_UIObject_release(self.bottomBtn);self.bottomBtn=nil;
_UIObject_release(self.bottomPart);self.bottomPart=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.cloud_1);self.cloud_1=nil;
_UIObject_release(self.cloud_2);self.cloud_2=nil;
_UIObject_release(self.cloud_3);self.cloud_3=nil;
_UIObject_release(self.completeTx);self.completeTx=nil;
_UIObject_release(self.constellation_1);self.constellation_1=nil;
_UIObject_release(self.constellation_2);self.constellation_2=nil;
_UIObject_release(self.constellation_3);self.constellation_3=nil;
_UIObject_release(self.costList);self.costList=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.fruitList);self.fruitList=nil;
_UIObject_release(self.jfBtn);self.jfBtn=nil;
_UIObject_release(self.leftList);self.leftList=nil;
_UIObject_release(self.leftPart);self.leftPart=nil;
_UIObject_release(self.lockTx);self.lockTx=nil;
_UIObject_release(self.lwBtn);self.lwBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.nextTips);self.nextTips=nil;
_UIObject_release(self.nextTipsRoot);self.nextTipsRoot=nil;
_UIObject_release(self.noneAttr);self.noneAttr=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.rightPart);self.rightPart=nil;
_UIObject_release(self.rune_1);self.rune_1=nil;
_UIObject_release(self.rune_10);self.rune_10=nil;
_UIObject_release(self.rune_11);self.rune_11=nil;
_UIObject_release(self.rune_12);self.rune_12=nil;
_UIObject_release(self.rune_2);self.rune_2=nil;
_UIObject_release(self.rune_3);self.rune_3=nil;
_UIObject_release(self.rune_4);self.rune_4=nil;
_UIObject_release(self.rune_5);self.rune_5=nil;
_UIObject_release(self.rune_6);self.rune_6=nil;
_UIObject_release(self.rune_7);self.rune_7=nil;
_UIObject_release(self.rune_8);self.rune_8=nil;
_UIObject_release(self.rune_9);self.rune_9=nil;
_UIObject_release(self.sapling);self.sapling=nil;
_UIObject_release(self.selectIcon);self.selectIcon=nil;
_UIObject_release(self.star1_1);self.star1_1=nil;
_UIObject_release(self.star1_2);self.star1_2=nil;
_UIObject_release(self.star1_3);self.star1_3=nil;
_UIObject_release(self.star2_1);self.star2_1=nil;
_UIObject_release(self.star2_2);self.star2_2=nil;
_UIObject_release(self.star2_3);self.star2_3=nil;
_UIObject_release(self.statisticsList);self.statisticsList=nil;
_UIObject_release(self.statisticsPanel);self.statisticsPanel=nil;
_UIObject_release(self.topBtn);self.topBtn=nil;
_UIObject_release(self.topReddot);self.topReddot=nil;
_UIObject_release(self.treeList);self.treeList=nil;
_UIObject_release(self.treeView);self.treeView=nil;
_UIObject_release(self.unlockTips);self.unlockTips=nil;
self.background=nil;
self.cloud=nil;
self.constellation=nil;
self.rune=nil;
self.star1=nil;
self.star2=nil;
end
















local _this=nil
local _leftCmp={
button=0,
selected=1,
normal=2,
nIcon=3,
sIcon=4,
reddot=5,
}
local _fruitCmp={
root=-1,
button=0,
icon=1,
textBg=2,
text=3,
flag=4,
select=5,
effect=6,
}
local _statisticsCmp={
icon=0,
name=1,
jumpBtn=2,
progressBar=3,
reddot=4,
full=5,
}
local _stageEffect=1
local _fruit_ab="ui/windows/tiandaoshu/tiandaoshu_fruit_atlas_pak.ab"
local _jobImage_ab="ui/windows/tiandaoshu/tiandaoshu_jobimage_atlas_pak.ab"
local _speeds={0.1,0.5,0.2,0.3,0.2,0.4}
local _runePos={Vector2.New(-290,150),Vector2.New(414,235),Vector2.New(525,522),Vector2.New(-454,560)}
local _rune_ab="ui/windows/tiandaoshu/tiandaoshu_jobrune_atlas_pak.ab"
local _dragCacheDelta=35
local _dragCacheScale=1
local _dragCacheDuration=1.2
local _dragCacheInterval=0.15
local _pageHeight=750
local _treeAudioIdList={568,569,570,570}



function UITianDaoShuWin:onLoaded(...)
self:bindComponents()
_this=self

local baseCfg=cfgHelper.get1(cfg_tiandaoshubaseconfig_get,1)
self.aTimeCfg=baseCfg.animTime
self.bSpine=baseCfg.basicSpine
self.bAnimCfg=baseCfg.basicAnim
self.bAnimCnt=#self.bAnimCfg
self.eAnim=baseCfg.exAnim

self.treePosRecord={}
self.dragCacheFlag=1
self.dragCacheValue=0
self.dragCacheTween=nil

local _onBeginDrag=function(...)self:onBeginDragTree(...)end
local _onEndDrag=function(...)self:onEndDragTree(...)end
local _onDrag=function(...)self:onDragTree(...)end
self.winlua:SetChildUIDragEvent(self.treeView:getID(),0,_onBeginDrag,_onEndDrag,_onDrag)

notifySystem:listenNotify(notifyConfig.onTiandaoshuVocActived,self.onTiandaoshuVocActived)
notifySystem:listenNotify(notifyConfig.onTiandaoshuStageActived,self.onTiandaoshuStageActived)
notifySystem:listenNotify(notifyConfig.onTiandaoshuFruitStatusChanged,self.onTiandaoshuFruitStatusChanged)
notifySystem:listenNotify(notifyConfig.onTiandaoshuFruitComprehend,self.onTiandaoshuFruitComprehend)
notifySystem:listenNotify(notifyConfig.onTiandaoshuFruitComplete,self.onTiandaoshuFruitComplete)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)
notifySystem:listenNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
notifySystem:listenNotify(notifyConfig.onTiandaoshuInited,self.onTiandaoshuInited)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.onTiandaoshuStatisticsTypeChange,self.onTiandaoshuStatisticsTypeChange)
notifySystem:listenNotify(notifyConfig.onTiandaoshuStatisticsCountChange,self.onTiandaoshuStatisticsCountChange)
notifySystem:listenNotify(notifyConfig.onTiandaoshuReset,self.onTiandaoshuReset)

self:initMoneyList()
self.treeViewHeight=self.treeView:getChildRectHeight()
self.cdList={}
self:initLeftList()
self:selectVoc(1)
end


function UITianDaoShuWin:__delete()
notifySystem:removelistener(notifyConfig.onTiandaoshuVocActived,self.onTiandaoshuVocActived)
notifySystem:removelistener(notifyConfig.onTiandaoshuStageActived,self.onTiandaoshuStageActived)
notifySystem:removelistener(notifyConfig.onTiandaoshuFruitStatusChanged,self.onTiandaoshuFruitStatusChanged)
notifySystem:removelistener(notifyConfig.onTiandaoshuFruitComprehend,self.onTiandaoshuFruitComprehend)
notifySystem:removelistener(notifyConfig.onTiandaoshuFruitComplete,self.onTiandaoshuFruitComplete)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)
notifySystem:removelistener(notifyConfig.onXianMengChange,self.onXianMengChange)
notifySystem:removelistener(notifyConfig.onTiandaoshuInited,self.onTiandaoshuInited)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.onTiandaoshuStatisticsTypeChange,self.onTiandaoshuStatisticsTypeChange)
notifySystem:removelistener(notifyConfig.onTiandaoshuStatisticsCountChange,self.onTiandaoshuStatisticsCountChange)
notifySystem:removelistener(notifyConfig.onTiandaoshuReset,self.onTiandaoshuReset)

self:unbindComponents()
_this=nil

self:stopBottomTick()
self:stopFruitCDTick()

self:killDragTween()
self:killJumpTween()
self:killWaitActive()
end




function UITianDaoShuWin:onShow(argtable,afterOnloaded)

end


function UITianDaoShuWin:onHide()

end




function UITianDaoShuWin:onDialog()
self.dialog:setActive(false)
end


function UITianDaoShuWin:onBackBtn()
UIFullTianDaoShuController:closeUI(true)
end


function UITianDaoShuWin:onLwBtn()
local fData=self.fList[self.fSelected]
local voc=self.vList[self.vSelected]
local stage=fData[1]
local fruit=fData[2]
local fruitData=tiandaoshuModel:getFruitData(voc,stage,fruit)
local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
if fruitData.status==tiandaoshuModel.eFruitStatus.eNormal then
local count=fruitData.count
for i,v in ipairs(fruitCfg.consume[count+1])do
local itemId=v[1]
local itemCount=v[2]
if moneyConfig.isMoney(itemId)then
local have=moneyModel.getMoney(itemId)
if have<itemCount then
gainControl:showGainWin(itemId)
local name=moneyModel.getMoneyName(itemId)
UIManager.error(FMT.fmt("{0}不足",name))
return
end
else
local have=bagModel.getItemCountById(itemId)
if have<itemCount then
gainControl:showGainWin(itemId)
local name=itemsConfig.getItemName(itemId)
UIManager.error(FMT.fmt("{0}不足",name))
return
end
end
end
tiandaoshuController.send_6_76(voc,stage,fruit)
end
end


function UITianDaoShuWin:onAttrBtn()
local show=self.winlua:GetChildActiveInHierarchy(self.rightPanel:getID())
show=not show
self.attrShow:setActive(show)
self.rightPanel:setActive(show)
self.statisticsPanel:setActive(show)
self.lastStatisticsJump=nil
if show then
self.rightPanel:setChildCanvasGroupAlpha(0)
self.statisticsPanel:setChildCanvasGroupAlpha(0)
self.rightPanel:setChildCanvasGroupDOFade(1,0.5)
self.statisticsPanel:setChildCanvasGroupDOFade(1,0.5)
local items=self.attrList:getChildLayoutGroupGridList()
for i=1,items.Count do
items[i-1]:ForceLayoutRect(0)
end
self.winlua:ForceLayoutRect(self.attrList:getID())
end
end

function UITianDaoShuWin:closeAttrShow()
self.attrShow:setActive(false)
self.rightPanel:setActive(false)
self.statisticsPanel:setActive(false)
self.lastStatisticsJump=nil
end


function UITianDaoShuWin:onStageBtn(warning)

if self.waitStage then

return false
end






local voc=self.vList[self.vSelected]
local vocData=tiandaoshuModel:getVocData(voc)
local stageCnt=#vocData.list
if stageCnt<vocData.max then
local nextStage=stageCnt+1
local conditions=tiandaoshuConfig:getConfig(voc,"unlock",nextStage)
local check,type,value1,value2=tiandaoshuModel:checkConditions(voc,conditions)
if check then
if nextStage>1 or voc==1 then
self.waitStage={voc,nextStage}
self.animPart:setActive(true)
self.leftPart:setActive(false)
self.rightPart:setActive(false)
self.moneyRoot:setActive(false)
self.backBtn:setActive(false)
self:selectFruit()
tiandaoshuController.send_6_73({self.waitStage})
else
tiandaoshuController.send_6_73({{voc,nextStage}})
end
return true
else
if warning then
local warningStr=tiandaoshuModel:getConditionWarning(type,value1,value2)
UIManager.error(warningStr)
end
return false
end
end
end









function UITianDaoShuWin:onJfBtn()
local fData=self.fList[self.fSelected]
local voc=self.vList[self.vSelected]
local stage=fData[1]
local fruit=fData[2]
local fruitData=tiandaoshuModel:getFruitData(voc,stage,fruit)
local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
if fruitData.status~=tiandaoshuModel.eFruitStatus.eSeal then
return
end
local okCb=function()
for i,v in ipairs(fruitCfg.unseal)do
local itemId=v[1]
local itemCount=v[2]
if moneyConfig.isMoney(itemId)then
local have=moneyModel.getMoney(itemId)
if have<itemCount then
gainControl:showGainWin(itemId)
local name=moneyModel.getMoneyName(itemId)
UIManager.error(FMT.fmt("{0}不足",name))
return
end
else
local have=bagModel.getItemCountById(itemId)
if have<itemCount then
gainControl:showGainWin(itemId)
local name=itemsConfig.getItemName(itemId)
UIManager.error(FMT.fmt("{0}不足",name))
return
end
end
end
tiandaoshuController.send_6_75(voc,stage,fruit)
end
local args={
title='解封',
rewardTitle="",
desc1="道果灵气枯竭，需要蕴养解封",
rewards=fruitCfg.unseal,
showCancel=true,
commitName='确定',
commitCB=okCb,
}
UIFullTianDaoShuController:showWindow('UIDialougeRewardWin',args)
end

function UITianDaoShuWin:onTopBtn(force,duration)
if force then
self:killJumpTween()
end
if not self.jumpTween then
duration=duration or 0.5
local oldPos=self.treeList:getChildAnchoredPosition()
local voc=self.vList[self.vSelected]
local index=self:calculateScreenIndex(oldPos.y)
local cStage=index+self.bAnimCnt
local tStage=nil
local vocData=tiandaoshuModel:getVocData(voc)
if vocData then
for stage=cStage+1,self.activeStageNum do
local stageData=vocData.list[stage]
for fruitId,fruitData in ipairs(stageData.list)do
if fruitData.status==tiandaoshuModel.eFruitStatus.eNormal or fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
tStage=stage
break
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eLock then

local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruitId)
if tiandaoshuModel:checkConditions(fruitCfg.unlock)then
tStage=stage
break
end
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eSeal then

if tiandaoshuModel:checkUnsealEnough(voc,stage,fruitId)then
tStage=stage
break
end
end
end
if tStage then
break
end
end
end

if tStage then
local targetY=self:calculateDragStagePos(tStage)
self:jumpTo(duration,targetY)
self:closeAttrShow()
return
end

local targetY=self.activeStageNum>self.bAnimCnt and self.treeViewHeight-self:getTreeListSizeDeltaY()or 0
self:jumpTo(duration,targetY)
self:closeAttrShow()
end
end

function UITianDaoShuWin:jumpTo(duration,targetY,callback)
if duration>0 then
local oldPos=self.treeList:getChildAnchoredPosition()
self:hideArrows()
self.jumpTween=self.treeList:setChildDOAnchorPosY(targetY,duration,function()
self:refreshBottomArrow(targetY)
self:refreshTopArrow(targetY)
local newPos=self.treeList:getChildAnchoredPosition()
self:dragBackground(newPos.y-oldPos.y)
self.jumpTween=nil
if callback then
callback()
end
end)
self.jumpTween:OnUpdate(function()
local newPos=self.treeList:getChildAnchoredPosition()
self:dragBackground(newPos.y-oldPos.y)
oldPos=newPos
end)
else
self:dragTreeTo(targetY)
if callback then
callback()
end
end
end

function UITianDaoShuWin:jumpToTop(force,duration)
if force then
self:killJumpTween()
end
if not self.jumpTween then
duration=duration or 0.5
local treeLen=self:getTreeListSizeDeltaY()
local targetY=self.activeStageNum>self.bAnimCnt and self.treeViewHeight-treeLen or 0
self:jumpTo(duration,targetY)
end
end

function UITianDaoShuWin:onBottomBtn(force,duration)
if force then
self:killJumpTween()
end
if not self.jumpTween then
local voc=self.vList[self.vSelected]
local oldPos=self.treeList:getChildAnchoredPosition()

local index=self:calculateScreenIndex(oldPos.y)
local lowStage=index+self.bAnimCnt-1
local vocData=tiandaoshuModel:getVocData(voc)
local tStage=nil
if vocData then
for stage=1,lowStage do
local stageData=vocData.list[stage]
for fruitId,fruitData in ipairs(stageData.list)do
if fruitData.status==tiandaoshuModel.eFruitStatus.eNormal or fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
tStage=stage
break
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eLock then

local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruitId)
if fruitCfg.unlockShow==1 and tiandaoshuModel:checkConditions(fruitCfg.unlock)then
tStage=stage
break
end
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eSeal then

if tiandaoshuModel:checkUnsealEnough(voc,stage,fruitId)then
tStage=stage
break
end
end
end
if tStage then
break
end
end
end

if not tStage then

return
end

local targetY=self:calculateDragStagePos(tStage)
self:jumpTo(duration or 0.5,targetY)
self:closeAttrShow()
end
end

function UITianDaoShuWin:killJumpTween()
if self.jumpTween then
self.jumpTween:Kill(false)
self.jumpTween=nil
end
end

function UITianDaoShuWin:pushDragCacheDelta(flag,value)
if flag~=0 then
if flag==self.dragCacheFlag then
self.dragCacheValue=self.dragCacheValue+value
else
self.dragCacheFlag=flag
self.dragCacheValue=value
end
end
end

function UITianDaoShuWin:popDragCacheDelta()
local delta=math.min(self.dragCacheValue,_dragCacheDelta)
self.dragCacheValue=self.dragCacheValue-delta
local sign=(self.dragCacheFlag>0)and 1 or-1
return sign*delta*_dragCacheScale
end

function UITianDaoShuWin:getDragCache()
return(self.dragCacheFlag>0)and self.dragCacheValue or-self.dragCacheValue
end

function UITianDaoShuWin:killDragTween()
self.dragCacheFlag=1
self.dragCacheValue=0
if self.dragCacheTween then
self.dragCacheTween:Kill()
self.dragCacheTween=nil
end
end

function UITianDaoShuWin:onBeginDragTree(id,pos)

if self.jumpTween then return end
if self.activeStageNum>self.bAnimCnt then
self.treePos=pos
self:killDragTween()
end
self:hideArrows()
self:closeAttrShow()
end

function UITianDaoShuWin:onEndDragTree(id,pos)
self.treePos=nil

local temp=self.treeList:getChildAnchoredPosition()

local cache=self:getDragCache()

if cache~=0 then
local target=Mathf.Clamp(temp.y+cache,self.treeViewHeight-self:getTreeListSizeDeltaY(),0)
local duration=math.min(math.ceil(math.abs(target-temp.y)/_dragCacheDelta)*_dragCacheInterval,_dragCacheDuration)
self.dragCacheTween=self.treeList:setChildDOAnchorPosY(target,duration,function()
self:refreshTopArrow(temp.y)
self:refreshBottomArrow(temp.y)
self.dragCacheTween=nil

local newPos=self.treeList:getChildAnchoredPosition()
self:dragBackground(newPos.y-temp.y)
end)
self.dragCacheTween:SetEase(DG.Tweening.Ease.OutQuart)
self.dragCacheTween:OnUpdate(function()
local newPos=self.treeList:getChildAnchoredPosition()
self:dragBackground(newPos.y-temp.y)
temp=newPos
end)
else
self:refreshTopArrow(temp.y)
self:refreshBottomArrow(temp.y)
end
end

function UITianDaoShuWin:onDragTree(id,pos,dt)
if not self.treePos then return end
local delta=pos-self.treePos

self:pushDragCacheDelta(Mathf.Sign(delta.y),math.abs(delta.y))
delta.y=self:popDragCacheDelta()

local point=self.treeList:getChildAnchoredPosition()
local height=self:getTreeListSizeDeltaY()
local y=Mathf.Clamp(point.y+delta.y,self.treeViewHeight-height,0)

local d=y-point.y
point.y=y
self.treeList:setChildAnchoredPosition(point)

self:dragBackground(d)

self.treePos=pos
end

function UITianDaoShuWin:dragTreeTo(targetY)

local oldPos=self.treeList:getChildAnchoredPosition()
self.treeList:setChildAnchoredPos(oldPos.x,targetY)
self:refreshTopArrow(targetY)
self:refreshBottomArrow(targetY)
self:dragBackground(targetY-oldPos.y)
end

function UITianDaoShuWin:dragBackground(d)
local height=self.treeViewHeight

for i,v in ipairs(self.background)do
local point=v:getChildAnchoredPosition()
point.y=point.y+d*_speeds[1]
while point.y<-height do
point.y=point.y+_pageHeight*3
end
while point.y>height do
point.y=point.y-_pageHeight*3
end
v:setChildAnchoredPosition(point)
end
for i,v in ipairs(self.cloud)do
local point=v:getChildAnchoredPosition()
point.y=point.y+d*_speeds[2]
while point.y<-height do
point.y=point.y+_pageHeight*3
end
while point.y>height do
point.y=point.y-_pageHeight*3
end
v:setChildAnchoredPosition(point)
end
for i,v in ipairs(self.constellation)do
local point=v:getChildAnchoredPosition()
point.y=point.y+d*_speeds[6]
while point.y<-height do
point.y=point.y+_pageHeight*3
end
while point.y>height do
point.y=point.y-_pageHeight*3
end
v:setChildAnchoredPosition(point)
end
for i,v in ipairs(self.star2)do
local point=v:getChildAnchoredPosition()
point.y=point.y+d*_speeds[3]
while point.y<-height do
point.y=point.y+_pageHeight*3
end
while point.y>height do
point.y=point.y-_pageHeight*3
end
v:setChildAnchoredPosition(point)
end
for i,v in ipairs(self.star1)do
local point=v:getChildAnchoredPosition()
point.y=point.y+d*_speeds[5]
while point.y<-height do
point.y=point.y+_pageHeight*3
end
while point.y>height do
point.y=point.y-_pageHeight*3
end
v:setChildAnchoredPosition(point)
end
for i,v in ipairs(self.rune)do
local point=v:getChildAnchoredPosition()
point.y=point.y+d*_speeds[4]
while point.y<-height do
point.y=point.y+_pageHeight*3
end
while point.y>height do
point.y=point.y-_pageHeight*3
end
v:setChildAnchoredPosition(point)
end
end

function UITianDaoShuWin.onTiandaoshuVocActived(voc)
local idx=table.findValue(_this.vList,voc)
if not idx then
local sVoc=_this.vSelected and _this.vList[_this.vSelected]or nil
table.insert(_this.vList,voc)
table.sort(_this.vList,_this.sortVoc)
_this.vSelected=sVoc and table.findValue(_this.vList,sVoc)or nil
_this.leftList:setChildLayoutGroupCreateItems(#_this.vList,function(index)
local iVoc=_this.vList[index]
local vocCfg=tiandaoshuConfig:getConfig(iVoc)
local item=_this.leftList:getChildLayoutGroupGridItem(index-1)
item:SetChildCSImageSprite(_leftCmp.sIcon,_jobImage_ab,cfg.sprite0)
item:SetChildCSImageSprite(_leftCmp.nIcon,_jobImage_ab,cfg.sprite1)
item:SetChildActive(_leftCmp.reddot,tiandaoshuModel:getVocReddot(iVoc))
item:SetChildButtonClick(_leftCmp.button,function()_this:selectVoc(index)end)
_this:refreshLeftSelect(index,item)

end)
else
local item=_this.leftList:getChildLayoutGroupGridItem(idx-1)
item:SetChildActive(_leftCmp.reddot,false)
end

_this:onStageBtn()
end

function UITianDaoShuWin.onTiandaoshuStageActived(voc,stage,toStage)

if _this.vSelected then
local sVoc=_this.vList[_this.vSelected]
if sVoc==voc then
if _this:needWaitActive()then
_this:setWaitActive(voc,stage)
return
end

_this.activeStageNum=stage

local animInfo=nil
if _this.activeStageNum>_this.bAnimCnt then
_this.treeList:setChildLayoutGroupAddItem()

local item=_this.treeList:getChildLayoutGroupGridItem(stage-_this.bAnimCnt-1)
item.gameObject.name=_this.activeStageNum
_this.winlua:SetAsLastSibling(_this.fruitList:getID())
local spineCfg=tiandaoshuConfig:getConfig(voc,"spine")
local audioId=_treeAudioIdList[4]
animInfo={item,0,spineCfg[stage],_this.eAnim,false,_this.activeStageNum>1,audioId}
else
local anim=_this.bAnimCfg[stage]
local audioId=_treeAudioIdList[stage]
animInfo={_this.winlua,_this.sapling:getID(),_this.bSpine,anim,_this.loadedSapling or false,_this.activeStageNum>1,audioId}
end

local stageCfg=tiandaoshuConfig:getStageConfig(voc,stage)
local sFruitIdx=#_this.fList+1
for fruit,fruitCfg in ipairs(stageCfg)do
table.insert(_this.fList,{stage,fruit})
_this.fruitList:setChildLayoutGroupAddItem()
local cnt=#_this.fList
_this:initFruit(voc,cnt)
end
local eFruitIdx=#_this.fList



if _this.waitStage and voc==_this.waitStage[1]and _this.waitStage[2]==stage then
_this:hideArrows()
_this:hideNewFruit(sFruitIdx,eFruitIdx)
_this.unlockTips:setChildCanvasGroupAlpha(0)
local btArgs={
sFruitIdx=sFruitIdx,
eFruitIdx=eFruitIdx,
widget=animInfo[1],
wIndex=animInfo[2],
anim=animInfo[4],
model=animInfo[3],
loaded=animInfo[5],
tWidget=_this.winlua,
tIndex=_this.unlockTips:getID(),
isNext=animInfo[6],
audioId=animInfo[7],
}
_this.bt=behaviorManager:addBehaviorTree("bt_ui_tds_unlock",nil,true,btArgs,true)
else
_this:jumpToTop(true)
_this.animPart:setActive(false)

if animInfo[5]then
animInfo[1]:SetChildModelAnimationStop(animInfo[2],animInfo[4],1)
else
animInfo[1]:SetChildUIModelShowTarget(animInfo[2],animInfo[3],1,nil,animInfo[4],true,false,0,function()
animInfo[1]:SetChildModelAnimationStop(animInfo[2],animInfo[4],1)
end)
end
end

local curStage=tiandaoshuModel:getVocStage(voc)
local conditions=tiandaoshuConfig:getConfig(voc,"unlock",curStage+1)

if conditions then
local str=tiandaoshuModel:getFirstConditionTips(conditions,voc)
_this.nextTips:setText(str)
else
_this.nextTips:setText("已达最终阶段")
end
end
end
end

function UITianDaoShuWin.onTiandaoshuFruitStatusChanged(voc,stage,fruit,status)

if _this.vSelected then
local sVoc=_this.vList[_this.vSelected]
local selectNext=false
if sVoc==voc then
for i,v in ipairs(_this.fList)do
if v[1]==stage and v[2]==fruit then
local fruitData=tiandaoshuModel:getFruitData(voc,stage,fruit)
local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
_this:refreshFruit(i,nil,fruitData,fruitCfg)
if#_this.cdList>0 then
_this:startFruitCDTick()
end
break
end
end

if _this.fSelected then
local fData=_this.fList[_this.fSelected]
if fData[1]==stage and fData[2]==fruit then
if status==tiandaoshuModel.eFruitStatus.eCompleted then
selectNext=true
else
_this:refreshBottomStatus()
end
end
end
end

local check=_this:onStageBtn()
if not check and selectNext then
local temp=_this.lastStatisticsJump
if temp and voc==temp[3]and stage==temp[4]and fruit==temp[5]then
local statisticsData=tiandaoshuModel:getStatisticsData(voc,temp[1])
local count=#statisticsData.fruits
local since=temp[2]
for i=1,count do
local index=since-i
index=index<=0 and(index+count)or index
local v=statisticsData.fruits[index]
local fruitData=tiandaoshuModel:getFruitData(voc,v[1],v[2])
if fruitData.status~=tiandaoshuModel.eFruitStatus.eCompleted then
_this.lastStatisticsJump={temp[1],index,voc,v[1],v[2]}
local targetY=_this:calculateDragStagePos(v[1])
local fIndex=_this:findFruitItemIndex(v[1],v[2])
_this:jumpTo(0.25,targetY,function()
_this:selectFruit(fIndex)
end)
return
end
end
end

local fruitCfgs=tiandaoshuConfig:getFruitConfig(voc)
for _fruit,fruitCfg in ipairs(fruitCfgs[stage])do
local fruitData=tiandaoshuModel:getFruitData(voc,stage,_fruit)
if fruitData.status==tiandaoshuModel.eFruitStatus.eNormal or fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
local fIdx=_this:findFruitItemIndex(stage,_fruit)
if fIdx then
_this:selectFruit(fIdx)
else
local targetY=_this:calculateDragStagePos(stage)
_this:jumpTo(0.2,targetY,function()
local fIdx=_this:findFruitItemIndex(stage,_fruit)
_this:selectFruit(fIdx)
end)
end
return
end
end

for _stage,_fruitCfgs in ipairs(fruitCfgs)do
if _stage~=stage then
for _fruit,fruitCfg in ipairs(fruitCfgs[_stage])do
local fruitData=tiandaoshuModel:getFruitData(voc,_stage,_fruit)
if fruitData.status==tiandaoshuModel.eFruitStatus.eNormal or fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
local targetY=_this:calculateDragStagePos(_stage)
_this:jumpTo(0.2,targetY,function()
local fIdx=_this:findFruitItemIndex(_stage,_fruit)
_this:selectFruit(fIdx)
end)
return
end
end
end
end
end
end
end

function UITianDaoShuWin.onTiandaoshuFruitComprehend(voc,stage,fruit,count,dCount)





local sVoc=nil
if _this.vSelected then
sVoc=_this.vList[_this.vSelected]
if sVoc==voc then
_this:refreshRightPanel()
_this:showFruitComprehendEffect(voc,stage,fruit)
_this.effect:setChildShowEffect(10289,true)


AudioManager.playAudio(567)
end
end
_this.vSelected=nil
_this:initLeftList()
if sVoc then
_this.vSelected=table.findValue(_this.vList,sVoc)
_this:refreshLeftSelect(_this.vSelected)
end

_this:refreshResetRoot()
end

function UITianDaoShuWin.onTiandaoshuFruitComplete(voc,stage,fruit,dComplete)

end

function UITianDaoShuWin:showFruitComprehendEffect(voc,stage,fruit)
local cfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
if cfg.effect then
local index=self:findFruitItemIndex(stage,fruit)
local item=self.fruitList:getChildLayoutGroupGridItem(index-1)
item:SetChildShowEffect(_fruitCmp.effect,cfg.effect,true)
end
end

function UITianDaoShuWin.on_building_event(bdType,level,exp,lastLv)
if bdType==buildingEvent.zongmenLevelUp then

if _this.vSelected then
_this:onStageBtn()
end
end
end

function UITianDaoShuWin.onXianMengLevelChange(oldlv,guildlevel,oldexp,guildexp)
if oldlv~=guildlevel then

if _this.vSelected then
_this:onStageBtn()
end
end
end

function UITianDaoShuWin.onXianMengChange(flag)
if flag then

if _this.vSelected then
_this:onStageBtn()
end
else

_this:selectFruit()
end
end

function UITianDaoShuWin.onTiandaoshuInited(flag)
if flag then
local oVoc=_this.vSelected and _this.vList[_this.vSelected]or nil
_this.vSelected=nil
_this:initLeftList()
if oVoc then
local vSelected=table.findValue(_this.vList,oVoc)
_this:selectVoc(vSelected)
end
end
end

function UITianDaoShuWin:selectVocCheck(index)

local voc=self.vList[self.vSelected]
if not tiandaoshuModel:isVocActive(voc)then
tiandaoshuController.send_6_72(voc)
self.treePosRecord[index]=nil
else
if not self:onStageBtn()then
local record=self.treePosRecord[index]

if record then
self:dragTreeTo(record[1])
self:selectFruit(record[2])
else
local vocData=tiandaoshuModel:getVocData(voc)
if vocData then

local sCount=#vocData.list
local lockMax=nil
for stage=sCount,1,-1 do
local stageData=vocData.list[stage]
for fruitId,fruitData in ipairs(stageData.list)do
if fruitData.status==tiandaoshuModel.eFruitStatus.eNormal or fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
local y=self:calculateDragStagePos(stage)
self:dragTreeTo(y)
local fIdx=self:findFruitItemIndex(stage,fruitId)
if fIdx then
self:selectFruit(fIdx)
end
return
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eLock then

local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruitId)
if tiandaoshuModel:checkConditions(fruitCfg.unlock)then
local y=self:calculateDragStagePos(fruitData.stage)
self:dragTreeTo(y)
local fIdx=self:findFruitItemIndex(fruitData.stage,fruitId)
if fIdx then
self:selectFruit(fIdx)
end
return
else
lockMax=lockMax and math.max(lockMax,stage)or lockMax
end
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eSeal then

if tiandaoshuModel:checkUnsealEnough(voc,stage,fruitId)then
local y=self:calculateDragStagePos(fruitData.stage)
self:dragTreeTo(y)
local fIdx=self:findFruitItemIndex(fruitData.stage,fruitId)
if fIdx then
self:selectFruit(fIdx)
end
return
else
lockMax=lockMax and math.max(lockMax,stage)or lockMax
end
end
end
end

if lockMax then
local y=self:calculateDragStagePos(fruitData.stage)
self:dragTreeTo(y)
local fIdx=self:findFruitItemIndex(fruitData.stage,fruitId)
if fIdx then
self:selectFruit(fIdx)
end
return
end
end

self:jumpToTop(true,0)
end
else
self.treePosRecord[index]=nil
self:jumpToTop(true,0)
end
end
end

function UITianDaoShuWin:selectVoc(index)

if self.vSelected~=index then
self:killDragTween()
self:killJumpTween()

local oVoc=self.vSelected
local oFruit=self.fSelected
local oPos=self.treeList:getChildAnchoredPosition()
self.vSelected=index

self:selectFruit()
self:initTreeView(index)
self:refreshRightPanel()
self:refreshStatisticsPanel()
self:refreshAttrButtonReddot()
self:refreshResetRoot()


self:refreshLeftSelect(index)
if oVoc then
self:refreshLeftSelect(oVoc)
self.treePosRecord[oVoc]={oPos.y,oFruit}
end
if self.loadedSapling then
self:selectVocCheck(index)
end
end
end

function UITianDaoShuWin:calculateDragStagePos(stage)

if stage<=self.bAnimCnt then
return 0
elseif stage>=self.activeStageNum then
return self.treeViewHeight-self:getTreeListSizeDeltaY()
else
local s=stage-self.bAnimCnt
local y=s*_pageHeight-(self.treeViewHeight-_pageHeight)/2
return-y
end
end

function UITianDaoShuWin:findFruitItemIndex(stage,fruit)
for i,v in ipairs(self.fList)do
if v[1]==stage and v[2]==fruit then
return i
end
end
end

function UITianDaoShuWin:selectFruit(index)
if index~=nil and not xianmengModel:hasXM()then
UIManager.error(cfgHelper.getlang("haveNotXianMengTips"))
return
end


if self.fSelected~=index then
if self.fSelected then
local item=self.fruitList:getChildLayoutGroupGridItem(self.fSelected-1)
if item then
item:SetChildActive(_fruitCmp.select,false)
end
end
self.fSelected=index

if self.fSelected then
local item=self.fruitList:getChildLayoutGroupGridItem(self.fSelected-1)
if item then
item:SetChildActive(_fruitCmp.select,true)
end
end
self.bottomPart:setActive(index~=nil)
if index then
self:refreshBottom()
else
self:clearBottom()
self:closeAttrShow()
end
end
end

function UITianDaoShuWin.sortVoc(a,b)
local aData=tiandaoshuModel:getVocData(a)
local bData=tiandaoshuModel:getVocData(b)
local aCount=aData and aData.count or 0
local bCount=bData and bData.count or 0
if aCount~=bCount then
return aCount>bCount
else
return a<b
end
end

function UITianDaoShuWin:initLeftList()
self.vList={}
local config=tiandaoshuConfig:getConfig()
for voc,cfg in pairs(config)do
if tiandaoshuModel:isVocActive(voc)or UIDiscipleModel:getDiscipleJobCount(voc)>0 then
table.insert(self.vList,voc)
end
end
table.sort(self.vList,self.sortVoc)
self.leftList:setChildLayoutGroupCreateItems(#self.vList,function(index)
local voc=self.vList[index]
local vocCfg=tiandaoshuConfig:getConfig(voc)
local item=self.leftList:getChildLayoutGroupGridItem(index-1)
item:SetChildCSImageSprite(_leftCmp.sIcon,_jobImage_ab,vocCfg.sprite0)
item:SetChildCSImageSprite(_leftCmp.nIcon,_jobImage_ab,vocCfg.sprite1)
item:SetChildButtonClick(_leftCmp.button,function()self:selectVoc(index)end)
item:SetChildActive(_leftCmp.reddot,tiandaoshuModel:getVocReddot(voc))
self:refreshLeftSelect(index,item)

end)
end

function UITianDaoShuWin:refreshLeftSelect(index,leftItem)
local isSelect=self.vSelected==index
local item=leftItem or self.leftList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(_leftCmp.selected,isSelect)

local size=item:GetChildAnchoredPosition(isSelect and _leftCmp.selected or _leftCmp.normal)
item:SetChildAnchoredPosition(_leftCmp.button,size)
self.winlua:ForceLayoutRect(self.leftList:getID())
end







function UITianDaoShuWin:refreshRightPanel()
local voc=self.vList[self.vSelected]
if not tiandaoshuModel:isVocActive(voc)then
self.attrList:setChildLayoutGroupClearAllItems()
return
end

local curStage=tiandaoshuModel:getVocStage(voc)
local conditions=tiandaoshuConfig:getConfig(voc,"unlock",curStage+1)

if conditions then
local str=tiandaoshuModel:getFirstConditionTips(conditions,voc)
self.nextTips:setText(str)
else
self.nextTips:setText(curStage>0 and"已达最终阶段"or"")
end

local attrList,percentList,activityList=tiandaoshuModel:getVocAttrList(voc)
local skillList,skillFinds=tiandaoshuModel:getVocSkillList(voc)
local activityCnt=#activityList
local skillCnt=next(skillList)and 1 or 0
local itemCnt=activityCnt+skillCnt
self.noneAttr:setActive(itemCnt<=0)
self.attrList:setChildLayoutGroupCreateItems(itemCnt,function(index)
local actId=activityList[index]
local item=self.attrList:getChildLayoutGroupGridItem(index-1)
if actId then
local aList=attrListHelper.sortByLookup(attrList[actId])
local aCnt=#aList
if actId==0 then
local pList=attrListHelper.sortByLookup(percentList)
local pCnt=#pList
local cnt=aCnt+pCnt
item:SetChildText(1,"基础属性")
item:SetChildLayoutGroupCreateItems(0,cnt,function(subIdx)
local aItem=item:GetChildLayoutGroupGridItem(0,subIdx-1)
if subIdx<=aCnt then
local aData=aList[subIdx]
local attrName=helper.getAttributeName(aData[1])
local attrValue=helper.getAttributeStrEx(aData[1],aData[2],2)
aItem:SetChildText(0,attrName)
aItem:SetChildText(1,attrValue)
else
local pData=pList[subIdx-aCnt]
local attrName=FMT.fmt("天道{0}",helper.getAttributeName(pData[1]))
local attrValue=FMT.fmt("{0}%",pData[2])
aItem:SetChildText(0,attrName)
aItem:SetChildText(1,attrValue)
end
end)
else
item:SetChildText(1,limitActivitiesModel:getActConfig(actId,"name"))
item:SetChildLayoutGroupCreateItems(0,aCnt,function(subIdx)
local aItem=item:GetChildLayoutGroupGridItem(0,subIdx-1)
local aData=aList[subIdx]
local attrName=helper.getAttributeName(aData[1])
local attrValue=aData[2]
aItem:SetChildText(0,attrName)
aItem:SetChildText(1,attrValue)
end)
end
else
item:SetChildText(1,"职业技能")
item:SetChildLayoutGroupCreateItems(0,#skillFinds,function(subIdx)
local sItem=item:GetChildLayoutGroupGridItem(0,subIdx-1)
local sType=skillFinds[subIdx]
local sValue=skillList[sType]
local skillList=cfgHelper.get3(cfg_disciplevocationconfig_get,voc,'skills',1)
local skillId=skillList[tiandaoshuModel:convertSkillType(sType)]
local skillname=cfgHelper.get2(cfg_skillconfig_get,skillId,"name")
sItem:SetChildText(0,skillname)
sItem:SetChildText(1,FMT.fmt("+{0}",sValue))
end)
end
item:ForceLayoutRect(0)
end)
self.winlua:ForceLayoutRect(self.attrList:getID())
end

function UITianDaoShuWin:refreshAttrButtonReddot()
local voc=self.vList[self.vSelected]
local reddot=tiandaoshuModel:getStatisticsVocReddot(voc)
self.attrBtnReddot:setActive(reddot)
end

function UITianDaoShuWin:refreshStatisticsPanel()
local voc=self.vList[self.vSelected]
if not tiandaoshuModel:isVocActive(voc)then
self.statisticsList:setChildLayoutGroupCreateItems(0,nil)
return
end
local statisticsCfg=cfg_tiandaoshufruitstatisticsconfig()
self.statisticsDatas={}
for statisticsType,config in ipairs(statisticsCfg)do
local statisticsData=tiandaoshuModel:getStatisticsData(voc,statisticsType)
if statisticsData then
local data={
voc=voc,
statisticsType=statisticsType,
count=statisticsData.count,
max=statisticsData.max,
config=config,
reddot=tiandaoshuModel:getStatisticsTypeReddot(voc,statisticsType),
items=tiandaoshuModel:getStatisticsFruitsCostItems(voc,statisticsType),
sortWeight=config.sortWeight,
}
table.insert(self.statisticsDatas,data)
end
end
if#self.statisticsDatas>1 then
table.sort(self.statisticsDatas,function(a,b)
local stateA=a.count<a.max and 0 or 1
local stateB=b.count<b.max and 0 or 1
if stateA==stateB then
return a.sortWeight<b.sortWeight
else
return stateA<stateB
end
end)
end
self.statisticsList:setChildLayoutGroupCreateItems(#self.statisticsDatas,function(index)
local item=self.statisticsList:getChildLayoutGroupGridItem(index-1)
local data=self.statisticsDatas[index]
item:SetChildCSImageSprite(_statisticsCmp.icon,_fruit_ab,data.config.icon)
item:SetChildText(_statisticsCmp.name,data.config.name)
item:SetChildProgressValue(_statisticsCmp.progressBar,data.count,data.max)
item:SetChildProgressText(_statisticsCmp.progressBar,FMT.fmt("{0}/{1}",data.count,data.max))
item:SetChildActive(_statisticsCmp.reddot,data.reddot)
item:SetChildButtonClick(_statisticsCmp.jumpBtn,function()
self:onClickStatisticsJump(index)
end)
item:SetChildActive(_statisticsCmp.jumpBtn,data.count<data.max)
item:SetChildActive(_statisticsCmp.full,data.count>=data.max)
end)
end

function UITianDaoShuWin.onTiandaoshuStatisticsTypeChange(oldStatisticsList,newStatisticsList)
local voc=_this.vList[_this.vSelected]
local checkList=newStatisticsList[voc]
if checkList and next(checkList)then
_this:refreshStatisticsPanel()
return
end
checkList=oldStatisticsList[voc]
if checkList then
for i,v in ipairs(_this.statisticsDatas)do
local dMax=checkList[v.statisticsType]
if dMax~=nil then
v.max=v.max+dMax
v.reddot=tiandaoshuModel:getStatisticsTypeReddot(voc,v.statisticsType)
v.items=tiandaoshuModel:getStatisticsFruitsCostItems(voc,v.statisticsType)

local item=_this.statisticsList:getChildLayoutGroupGridItem(i-1)
item:SetChildProgressValue(_statisticsCmp.progressBar,v.count,v.max)
item:SetChildProgressText(_statisticsCmp.progressBar,FMT.fmt("{0}/{1}",v.count,v.max))
item:SetChildActive(_statisticsCmp.jumpBtn,v.count<v.max)
item:SetChildActive(_statisticsCmp.full,v.count>=v.max)
item:SetChildActive(_statisticsCmp.reddot,v.reddot)
end
end
end
end

function UITianDaoShuWin.onTiandaoshuStatisticsCountChange(voc,statisticsType,dCount)
if dCount==0 then return end
if voc==_this.vList[_this.vSelected]then
for i,v in ipairs(_this.statisticsDatas)do
if v.statisticsType==statisticsType then
local oldCount=v.count
v.count=v.count+dCount
v.reddot=tiandaoshuModel:getStatisticsTypeReddot(voc,statisticsType)
v.items=tiandaoshuModel:getStatisticsFruitsCostItems(voc,statisticsType)

if(oldCount<v.max and v.count>=v.max)or(oldCount>=v.max and v.count<v.max)then
_this:refreshStatisticsPanel()
else
local item=_this.statisticsList:getChildLayoutGroupGridItem(i-1)
item:SetChildProgressValue(_statisticsCmp.progressBar,v.count,v.max)
item:SetChildProgressText(_statisticsCmp.progressBar,FMT.fmt("{0}/{1}",v.count,v.max))
item:SetChildActive(_statisticsCmp.reddot,v.reddot)
end
return
end
end
end
end

function UITianDaoShuWin.onTiandaoshuReset(voc)
if voc==_this.vList[_this.vSelected]then
_this.fruitList:setChildLayoutGroupClearAllItems()
_this:onTiandaoshuInited(true)
end
end

function UITianDaoShuWin:onClickStatisticsJump(index)
if self.jumpTween then return end
if self.waitStage then return end
if self.dragCacheTween then return end
local data=self.statisticsDatas[index]
local voc=data.voc
local statisticsType=data.statisticsType
local statisticsData=tiandaoshuModel:getStatisticsData(voc,statisticsType)
local count=#statisticsData.fruits
local since=0
if self.lastStatisticsJump~=nil and statisticsType==self.lastStatisticsJump[1]then
since=self.lastStatisticsJump[2]
else
self.clickStatisticsSortList={}
local reddot={}
local notReddot={}
for i=count,1,-1 do
local v=statisticsData.fruits[i]
if tiandaoshuModel:checkFruitCost(voc,v[1],v[2])then
table.insert(reddot,i)
else
table.insert(notReddot,i)
end
end
self.clickStatisticsSortList=table.concatTableX(reddot,notReddot)
end

local index=since+1
index=index>count and(index-count)or index
local v=statisticsData.fruits[self.clickStatisticsSortList[index]]
self.lastStatisticsJump={statisticsType,index,voc,v[1],v[2]}
local targetY=self:calculateDragStagePos(v[1])
local fIndex=self:findFruitItemIndex(v[1],v[2])
self.lastStatisticsJump={statisticsType,index,voc,v[1],v[2]}
self:jumpTo(0.25,targetY,function()
self:selectFruit(fIndex)
end)
end

function UITianDaoShuWin:initTreeView(index)
local voc=self.vList[self.vSelected]

local cfg=tiandaoshuConfig:getConfig(voc)
self.treeList:setChildAnchoredPosition(Vector2.zero)

if api_Available_SetChildWidgetMaterialVector4()then
local colorInfo=cfg.bgcolor
self.winlua:SetChildWidgetMaterialVector4(self.background_1:getID(),"_Color",Vector4.New(colorInfo[1],colorInfo[2],colorInfo[3],colorInfo[4]))
self.winlua:SetChildWidgetMaterialFloat(self.background_1:getID(),"_ColorMask",colorInfo[5])
self.winlua:SetChildWidgetMaterialFloat(self.background_1:getID(),"_Hue",colorInfo[6])
self.winlua:SetChildWidgetMaterialFloat(self.background_1:getID(),"_Saturation",colorInfo[7])
self.winlua:SetChildWidgetMaterialFloat(self.background_1:getID(),"_Value",colorInfo[8])
colorInfo=cfg.cloundcolor
for i,v in ipairs(self.cloud)do
self.winlua:SetChildWidgetMaterialVector4(v:getID(),"_Color",Vector4.New(colorInfo[1],colorInfo[2],colorInfo[3],colorInfo[4]))
self.winlua:SetChildWidgetMaterialFloat(v:getID(),"_ColorMask",colorInfo[5])
self.winlua:SetChildWidgetMaterialFloat(v:getID(),"_Hue",colorInfo[6])
self.winlua:SetChildWidgetMaterialFloat(v:getID(),"_Saturation",colorInfo[7])
self.winlua:SetChildWidgetMaterialFloat(v:getID(),"_Value",colorInfo[8])
end
colorInfo=cfg.star1color
self.winlua:SetChildWidgetMaterialVector4(self.star1_1:getID(),"_Color",Vector4.New(colorInfo[1],colorInfo[2],colorInfo[3],colorInfo[4]))
self.winlua:SetChildWidgetMaterialFloat(self.star1_1:getID(),"_ColorMask",colorInfo[5])
self.winlua:SetChildWidgetMaterialFloat(self.star1_1:getID(),"_Hue",colorInfo[6])
self.winlua:SetChildWidgetMaterialFloat(self.star1_1:getID(),"_Saturation",colorInfo[7])
self.winlua:SetChildWidgetMaterialFloat(self.star1_1:getID(),"_Value",colorInfo[8])
colorInfo=cfg.star2color
self.winlua:SetChildWidgetMaterialVector4(self.star2_1:getID(),"_Color",Vector4.New(colorInfo[1],colorInfo[2],colorInfo[3],colorInfo[4]))
self.winlua:SetChildWidgetMaterialFloat(self.star2_1:getID(),"_ColorMask",colorInfo[5])
self.winlua:SetChildWidgetMaterialFloat(self.star2_1:getID(),"_Hue",colorInfo[6])
self.winlua:SetChildWidgetMaterialFloat(self.star2_1:getID(),"_Saturation",colorInfo[7])
self.winlua:SetChildWidgetMaterialFloat(self.star2_1:getID(),"_Value",colorInfo[8])
end

for i,v in ipairs(self.background)do
local y=(i-2)*_pageHeight
v:setChildAnchoredPosition(Vector2.up*y)
end
for i,v in ipairs(self.cloud)do
local y=(i-2)*_pageHeight
v:setChildAnchoredPosition(Vector2.up*y)
end
for i,v in ipairs(self.star1)do
local y=(i-2)*_pageHeight
v:setChildAnchoredPosition(Vector2.up*y)
end
for i,v in ipairs(self.star2)do
local y=(i-2)*_pageHeight
v:setChildAnchoredPosition(Vector2.up*y)
end

local count=#_runePos
for i,v in ipairs(self.rune)do
v:setSprite(_rune_ab,cfg.sprite2)
local index=i%count
index=index>0 and index or count
local offset=math.ceil(i/count)-2
local offsetV=Vector2.up*(offset*_pageHeight)
v:setChildAnchoredPosition(_runePos[index]+offsetV)
end

self.waitTruck=0
self.waitFruit=0

if not tiandaoshuModel:isVocActive(voc)then
self.activeStageNum=0
self.fList={}
self.cdList={}


self.fruitList:setChildLayoutGroupCreateItems(0)
self.treeList:setChildLayoutGroupCreateItems(0)
self.topBtn:setActive(false)
self.bottomBtn:setActive(false)
self.treeList:setChildAnchoredPosition(Vector2.zero)


if not self.loadedSapling then
self.sapling:setChildUIModelShowTarget(self.bSpine,1,{},self.bAnimCfg[1],true,false,0,function()
self.loadedSapling=true
self:selectVocCheck(index)
end)
else
self.winlua:SetChildModelAnimationStop(self.sapling:getID(),self.bAnimCfg[1],0)
end
return
end


local vocCfg=tiandaoshuConfig:getVocConfig(voc)
local vocData=tiandaoshuModel:getVocData(voc)
self.activeStageNum=#vocData.list

local temp=self.activeStageNum>self.bAnimCnt and(self.activeStageNum-self.bAnimCnt)or 0
self.waitTruck=temp
self.treeList:setChildLayoutGroupCreateItems(temp,function(index)
self.waitTruck=self.waitTruck-1
local item=self.treeList:getChildLayoutGroupGridItem(index-1)
item.gameObject.name=tostring(index+self.bAnimCnt)
item:SetChildUIModelShowTarget(0,cfg.spine[index+self.bAnimCnt],1,{},self.eAnim,true,false,0,function()
item:SetChildModelAnimationStop(0,self.eAnim,1)
end)
item:SetAsLastSibling(-1)
self.winlua:SetAsLastSibling(self.fruitList:getID())
end)


self.topBtn:setActive(false)
self.bottomBtn:setActive(false)


self.fList={}
self.cdList={}
for stage=1,self.activeStageNum do
local stageCfg=tiandaoshuConfig:getStageConfig(voc,stage)
for fruit,fruitCfg in ipairs(stageCfg)do
table.insert(self.fList,{stage,fruit})
end
end

self.waitFruit=#self.fList
self.fruitList:setChildLayoutGroupCreateItems(#self.fList,function(index)
self.waitFruit=self.waitFruit-1
self:initFruit(voc,index)
end)
if#self.cdList>0 then
self:startFruitCDTick()
end


local saplingAnim=self.activeStageNum>self.bAnimCnt and self.bAnimCfg[self.bAnimCnt]or self.bAnimCfg[self.activeStageNum]
if saplingAnim then
if not self.loadedSapling then
self.sapling:setChildUIModelShowTarget(self.bSpine,1,{},saplingAnim,true,false,0,function()
self.loadedSapling=true
self.winlua:SetChildModelAnimationStop(self.sapling:getID(),saplingAnim,1)
self:selectVocCheck(index)
end)
else
self.winlua:SetChildModelAnimationStop(self.sapling:getID(),saplingAnim,1)
end
else
saplingAnim=self.bAnimCfg[1]
self.sapling:setChildUIModelShowTarget(self.bSpine,1,{},saplingAnim,true,false,0,function()
self.loadedSapling=true
self.winlua:SetChildModelAnimationStop(self.sapling:getID(),saplingAnim,0)
self:selectVocCheck(index)
end)
end
end

function UITianDaoShuWin:initFruit(voc,index)

local data=self.fList[index]
local item=self.fruitList:getChildLayoutGroupGridItem(index-1)
local stage=data[1]
local fruit=data[2]
local fruitData=tiandaoshuModel:getFruitData(voc,stage,fruit)
local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
item:SetChildAnchoredPosition(_fruitCmp.button,mathHelper.convertArrayToVector(fruitCfg.uiPos))
item:SetChildCSImageSprite(_fruitCmp.icon,_fruit_ab,fruitCfg.icon)
item:SetChildButtonClick(_fruitCmp.button,function()self:selectFruit(index)end)
item:SetChildAnimationStringID(_fruitCmp.select,'tiandaoshu_select',true)
item:SetChildAnimationStringID(_fruitCmp.flag,'tiandaoshu_lock',true)
item:SetChildActive(_fruitCmp.select,self.fSelected==index)
item.gameObject.name=table.concat({voc,stage,fruit,index},'_')
item:SetChildNewBieComponentId(_fruitCmp.root,FMT.fmt("UITianDaoShuWin.fruitItem.{0}",index))
self:refreshFruit(index,item,fruitData,fruitCfg)
end

function UITianDaoShuWin:refreshFruit(index,fItem,fruitData,fruitCfg)
local item=fItem or self.fruitList:getChildLayoutGroupGridItem(index-1)
if item==nil then return end
if fruitData then
if fruitCfg.unlockShow==1 then
item:SetChildGray(_fruitCmp.icon,fruitData.status<=tiandaoshuModel.eFruitStatus.eSeal)
item:SetChildActive(_fruitCmp.flag,fruitData.status<=tiandaoshuModel.eFruitStatus.eSeal)

else
item:SetChildGray(_fruitCmp.icon,fruitData.status<tiandaoshuModel.eFruitStatus.eSeal)
item:SetChildActive(_fruitCmp.flag,fruitData.status==tiandaoshuModel.eFruitStatus.eSeal)

end
item:SetChildActive(_fruitCmp.textBg,fruitData.status>=tiandaoshuModel.eFruitStatus.eNormal)
else
item:SetChildGray(_fruitCmp.icon,true)
item:SetChildActive(_fruitCmp.flag,false)
item:SetChildActive(_fruitCmp.textBg,false)
end
local textStr=""
if fruitData then
if fruitData.status==tiandaoshuModel.eFruitStatus.eNormal then
textStr=FMT.fmt("{0}/{1}",fruitData.count,fruitData.max)
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
local nowTime=timeHelper.getServerShortTime()
local cd=math.max(fruitData.duration-(nowTime-fruitData.cdTime),0)
textStr=FMT.fmt("{0}",timeHelper.format_time_stamp(cd))
table.insert(self.cdList,{index,fruitData})
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eCompleted then
textStr=FMT.fmt("<color=#76D81E>{0}/{1}</color>",fruitData.max,fruitData.max)
end
end
item:SetChildText(_fruitCmp.text,textStr)
item:ForceLayoutRect(_fruitCmp.textBg)
end

function UITianDaoShuWin:startFruitCDTick()
if not self.fruitCDTick then
self.fruitCDTick=self:setTimer(1,0,function()
self:onFruitCDTick()
end)
end
end

function UITianDaoShuWin:stopFruitCDTick()
if self.fruitCDTick then
self:stopTimerByID(self.fruitCDTick)
self.fruitCDTick=nil
end
end

function UITianDaoShuWin:onFruitCDTick()
local nowTime=timeHelper.getServerShortTime()
local rList={}
for i,v in ipairs(self.cdList)do
local index=v[1]
local fruitData=v[2]
local cd=math.max(fruitData.duration-(nowTime-fruitData.cdTime),0)
local item=self.fruitList:getChildLayoutGroupGridItem(index-1)
local textStr=FMT.fmt("{0}",timeHelper.format_time_stamp(cd))
if fruitData.status~=tiandaoshuModel.eFruitStatus.eCountDown then
if fruitData.status==tiandaoshuModel.eFruitStatus.eNormal then
textStr=FMT.fmt("{0}/{1}",fruitData.count,fruitData.max)
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eCompleted then
textStr=FMT.fmt("<color=#76D81E>{0}/{1}</color>",fruitData.max,fruitData.max)
end
table.insert(rList,i)
end
item:SetChildText(_fruitCmp.text,textStr)
end
for i=#rList,1,-1 do
local index=rList[i]
table.remove(self.cdList,index)
end
if#self.cdList<=0 then
self:stopFruitCDTick()
end
end

function UITianDaoShuWin:refreshTopArrow(y)
if self.waitStage then return end
local index=self:calculateScreenIndex(y)
local cStage=index>0 and(index+self.bAnimCnt)or 0
local show=self.activeStageNum>self.bAnimCnt and cStage<self.activeStageNum
self.topBtn:setActive(show)

if show then
local voc=self.vList[self.vSelected]
local vocData=tiandaoshuModel:getVocData(voc)
if vocData then
for stage=cStage+1,self.activeStageNum do
local stageData=vocData.list[stage]
for fruitId,fruitData in ipairs(stageData.list)do
if fruitData.status==tiandaoshuModel.eFruitStatus.eNormal or fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
self.topReddot:setActive(true)
return
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eLock then

local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruitId)
if tiandaoshuModel:checkConditions(fruitCfg.unlock)then
self.topReddot:setActive(true)
return
end
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eSeal then

if tiandaoshuModel:checkUnsealEnough(voc,stage,fruitId)then
self.topReddot:setActive(true)
return
end
end
end
end
end
self.topReddot:setActive(false)
end
end

function UITianDaoShuWin:refreshBottomArrow(y)
if self.waitStage then return end
local index=self:calculateScreenIndex(y)
if index>0 then
local lowStage=index+self.bAnimCnt-1
local voc=self.vList[self.vSelected]
local vocData=tiandaoshuModel:getVocData(voc)
if vocData then
for stage=lowStage,1,-1 do
local stageData=vocData.list[stage]
for fruitId,fruitData in ipairs(stageData.list)do
if fruitData.status==tiandaoshuModel.eFruitStatus.eNormal or fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
self.bottomBtn:setActive(true)
return
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eLock then

local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruitId)
if fruitCfg.unlockShow==1 and tiandaoshuModel:checkConditions(fruitCfg.unlock)then
self.bottomBtn:setActive(true)
return
end
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eSeal then

if tiandaoshuModel:checkUnsealEnough(voc,stage,fruitId)then
self.bottomBtn:setActive(true)
return
end
end
end
end
end



end
self.bottomBtn:setActive(false)
end

function UITianDaoShuWin:hideArrows()
self.topBtn:setActive(false)
self.bottomBtn:setActive(false)
end

function UITianDaoShuWin:refreshBottomStatus()
local data=self.fList[self.fSelected]
local voc=self.vList[self.vSelected]
local stage=data[1]
local fruit=data[2]
local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
local fruitData=tiandaoshuModel:getFruitData(voc,stage,fruit)

self.winlua:SetChildGray(self.selectIcon:getID(),fruitData.status<=tiandaoshuModel.eFruitStatus.eSeal)

local costList=fruitCfg.consume[fruitData.count+1]or fruitCfg.consume[fruitData.max]
if fruitData.status==tiandaoshuModel.eFruitStatus.eSeal then
costList=fruitCfg.unseal
end
self.costList:setChildLayoutGroupCreateItems(#costList,function(index)
local cost=costList[index]
local item=self.costList:getChildLayoutGroupGridItem(index-1)
local costId=cost[1]
local costNum=cost[2]
local countStr=''
local showCountBG=true
local haveNum=itemsModel.getCount(costId)
if not itemsConfig.isMoney(costId)then
if haveNum>=costNum then
haveNum=mathHelper.formatBIGNumbereEx(haveNum)
else
haveNum=FMT.cfmt(FONT_COLOR.eRedColor,mathHelper.formatBIGNumbereEx(haveNum))
end
countStr=FMT.fmt("{0}/{1}",haveNum,mathHelper.formatBIGNumbereEx(costNum))
else
if haveNum>=costNum then
countStr=tostring(costNum)
else
countStr=FMT.cfmt(FONT_COLOR.eRedColor,tostring(costNum))
end
end
local costData={itemid=costId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(costData)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,function(...)itemsComponentHelper.onItemClick(...)end)
end)

self.lockTx:setActive(fruitData.status==tiandaoshuModel.eFruitStatus.eLock)
self.jfBtn:setActive(fruitData.status==tiandaoshuModel.eFruitStatus.eSeal)
self.lwBtn:setActive(fruitData.status==tiandaoshuModel.eFruitStatus.eNormal)
self.cdTx:setActive(fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown)
self.completeTx:setActive(fruitData.status==tiandaoshuModel.eFruitStatus.eCompleted)

if fruitData.status==tiandaoshuModel.eFruitStatus.eLock then
local lockStr=tiandaoshuModel:getFirstConditionTips2(fruitCfg.unlock,voc)


self.lockTx:setText(lockStr)
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
local nowTime=timeHelper.getServerShortTime()
local cd=math.max(fruitData.duration-(nowTime-fruitData.cdTime))
local cdStr=FMT.fmt("下次领悟：{0}",timeHelper.format_time_stamp(cd))
self.cdTx:setText(cdStr)
if cd>0 then
self:startBottomTick()
else
self:stopBottomTick()
end
else
self:stopBottomTick()
end
end

function UITianDaoShuWin:refreshBottom()
local data=self.fList[self.fSelected]
local voc=self.vList[self.vSelected]
local stage=data[1]
local fruit=data[2]
local fruitCfg=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
local fruitData=tiandaoshuModel:getFruitData(voc,stage,fruit)

self.selectIcon:setSprite(_fruit_ab,fruitCfg.icon)
self.winlua:SetChildGray(self.selectIcon:getID(),fruitData.status<=tiandaoshuModel.eFruitStatus.eSeal)

local attrStr=tiandaoshuModel:getFruitAttrDesc(voc,fruitCfg.attr,fruitCfg.percent or{},fruitCfg.skill)
self.descTx:setText(attrStr)

local costList=fruitCfg.consume[fruitData.count+1]or fruitCfg.consume[fruitData.max]
if fruitData.status==tiandaoshuModel.eFruitStatus.eSeal then
costList=fruitCfg.unseal or{}
end
self.costList:setChildLayoutGroupCreateItems(#costList,function(index)
local cost=costList[index]
local item=self.costList:getChildLayoutGroupGridItem(index-1)
local costId=cost[1]
local costNum=cost[2]
local countStr=''
local showCountBG=true
local haveNum=itemsModel.getCount(costId)
if not itemsConfig.isMoney(costId)then
if haveNum>=costNum then
haveNum=mathHelper.formatBIGNumbereEx(haveNum)
else
haveNum=FMT.cfmt(FONT_COLOR.eRedColor,mathHelper.formatBIGNumbereEx(haveNum))
end
countStr=FMT.fmt("{0}/{1}",haveNum,mathHelper.formatBIGNumbereEx(costNum))
else
if haveNum>=costNum then
countStr=tostring(costNum)
else
countStr=FMT.cfmt(FONT_COLOR.eRedColor,tostring(costNum))
end
end
local costData={itemid=costId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(costData)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,function(...)itemsComponentHelper.onItemClick(...)end)
end)

self.lockTx:setActive(fruitData.status==tiandaoshuModel.eFruitStatus.eLock)
self.jfBtn:setActive(fruitData.status==tiandaoshuModel.eFruitStatus.eSeal)
self.lwBtn:setActive(fruitData.status==tiandaoshuModel.eFruitStatus.eNormal)
self.cdTx:setActive(fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown)
self.completeTx:setActive(fruitData.status==tiandaoshuModel.eFruitStatus.eCompleted)

if fruitData.status==tiandaoshuModel.eFruitStatus.eLock then

local lockStr=tiandaoshuModel:getFirstConditionTips2(fruitCfg.unlock,voc)

self.lockTx:setText(lockStr)
elseif fruitData.status==tiandaoshuModel.eFruitStatus.eCountDown then
local nowTime=timeHelper.getServerShortTime()
local cd=nowTime-fruitData.cdTime
local cdStr=FMT.fmt("下次领悟：{0}",timeHelper.format_time_stamp(cd))
self.cdTx:setText(cdStr)
if cd>0 then
self:startBottomTick()
else
self:stopBottomTick()
end
else
self:stopBottomTick()
end
end

function UITianDaoShuWin:startBottomTick()
if not self.bottomTick then
self.bottomTick=self:setTimer(1,0,function()
self:onBottomTick()
end)
end
end

function UITianDaoShuWin:stopBottomTick()
if self.bottomTick then
self:stopTimerByID(self.bottomTick)
self.bottomTick=nil
end
end

function UITianDaoShuWin:onBottomTick()
local data=self.fList[self.fSelected]
local voc=self.vList[self.vSelected]
local stage=data[1]
local fruit=data[2]
local fruitData=tiandaoshuModel:getFruitData(voc,stage,fruit)
local nowTime=timeHelper.getServerShortTime()
local cd=math.max(fruitData.duration-(nowTime-fruitData.cdTime),0)
local cdStr=FMT.fmt("下次领悟：{0}",timeHelper.format_time_stamp(cd))
self.cdTx:setText(cdStr)
if cd<=0 then
self:stopBottomTick()
end
end

function UITianDaoShuWin:clearBottom()
self:stopBottomTick()
end

function UITianDaoShuWin:showNewFruit(sIdx,eIdx,duration)

local items=self.fruitList:getChildLayoutGroupGridList()
duration=duration or 1
for i=sIdx,eIdx do
local item=items[i-1]
item:SetChildCanvasGroupDOFade(_fruitCmp.root,1,duration)
end
end

function UITianDaoShuWin:hideNewFruit(sIdx,eIdx)

local items=self.fruitList:getChildLayoutGroupGridList()
for i=sIdx,eIdx do
local item=items[i-1]
item:SetChildCanvasGroupAlpha(_fruitCmp.root,0)
end
end

function UITianDaoShuWin:onFinishAnimation()
self.animPart:setActive(false)
self.loadedSapling=true
self.waitStage=nil
local check=self:onStageBtn()
if not check then
self:refreshTopArrow()
self:refreshBottomArrow()
self:refreshStatisticsPanel()
self.leftPart:setActive(true)
self.leftPart:setChildCanvasGroupAlpha(0)
self.leftPart:setChildCanvasGroupDOFade(1,0.2)
self.rightPart:setActive(true)
self.rightPart:setChildCanvasGroupAlpha(0)
self.rightPart:setChildCanvasGroupDOFade(1,0.2)
self.backBtn:setActive(true)
self.backBtn:setChildCanvasGroupAlpha(0)
self.backBtn:setChildCanvasGroupDOFade(1,0.2)
self.moneyRoot:setActive(true)
self.moneyRoot:setChildCanvasGroupAlpha(0)
self.moneyRoot:setChildCanvasGroupDOFade(1,0.2)

for i,v in ipairs(self.fList)do
if v[1]==self.activeStageNum and v[2]==1 then
self:selectFruit(i)
break
end
end
end
end

function UITianDaoShuWin:onEmpty()
self:selectFruit()
end

function UITianDaoShuWin:onTreeView()
self:selectFruit()
end

function UITianDaoShuWin:initMoneyList()
local config=tiandaoshuConfig:getBaseConfig("money")
self.moneys={}
self.moneyRoot:setChildLayoutGroupCreateItems(#config,function(index)
local moneyItem=self.moneyRoot:getChildLayoutGroupGridItem(index-1)
local moneyType=config[index]
local moneyCount=itemsModel.getCount(moneyType)
moneyItem:SetChildCSImageIcon(0,iconHelper.getIconName(moneyType),false)
moneyItem:SetChildText(1,mathHelper.formatBIGNumbereEx(moneyCount))
moneyItem:SetChildButtonClick(-1,function()
gainControl:showGainWin(moneyType)
end)
self.moneys[moneyType]=index
end)
end

function UITianDaoShuWin.on_money_changed(moneyType,lastVal,val)
local index=_this.moneys[moneyType]
if index then
local moneyItem=_this.moneyRoot:getChildLayoutGroupGridItem(index-1)
moneyItem:SetChildText(1,mathHelper.formatBIGNumbereEx(val))
end

for i,v in ipairs(_this.statisticsDatas)do
if v.items[moneyType]then
v.reddot=tiandaoshuModel:getStatisticsTypeReddot(v.voc,v.statisticsType)
local item=_this.statisticsList:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(_statisticsCmp.reddot,v.reddot)
end
end
end

function UITianDaoShuWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
for i,v in ipairs(_this.statisticsDatas)do
if v.items[itemid]then
v.reddot=tiandaoshuModel:getStatisticsTypeReddot(v.voc,v.statisticsType)
local item=_this.statisticsList:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(_statisticsCmp.reddot,v.reddot)
_this:refreshBottomStatus()
end
end
end

function UITianDaoShuWin:getTreeListSizeDeltaY()
return(math.max(self.activeStageNum-self.bAnimCnt,0)+1)*_pageHeight
end

function UITianDaoShuWin:calculateScreenIndex(y)
if not y then
local pos=self.treeList:getChildAnchoredPosition()
y=pos.y
end
y=math.abs(y)
local delta=_pageHeight-self.treeViewHeight/2

if y<delta then
return 0
end
return math.ceil((y-delta)/_pageHeight)
end

function UITianDaoShuWin:needWaitActive()
return self.waitTruck>0 or self.waitFruit>0
end

function UITianDaoShuWin:setWaitActive(wVoc,wStage)
self.waitActiveStage={wVoc,wStage}
if not self.waitTick then
self.waitTick=self:setTimer(0.1,0,function()
if not self:needWaitActive()then
self:killWaitActive()
self.onTiandaoshuStageActived(self.waitActiveStage[1],self.waitActiveStage[2])
end
end)
end
end

function UITianDaoShuWin:killWaitActive()
if self.waitTick then
self:stopTimerByID(self.waitTick)
self.waitTick=nil
end
end


function UITianDaoShuWin:refreshResetRoot()

local voc=self.vList[self.vSelected]
local vocData=tiandaoshuModel:getVocData(voc)
local isShowReset=vocData~=nil and vocData.count>0

self.resetBtn:setActive(isShowReset)
end


function UITianDaoShuWin:onResetBtn()
local voc=self.vList[self.vSelected]
local vocData=tiandaoshuModel:getVocData(voc)

self:showWindow("UITianDaoShuResetWin",{voc=voc})
end
