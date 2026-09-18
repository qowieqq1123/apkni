







def_class("UICommonEnterDisplayWin",UIWindowBase)









function UICommonEnterDisplayWin:bindComponents()

self.creator=UIObject.get(self,0)



end


function UICommonEnterDisplayWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.creator);self.creator=nil;
end



















function UICommonEnterDisplayWin:onLoaded(...)
self:bindComponents()

self.tickTimers={}
end


function UICommonEnterDisplayWin:__delete()
self:unbindComponents()
end




function UICommonEnterDisplayWin:onShow(argtable,afterOnloaded)

local viewArgs=argtable.args
self.argtable=viewArgs

local sortArgs=self:getChildCanvas(-1)
local sortLayer=sortArgs[1]
local sortOrder=sortArgs[2]-1
self:showWindow("UIRawImageBackWin",{sortLayer=sortLayer,
sortOrder=sortOrder})


self:stopAllTimer()
local cfgs=argtable.cfgs
self.cfgs=cfgs
self.creator:setChildLayoutGroupCreateItems(#cfgs,function(index)
local widget=self.creator:getChildLayoutGroupGridItem(index-1)
local config=cfgs[index]
local typo=config.typo
local tabType=config.tabType
local reddot=config.reddotFunc and config.reddotFunc(viewArgs)
local ret,args
if config.unlockFunc then
ret,args=config.unlockFunc(viewArgs)
end
if ret==nil then ret=true end
if reddot==nil then reddot=false end

widget:SetChildButtonClick(0,function(...)
if not ret then
local tips=self:getTips(args)
UIManager.error(tips)
else
self:onClickItem(config)
end
end)
widget:SetChildCSImageSprite(0,config.abName,config.assetName)
widget:SetChildActive(1,reddot)
if reddot then
local tweener=widget:SetChildDOPunchRotation(1,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
end
widget:SetChildActive(2,not ret)
widget:SetChildGraphicGray(0,not ret)
if not ret and args then
self:handleLockArgs(widget,index,args)
end

if tabType then
widget:SetChildNewBieComponentId(0,FMT.fmt('UICommonEnterDisplayWin.item_{0}',tabType))
widget:SetChildWeakGuideComponentId(0,FMT.fmt('UICommonEnterDisplayWin.item_{0}',tabType))
end
end)
end


function UICommonEnterDisplayWin:onHide()

end




function UICommonEnterDisplayWin:handleLockArgs(widget,index,args)
args=args or{}
local typo=args.typo
local args=args.args
if typo==nil then
widget:SetChildActive(2,false)
widget:SetChildText(3,'')
elseif typo==1 then
widget:SetChildActive(2,true)
local endStamp=args.endStamp
local txtFmt=args.txtFmt
local tick=function()
local stamp=timeHelper.getServerShortTime()
local left=endStamp-stamp
if left>0 then
widget:SetChildText(3,FMT.fmt(txtFmt,timeHelper.formatSimpleTime(left)))
else
widget:SetChildGraphicGray(0,false)
widget:SetChildActive(2,false)
self:clearTimer(index)
end
end
self.tickTimers[index]=self:setTimer(1,0,tick)
tick()
elseif typo==2 then
local txt=args.txt
widget:SetChildActive(2,true)
widget:SetChildText(3,txt)
end
end

function UICommonEnterDisplayWin:clearTimer(index)
if self.tickTimers[index]then
self:stopTimerByID(self.tickTimers[index])
self.tickTimers[index]=nil
end
end

function UICommonEnterDisplayWin:getTips(args)
args=args or{}
local typo=args.typo
local args=args.args
if typo==1 then
local endStamp=args.endStamp
local nowTime=timeHelper.getServerShortTime()
local left=endStamp-nowTime
local txtFmt=args.txtFmt
return FMT.fmt(txtFmt,timeHelper.formatSimpleTime(left))
elseif typo==2 then
return args.txt
end
end

function UICommonEnterDisplayWin:onClickItem(config)
local args=self.argtable
local clickFunc=config.clickFunc
local jumpParam=config.jump
self:closeSelf()
if jumpParam then
jumpManager:jump(jumpParam)
elseif clickFunc then
clickFunc(args)
end
end
