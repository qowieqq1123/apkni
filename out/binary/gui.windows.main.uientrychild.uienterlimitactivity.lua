







def_class("UIEnterLimitActivity",UICloneObject)





UIEnterLimitActivity.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterLimitActivity.assetName="UIEnterNomalItem"


function UIEnterLimitActivity:bindComponents()

self.icon=UIButton.get(self,0)
self.reddot=UIObject.get(self,1)
self.name=UIText.get(self,2)
self.time=UIText.get(self,3)
self.timeBg=UIObject.get(self,4)
self.qipao=UIObject.get(self,5)
self.qipaoText=UIText.get(self,6)
self.model=UIObject.get(self,7)
self.clickBg=UIButton.get(self,8)
self.extendbg=UIObject.get(self,9)
self.lldhQiPao=UIObject.get(self,10)

self.icon:setButtonClick(function()self:onIcon()end)

self.clickBg:setButtonClick(function()self:onClickBg()end)

end


function UIEnterLimitActivity:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.qipao);self.qipao=nil;
_UIObject_release(self.qipaoText);self.qipaoText=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.clickBg);self.clickBg=nil;
_UIObject_release(self.extendbg);self.extendbg=nil;
_UIObject_release(self.lldhQiPao);self.lldhQiPao=nil;
end







function UIEnterLimitActivity:onLoaded(...)
self:bindComponents()

self.onLimitActReddotChange_=function(...)
self:onLimitActReddotChange(...)
end
notifySystem:listenNotify(notifyConfig.onLimitActReddotChange,self.onLimitActReddotChange_)
end


function UIEnterLimitActivity:__delete()
self:stopSelfTimer()
self:unbindComponents()
self.actID=nil

notifySystem:removelistener(notifyConfig.onLimitActReddotChange,self.onLimitActReddotChange_)
self.onLimitActReddotChange_=nil
end

function UIEnterLimitActivity:onLimitActReddotChange(actID)
if self.actID~=actID then return end

self:refreshReddot()
end


function UIEnterLimitActivity:onHide()

end




function UIEnterLimitActivity:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
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
self.extendbg:setActive(argtable.isEx or false)

self.qipao:setActive(false)
end

function UIEnterLimitActivity:refreshReddot()
local flag=limitActivitiesModel:getActReddot(self.actID)
self.reddot:setActive(flag)
end

function UIEnterLimitActivity:startTimer()
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

function UIEnterLimitActivity:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIEnterLimitActivity:onClickBg()

end
