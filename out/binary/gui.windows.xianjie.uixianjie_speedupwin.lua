







def_class("UIXianJie_speedUpWin",UIWindowBase)









function UIXianJie_speedUpWin:bindComponents()

self.item=UIObject.get(self,0)
self.mask=UIButton.get(self,1)
self.progressbar=UIProgress.get(self,2)
self.root=UIObject.get(self,3)
self.speedUpItemGroup=UIObject.get(self,4)
self.buyTxt=UIText.get(self,5)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIXianJie_speedUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.speedUpItemGroup);self.speedUpItemGroup=nil;
_UIObject_release(self.buyTxt);self.buyTxt=nil;
end
















local _this
local _speedUpItemCmpIndex={
item=0,
name=1,
desc=2,
useBtn=3,
buyBtn=4,
moneyCountText=5,
moneyIcon=6,
moneyCountText1=9,
moneyIcon1=10,
}




function UIXianJie_speedUpWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.on_money_changed,function()
self:freshHasCount()
end)

self:addNotify(notifyConfig.on_item_list_changed,function()
self:freshHasCount()
end)
end


function UIXianJie_speedUpWin:__delete()
UIManager:invokeUIMethod("UIXianJieMainWin","refreshTeamPanel_onlySelect",true)
self:clearProgressTimer()
_this=nil
self:unbindComponents()
end




function UIXianJie_speedUpWin:onShow(argtable,afterOnloaded)

self.onlykey=argtable and argtable.onlykey
self.marchtype=argtable and argtable.marchtype or nil


self:setRootPos()
self:refresh()
end


function UIXianJie_speedUpWin:onHide()
self:clearProgressTimer()
end

function UIXianJie_speedUpWin:refresh()

self:setProgressShow()


self:refreshSpeedUpItemGroup()
end


function UIXianJie_speedUpWin:setRootPos()
























end

function UIXianJie_speedUpWin:setProgressShow()

self:clearProgressTimer()

local func=function()
return self:refreshProgress()
end

self.progressTimer=self:setTimer(0.25,0,func)
func()
end

function UIXianJie_speedUpWin:refreshProgress()
local teamHandle=xianjieController:getXJTeamHandleByKey(self.onlykey)
if teamHandle then
local isShowProgress=teamHandle:checkIsShowProgress()
if isShowProgress then

local isCanSpeedUp=teamHandle:checkSpeeUp()
if isCanSpeedUp then
local lerpTime,wayTime=teamHandle:geLerpTime()
if wayTime and lerpTime>0 then
lerpTime=math.ceil(lerpTime)
self.progressbar:setProgressValue(wayTime-lerpTime,wayTime)
local time_str=timeHelper.format_time_stamp(lerpTime,true)
self.progressbar:setChildProgressText(time_str)

return
else
self.progressbar:setProgressValue(100,100)
local time_str=timeHelper.format_time_stamp(0,true)
self.progressbar:setChildProgressText(time_str)


return self:closeWin()
end
end
end
end


return self:closeWin()
end

function UIXianJie_speedUpWin:refreshSpeedUpItemGroup()
local itemInfo=self:getSpeedCostItem()
local costInfo=itemInfo[1]
local replaceInfo=itemInfo[2]
local rate=costInfo[1]
local cost=costInfo[2][1]
local replaceMoney=replaceInfo[2][1]
local typo=costInfo[3]
local itemId=cost[1]
local neednum=cost[2]
local itemCfg=itemsConfig.getConfig(itemId)
local canPlace=replaceMoney~=nil


local widget=self.winlua:GetChildWidgetBase(self.item:getID())
local itemWidget=widget:GetChildWidgetBase(0)
local isMoney=itemsConfig.isMoney(itemId)
local hasCount=itemsModel.getCount(itemId)
local countStr=hasCount>1 and mathHelper.formatNumber(hasCount)or''
local showCountBG=hasCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)


local itemName=itemCfg.name
widget:SetChildText(_speedUpItemCmpIndex.name,itemName)


local descStr=FMT.fmt("队伍剩余移动时间减少{0}%",rate)
widget:SetChildText(_speedUpItemCmpIndex.desc,descStr)
widget:SetChildText(7,typo==1 and FMT.fmt('宗门持有：{0}',hasCount)or FMT.fmt('仙盟仓库：{0}',hasCount))

local permissionCfg=costInfo[4]
local hasPermission,msg=self:hasPermission(permissionCfg,costInfo[5])

local enoughnum=hasCount>=neednum
local isNeedBuy=not enoughnum and not isMoney
if isNeedBuy then

if canPlace then

widget:SetChildActive(_speedUpItemCmpIndex.buyBtn,true)
widget:SetChildActive(_speedUpItemCmpIndex.useBtn,false)
local moneyType=replaceMoney[1]
local moneyCount=replaceMoney[2]
widget:SetChildText(_speedUpItemCmpIndex.moneyCountText,moneyCount)
widget:SetChildIcon(_speedUpItemCmpIndex.moneyIcon,iconHelper.getMoneyIconName(moneyType),false)
widget:SetChildActive(_speedUpItemCmpIndex.moneyCountText,true)
widget:SetChildButtonClick(_speedUpItemCmpIndex.buyBtn,function()
if not hasPermission then
UIManager.error(msg)
return
end
local onlykey=self.onlykey
local func=function()
local teamHandle=xianjieController:getXJTeamHandleByKey(onlykey)
if teamHandle then
teamHandle:doSpeedUp(2)
end
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianJieSpeedUp2)

if flag then
moneySystem:useMoney(moneyType,moneyCount,func,WARNING_TYPE.eWarning)
return
end
local name=itemsConfig.getColorName(itemId)
local moneyName=itemsConfig.getItemName(moneyType)
local showdata=
{
type='UIDialouge',
title='提示',
content=string.format('是否消耗<color=#ca631d>%d%s</color>购买%s进行加速？',moneyCount,moneyName,name),
oktext='确定',
canceltext='取消',
okcallback=function(...)
moneySystem:useMoney(moneyType,moneyCount,func,WARNING_TYPE.eWarning)
end,

}
showdata.choosetext="今日不再提示"
showdata.choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianJieSpeedUp2,flag)
end
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()

end,true)
else
widget:SetChildActive(_speedUpItemCmpIndex.buyBtn,false)
widget:SetChildActive(_speedUpItemCmpIndex.useBtn,true)
widget:SetChildText(_speedUpItemCmpIndex.moneyCountText1,neednum)
widget:SetChildIcon(_speedUpItemCmpIndex.moneyIcon1,iconHelper.getIconName(itemId),false)
widget:SetChildButtonClick(_speedUpItemCmpIndex.useBtn,function()
gainControl:showGainWin(itemId)
local name=itemsConfig.getItemName(itemId)
UIManager.error(FMT.fmt('{0}不足',name))
end,true)
end
else
widget:SetChildImageExGray(_speedUpItemCmpIndex.useBtn,not hasPermission)
widget:SetChildActive(_speedUpItemCmpIndex.buyBtn,false)
widget:SetChildActive(_speedUpItemCmpIndex.useBtn,true)
widget:SetChildText(_speedUpItemCmpIndex.moneyCountText1,neednum)
widget:SetChildIcon(_speedUpItemCmpIndex.moneyIcon1,iconHelper.getIconName(itemId),false)

widget:SetChildButtonClick(_speedUpItemCmpIndex.useBtn,function()
if not hasPermission then
UIManager.error(msg)
return
end
if not enoughnum then
gainControl:showGainWin(itemId)
local name=itemsConfig.getItemName(itemId)
UIManager.error(FMT.fmt('{0}不足',name))
return
end
local repeat_tp=typo==1 and REPEAT_TYPE.eXianJieSpeedUp or REPEAT_TYPE.eXianJieSpeedUp3
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,repeat_tp)
if flag then
self:useSpeedUpItem(1)
return
end
local name=itemsConfig.getColorName(itemId)
local showdata=
{
type='UIDialouge',
title='提示',
content=string.format("是否消耗<color=#ca631d>%d</color>个%s进行加速？",neednum,name),
oktext='确定',
canceltext='取消',
okcallback=function(...)
self:useSpeedUpItem(1)
end,

}
showdata.choosetext="今日不再提示"
showdata.choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,repeat_tp,flag)
end
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end,true)
end
end

function UIXianJie_speedUpWin:hasPermission(cfg,title)
if cfg==nil or#cfg==0 then return true end
local typo=cfg[1]
if typo==1 then
local gzid=cfg[2]
local actorid=playerModel:getActorID()
local pos=xianmengModel:getXMMemberPost(actorid)
local ret=pos and pos<=gzid or false
local str=''
if not ret then
str='需'
for i=1,gzid do
local name=cfgHelper.get2(cfg_guildpositionconfig_get,i,'name')
str=i==1 and FMT.fmt('{0}{1}',str,name)or FMT.fmt('{0}或{1}',str,name)
end
str=FMT.fmt('{0}才可使用加速',str)
end
return ret,title or str
else
loggerUtil.logErrFMT('加速权限类型{0}尚未支持',typo)
end
return true
end

function UIXianJie_speedUpWin:getSpeedCostItem()

local accelerate=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'accelerate')
local itemlist=accelerate[self.marchtype]or accelerate[0]
return itemlist
end

function UIXianJie_speedUpWin:clearProgressTimer()
if self.progressTimer then
self:stopTimerByID(self.progressTimer)
self.progressTimer=nil
end
end

function UIXianJie_speedUpWin:fastBuyRecvCallback(itemId,onlyKey)
if onlyKey==self.onlykey then
return self:useSpeedUpItem(itemId)
end

return self:refresh()
end



function UIXianJie_speedUpWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,showModel=true,})
end


function UIXianJie_speedUpWin:buyAndUseSpeedUpItem(itemId,neednum)
local cfg=fastBuyController.getCfg(itemId)
if cfg then
local onlyKey=self.onlykey
fastBuyController:checkUse4(itemId,1,nil,nil,function(itemid)
UIManager:invokeUIMethod("UIXianJie_speedUpWin","fastBuyRecvCallback",itemid,onlyKey)
end)
else
UIManager.error("暂无购买途径")
end
end


function UIXianJie_speedUpWin:useSpeedUpItem(index)
local teamHandle=xianjieController:getXJTeamHandleByKey(self.onlykey)
if teamHandle then
teamHandle:doSpeedUp(index)

end
end

function UIXianJie_speedUpWin:closeWin()
self:closeSelf()
end

function UIXianJie_speedUpWin:onMask()
self:closeWin()
end

function UIXianJie_speedUpWin:freshHasCount()
self:refreshSpeedUpItemGroup()
end
