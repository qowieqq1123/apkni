




UIChildSubXianJie=simple_class(UIChildObject)

local defaultIcon='button_xianjie'
local _this

function UIChildSubXianJie:onLoaded()

end

function UIChildSubXianJie:onShow(isInit)
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

local zmData=xianjieModel:getZongMenOutPos()
if zmData then
local sceneType_=zmData[1]
local flag=sceneType_==0
self:setChildActive(3,flag)
if flag then
local abName='ui/windows/yandaotai/yandaotai_atlas_pak.ab'
self:setChildCSImageSprite(3,abName,'icon_baoleibiaoshi')
end
else
self:setChildActive(3,false)
end


self:setChildActive(4,false)
end

function UIChildSubXianJie:OnButtonClick()
local sceneType=xianjienSceneType.eXianJie
if xianjieController:isSceneOpen(sceneType,nil,false)and(not mainControl:isSceneType(eSceneType.eXianJie)or xianjieModel:getScenceType()~=sceneType)then

xianguanController:setPrepareShowMsg()
xianjieController:jumpXianJie(sceneType)
end

UIManager:invokeUIMethod("UIMainSubEnterPanelWin","onMask")
end

function UIChildSubXianJie:OnYuanZhuButtonClick()
xianjieController:reqHelpAll()
end

function UIChildSubXianJie:release()
self:setChildActive(2,false)
self:doPunchRotation(false)

self:setChildActive(3,false)
_this=nil
end

function UIChildSubXianJie.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end

function UIChildSubXianJie:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end

function UIChildSubXianJie:doPunchRotation(isreddot)
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