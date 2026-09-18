







def_class("UIXingYu_jiesuanWin",UIWindowBase)









function UIXingYu_jiesuanWin:bindComponents()

self.descTxt=UIText.get(self,0)



end


function UIXingYu_jiesuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descTxt);self.descTxt=nil;
end



















function UIXingYu_jiesuanWin:onLoaded(...)
self:bindComponents()
end


function UIXingYu_jiesuanWin:__delete()
self:unbindComponents()
end




function UIXingYu_jiesuanWin:onShow(argtable,afterOnloaded)
local data=argtable.data
if data and data[1]==1 then
if data[2]then
self.descTxt:setText("恭喜祖师在本轮对战中获胜！")
else
self.descTxt:setText("恭喜祖师在最终对战中力胜强敌，夺得冠军！")
end
else
self.descTxt:setText("很遗憾，祖师在本轮对战中惜败，将离开星域")
end

end


function UIXingYu_jiesuanWin:onHide()

end



