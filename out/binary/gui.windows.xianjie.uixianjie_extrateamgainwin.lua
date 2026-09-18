







def_class("UIXianJie_extraTeamGainWin",UIWindowBase)









function UIXianJie_extraTeamGainWin:bindComponents()

self.root=UIObject.get(self,0)
self.gainScrollView=UIObject.get(self,1)
self.gainGirdGroup=UIObject.get(self,2)



end


function UIXianJie_extraTeamGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.gainScrollView);self.gainScrollView=nil;
_UIObject_release(self.gainGirdGroup);self.gainGirdGroup=nil;
end
















local gainItemCmpIndex={
icon=0,
name=1,
lockImg=2,
goBtn=3,
bg=4,
garyImg=5,
state=6,
selectBg=7,
specialBg=8,
}




function UIXianJie_extraTeamGainWin:onLoaded(...)
self:bindComponents()
end


function UIXianJie_extraTeamGainWin:__delete()
self:unbindComponents()
end




function UIXianJie_extraTeamGainWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIXianJie_extraTeamGainWin:onHide()

end

function UIXianJie_extraTeamGainWin:refresh()

local gainCfgList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'extraTeamGain')
local showCfgList={}
for i,cfg in ipairs(gainCfgList)do
local gainType=cfg.type
local isShow=true
if gainType then

if gainType==1 then

if xianjieModel:getCloudIsRecvQueue()then
isShow=false
end
elseif gainType==2 then

if seasonController:checkSeasonHandleComplete(0)then
isShow=false
end
end
end

if isShow then
showCfgList[#showCfgList+1]=cfg
end
end


self.gainGirdGroup:setChildLayoutGroupCreateItems(#showCfgList,function(index)
local widget=self.gainGirdGroup:getChildLayoutGroupGridItem(index-1)
local cfg=showCfgList[index]
if cfg then
widget:SetChildActive(-1,true)
local name=cfg.name
widget:SetChildText(gainItemCmpIndex.name,name)
local jumpParam=cfg.jumpParam
local hasJumpParam=jumpParam~=nil
local unLock=self:checkIsUnlock(cfg)
local unlockTipsStr=cfg.unlockTips or"功能未解锁"
if not unLock then

widget:SetChildButtonClick(gainItemCmpIndex.bg,function()
UIManager.error(unlockTipsStr)
end,true)
else
if hasJumpParam then
widget:SetChildButtonClick(gainItemCmpIndex.bg,function()
return jumpManager:jump(jumpParam)
end,true)
else
widget:SetChildButtonClick(gainItemCmpIndex.bg,function()
return
end,true)
end
end
widget:SetChildActive(gainItemCmpIndex.lockImg,not unLock)

widget:SetChildActive(gainItemCmpIndex.goBtn,unLock and hasJumpParam)
else
widget:SetChildActive(-1,false)
end
end)
end

function UIXianJie_extraTeamGainWin:checkIsUnlock(cfg)
local gainType=cfg.type
local isUnlock=true
if gainType==1 then

elseif gainType==2 then

local handle=seasonModel:getHandle(0)
if not seasonController:checkSeasonHandleOpen(0)or not handle or not handle:checkShowCondition()then
isUnlock=false
end
end
return isUnlock
end



