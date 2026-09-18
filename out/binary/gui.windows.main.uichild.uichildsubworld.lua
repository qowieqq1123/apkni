




UIChildSubWorld=simple_class(UIChildObject)

local defaultIcon='button_xiajie'
local _this

function UIChildSubWorld:onLoaded()

end

function UIChildSubWorld:onShow(isInit)
if isInit then
_this=self
end
local abname=mainConfig.getBundleName()


local iconname=defaultIcon
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()self:OnButtonClick()end,true)
local isreddot=false
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
self:doPunchRotation(isreddot)

self:setChildActive(3,false)


self:setChildActive(4,false)
end

function UIChildSubWorld:OnButtonClick()
if not systemModel.isOpen(SYSTEM_DEFINE.eWorld)then
UIManager.error("神州世界危险重重，请祖师先发展宗门")

return
end
if worldBlockModel:checkWorldEnterLimit(2)then
UIManager:showWindow("UIWorldMapWinEx",{showInfo=true,enter=function(index)
if not mainControl:isWaitSceneChange()then
worldController:enterWorld(index)
end
UIManager:closeWindow("UIWorldMapWinEx")
end})
else
if not mainControl:isWaitSceneChange()then
worldController:enterWorld(1)
end
end

UIManager:invokeUIMethod("UIMainSubEnterPanelWin","onMask")
end

function UIChildSubWorld:OnYuanZhuButtonClick()
xianjieController:reqHelpAll()
end

function UIChildSubWorld:release()
self:setChildActive(2,false)
self:doPunchRotation(false)

self:setChildActive(3,false)
_this=nil
end

function UIChildSubWorld.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end

function UIChildSubWorld:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end

function UIChildSubWorld:doPunchRotation(isreddot)
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