




UIChildSubMoJieShiLi=simple_class(UIChildObject)

local defaultIcon='button_mojie_shili'
local defaultIcon2='button_zjmmojieweikaiqi'
local _this
local mjabname='ui/windows/mojieforce/mojieforce_atlas_pak.ab'
local mjabname2='ui/windows/main/main_sprite_atlas_pak.ab'

function UIChildSubMoJieShiLi:onLoaded()

end

function UIChildSubMoJieShiLi:onShow(isInit)
if isInit then
_this=self
end
local abname=mainConfig.getBundleName()
local iconname=defaultIcon

local isreddot=false
local forceid=xianjieController:getForce()
if forceid>0 then
local cfg=cfg_devildomforceconfig_get(forceid)
if cfg and cfg.btnicon then
self:setChildCSImageSprite(0,mjabname,cfg.btnicon)
else
self:setChildCSImageSprite(0,abname,iconname)
end
isreddot=xianjieController:getMJSLALLReddot()
else
self:setChildCSImageSprite(0,mjabname,'button_mojie_shili')

local widget=self:getWidgetBase()
local isopen=xianjieController:CheckMoJieSaiJieActityeTime()
widget:SetChildGray(0,not isopen)
isreddot=isopen
end
self:setChildButtonClick(1,function()self:OnButtonClick()end,true)
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
self:doPunchRotation(isreddot)


self:setChildActive(3,false)

self:setChildActive(4,false)
end


function UIChildSubMoJieShiLi:OnButtonClick()
local isMJtime=xianjieController:CheckMoJieSaiJieActityeTime()
if isMJtime then
UIManager:invokeUIMethod("UIMainSubEnterPanelWin","onMask")
local func=function()
xianjieController:OpenMoJieShiLiWinByForce()
end
if not xianjieModel:isInMoJie()then
local forceid=xianjieController:getForce()
if forceid>0 then
func()
else


func()
end
else
func()
end
else
UIManager.info('魔界赛季已结束')
end
end

function UIChildSubMoJieShiLi:OnYuanZhuButtonClick()
xianjieController:reqHelpAll()
end

function UIChildSubMoJieShiLi:release()
if self==nil then return end
self:setChildActive(2,false)
self:doPunchRotation(false)

self:setChildActive(3,false)
_this=nil
end

function UIChildSubMoJieShiLi.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end

function UIChildSubMoJieShiLi:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end

function UIChildSubMoJieShiLi:doPunchRotation(isreddot)
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