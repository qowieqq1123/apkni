







def_class("UIWeekendWelfareWin",UIWindowBase)









function UIWeekendWelfareWin:bindComponents()

self.Root=UIObject.get(self,0)
self.bgSpine=UIObject.get(self,1)
self.uiRoot=UIObject.get(self,2)
self.titleimg=UIObject.get(self,3)
self.lefttimebg=UIObject.get(self,4)
self.ceilList=UIObject.get(self,5)
self.countdowm=UIText.get(self,6)



end


function UIWeekendWelfareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.titleimg);self.titleimg=nil;
_UIObject_release(self.lefttimebg);self.lefttimebg=nil;
_UIObject_release(self.ceilList);self.ceilList=nil;
_UIObject_release(self.countdowm);self.countdowm=nil;
end
















local CmpCeilItemIndex={
ceilBg=0,
ceilName=1,
ceilState=2,
ceilInfo=3,
ntitle=4,
infoLayout=5,
effectIcon=6,
infodesc=7,
rewardList=8,
chatu=9,
lock=10,
}

local CmpRewardItemIndex={
smallItem=0,
receiveImg=1,
select=2,
}

local CmpStateIconList={
'icon_zhoumofmui_1',
'icon_zhoumofmui_2',
'icon_zhoumofmui_3',
'icon_zhoumofmui_4',
}

local CmpCeilStateBgImgList={
'image_zhoumofmui_1',
'image_zhoumofmui_2',
}

local _this

local _CEIL_Len=3

local _ab='ui/windows/welfare/welfare_weekwelfare_atlas_pak.ab'



function UIWeekendWelfareWin:onLoaded(...)
self:bindComponents()

_this=self
end


function UIWeekendWelfareWin:__delete()
self:unbindComponents()

_this=nil
self:stopTimer()
end




function UIWeekendWelfareWin:onShow(argtable,afterOnloaded)
self.idx=weekendBenifitsModel:getCfgId()


self:refreshCountDown()

self:refreshPanel()
end


function UIWeekendWelfareWin:onHide()

end

function UIWeekendWelfareWin:onShowArgRecv()
self:onShow()
end

function UIWeekendWelfareWin:refreshCountDown()
local leftTime=weekendBenifitsModel:getLeftTime()
local leftTimeStamp=timeHelper.getServerLongTime()+leftTime

local isShowCountDown=leftTime>0
self.countdowm:setActive(isShowCountDown)

self:stopTimer()

if isShowCountDown then
local updateFunc=function()
local curStamp=timeHelper.getServerLongTime()
local leftStamp=leftTimeStamp-curStamp
local timeFormat=timeHelper.format_time_stamp3(leftStamp)
local countdownStr=FMT.fmt("活动剩余时间：{0}",timeFormat)
self.countdowm:setText(countdownStr)
if leftStamp<=0 then
_this:stopTimer()
_this:refreshPanel()
end
end

self.countdownTimerId=self:setTimer(1,0,updateFunc)
updateFunc()
end
end

function UIWeekendWelfareWin:stopTimer()
if self.countdownTimerId then
self:stopTimerByID(self.countdownTimerId)
self.countdownTimerId=nil
end
end

function UIWeekendWelfareWin:refreshPanel()
local rewardIdx=weekendBenifitsModel:getRewardIdx()

self.ceilList:setChildLayoutGroupCreateItems(_CEIL_Len,function(index)
local ceilItem=self.ceilList:getChildLayoutGroupGridItem(index-1)
local cfg=weekendBenifitsModel:getCfgByIndex(index)

local receiveState=weekendBenifitsModel:getCanReceive(index)
local ceilState=weekendBenifitsModel:getCeilState(index)
local loginState=weekendBenifitsModel:getLoginFlag(index)
local rewardFlag=weekendBenifitsModel:getRewardFlag(index)
local isToday=ceilState==2

ceilItem:SetChildActive(-1,true)

local bcfg=cfgHelper.get1(cfg_guildstateconfig_get,cfg.state)


local ceilBgImg=ceilState==2 and CmpCeilStateBgImgList[2]or CmpCeilStateBgImgList[1]
ceilItem:SetChildCSImageSprite(CmpCeilItemIndex.ceilBg,_ab,ceilBgImg)


ceilItem:SetChildCSImageSprite(CmpCeilItemIndex.ceilName,_ab,cfg.ceilTitleImg)


ceilItem:SetChildCSImageSprite(CmpCeilItemIndex.chatu,_ab,cfg.ceilChatuImg)


local buffIconName=iconHelper.getzmStateIcon(bcfg.icon)
ceilItem:SetChildIcon(CmpCeilItemIndex.effectIcon,buffIconName,false)

ceilItem:SetChildText(CmpCeilItemIndex.ntitle,bcfg.name)



ceilItem:SetChildText(CmpCeilItemIndex.infodesc,cfg.ceilBuffdesc)



local gray=((ceilState<=2 and rewardFlag)or(ceilState==1 and not loginState))and 1 or 0
local rewards=cfg.rewards[rewardIdx][2]
local propDataList={}
local colorEffect=ceilState<=2 and not rewardFlag and loginState
local effectId="xianshu_light"
for k,baseData in ipairs(rewards)do
local itemid=baseData[1]
local itemnum=baseData[2]or 0
local range=baseData.range

local conf={
itemid=itemid,
itemcount=itemnum>-1 and mathHelper.formatNumber(itemnum)or'',
showCountBG=itemnum>-1 or range~=nil,
showname=false,
range=range,
gray=gray,

}
local propdata=itemsComponentHelper.getCommonFillDataSmall(conf)
table.insert(propDataList,propdata)
end
ceilItem:SetChildLayoutGroupCreateItems(CmpCeilItemIndex.rewardList,#propDataList,function(rindex)
local rItem=ceilItem:GetChildLayoutGroupGridItem(CmpCeilItemIndex.rewardList,rindex-1)
local propData=propDataList[rindex]

rItem:SetChildActive(-1,true)



rItem:SetChildActive(CmpRewardItemIndex.select,colorEffect)

rItem:SetChildPropData(CmpRewardItemIndex.smallItem,propData)
rItem:SetChildActive(CmpRewardItemIndex.receiveImg,not receiveState)
rItem:SetBaseItemClickEvent(CmpRewardItemIndex.smallItem,function(...)

if receiveState and loginState then
weekendBenifitsController:send_248_84(cfg.day)
else
itemsComponentHelper.onItemClick(...)
end
end)
end)


local stateIconName=CmpStateIconList[ceilState]
ceilItem:SetChildCSImageSprite(CmpCeilItemIndex.ceilState,_ab,stateIconName)

local isShowLock=ceilState==1 and(rewardFlag or not loginState)

ceilItem:SetChildActive(CmpCeilItemIndex.lock,isShowLock)
if isShowLock then
ceilItem:SetChildCSImageSprite(CmpCeilItemIndex.lock,_ab,cfg.ceilBgImg)
end


ceilItem:SetBaseItemClickEvent(-1,function(...)

if receiveState and loginState then
weekendBenifitsController:send_248_84(cfg.day)
end
end)

ceilItem:ForceLayoutRect(CmpCeilItemIndex.infoLayout)
end)
end



