







def_class("UIJiuYouTaEnterWin",UIWindowBase)









function UIJiuYouTaEnterWin:bindComponents()

self.buffRoot=UIObject.get(self,0)
self.buffText=UIText.get(self,1)
self.cancelButton=UIButton.get(self,2)
self.enterButton=UIButton.get(self,3)
self.head=UIObject.get(self,4)
self.helpButton=UIButton.get(self,5)
self.itemPanel=UIObject.get(self,6)
self.jingjie=UIText.get(self,7)
self.jumpButton1=UIButton.get(self,8)
self.jumpButton2=UIButton.get(self,9)
self.LayerText=UIText.get(self,10)
self.level=UIText.get(self,11)
self.levelTips=UIObject.get(self,12)
self.levelTipsText=UIText.get(self,13)
self.listEndImage=UIObject.get(self,14)
self.listHead=UIObject.get(self,15)
self.listHead1=UIObject.get(self,16)
self.listHead2=UIObject.get(self,17)
self.ListPanel=UIObject.get(self,18)
self.logButton=UIButton.get(self,19)
self.logReddot=UIObject.get(self,20)
self.mask=UIObject.get(self,21)
self.model=UIObject.get(self,22)
self.modelRoot=UIObject.get(self,23)
self.multiTeam=UIText.get(self,24)
self.multiTeamBg=UIObject.get(self,25)
self.RankButton=UIButton.get(self,26)
self.RankReddot=UIObject.get(self,27)
self.rating=UIText.get(self,28)
self.ratingRoot=UIButton.get(self,29)
self.RewardButton=UIButton.get(self,30)
self.RewardEffect=UIObject.get(self,31)
self.RewardImg=UIImage.get(self,32)
self.RewardImgBX=UIImage.get(self,33)
self.RewardReddot=UIObject.get(self,34)
self.RewardText=UIText.get(self,35)
self.scoreJianTou=UIObject.get(self,36)
self.scoreJianTou2=UIObject.get(self,37)
self.scoreList=UILoopListView.new(self,38)
self.scoreMove=UIObject.get(self,39)
self.scoreRoot=UIButton.get(self,40)
self.scoreTitle=UIText.get(self,41)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,42)
self.selectButton=UIButton.get(self,43)
self.selectReddot=UIObject.get(self,44)
self.selectText=UIText.get(self,45)
self.shadow=UIObject.get(self,46)
self.smoke=UIObject.get(self,47)
self.zhengTuButton=UIButton.get(self,48)
self.zhengTuReddot=UIObject.get(self,49)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.enterButton:setButtonClick(function()self:onEnterButton()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.jumpButton1:setButtonClick(function()self:onJumpButton1()end)

self.jumpButton2:setButtonClick(function()self:onJumpButton2()end)

self.logButton:setButtonClick(function()self:onLogButton()end)

self.RankButton:setButtonClick(function()self:onRankButton()end)

self.ratingRoot:setButtonClick(function()self:onRatingRoot()end)

self.RewardButton:setButtonClick(function()self:onRewardButton()end)

self.scoreList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.scoreRoot:setButtonClick(function()self:onScoreRoot()end)

self.selectButton:setButtonClick(function()self:onSelectButton()end)

self.zhengTuButton:setButtonClick(function()self:onZhengTuButton()end)



end


function UIJiuYouTaEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buffRoot);self.buffRoot=nil;
_UIObject_release(self.buffText);self.buffText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.enterButton);self.enterButton=nil;
_UIObject_release(self.head);self.head=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
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
_UIObject_release(self.multiTeam);self.multiTeam=nil;
_UIObject_release(self.multiTeamBg);self.multiTeamBg=nil;
_UIObject_release(self.RankButton);self.RankButton=nil;
_UIObject_release(self.RankReddot);self.RankReddot=nil;
_UIObject_release(self.rating);self.rating=nil;
_UIObject_release(self.ratingRoot);self.ratingRoot=nil;
_UIObject_release(self.RewardButton);self.RewardButton=nil;
_UIObject_release(self.RewardEffect);self.RewardEffect=nil;
_UIObject_release(self.RewardImg);self.RewardImg=nil;
_UIObject_release(self.RewardImgBX);self.RewardImgBX=nil;
_UIObject_release(self.RewardReddot);self.RewardReddot=nil;
_UIObject_release(self.RewardText);self.RewardText=nil;
_UIObject_release(self.scoreJianTou);self.scoreJianTou=nil;
_UIObject_release(self.scoreJianTou2);self.scoreJianTou2=nil;
self.scoreList:deleteSelf();self.scoreList=nil;
_UIObject_release(self.scoreMove);self.scoreMove=nil;
_UIObject_release(self.scoreRoot);self.scoreRoot=nil;
_UIObject_release(self.scoreTitle);self.scoreTitle=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.selectButton);self.selectButton=nil;
_UIObject_release(self.selectReddot);self.selectReddot=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.shadow);self.shadow=nil;
_UIObject_release(self.smoke);self.smoke=nil;
_UIObject_release(self.zhengTuButton);self.zhengTuButton=nil;
_UIObject_release(self.zhengTuReddot);self.zhengTuReddot=nil;
end


















local UIPrepareEnScroller=simple_class(UIEnhancedScroller)


function UIJiuYouTaEnterWin:onLoaded(...)
self:bindComponents()

self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self
self.scrollTimer=self:setTimer(0.02,0,function()
self:onScrollDrag()
end)

self.selectButton:setChildUIModelShowTarget(2030,1,nil,eAnimationID.stand,false,false,0,nil)
local isBanPlay,BanPlayTime=JiuYouTaModel:isInBanPlayTime()
self.winid:SetChildUIModelGray(self.selectButton:getID(),isBanPlay)

end


function UIJiuYouTaEnterWin:__delete()

self.mask:setActive(true)
self.head:setActive(true)

if self.scrollTimer then
self:stopTimerByID(self.scrollTimer)
self.scrollTimer=nil
end

self:unbindComponents()
end




function UIJiuYouTaEnterWin:onShow(argtable,afterOnloaded)
self.args=argtable

self.listHeadHide=true

JiuYouTaModel.data.selectStage=self.args.selectStage

local selectLayer=self.args[1]
self.selectedLayer=selectLayer

self:refreshPanel(true,self.selectedLayer==nil,selectLayer)

end


function UIJiuYouTaEnterWin:onHide()

end

function UIJiuYouTaEnterWin:onRecvGotReward()
local clearLayer=JiuYouTaModel:getClearLayer()
local aimLayer=JiuYouTaModel:getSectionSelectLayer()or JiuYouTaModel:getAimLayer(clearLayer)
self.RewardText:setText(FMT.fmt("{0}/{1}层",clearLayer,aimLayer))
self:refreshReddot()
end

function UIJiuYouTaEnterWin:refreshPanel(anim,smoke)
anim=anim or false
smoke=smoke or false
local curLayer=JiuYouTaModel:getCurLayer()
local clearLayer=JiuYouTaModel:getClearLayer()
self.curLayer=curLayer
self.selectedLayer=self.selectedLayer or self.curLayer

self:refreshReddot()
self:refreshTiaoZhanReddot()

self:doPunchRotation2(false)

self.LayerText:setText(FMT.fmt("第{0}层",self.selectedLayer))

local aimLayer=JiuYouTaModel:getSectionSelectLayer()or JiuYouTaModel:getAimLayer(clearLayer)

self.RewardText:setText(FMT.fmt("{0}/{1}层",clearLayer,aimLayer))


self:refreshList()
self:selectLayer(self.selectedLayer,anim,smoke)


self:onJump()

if self.selectedLayer>3 then
self.head:setActive(true)
else
self.head:setActive(false)
end
self.firstAnim=true
self:setTimer(1,1,function()
if self and not self.isClose then
self.head:setActive(false)
self:onScrollDrag()
self.firstAnim=false
end
end)




self.selectButton:setActive(true)


self:refreshRating()
end

function UIJiuYouTaEnterWin:refreshRankReddot(flag)
self:doPunchRotation2(flag)
end

function UIJiuYouTaEnterWin:refreshList()
local config=cfg_jiuyoutalayerconfig()
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
local cfg=config[rankType]or{}
local cfgLength=#cfg
local length=cfgLength
self.layerList=cfg

self.enhancedscrollscript:initData(self.layerList,85,length)

end

function UIJiuYouTaEnterWin:refreshRating()
local cfg=cfg_jiuyoutalayelevelrconfig()
local rankType=JiuYouTaModel:getJiuYouTaRankType()or 1
local rankCfg=cfg[rankType]
self.rating:setText(rankCfg[JiuYouTaModel:getJiuYouTaRating()].name)
end

function UIJiuYouTaEnterWin:selectLayer(layer,anim,smoke)
local cfg=self.layerList[layer]
if cfg then
self.scoreTitle:setText(FMT.fmt("本层积分：{0}",JiuYouTaModel:getScore(layer)))

local showMonster=cfg.showMonster


self.smoke:setChildShowEffect(11001,smoke==true)
self.modelRoot:setActive(false)
self.model:setChildUIModelRemoveTarget()
self:setTimer(0.5,1,function()
if self and not self.isClose then
self.modelRoot:setActive(true)
self.model:setChildUIModelShowTarget(showMonster[1],showMonster[2],{},eAnimationID.stand,false,false,0,function()
self.model:setChildModelAnimationState(eAnimationID.stand)
end)

self.model:setChildUIModelShowTargetOffset(showMonster[3]or 0,showMonster[4]or 0)
self.shadow:setScale(Vector3(showMonster[5]or 1,showMonster[6]or 1,1))
end
end)

local reward=cfg.pass_reward

if reward then
local rating=JiuYouTaModel:getJiuYouTaRating()
local exReward=cfg.pass_ex_reward[rating]or defaultT
















self:showItemPanel(reward,exReward)

end



local isInBanPlayTime,banPlayTime=JiuYouTaModel:isInBanPlayTime()

if isInBanPlayTime then
self.multiTeamBg:setActive(true)
self.multiTeam:setText("玩法进入休赛期，将于15号重新开启")
self.winid:SetChildUIModelGray(self.selectButton:getID(),true)
else
self.winid:SetChildUIModelGray(self.selectButton:getID(),false)
local monsterList=JiuYouTaModel.getLayerMonsterGroupList(layer)
local monLength=#monsterList
if monLength>1 then
self.multiTeamBg:setActive(true)
self.multiTeam:setText(FMT.fmt("本层需要{0}支队伍挑战",monLength))
else
self.multiTeamBg:setActive(false)
end
end
end
end

function UIJiuYouTaEnterWin:onListClick(clicknum,index)
if self.selectedLayer==index+1 then
return
end

self:selectLayer(index+1,nil,true)

self.selectedLayer=index+1

self.LayerText:setText(FMT.fmt("第{0}层",self.selectedLayer))


end

function UIJiuYouTaEnterWin:onItemClick(id,index,guid,attach)
itemsComponentHelper.onItemClick(id,index,guid,attach)
end

function UIJiuYouTaEnterWin:showItemPanelAni(args,exList)
local itemList=args
if itemList then
local itemLength=#itemList
local count=itemLength+#exList
self.itemPanel:setChildLayoutGroupCreateItems(count,function(id)
local item=self.itemPanel:getChildLayoutGroupGridItem(id-1)
local reward=itemList[id]
if not reward then
reward=exList[id-itemLength]
reward.ex=1
end
if reward then
reward[2]=reward[2]==1 and 0 or reward[2]
reward.showStage=true
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
item:SetChildActive(0,reward.ex==1)
else
item:SetChildActive(1,false)
end
end)



end
end

function UIJiuYouTaEnterWin:showItemPanel(args,exList)
local itemList=args
if itemList then
local itemLength=#itemList
local count=itemLength+#exList
self.itemPanel:setChildLayoutGroupCreateItems(count)

local grids=self.itemPanel:getChildLayoutGroupGridList()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
item:SetChildAnchoredPosition(2,Vector2.zero)
local reward=itemList[i+1]
if reward then
reward[2]=reward[2]==1 and 0 or reward[2]
reward.showStage=true
widgetHelper.setNormalRewardItem(item,2,reward)
item:SetChildActive(1,true)
item:SetChildActive(0,false)
else
reward=exList[i+1-itemLength]
if reward then
reward[2]=reward[2]==1 and 0 or reward[2]
reward.showStage=true
widgetHelper.setNormalRewardItem(item,2,reward)
item:SetChildActive(0,true)
item:SetChildActive(1,true)
else
item:SetChildActive(0,false)
item:SetChildActive(1,false)
end

end
end
end
end

function UIJiuYouTaEnterWin:refreshReddot()
local reddot=JiuYouTaModel:getSectionRewardState()

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

function UIJiuYouTaEnterWin:refreshTiaoZhanReddot()
local reddot=JiuYouTaModel:getDayChallengeReddot()
self.selectReddot:setActive(reddot)
if reddot then
if self.reddotTweener==nil then
self:setChildRotation(self.selectReddot:getID(),0,0,0)
local tweener=self:setChildDOPunchRotation(self.selectReddot:getID(),Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener;
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self:setChildRotation(self.selectReddot:getID(),0,0,0)
end
end
end

function UIJiuYouTaEnterWin:doPunchRotation1(reddot)
self.RewardReddot:setActive(reddot)
end

function UIJiuYouTaEnterWin:doPunchRotation2(reddot)
self.RankReddot:setActive(reddot)
end


function UIJiuYouTaEnterWin:onScrollDrag()
if self and not self.isClose then


if self.headTimer then
return
end
self.headTimer=self:setTimer(0.4,1,function()
if self and not self.isClose then
self.headTimer=nil
end
end)

local cell=self.enhancedscrollscript:GetCell(1)
if cell then
if not self.listHeadHide then
self.listHead1:setLocalPosX(-25+20)
self.listHead2:setLocalPosX(80+20)
self.listHead1:setChildCanvasGroupAlpha(1)
self.listHead1:setChildDOLocalMoveX(-95+20,0.4,nil)
self.listHead1:setChildCanvasGroupDOFade(0,0.8,nil)
self.listHead2:setChildCanvasGroupAlpha(1)
self.listHead2:setChildDOLocalMoveX(150+20,0.4,nil)
self.listHead2:setChildCanvasGroupDOFade(0,0.8,nil)
self.listHeadHide=true
end
else
if self.listHeadHide then
self.listHead1:setLocalPosX(-95+20)
self.listHead2:setLocalPosX(150+20)
self.listHead1:setChildCanvasGroupAlpha(0)
self.listHead1:setChildDOLocalMoveX(-25+20,0.4,nil)
self.listHead1:setChildCanvasGroupDOFade(1,0.4,nil)
self.listHead2:setChildCanvasGroupAlpha(0)
self.listHead2:setChildDOLocalMoveX(80+20,0.4,nil)
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






function UIJiuYouTaEnterWin:onCancelButton()
if not(self and not self.isClose)then
return
end
self.scoreList:setActive(false)
self.multiTeamBg:setActive(false)
JiuYouTaModel.data.selectStage=nil
UIFullJiuYouTaControl:closeUI(true,true)
fightController:closeSelectStage()
end



function UIJiuYouTaEnterWin:onEnterButton()
end

function UIJiuYouTaEnterWin:onJump()
self:onListClick(1,self.selectedLayer-1)
if self.selectedLayer<=4 then
self.enhancedscrollscript:jumpToDataIndex(0,0,0,true,0,0,nil)
else
self.enhancedscrollscript:jumpToDataIndex(self.selectedLayer-4,0,0,true,0,0,nil)
end
end



function UIJiuYouTaEnterWin:onJumpButton1()
self:onJump()
end



function UIJiuYouTaEnterWin:onJumpButton2()
self:onJump()
end



function UIJiuYouTaEnterWin:onLogButton()
self:showWindow("UIJiuYouTaLogWin",{layer=self.selectedLayer})
end



function UIJiuYouTaEnterWin:onRankButton()
self:showWindow("UIJiuYouTaRankTpyeWin",{tabType=1})
end



function UIJiuYouTaEnterWin:onRewardButton()
self:showWindow("UIJiuYouTaRewardSelectWin")
end



function UIJiuYouTaEnterWin:onSelectButton(selectedLayer)

selectedLayer=selectedLayer or self.selectedLayer
local isBanPlay,banPlayTime=JiuYouTaModel:isInBanPlayTime()
if isBanPlay then
UIManager.error("休赛期无法进行挑战")
return
end

local clearLayer=JiuYouTaModel:getClearLayer()
if selectedLayer<=clearLayer and not JiuYouTaModel:getExLayer(selectedLayer)then
UIManager.error("本层已通关")
return
end

if selectedLayer>self.curLayer then
UIManager.error(FMT.fmt("需先通关第{0}层",self.curLayer))
return
end




local layer=selectedLayer

local monsterList=JiuYouTaModel.getLayerMonsterGroupList(layer)

local fightList={}
local multipleMonsterList={}
for i,v in ipairs(monsterList)do
table.insert(fightList,JiuYouTaModel:getMonsterFightVal(layer,i))
table.insert(multipleMonsterList,cfgHelper.get2(cfg_monstergroup_get,v,"monList"))
end

local temNum=#monsterList
local teamData=fightPreSelectModel:getMulTeamSaveData(eFightPreSelectType.jiuyouta,temNum)
self.scoreList:setActive(false)
self.multiTeamBg:setActive(false)
local winArgs=
{
enterCallBack=function(guidList,zfId,map)
JiuYouTaModel:setDayChallengeReddot()
JiuYouTaController.selectDiscipleCallBack(guidList,zfId,nil,layer)
end,
enterTxt="九幽塔",
cancelCallBack=JiuYouTaController.cancelSelectDiscipleCallBack,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
multipleMonsterList=multipleMonsterList,
groupId=monsterList[1],
multipleTeams=teamData,


fightType=eFightPreSelectType.jiuyouta,
dontCloseStage=true,
enterBehaviorId=1,
statePriorityCheck=false,
monsterFightEx=fightList,
mapId=cfgHelper.get2(cfg_monstergroup_get,monsterList[1],"mapId"),
}
local stage=self.args.selectStage
fightManager.initCamera(Vector3.New(0,3,-3.8),Vector3.New(0,-0.6,0),Vector3.New(0,1.1,-2.5),Vector3.New(0,0,0),15)
UIManager:closeWindow("UIJiuYouTaEnterWin")
fightController:setSelectMask({1,2,3,4,5})

UIFullFightPrepareControl:showPrepareWindowWithoutStage(winArgs,stage)



end

function UIJiuYouTaEnterWin:onSelectClickDown()
self.selectButton:setChildModelAnimationState(eAnimationID.idle1)
end



function UIJiuYouTaEnterWin:onZhengTuButton()

end

function UIJiuYouTaEnterWin:onRatingRoot()
self:showWindow("UIJiuYouTaRewardWin",{layer=self.selectedLayer})
end

function UIJiuYouTaEnterWin:onHelpButton()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='jiuyouta_help_%s'})
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

local layer
local v=self.window.layerList[i]

local clearLayer=JiuYouTaModel:getClearLayer()

if item then
if v then
layer=v.layer_id
item:SetChildText(0,FMT.fmt("第{0}层",layer))
item:SetChildActive(8,layer==1)

if layer==self.window.curLayer and layer~=clearLayer then
item:SetChildCanvasGroupAlpha(1,1)
item:SetChildCanvasGroupAlpha(2,0)
item:SetChildCanvasGroupAlpha(3,0)
elseif layer>clearLayer then
item:SetChildCanvasGroupAlpha(3,1)
item:SetChildCanvasGroupAlpha(1,0)
item:SetChildCanvasGroupAlpha(2,0)
elseif layer<=clearLayer then
item:SetChildCanvasGroupAlpha(1,0)
item:SetChildCanvasGroupAlpha(2,1)
item:SetChildCanvasGroupAlpha(3,0)
end


local sectionLayer=JiuYouTaModel:getExLayer(layer)or false


item:SetChildActive(6,sectionLayer)

item:SetChildActive(4,self.window.selectedLayer==layer)

if self.window.selectedLayer==layer then
self.refreshLayer=i
end

if sectionLayer then
item:SetChildButtonClick(6,function()
self:onItemClick(nil,cellIndex,i-1,item)
end)
end
else
item:SetChildActive(5,false)
end
end
end

function UIPrepareEnScroller:onItemClick(data,cellIndex,dataIndex,cell)
dataIndex=dataIndex+1
local v=self.window.layerList[dataIndex]
if not v then
return
end
if self.window.selectedLayer==dataIndex then
return
end
self.window:selectLayer(dataIndex,nil,true)
self.window.selectedLayer=dataIndex
self.window.LayerText:setText(FMT.fmt("第{0}层",self.window.selectedLayer))

if self.refreshLayer then
local oldcell=self:GetCell(self.refreshLayer-1)
if oldcell then
oldcell:SetChildActive(4,false)
end
end
if cell then
cell:SetChildActive(4,true)
end
self.refreshLayer=dataIndex
end

function UIJiuYouTaEnterWin:onFreshAction(i,grid)
local data=self.exLayerList[i]
grid:SetChildText(0,FMT.fmt("第{0}层：{1}",data.layer_id,JiuYouTaModel:getScore(data.layer_id)))
grid:SetChildButtonClick(1,function()
self:onSelectButton(data.layer_id)
end)
grid:SetChildGray(1,data.layer_id>self.curLayer)
grid:SetChildActive(2,data.layer_id==self.curLayer)
end

function UIJiuYouTaEnterWin:onStartAction(i,grid)

end

function UIJiuYouTaEnterWin:onScoreRoot()
self.isShowScorePanel=not self.isShowScorePanel

self.scoreJianTou:setActive(not self.isShowScorePanel)
self.scoreJianTou2:setActive(self.isShowScorePanel)
self.scoreList:setActive(self.isShowScorePanel)
if self.isShowScorePanel then
if not self.exLayerList then
local exLayerList={}
for i,v in ipairs(self.layerList)do
if JiuYouTaModel:getExLayer(v.layer_id)then
table.insert(exLayerList,v)
end
end
self.exLayerList=exLayerList
end
self.scoreList:initData("item",self.exLayerList)
self.scoreMove:setLocalPosY(300)
self.scoreMove:setChildDOAnchorPosY(0,0.2)
end
end