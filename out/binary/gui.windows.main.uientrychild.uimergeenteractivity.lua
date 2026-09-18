







def_class("UIMergeEnterActivity",UICloneObject)





UIMergeEnterActivity.abName="ui/windows/main/uientrychild/uienternomalitem.ab"

UIMergeEnterActivity.assetName="UIEnterNomalItem"


function UIMergeEnterActivity:bindComponents()

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


function UIMergeEnterActivity:unbindComponents()
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








function UIMergeEnterActivity:onLoaded(...)
self:bindComponents()

self.onActivityReddotChange_=function(...)
self:onActivityReddotChange(...)
end
notifySystem:listenNotify(notifyConfig.onActivityReddotChange,self.onActivityReddotChange_)
end

function UIMergeEnterActivity:__delete()
self:stopSelfTimer()
self:unbindComponents()
self.act_id=nil
self.sub_act_type=nil
self.sub_act_id=nil

notifySystem:removelistener(notifyConfig.onActivityReddotChange,self.onActivityReddotChange_)
self.onActivityReddotChange_=nil
end

function UIMergeEnterActivity:onActivityReddotChange(act_id)
local enterCfg=cfg_activityentermergeconfig_get(self.mergeId)
for i,actId in ipairs(enterCfg.activityIdList)do
if actId==act_id then
self:refreshReddot()
break
end
end
end

function UIMergeEnterActivity:onShow(argtable,afterOnloaded)
enterConfig.preInitEnter(self)
local info=argtable.info
local params=info.params
local mergeId=params.mergeId
local enterCfg=cfg_activityentermergeconfig_get(mergeId)

local iconType=ENTER_ICON_TYPE.eNomal
local icon=enterCfg.icon
local effectId=enterCfg.effectId
local modelParams=enterCfg.modelParams


self.mergeId=mergeId

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

local countdown=enterCfg.countdown
local showTime=countdown~=nil

if showTime then
self:startTimer()
else
self.widget:SetChildText(3,"")
self.widget:SetChildActive(4,false)
end

self:refreshReddot()

self.widget:SetChildButtonClick(self.clickBg:getID(),function()
local _,act_id=activityEnterMergeController:getMinActEndLeftTime(mergeId)
local list=activitiesModel:getActSubList_open_doing(act_id)
local firstSubData=list[1]
activitiesController:jump(firstSubData.act_id,firstSubData.sub_act_type,firstSubData.sub_act_id,{jumpInType=act_jump_in_type.eEnterIn})
UIManager:closeWindow("UIAct_ExtendEnterWin")
end,true)
self.widget:SetChildButtonClick(0,function()
local _,act_id=activityEnterMergeController:getMinActEndLeftTime(mergeId)
local list=activitiesModel:getActSubList_open_doing(act_id)
local firstSubData=list[1]
activitiesController:jump(firstSubData.act_id,firstSubData.sub_act_type,firstSubData.sub_act_id,{jumpInType=act_jump_in_type.eEnterIn})
UIManager:closeWindow("UIAct_ExtendEnterWin")
end,true)

self.extendbg:setActive(argtable.isEx or false)
self.qipao:setActive(false)
end

function UIMergeEnterActivity:refreshReddot()
local flag=activityEnterMergeController:checkMergeActivityReddot(self.mergeId)
self.reddot:setActive(flag)
end

function UIMergeEnterActivity:startTimer()
self.widget:SetChildActive(4,true)

self.stamp=os.time()+activityEnterMergeController:getMinActEndLeftTime(self.mergeId)

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

function UIMergeEnterActivity:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIMergeEnterActivity:onHide()

end



function UIMergeEnterActivity:onIcon()

end

function UIMergeEnterActivity:onClickBg()

end
