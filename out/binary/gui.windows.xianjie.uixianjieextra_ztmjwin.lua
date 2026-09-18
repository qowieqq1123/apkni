







def_class("UIXianJieExtra_ZTMJWin",UIWindowBase)









function UIXianJieExtra_ZTMJWin:bindComponents()

self.clickMask=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.mbzkBtn=UIButton.get(self,3)
self.normalPanel=UIObject.get(self,4)
self.timeTx=UIText.get(self,5)
self.topBg=UIButton.get(self,6)
self.uiroot=UIObject.get(self,7)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.mbzkBtn:setButtonClick(function()self:onMbzkBtn()end)

self.topBg:setButtonClick(function()self:onTopBg()end)



end


function UIXianJieExtra_ZTMJWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.mbzkBtn);self.mbzkBtn=nil;
_UIObject_release(self.normalPanel);self.normalPanel=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.topBg);self.topBg=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
end



















function UIXianJieExtra_ZTMJWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieExtra_ZTMJWin:__delete()
self:unbindComponents()
end




function UIXianJieExtra_ZTMJWin:onShow(argtable,afterOnloaded)
self:startCDTick()
end


function UIXianJieExtra_ZTMJWin:onHide()

end




function UIXianJieExtra_ZTMJWin:onHelpBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eZhengTaoMoJiang,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end

function UIXianJieExtra_ZTMJWin:onTopBg()
self:onHelpBtn()
end


function UIXianJieExtra_ZTMJWin:onMbzkBtn()
UIManager:showWindow("UIZhengTaoMoJiangFightSituationWin")
end

function UIXianJieExtra_ZTMJWin:onEndAct()




self.normalPanel:setActive(false)
self.clickMask:setActive(true)



UIManager:invokeUIMethod("UIXianJieMainWin","refreshLeftMenuExPanel")

self:closeSelf()

end


function UIXianJieExtra_ZTMJWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end


function UIXianJieExtra_ZTMJWin:startCDTick()
self:stopCDTick()
local func=function()
local lerp=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eMoJiang)or 0
local temp=lerp>0
if temp then
self.timeTx:setText(timeHelper.format_time_stamp11(lerp,true))
else
self.timeTx:setText("已结束")
UIManager.error("活动已结束")
self:onEndAct()
self:stopCDTick()
end
end
func()
if self.cdTick==nil then
self.cdTick=self:setTimer(1,0,func)
end
end