







def_class("UIEnterBigLimitActivity",UICloneObject)





UIEnterBigLimitActivity.abName="ui/windows/main/uientrychild/uienterbigitem.ab"

UIEnterBigLimitActivity.assetName="UIEnterBigItem"


function UIEnterBigLimitActivity:bindComponents()

self.icon=UIButton.get(self,0)
self.reddot=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.time=UIText.get(self,3)
self.timeBg=UIObject.get(self,4)
self.model=UIObject.get(self,5)
self.clickBg=UIButton.get(self,6)

self.icon:setButtonClick(function()self:onIcon()end)

self.clickBg:setButtonClick(function()self:onClickBg()end)

end


function UIEnterBigLimitActivity:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.clickBg);self.clickBg=nil;
end







function UIEnterBigLimitActivity:onLoaded(...)
self:bindComponents()

self.onLimitActReddotChange_=function(...)
self:onLimitActReddotChange(...)
end
notifySystem:listenNotify(notifyConfig.onLimitActReddotChange,self.onLimitActReddotChange_)
end


function UIEnterBigLimitActivity:__delete()
self:stopSelfTimer()
self:unbindComponents()

self.actID=nil

notifySystem:removelistener(notifyConfig.onLimitActReddotChange,self.onLimitActReddotChange_)
self.onLimitActReddotChange_=nil
end

function UIEnterBigLimitActivity:onLimitActReddotChange(actID)
if self.actID~=actID then return end

self:refreshReddot()
end


function UIEnterBigLimitActivity:onHide()
self.widget:SetChildShowEffect(10,0,false)
end

function UIEnterBigLimitActivity:onUIEnterBigLimitActivityBottomText()

local str=limitActivitiesModel:invokeMethod(self.actID,'getUIEnterBigLimitActivityBottomText')

if str then
self.widget:SetChildActive(4,false)
self.widget:SetChildActive(8,true)
self.widget:SetChildText(9,FMT.fmt('{0}',str))
else
local act_cfg=limitActivitiesModel:getActConfig(self.actID)
local showTime=act_cfg.countdown~=nil
self.widget:SetChildActive(4,showTime)
self.widget:SetChildActive(8,false)
end
end




function UIEnterBigLimitActivity:onShow(argtable,afterOnloaded)
local info=argtable.info
local params=info.params
local actID=params.actID
local act_cfg=limitActivitiesModel:getActConfig(actID)
local iconType
local icon
local effectId
local modelParams

iconType=act_cfg.iconType
icon=act_cfg.icon
effectId=act_cfg.effectId
modelParams=act_cfg.modelParams

self.actID=actID

if modelParams then
self.icon:setActive(false)
self.model:setChildUIModelShowTarget(modelParams[1],modelParams[2]or 1,{},modelParams[3]or 0,webGLHelper:isHidePunchAni())
local offsetX=modelParams[4]
local offsetY=modelParams[5]
if offsetX and offsetY and(offsetX>0 or offsetY>0)then
self.model:setChildUIModelShowTargetOffset(offsetX,offsetY)
end
else
self.model:setChildUIModelRemoveTarget()
self.icon:setActive(true)
local abname,iconname=limitActivitiesModel.getActIcon(icon)
self.widget:SetChildCSImageSprite(0,abname,iconname)
end
self.widget:SetChildActive(10,false)
if effectId~=nil and effectId>0 then
self.widget:SetChildActive(10,true)
local m_cav=self:getChildCanvas(-1)
self.widget:SetChildShowEffectEx(10,effectId,m_cav[1],m_cav[2]+1,true)
else
self.widget:SetChildShowEffect(10,0,false)
end

self.reddot:setActive(false)

local name_str=''



self.widget:SetChildText(2,name_str)

local countdown=act_cfg.countdown
local showTime=countdown~=nil
if showTime then
self:startTimer()
else
self.widget:SetChildText(3,"")
self.widget:SetChildActive(4,false)
end

self:refreshReddot()

self.widget:SetChildButtonClick(self.clickBg:getID(),function()
limitActivitiesController:jump(actID)
end,true)
self.widget:SetChildButtonClick(0,function()
limitActivitiesController:jump(actID)
end,true)

self:onUIEnterBigLimitActivityBottomText()

end

function UIEnterBigLimitActivity:refreshReddot()
local flag=limitActivitiesModel:getActReddot(self.actID)
self.reddot:setActive(flag)
self:doPunchRotation(flag)
end

function UIEnterBigLimitActivity:startTimer()
self.widget:SetChildActive(4,true)

self.stamp=os.time()+limitActivitiesModel:getActEndLeftTime(self.actID)

self:stopSelfTimer()

local func=function()
if self==nil or self.isClose or self.widget==nil then return end
local left=self.stamp-os.time()
if left<0 then left=0 end
self.widget:SetChildText(3,timeHelper.format_time_stamp3(left))
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIEnterBigLimitActivity:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIEnterBigLimitActivity:doPunchRotation(reddot)
if webGLHelper:isHidePunchAni()then return end
if reddot then
if self.reddotTweener==nil then
self.reddot:setRotation(0,0,0)
local tweener=self.reddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.reddot:setRotation(0,0,0)
end
end
end

function UIEnterBigLimitActivity:onClickBg()

end
