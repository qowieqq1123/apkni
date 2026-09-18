







def_class("UIMysteryTargetStartWin",UIWindowBase)









function UIMysteryTargetStartWin:bindComponents()

self.root=UIObject.get(self,0)
self.maskClick=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.targetRoot=UIObject.get(self,3)
self.ListPanel=UIObject.get(self,4)
self.Mdoel=UIObject.get(self,5)
self.dzSpeak=UIObject.get(self,6)
self.txtDzSpeak=UIText.get(self,7)

self.maskClick:setButtonClick(function()self:onMaskClick()end)



end


function UIMysteryTargetStartWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.maskClick);self.maskClick=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.targetRoot);self.targetRoot=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.Mdoel);self.Mdoel=nil;
_UIObject_release(self.dzSpeak);self.dzSpeak=nil;
_UIObject_release(self.txtDzSpeak);self.txtDzSpeak=nil;
end


















local modelId=2054


function UIMysteryTargetStartWin:onLoaded(...)
self:bindComponents()

end


function UIMysteryTargetStartWin:__delete()
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
self.delayTimer=nil
end

if MysteryModel.currentFBData.isFirst then
MysteryController.send_mystery_start()
end
MysteryModel.currentFBData.isFirst=false
self:unbindComponents()

end




function UIMysteryTargetStartWin:onShow(argtable,afterOnloaded)
local fbId=MysteryModel:get_cur_fbid()
local data=MysteryModel:getFBInfoData(fbId)
local targetListLen,targetData=MysteryModel:get_fb_target_progress()
if targetListLen<=0 then
if data then
targetListLen=data[7]
targetData=data[8]
end
end
self:refreshTargetList(targetListLen,targetData)

self.delayTimer=self:setTimer(0.2,1,function()

if self and not self.isClose then
self.bgModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.common_window_enter,false,false,0,nil)

end
end)

local isOpenAuto,reason=MysteryGuildOrder.isOrderSetupOpen(fbId)
self.autoReason=reason
if isOpenAuto then
self:delayDo(3,function()
self:onMaskClick()
end)
end

end


function UIMysteryTargetStartWin:onHide()

end

function UIMysteryTargetStartWin:refreshTargetList(targetListLen,targetData)
if not targetListLen then
targetListLen,targetData=MysteryModel:get_fb_target_progress()
end
self.fbId=MysteryModel:get_cur_fbid()
if not self.fbId then
return
end
self.targetConfig=cfgHelper.get2(cfg_secretscenefubenconfig_get,self.fbId,"target")
if targetListLen>0 then
local targetDesc=cfgHelper.get2(cfg_secretscenefubenconfig_get,self.fbId,"targetDesc")
local targetList={}
for i,v in ipairs(targetDesc)do
if not v.isHide then
table.insert(targetList,{desc=v,oriIndex=i})
end
end
self.ListPanel:setChildLayoutGroupCreateItems(#targetList)
local grids=self.ListPanel:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local t=targetList[i]
local index=t.oriIndex
local descCfg=t.desc
local target=targetData[index]
local item=grids[i-1]


if descCfg then
local desc=descCfg[1]
item:SetChildText(1,desc)
local iconIndex=descCfg[2]or 1
local targetConfig=cfg_secretscenefubenaimconfig_get(target.targetId)
item:SetChildCSImageIcon(0,targetConfig.icon[iconIndex],true)
if not(target.param_1==0 and target.param_2==0 and target.param_3==0 and target.param_4==0)then
item:SetChildProgress(2,target.param_1,target.param_2)
if target.param_1==target.param_2 then
item:SetChildText(3,"完成")
else
item:SetChildText(3,FMT.fmt("{0}/{1}",target.param_1,target.param_2))
end
else
item:SetChildProgress(2,target.finishStatus,1)
if target.finishStatus==1 then
item:SetChildText(3,"完成")
else
item:SetChildText(3,FMT.fmt("{0}/1",target.finishStatus))
end
end
end

end
end
end

function UIMysteryTargetStartWin:showModel()
local team=MysteryModel:get_fb_probeTeam()or{}
local captain=team[1]
if captain then
local guid=captain.unitId
local unitType=captain.unitType
if unitType==eTeamEntityType.dizi then
comHelper.setChildHead2(self.Mdoel,guid,1,nil,nil,false)
elseif unitType==eTeamEntityType.npc then
guid=tonumber(tostring(captain.unitId))
local modelId=fightPreSelectModel.getNPCOutSideModel(guid)
self.Model:setChildUIModelShowTarget(modelId,1,{},eAnimationID.stand)
end
self.Mdoel:setChildUIModelShowFlipX(true)

local speak=cfgHelper.get2(cfg_secretscenebaseconfig_get,1,"targetSpeak")
if speak then
self.txtDzSpeak:setText(speak[math.random(1,#speak)]or"")
end
end
end

function UIMysteryTargetStartWin:onMaskClick()
if MysteryController.isInitingEntity then
return
end
if self.closeDelay then
return
end
self.targetRoot:setChildCanvasGroupAlpha(1)
self.targetRoot:setChildCanvasGroupDOFade(0,0.2)
self.bgModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.idle1,false,false,0,function()
if self and not self.isClose then
self.closeDelay=self:setTimer(0.4,1,function()
if self and not self.isClose then
self.maskClick:setButtonEnable(false)
self:closeSelf()
end
end)
end
end)


end



