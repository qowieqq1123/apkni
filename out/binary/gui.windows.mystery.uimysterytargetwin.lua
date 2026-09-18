







def_class("UIMysteryTargetWin",UIWindowBase)









function UIMysteryTargetWin:bindComponents()

self.targetRoot=UIButton.get(self,0)
self.topButton=UIButton.get(self,1)
self.showButton=UIButton.get(self,2)
self.hideButton=UIButton.get(self,3)
self.ListPanel=UIObject.get(self,4)

self.targetRoot:setButtonClick(function()self:onTargetRoot()end)

self.topButton:setButtonClick(function()self:onTopButton()end)

self.showButton:setButtonClick(function()self:onShowButton()end)

self.hideButton:setButtonClick(function()self:onHideButton()end)



end


function UIMysteryTargetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.targetRoot);self.targetRoot=nil;
_UIObject_release(self.topButton);self.topButton=nil;
_UIObject_release(self.showButton);self.showButton=nil;
_UIObject_release(self.hideButton);self.hideButton=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
end



















function UIMysteryTargetWin:onLoaded(...)
self:bindComponents()
local fbId=MysteryModel:get_cur_fbid()
MysteryController.send_4_21(fbId)

self.ListPanel:setChildScrollViewInit(0.5,true,function(...)self:onScrollItemClick(...)end)
end


function UIMysteryTargetWin:__delete()
self:unbindComponents()
end




function UIMysteryTargetWin:onShow(argtable,afterOnloaded)
self:refreshTargetList()
self.TargetHide=false
self:onShowButton()
end


function UIMysteryTargetWin:onHide()

end

function UIMysteryTargetWin:openStartPanel()
UIManager:showWindow("UIMysteryTargetStartWin")
end





function UIMysteryTargetWin:onHideButton()
self:onButtonArrow()
end

function UIMysteryTargetWin:onShowButton()
self:onButtonArrow()
end

function UIMysteryTargetWin:onTopButton()
self:onButtonArrow()
end

function UIMysteryTargetWin:onButtonArrow()
if self.ListPanel:getTransform()then
self.ListPanel:setChildDOAnchorPosY(self.TargetHide and 260 or 100,0.25,nil)

self.showButton:setActive(not self.TargetHide)
self.TargetHide=not self.TargetHide
end
end

function UIMysteryTargetWin:refreshTargetList(targetListLen,targetData)
if not targetListLen then
targetListLen,targetData=MysteryModel:get_fb_target_progress()
end
self.fbId=MysteryModel:get_cur_fbid()
if not self.fbId then
return
end

local progress=MysteryModel:get_fb_progress()or 0

self.targetConfig=cfgHelper.get2(cfg_secretscenefubenconfig_get,self.fbId,"target")
if targetListLen>0 then
local targetDesc=cfgHelper.get2(cfg_secretscenefubenconfig_get,self.fbId,"targetDesc")
local targetList={}
for i,v in ipairs(targetDesc)do
if not v.isHide then
table.insert(targetList,{desc=v,oriIndex=i})
end
end

self.ListPanel:setChildScrollViewCreateGrids(#targetList,1)
local grids=self.ListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local t=targetList[i]
local index=t.oriIndex
local descCfg=t.desc
local target=targetData[index]
local item=grids[i-1]

if target then
if not(target.param_1==0 and target.param_2==0 and target.param_3==0 and target.param_4==0)then
if progress>=100 then
item:SetChildProgress(0,target.param_2,target.param_2)
item:SetChildText(2,"完成")
else
item:SetChildProgress(0,target.param_1,target.param_2)
if target.param_1==target.param_2 then
item:SetChildText(2,"完成")
else
item:SetChildText(2,FMT.fmt("{0}/{1}",target.param_1,target.param_2))
end
end

else
if progress>=100 then
item:SetChildProgress(0,1,1)
item:SetChildText(2,"完成")
else
item:SetChildProgress(0,target.finishStatus,1)
if target.finishStatus==1 then
item:SetChildText(2,"完成")
else
item:SetChildText(2,FMT.fmt("{0}/1",target.finishStatus))
end
end
end
end

if descCfg then
local desc=descCfg[1]
item:SetChildText(3,desc)

local iconIndex=descCfg[2]or 1
if target then
local targetConfig=cfg_secretscenefubenaimconfig_get(target.targetId)
item:SetChildCSImageIcon(1,targetConfig.icon[iconIndex],true)
end
end

item:SetChildNewBieComponentId(-1,FMT.fmt('UIMysteryTargetWin.UIMysteryTarget_{0}',i))
end
end
end

function UIMysteryTargetWin:onScrollItemClick(id,index)
if not self.targetConfig then
return
end
local target=self.targetConfig[index+1]
if target then
local id=target[1]
if id==4 then
if mysteryCameraController:getCameraTween()then
return
end
local mosterId=target[2]
local monster=mysteryMonsterModel:get_entity_by_id(mosterId)
if monster then
if monster.isVisible or(not worldController:checkNoticiateBlockOpen())then
mysteryTriggerManager.triggerMoveCamera(monster.roomId,monster.pos,nil,12,0.7)

end
else

self:openStartPanel()
end
elseif id==7 then
if mysteryCameraController:getCameraTween()then
return
end
local monster=mysteryMonsterModel:get_entity_random()
if monster then
mysteryTriggerManager.triggerMoveCamera(monster.roomId,monster.pos,nil,12,0.7)

else

self:openStartPanel()
end
else

self:openStartPanel()
end
end
end

function UIMysteryTargetWin:onTargetRoot()


end