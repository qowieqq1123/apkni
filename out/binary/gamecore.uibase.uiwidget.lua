







UIWidget=simple_class(UIWidgetBase)

local UIHelper=CS.UIHelper
local _Destroy=UnityEngine.GameObject.Destroy
local _BindWindow=CS.BindWindow
local _FindButton=UIHelper.FindButton
local _FindImage=UIHelper.FindImage
local _FindText=UIHelper.FindText
local _FindCSGUIProgressbar=UIHelper.FindCSGUIProgressbar
local _FindWindowLua=UIHelper.FindWindowLua
local _FindEnhancedScrollerLua=UIHelper.FindEnhancedScrollerLua
local _FindTransform=UIHelper.FindTransform
local _FindRectTransform=UIHelper.FindRectTransform
local _FindSlider=UIHelper.FindSlider

local _GetWindowLua=UIHelper.GetWindowLua
local _GetButton=UIHelper.GetButton
local _GetSlider=UIHelper.GetSlider


function UIWidget:__init(gameObject,winlua,events,onStartCallback,name)
self.__name=name or''
self.gameObject=gameObject
self.winlua=winlua
self.winid=winlua
self.transform=gameObject.transform
self.widget=winlua
self.isClose=false
_BindWindow(winlua,self)







end

function UIWidget:__delete()
local selfTableName=self.__name
if self.stopAllTimer then
self:stopAllTimer()
end
self.gameObject=nil
self.winlua=nil
self.winid=nil
self.transform=nil

if self._updateTimer then
self._updateTimer:cancel()
self._updateTimer=nil
end
local _closeSelfFun=self.closeSelf
for k,v in pairs(self)do
self[k]=nil
end
self.closeSelf=_closeSelfFun
_closeSelfFun=nil
self.isClose=true


rawset(self,'__deleted__',true)
local traceback=debug.traceback()
setmetatable(self,{
__index=function(r,b)
logErr('引用错误,界面',selfTableName,'已关闭,不能再获取',b,'的值, \n堆栈信息:\n',traceback,'\n-------------------------------\nerror:')
end,
__newindex=function(r,b)
logErr('引用错误,界面',selfTableName,'已关闭,不能再设置',b,'的值, \n堆栈信息:\n',traceback,'\n-------------------------------\nerror:')
end
})
end

function UIWidget:destroySelf()
self.winlua:DestroySelf()

self:deleteSelf()
end

function UIWidget:deStory()
local v=self.gameObject
if v then
self:deleteSelf()
_Destroy(v)
end
end


function UIWidget:onLoaded()

end

function UIWidget:Start()

self.started=true;
if self._onStartCallback~=nil then
self._onStartCallback()
self._onStartCallback=nil
end

end

function UIWidget:SetStartCallback(cb)

self._onStartCallback=cb
end

function UIWidget:OnEnable()

end

function UIWidget:OnDisable()

end



function UIWidget:enableUpdate(interval)
if self._updateTimer==nil then
self._updateTimer=timer.new()
self._updateTimer:start(interval or 0.1,function()self:onUpdate()end)
end
end

function UIWidget:onUpdate()

end


function UIWidget:UnBindLua()

self.winlua:UnBindLua()
end

function UIWidget:active(...)

end

function UIWidget:unActive(...)

end

function UIWidget:FindButton(name)

return _FindButton(self.gameObject,name)
end

function UIWidget:FindTransform(name)

return _FindTransform(self.gameObject,name)
end

function UIWidget:FindRectTransform(name)

return _FindRectTransform(self.gameObject,name)
end

function UIWidget:FindImage(name)

return _FindImage(self.gameObject,name)
end

function UIWidget:FindSlider(name)
return _FindSlider(self.gameObject,name)
end

function UIWidget:FindText(name)

return _FindText(self.gameObject,name)
end

function UIWidget:FindCSGUIProgressbar(name)

return _FindCSGUIProgressbar(self.gameObject,name)
end

function UIWidget:FindWindowLua(name)

return _FindWindowLua(self.gameObject,name)
end

function UIWidget:FindEnhancedScrollerLua(name)

return _FindEnhancedScrollerLua(self.gameObject,name)
end


function UIWidget:GetButton()

return _GetButton(self.gameObject)
end

function UIWidget:GetSlider()

return _GetSlider(self.gameObject)
end

function UIWidget:GetWindowLua()

return _GetWindowLua(self.gameObject)
end

function UIWidget:reload()
UIManager:closeWindow(self.__name)
UIManager:showWindow(self.__name)
end

