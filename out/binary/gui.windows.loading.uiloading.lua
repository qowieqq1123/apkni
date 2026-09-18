







def_class("UILoading",UIWindowBase)









function UILoading:bindComponents()

self.ani=UIObject.get(self,0)
self.progress=UIObject.get(self,1)
self.progressBar=UIProgressBarAni.get(self,2)
self.progressBar2=UIProgressBarAni.get(self,3)
self.HandleRect=UIObject.get(self,4)
self.progressCount=UIText.get(self,5)
self.effect=UIObject.get(self,6)
self.HandleAni=UIObject.get(self,7)
self.ruletips=UIText.get(self,8)



end


function UILoading:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ani);self.ani=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressBar2);self.progressBar2=nil;
_UIObject_release(self.HandleRect);self.HandleRect=nil;
_UIObject_release(self.progressCount);self.progressCount=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.HandleAni);self.HandleAni=nil;
_UIObject_release(self.ruletips);self.ruletips=nil;
end
















local cloudClose=0
local cloudOpen=1
local cloudCloseImmediately=2
local cloudOpenImmediately=3

local animationList={
eAnimationID.juanzhou_idle1,
eAnimationID.juanzhou_idle2,
eAnimationID.juanzhou_idle3,
}

local animationOffsetXList={
-155,
-60,
40,
}
local locktype=
{
wanfa=1,
gongyue=2,
}


local _max=500
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool



function UILoading:onLoaded(...)
self:bindComponents()
CS.BindWidget(self.ani:getWidgetBase(),self)
self._onLoadSceneLoading=function(...)
self:onLoadSceneLoading(...)
end
notifySystem:listenNotify(notifyConfig.loadingObj,self._onLoadSceneLoading)
self._onProgressUpdateAction=function(...)
self:onProgressUpdateAction(...)
end
self.progressBar:setUpdateAction(self._onProgressUpdateAction)

self:startProgressAni()

end


function UILoading:__delete()
self.progressBar:setUpdateAction(nil)

self:unbindComponents()
self.loadInfo=nil
notifySystem:removelistener(notifyConfig.loadingObj,self._onLoadSceneLoading)
if LuaApplication.state==loginState then
loginState:closeLoginWin()
end
end





function UILoading:onShow(loadInfo,afterOnloaded)
local idx=loadInfo.idx
self.loadInfo=loadInfo

local aindex=idx or math.random(1,#animationList)
self.HandleAni:setLocalPosX(animationOffsetXList[aindex])
self.winid:SetChildShowEffect(self.effect:getID(),10159,true)
self.winlua:SetChildSpineAnimation(self.HandleAni:getID(),animationList[aindex],1,nil)




self:startAni()

self:showGameDesc()
local blflag=buildlightController:getFirstLodingBLFlag()
if not blflag then
buildlightController:firstRefreshBLState()
buildlightController:setFirstLodingBLFlag(true)
end
end


function UILoading:onHide()
self.loadInfo=nil
end




function UILoading:onCloseFinish()

buildlightController:pause()
self.cloudIsClose=true
self:invokeStartCallback()
loginState:closeLoginWin()
end


function UILoading:onOpenFinish()
self:invokeFinishCallback()
self:closeSelf()
end

function UILoading:onOpenSee()
notifySystem:postNotify(notifyConfig.endCloud,1)
end


function UILoading:onCloseStart()

AudioManager.playAudio(614)
end


function UILoading:onOpenStart()

buildlightController:resume()
AudioManager.playAudio(615)
end


function UILoading:setState(state)
self.winlua:SetChildAnimatorInteger(self.ani:getID(),'state',state,true)
end


function UILoading:startAni()

if self.cloudIsClose then
self:invokeStartCallback()
return
end


if self.loadInfo~=nil and self.loadInfo.immediately then
self:setState(cloudCloseImmediately)
self:invokeStartCallback()
else
self:setState(cloudClose)
end
end


function UILoading:endAni()

notifySystem:postNotify(notifyConfig.startEndCloud,1)
self:setState(cloudOpen)
self:delayDo(0.5,function()
self.progress:setActive(false)
end,true)
return true
end

function UILoading:invokeStartCallback()
if self.loadInfo and self.loadInfo.onLoadStart then
self.loadInfo.onLoadStart()
end
end

function UILoading:invokeFinishCallback()
if self.loadInfo~=nil and self.loadInfo.onCloseLoading~=nil then
self.loadInfo.onCloseLoading()
end
end

function UILoading:onProgressUpdateAction(div,time)
local val=math.floor(div*100)
self.progressNum=div*_max
self.progressCount:setText(FMT.fmt('{0}%',val))
end

function UILoading:onLoadSceneLoading(num,max)
local verifyHideLoader=_AppConfig_GetBool("verifyHideLoader",false)
if verifyHideLoader and verifyManager:isOpen()then
self.progress:setActive(false)
return
end

if max==0 then return end
if self.left==nil then
self.left=self.max-self.progressNum
self.lastProgressNum=self.progressNum
end
if self.left>0 then
local multi=self.left/max
local num1=math.floor(num*multi)+self.lastProgressNum
self.progressBar:animateThreeParams(num1,self.max,0.2)
self.progressBar2:animateTwoParams(num1,self.max)
end
end

function UILoading:startProgressAni()
local verifyHideLoader=_AppConfig_GetBool("verifyHideLoader",false)
if verifyHideLoader and verifyManager:isOpen()then
self.progress:setActive(false)
return
end
self.progress:setActive(true)
self.max=_max
self.progressNum=0
self.progressBar:animateThreeParams(self.max,self.max,5)

end

function UILoading:endProgressAni(delay)
local verifyHideLoader=_AppConfig_GetBool("verifyHideLoader",false)
if verifyHideLoader and verifyManager:isOpen()then
self.progress:setActive(false)
return
end
self.progress:setActive(true)
self.max=_max
self.progressBar:animateThreeParams(self.max,self.max,delay)

end

function UILoading:test(idx)
self.HandleAni:setLocalPosX(animationOffsetXList[idx])
self.winlua:SetChildSpineAnimation(self.HandleAni:getID(),animationList[idx],1,nil)
end


function UILoading:showFirstLoadDesc()
local cfgku=cfg_globalconfig_get(1).loadingTxt
local gongyuedesc=cfgku[locktype.gongyue]
self.ruletips:setActive(true)
self.ruletips:setText(gongyuedesc)
loginControl:setFirstLodingFlag(true)
end


function UILoading:showGameDesc()
local cfgku=cfg_globalconfig_get(1).loadingTxt

local wanfadescList=cfgku[locktype.wanfa]
local wanfadesc
local day_=timeHelper.getServerOpenDay()
for i,v in ipairs(wanfadescList)do
local minDay=v[1]
local maxDay=v[2]
if day_>=minDay and(maxDay==0 or day_<=maxDay)then
wanfadesc=v[3]
break
end
end
if not wanfadesc then

return
end

local list={}
for k,v in ipairs(wanfadesc)do
local jisuo=v[3]
if jisuo then

local unlock=false
for i,j in ipairs(jisuo)do
if j[1]==1 then

if systemModel.isOpen(j[2])then
unlock=true
else
unlock=false
end
elseif j[1]==2 then
local day_=timeHelper.getServerOpenDay()
if day_>=j[2]then
unlock=true
else
unlock=false
end
elseif j[1]==3 then
local level=zongmenModel:getLevel()
if level>=j[2]then
unlock=true
else
unlock=false
end
end
end
if unlock then
table.insert(list,v)
end
else
table.insert(list,v)
end
end

local info1,idx,info=roleAudioModel:randomByWeight(list)
if info1 then
local str=info1[1]or""
self.ruletips:setActive(true)
self.ruletips:setText(str)
end

end




function UILoading:randomByWeight(lib,totalWeight)
if not totalWeight then
totalWeight=0
for _,info in ipairs(lib)do
totalWeight=totalWeight+info[2]
end
if totalWeight<=0 then
return
end
end


local rand=math.random(1,totalWeight)
local rate=0
for idx,info in ipairs(lib)do
rate=rate+info[2]
if rand<=rate then

return info[1],idx,info
end
end
end
