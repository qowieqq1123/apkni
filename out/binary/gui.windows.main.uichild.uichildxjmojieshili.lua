




UIChildXJMoJieShiLi=simple_class(UIChildObject)

local defaultIcon='button_mojie_shili_1'
local selectIcon='button_mojie_shili_2'
local _this
local slabname='ui/windows/mojieforce/mojieforce_atlas_pak.ab'

function UIChildXJMoJieShiLi:onLoaded()

end

function UIChildXJMoJieShiLi:onShow(isInit)
if isInit then
_this=self

end
local abname=mainConfig.getBundleName()


local iconname=defaultIcon
local selectIconName=selectIcon
self:setChildCSImageSprite(0,slabname,iconname)
self:setChildCSImageSprite(6,slabname,selectIconName)
self:setChildActive(6,false)
self:setChildButtonClick(1,function()self:OnButtonClick()end,true)
local isreddot=reddotClassManager.get_reddot(REDDIT_TYPE.eXianGong)
local forceid=xianjieController:getForce()
if not forceid or forceid==0 then
isreddot=true
end
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
self:doPunchRotation(isreddot)

self:setChildActive(3,false)



end

function UIChildXJMoJieShiLi:OnButtonClick()
local btnList={
MAIN_BTNS_TYPE.eSubXianGong,
MAIN_BTNS_TYPE.eSubMoJieShiLi,
}

local widget=self:getWidgetBase()
local posVector2=widget:GetChildScreenPointToLocalPointRectangle(-1)
local pos={posVector2.x,posVector2.y+55}
local closeCallback=function()
if not _this then return end
_this:setChildActive(6,false)
end

UIManager:showWindow("UIMainSubEnterPanelWin",{btnList=btnList,pos=pos,closeCallback=closeCallback})
self:setChildActive(6,true)
end

function UIChildXJMoJieShiLi:release()


self:setChildActive(2,false)
self:doPunchRotation(false)

self:setChildActive(3,false)

self:setChildActive(4,false)

self:setChildActive(6,false)
_this=nil
end

function UIChildXJMoJieShiLi.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end
function UIChildXJMoJieShiLi:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end
function UIChildXJMoJieShiLi:doPunchRotation(isreddot)
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


