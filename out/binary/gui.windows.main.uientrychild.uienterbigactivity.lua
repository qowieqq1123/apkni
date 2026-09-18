







def_class("UIEnterBigActivity",UICloneObject)





UIEnterBigActivity.abName="ui/windows/main/uientrychild/uienterbigitem.ab"

UIEnterBigActivity.assetName="UIEnterBigItem"


function UIEnterBigActivity:bindComponents()

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


function UIEnterBigActivity:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.clickBg);self.clickBg=nil;
end






local iconname='button_yyhdrk_0000'

function UIEnterBigActivity:onLoaded(...)
self:bindComponents()

self.onActivityReddotChange_=function(...)
self:onActivityReddotChange(...)
end
notifySystem:listenNotify(notifyConfig.onActivityReddotChange,self.onActivityReddotChange_)
end

function UIEnterBigActivity:__delete()
self:stopSelfTimer()
self:unbindComponents()

self.act_id=nil
self.sub_act_type=nil
self.sub_act_id=nil

notifySystem:removelistener(notifyConfig.onActivityReddotChange,self.onActivityReddotChange_)
self.onActivityReddotChange_=nil
end

function UIEnterBigActivity:onActivityReddotChange(act_id)
if self.act_id~=act_id then return end

self:refreshReddot()
end

function UIEnterBigActivity:onUIEnterBigActivityIconChange(_act_id)
local _subtype
local _subid
local sublist=activitiesModel:getActSubList_open_doing(_act_id)
if not sublist then
return
end
for i,v in ipairs(sublist)do
local act_id=v.act_id
if act_id==_act_id then
if v.sub_act_type==SUB_ACTIVITY_TYPE.eTaiGuShiLian then
_subtype=v.sub_act_type
_subid=v.sub_act_id
break
end
end
end
if _subtype and _subid then
local actData=BigActivityIconConfig[_subtype]
if actData then
local abname=actData.abname
local iconname=actData.iconname
local callback=actData.callback
if abname and iconname and callback then
local flag=callback(_act_id,_subtype,_subid)
if flag then


self.reddot:setActive(true)
self:doPunchRotation(true)
else

self:refreshReddot()
end
end
end
end
end

function UIEnterBigActivity:onShow(argtable,afterOnloaded)
local info=argtable.info
local params=info.params
local act_id=params.act_id
local act_cfg=activitiesModel:getActConfig(act_id)
local sub_act_type=params.sub_act_type
local sub_act_id=params.sub_act_id
local iconType
local icon
local effectId
local modelParams
if sub_act_type~=nil then

iconType=params.iconType
icon=params.icon
effectId=params.effectId
modelParams=params.modelParams
else
iconType=act_cfg.iconType
icon=act_cfg.icon
effectId=act_cfg.effectId
modelParams=act_cfg.modelParams
end
self.act_id=act_id
self.sub_act_type=sub_act_type
self.sub_act_id=sub_act_id

if modelParams then
self.icon:setActive(false)
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.widget:SetChildUIModelEnableInitUISpineParaEx(self.model:getID(),true,true,true)
end
self.model:setChildUIModelShowTarget(modelParams[1],modelParams[2]or 1,{},modelParams[3]or 0,webGLHelper:isHidePunchAni())
local offsetX=modelParams[4]
local offsetY=modelParams[5]
if offsetX and offsetY and(offsetX>0 or offsetY>0)then
self.model:setChildUIModelShowTargetOffset(offsetX,offsetY)
end
else
self.model:setChildUIModelRemoveTarget()
self.icon:setActive(true)
local abname,iconname=activitiesModel.getEnterIcon(icon)
self.widget:SetChildCSImageSprite(0,abname,iconname)
end
if effectId~=nil and effectId>0 then


else

end
self.widget:SetChildActive(8,false)
self.widget:SetChildText(9,"")
self.widget:SetChildShowEffect(10,0,false)

self.reddot:setActive(false)

local name_str=''





self.widget:SetChildText(2,name_str)

local countdown=activitiesModel:getActConfig(self.act_id,'countdown')
local showTime=countdown~=nil
if showTime then
self:startTimer()
else
self.widget:SetChildText(3,"")
self.widget:SetChildActive(4,false)
end

self:refreshReddot()

self:onUIEnterBigActivityIconChange(self.act_id)

self.widget:SetChildButtonClick(self.clickBg:getID(),function()
activitiesController:jump(act_id,sub_act_type,sub_act_id,{jumpInType=act_jump_in_type.eEnterIn})
end,true)
self.widget:SetChildButtonClick(0,function()
activitiesController:jump(act_id,sub_act_type,sub_act_id,{jumpInType=act_jump_in_type.eEnterIn})
end,true)

end

function UIEnterBigActivity:refreshReddot()
local flag
if self.sub_act_type~=nil then
flag=activitiesModel:checkSubActReddot(self.act_id,self.sub_act_type,self.sub_act_id)
else
flag=activitiesModel:checkActReddot(self.act_id)
end
self.reddot:setActive(flag)
self:doPunchRotation(flag)
end

function UIEnterBigActivity:startTimer()
self.widget:SetChildActive(4,true)

if self.sub_act_type~=nil then
self.stamp=os.time()+activitiesModel:getSubActEndLeftTime(self.act_id,self.sub_act_type,self.sub_act_id)
else
self.stamp=os.time()+activitiesModel:getActEndLeftTime(self.act_id)
end

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

function UIEnterBigActivity:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIEnterBigActivity:onHide()

end

function UIEnterBigActivity:doPunchRotation(reddot)
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


function UIEnterBigActivity:onIcon()

end

function UIEnterBigActivity:onClickBg()

end
