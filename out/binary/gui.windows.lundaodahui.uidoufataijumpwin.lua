







def_class("UIDouFaTaiJumpWin",UIWindowBase)









function UIDouFaTaiJumpWin:bindComponents()

self.GridRoot=UIObject.get(self,0)
self.leftJianTou=UIButton.get(self,1)
self.rightJianTou=UIButton.get(self,2)
self.Scroll_View=UIObject.get(self,3)

self.leftJianTou:setButtonClick(function()self:onLeftJianTou()end)

self.rightJianTou:setButtonClick(function()self:onRightJianTou()end)



end


function UIDouFaTaiJumpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.GridRoot);self.GridRoot=nil;
_UIObject_release(self.leftJianTou);self.leftJianTou=nil;
_UIObject_release(self.rightJianTou);self.rightJianTou=nil;
_UIObject_release(self.Scroll_View);self.Scroll_View=nil;
end


















local abName="ui/windows/lundaodahui/lundaodahui_atlas_pak.ab"

local reddotCheck={
[1]=function()
return douFaTaiModel:checkRewardReddot()
end,
[2]=function()
return lundaodahuiModel:checkRongYuTangReddot()
end,
[3]=function()
return UIXianFaWenDaoControl:checkReddot()
end,
[4]=function()
return WDCQController.checkSysReddot()
end
}

local showCheck=
{
[2]=function()
return true
end,
[3]=function()



return true
end,
[4]=function()
return XiWeiSaiController.checkSysOpen()
end,
}

local unlockCheck=
{
[2]=function()
return lundaodahuiModel:checkUnlock(true)
end,
[3]=function()
return UIXianFaWenDaoControl:checkUnlock()
end,
[4]=function()
return true
end
}


function UIDouFaTaiJumpWin:onLoaded(...)
self:bindComponents()

self.timers={}
end


function UIDouFaTaiJumpWin:__delete()
self:unbindComponents()
end

function UIDouFaTaiJumpWin:getShowIconCfgs()
local cfgs=cfg_doufataijumpconfig()
local list={}
for i,v in ipairs(cfgs)do
local check=showCheck[i]
if not check or check()then
table.insert(list,v)
end
end
return list
end




function UIDouFaTaiJumpWin:onShow(argtable,afterOnloaded)
local arrs=self:getChildCanvas(-1)
local sortLayer=arrs[1]
local sortOrder=arrs[2]-1
self:showWindow("UIRawImageBackWin",{sortLayer=sortLayer,sortOrder=sortOrder})
local cfg=self:getShowIconCfgs()
self.gridLen=#cfg
if self.gridLen<4 then
self.leftJianTou:setActive(false)
self.rightJianTou:setActive(false)
end
self.GridRoot:setChildLayoutGroupCreateItems(#cfg,function(id)
local item=self.GridRoot:getChildLayoutGroupGridItem(id-1)
local config=cfg[id]
local index=config.id
item:SetChildButtonClick(0,function(...)
self:onClickItem(id,config)
end)
item:SetChildCSImageSprite(0,abName,config.icon)
local reddot=self:getReddot(index)
item:SetChildActive(2,reddot)
if reddot then
local tweener=item:SetChildDOPunchRotation(2,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
end
local check,ctype,txt,cd=self:getUnlock(index)
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

function UIDouFaTaiJumpWin:clearTimer(index)
if self.timers[index]then
self:stopTimerByID(self.timers[index])
self.timers[index]=nil
end
end

function UIDouFaTaiJumpWin:onClickItem(index,config)
jumpManager:jump(config.jump,nil,JUMP_BACK.eNoBack)
end


function UIDouFaTaiJumpWin:onHide()

end

function UIDouFaTaiJumpWin:getReddot(index)
return reddotCheck[index]and reddotCheck[index]()or false
end

function UIDouFaTaiJumpWin:getUnlock(index)
local func=unlockCheck[index]
if func then
return func()
end
return true
end



local _iconWidth=230
local _iconSpan=150
local _iconListLeftSpan=80
local _iconListRightSpan=80
local _moveSpeed=1000
function UIDouFaTaiJumpWin:refreshJiantou()
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

function UIDouFaTaiJumpWin:onScrollViewChange()
self:refreshJiantou()
end

function UIDouFaTaiJumpWin:onLeftJianTou()
local pos=self.GridRoot:getChildAnchoredPosition()
local toposx=pos.x+_iconWidth+_iconSpan
toposx=Mathf.Min(toposx,0)
self.GridRoot:setChildDOAnchorPosX(toposx,(-(pos.x-toposx))/_moveSpeed,nil)
end

function UIDouFaTaiJumpWin:onRightJianTou()
local pos=self.GridRoot:getChildAnchoredPosition()
local swidth=self.Scroll_View:getChildSizeDeltaX()
local iwidth=self.GridRoot:getChildSizeDeltaX()

local toposx=pos.x-_iconWidth-_iconSpan
toposx=Mathf.Max(toposx,swidth-iwidth)

self.GridRoot:setChildDOAnchorPosX(toposx,(-(toposx-pos.x))/_moveSpeed,nil)
end
