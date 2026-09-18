UIChildXianWuLou=simple_class(UIChildObject)

local iconname='button_zjmxianwulou'

local _this

function UIChildXianWuLou:onLoaded()
_this=self
reddotClassManager.register_event(REDDIT_TYPE.eXianWuLou,self.refreshReddot)
end

function UIChildXianWuLou:onShow(isInit)
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()
UIFullXianMengXianWuLouControl:touchBuild()
end,true)
local isreddot=reddotClassManager.get_reddot(REDDIT_TYPE.eXianWuLou)
self:setChildActive(2,isreddot)
self:doPunchRotation(isreddot)
end

function UIChildXianWuLou:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eXianWuLou,self.refreshReddot)
_this=nil
end

function UIChildXianWuLou.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:doPunchRotation(flag)
end

function UIChildXianWuLou:doPunchRotation(isreddot)
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