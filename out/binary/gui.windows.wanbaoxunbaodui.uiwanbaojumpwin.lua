







def_class("UIWanBaoJumpWin",UIWindowBase)









function UIWanBaoJumpWin:bindComponents()

self.GridRoot=UIObject.get(self,0)



end


function UIWanBaoJumpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.GridRoot);self.GridRoot=nil;
end


















local abName="ui/windows/wanbaoxunbaodui/wanbaoxunbaodui_atlas_pak.ab"

local reddotCheck={
[1]=function()
return UIFullWanBaoXunBaoDuiController:checkReddot()
end,
[2]=function()
return wanBaoXunBaoDuiController:checkCatMijinTanShuo()or wanBaoXunBaoDuiController:checkCatMijinReddot()
end,
[3]=function()
return false
end
}

local showCheck=
{
[2]=function()
return true
end,
[3]=function()



return true
end
}

local unlockCheck=
{
[2]=function()
return false
end,
}
local _this


function UIWanBaoJumpWin:onLoaded(...)
self:bindComponents()
self.timers={}
_this=self
end


function UIWanBaoJumpWin:__delete()
self:unbindComponents()
_this=nil
end

function UIWanBaoJumpWin:getShowIconCfgs()

local list={}






list[1]={id=1,icon="button_tanxianmatou_1"}
list[2]={id=2,icon="button_mijingxiandi_1"}

return list
end




function UIWanBaoJumpWin:onShow(argtable,afterOnloaded)
local arrs=self:getChildCanvas(-1)
local sortLayer=arrs[1]
local sortOrder=arrs[2]-1
self:showWindow("UIRawImageBackWin",{sortLayer=sortLayer,sortOrder=sortOrder})
local cfg=self:getShowIconCfgs()

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
item:SetChildActive(3,false)

























end)
end


function UIWanBaoJumpWin:refreshreddotsecond()
local item=_this.GridRoot:getChildLayoutGroupGridItem(1)
local reddot=_this:getReddot(2)

item:SetChildActive(2,reddot)
end

function UIWanBaoJumpWin:clearTimer(index)
if self.timers[index]then
self:stopTimerByID(self.timers[index])
self.timers[index]=nil
end
end

function UIWanBaoJumpWin:onClickItem(index,config)

if index==1 then
UIFullWanBaoXunBaoDuiController:showWanBaoXunBaoDuiMTWindow()
else
UIManager:showWindow('UIWanBaoXunBaoDui_MiJinWin')
end
end


function UIWanBaoJumpWin:onHide()

end

function UIWanBaoJumpWin:getReddot(index)
return reddotCheck[index]and reddotCheck[index]()or false
end

function UIWanBaoJumpWin:getUnlock(index)
local func=unlockCheck[index]
if func then
return func()
end
return true
end



