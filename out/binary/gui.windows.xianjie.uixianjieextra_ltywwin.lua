







def_class("UIXianJieExtra_LTYWWin",UIWindowBase)









function UIXianJieExtra_LTYWWin:bindComponents()

self.clickMask=UIObject.get(self,0)
self.normalPanel=UIObject.get(self,1)
self.uiroot=UIObject.get(self,2)
self.helpBtn=UIButton.get(self,3)
self.timeText=UIText.get(self,4)
self.zhanKuangBtn=UIButton.get(self,5)
self.rankBtn=UIButton.get(self,6)
self.zhanLingBtn=UIButton.get(self,7)
self.effect=UIObject.get(self,8)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.zhanKuangBtn:setButtonClick(function()self:onZhanKuangBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.zhanLingBtn:setButtonClick(function()self:onZhanLingBtn()end)



end


function UIXianJieExtra_LTYWWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.normalPanel);self.normalPanel=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.zhanKuangBtn);self.zhanKuangBtn=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.zhanLingBtn);self.zhanLingBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
end



















function UIXianJieExtra_LTYWWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieExtra_LTYWWin:__delete()
self:clearTimer()
self:unbindComponents()
end




function UIXianJieExtra_LTYWWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIXianJieExtra_LTYWWin:onHide()
self:clearTimer()
end

function UIXianJieExtra_LTYWWin:refresh()

self:setRemainingTimeTimer()
end


function UIXianJieExtra_LTYWWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local actId=LIMIT_ACT_TYPE.eLeiTaiYanWu
local lerp=limitActivitiesModel:getActEndLeftTime(actId)or 0
if lerp>0 then

self.timeText:setText(timeHelper.format_time_stamp16(lerp))
else
self.timeText:setText("已结束")
UIManager.error("活动已结束")
self:clearTimer()
self:onEndAct()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UIXianJieExtra_LTYWWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end



function UIXianJieExtra_LTYWWin:onEndAct()

local effectId=22624
self.effect:setChildShowEffect(effectId,true)


UIManager:invokeUIMethod("UIXianJieMainWin","checkActMode")


xianJieArenaActController:reqGetXJArenaActData()



self.normalPanel:setActive(false)
self.clickMask:setActive(true)

self:delayDo(2,function()

self:closeSelf()
end)
end




function UIXianJieExtra_LTYWWin:onZhanKuangBtn(page,extraArgs)

self:showWindow("UIXianJieArenaAct_ovBgWin",{page=page,extraArgs=extraArgs})
end



function UIXianJieExtra_LTYWWin:onRankBtn()
local page=1

msgWinControl:addMsgWin(msgWinType.eLTYWRankBg,{page=page})
end



function UIXianJieExtra_LTYWWin:onZhanLingBtn()
return UIManager.error("敬请期待")
end

function UIXianJieExtra_LTYWWin:onHelpBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eLeiTaiYanWu,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end

