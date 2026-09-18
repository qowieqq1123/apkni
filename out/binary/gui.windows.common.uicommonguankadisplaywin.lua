







def_class("UICommonGuanKaDisplayWin",UIWindowBase)









function UICommonGuanKaDisplayWin:bindComponents()

self.Content=UIObject.get(self,0)
self.creator=UIObject.get(self,1)
self.leftJianTou=UIButton.get(self,2)
self.rightJianTou=UIButton.get(self,3)
self.scrollview=UIObject.get(self,4)

self.leftJianTou:setButtonClick(function()self:onLeftJianTou()end)

self.rightJianTou:setButtonClick(function()self:onRightJianTou()end)



end


function UICommonGuanKaDisplayWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.creator);self.creator=nil;
_UIObject_release(self.leftJianTou);self.leftJianTou=nil;
_UIObject_release(self.rightJianTou);self.rightJianTou=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
end
















local _this




function UICommonGuanKaDisplayWin:onLoaded(...)
self:bindComponents()

_this=self
self.tickTimers={}

self:addNotify(notifyConfig.onBuildTiaoZhanItemStateChange,self.onBuildTiaoZhanItemStateChange)
end


function UICommonGuanKaDisplayWin:__delete()
_this=nil
self:unbindComponents()
end




function UICommonGuanKaDisplayWin:onShow(argtable,afterOnloaded)

self.argtable=argtable
self.viewArgs=argtable.args

local sortArgs=self:getChildCanvas(-1)
local sortLayer=sortArgs[1]
local sortOrder=sortArgs[2]-1
self:showWindow("UIRawImageBackWin",{sortLayer=sortLayer,
sortOrder=sortOrder})


self:stopAllTimer()
local cfgs=argtable.cfgs
local len=#cfgs
self.cfgs=cfgs



self.gridLen=len
if self.gridLen<4 then
self.leftJianTou:setActive(false)
self.rightJianTou:setActive(false)
end
self.scrollview:setChildScrollRectEnable(len>3)
self.scrollview:setChildScrollViewCreateGrids(len,len)
self.items=self.scrollview:getChildScrollViewItemWidgets()

self.typeIndexLookUp={}

for index=1,len do
self:refreshItem(index)
end

self:refreshJiantou()
end

function UICommonGuanKaDisplayWin:refreshItem(index,noTimer)
local widget=self.items[index-1]

local viewArgs=self.viewArgs
local cfgs=self.argtable.cfgs

local config=cfgs[index]
local typo=config.typo
self.typeIndexLookUp[typo]=index
local reddot=config.reddotFunc and config.reddotFunc(viewArgs)
local ret,args
if config.unlockFunc then
ret,args=config.unlockFunc(viewArgs)
end
if ret==nil then ret=true end
if reddot==nil then reddot=false end

widget:SetChildButtonClick(0,function(...)
if not ret then
local tips=_this:getTips(args)
if args.isUseDialouge then
_this:showDialouge(tips)
else
UIManager.error(tips)
end
else
_this:onClickItem(typo,config)
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
_this:handleLockArgs(widget,index,args,noTimer)
end

if config.newbieGuidStr~=nil then
widget:SetChildNewBieComponentId(0,config.newbieGuidStr)
widget:SetChildWeakGuideComponentId(0,config.newbieGuidStr)
end

local dayShow,dayTips=false,''
if ret and config.dayFunc~=nil then
dayShow=true
dayTips=config.dayFunc()
end

if ret and config.dayTimeJiuYouTa~=nil then
self:clearTimer(index)
local curTimeStamp=timeHelper.getServerLongTime()
local endTimeStamp,dayStrFmt,defaultStr=config.dayTimeJiuYouTa()
if endTimeStamp and endTimeStamp>curTimeStamp then
local tickJiuYouTa=function()
if _this==nil then return end
curTimeStamp=timeHelper.getServerLongTime()
local left=endTimeStamp-curTimeStamp
local dayTips=FMT.fmt(dayStrFmt,timeHelper.format_time_stamp12(left))
if left<0 then
_this:clearTimer(index)
_this:refreshItem(index)
dayTips=defaultStr
end
widget:SetChildText(5,dayTips)
end
self.tickTimers[index]=self:setTimer(1,0,tickJiuYouTa)
tickJiuYouTa()
end
end

if ret and config.dayTime~=nil then
self:clearTimer(index)
local curTimeStamp=timeHelper.getServerShortTime()
local endTimeStamp,dayStrFmt,defaultStr=config.dayTime()
if endTimeStamp and endTimeStamp>curTimeStamp then
local tick=function()
if _this==nil then return end
curTimeStamp=timeHelper.getServerShortTime()
local left=endTimeStamp-curTimeStamp
local dayTips=FMT.fmt(dayStrFmt,timeHelper.format_time_stamp12(left))
if left<0 then
_this:clearTimer(index)
_this:refreshItem(index)
dayTips=defaultStr
end
widget:SetChildText(5,dayTips)
end

self.tickTimers[index]=self:setTimer(1,0,tick)
tick()
end
end

widget:SetChildActive(4,dayShow)
widget:SetChildText(5,dayTips)
end



function UICommonGuanKaDisplayWin:onHide()

end



function UICommonGuanKaDisplayWin:handleLockArgs(widget,index,args,noTimer)
args=args or{}
local typo=args.typo
local args=args.args
if typo==nil then
widget:SetChildActive(2,false)
widget:SetChildText(3,'')
elseif typo==1 and(not noTimer)then
widget:SetChildActive(2,true)
local endStamp=args.endStamp
local txtFmt=args.txtFmt
local tick=function()
local stamp=timeHelper.getServerShortTime()
local left=endStamp-stamp
if left>0 then
widget:SetChildText(3,FMT.fmt(txtFmt,timeHelper.formatSimpleTime(left)))
else
_this:clearTimer(index)

widget:SetChildGraphicGray(0,false)
widget:SetChildActive(2,false)
widget:SetChildText(3,"")

_this:refreshItem(index,true)
end
end
self.tickTimers[index]=self:setTimer(1,0,tick)
tick()
elseif typo==2 or typo==3 then
local txt=args.txt
widget:SetChildActive(2,true)
widget:SetChildText(3,txt)
end
end

function UICommonGuanKaDisplayWin:clearTimer(index)
if self.tickTimers[index]then
self:stopTimerByID(self.tickTimers[index])
self.tickTimers[index]=nil
end
end

function UICommonGuanKaDisplayWin:getTips(args)
args=args or{}
local typo=args.typo
local args=args.args
if typo==1 then
local endStamp=args.endStamp
local txtFmt=args.txtFmt
return FMT.fmt(txtFmt,timeHelper.formatSimpleTime(endStamp))
elseif typo==2 then
return args.txt
elseif typo==3 then
return args.errtip
end
end

function UICommonGuanKaDisplayWin:onClickItem(typo,config)
buildTiaoZhanControl:showTiaoZhanWindow(typo,self.viewArgs)
self:closeSelf()
end

function UICommonGuanKaDisplayWin:showDialouge(content)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
allowclickBG=true,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end


local _iconWidth=300
local _iconSpan=100
local _iconListLeftSpan=50
local _iconListRightSpan=50
local _moveSpeed=1000
function UICommonGuanKaDisplayWin:refreshJiantou()
if self.gridLen<4 then
self.leftJianTou:setActive(false)
self.rightJianTou:setActive(false)
return
end
local pos=self.Content:getChildAnchoredPosition()
local state=pos.x<-_iconListLeftSpan

self.leftJianTou:setActive(state)
self.rightJianTou:setActive(not state)

self.isShowLeftJT=state
end

function UICommonGuanKaDisplayWin:onScrollViewChange()
self:refreshJiantou()
end

function UICommonGuanKaDisplayWin:onLeftJianTou()
local pos=self.Content:getChildAnchoredPosition()
local toposx=pos.x+_iconWidth+_iconSpan
toposx=Mathf.Min(toposx,0)
self.Content:setChildDOAnchorPosX(toposx,(-(pos.x-toposx))/_moveSpeed,nil)
end

function UICommonGuanKaDisplayWin:onRightJianTou()
local pos=self.Content:getChildAnchoredPosition()
local swidth=self.scrollview:getChildSizeDeltaX()
local iwidth=self.Content:getChildSizeDeltaX()

local toposx=pos.x-_iconWidth-_iconSpan
toposx=Mathf.Max(toposx,swidth-iwidth)

self.Content:setChildDOAnchorPosX(toposx,(-(toposx-pos.x))/_moveSpeed,nil)
end

function UICommonGuanKaDisplayWin.onBuildTiaoZhanItemStateChange(typo)
if _this==nil or _this.typeIndexLookUp==nil or next(_this.typeIndexLookUp)==nil or _this.typeIndexLookUp[typo]==nil then return end

local index=_this.typeIndexLookUp[typo]
_this:refreshItem(index)
end

