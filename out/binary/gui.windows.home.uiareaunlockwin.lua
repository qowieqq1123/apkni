







def_class("UIAreaUnlockWin",UIWindowBase)









function UIAreaUnlockWin:bindComponents()

self.root=UIObject.get(self,0)
self.unlockBtnText=UIText.get(self,1)
self.title=UIText.get(self,2)
self.scrollview=UIObject.get(self,3)
self.condition=UIText.get(self,4)
self.costs=UIObject.get(self,5)
self.gouImg=UIObject.get(self,6)
self.btnUnlock=UIButton.get(self,7)

self.btnUnlock:setButtonClick(function()self:onBtnUnlock()end)



end


function UIAreaUnlockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.unlockBtnText);self.unlockBtnText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.condition);self.condition=nil;
_UIObject_release(self.costs);self.costs=nil;
_UIObject_release(self.gouImg);self.gouImg=nil;
_UIObject_release(self.btnUnlock);self.btnUnlock=nil;
end
















local _this




function UIAreaUnlockWin:onLoaded(...)
self:bindComponents()
_this=self

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)

self.on_money_changed=function(mtype,last,curr)
if mtype==self.checkType then
self:refresh()
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIAreaUnlockWin:__delete()
self:stopCloseTimer()
self:unbindComponents()

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)

_this=nil
end




function UIAreaUnlockWin:onShow(argtable,afterOnloaded)
self.areaId=argtable
self:refresh()
end

function UIAreaUnlockWin:refresh()
local cfg=cfgHelper.get1(cfg_monijyareaconfig_get,self.areaId)

self.title:setText(cfg.name)

local rewards=cfg.unlock_rewards
self.scrollview:setChildScrollViewCreateGrids(#rewards,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local data=rewards[i+1]
local item=grids[i]
widgetHelper.setNormalRewardItem(item,0,data)
end

local level=zongmenModel:getLevel()
local txt=''
for i,v in ipairs(cfg.unlock_condition)do
if v.type==1 then
if level<v.param then
txt=string.format('需宗门等级达到<color=red>%s</color>级',v.param)
break
end
elseif v.type==2 then
if not taskModel:checkTaskFinish(v.param)then
local cfg=cfgHelper.get1(cfg_taskconfig_get,v.param)
txt=FMT.fmt('完成任务<color=red>{0}</color>后可解锁',cfg.name)
break
end
elseif v.type==3 then
if not zongmenModel:isAreaUnlock(v.param)then
local cfg=cfgHelper.get1(cfg_monijyareaconfig_get,v.param)
txt=FMT.fmt('需解锁区块<color=red>{0}</color>',cfg.name)
break
end
elseif v.type==4 then
if not zongmenModel:isCompleteBuildQiYu(v.param)then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.param)
txt=FMT.fmt('需完成奇遇<color=red>{0}</color>',cfg.name)
break
end
end
end
self.condition:setText(txt)
local sfId=zongmenModel:getMountainId()
local count=zongmenModel:getUnlockAreaCount(sfId)
count=math.min(#cfg.unlock_cost,count)
local costData=cfg.unlock_cost[count]
self.costData=costData
self.costs:setChildLayoutGroupCreateItems(#costData)
local items=self.costs:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local data=costData[i+1]
item:SetChildIcon(0,iconHelper.getIconName(data[1]),true)
local need=data[2]
local have=moneyModel.getMoney(data[1])
local enough=have<need
need=mathHelper.formatNumber(need)
have=mathHelper.formatNumber(have)
if enough then
item:SetChildText(1,FMT.fmt('<color=red>{0}/{1}</color>',have,need))
else
item:SetChildText(1,FMT.fmt('{0}/{1}',have,need))
end
end

local canUnlock,flag=self:CheckUnlock()
self.gouImg:setActive(canUnlock)
local paramVal=canUnlock and'true'or'false'
self.winlua:SetChildAnimatorParameter(self.root:getID(),'unlockok','bool',paramVal)
local delayTime
if canUnlock then
delayTime=1.5
else
delayTime=0.5
end
self.unlockBtnText:setText(cfg.unlock_dizi and'派遣弟子'or'解锁')
self.closeTimer=self:delayDo(delayTime,function(...)
self.canClose=true
if not canUnlock then
if flag==1 then
self.unlockBtnText:setText('提升等级')
elseif flag==3 then
self.unlockBtnText:setText('获取灵石')
elseif flag==4 then
self.unlockBtnText:setText('前往解锁')
elseif flag==5 then
self.unlockBtnText:setText('前往奇遇')
else
self.winlua:SetChildGraphicGray(self.btnUnlock:getID(),true)
end
end
end)
end


function UIAreaUnlockWin:onHide()

end

function UIAreaUnlockWin:CheckUnlock(wraning,check)
local cfg=cfgHelper.get1(cfg_monijyareaconfig_get,self.areaId)
local level=zongmenModel:getLevel()
for i,v in ipairs(cfg.unlock_condition)do
if v.type==1 then
if level<v.param then



if check then
gainControl:showGainWin(11)
end
return false,1
end
elseif v.type==2 then
if not taskModel:checkTaskFinish(v.param)then
if wraning then
local cfg=cfgHelper.get1(cfg_taskconfig_get,v.param)
local color=FONT_COLOR_VAL[FONT_COLOR.eOrangeColor]
UIManager.error(FMT.fmt('需要完成任务<color={0}>{1}</color>',color,cfg.name))
end
return false,2
end
elseif v.type==3 then
if not zongmenModel:isAreaUnlock(v.param)then
if wraning then
local cfg=cfgHelper.get1(cfg_monijyareaconfig_get,v.param)
local color=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
UIManager.error(FMT.fmt('需要解锁区块<color={0}>{1}</color>',color,cfg.name))
end
if check then
isometricMapSystem:openAreaUnLockWin(nil,v.param)

end
return false,4
end
elseif v.type==4 then
if not zongmenModel:isCompleteBuildQiYu(v.param)then
if wraning then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.param)
local color=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
UIManager.error(FMT.fmt('需完成奇遇<color={0}>{1}</color>',color,cfg.name))
end
if check then
local sfId=zongmenModel:getMountainId()
local repairData=isometricMapSystem:getRepairDataByID(sfId,v.param)
local bdData=repairData and repairData.bdData or nil
if not bdData then
bdData=zongmenModel:findBuildingDataByID(sfId,v.param)
end
if bdData and bdData.entityId then
local pos=_MapManager.GetObjectAreaC(bdData.entityId)
isometricMapSystem:moveCameraToPosition(pos,true)
self:onClickClose()
UIManager:invokeUIMethod('UIChallengeWin','onClickClose')
end
end
return false,5
end
end
end
local needData
for i,v in ipairs(self.costData)do
local need=v[2]
local moneyType=v[1]
local have=moneyModel.getMoney(moneyType)
if have<need then
needData=v



break
end
end
if needData then
self.checkType=needData[1]
if check then
local ret=UIDiscipleController.doTriggerSomething(dzTriggerDoSomething.ePrivateMoney,{needData[1],needData[2]})
if not ret then
gainControl:showGainWin(needData[1])
end
end
return false,3
end
return true
end

function UIAreaUnlockWin:stopCloseTimer()
if self.closeTimer then
self:stopTimerByID(self.closeTimer)
self.closeTimer=nil
end
end





function UIAreaUnlockWin:onBtnUnlock()
if self:CheckUnlock(true,true)then
local areaId=self.areaId
local sfId=zongmenModel:getMountainId()
local cfg=cfgHelper.get1(cfg_monijyareaconfig_get,areaId)
local unlockFunc=function()
if cfg.unlock_dizi then

local args={areaId=areaId}
args.callback=function(dzguid)
zongmenControl:reqUnlockArea(sfId,areaId,1,1,{dzguid})
end
local winParams={
titleName='派遣弟子',
extraWin='UIAreaUnlockSelectDZWin',
extraParams=args,
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
else
zongmenControl:reqUnlockArea(sfId,areaId,1,0,{})
end
end
if cfg.qy_event_id then
local data=zongmenModel:getAreaData(sfId,areaId)
if data.can_unlock==1 then
unlockFunc()
else

end
else
unlockFunc()
end
self.canClose=true
self:onClickClose()
end
end

function UIAreaUnlockWin:onClickClose()
if not self.canClose then
return
end
self:closeSelf()
end