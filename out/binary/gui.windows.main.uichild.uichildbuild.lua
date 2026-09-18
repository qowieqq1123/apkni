




UIChildBuild=simple_class(UIChildObject)

local iconname='button_zjmjianzao'
local _this
function UIChildBuild:onLoaded()
reddotClassManager.register_event(REDDIT_TYPE.eLayoutBuild,self.refreshReddot)
_this=self
end

function UIChildBuild:onShow()
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()
if zongmenModel:getMountainId()~=mapIdType.xianmeng then
isometricMapSystem:enterLayoutModel({model=layoutMode.eBuild})
else
isometricMapSystem:enterLayoutModel({model=layoutMode.eLayout})
end
end,true)
local reddot=reddotClassManager.get_reddot(REDDIT_TYPE.eLayoutBuild)
self:setChildActive(2,reddot)
self:doPunchRotation(reddot)
end

function UIChildBuild:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eLayoutBuild,self.refreshReddot)
self:setChildActive(2,false)
self:doPunchRotation(false)
_this=nil
end


function UIChildBuild.refreshReddot(class,sub_typo,last_flag,flag)
_this:setChildActive(2,flag)
_this:doPunchRotation(flag)
end

function UIChildBuild:doPunchRotation(reddot)
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