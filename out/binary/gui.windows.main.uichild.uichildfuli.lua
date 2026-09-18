




UIChildFuli=simple_class(UIChildObject)

local iconname='button_zjmfuli'
local _this

function UIChildFuli:onLoaded()

end

function UIChildFuli:onShow(isInit)
if isInit then
_this=self
reddotClassManager.register_event(REDDIT_TYPE.eWelfare,self.refreshReddot)
end

local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()

UIFullWelfareController:showMainUI()
end,true)
local reddot=reddotClassManager.get_reddot(REDDIT_TYPE.eWelfare)
self:setChildActive(2,reddot)
self:refreshReddotView(reddot)
self:doPunchRotation(reddot)
end

function UIChildFuli:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eWelfare,self.refreshReddot)
self:setChildActive(2,false)
self:doPunchRotation(false)
_this=nil
end

function UIChildFuli.refreshReddot(class,sub_typo,last_flag,flag)
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end

function UIChildFuli:refreshReddotView(reddot)
if not reddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(2,abname,reddotImg)
end

function UIChildFuli:doPunchRotation(reddot)
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