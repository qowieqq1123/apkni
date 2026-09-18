







def_class("UIFangYingTingTongGuanWin",UIWindowBase)









function UIFangYingTingTongGuanWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.juqingText=UIText.get(self,2)
self.juqingText1=UIText.get(self,3)
self.juqingText2=UIText.get(self,4)
self.quitBtn=UIButton.get(self,5)
self.root=UIObject.get(self,6)
self.titleBg=UIImage.get(self,7)
self.UIFangYingTingTongGuanWin=UIWindowLua.new(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.quitBtn:setButtonClick(function()self:onQuitBtn()end)



end


function UIFangYingTingTongGuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.juqingText);self.juqingText=nil;
_UIObject_release(self.juqingText1);self.juqingText1=nil;
_UIObject_release(self.juqingText2);self.juqingText2=nil;
_UIObject_release(self.quitBtn);self.quitBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
self.UIFangYingTingTongGuanWin:deleteSelf();self.UIFangYingTingTongGuanWin=nil;
end
















local this

local desc=
{
[eFangYingTingPlotState.Easy]=
{
titleText="已成功通关剧情模式",
Desc="【挑战模式】开启\n<size=22>挑战模式可获得额外奖励但不会影响放映进度</size>"
},
[eFangYingTingPlotState.Difficult]=
{
titleText="已成功通关挑战模式",
Desc="【挑战模式】结束"
},
}




function UIFangYingTingTongGuanWin:onLoaded(...)
self:bindComponents()
this=self
end


function UIFangYingTingTongGuanWin:__delete()
self:unbindComponents()
end




function UIFangYingTingTongGuanWin:onShow(argtable,afterOnloaded)
if argtable.sub_actcfg then
self.sub_actcfg=argtable.sub_actcfg
self.custom=(self.sub_actcfg and self.sub_actcfg.custonPanelConfig)or{}
self.custom2=(self.sub_actcfg and self.sub_actcfg.custonSpineConfig)or{}

local img8=self.custom.image8
if img8 and img8[1]and img8[2]then
self.titleBg:setSprite(img8[1],img8[2],false)
end
end

self.PlotState=argtable.PlotState
self:showBgModel()
self.juqingText:setText(desc[self.PlotState].titleText)
self.juqingText1:setText(desc[self.PlotState].Desc)
end


function UIFangYingTingTongGuanWin:onHide()

end



function UIFangYingTingTongGuanWin:showBgModel()
self.root:setChildCanvasGroupAlpha(0)
local bgModelId=6213
local spine4=self.custom2[4]
if spine4 then
bgModelId=spine4
end

if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),true,true,true)
end

self.bgModel:setChildUIModelShowTarget(bgModelId,1,nil,eAnimationID.enter,false,false,0,function()
end)
self:delayDo(0.25,function()
self.root:setChildCanvasGroupDOFade(1,0.5)
end)

end




function UIFangYingTingTongGuanWin:onQuitBtn()
self:closeInterFace()
end


function UIFangYingTingTongGuanWin:onCloseBtn()
self:closeInterFace()
end

function UIFangYingTingTongGuanWin:closeInterFace()
if UIManager:isActive("UIFightPrepareLoading")then
if this.PlotState==eFangYingTingPlotState.Difficult then
UIManager:closeWindow("UIDaHuaXiYouWin_CopyMainWin")
else
UIManager:invokeUIMethod("UIDaHuaXiYouWin_CopyMainWin","switchState")
end
this:closeSelf()
else
UIManager:showWindow("UIFightPrepareLoading",{
startCallback=function()
if this.PlotState==eFangYingTingPlotState.Difficult then
UIManager:closeWindow("UIDaHuaXiYouWin_CopyMainWin")
else
UIManager:invokeUIMethod("UIDaHuaXiYouWin_CopyMainWin","switchState")
end
this:closeSelf()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
})
end
end