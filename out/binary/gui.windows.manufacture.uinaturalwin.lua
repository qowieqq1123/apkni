







def_class("UINaturalWin",UIWindowBase)








function UINaturalWin:bindComponents()

self.btnReceive=UIButton.get(self,0)
self.btnUpgrade=UIButton.get(self,1)
self.fullTime=UIText.get(self,2)
self.icon=UIObject.get(self,3)
self.imgRatio=UIImage.get(self,4)
self.infoPanel=UIObject.get(self,5)
self.liandonBtn=UIButton.get(self,6)
self.progress=UIObject.get(self,7)
self.progressCount=UIText.get(self,8)
self.ratio=UIText.get(self,9)
self.txtCurLevel=UIText.get(self,10)
self.txtUpgradeBtn=UIText.get(self,11)

self.btnReceive:setButtonClick(function()self:onBtnReceive()end)

self.btnUpgrade:setButtonClick(function()self:onBtnUpgrade()end)

self.liandonBtn:setButtonClick(function()self:onLiandonBtn()end)



end


function UINaturalWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnReceive);self.btnReceive=nil;
_UIObject_release(self.btnUpgrade);self.btnUpgrade=nil;
_UIObject_release(self.fullTime);self.fullTime=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.imgRatio);self.imgRatio=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.liandonBtn);self.liandonBtn=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.progressCount);self.progressCount=nil;
_UIObject_release(self.ratio);self.ratio=nil;
_UIObject_release(self.txtCurLevel);self.txtCurLevel=nil;
_UIObject_release(self.txtUpgradeBtn);self.txtUpgradeBtn=nil;
end
















local _this
local _format=string.format




function UINaturalWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UINaturalWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
_this=nil
end




function UINaturalWin:onShow(argtable,afterOnloaded)

if argtable then
local guid=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)
end

self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)

UIManager:callWindowFunc('UIBottomMaskWin','setTitle',self.config.name)

self:refreshLevelPanel()
self:refreshNaturalPanel()
self:refreshLianDonBtn()
end


function UINaturalWin:OnEnable()

end


function UINaturalWin:OnDisable()

end




function UINaturalWin:onLevelUpBtn()
if not zongmenControl:checkLevelUp(self.nextLvCfg,true)then
return
end
zongmenControl:reqBuildingLevelUp(self.sfId,self.bdData.un_build_id,0,{})
end



function UINaturalWin:onSpeedUpBtn()
local args={
bdData=self.bdData,
callback=function(type1,count,itemId)
zongmenControl:reqSpeedup(type1,count,itemId,speedUpType.eUpgradeBuilding,self.sfId,self.bdData.un_build_id)
end
}
UIManager:showWindow('UISpeedUpWin',args)
end



function UINaturalWin:onBtnReceive()
zongmenControl:getNaturalRewards(self.sfId,self.bdData)
end



function UINaturalWin:onLiandonBtn()
UIManager:showWindow('UITipLianDonWin',{linkageId=self.config.linkageId})
end

function UINaturalWin:onClickClose()
self:closeSelf()
end

function UINaturalWin:onBtnUpgrade()
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end

function UINaturalWin.on_building_event(etype,sfId,bdId)
if etype==buildingEvent.receiveNatural then
_this:refreshNaturalPanel()
_this:flyIcon()
elseif etype==buildingEvent.levelUpStart
or etype==buildingEvent.speedUpComplete then
_this:refreshLevelPanel()
elseif etype==buildingEvent.levelUpComplete then
_this:refreshLevelPanel()
_this:refreshNaturalPanel()
end
end

function UINaturalWin:flyIcon()
local spos=self.progressCount:getChildPosition()
local rwType=self.curLvCfg.normal_produce.rewards[1][1]
UIManager:invokeUIMethod('UITopMoneyWin','flyMoneyIcon',spos,rwType)
end

function UINaturalWin:refreshNaturalPanel()
if self.curLvCfg.normal_produce then
local profitTime=self.curLvCfg.normal_produce[1]
local reward=self.curLvCfg.normal_produce.rewards[1]
local maxReward=self.curLvCfg.normal_produce.maxrewards[1]
local cfg=moneyModel.getMoneyConfig(reward[1])
self.imgRatio:setChildIcon(iconHelper.getIconName(cfg.id),true)
self.ratio:setText(_format('%s%s/%s',reward[2],cfg.name,timeHelper.format_time_stamp11(profitTime)))
local beginTime=self.bdData.ncreateopentime
if beginTime>0 then
local tick=function()
local curTime=gameUtilityModel.getServerShortTime()
local dtime=curTime-beginTime+self.bdData.ncreatetotaltimes
local dtimeS=math.floor(dtime/profitTime)*profitTime
local profit=reward[2]/profitTime
local crw=profit*dtime
local drw=maxReward[2]-crw
local dt=drw/profit
local isFull=dt<=0
if isFull then
self.fullTime:setText('已满')
self.progress:setChildIconFillAmount(1)
self.progressCount:setText(_format('%s/%s',maxReward[2],maxReward[2]))
self:stopNaturalTimer()
else
self.fullTime:setText(_format('%s后存满',timeHelper.format_time_stamp4(math.floor(dt))))
local crwS=profit*dtimeS
local p=crwS/maxReward[2]
self.progress:setChildIconFillAmount(p)
self.progressCount:setText(_format('%s/%s',math.floor(crwS),maxReward[2]))
end
end
tick()
self:stopNaturalTimer()
self.naturalTimer=self:setTimer(1,0,tick)
else
self.fullTime:setText('暂停中')
end
end
end

function UINaturalWin:refreshLevelPanel()
self.curLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level)
self.nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)

local modelId=self.config.model[self.curLvCfg.level]
local scales2Pram=isometricMapSystem:getModelScales2Pram(modelId,29)
local scale=scales2Pram and scales2Pram[1]or 1
local offset=scales2Pram and{scales2Pram[2],scales2Pram[3]}or{0,0}

self.icon:setChildUIModelShowTarget(modelId,scale,nil,eAnimationID.stand)
self.icon:setChildUIModelShowTargetOffset(offset[1],offset[2])

if self.nextLvCfg then
if self.bdData.flag==buildingStateType.eUpgrading then
self:refreshUpgradePanel()
else
self.txtUpgradeBtn:setText('建筑升级')
self.txtCurLevel:setText(_format('%s级%s',self.bdData.level,self.config.name))
end
else
self.txtUpgradeBtn:setText('建筑信息')
self.txtCurLevel:setText(_format('%s级%s',self.bdData.level,self.config.name))
end
end

function UINaturalWin:refreshUpgradePanel()
local beginTime=self.bdData.begintime
if beginTime>0 then
self.upgrade_need_time=self.nextLvCfg.uplevel_times
local delta_time=gameUtilityModel.getServerShortTime()-beginTime+self.bdData.reducetime
local ctime=self.upgrade_need_time-delta_time
if ctime>0 then
self:stopLevelUpTimer()
local endtime=os.time()+ctime
local tick=function()
local dtime=endtime-os.time()
if dtime>0 then
self.txtCurLevel:setText(timeHelper.format_time_stamp4(dtime))
else
self:showFinish()
end
end
tick()
self.txtUpgradeBtn:setText('加速升级')
self.levelUpTimer=self:setTimer(1,0,tick)
else
self:showFinish()
end
end
end

function UINaturalWin:showFinish()
self:stopLevelUpTimer()
self.txtUpgradeBtn:setText('完成升级')
self.txtCurLevel:setText('完成升级')
end

function UINaturalWin:stopLevelUpTimer()
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end

function UINaturalWin:stopNaturalTimer()
if self.naturalTimer then
self:stopTimerByID(self.naturalTimer)
self.naturalTimer=nil
end
end

function UINaturalWin:refreshLianDonBtn()

if liandonModel:isCloseliandonFlag()then
self.liandonBtn:setActive(false)
return
end
self.liandonBtn:setActive(self.config.linkageId~=nil)
end
