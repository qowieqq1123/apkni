







def_class("UIRepairCDWin",UIWindowBase)









function UIRepairCDWin:bindComponents()

self.title=UIText.get(self,0)
self.rightPanel=UIObject.get(self,1)
self.destext=UIText.get(self,2)
self.cdProgress=UIObject.get(self,3)
self.completeBtn=UIButton.get(self,4)
self.time2=UIText.get(self,5)
self.icon=UIObject.get(self,6)

self.completeBtn:setButtonClick(function()self:onCompleteBtn()end)



end


function UIRepairCDWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.destext);self.destext=nil;
_UIObject_release(self.cdProgress);self.cdProgress=nil;
_UIObject_release(self.completeBtn);self.completeBtn=nil;
_UIObject_release(self.time2);self.time2=nil;
_UIObject_release(self.icon);self.icon=nil;
end



















function UIRepairCDWin:onLoaded(...)
self:bindComponents()

self.completeBtn:setActive(false)
end


function UIRepairCDWin:__delete()
self:unbindComponents()


end




function UIRepairCDWin:onShow(argtable,afterOnloaded)
self.bdData=argtable
self:refresh()
end


function UIRepairCDWin:onHide()

end

function UIRepairCDWin:getRepairModel(cfg)
if cfg.sp_ui_model then
return cfg.sp_ui_model[0]
end
return cfg.repair_model[1]
end

function UIRepairCDWin:refresh()
local id=self.bdData.build_id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,1)

self.title:setText(cfg.name)
self.destext:setText(levelCfg.build_desc)

local repairModel=self:getRepairModel(cfg)
local scale=isometricMapSystem:getModelScale(repairModel,true)
self.icon:setChildUIModelShowTarget(repairModel,scale,nil,eAnimationID.stand)

self:stopCOuntDown()
self:startCountDown()
end

function UIRepairCDWin:startCountDown()
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id)
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime)
local playCheck=false
local tick=function()
if cddata.complete then
self.time2:setText('已完成')
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),1,1)
self:stopCOuntDown()
self.completeBtn:setActive(true)
else
self.time2:setText(timeHelper.format_time_stamp11(cddata.cd))
if playCheck then
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime)
else
playCheck=true
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime,false)
end
end
end
tick()
self:addCDUpdateFunc('RPCD',tick)
end

function UIRepairCDWin:stopCOuntDown()
self:removeCDUpdateFunc('RPCD')
end





function UIRepairCDWin:onCompleteBtn()
zongmenControl:reqBuildComplete(zongmenModel:getMountainId(),self.bdData.un_build_id)
self:onClickClose()
end

function UIRepairCDWin:onClickClose()
self:closeSelf()
end

