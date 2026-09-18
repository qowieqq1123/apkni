









local xjEntityHud_JieYin={}
local abname="ui/windows/xianjie/xianjietask_atlas_pak.ab"

function xjEntityHud_JieYin:onInit()
self.needFollow=true

end


function xjEntityHud_JieYin:onCreateWidget(widget)
self:refreshInfo()
end


function xjEntityHud_JieYin:onRemoveWidget(widget)
if self.dt then
self.dt:Complete()
self.dt:Kill()
self.dt=nil
end
end


function xjEntityHud_JieYin:refreshInfo()
local widget=self:getWidget()

widget:SetChildAnchoredPos(0,0,100)

widget:SetChildButtonClick(3,function()
self:onClick()
end)

local isCanReceive=jiuchongtianjieGuideController:checkIsCanReceiveSupportRewad()
local hasSupportActor=jiuchongtianjieGuideController:checkHasCanSupportActor()
local iconName="button_guangxizhuanghuan"

if hasSupportActor then
iconName="icon_zhaomucs"
end

if isCanReceive then
iconName="icon_fangshigx"
end

widget:SetChildCSImageSprite(2,globalABLookup.hud_atlas,iconName)

if self.dt then
self.dt:Complete()
self.dt:Kill()
self.dt=nil
end

widget:SetChildRotation(0,0,0,0)
self.dt=widget:SetChildDOPunchRotation(0,Vector3(0,0,15),2,2,1)
self.dt:SetEase(_Ease.Linear)
self.dt:SetLoops(-1,_LoopType.Restart)
end

function xjEntityHud_JieYin:onClick()
UIManager:showWindow("UIXianJieJieYin_SupportWin")
end


function xjEntityHud_JieYin:onDelete()

end

return xjEntityHud_JieYin