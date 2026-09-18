




UIChildSubXianYu=simple_class(UIChildObject)

local defaultIcon='button_xianyu'
local _this

function UIChildSubXianYu:onLoaded()

end

function UIChildSubXianYu:onShow(isInit)
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
local flag=sceneType_>0
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

function UIChildSubXianYu:OnButtonClick()
if mainBtnConfig.isActive(MAIN_BTNS_TYPE.eSubXianYu)then












if systemModel.isOpen(SYSTEM_DEFINE.eXianYuEnter)then
xianguanController:setPrepareShowMsg()
if not xianjieModel:checkJoin()then
xianjieController:reqCreateZMPos()
else
local sceneidx_=xianjieModel:getXianYuSceneIndex()
local sceneType=xianjieModel:sceneIndex2SceneType(sceneidx_)
xianjieController:jumpXianJie(sceneType)
end
else
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eXianYuEnter,nil,"开启仙域")
UIManager.error(tips)
end
end








UIManager:invokeUIMethod("UIMainSubEnterPanelWin","onMask")
end

function UIChildSubXianYu:OnYuanZhuButtonClick()
xianjieController:reqHelpAll()
end

function UIChildSubXianYu:release()
self:setChildActive(2,false)
self:doPunchRotation(false)

self:setChildActive(3,false)
_this=nil
end

function UIChildSubXianYu.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end

function UIChildSubXianYu:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end

function UIChildSubXianYu:doPunchRotation(isreddot)
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