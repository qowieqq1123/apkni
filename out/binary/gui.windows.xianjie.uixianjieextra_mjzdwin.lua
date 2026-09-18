







def_class("UIXianJieExtra_MJZDWin",UIWindowBase)









function UIXianJieExtra_MJZDWin:bindComponents()

self.clickMask=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.hideButton=UIButton.get(self,3)
self.normalPanel=UIObject.get(self,4)
self.rankBtn=UIButton.get(self,5)
self.returnBtn=UIButton.get(self,6)
self.settingBtn=UIButton.get(self,7)
self.stateImg=UIImage.get(self,8)
self.timeText=UIText.get(self,9)
self.uiroot=UIObject.get(self,10)
self.zhanKuangBtn=UIButton.get(self,11)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.hideButton:setButtonClick(function()self:onHideButton()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.returnBtn:setButtonClick(function()self:onReturnBtn()end)

self.settingBtn:setButtonClick(function()self:onSettingBtn()end)

self.zhanKuangBtn:setButtonClick(function()self:onZhanKuangBtn()end)



end


function UIXianJieExtra_MJZDWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.hideButton);self.hideButton=nil;
_UIObject_release(self.normalPanel);self.normalPanel=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.returnBtn);self.returnBtn=nil;
_UIObject_release(self.settingBtn);self.settingBtn=nil;
_UIObject_release(self.stateImg);self.stateImg=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.zhanKuangBtn);self.zhanKuangBtn=nil;
end
















local _stateImgList={'image_mogongzengduo_02','image_mogongzengduo_02A'}




function UIXianJieExtra_MJZDWin:onLoaded(...)
self:bindComponents()

end


function UIXianJieExtra_MJZDWin:__delete()
self:unbindComponents()
self:clearTimer()
end




function UIXianJieExtra_MJZDWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIXianJieExtra_MJZDWin:onHide()
self:clearTimer()
end
function UIXianJieExtra_MJZDWin:refresh()
self.actState=moGongZhengDuoActModel:getActLeftState()or 2

self.stateImg:setCSImageSprite(globalABLookup.mogongzhengduo,_stateImgList[self.actState])

if self.actState==1 then
self:setReadyTimer()
else

self:setRemainingTimeTimer()
end
end

function UIXianJieExtra_MJZDWin:setReadyTimer()
self:clearTimer()

local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMoGongZhengDuo)
local nowTime=timeHelper.getServerShortTime()
local readyTime=moGongZhengDuoActModel:getBaseConfig('readyTime')
local endTime=actInfo.start_time+readyTime
local left=endTime-nowTime

local func=function()
nowTime=timeHelper.getServerShortTime()
left=endTime-nowTime
if left>=0 then
self.timeText:setText(timeHelper.format_time_stamp4(left))
else
UIManager.info("争夺开始")
notifySystem:postNotify(notifyConfig.onMoGongZhengDuoReadyEnd)
self:refresh()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UIXianJieExtra_MJZDWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local actId=LIMIT_ACT_TYPE.eMoGongZhengDuo
local lerp=limitActivitiesModel:getActEndLeftTime(actId)or 0
if lerp>0 then

self.timeText:setText(timeHelper.format_time_stamp4(lerp))
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


function UIXianJieExtra_MJZDWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end



function UIXianJieExtra_MJZDWin:onEndAct()





moGongZhengDuoActController:reqMoGongActData()

self.normalPanel:setActive(false)
self.clickMask:setActive(true)

self:delayDo(2,function()

UIManager:invokeUIMethod("UIXianJieMainWin","refreshLeftMenuExPanel")

self:closeSelf()
end)
end




function UIXianJieExtra_MJZDWin:onHelpBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eMoGongZhengDuo,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end



function UIXianJieExtra_MJZDWin:onHideButton()
self.isHideMode=not self.isHideMode
if self.isHideMode then

else

end
end



function UIXianJieExtra_MJZDWin:onRankBtn()
local page=1

xianjieController:openMGZDRanktInfoWin({page=page})
end



function UIXianJieExtra_MJZDWin:onZhanKuangBtn(page,extraArgs)
xianjieController:openMGZDFightInfoWin({showIndex=1,pageList={2}})
end



function UIXianJieExtra_MJZDWin:onZhanLingBtn()

end

function UIXianJieExtra_MJZDWin:onSettingBtn()
self:showWindow("UIMoGongZhengDuoAct_SettingWin")
end

function UIXianJieExtra_MJZDWin:onReturnBtn()
local saijiid=xianjieController:getMoJieSaiJiID()
if saijiid==nil then
mainControl:enterHome()
else
local mojieCfg=cfgHelper.get1(cfg_devildomseasonconfig_get,saijiid)
local sceneIdx=mojieCfg.sceneidx
local sceneType=xianjieModel:sceneIndex2SceneType(sceneIdx)
xianjieController:jumpXianJie(sceneType)
end
end
