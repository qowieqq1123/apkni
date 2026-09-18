







def_class("UIXM_LXWJ_beginWin",UIWindowBase)









function UIXM_LXWJ_beginWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.titleTxt=UIText.get(self,2)



end


function UIXM_LXWJ_beginWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end
















local _this=nil


function UIXM_LXWJ_beginWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_beginWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_beginWin:onHide()

end




function UIXM_LXWJ_beginWin:onShow(argtable,afterOnloaded)
local raceIndex=lingxuwenjianModel:getRaceIndex()
local race_str=FMT.fmt('第{0}届',raceIndex)
self.titleTxt:setText(race_str)

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4794,1,{},2040,false,false,0,function()
if _this==nil then return end
self:delayDo(0.25,function()
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
end
end