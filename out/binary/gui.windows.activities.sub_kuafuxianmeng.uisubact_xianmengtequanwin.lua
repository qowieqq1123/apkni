







def_class("UISubAct_XianMengTeQuanWin",UIWindowBase)









function UISubAct_XianMengTeQuanWin:bindComponents()

self.effect=UIObject.get(self,0)
self.ListPanel=UIObject.get(self,1)
self.serverButton=UIButton.get(self,2)
self.libao=UIButton.get(self,3)
self.titlle=UIImage.get(self,4)
self.timeText=UIText.get(self,5)
self.libaoReddot=UIObject.get(self,6)

self.serverButton:setButtonClick(function()self:onServerButton()end)

self.libao:setButtonClick(function()self:onLibao()end)



end


function UISubAct_XianMengTeQuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.serverButton);self.serverButton=nil;
_UIObject_release(self.libao);self.libao=nil;
_UIObject_release(self.titlle);self.titlle=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.libaoReddot);self.libaoReddot=nil;
end



















local cmpIndex=
{
name=0,
desc=1,
time=2,
icon=3,
quality=4,
btn=5,
root=6,
}


function UISubAct_XianMengTeQuanWin:onLoaded(...)
self:bindComponents()
self.effect:setChildShowEffect(10521,true)
end


function UISubAct_XianMengTeQuanWin:__delete()
self:unbindComponents()
end




function UISubAct_XianMengTeQuanWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eXianMengTeQuan
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

self:setRemainingTimeTimer()
self:onRefresh()
end



function UISubAct_XianMengTeQuanWin:onRefresh()
local privilegeList=self.config.privilege
local privilegeShow=self.config.privilegeShow
local num=#privilegeList
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local list=data.list or{}
self.ListPanel:setChildLayoutGroupCreateItems(num)
local gridlist=self.ListPanel:getChildLayoutGroupGridList()
local c=gridlist.Count
local item=nil
local startTimer=false
for i=0,c-1 do
item=gridlist[i]
local privilege=privilegeList[i+1]
local privilegeType=privilege[3]
local showConfig=privilegeShow[privilegeType]
item:SetChildText(cmpIndex.desc,showConfig[2])
if privilege[3]==1 and(privilege[4]or 0)-(list[i+1]or 0)==0 then
item:SetChildText(cmpIndex.quality,FMT.fmt("免冷却次数:<color=#C82C2C>{1}</color>/{0}",privilege[4],(privilege[4]or 0)-(list[i+1]or 0)))
else
item:SetChildText(cmpIndex.quality,FMT.fmt(showConfig[3],privilege[4],(privilege[4]or 0)-(list[i+1]or 0)))
end


item:SetChildCSImageSprite(cmpIndex.icon,"ui/windows/activities/sub_kuafuxianmeng/xianmengtequan_atlas_pak.ab",FMT.fmt('image_kuafuxianmeng_ch{0}',showConfig[1]))

item:SetChildActive(7,showConfig[4]==1)

if privilege[1]>=0 then
startTimer=true
end

end

self.info:setAllShowReddot()

if self.daytimer then
self:stopTimerByID(self.daytimer)
self.daytimer=nil
end
if startTimer then
local today=self.info:getStart2NowDay()
local func=function()
local time=timeHelper.getServerShortTime()
local zeroTime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp()+86400)
for i=0,c-1 do
item=gridlist[i]
local privilege=privilegeList[i+1]
local startDay=privilege[1]
local endDay=privilege[2]


if startDay~=0 and endDay~=0 then
if startDay>today then
item:SetChildText(cmpIndex.time,"未开始")
elseif today>endDay then
item:SetChildText(cmpIndex.time,"已结束")
else
if today==endDay then
item:SetChildText(cmpIndex.time,timeHelper.format_time_stamp(zeroTime-time,true))
else
item:SetChildText(cmpIndex.time,timeHelper.format_time_stamp3((zeroTime+(endDay-today)*86400)-time,true))
end
end
else
local tq_start_time
local tq_end_time
local todayZeroTime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp())
local startTime=self.info.start_time
local endTime=self.info.end_time

if startDay==0 then
tq_start_time=startTime
else
tq_start_time=todayZeroTime+(startDay-1)*86400
end

if endDay==0 then
tq_end_time=endTime
else
tq_end_time=todayZeroTime+(endDay-1)*86400
end

local leftTime=tq_end_time-time
local rightTime=tq_start_time-time

local desc
if rightTime<=0 and leftTime>=0 then
if leftTime>=86400 then
desc=timeHelper.format_time_stamp3(leftTime,true)
else
desc=timeHelper.format_time_stamp(leftTime,true)
end
elseif rightTime>0 then
desc='未开启'
elseif leftTime<0 then
desc='已结束'
end
item:SetChildText(cmpIndex.time,desc)
end
end
end
self.daytimer=self:setTimer(1,-1,func)

end
self.serverButton:setActive(not self.config.shield_serverlist)
self.titlle:setCSImageSprite(self.config.title_param[1],self.config.title_param[2])

local isShowLiBao=false
if self.config.free_libao_id then
local data={self.actid,self.subType,self.subid}
isShowLiBao=FreeGiftController.GetFreeGift(self.config.free_libao_id,data)
end
self.libao:setActive(isShowLiBao)
end


function UISubAct_XianMengTeQuanWin:onHide()

end


function UISubAct_XianMengTeQuanWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshRemainingTimeTimer()
end

self.timer=self:setTimer(1,0,func)

self:refreshRemainingTimeTimer()
end


function UISubAct_XianMengTeQuanWin:refreshRemainingTimeTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actid,self.subType,self.subid)
if time>0 then

local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp11(time,true))
self.timeText:setText(time_str)
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()

end
end



function UISubAct_XianMengTeQuanWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end






function UISubAct_XianMengTeQuanWin:onServerButton()
self:showWindow("UISubAct_KuaFuLieBiaoWin")
end

function UISubAct_XianMengTeQuanWin:onLibao()
if self.config.free_libao_id then
self.info:reqFreeGift()
end
end

