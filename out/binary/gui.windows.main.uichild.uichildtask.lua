




UIChildTask=simple_class(UIChildObject)

local iconname='button_zjmrichang'

local _this

function UIChildTask:onLoaded()

end

function UIChildTask:onShow(isInit)
if isInit then
_this=self
reddotClassManager.register_event(REDDIT_TYPE.eDailyTask,self.refreshReddot)
end
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()self:onClickDailyTaskBtn()end,true)
local isreddot=taskModel:checkDailyTaskReddot()or taskModel:GetNewTaskReddot()
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
self:doPunchRotation(isreddot)
end

function UIChildTask:onClickDailyTaskBtn()
UIFullTaskMainControl:showWindowDaily()
end

function UIChildTask:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eDailyTask,self.refreshReddot)
self:setChildActive(2,false)
self:doPunchRotation(false)
_this=nil
end

function UIChildTask.refreshReddot(class,sub_typo,last_flag,flag)
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end

function UIChildTask:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end

function UIChildTask:doPunchRotation(isreddot)
if webGLHelper:isHidePunchAni()then return end
if isreddot then
if self.reddotTweener==nil then
self:setChildRotation(2,0,0,0)
local tweener=self:setChildDOPunchRotation(2,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self:setChildRotation(2,0,0,0)
end
end
end