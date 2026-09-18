







def_class("UIXianGuanLogDetailWin",UIWindowBase)









function UIXianGuanLogDetailWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.emptyRoot=UIObject.get(self,1)
self.logLoopView=UILoopListView.new(self,2)
self.menu_1=UIButton.get(self,3)
self.menu_2=UIButton.get(self,4)
self.menuList=UIObject.get(self,5)
self.Root=UIObject.get(self,6)
self.title=UIText.get(self,7)
self.uiRoot=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.logLoopView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.menu_1:setButtonClick(function()self:onMenu_1()end)

self.menu_2:setButtonClick(function()self:onMenu_2()end)
self.menu={
self.menu_1,
self.menu_2,
}



end


function UIXianGuanLogDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.emptyRoot);self.emptyRoot=nil;
self.logLoopView:deleteSelf();self.logLoopView=nil;
_UIObject_release(self.menu_1);self.menu_1=nil;
_UIObject_release(self.menu_2);self.menu_2=nil;
_UIObject_release(self.menuList);self.menuList=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.menu=nil;
end

















local _this

local _menuTypeEnum={
buff=1,
fight=2,
}

local _logStateEnum={
effect=1,
ended=2,
Expired=3,
}


local body_id={
back=2016,
menu=2017,
}
local menu_slot_name='button_dytab'

local _CmpLogInfoIndex={
head=0,
loseHead=1,
xgName=2,
pName=3,
stateImg=4,
desc=5,
stamp=6,
new=7,
chakanBtn=8,
}

local _stateImgList={
[_logStateEnum.effect]="image_xianguanjishi_wz2",
[_logStateEnum.ended]="image_xianguanjishi_wz3",
[_logStateEnum.Expired]="image_xianguanjishi_wz4"
}

local _ab="ui/windows/xianguan/xianguan_atlas_pak.ab"


local getMenuAttchmentName=function(isSelect)
local name
if isSelect then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end
return name
end

local checkEndStateJump={
[XIANGUAN_PRIVILEGE_ENUM.eXianShiYaoWu]=function(logData)
return timeHelper.checkInSameWeek4(logData.sec)
end
}




function UIXianGuanLogDetailWin:onLoaded(...)
self:bindComponents()

_this=self

self.selectMenuIdx=_menuTypeEnum.buff
end


function UIXianGuanLogDetailWin:__delete()
_this=nil
self:stopStateTimer()

self:unbindComponents()

xianguanController:updateLogShowSec()
end




function UIXianGuanLogDetailWin:onShow(argtable,afterOnloaded)


self.isFull=argtable and argtable.isFull

local autoSelectMenuIndex=self:autoSelectMenu()
if argtable and argtable.menuIdx then
self.selectMenuIdx=argtable.menuIdx
else
self.selectMenuIdx=autoSelectMenuIndex
end

self:refreshLogList()

if afterOnloaded then
self:freshMenuList()
end
end


function UIXianGuanLogDetailWin:onHide()

end

function UIXianGuanLogDetailWin:freshMenuList()
local selectMenuIdx=self.selectMenuIdx

local func2=function(index,animWiget)
local isSelect=selectMenuIdx==index
local name=getMenuAttchmentName(isSelect)

animWiget:SetChildUIModelShowSlotAttachment(0,menu_slot_name,name)
end

for i,v in ipairs(self.menu)do
local anim=self.menu[i]
local animWiget=anim:getWidgetBase()
local cb=function()
func2(i,animWiget)
end
animWiget:SetChildUIModelShowTarget(0,body_id.menu,1,{},eAnimationID.common_window_enter,false,false,0,cb)
end
end

function UIXianGuanLogDetailWin:onClickMenu(index)
local preAnim=_this.menu[_this.selectMenuIdx]
local preAnimWiget=preAnim:getWidgetBase()
local preName=getMenuAttchmentName(false)
preAnimWiget:SetChildUIModelShowSlotAttachment(0,menu_slot_name,preName)

_this.selectMenuIdx=index
local anim=_this.menu[_this.selectMenuIdx]
local animWiget=anim:getWidgetBase()
local name=getMenuAttchmentName(true)
animWiget:SetChildModelAnimationState(0,eAnimationID.common_window_dianji)
animWiget:SetChildUIModelShowSlotAttachment(0,menu_slot_name,name)

_this:refreshLogList()
end

function UIXianGuanLogDetailWin:refreshLogList()
self:stopStateTimer()

self:selectLogList()

local isEmpty=#self.logList==0
self.emptyRoot:setActive(isEmpty)
self.logLoopView:setActive(not isEmpty)

if not isEmpty then

self.logLoopView:initData("temp",self.logList,#self.logList)
self.logLoopView:jumpItem(0)

self.updateList={}

for index,data in ipairs(self.logList)do
if self:getLogState(data)==_logStateEnum.effect then
local duration=xianguanConfig.getTeQuanCfg(data.tqid,'duration')
self.updateList[#self.updateList+1]={index,data,data.sec+duration}
end
end

if#self.updateList>0 then
self:startLogStateTimer()
end
end
end


function UIXianGuanLogDetailWin:onStartAction()
end

function UIXianGuanLogDetailWin:onFreshAction(index,widget,data)
if data==nil then



end

local isLose=data.actorname==''
local isShowHead=not isLose

widget:SetChildActive(_CmpLogInfoIndex.head,isShowHead)
widget:SetChildActive(_CmpLogInfoIndex.loseHead,isLose)

if isShowHead then
playerController:setHeadIcon(widget,_CmpLogInfoIndex.head,{scale=0.8,iconInfo=data.iconInfo})
widget:SetChildButtonClick(_CmpLogInfoIndex.head,function()
local actorid=data.actorid
local serverid=data.serverid
if actorid and serverid then
local attach={serverid=serverid}
otherPlayerController:openOtherPlayerInfoWin(actorid,nil,nil,attach)
else



end
end)
end

widget:SetChildText(_CmpLogInfoIndex.pName,playerModel:getOtherActorName(data.actorname))

local xgName=xianguanConfig.getJobConfig(nil,data.xgid,'name')
xgName=FMT.fmt("【{0}】",xgName)
widget:SetChildText(_CmpLogInfoIndex.xgName,xgName)

local log=xianguanModel:getDetailLogDesc(data)
log=FMT.fmt("<color=#00000000>____________</color>{0}",log)
widget:SetChildText(_CmpLogInfoIndex.desc,log)

local timeStr=timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(data.sec)))
widget:SetChildText(_CmpLogInfoIndex.stamp,timeStr)

local stateIdx=self:getLogState(data)
local stateImg=_stateImgList[stateIdx]
widget:SetChildCSImageSprite(_CmpLogInfoIndex.stateImg,_ab,stateImg)

local isNew=data.isNew~=nil and data.isNew
widget:SetChildActive(_CmpLogInfoIndex.new,isNew)

local isShowChaKanBtn=false
local logJump
local chakanBtnClick
if self.selectMenuIdx==_menuTypeEnum.buff then
logJump=xianguanConfig.getTeQuanCfg(data.tqid,'logJump')
isShowChaKanBtn=logJump~=nil
if logJump then
chakanBtnClick=function()
if stateIdx==_logStateEnum.effect then
xianguanConfig.commonLogJump(data.xgid,data.tqid,data)
elseif stateIdx==_logStateEnum.Expired then
UIManager.error("效果已过期，查看失败")
elseif stateIdx==_logStateEnum.ended then
if checkEndStateJump[data.tqid]then
if checkEndStateJump[data.tqid](data)then
xianguanConfig.commonLogJump(data.xgid,data.tqid,data)
end
end
end
end
end
elseif self.selectMenuIdx==_menuTypeEnum.fight then
logJump=xianguanConfig.getTeQuanCfg(data.tqid,'logJump')
isShowChaKanBtn=logJump~=nil
if logJump then
chakanBtnClick=function()
xianguanConfig.commonLogJump(data.xgid,data.tqid,data)
end
end
end
widget:SetChildActive(_CmpLogInfoIndex.chakanBtn,isShowChaKanBtn)
widget:SetChildButtonClick(_CmpLogInfoIndex.chakanBtn,chakanBtnClick,true)
end


function UIXianGuanLogDetailWin:selectLogList()
if self.selectMenuIdx==_menuTypeEnum.buff then
self.logList=xianguanModel:getLogList_Buff()
elseif self.selectMenuIdx==_menuTypeEnum.fight then
self.logList=xianguanModel:getLogList_Fight()
else
self.logList={}
end
end

function UIXianGuanLogDetailWin:autoSelectMenu()
local list=xianguanModel:getLogList_Buff()
if#list>0 then
return _menuTypeEnum.buff
end

list=xianguanModel:getLogList_Fight()
if#list>0 then
return _menuTypeEnum.fight
end

return _menuTypeEnum.buff
end


function UIXianGuanLogDetailWin:getLogState(data)
local curTime=timeHelper.getServerShortTime()
local duration=xianguanConfig.getTeQuanCfg(data.tqid,'duration')
if duration~=nil then
if duration+data.sec>curTime then
return _logStateEnum.effect
else
return _logStateEnum.Expired
end
else
return _logStateEnum.ended
end
end


function UIXianGuanLogDetailWin:startLogStateTimer()
self:stopStateTimer()

local curTime=timeHelper.getServerShortTime()
local totalLen=#self.updateList
local passLen=0
local func=function()
curTime=timeHelper.getServerShortTime()
for index,data in ipairs(_this.updateList)do
if not data.pass then
if curTime>=data[3]then
_this:freshItem(data[1],data[2])
data.pass=true
passLen=passLen+1
end
end
end

if passLen>=totalLen then
_this:stopStateTimer()
end
end

self.stateTimer=self:setTimer(0.1,0,func)
func()
end

function UIXianGuanLogDetailWin:stopStateTimer()
if self.stateTimer then
self:stopTimerByID(self.stateTimer)
self.stateTimer=nil
end
end

function UIXianGuanLogDetailWin:freshItem(dataIdx,data)
local widget=self.logLoopView:getListViewItemWidgetByDataIndex(dataIdx)
if widget then
self:onFreshAction(dataIdx,widget,data)
end
end





function UIXianGuanLogDetailWin:onCloseBtn()
if self.isFull then
UIFullCommonControl:closeUI()
else
self:closeSelf()
end
end



function UIXianGuanLogDetailWin:onMenu_1()
if self.selectMenuIdx==_menuTypeEnum.buff then return end
self:onClickMenu(_menuTypeEnum.buff)
end



function UIXianGuanLogDetailWin:onMenu_2()
if self.selectMenuIdx==_menuTypeEnum.fight then return end
self:onClickMenu(_menuTypeEnum.fight)
end

