







def_class("UIHeChengLianHuaWin",UIWindowBase)









function UIHeChengLianHuaWin:bindComponents()

self.root=UIObject.get(self,0)
self.lianhuaRunning=UIObject.get(self,1)
self.btnSelect=UIObject.get(self,2)
self.btnSwitch=UIObject.get(self,3)
self.selectPeiFangBtn=UIButton.get(self,4)
self.targetItem=UIBaseItem.get(self,5)
self.effect=UIObject.get(self,6)
self.progressBar=UIProgressBarAni.get(self,7)
self.progressText=UIText.get(self,8)
self.diziLock=UIText.get(self,9)
self.diziInfo=UIObject.get(self,10)
self.dzName=UIText.get(self,11)
self.skill=UIText.get(self,12)
self.scrollView2=UIObject.get(self,13)

self.selectPeiFangBtn:setButtonClick(function()self:onSelectPeiFangBtn()end)



end


function UIHeChengLianHuaWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.lianhuaRunning);self.lianhuaRunning=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnSwitch);self.btnSwitch=nil;
_UIObject_release(self.selectPeiFangBtn);self.selectPeiFangBtn=nil;
_UIObject_release(self.targetItem);self.targetItem=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.diziLock);self.diziLock=nil;
_UIObject_release(self.diziInfo);self.diziInfo=nil;
_UIObject_release(self.dzName);self.dzName=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
end

















local _this=nil


function UIHeChengLianHuaWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UIHeChengLianHuaWin:__delete()

uiAIManager:removeUIInstance(self.currDZ)
uiAIManager:clearUIWinData('UIHeChengLianHuaWin')
self:unbindComponents()
_this=nil
if self.isHeChengZhong then
self:showRewards()
end
self:stopLHTimer()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
end




function UIHeChengLianHuaWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end
local entityId=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(entityId)
self.buildConfig=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)

self.ubdId=self.bdData.un_build_id

if argtable.itemid then
self.jumpItemid=argtable.itemid
self:onSelectPeiFangBtn()
end


end

function UIHeChengLianHuaWin:onShowArgRecv()
if self.isHeChengZhong then
self.effect:setChildShowEffect(10068,true)
end
end


function UIHeChengLianHuaWin:onHide()
self.effect:setChildShowEffect(10068,false)
end






























































































































function UIHeChengLianHuaWin:startHeChengLianHua(pfId,reward,cb)
if cb then
self.sendCb=cb
end
self.targetItem:setActive(true)

self.isHeChengZhong=true
self.showReward=reward
self.pfId=pfId
local config=cfgHelper.get1(cfg_lianqigeconfig_get,pfId)
self.selectPeiFangBtn:setActive(false)
self.lianhuaRunning:setActive(true)
local time=config.time
self.progressBar:animateFiveParams(0,time,time,time)
local func=function(...)
self.isHeChengZhong=false
self.selectPeiFangBtn:setActive(true)
self.lianhuaRunning:setActive(false)
UIManager.setMoneyMsgShowState(true,true)
self:showRewards(true)
self.targetItem:setActive(false)
self.effect:setChildShowEffect(10068,false)
end
self.progressBar:setFinishAction(func)
UIManager.setMoneyMsgShowState(false,true)
self:refreshTargetItem(config)

self.progressText:setText(timeHelper.format_time_stamp4(time))
self:stopLHTimer()
local timeFunc=function(...)
time=time-1
self.progressText:setText(timeHelper.format_time_stamp4(time))
end
self.lhTimer=self:setTimer(1,0,timeFunc)

self.effect:setChildShowEffect(10068,true)

AudioManager.playAudio(560)
end

function UIHeChengLianHuaWin:stopLHTimer()
if self.lhTimer then
self:stopTimerByID(self.lhTimer)
self.lhTimer=nil
end
end

function UIHeChengLianHuaWin:refreshTargetItem(config)
local reward=heChengLianHuaModel:getRewards(config)
local item=reward[1]
local itemid=item[1]
local conf={itemid=itemid,itemcount='',showCountBG=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.targetItem:setChildPropData(prop)
end

function UIHeChengLianHuaWin:showRewards(isBackPf)
if self.sendCb then
self.sendCb(self.pfId,isBackPf)
self.sendCb=nil
end
if self.showReward then
for i,v in ipairs(self.showReward)do
local itemid=v.param_1
local count=v.param_2
local conf={{itemid=itemid,num=count}}

if isBackPf then

local sfId=mapIdType.zhufeng
local bdId=SLG_SYSTEM_TYPE.eBaGuaLu1
local bdData=zongmenModel:findBuildingDataByID(sfId,bdId)
UIFullBaGuaLuControl:showWindow('UIHeChengLianHuaPeiFangWin',{sfId=sfId,bdData=bdData,pfId=self.pfId})
end

showPrizeControl.showWindowNow(conf)
end
end
end



function UIHeChengLianHuaWin:onSelectPeiFangBtn()










UIFullBaGuaLuControl:showWindow('UIHeChengLianHuaPeiFangWin',{sfId=self.sfId,bdData=self.bdData,itemid=self.jumpItemid})
end

function UIHeChengLianHuaWin:onClickSelect()













zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eManager,dzSelectEffectType.ePlan,3)
end