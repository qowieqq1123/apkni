




UIChildShop=simple_class(UIChildObject)

local iconname='button_zjmshangdian'
local _this
function UIChildShop:onLoaded()
reddotClassManager.register_event(REDDIT_TYPE.eXianGouLiBao,self.refreshReddot)
_this=self
end

function UIChildShop:onShow()
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()

UIFullRechargeController:showMyWindow()
end,true)
local reddot=rechargeModel:checkXianGouLiBaoReddot()
self:setChildActive(2,reddot)
self:doPunchRotation(reddot)
end

function UIChildShop:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eXianGouLiBao,self.refreshReddot)
self:doPunchRotation(false)
_this=nil
end

function UIChildShop.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil or _this.isClose then return end
_this:setChildActive(2,flag)
_this:doPunchRotation(flag)
end

function UIChildShop:doPunchRotation(reddot)
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