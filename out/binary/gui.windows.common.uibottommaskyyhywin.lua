







def_class("UIBottomMaskYYHYWin",UIWindowBase)









function UIBottomMaskYYHYWin:bindComponents()

self.root=UIObject.get(self,0)
self.animFg=UIObject.get(self,1)
self.title=UIText.get(self,2)
self.animMmc=UIObject.get(self,3)
self.mouse_1=UIObject.get(self,4)
self.mouse_2=UIObject.get(self,5)
self.menu=UIObject.get(self,6)
self.animFan=UIObject.get(self,7)
self.scrollView=UIScrollView.get(self,8)
self.mouseClick1=UIButton.get(self,9)
self.mouseClick2=UIButton.get(self,10)
self.dropList_1=UIObject.get(self,11)
self.dropList_2=UIObject.get(self,12)
self.spinebg=UIObject.get(self,13)
self.spineboss=UIObject.get(self,14)
self.npcClicker=UIButton.get(self,15)
self.speakObj=UIObject.get(self,16)
self.speakText=UIText.get(self,17)

self.mouseClick1:setButtonClick(function()self:onMouseClick1()end)

self.mouseClick2:setButtonClick(function()self:onMouseClick2()end)

self.npcClicker:setButtonClick(function()self:onNpcClicker()end)
self.mouse={
self.mouse_1,
self.mouse_2,
}
self.dropList={
self.dropList_1,
self.dropList_2,
}



end


function UIBottomMaskYYHYWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.animFg);self.animFg=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.animMmc);self.animMmc=nil;
_UIObject_release(self.mouse_1);self.mouse_1=nil;
_UIObject_release(self.mouse_2);self.mouse_2=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.animFan);self.animFan=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.mouseClick1);self.mouseClick1=nil;
_UIObject_release(self.mouseClick2);self.mouseClick2=nil;
_UIObject_release(self.dropList_1);self.dropList_1=nil;
_UIObject_release(self.dropList_2);self.dropList_2=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.spineboss);self.spineboss=nil;
_UIObject_release(self.npcClicker);self.npcClicker=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
self.mouse=nil;
self.dropList=nil;
end


















local _CMP_INDEX={
cmpSelfItem=0,
cmpNomalIcon=1,
cmpSelectRoot=2,
cmpSelectIcon=3,
cmpReddot=4,
}

local _scrollLen=4
local _mouse_ais={}
local _mouse_catchs={}
local _mouse_rewards={}
local _this

function UIBottomMaskYYHYWin:onLoaded(...)
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)

self.isInit=false
_this=self
end


function UIBottomMaskYYHYWin:__delete()
self.scrollView:setClickAction(nil)

self:removeAllBehaviorTree()

self:unbindComponents()
self:clearReddotFunction()
end




function UIBottomMaskYYHYWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local clickMenu=argtable.clickMenu or false
_mouse_catchs={}
_mouse_rewards={}
self.args=argtable or{}

if not self.isPlay then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),'',0,2)
self.winlua:SetChildAnimationStringID(self.animFg:getID(),'beijing',false)
self.spinebg:setChildUIModelShowTarget(4515,1,nil,2104)
end


self.isPlay=true
self:freshMenuList()


self.speakContent=cfg_yiyuhuiyouspeckkuconfig_get(25).text_list
self:delayDo(0.3,function()
self:doSpeaking(1)
end)

self.isInit=true
end

function UIBottomMaskYYHYWin:testspine()


_this.spinebg:setChildModelAnimationState(2106)

end


function UIBottomMaskYYHYWin:onHide()
self.isPlay=false

self:clearReddotFunction()
self:clearMouseData()
self.isInit=false
end




function UIBottomMaskYYHYWin:setTitle(title)
self.title:setText(title)
end


function UIBottomMaskYYHYWin:onClickCloseBtn()

AudioManager.playBtnClick()
self:onClickClose()
end

function UIBottomMaskYYHYWin:onClickClose()
if self.args.close then
self.args.close()
else
fullScreenUI.closeActiveUI(true)
end
end

function UIBottomMaskYYHYWin:freshMenuList()
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI


self:clearReddotFunction()
local config=cfgHelper.get1(cfg_fullsystemconfig_get,activeUI.fullType)
if config then
self.title:setText(config.name)
end

local activeSubMenu=activeUI.activeSubMenu
if activeSubMenu and#activeSubMenu>0 then
self.menu:setActive(true)
self.selectMenuIdx=activeUI.activeMenuIndex

local tNum=#activeSubMenu

self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),tNum>_scrollLen)
self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i,v in ipairs(activeSubMenu)do
self:fillMenu(activeUI,i,v)
end
if not self.isInit then
self.scrollView:setChildCanvasGroupAlpha(0)
self.scrollView:setChildCanvasGroupDOFade(1,0.5):SetDelay(0.5)
end
else
self.menu:setActive(false)
end
end

function UIBottomMaskYYHYWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIBottomMaskYYHYWin:fillMenu(activeUI,index,config)
local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local selecticon=assetConfig.selecticon
local selectMenuIdx=activeUI.activeMenuIndex

local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,selectMenuIdx==index)


local isreddot=false
local reddotType=config.reddotType
if reddotType then
isreddot=reddotClassManager.get_reddot(reddotType)
local func=function(...)
if self==nil or self.isClose then return end
self:refreshReddot(index,...)
end
self.reddotfuncs[reddotType]=func
reddotClassManager.register_event(reddotType,func)
end
item:SetChildActive(_CMP_INDEX.cmpReddot,isreddot)
item:SetChildNewBieComponentId(-1,FMT.fmt('UIBottomMaskYYHYWin.btnClick.{0}',index))
end

function UIBottomMaskYYHYWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.cmpReddot,flag)
end

function UIBottomMaskYYHYWin:freshMenuSelect(activeUI,index)
if index==nil then
return
end
local activeSubMenu=activeUI.activeSubMenu
local config=activeSubMenu[index]
if config==nil then
return
end
local selectMenuIdx=activeUI.activeMenuIndex
local item=self.winlua:GetChildCSGUIBaseItem(index-1)
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,selectMenuIdx==index)
end

function UIBottomMaskYYHYWin:on_click_callback(id,index,guid,attach)
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI
if index==self.selectMenuIdx then
return
end
if activeUI.activeSubMenu and activeUI.activeSubMenu[index]then
local conf=activeUI.activeSubMenu[index]
local tabType=conf.tabType
if not fullScreenModel.checkTabEnoughCND(tabType,true)then return end
local clickCond=conf.clickCond
if clickCond~=nil then
if not clickCond()then
return
end
end
self:freshMenuSelect(self.selectMenuIdx)
self:freshMenuSelect(index)
activeUI.activeMenuIndex=index
self.selectMenuIdx=index

local clickCall=conf.callback
if clickCall==nil then
loggerUtil.logErrFMT('没有找到配置页签类型：{0}的点击事件',tabType)
return
end
if not fullScreenModel.isTabOpen(tabType,true)then return end
local isload=activeUI.showTabTypeList[tabType]
local argstable=nil
if activeUI.attach then
argstable=activeUI.attach
if argstable then
argstable.clickMenu=true
end
else
argstable={clickMenu=true}
end
clickCall(argstable)
if argstable then
argstable.clickMenu=nil
end
end
end

function UIBottomMaskYYHYWin:OnStart()


end

function UIBottomMaskYYHYWin:OnDisplay()


end

function UIBottomMaskYYHYWin:initAI()

local data1={
UIstateId=0,
minPos={-180,280},
maxPos={-505,305},
nestPos={-220,230},
midPos={0,270},
initPos={-480,300},
index=1,
}
local bt=self:createBehaviour('bt_ui_mouse',self.mouse_1:getID(),data1)
self.mouse_1.bt=bt


local data2={
UIstateId=0,
minPos={180,280},
maxPos={505,305},
nestPos={220,230},
midPos={0,270},
initPos={480,300},
index=2,
}
local bt=self:createBehaviour('bt_ui_mouse',self.mouse_2:getID(),data2)
self.mouse_2.bt=bt
end

function UIBottomMaskYYHYWin:resetAI(sleep)
for i,v in ipairs(self.mouse)do
v.bt:setSharedVar(behaviorConfig.uiStateIdKey,not sleep and _mouse_ais[i]and 4 or 5)
end
end

function UIBottomMaskYYHYWin:createBehaviour(fName,compIndex,data)
local initData={
widget=self.winlua,
compIndex=compIndex,
}
if data then
for k,v in pairs(data)do
initData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fName,nil,true,initData)
return bt
end

function UIBottomMaskYYHYWin:removeAllBehaviorTree()


end






function UIBottomMaskYYHYWin:onMouseClick1()

end

function UIBottomMaskYYHYWin:onMouseClick2()

end

function UIBottomMaskYYHYWin:clearMouseData()
_mouse_catchs={}
_mouse_rewards={}
for i,v in ipairs(self.dropList)do
v:setChildLayoutGroupClearAllItems()
end

end

function UIBottomMaskYYHYWin:catchMouse(index)

local contains=table.containsValue(_mouse_catchs,index)
if not contains then
local mouse=self.mouse[index]
local state=mouse.bt:getSharedVar(behaviorConfig.uiStateIdKey)
if state==1 then
table.insert(_mouse_catchs,index)
zongmenControl:reqAnimalReward()
end
end
end

function UIBottomMaskYYHYWin:rewardMouse(rewards)
for i,v in ipairs(_mouse_catchs)do
local list=_mouse_rewards[v]
if list==nil then
_mouse_rewards[v]=rewards

local mouse=self.mouse[v]
local state=mouse.bt:getSharedVar(behaviorConfig.uiStateIdKey)
if state==1 then
mouse.bt:setSharedVar(behaviorConfig.uiStateIdKey,3)
end
return
end
end
end

function UIBottomMaskYYHYWin:dropMouse(index)
local rewardList=_mouse_rewards[index]
if rewardList then
local mouse=self.mouse[index]
local dropList=self.dropList[index]

local posData=self.winlua:GetChildAnchoredPosition(mouse:getID())
self.winlua:SetChildAnchoredPosition(dropList:getID(),posData)

local posList=cfgHelper.getglobal1('suijiwuhudoffset')
local optionTab={}
for i,v in ipairs(posList)do
table.insert(optionTab,v)
end

local rewardCnt=#rewardList
dropList:setChildLayoutGroupCreateItems(#rewardList)

local cb=function()
dropList:setChildLayoutGroupClearAllItems()
for i,v in ipairs(rewardList)do
UIManager.rewardInfo(iconHelper.getIconName(v.param_1),FMT.fmt('X{0}',v.param_2))
end
end

for i,v in ipairs(rewardList)do
local rand=math.random(1,#optionTab)
local randPos=optionTab[rand]
table.remove(optionTab,rand)
local offsetX=randPos[1]
local offsetY=randPos[2]

local count=v.param_2
local iconName=iconHelper.getIconName(v.param_1)

local dropObj=dropList:getChildLayoutGroupGridItem(i-1)
local singleCb=rewardCnt==i and cb or nil

dropObj:SetChildIcon(1,iconName,false)
dropObj:SetChildText(2,FMT.fmt('+{0}',count))
dropObj:SetCurveAniPlay(1,1,Vector3(0,offsetY,0),Vector3(offsetX,50+offsetY,0),singleCb)
dropObj:SetCurveAniPlay(2,1,Vector3(0,0,0),Vector3(58,0,0),nil)
end
end
end

function UIBottomMaskYYHYWin:refreshMouseData()
local cnt=zongmenModel:getMouseCnt()
if cnt>=2 then
_mouse_ais[1]=true
_mouse_ais[2]=true
elseif cnt==1 then
local index=math.random(2)
_mouse_ais[1]=index==1
_mouse_ais[2]=index==2
else
_mouse_ais[1]=false
_mouse_ais[2]=false
end

self:resetAI(false)
end











function UIBottomMaskYYHYWin:onNpcClicker()
UIBottomMaskYYHYWin:doSpeaking(1)
_this.spinebg:setChildModelAnimationState(2106)










end

function UIBottomMaskYYHYWin:doSpeaking(speakType)
local speakList=_this.speakContent
local rand=math.random(1,#speakList)
local randomnum=math.random(1,100)
local speakStr=speakList[rand]
if randomnum>speakStr[1]then
return
end
local speed=30
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.speakText:setChildTrendsTextPlay(speakStr[2],speed,nil)
_this:doTalkAnim()
end

function UIBottomMaskYYHYWin:doTalkAnim()
if _this.talkTween~=nil then
_this.talkTween:Kill()
_this.talkTween=nil
end
_this.speakObj:setScale(Vector3.zero)
_this:delayDo(0.2,function()
_this.speakObj:setChildCanvasGroupAlpha(1)
_this.talkTween=_this.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end)
end

function UIBottomMaskYYHYWin:talkEnd()
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
_this.speakShowTimer=_this:delayDo(3.5,function()

if _this==nil then return end
_this.speakObj:setScale(Vector3.zero)
_this.speakObj:setChildCanvasGroupAlpha(0)

if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
end)
end
