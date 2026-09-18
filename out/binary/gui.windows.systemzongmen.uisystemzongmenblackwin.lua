







def_class("UISystemZongMenBlackWin",UIWindowBase)







local cshelper=CS.UIHelper

function UISystemZongMenBlackWin:auto_bind()
end














local _this=nil




function UISystemZongMenBlackWin:onLoaded(...)

_this=self
end


function UISystemZongMenBlackWin:__delete()

_this=nil
self:closeExtra()
systemZongMenController:endResult()
UIManager:invokeUIMethod("UISystemZongMenTaYinWin","setViewReady")
end




function UISystemZongMenBlackWin:onShow(argtable,afterOnloaded)
self.current=0
self.list=argtable.list

self:switchNext()
end


function UISystemZongMenBlackWin:onHide()

end



function UISystemZongMenBlackWin:closeExtra()
local current=self.list[self.current]
if current then
local winName=current.winName
UIFullSystemZongMenControl:closeWindow(winName)
end
end

function UISystemZongMenBlackWin:openExtra()
local current=self.list[self.current]
if current then
local winName=current.winName
local winParam=current.winParam or{}
winParam.parentWin=self
winParam.callback=function()
self:switchNext()
end
UIFullSystemZongMenControl:showWindow(winName,winParam)
else
self:closeSelf()
end
end

function UISystemZongMenBlackWin:switchNext()
self:closeExtra()
self.current=self.current+1
self:openExtra()
end