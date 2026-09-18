







def_class("UISubAct_SHXB_wildDieSelectWin",UIWindowBase)









function UISubAct_SHXB_wildDieSelectWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.wildDieSelectGroup=UIObject.get(self,2)
self.arrow=UIObject.get(self,3)

self.clickMask:setButtonClick(function()self:onClickMask()end)



end


function UISubAct_SHXB_wildDieSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.wildDieSelectGroup);self.wildDieSelectGroup=nil;
_UIObject_release(self.arrow);self.arrow=nil;
end



















function UISubAct_SHXB_wildDieSelectWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_SHXB_wildDieSelectWin:__delete()
self:unbindComponents()
end




function UISubAct_SHXB_wildDieSelectWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.pos=argtable and argtable.pos or{0,0}
self.offset=argtable and argtable.offset or{0,0}


self.myData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.sub_actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

self:refresh()
end


function UISubAct_SHXB_wildDieSelectWin:onHide()

end

function UISubAct_SHXB_wildDieSelectWin:refresh()

local rootPosX=self.pos[1]+self.offset[1]
local rootPosY=self.pos[2]+self.offset[2]
self.root:setChildAnchoredPos(rootPosX,rootPosY)
local arrowPosX=-self.offset[1]
local arrowPosY=-6
self.arrow:setChildAnchoredPos(arrowPosX,arrowPosY)



local grids=self.wildDieSelectGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
widget:SetChildButtonClick(-1,function()
return self:onWildDieSelectBtnClick(i)
end,true)
end
end





function UISubAct_SHXB_wildDieSelectWin:onClickMask()
self:closeSelf()
end

function UISubAct_SHXB_wildDieSelectWin:onWildDieSelectBtnClick(idx)
if self.parentWin and self.parentWin.isMoving then
return
end

self.sub_actInfo:reqRollDiceByNum(idx)
return self:onClickMask()
end

