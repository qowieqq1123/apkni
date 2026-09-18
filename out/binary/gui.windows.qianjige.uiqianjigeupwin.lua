







def_class("UIQianJiGeUpWin",UIWindowBase)









function UIQianJiGeUpWin:bindComponents()

self.level=UIText.get(self,0)
self.btnUpgrade=UIButton.get(self,1)
self.txtUpgradeBtn=UIText.get(self,2)

self.btnUpgrade:setButtonClick(function()self:onBtnUpgrade()end)


self.sprite_button_qjgjnxx_1=0
self.sprite_button_qjgjnxx_2=1
self.sprite_button_qjgjnxx_3=2

end


function UIQianJiGeUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.btnUpgrade);self.btnUpgrade=nil;
_UIObject_release(self.txtUpgradeBtn);self.txtUpgradeBtn=nil;
end


















local _this=nil

function UIQianJiGeUpWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.building_event,self.on_building_event)
end


function UIQianJiGeUpWin:__delete()
self:unbindComponents()
end




function UIQianJiGeUpWin:onShow(argtable,afterOnloaded)
if argtable then
local guid=argtable.entityId
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)
end
self.sfId=zongmenModel:getMountainId()
self:refreshLevelUp()
end


function UIQianJiGeUpWin:onHide()

end

function UIQianJiGeUpWin.on_building_event(etype,sfId,ubdId,gzId,args1,args2)
if etype==buildingEvent.levelUpComplete then
_this:refreshLevelUp()
end
end

function UIQianJiGeUpWin:refreshLevelUp()
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
if nextLvCfg then
self.txtUpgradeBtn:setText('升级')
if self.bdData.flag==buildingStateType.eUpgrading then
local beginTime=self.bdData.begintime-self.bdData.reducetime
if beginTime>0 then
local needTime=nextLvCfg.uplevel_times
local func=function()
local curTime=gameUtilityModel.getServerShortTime()
local dtime=curTime-beginTime
if dtime>needTime then
if self.bdData.flag==buildingStateType.eUpgrading then
self.txtUpgradeBtn:setText('完成升级')
end
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end
end
func()
self.levelUpTimer=self:setTimer(1,0,func)
else

self.level:setText(FMT.fmt('{0}级{1}',self.bdData.level,bdCfg.name))
end
else

self.level:setText(FMT.fmt('{0}级{1}',self.bdData.level,bdCfg.name))
end
else
self.level:setText(FMT.fmt('{0}级{1}',self.bdData.level,bdCfg.name))
self.txtUpgradeBtn:setText('建筑信息')

end
end





function UIQianJiGeUpWin:onBtnUpgrade()

if not mainControl:isInScene(eSceneType.eZongmen)then
UIManager.error("需要在宗门里进行升级")
return
end
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end

