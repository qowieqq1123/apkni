







def_class("UIXianJieSeasonEnter_MJMB_Preview",UICloneObject)





UIXianJieSeasonEnter_MJMB_Preview.abName="ui/windows/xianjie/child/uixianjieseasonenter_mjmb_preview.ab"

UIXianJieSeasonEnter_MJMB_Preview.assetName="UIXianJieSeasonEnter_MJMB_Preview"


function UIXianJieSeasonEnter_MJMB_Preview:bindComponents()

self.artFont=UIObject.get(self,0)
self.cd=UIText.get(self,1)
self.reddot=UIObject.get(self,2)
self.spineBg=UIObject.get(self,3)

end


function UIXianJieSeasonEnter_MJMB_Preview:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.artFont);self.artFont=nil;
_UIObject_release(self.cd);self.cd=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.spineBg);self.spineBg=nil;
end









function UIXianJieSeasonEnter_MJMB_Preview:onLoaded(...)
self:bindComponents()

self.widget:SetChildButtonClick(-1,function()
self:onClick()
end)

local _onNewDay=function()
self:onNewDay()
end
self:addNotify(notifyConfig.onNewDay,_onNewDay)
local _onReddot=function()
self:refreshReddot()
end
self:addReddotNotify(REDDIT_TYPE.eMJYGExtend,_onReddot)
end


function UIXianJieSeasonEnter_MJMB_Preview:__delete()
self:stopWeakGuideDelayTimer()
self:stopCD()

self:unbindComponents()
end




function UIXianJieSeasonEnter_MJMB_Preview:onShow(argtable,afterOnloaded)
self.enterData=xianjieModel:getMoJieEnterData()

self.cfg=cfgHelper.get1(cfg_devildomseasonconfig_get,self.enterData.sId)
self.baseCfg=cfg_mojieyugaoextbaseconfig_get(self.enterData.sId)

local preEnterInfo=self.cfg.preEnterInfo

preEnterInfo=preEnterInfo[2]

local bgSpineId=preEnterInfo[1]
if self.baseCfg.custonPanelConfig and self.baseCfg.custonPanelConfig.previewSpine then
bgSpineId=self.baseCfg.custonPanelConfig.previewSpine[2][1]
end

self.spineBg:setChildUIModelShowTarget(bgSpineId,1,{},eAnimationID.stand)
self.artFont:setActive(false)

self.widget:SetChildNewBieComponentId(-1,'seasonPreView.mjmb')
self.widget:SetChildWeakGuideComponentId(-1,'seasonPreView.mjmb')

self.enterData=xianjieModel:getMoJieEnterData()

self:refreshCD()
self:refreshReddot()
end


function UIXianJieSeasonEnter_MJMB_Preview:onHide()

end

function UIXianJieSeasonEnter_MJMB_Preview:refreshCD()
local curtime=timeHelper.getServerShortTime()
if self.enterData then
if curtime>=self.enterData.sTime then
self.cd:setText("魔界已开启")
self:startWeakGuideDelayTimer()
else
self:startCD()
end
else
self.cd:setActive(false)
end
end

function UIXianJieSeasonEnter_MJMB_Preview:startCD()
local beginTime=self.enterData.sTime
local curTime=timeHelper.getServerShortTime()

local func=function()
curTime=timeHelper.getServerShortTime()
local left=beginTime-curTime
if left<=0 then
self:stopCD()
self:refreshCD()
return
end
self.cd:setText(FMT.fmt("魔界将在{0}后开启",timeHelper.format_time_stamp12(left)))
end

self.cdTimer=self:setTimer(1,0,func)
func()
end

function UIXianJieSeasonEnter_MJMB_Preview:stopCD()
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end

function UIXianJieSeasonEnter_MJMB_Preview:onClick()
UIManager:showWindow("UIMoJieCDOpenWin")
end

function UIXianJieSeasonEnter_MJMB_Preview:refreshReddot()
local reddot=reddotClassManager.get_reddot(REDDIT_TYPE.eMJYGExtend)
self.reddot:setActive(reddot)
end


function UIXianJieSeasonEnter_MJMB_Preview:onNewDay()
self:refreshCD()
end


function UIXianJieSeasonEnter_MJMB_Preview:startWeakGuideDelayTimer()
self:stopWeakGuideDelayTimer()

self.delayStartWeakGuideTimer=self:delayDo(3,function()
if seasonModel:isCanShowPreviewGuide(self.seasonType)then
weakGuideController:beginGuide(4161)
end
end)
end

function UIXianJieSeasonEnter_MJMB_Preview:stopWeakGuideDelayTimer()
if self.delayStartWeakGuideTimer then
self:stopTimerByID(self.delayStartWeakGuideTimer)
self.delayStartWeakGuideTimer=nil
end
end


