







def_class("UIMoJieRewardClaimConditionTipsWin",UIWindowBase)









function UIMoJieRewardClaimConditionTipsWin:bindComponents()

self.personalClaimConditions=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.serverWideClaimConditions=UIObject.get(self,2)
self.uiRoot=UIObject.get(self,3)



end


function UIMoJieRewardClaimConditionTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.personalClaimConditions);self.personalClaimConditions=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.serverWideClaimConditions);self.serverWideClaimConditions=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end



















function UIMoJieRewardClaimConditionTipsWin:onLoaded(...)
self:bindComponents()
end


function UIMoJieRewardClaimConditionTipsWin:__delete()
self:unbindComponents()
end




function UIMoJieRewardClaimConditionTipsWin:onShow(argtable,afterOnloaded)
self.tipsTextContent=argtable.tipsTextContent
self.serverWideTargetScore=argtable.serverWideTargetScore
self.serverWideCurrentScore=argtable.serverWideCurrentScore
self.personalTargetScore=argtable.personalTargetScore
self.personalCurrentScore=argtable.personalCurrentScore

self:initializeTipsDisplay()
end


function UIMoJieRewardClaimConditionTipsWin:onHide()

end




function UIMoJieRewardClaimConditionTipsWin:initializeTipsDisplay()
local idIndex=-1
local getWidgetId=function()
idIndex=idIndex+1
return idIndex
end
local widgetID={
condTex=getWidgetId(),
finished=getWidgetId(),
unfinished=getWidgetId()
}

local serverWideCondWbEnable=self.serverWideTargetScore~=-1

local serverWideCondWb=self.serverWideClaimConditions:getChildWidgetBase()
serverWideCondWb:SetChildActive(-1,serverWideCondWbEnable)
if serverWideCondWbEnable then
local isFinished=self.serverWideCurrentScore>=self.serverWideTargetScore
local tipsColor=isFinished and FONT_COLOR_VAL[FONT_COLOR.eGreenColor]or FONT_COLOR_VAL[FONT_COLOR.eRedColor]

serverWideCondWb:SetChildActive(widgetID.finished,isFinished)
serverWideCondWb:SetChildActive(widgetID.unfinished,not isFinished)
local content=FMT.fmt("全服{0} (<color={1}>{2}/{3}</color>)",self.tipsTextContent.serverWideCond,
tipsColor,
self.serverWideCurrentScore,
self.serverWideTargetScore)
serverWideCondWb:SetChildText(widgetID.condTex,content)
end

local personalCondWbEnable=self.personalTargetScore~=-1

local personalCondWb=self.personalClaimConditions:getChildWidgetBase()
personalCondWb:SetChildActive(-1,personalCondWbEnable)
if personalCondWbEnable then
local isFinished=self.personalCurrentScore>=self.personalTargetScore
local tipsColor=isFinished and FONT_COLOR_VAL[FONT_COLOR.eGreenColor]or FONT_COLOR_VAL[FONT_COLOR.eRedColor]

personalCondWb:SetChildActive(widgetID.finished,isFinished)
personalCondWb:SetChildActive(widgetID.unfinished,not isFinished)
local content=FMT.fmt("个人{0} (<color={1}>{2}/{3}</color>)",self.tipsTextContent.personalCond,
tipsColor,
self.personalCurrentScore,
self.personalTargetScore)
personalCondWb:SetChildText(widgetID.condTex,content)
end

end


