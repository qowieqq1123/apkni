







def_class("UIGuPiaoItemEventWin",UIWindowBase)









function UIGuPiaoItemEventWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.gridContent=UIObject.get(self,1)
self.noItem=UIObject.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIGuPiaoItemEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gridContent);self.gridContent=nil;
_UIObject_release(self.noItem);self.noItem=nil;
end



















function UIGuPiaoItemEventWin:onLoaded(...)
self:bindComponents()
end


function UIGuPiaoItemEventWin:__delete()
self:unbindComponents()
end




function UIGuPiaoItemEventWin:onShow(argtable,afterOnloaded)
self:refresh()
end


function UIGuPiaoItemEventWin:onHide()

end

function UIGuPiaoItemEventWin:refresh()
local itemEventList=shangHangModel:getItemList()
if next(itemEventList)then
self.gridContent:setChildLayoutGroupCreateItems(#itemEventList)
local grids=self.gridContent:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
self:refreshItem(i,grid,itemEventList[i])
end

if self.timeUpdate then
self:stopTimerByID(self.timeUpdate)
end
local refreshTimeCB=function()
local nowTime=timeHelper.getServerShortTime()
for i=1,grids.Count do
local grid=grids[i-1]
self:refreshTime(grid,nowTime,itemEventList[i])
end
end
refreshTimeCB()
self.timeUpdate=self:setTimer(1,0,refreshTimeCB)

self.noItem:setActive(false)
else


self:closeSelf()
end
end

function UIGuPiaoItemEventWin:refreshItem(index,grid,item)
local itemId=item.itemid

local cfg=itemsConfig.getConfig(itemId)
local count=bagModel.getNotExpireItemCountById(itemId)
local hasExpireTime=bagUseControl.hasExpireTime(item.itemguid)
if hasExpireTime then

if bagUseControl.isItemExpire(item.itemguid)then
grid:SetChildActive(-1,false)
return
end
end
local conf={itemid=itemId,itemcount=hasExpireTime and''or count,showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildPropData(1,prop)
grid:SetBaseItemClickEvent(1,function(itemid,index,guid,attach)
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end)
grid:SetChildText(0,cfg.name)

local eventCfg=cfgHelper.get(cfg_shanghangitemeventconfig_get,itemId)

grid:SetChildText(2,eventCfg.desc or'')



grid:SetChildButtonClick(3,function()
local now=timeHelper.getServerLongTime()
if not shangHangModel:isOpenTime(now)then
UIManager.error("休市中无法使用")
return
end
local nextTime=shangHangModel:getNextChangeTime(false,now)
for i=1,2 do
if nextTime==0 then
UIManager.error("即将休市无法使用")
return
end
nextTime=shangHangModel:getNextChangeTime(false,nextTime)
end

local expireTime=bagUseControl.getItemExpireTime(item.itemguid)
if hasExpireTime and expireTime then
local nowTime=timeHelper.getServerShortTime()

if expireTime>0 and expireTime-nowTime>0 then
socketManager:send_248_102(itemId)
else
UIManager.error("已过期")
end
else
socketManager:send_248_102(itemId)
end
end)
end

function UIGuPiaoItemEventWin:refreshTime(grid,nowTime,item)

local expireTime=bagUseControl.getItemExpireTime(item.itemguid)
if expireTime>0 then
local time=(expireTime>0 and expireTime-nowTime>0)and timeHelper.format_time_stamp3(expireTime-nowTime)or
FMT.fmt("<color={0}>已过期</color>",FONT_COLOR_VAL[FONT_COLOR.eRedColor])
grid:SetChildText(4,FMT.fmt("有效期：{0}",time))
end
end




function UIGuPiaoItemEventWin:onCloseBtn()
self:closeSelf()
end

