







def_class("UIEnterTianMoJieAct",UICloneObject)





UIEnterTianMoJieAct.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIEnterTianMoJieAct.assetName="UIEnterNomalItem"


function UIEnterTianMoJieAct:bindComponents()

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


function UIEnterTianMoJieAct:unbindComponents()
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








function UIEnterTianMoJieAct:onLoaded(...)
self:bindComponents()

self.onActivityReddotChange_=function(...)
self:onActivityReddotChange(...)
end
notifySystem:listenNotify(notifyConfig.onActivityReddotChange,self.onActivityReddotChange_)
end

function UIEnterTianMoJieAct:__delete()
self:stopSelfTimer()
self:unbindComponents()
self.act_id=nil
self.sub_act_type=nil
self.sub_act_id=nil

notifySystem:removelistener(notifyConfig.onActivityReddotChange,self.onActivityReddotChange_)
self.onActivityReddotChange_=nil
end

function UIEnterTianMoJieAct:onActivityReddotChange(act_id)
if self.act_id~=act_id then return end

self:refreshReddot()
end

function UIEnterTianMoJieAct:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
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
local jumpFunc=function()
jumpManager:jump({id=JUMP_TYPE.eActivity,args={actId=act_id,subType=sub_act_type,subid=sub_act_id}})
end
self.widget:SetChildButtonClick(self.clickBg:getID(),function()
loadingControl.openCloud(jumpFunc,1)
end,true)
self.widget:SetChildButtonClick(0,function()
loadingControl.openCloud(jumpFunc,1)
end,true)

self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end

function UIEnterTianMoJieAct:refreshReddot()
local flag
if self.sub_act_type~=nil then
flag=activitiesModel:checkSubActReddot(self.act_id,self.sub_act_type,self.sub_act_id)
else
flag=activitiesModel:checkActReddot(self.act_id)
end
self.reddot:setActive(flag)
end

function UIEnterTianMoJieAct:startTimer()
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

function UIEnterTianMoJieAct:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIEnterTianMoJieAct:onHide()

end



function UIEnterTianMoJieAct:onIcon()

end

function UIEnterTianMoJieAct:onClickBg()

end
