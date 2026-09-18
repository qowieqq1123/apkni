







def_class("UIXianJieFortTaskbarWin",UIWindowBase)









function UIXianJieFortTaskbarWin:bindComponents()

self.fortBtn=UIButton.get(self,0)
self.fortBtnReddot=UIObject.get(self,1)
self.fortBtnSelected=UIObject.get(self,2)
self.layout=UIObject.get(self,3)
self.taskBtn=UIButton.get(self,4)
self.taskBtnReddot=UIObject.get(self,5)
self.taskBtnSelected=UIObject.get(self,6)

self.fortBtn:setButtonClick(function()self:onFortBtn()end)

self.taskBtn:setButtonClick(function()self:onTaskBtn()end)



end


function UIXianJieFortTaskbarWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fortBtn);self.fortBtn=nil;
_UIObject_release(self.fortBtnReddot);self.fortBtnReddot=nil;
_UIObject_release(self.fortBtnSelected);self.fortBtnSelected=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.taskBtn);self.taskBtn=nil;
_UIObject_release(self.taskBtnReddot);self.taskBtnReddot=nil;
_UIObject_release(self.taskBtnSelected);self.taskBtnSelected=nil;
end


















local _this

local leftPanelTypeFun={
[leftFortSimpleState.fort]={
showFun=function()
_this:leftPanel_showFort()
end,
closeFun=function()
_this:leftPanel_closeFort()
end,
selectedCmp=function(_self)
return _self.fortBtnSelected
end,
reddotFun=function()
_this:leftPanel_refrshFortReddot()
end,
},

[leftFortSimpleState.task]={
showFun=function()
_this:leftPanel_showTask()
end,
closeFun=function()
_this:leftPanel_closeTask()
end,
selectedCmp=function(_self)
return _self.taskBtnSelected
end,
reddotFun=function()
_this:leftPanel_refrshTaskReddot()
end,
},
}


function UIXianJieFortTaskbarWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianJieFortTaskbarWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJieFortTaskbarWin:onShow(argtable,afterOnloaded)
self:checkBarPanelShow()
local state2=simpleModeControl:getFortLeftSimple()
for state,v in pairs(leftPanelTypeFun)do
local selectedCmp=v.selectedCmp(self)
selectedCmp:setActive(state2==state)
v.reddotFun()
end
end

function UIXianJieFortTaskbarWin:showBarPanel(isInit)
if self.isShowBar then
return
end

self:clearShowPanelTweener()
local endVal=0
if isInit then
self.winlua:SetChildLocalPosX(self.layout:getID(),endVal)
else
self.winlua:SetChildLocalPosX(self.layout:getID(),-450)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3)
end
self.isShowBar=true
end

function UIXianJieFortTaskbarWin:hideBarPanel(callBack)
if not self.isShowBar then
return
end

self:clearShowPanelTweener()
local endVal=-450
self.winlua:SetChildLocalPosX(self.layout:getID(),0)
self.showPanelTweener=self.winlua:SetChildDOLocalMoveX(self.layout:getID(),endVal,0.3,callBack)
self.isShowBar=false
end

function UIXianJieFortTaskbarWin:checkBarPanelShow()
self:clearShowPanelTweener()
local state=simpleModeControl:getLeftSimple()
local isInFort=zongmenControl:isMountid(mapIdType.fort)
self.isShowBar=state==leftSimpleState.task and isInFort
local endVal=self.isShowBar and 0 or-450
self.winlua:SetChildLocalPosX(self.layout:getID(),endVal)
end

function UIXianJieFortTaskbarWin:clearShowPanelTweener()
if self.showPanelTweener~=nil then
self.showPanelTweener:Kill()
self.showPanelTweener=nil
end
end

function UIXianJieFortTaskbarWin:leftPanel_showFort()
UIManager:invokeUIMethod("UIXianJieFortInfoWin","showInfoListPanel")
end

function UIXianJieFortTaskbarWin:leftPanel_closeFort()
UIManager:invokeUIMethod("UIXianJieFortInfoWin","hideInfoListPanel")
end

function UIXianJieFortTaskbarWin:leftPanel_showTask()
UIManager:invokeUIMethod("UITaskListWin","showTaskListPanel")
end

function UIXianJieFortTaskbarWin:leftPanel_closeTask()
UIManager:invokeUIMethod("UITaskListWin","hideTaskListPanel")
end

function UIXianJieFortTaskbarWin:leftPanel_refrshFortReddot()
local fortReddot=xianJieFortInfoController:getInfoReddot()
self.fortBtnReddot:setActive(fortReddot)
end

function UIXianJieFortTaskbarWin:leftPanel_refrshTaskReddot()
local taskReddot=taskModel:getHasRewardTaskNum()>0
self.taskBtnReddot:setActive(taskReddot)
end


function UIXianJieFortTaskbarWin:onFortBtn()
self:changeStateBtn(leftFortSimpleState.fort)
end

function UIXianJieFortTaskbarWin:onTaskBtn()
self:changeStateBtn(leftFortSimpleState.task)
end

function UIXianJieFortTaskbarWin:changeStateBtn(new_state)
local old_state=simpleModeControl:getFortLeftSimple()
if new_state==old_state then
return
end
leftPanelTypeFun[old_state].closeFun()
local selectedCmp=leftPanelTypeFun[old_state].selectedCmp(self)
selectedCmp:setActive(false)
simpleModeControl:setFortLeftSimple(new_state)
leftPanelTypeFun[new_state].showFun()
local selectedCmp=leftPanelTypeFun[new_state].selectedCmp(self)
selectedCmp:setActive(true)
end