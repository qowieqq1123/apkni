







def_class("UIShiLianTaEnterWin",UIWindowBase)









function UIShiLianTaEnterWin:bindComponents()

self.cancelButton=UIButton.get(self,0)
self.enterButton=UIButton.get(self,1)
self.head=UIObject.get(self,2)
self.itemPanel=UIObject.get(self,3)
self.jingjie=UIText.get(self,4)
self.jumpButton1=UIButton.get(self,5)
self.jumpButton2=UIButton.get(self,6)
self.LayerText=UIText.get(self,7)
self.level=UIText.get(self,8)
self.levelTips=UIObject.get(self,9)
self.levelTipsText=UIText.get(self,10)
self.listEndImage=UIObject.get(self,11)
self.listHead=UIObject.get(self,12)
self.listHead1=UIObject.get(self,13)
self.listHead2=UIObject.get(self,14)
self.ListPanel=UIObject.get(self,15)
self.logButton=UIButton.get(self,16)
self.logReddot=UIObject.get(self,17)
self.mask=UIObject.get(self,18)
self.model=UIObject.get(self,19)
self.modelRoot=UIObject.get(self,20)
self.RankButton=UIButton.get(self,21)
self.RankReddot=UIObject.get(self,22)
self.RewardButton=UIButton.get(self,23)
self.RewardEffect=UIObject.get(self,24)
self.RewardImg=UIImage.get(self,25)
self.RewardImgBX=UIImage.get(self,26)
self.RewardReddot=UIObject.get(self,27)
self.RewardText=UIText.get(self,28)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,29)
self.selectButton=UIButton.get(self,30)
self.selectText=UIText.get(self,31)
self.shadow=UIObject.get(self,32)
self.smoke=UIObject.get(self,33)
self.zhengTuButton=UIButton.get(self,34)
self.zhengTuReddot=UIObject.get(self,35)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.enterButton:setButtonClick(function()self:onEnterButton()end)

self.jumpButton1:setButtonClick(function()self:onJumpButton1()end)

self.jumpButton2:setButtonClick(function()self:onJumpButton2()end)

self.logButton:setButtonClick(function()self:onLogButton()end)

self.RankButton:setButtonClick(function()self:onRankButton()end)

self.RewardButton:setButtonClick(function()self:onRewardButton()end)

self.selectButton:setButtonClick(function()self:onSelectButton()end)

self.zhengTuButton:setButtonClick(function()self:onZhengTuButton()end)



end


function UIShiLianTaEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.enterButton);self.enterButton=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.jumpButton1);self.jumpButton1=nil;
_UIObject_release(self.jumpButton2);self.jumpButton2=nil;
_UIObject_release(self.LayerText);self.LayerText=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.levelTips);self.levelTips=nil;
_UIObject_release(self.levelTipsText);self.levelTipsText=nil;
_UIObject_release(self.listEndImage);self.listEndImage=nil;
_UIObject_release(self.listHead);self.listHead=nil;
_UIObject_release(self.listHead1);self.listHead1=nil;
_UIObject_release(self.listHead2);self.listHead2=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.logButton);self.logButton=nil;
_UIObject_release(self.logReddot);self.logReddot=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.RankButton);self.RankButton=nil;
_UIObject_release(self.RankReddot);self.RankReddot=nil;
_UIObject_release(self.RewardButton);self.RewardButton=nil;
_UIObject_release(self.RewardEffect);self.RewardEffect=nil;
_UIObject_release(self.RewardImg);self.RewardImg=nil;
_UIObject_release(self.RewardImgBX);self.RewardImgBX=nil;
_UIObject_release(self.RewardReddot);self.RewardReddot=nil;
_UIObject_release(self.RewardText);self.RewardText=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.selectButton);self.selectButton=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.shadow);self.shadow=nil;
_UIObject_release(self.smoke);self.smoke=nil;
_UIObject_release(self.zhengTuButton);self.zhengTuButton=nil;
_UIObject_release(self.zhengTuReddot);self.zhengTuReddot=nil;
end


















local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemBgCountIdx=2,
cmpItemTxtCountIdx=3,
cmpItemTxtStage=4,
}
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)

function UIShiLianTaEnterWin:onLoaded(...)
self:bindComponents()

self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self
self.scrollTimer=self:setTimer(0.02,0,function()
self:onScrollDrag()
end)

self.selectButton:setChildDragonTarget(2030,1,nil,eAnimationID.stand,false,0,false,nil)

shiLianTaController.req_13_1()
end


function UIShiLianTaEnterWin:__delete()
self.mask:setActive(true)
self.head:setActive(true)

if self.scrollTimer then
self:stopTimerByID(self.scrollTimer)
self.scrollTimer=nil
end

self:unbindComponents()

end




function UIShiLianTaEnterWin:onShow(argtable,afterOnloaded)
self.args=argtable

self.listHeadHide=true

shiLianTaModel.data.selectStage=self.args.selectStage

local selectLayer=self.args[2]
self.selectedLayer=selectLayer

self:refreshPanel(true,self.selectedLayer==nil,selectLayer)

if(not shiLianTaModel:getSectionRewardState())then
local weakGuide=3500
local isGuide=userActorSetting.get(FMT.fmt("weakGuide_{0}",weakGuide),0)
if isGuide~=1 then
local delay=self:setTimer(0.5,1,function()
weakGuideController:beginGuide(weakGuide)
end)
end
end

self:refreshZhengTuBtn()
end




function UIShiLianTaEnterWin:onHide()

end

function UIShiLianTaEnterWin:refreshPanel(anim,smoke)
anim=anim or false
smoke=smoke or false
local curLayer=shiLianTaModel:getCurLayer()
self.curLayer=curLayer
self.selectedLayer=self.selectedLayer or self.curLayer
local aimLayer,reType=shiLianTaModel:getCurAimLayer()
local isClearAll=shiLianTaModel:isClearAll()
self.isAimLayer=not shiLianTaModel:getSectionRewardState()
local aimLayer=shiLianTaModel:getSectionSelectLayer()


self:refreshReddot()

self:doPunchRotation2(shiLianTaModel:checkFirstClearRewardReddot()or false)
self.LayerText:setText(FMT.fmt("第{0}层",self.selectedLayer))

if aimLayer==curLayer-1 and not isClearAll then
aimLayer,reType=shiLianTaModel:getAimLayer(curLayer)
end

local current=isClearAll and curLayer or curLayer-1
local target=aimLayer>shiLianTaModel.finalRewardLayer and shiLianTaModel.finalRewardLayer or aimLayer
self.RewardText:setText(FMT.fmt("{0}/{1}层",current,target))


self:refreshList()
self:selectLayer(self.selectedLayer,anim,smoke)






self:onJump()

if self.selectedLayer>3 then
self.head:setActive(true)
else
self.head:setActive(false)
end
self.firstAnim=true
local afterAnim=self:setTimer(1,1,function()
if self and not self.isClose then
self.head:setActive(false)
self:onScrollDrag()
self.firstAnim=false
end
end)

end

function UIShiLianTaEnterWin:refreshRankReddot(flag)
self:doPunchRotation2(flag)
end

function UIShiLianTaEnterWin:refreshList()
local cfg=cfg_traintowerconfig()
local cfgLength=#cfg
local topLayer=cfgHelper.get(cfg_traintowerglobalconfig_get,1,"topLayer")
local length=cfgLength-self.curLayer<50 and cfgLength or(self.curLayer+50>=topLayer and topLayer or self.curLayer+50)

self.enhancedscrollscript:initData(self.disciplesList,71,length)

























































end

function UIShiLianTaEnterWin:selectLayer(layer,anim,smoke)
local cfg=cfgHelper.get1(cfg_traintowerconfig_get,layer)
if cfg then
local showMonster=cfg.showMonster
local showLog=cfg.tzRecord



self.smoke:setChildShowEffect(11001,smoke==true)
self.modelRoot:setActive(false)
self.model:setChildUIModelRemoveTarget()
local delay=self:setTimer(0.5,1,function()
if self and not self.isClose then
self.modelRoot:setActive(true)
self.model:setChildUIModelShowTarget(showMonster[1],showMonster[2],{},eAnimationID.stand,false,false,0,function()
self.model:setChildModelAnimationState(eAnimationID.stand)
end)

self.model:setChildUIModelShowTargetOffset(showMonster[3]or 0,showMonster[4]or 0)
self.shadow:setScale(Vector3(showMonster[5]or 1,showMonster[6]or 1,1))
end
end)

local reward=shiLianTaModel.getLayerReward(layer)

if reward then
if anim then
local delay=self:setTimer(1,1,function()
if self and not self.isClose then
self:showItemPanelAni(reward)
end
end)
else
self:showItemPanel(reward)
end
end

local monsterList,groupID=shiLianTaModel.getLayerMonsterList(layer)
if groupID then
self.level:setText(cfg.level or"")
end

self.logButton:setActive(showLog==1)

local curZMLevel=zongmenModel:getLevel()
local zmLevel=cfg.zmLevel
local showTips=zmLevel~=nil and curZMLevel<zmLevel
self.levelTips:setActive(showTips)
if showTips then
self.levelTipsText:setText(FMT.fmt("宗门<color=#d3a004>{0}级</color>可挑战",zmLevel))
end

end
end

function UIShiLianTaEnterWin:onListClick(clicknum,index)
local cfg=cfg_traintowerconfig()
local v=cfg[index+1]
if not v then
return
end
if self.selectedLayer==index+1 then
return
end


self:selectLayer(index+1,nil,true)

self.selectedLayer=index+1

self.LayerText:setText(FMT.fmt("第{0}层",self.selectedLayer))
end

function UIShiLianTaEnterWin:onItemClick(id,index,guid,attach)
itemsComponentHelper.onItemClick(id,index,guid,attach)
end

function UIShiLianTaEnterWin:showItemPanelAni(args)
local itemList=args
if itemList then
local count=4
self.itemPanel:setChildScrollViewDelayCreateGrids(count,count,0.2,1,true,false,function(id,item)
local reward=itemList[id+1]
if reward then
reward[2]=reward[2]==1 and 0 or reward[2]
widgetHelper.setNormalRewardItem(item,2,reward)
item:SetChildActive(1,true)
item:SetChildDOScale(2,1.2,0.3,function()
if self and not self.isClose then
item:SetChildDOScale(2,1,0.3,nil)
end
end)

item:SetChildDOLocalMoveY(2,10,0.2,function()
if self and not self.isClose then
item:SetChildDOLocalMoveY(2,0,0.4,nil)
end
end)
else
item:SetChildActive(1,false)
end
end)
end
end

function UIShiLianTaEnterWin:showItemPanel(args)
local itemList=args
if itemList then
local count=4
self.itemPanel:setChildScrollViewCreateGrids(count,count)

local grids=self.itemPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local reward=itemList[i+1]
if reward then
reward[2]=reward[2]==1 and 0 or reward[2]
widgetHelper.setNormalRewardItem(item,2,reward)
item:SetChildActive(1,true)
else
item:SetChildActive(1,false)
end
end
end
end

function UIShiLianTaEnterWin:refreshReddot()
local reddot=not shiLianTaModel:getSectionRewardState()

if reddot then
self.RewardEffect:setChildShowEffect(10304,true)
else
self.RewardEffect:setChildShowEffect(10304,false)
end
local aimLayerItem=nil
if aimLayerItem then
self.RewardImgBX:setActive(false)
self.RewardImg:setActive(true)
self.RewardImg:setChildIcon(iconHelper.getIconName(aimLayerItem[1]))
else
self.RewardImgBX:setActive(true)
self.RewardImg:setActive(false)
end

self:doPunchRotation1(reddot)
end

function UIShiLianTaEnterWin:doPunchRotation1(reddot)
self.RewardReddot:setActive(reddot)















end

function UIShiLianTaEnterWin:doPunchRotation2(reddot)
self.RankReddot:setActive(reddot)















end


function UIShiLianTaEnterWin:refreshZhengTuBtn()

local isOpenEnter=shiLianTaController:checkShiLianZhengTuEnter()
self.zhengTuButton:setActive(isOpenEnter)
self.zhengTuJumpMenuId=nil
if isOpenEnter then

local reddot,menuId=shiLianTaController:checkShiLianZhengTuEnterReddot()
self.zhengTuReddot:setActive(reddot)
self.zhengTuJumpMenuId=menuId
end
end

function UIShiLianTaEnterWin:onScrollDrag()
if self and not self.isClose then
self:onScrollEffectShow()

if self.headTimer then
return
end
self.headTimer=self:setTimer(0.4,1,function()
if self and not self.isClose then
self.headTimer=nil
end
end)


local listHead1Pos=self.listHead1:getChildUIScreenPos()

local cell=self.enhancedscrollscript:GetCell(1)
if cell then
if not self.listHeadHide then
self.listHead1:setLocalPosX(-25)
self.listHead2:setLocalPosX(80)
self.listHead1:setChildCanvasGroupAlpha(1)
self.listHead1:setChildDOLocalMoveX(-95,0.4,nil)
self.listHead1:setChildCanvasGroupDOFade(0,0.8,nil)
self.listHead2:setChildCanvasGroupAlpha(1)
self.listHead2:setChildDOLocalMoveX(150,0.4,nil)
self.listHead2:setChildCanvasGroupDOFade(0,0.8,nil)
self.listHeadHide=true
end
else
if self.listHeadHide then
self.listHead1:setLocalPosX(-95)
self.listHead2:setLocalPosX(150)
self.listHead1:setChildCanvasGroupAlpha(0)
self.listHead1:setChildDOLocalMoveX(-25,0.4,nil)
self.listHead1:setChildCanvasGroupDOFade(1,0.4,nil)
self.listHead2:setChildCanvasGroupAlpha(0)
self.listHead2:setChildDOLocalMoveX(80,0.4,nil)
self.listHead2:setChildCanvasGroupDOFade(1,0.4,nil)
self.listHeadHide=false
end
end

if self.curLayer and not self.firstAnim then
local curGrid=self.enhancedscrollscript:GetCell(self.curLayer)

if curGrid then





























self.jumpButton1:setActive(false)
self.jumpButton2:setActive(false)
else
if self.enhancedscrollscript.refreshLayer then
if self.enhancedscrollscript.refreshLayer>self.curLayer then
self.jumpButton1:setActive(true)
self.jumpButton2:setActive(false)
else
self.jumpButton1:setActive(false)
self.jumpButton2:setActive(true)
end
end
end
end
end
end

function UIShiLianTaEnterWin:onScrollEffectShow()
























end





function UIShiLianTaEnterWin:onRewardButton()
shiLianTaController:showRewardWindow()
end

function UIShiLianTaEnterWin:onRankButton()
shiLianTaController:showRankWindow(shiLianTaModel.RankPanelType.Rank)
end

function UIShiLianTaEnterWin:onSelectButton()
self:onEnterButton()
end

function UIShiLianTaEnterWin:onSelectClickDown()
self.selectButton:setChildModelAnimationState(eAnimationID.idle1)
end

function UIShiLianTaEnterWin:onEnterButton()

if not(self and not self.isClose)then
return
end

if self.selectedLayer<self.curLayer or self.args[1]==1 then
UIManager.error("该层已通关")
return
elseif self.selectedLayer>self.curLayer then
UIManager.error(FMT.fmt("需要通关第{0}层",self.curLayer))
return
end

if shiLianTaModel:isZMLevelNotEnough(self.selectedLayer,true)then
return
end

local viewFight=cfgHelper.get2(cfg_traintowerconfig_get,self.curLayer,"viewFight")
local globalCfg=cfgHelper.get(cfg_traintowerglobalconfig_get,1)
local monsterList,groupID=shiLianTaModel.getLayerMonsterList(self.curLayer)
local winArgs=
{
enterCallBack=function(guidList,zfId,map)
shiLianTaController.selectDiscipleCallBack(guidList,zfId,nil)
end,
enterTxt="锁妖塔",
cancelCallBack=shiLianTaController.cancelSelectDiscipleCallBack,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
monsterList=monsterList,
groupId=groupID,
cantEnter=self.args[1]==1,
cantEnterTips="锁妖塔已通关",
fightType=fightPreSelectModel.fightType.shilianta,
dontCloseStage=true,
enterBehaviorId=1,
monsterFight=viewFight,
statePriorityCheck=false,
fightCompareTips=globalCfg.fightCompareTips,
fightCompareValue=globalCfg.fightCompare,
}
if self.args[5]>0 then
local teamList={}
for i,v in ipairs(self.args[6])do
if v.unitType>0 then
teamList[i]=v.unitId
end
end
winArgs.teamList=teamList
else
local teamList=fightPreSelectModel:getTeamData(fightPreSelectModel.fightType.shilianta)
winArgs.teamList=teamList
end




local stage=self.args.selectStage



fightManager.initCamera(Vector3.New(0,3,-3.8),Vector3.New(0,-0.6,0),Vector3.New(0,1.1,-2.5),Vector3.New(0,0,0),15)


UIManager:closeWindow("UIShiLianTaEnterWin")

fightController:setSelectMask({1,2,3,4,5})
UIFullFightPrepareControl:showPrepareWindowWithoutStage(winArgs,stage)




end

function UIShiLianTaEnterWin:onCancelButton()

if not(self and not self.isClose)then
return
end

shiLianTaModel.data.selectStage=nil
UIFullFightPrepareControl:closeUI(true,true)
fightController:closeSelectStage()

end

function UIShiLianTaEnterWin:onZhengTuButton()

shiLianTaController:showShiLianZhengTuWindow(self.zhengTuJumpMenuId)
end

function UIShiLianTaEnterWin:onJump()
self:onListClick(1,self.curLayer-1)
if self.selectedLayer<=4 then

self.enhancedscrollscript:jumpToDataIndex(0,0,0,true,0,0,nil)
else

self.enhancedscrollscript:jumpToDataIndex(self.selectedLayer-4,0,0,true,0,0,nil)
end
end

function UIShiLianTaEnterWin:onJumpButton1()
self:onJump()
end

function UIShiLianTaEnterWin:onJumpButton2()
self:onJump()
end

function UIShiLianTaEnterWin:onLogButton()
UIFullFightPrepareControl:showWindow('UIShiLianTaLogWin',{layer=self.selectedLayer})
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end


function UIPrepareEnScroller:RefreshCell(i,cellIndex,item)
if self.window and self.window.isClose then
return
end
self.refreshLayer=i
local cfg=cfg_traintowerconfig()
local layer
local v=cfg[i]
if item then
if v then
layer=v.id
item:SetChildText(0,FMT.fmt("第{0}层",layer))
item:SetChildActive(8,layer==1)
























if layer==self.window.curLayer and self.window.args[1]~=1 then
item:SetChildCanvasGroupAlpha(1,1)
item:SetChildCanvasGroupAlpha(2,0)
item:SetChildCanvasGroupAlpha(3,0)
elseif layer>self.window.curLayer then
item:SetChildCanvasGroupAlpha(3,1)
item:SetChildCanvasGroupAlpha(1,0)
item:SetChildCanvasGroupAlpha(2,0)
elseif layer<self.window.curLayer or(self.window.args[1]==1)then
item:SetChildCanvasGroupAlpha(1,0)
item:SetChildCanvasGroupAlpha(2,1)
item:SetChildCanvasGroupAlpha(3,0)
end


local sectionLayer=shiLianTaModel:isSectionLayer(layer)~=nil


item:SetChildActive(6,sectionLayer)
if sectionLayer then
if layer>self.window.curLayer then
item:SetChildShowEffect(7,10107,true)
else
item:SetChildShowEffect(7,10110,true)
end

else
item:SetChildShowEffect(7,10110,false)
end

item:SetChildActive(4,self.window.selectedLayer==layer)
else
item:SetChildActive(5,false)
end
end
end

function UIPrepareEnScroller:onItemClick(data,cellIndex,dataIndex,cell,exchangeIndex,behaviour,notTips,appearTips)
local cfg=cfg_traintowerconfig()
dataIndex=dataIndex+1
local v=cfg[dataIndex]
if not v then
return
end
if self.window.selectedLayer==dataIndex then
return
end
self.window:selectLayer(dataIndex,nil,true)
self.window.selectedLayer=dataIndex
self.window.LayerText:setText(FMT.fmt("第{0}层",self.window.selectedLayer))
end