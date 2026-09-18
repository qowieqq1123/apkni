UIChildXZBX=simple_class(UIChildObject)

local iconname='button_xianzangbaoxia'
local abname='ui/windows/xianzhangbaoxia/xianzhangbaoxia_atlas_pak.ab'

local _this

function UIChildXZBX:onLoaded()
_this=self
end

function UIChildXZBX:onShow(isInit)
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()
UIFullXianMengBaoXiaControl:showBaoXiaWindow()
end,true)
local isreddot=false
self:setChildActive(2,isreddot)
self:doPunchRotation(isreddot)
end

function UIChildXZBX:release()

_this=nil
end

function UIChildXZBX.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:doPunchRotation(flag)
end

function UIChildXZBX:doPunchRotation(isreddot)
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