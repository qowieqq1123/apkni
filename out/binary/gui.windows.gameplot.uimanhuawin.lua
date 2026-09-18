







def_class("UIManHuaWin",UIWindowBase)









function UIManHuaWin:bindComponents()

self.manhuaRoot=UIObject.get(self,0)
self.skipBtn=UIButton.get(self,1)
self.arrowShadow=UIObject.get(self,2)
self.topUIRoot=UIObject.get(self,3)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)



end


function UIManHuaWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.manhuaRoot);self.manhuaRoot=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.arrowShadow);self.arrowShadow=nil;
_UIObject_release(self.topUIRoot);self.topUIRoot=nil;
end

















function UIManHuaWin:onLoaded(...)
self:bindComponents()

local arrs=self:getChildCanvas(-1)
local sortLayer=arrs[1]
local sortOrder=arrs[2]
self.topUIRoot:setChildCanvas(sortLayer,sortOrder+220)
end


function UIManHuaWin:__delete()
self:unbindComponents()
end


function UIManHuaWin:onHide()

end




function UIManHuaWin:onShow(argtable,afterOnloaded)
self.groupid=argtable.groupid
self.callback=argtable.callback
self.isFullOpen=argtable.isFullOpen

local groupcfg=cfgHelper.get(cfg_manhuagroupconfig_get,self.groupid)
self.manhualist=groupcfg.manhualist


local showSkip=groupcfg.allowskip
self.skipBtn:setActive(showSkip==true)

self.curIndex=0
self.maxIndex=#self.manhualist
self.isPlaying=true
self.playSoundList={}


self.beforeBgm=AudioManager.getCurrentBgm()
self.nowBgmHandle=nil
self.nowBgmId=nil

self:doNext()
end

function UIManHuaWin:doNext()
self.curIndex=self.curIndex+1
if self.curIndex<=self.maxIndex then
self.playSoundList={}
local idx=self.manhualist[self.curIndex]
self.manhuacfg=cfgHelper.get1(cfg_manhuaconfig_get,idx)
self:showManHua()
else
self.isPlaying=false
self:finish()
end
end

function UIManHuaWin:showManHua()
local abname=self.manhuacfg.abname

if webGLHelper:isRunMiniGame()and self.manhuacfg.wxAbname~=nil then
abname=self.manhuacfg.wxAbname
end









local soundList=self.manhuacfg.soundList
if soundList and next(soundList)then
for i=1,#soundList do
local soundClip=soundList[i][1]
local soundId=soundList[i][2]
self.manhuaRoot:addChildUIAnimatorPrefabEventInt(soundClip,"animatorPlaySound",soundId)
end
end

self.manhuaRoot:setChildUIAnimatorPrefabLoaderCreate(abname,'',function(obj)

self:animatorPrefabInitCallBack(obj)
end)

local pageBgmId=self.manhuacfg.pageBGM
local fadeTime=0.5
if pageBgmId then

if pageBgmId~=self.nowBgmId then

self.nowBgmHandle=AudioManager.playBgMusic(pageBgmId,fadeTime)
self.nowBgmId=pageBgmId
end
else

if not self.nowBgmHandle then

AudioManager.fadeoutBGMusic(fadeTime)
end
end

self:clearStayTimer()
self:clearPlayTimer()
self:setPlayTimer()
self.talking=true
self.arrowShadow:setActive(false)
end

function UIManHuaWin:setPlayTimer()
local time=self.manhuacfg.time/1000
local func=function()
self.talking=false
self.arrowShadow:setActive(true)
self:setStayTimer()
end
self.playTimer=self:setTimer(time,1,func)
end

function UIManHuaWin:clearPlayTimer()
if self.playTimer~=nil then
self:stopTimerByID(self.playTimer)
self.playTimer=nil
end
end

function UIManHuaWin:setStayTimer()
local time=self.manhuacfg.staytime
if time>0 then
local func=function()
self:doNext()
end
self.stayTimer=self:setTimer(time/1000,1,func)
else
self:doNext()
end
end

function UIManHuaWin:clearStayTimer()
if self.stayTimer~=nil then
self:stopTimerByID(self.stayTimer)
self.stayTimer=nil
end
end

function UIManHuaWin:finish()
self:clearPlaySound()


if self.beforeBgm then
AudioManager.playBgMusic(self.beforeBgm)
end
local isFullOpen=self.isFullOpen
local cb=self.callback
self:closeFullWin(isFullOpen)
if cb~=nil then cb()end
end

function UIManHuaWin:closeFullWin(isFullOpen)
if isFullOpen then
fullScreenUI.closeActiveUI()
else
self:closeSelf()
end
end

function UIManHuaWin:onSkipBtn()
self:clearStayTimer()
self:finish()
end

function UIManHuaWin:onBackClick()
if not self.isPlaying then return end
if not self.talking then
self:clearStayTimer()
self:doNext()
end
end


function UIManHuaWin:animatorPrefabInitCallBack(obj)
self.animatorObj=obj;
local component=self.animatorObj:GetComponent("CSGUILuaFunction")
if component then
CS.BindFunction(component,self)
end
end


function UIManHuaWin:animatorPlaySound(soundId)
local audioHandleId=AudioManager.playAudio(soundId)

table.insert(self.playSoundList,audioHandleId)
end


function UIManHuaWin:clearPlaySound()
if self.playSoundList and next(self.playSoundList)then
local fadeTime=1
for i,v in ipairs(self.playSoundList)do
AudioManager.fadeOutStopAudioById(v,fadeTime)
end


self.playSoundList={}
end
end
