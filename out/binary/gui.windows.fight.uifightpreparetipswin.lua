







def_class("UIFightPrepareTipsWin",UIWindowBase)









function UIFightPrepareTipsWin:bindComponents()

self.oneObj=UIObject.get(self,0)
self.twoObj=UIObject.get(self,1)
self.threeObj=UIObject.get(self,2)
self.tipstxt=UIText.get(self,3)
self.instructionBtn=UIButton.get(self,4)

self.instructionBtn:setButtonClick(function()self:onInstructionBtn()end)



end


function UIFightPrepareTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.oneObj);self.oneObj=nil;
_UIObject_release(self.twoObj);self.twoObj=nil;
_UIObject_release(self.threeObj);self.threeObj=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.instructionBtn);self.instructionBtn=nil;
end



















local left={{1113102,{1113102,300302}},{1131201,{1131201,300401}}}
local right={1,7,7}
local life=2


function UIFightPrepareTipsWin:onLoaded(...)
self:bindComponents()
end


function UIFightPrepareTipsWin:__delete()
self:unbindComponents()
end




function UIFightPrepareTipsWin:onShow(argtable,afterOnloaded)
self:initView()
self:delayBegin1(true)
self:delayBegin2(true)
self:delayBegin3(true)
end


function UIFightPrepareTipsWin:onHide()

end

function UIFightPrepareTipsWin:initView()


self.tipstxt:setText(cfgHelper.getlang('build_road_tips_5'))
local weaponId
local slotName='wuqi'
local oneWidget=self.oneObj:getChildWidgetBase()
oneWidget:SetChildText(0,cfgHelper.getlang('fight_tips_1'))
oneWidget:SetChildText(1,cfgHelper.getlang('fight_tips_2'))
oneWidget:SetChildUIModelShowTarget(2,left[1][1],0.7,left[1][2],eAnimationID.stand)
oneWidget:SetChildUIModelShowFlipX(2,true)
weaponId=left[1].weaponId
if weaponId and slotName then
oneWidget:SetChildLoadSlot(2,slotName,weaponId)
end
oneWidget:SetChildUIModelShowTarget(3,left[2][1],0.7,left[2][2],eAnimationID.stand)
oneWidget:SetChildUIModelShowFlipX(3,true)

local model=self.getMonsterModelParams(right[1])
oneWidget:SetChildUIModelShowTarget(4,model.body,0.25,model.componets,eAnimationID.stand)
model=self.getMonsterModelParams(right[2])
oneWidget:SetChildUIModelShowTarget(5,model.body,0.25,model.componets,eAnimationID.stand)

local twoWidget=self.twoObj:getChildWidgetBase()
twoWidget:SetChildText(0,cfgHelper.getlang('fight_tips_3'))
twoWidget:SetChildText(1,cfgHelper.getlang('fight_tips_4'))
twoWidget:SetChildUIModelShowTarget(2,left[1][1],0.7,left[1][2],eAnimationID.stand)
twoWidget:SetChildUIModelShowFlipX(2,true)

model=self.getMonsterModelParams(right[1])
twoWidget:SetChildUIModelShowTarget(3,model.body,0.25,model.componets,eAnimationID.stand)
model=self.getMonsterModelParams(right[2])
twoWidget:SetChildUIModelShowTarget(4,model.body,0.25,model.componets,eAnimationID.stand)
model=self.getMonsterModelParams(right[3])
twoWidget:SetChildUIModelShowTarget(5,model.body,0.25,model.componets,eAnimationID.stand)

local threeWidget=self.threeObj:getChildWidgetBase()
threeWidget:SetChildText(0,cfgHelper.getlang('fight_tips_5'))
threeWidget:SetChildText(1,cfgHelper.getlang('fight_tips_6'))
threeWidget:SetChildUIModelShowTarget(2,left[1][1],0.7,left[1][2],eAnimationID.stand)
threeWidget:SetChildUIModelShowFlipX(2,true)
weaponId=left[1].weaponId
if weaponId and slotName then
threeWidget:SetChildLoadSlot(2,slotName,weaponId)
end
model=self.getMonsterModelParams(right[1])
threeWidget:SetChildUIModelShowTarget(3,model.body,0.25,model.componets,eAnimationID.stand)
model=self.getMonsterModelParams(right[2])
threeWidget:SetChildUIModelShowTarget(4,model.body,0.25,model.componets,eAnimationID.stand)
end


function UIFightPrepareTipsWin:beginAnim1()
local oneWidget=self.oneObj:getChildWidgetBase()

oneWidget:SetChildLocalPos(2,-84,71,0)
oneWidget:SetChildModelAnimationState(2,eAnimationID.move)
oneWidget:SetChildDOLocalMove(2,Vector3(5,71,0),0.1,function()
if self.isClose then return end
oneWidget:SetChildModelAnimationState(2,eAnimationID.attack1)
self:setTimer(0.5,1,function()
if self.isClose then return end
oneWidget:SetChildModelAnimationState(4,eAnimationID.hit)
end)
local id=self:setTimer(1.2,1,function()
if self.isClose then return end
oneWidget:SetChildModelAnimationState(2,eAnimationID.move)
oneWidget:SetChildDOLocalMove(2,Vector3(-84,71,0),0.1,function()
if self.isClose then return end
oneWidget:SetChildModelAnimationState(2,eAnimationID.stand)

self:delayBegin1()
end)
end)
end)
end

function UIFightPrepareTipsWin:delayBegin1(init)
local func=function()
if self.isClose then return end
self:beginAnim1()
end
self:delayDo(init and 1 or life,func)
end

function UIFightPrepareTipsWin:beginAnim2()
local twoWidget=self.twoObj:getChildWidgetBase()

twoWidget:SetChildLocalPos(2,-113,0,0)
twoWidget:SetChildModelAnimationState(2,eAnimationID.move)
twoWidget:SetChildDOLocalMove(2,Vector3(-55,0,0),0.1,function()
if self.isClose then return end
twoWidget:SetChildModelAnimationState(2,eAnimationID.attack1)
self:setTimer(0.5,1,function()
if self.isClose then return end
twoWidget:SetChildModelAnimationState(3,eAnimationID.hit)
end)
local id=self:setTimer(1.2,1,function()
if self.isClose then return end
twoWidget:SetChildModelAnimationState(2,eAnimationID.move)
twoWidget:SetChildDOLocalMove(2,Vector3(-113,0,0),0.1,function()
if self.isClose then return end
twoWidget:SetChildModelAnimationState(2,eAnimationID.stand)

self:delayBegin2()
end)
end)
end)
end

function UIFightPrepareTipsWin:delayBegin2(init)
local func=function()
if self.isClose then return end
self:beginAnim2()
end
self:delayDo(init and 1 or life,func)
end

function UIFightPrepareTipsWin:beginAnim3()
local threeWidget=self.threeObj:getChildWidgetBase()

threeWidget:SetChildLocalPos(2,-95,0,0)
threeWidget:SetChildModelAnimationState(2,eAnimationID.move)
threeWidget:SetChildDOLocalMove(2,Vector3(27,67,0),0.1,function()
if self.isClose then return end
threeWidget:SetChildModelAnimationState(2,eAnimationID.attack1)
self:setTimer(0.5,1,function()
if self.isClose then return end
threeWidget:SetChildModelAnimationState(3,eAnimationID.hit)
end)
local id=self:setTimer(1.2,1,function()
if self.isClose then return end
threeWidget:SetChildModelAnimationState(2,eAnimationID.move)
threeWidget:SetChildDOLocalMove(2,Vector3(-95,0,0),0.1,function()
if self.isClose then return end
threeWidget:SetChildModelAnimationState(2,eAnimationID.stand)

self:delayBegin3()
end)
end)
end)
end

function UIFightPrepareTipsWin:delayBegin3(init)
local func=function()
if self.isClose then return end
self:beginAnim3()
end
self:delayDo(init and 1 or life,func)
end

function UIFightPrepareTipsWin.getMonsterModelParams(monsterId)
local cfg=cfgHelper.get1(cfg_monsterconfig_get,monsterId)
local result={}
result.body=cfg.modelid[1]
result.componets=cfg.modelid[2]
return result
end

function UIFightPrepareTipsWin:initModel()

end



function UIFightPrepareTipsWin:onInstructionBtn()
instructionbookController:jumpTo(INSTRUCTIONBOOK_JUMP_TYPE.eUIFightPrepareTipsWin)
end