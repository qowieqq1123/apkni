




UIChildXianTuChengJiu=simple_class(UIChildObject)

local iconname='button_zjmxiantu'
local _this

function UIChildXianTuChengJiu:onLoaded()
reddotClassManager.register_event(REDDIT_TYPE.eXianTuChengJiu_Base,self.refreshReddot)
_this=self
end

function UIChildXianTuChengJiu:onShow()
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setNewBieComponentId(4,"UIMain.UIChildXianTuChengJiu.enter")
self:setChildButtonClick(4,function()
self:onButtonClick()
end,true)
self:setChildButtonClick(1,function()
self:onButtonClick_NewBie()
end,true)
local reddot=reddotClassManager.get_reddot(REDDIT_TYPE.eXianTuChengJiu_Base)
self:setChildActive(2,reddot)
self:doPunchRotation(reddot)
end

function UIChildXianTuChengJiu:onButtonClick()
UIFullXianTuChengJiuControl:showMainWindow()
end

function UIChildXianTuChengJiu:onButtonClick_NewBie()
UIFullXianTuChengJiuControl:showWindow_Guide()
end

function UIChildXianTuChengJiu:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eXianTuChengJiu_Base,self.refreshReddot)
self:setChildActive(2,false)
self:doPunchRotation(false)
_this=nil
end

function UIChildXianTuChengJiu.refreshReddot(class,sub_typo,last_flag,flag)
_this:setChildActive(2,flag)
_this:doPunchRotation(flag)
end

function UIChildXianTuChengJiu:doPunchRotation(reddot)
if webGLHelper:isHidePunchAni()then return end
if reddot then
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