







def_class("xzsChildProgressText",UICloneObject)





xzsChildProgressText.abName="ui/windows/xiaozhushou/child/xzschildprogresstext.ab"

xzsChildProgressText.assetName="xzsChildProgressText"


function xzsChildProgressText:bindComponents()

self.doingText=UIText.get(self,0)
self.icon=UIImage.get(self,1)
self.progress=UIProgressBarAni.get(self,2)
self.resultTx=UIText.get(self,3)
self.title=UIText.get(self,4)

end


function xzsChildProgressText:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.resultTx);self.resultTx=nil;
_UIObject_release(self.title);self.title=nil;
end





local _ab="ui/windows/xiaozhushou/xzsiconsmall_pak.ab"



function xzsChildProgressText:onLoaded(...)
self:bindComponents()
self._onHandleProto=function(...)self:onHandleProto(...)end
self._onHandleNotify=function(...)self:onHandleNotify(...)end
self._onProgressComplete=function(...)
self:onProgressComplete(...)
end
self.progress:setFinishAction(self._onProgressComplete)
end


function xzsChildProgressText:__delete()
self:unbindComponents()
self:stopOverTick()
end




function xzsChildProgressText:onShow(argtable,afterOnloaded)
self.orderID=argtable.orderID
self.detailId=argtable.detailId
self.onCheck=argtable.onCheck
self.onComplete=argtable.onComplete
self.onRecv=argtable.onRecv
self.onNotify=argtable.onNotify

self.detailCfg=cfg_xiaozhushoudetailconfig_get(self.detailId)
self.title:setText(self.detailCfg.name)
local iconName=string.format("image_zsjztps_%d",self.detailCfg.icon)
self.icon:setSprite(_ab,iconName)

local error=argtable.error
if error then
self.progress:setActive(false)
self.resultTx:setActive(true)
self.resultTx:setText(error)
self.widget:ForceLayoutRect(-1)
if self.onComplete then
self.onComplete(self)
end
return
end

self.doingText:setText(self.detailCfg.timeTxt)
self.progress:setActive(true)
self.resultTx:setActive(false)
local time=argtable.time or self.detailCfg.time[1]
self.overTime=self.detailCfg.time[2]
self.overStr=argtable.overStr
self.progress:animateFiveParams(0,10000,10000,time,false)
self.widget:ForceLayoutRect(-1)

if argtable.proto then
self:addProNotify(argtable.proto[1],argtable.proto[2],self._onHandleProto)
end
if argtable.notify then
self:addNotify(argtable.notify,self._onHandleNotify)
end
self.progressing=true
self.complete=false
if argtable.onStart then
argtable.onStart(self)
end
self:startOverTick()
end


function xzsChildProgressText:onHide()

end



function xzsChildProgressText:onProgressComplete()
self.progressing=false
if self.complete then
self:setOverState(false)
end
end

function xzsChildProgressText:onHandleProto(...)
if self.onRecv and self.onRecv(self,...)then
local check=self.onCheck(self)
if check then
self.resultTx:setText(check)
self.complete=true

if not self.progressing then
self:setOverState(false)
end
end
end
end

function xzsChildProgressText:onHandleNotify(...)
if self.onNotify and self.onNotify(self,...)then
local check=self.onCheck(self)
if check then
self.resultTx:setText(check)
self.complete=true

if not self.progressing then
self:setOverState(false)
end
end
end
end

function xzsChildProgressText:setOverState(overTime)
self.progress:setActive(false)
self.resultTx:setActive(true)
self.widget:ForceLayoutRect(-1)
self:stopOverTick()
if self.onComplete then
self.onComplete(self,overTime)
end
end

function xzsChildProgressText:startOverTick()
if not self.overTick then
self.overTick=self:setTimer(self.overTime,1,function()
self.resultTx:setText(self.overStr)
self:setOverState(true)
end)
end
end

function xzsChildProgressText:stopOverTick()
if self.overTick then
self:stopTimerByID(self.overTick)
self.overTick=nil
end
end