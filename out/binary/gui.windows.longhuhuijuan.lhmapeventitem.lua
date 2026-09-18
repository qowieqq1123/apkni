







def_class("lhMapEventItem",UICloneObject)





lhMapEventItem.abName="ui/windows/longhuhuijuan/lhmapeventitem.ab"

lhMapEventItem.assetName="lhMapEventItem"


function lhMapEventItem:bindComponents()

self.root=UIObject.get(self,0)
self.Button=UIButton.get(self,1)
self.tIcon=UIImage.get(self,2)
self.zhenji=UIImage.get(self,3)
self.Image=UIObject.get(self,4)

self.Button:setButtonClick(function()self:onButton()end)

end


function lhMapEventItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.Button);self.Button=nil;
_UIObject_release(self.tIcon);self.tIcon=nil;
_UIObject_release(self.zhenji);self.zhenji=nil;
_UIObject_release(self.Image);self.Image=nil;
end









function lhMapEventItem:onLoaded(...)
self:bindComponents()
end


function lhMapEventItem:__delete()
self:doPunchRotation(self:getWidget(),self.tIcon:getID(),0,false)
self:unbindComponents()
end




function lhMapEventItem:onShow(argtable,afterOnloaded)
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan
self.subid=argtable.sub_act_id

self.eventType=argtable.eventType

self.mainEventCfg=argtable.mainEventCfg

self.lineIdx=argtable.lineIdx
self.lineIdx2=argtable.lineIdx2
self.lineEventCfg=argtable.lineEventCfg

self.zjEvent=argtable.zjEvent
self.plotId=argtable.plotId
self.zjPos=argtable.zjPos

if self.mainEventCfg then
local posId=self.mainEventCfg[2]

local posCfg=cfgHelper.get(cfg_longhuhuijuanposconfig_get,posId)
self.root:setLocalPos(posCfg.pos[1],posCfg.pos[2],0)
self.tIcon:setActive(true)
self.tIcon:setCSImageSprite("ui/windows/longhuhuijuan/longhuhuijuan_atlas_pak.ab","image_longhuhuj_12")
self.zhenji:setActive(false)

self:doPunchRotation(self:getWidget(),self.tIcon:getID(),0,true)
end

if self.lineEventCfg then
local posId=self.lineEventCfg[2]

local posCfg=cfgHelper.get(cfg_longhuhuijuanposconfig_get,posId)
self.root:setLocalPos(posCfg.pos[1],posCfg.pos[2],0)
self.tIcon:setActive(true)
self.tIcon:setCSImageSprite("ui/windows/longhuhuijuan/longhuhuijuan_atlas_pak.ab","image_longhuhuj_12A")
self.zhenji:setActive(false)

self:doPunchRotation(self:getWidget(),self.tIcon:getID(),0,true)
end

if self.zjEvent then
local posCfg=cfgHelper.get(cfg_longhuhuijuanposconfig_get,self.zjPos)
self.root:setLocalPos(posCfg.pos[1],posCfg.pos[2],0)
self.tIcon:setActive(false)
self.zhenji:setActive(true)

self:doPunchRotation(self:getWidget(),self.tIcon:getID(),0,false)
end
end


function lhMapEventItem:onHide()

end

function lhMapEventItem:onButton()
if self.eventType==1 then
activitiesHandle_longhuhuijuan.req_event_start(self.actid,self.subid,1,self.lineIdx,self.lineIdx2)
elseif self.eventType==2 then
activitiesHandle_longhuhuijuan.req_event_start(self.actid,self.subid,2,self.lineIdx,self.lineIdx2)
elseif self.eventType==3 then
UIManager:showWindow("UIZhenJiFixWin",{act_id=self.actid,sub_act_id=self.subid,zhenjiId=self.zjEvent,plotId=self.plotId})
end
end

function lhMapEventItem:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


