







def_class("UIMovieWin",UIWindowBase)









function UIMovieWin:bindComponents()

self.movieRoot=UIObject.get(self,0)
self.skipBtn=UIButton.get(self,1)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)



end


function UIMovieWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.movieRoot);self.movieRoot=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
end

















function UIMovieWin:onLoaded(...)
self:bindComponents()
end


function UIMovieWin:__delete()
self:unbindComponents()
end


function UIMovieWin:onHide()

end




function UIMovieWin:onShow(argtable,afterOnloaded)
self.movieid=argtable.movieid
self.callback=argtable.callback

self.moviecfg=cfgHelper.get(cfg_movieconfig_get,self.movieid)

self:showManHua()
end

function UIMovieWin:showManHua()
local abname=self.moviecfg.abname


self:clearPlayTimer()
self:setPlayTimer()
end

function UIMovieWin:setPlayTimer()
local time=self.moviecfg.time/1000
local func=function()
self:finish()
end
self.playTimer=self:setTimer(time,1,func)
end

function UIMovieWin:clearPlayTimer()
if self.playTimer~=nil then
self:stopTimerByID(self.playTimer)
self.playTimer=nil
end
end

function UIMovieWin:finish()
local cb=self.callback
self:closeFullWin()
if cb~=nil then cb()end
end

function UIMovieWin:closeFullWin()
fullScreenUI.closeActiveUI()
end

function UIMovieWin:onSkipBtn()
self:closeFullWin()
end