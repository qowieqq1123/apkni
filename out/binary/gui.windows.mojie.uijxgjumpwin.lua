







def_class("UIJXGJumpWin",UIWindowBase)









function UIJXGJumpWin:bindComponents()

self.GridRoot=UIObject.get(self,0)
self.leftJianTou=UIButton.get(self,1)
self.rightJianTou=UIButton.get(self,2)
self.Scroll_View=UIObject.get(self,3)

self.leftJianTou:setButtonClick(function()self:onLeftJianTou()end)

self.rightJianTou:setButtonClick(function()self:onRightJianTou()end)



end


function UIJXGJumpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.GridRoot);self.GridRoot=nil;
_UIObject_release(self.leftJianTou);self.leftJianTou=nil;
_UIObject_release(self.rightJianTou);self.rightJianTou=nil;
_UIObject_release(self.Scroll_View);self.Scroll_View=nil;
end
















local showListCfg=
{
[1]={
name="魔界密令",
abName="ui/windows/common/sharedtextures/button_mojiemiling_1.ab",
icon="button_mojiemiling_1",
showCheck=function()
local guid=UITYTongXingZhengModel:getGuidBySysID(txzType.sys,SYSTEM_DEFINE.eXianYuEnter,0)
if guid then
return true
end
return false
end,
jumpFunc=function(_self)
_self:closeSelf()
local guid=UITYTongXingZhengModel:getGuidBySysID(txzType.sys,SYSTEM_DEFINE.eXianYuEnter,0)
local passportId=xianjieModel:getMoJieEnterConfig("passport")
if guid and passportId then
UITYTongXingZhengController:showTXZWin(guid,passportId)
else
UIManager.info('魔界密令未开启')
end
end,
reddotFunc=function()
local guid=UITYTongXingZhengModel:getGuidBySysID(txzType.sys,SYSTEM_DEFINE.eXianYuEnter,0)
local reddot=UITYTongXingZhengModel:getReddot(guid)
return reddot
end
},
[2]={
name="魔界商店",
abName="ui/windows/common/sharedtextures/button_mojieshangdian_1.ab",
icon="button_mojieshangdian_1",
showCheck=function()
return true
end,
jumpFunc=function(_self)
local hasXM=xianmengModel:hasXM()
if not hasXM then
UIManager.info('未加入仙盟')
else
_self:closeSelf()

xianjieController:MoJieShop_Enter()
end
end,
},
}




function UIJXGJumpWin:onLoaded(...)
self:bindComponents()
self.timers={}
end


function UIJXGJumpWin:__delete()
self:unbindComponents()
end


function UIJXGJumpWin:getShowIconCfgs()
local list={}
for i,v in ipairs(showListCfg)do
local check=v.showCheck
v.index=i
if not check or check()then
table.insert(list,v)
end
end
return list
end




function UIJXGJumpWin:onShow(argtable,afterOnloaded)

local cfg=self:getShowIconCfgs()
self.gridLen=#cfg
if self.gridLen<4 then
self.leftJianTou:setActive(false)
self.rightJianTou:setActive(false)
end
self.GridRoot:setChildLayoutGroupCreateItems(#cfg,function(itemIndex)
local item=self.GridRoot:getChildLayoutGroupGridItem(itemIndex-1)
local config=cfg[itemIndex]
local index=config.index
item:SetChildButtonClick(0,function(...)
self:onClickItem(itemIndex,config)
end)
item:SetChildCSImageSprite(0,config.abName,config.icon)
local reddot=self:getReddot(config)
item:SetChildActive(2,reddot)
if reddot then
local tweener=item:SetChildDOPunchRotation(2,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
end
local check,ctype,txt,cd=self:getUnlock(config)
item:SetChildActive(3,not check)
item:SetChildGraphicGray(0,not check)
if not check then
if ctype==1 then
self:clearTimer(index)
local endTime=os.time()+cd
local tick=function()
local dt=endTime-os.time()
if dt>0 then
item:SetChildText(4,FMT.fmt(txt,timeHelper.formatSimpleTime(dt)))
else
item:SetChildGraphicGray(0,false)
item:SetChildActive(3,false)
self:clearTimer(index)
end
end
self.timers[index]=self:setTimer(1,0,tick)
tick()
else
item:SetChildText(4,txt)
end
end
end)
end


function UIJXGJumpWin:onHide()

end

function UIJXGJumpWin:clearTimer(index)
if self.timers[index]then
self:stopTimerByID(self.timers[index])
self.timers[index]=nil
end
end





function UIJXGJumpWin:onLeftJianTou()
end



function UIJXGJumpWin:onRightJianTou()
end


function UIJXGJumpWin:onClickItem(index,config)
if config.jumpFunc then
config.jumpFunc(self)
else
logErr("onClickItem jumpFunc 为 nil",config.index)
end
end

function UIJXGJumpWin:getReddot(config)
if config.reddotFunc then
return config.reddotFunc()
end
return false
end

function UIJXGJumpWin:getUnlock(config)
if config.unlockFunc then
return config.unlockFunc()
end
return true
end


local _iconWidth=230
local _iconSpan=150
local _iconListLeftSpan=80
local _iconListRightSpan=80
local _moveSpeed=1000
function UIJXGJumpWin:refreshJiantou()
if self.gridLen<4 then
self.leftJianTou:setActive(false)
self.rightJianTou:setActive(false)
return
end
local pos=self.GridRoot:getChildAnchoredPosition()
local state=pos.x<-_iconListLeftSpan

self.leftJianTou:setActive(state)
self.rightJianTou:setActive(not state)

self.isShowLeftJT=state
end

function UIJXGJumpWin:onScrollViewChange()
self:refreshJiantou()
end

function UIJXGJumpWin:onLeftJianTou()
local pos=self.GridRoot:getChildAnchoredPosition()
local toposx=pos.x+_iconWidth+_iconSpan
toposx=Mathf.Min(toposx,0)
self.GridRoot:setChildDOAnchorPosX(toposx,(-(pos.x-toposx))/_moveSpeed,nil)
end

function UIJXGJumpWin:onRightJianTou()
local pos=self.GridRoot:getChildAnchoredPosition()
local swidth=self.Scroll_View:getChildSizeDeltaX()
local iwidth=self.GridRoot:getChildSizeDeltaX()

local toposx=pos.x-_iconWidth-_iconSpan
toposx=Mathf.Max(toposx,swidth-iwidth)

self.GridRoot:setChildDOAnchorPosX(toposx,(-(toposx-pos.x))/_moveSpeed,nil)
end



