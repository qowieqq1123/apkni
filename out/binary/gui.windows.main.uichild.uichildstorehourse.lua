




UIChildStoreHourse=simple_class(UIChildObject)

local iconname='button_zjmcangku'
local _this

function UIChildStoreHourse:onLoaded()

end

function UIChildStoreHourse:onShow(isInit)
if isInit or(_this~=nil and _this~=self)then
if(_this~=nil and _this~=self)then

reddotClassManager.unregister_event(REDDIT_TYPE.eStoreHouseBase,self.refreshReddot)
end

_this=self
reddotClassManager.register_event(REDDIT_TYPE.eStoreHouseBase,self.refreshReddot)
end
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()

local win=UIManager:findActiveWindow('UIXianJieExplorationWin')
if win then
win:onMaskBlock()
end
local win2=UIManager:findActiveWindow('UIMoJieExplorationWin')
if win2 then
win2:onMaskBlock()
end
UIManager:showWindow('UIBagWin')
end,true)

local isreddot=reddotClassManager.get_reddot(REDDIT_TYPE.eStoreHouseBase)
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
self:doPunchRotation(isreddot)
end

function UIChildStoreHourse:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eStoreHouseBase,self.refreshReddot)
self:setChildActive(2,false)
self:doPunchRotation(false)
_this=nil
end

function UIChildStoreHourse.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end

function UIChildStoreHourse:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end

function UIChildStoreHourse:doPunchRotation(isreddot)
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
