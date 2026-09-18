







def_class("UIRepairWin",UIWindowBase)









function UIRepairWin:bindComponents()

self.funcpanel1=UIObject.get(self,0)
self.repairBtn=UIButton.get(self,1)
self.cost1=UIObject.get(self,2)
self.cost2=UIObject.get(self,3)
self.cost3=UIObject.get(self,4)
self.tips=UIText.get(self,5)
self.unlockText=UILinkImageText.get(self,6)
self.destext=UIText.get(self,7)
self.funcpanel2=UIObject.get(self,8)
self.repairInfo=UIObject.get(self,9)
self.icon=UIObject.get(self,10)
self.buildScrollview=UIObject.get(self,11)
self.time=UIText.get(self,12)
self.openTips=UIText.get(self,13)
self.gotoBtn=UIButton.get(self,14)
self.title=UIText.get(self,15)

self.repairBtn:setButtonClick(function()self:onRepairBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIRepairWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.funcpanel1);self.funcpanel1=nil;
_UIObject_release(self.repairBtn);self.repairBtn=nil;
_UIObject_release(self.cost1);self.cost1=nil;
_UIObject_release(self.cost2);self.cost2=nil;
_UIObject_release(self.cost3);self.cost3=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
_UIObject_release(self.destext);self.destext=nil;
_UIObject_release(self.funcpanel2);self.funcpanel2=nil;
_UIObject_release(self.repairInfo);self.repairInfo=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.buildScrollview);self.buildScrollview=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.openTips);self.openTips=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _this




function UIRepairWin:onLoaded(...)
self:bindComponents()

_this=self

self.buildScrollview:setChildScrollViewInit(1,true,nil,nil)

notifySystem:listenNotify(notifyConfig.onZongMenAreaUnLock,self.on_area_unlock)

self.on_money_changed=function(mtype,last,curr)
if mtype==self.checkType then
self:refresh()
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIRepairWin:__delete()
self:unbindComponents()

notifySystem:removelistener(notifyConfig.onZongMenAreaUnLock,self.on_area_unlock)

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)

_this=nil
end

function UIRepairWin.on_area_unlock(sfId,areaId)
local id=_MapManager.GetAreaIDByObject(_this.data.guid)
if areaId==id then
_this:refresh()
end
end




function UIRepairWin:onShow(argtable,afterOnloaded)
self.data=argtable
self:refresh()
end







function UIRepairWin:checkShow(cfg)
if cfg.repair_tips then







return true
end
return false
end

function UIRepairWin:refresh()
local id=self.data.id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
self.config=cfg
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,1)

self.title:setText(cfg.name)
self.destext:setText(levelCfg.build_desc)
local repairModel=self:getRepairModel(cfg)
local scale=isometricMapSystem:getModelScale(repairModel,true)
self.icon:setChildUIModelShowTarget(repairModel,scale,nil,eAnimationID.stand)

self.repairInfo:setActive(not cfg.auto_repair)




local repair_cost=cfg.repair_cost or{}
local costData=repair_cost[1]or{}
self:setCost(self.cost1,costData[1])
self:setCost(self.cost2,costData[2])

local time=cfg.repair_time and cfg.repair_time[1]or levelCfg.uplevel_times
self.cost3:setActive(time>0)
self.time:setText(timeHelper.format_time_stamp11(time))

local benefit=cfg.benefit_type
if benefit then
self.buildScrollview:setChildScrollViewCreateGrids(#benefit,0)
local grids=self.buildScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,benefit[i+1])
local node=grids[i]
node:SetChildUIModelShowTarget(0,bdcfg.model[1],0.15,nil,eAnimationID.bd_stand)
node:SetChildText(1,bdcfg.name)
end
end

local isOpen,tipsData=isometricMapSystem:checkRepairBuildOpen(self.data,cfg)
self.tipsData=tipsData
self.repairBtn:setActive(isOpen)
self.tips:setActive(not isOpen)

if isOpen then
self.funcpanel1:setActive(true)
self.funcpanel2:setActive(false)
local check,val=isometricMapSystem:checkRepairCost(cfg)
if not check and val then
self.tips:setText(FMT.fmt('{0}不足',itemsConfig.getItemName(val)))
self.tips:setActive(false)
self.repairBtn:setActive(true)
end

if check then
check,val=isometricMapSystem:checkRepairLevel(self.data.id,self.data.mapId)
if not check and val then
self.tips:setText(FMT.fmt('需要宗门达到{0}级',val))
self.repairBtn:setActive(check)
self.tips:setActive(not check)
end
end

if check then
local tId
check,tId=isometricMapSystem:checkRepairTask(self.data.id,self.data.mapId)
if not check then
local name=taskModel:getTaskConfig(tId).name
self.tips:setText(FMT.fmt('完成任务{0}解锁',name))
self.repairBtn:setActive(check)
self.tips:setActive(not check)
end
end



self.unlockText:setActive(false)
else
if self:checkShow(cfg)then
self.funcpanel1:setActive(false)
self.funcpanel2:setActive(true)

local rtips=self.tipsData
local desc=rtips.desc
if rtips.ctype==1 then
local acfg=cfgHelper.get1(cfg_monijyareaconfig_get,rtips.cargs[1])
desc=FMT.fmt(desc,acfg.name)
elseif rtips.ctype==3 then
local tcfg=taskModel:getTaskConfig(rtips.cargs[1])
desc=FMT.fmt(desc,tcfg.name)
elseif rtips.ctype==4 then
local stamp=timeHelper.getOpenServerShortTime()
local need=rtips.cargs[1]
local y,m,d=timeHelper.getDateNumber(gameUtilityModel.getOpenServerLongTime())
local t=timeHelper.timeServer(y,m,d,0,0,0)
t=t+(need-1)*86400
local cur=gameUtilityModel.getServerLongTime()
local cd=t-cur
desc=FMT.fmt(desc,need,timeHelper.format_time_stamp3(cd))
self:showOpenCD(cd,rtips.desc,need)
end
self.openTips:setText(desc)
self.gotoBtn:setActive(rtips.jump~=nil)
else
self.funcpanel1:setActive(true)
self.funcpanel2:setActive(false)
local areaId=self.data.areaId
local acfg=cfgHelper.get1(cfg_monijyareaconfig_get,areaId)
self.tips:setText(FMT.fmt('解锁{0}后可修复',acfg.name))
self.unlockText:setActive(true)
self.unlockText:setText(FMT.fmt(cfgHelper.getlang('repair_link_text'),areaId))
end
end
end

function UIRepairWin:showOpenCD(cd,desc,need)
self:clearTimer()
local etime=timeHelper.getServerShortTime()+cd
local tick=function()
local dt=etime-timeHelper.getServerShortTime()
if dt>=0 then
self.openTips:setText(FMT.fmt(desc,need,timeHelper.format_time_stamp3(dt)))
else
self:clearTimer()
self:refresh()
end
end
self.timer=self:setTimer(1,0,tick)
end

function UIRepairWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIRepairWin:getRepairModel(cfg)
if cfg.sp_ui_model then
return cfg.sp_ui_model[0]
end
return cfg.repair_model[1]
end

function UIRepairWin:setCost(item,data)
if data then
item:setActive(true)
local node=item:getChildWidgetBase()
node:SetChildIcon(0,iconHelper.getIconName(data[1]),true)
local need=data[2]
local have=moneyModel.getMoney(data[1])
if have<need then
node:SetChildText(1,string.format('<color=red>%s</color>',need))
else
node:SetChildText(1,need)
end
else
item:setActive(false)
end
end


function UIRepairWin:onHide()

end





function UIRepairWin:onRepairBtn()
if not isometricMapSystem:checkRepairLevel(self.data.id,self.data.mapId,true)then
return
end

if not isometricMapSystem:checkRepairTask(self.data.id,self.data.mapId,true)then
return
end

local check,id=isometricMapSystem:checkRepairCost(self.config,nil,true)
if check then
local sfId=zongmenModel:getMountainId()
zongmenControl:reqBuild(sfId,self.data.id,self.data.x,self.data.y,self.data.orientation)
self:onClickClose()
else
self.checkType=id
end
end

function UIRepairWin:onGotoBtn()
if self.config.repair_tips then

local rtips=self.tipsData
local jtype=rtips.jump.jtype
if jtype==1 then
weakGuideController:beginGuide(rtips.jump.jargs[1])
elseif jtype==2 then
jumpManager:jump(rtips.jump.jargs)
end
UIManager:closeWindow('UIRepairWin')
end
end

function UIRepairWin:onClickClose()
self:closeSelf()
end
