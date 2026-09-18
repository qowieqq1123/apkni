






local _MODULENAME="ChangeActController"

gameState.addListener(def_table(_MODULENAME))
ChangeActController.name=_MODULENAME
ChangeActController.data={}

local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString

function ChangeActController:onAppStart()
ChangeActModel:onAppStart()

end


function ChangeActController:onEnterState(isReconnect)
ChangeActModel:onEnterState()
if not isReconnect then
self.hdguid=nil
end
end


function ChangeActController:onProtocolReq()
ChangeActModel:onProtocolReq()
self:requestRuKou()
end


function ChangeActController:onLeaveState(isReconnect)
ChangeActModel:onLeaveState(isReconnect)
if not isReconnect then
self.hdguid=nil
end

self.data={}
end


function ChangeActController:onLostConnection()

end


function ChangeActController:onReConnection(isInitPro)

end


function ChangeActController:setTransferActdata(data)

if data then
self.data.is_open=data.is_open and tonumber(data.is_open)
self.data.begin_time=data.begin_time and tonumber(data.begin_time)
self.data.is_converted_package=data.is_converted_package and tonumber(data.is_converted_package)
self.data.show_text=data.show_text
self.data.show_text_color=data.show_text_color
self.data.show_text_blink=data.show_text_blink and tonumber(data.show_text_blink)

self:freshEntry()
end
end

function ChangeActController:getis_open()
return self.data.is_open
end

function ChangeActController:getbegin_time()
return self.data.begin_time
end

function ChangeActController:getis_converted_package()
return self.data.is_converted_package or 0
end

function ChangeActController:getshow_text()
return self.data.show_text
end

function ChangeActController:getshow_text_color()
return self.data.show_text_color
end

function ChangeActController:getshow_text_blink()
return self.data.show_text_blink
end

function ChangeActController:testsetdata(arry)
self.data.test=arry
end
function ChangeActController:testgetdata()
return self.data.test
end


function ChangeActController:testjiekou(arry)

local temptest=
{
is_open=arry[1]or 1,
begin_time=arry[2]or 1752897013,
is_converted_package=arry[3]or 0,
show_text=arry[4]or"请关注微信公众号\nzuiqiangzhushi\n换端领取专属福利",
show_text_color=arry[5]or"10,23,#549327",
show_text_blink=arry[6]or 1,
}
ChangeActController:setTransferActdata(temptest)
end


function ChangeActController:requestRuKou()

if pfwindowslController:checkIsGameVersion_guofu()then
loginControl:requestTransferActURL()
end
end

function ChangeActController:checkHDisOpen()
local isopen=false
local isopen1=self:getis_open()
if not isopen1 then
return false
end
local begin_time=self:getbegin_time()
if not begin_time then
return false
end
local isopenlb2=self:checkIsOpenByLiBao()
local isopenalllb=self:checkIsGetAllByLiBao()
if isopenalllb then
return false
end
if isopen1==1 or isopenlb2 then
isopen=true
end
return isopen
end

function ChangeActController:freshEntry()
local isopen=self:getis_open()
if not isopen then
return false
end
local begin_time=self:getbegin_time()
if not begin_time then
return false
end
local isopenlb=self:checkIsOpenByLiBao()
local isopenalllb=self:checkIsGetAllByLiBao()

if isopenalllb then
if self.hdguid then
enterManager:removeEnter(self.hdguid)
self.hdguid=nil
end
return
end
if isopen==1 or isopenlb then
if self.hdguid==nil then
self.hdguid=enterManager:freshEnter({enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eChangeAct})
end
else
if self.hdguid then
enterManager:removeEnter(self.hdguid)
self.hdguid=nil
end
end
end

function ChangeActController:freshReddot()
if self.hdguid then
enterManager:freshFunc('freshReddot',ENTER_TYPE.eChangeAct)
end
end

function ChangeActController:checkIsOpenByLiBao()
local isopen=false
local hdcfg=cfg_huanduanconfig_get(1)
local freelsit=hdcfg.freelsit
if freelsit and#freelsit>0 then
















for i=1,#freelsit do
local slbid=freelsit[i]
isopen=FreeGiftController.GetFreeGift(slbid)
if not isopen then
break
end
end
end
return not isopen
end

function ChangeActController:checkIsGetAllByLiBao()
local isopen=true
local hdcfg=cfg_huanduanconfig_get(1)
local freelsit=hdcfg.freelsit
if freelsit and#freelsit>0 then
for i=1,#freelsit do
local slbid=freelsit[i]
isopen=FreeGiftController.GetFreeGift(slbid)
if isopen then
break
end
end
end
return not isopen
end

function ChangeActController:checkHdReddotSingle(selectid)
local isget=false
local begin_time=ChangeActController:getbegin_time()
if not begin_time then
return false
end
local passDay=timeHelper.getPassDay(timeHelper.convertLongStamp(begin_time))
local nowdayidx=selectid
if passDay+1>=nowdayidx then
isget=true
end
return isget
end

function ChangeActController:checkCanGet(selectid)
local isget=false
local begin_time=ChangeActController:getbegin_time()
if not begin_time then
return false
end
local passDay=timeHelper.getPassDay(begin_time)
local nowdayidx=selectid
if passDay>=nowdayidx then
isget=true
else
local todayLeft=timeHelper.getServerTodayLeft()
local nextday=(nowdayidx-2)*86400
local needtime=todayLeft+nextday
if needtime<=0 then
isget=true
end
end
return isget
end

function ChangeActController:checkHdReddotAll()
local reddot=false
local isopen=self:getis_open()
if not isopen then
return false
end
local isopenlb=self:checkIsOpenByLiBao()
local isopenalllb=self:checkIsGetAllByLiBao()
if isopenalllb then
return false
end
if isopen==1 or isopenlb then
local hdcfg=cfg_huanduanconfig_get(1)
local freelsit=hdcfg.freelsit
if freelsit then
for k,v in ipairs(freelsit)do
local libid=v
local iscanget=FreeGiftController.GetFreeGift(libid)
if iscanget then
local isgettime=self:checkCanGet(k)
if isgettime then
reddot=true
end
end
end
end
end
return reddot
end



function ChangeActController:checkHBZYOpen()


local hdcfg=cfg_huanbaozhiyinconfig_get(1)
local slbid=hdcfg.freelsit
if slbid then
local isCanGetGift=FreeGiftController.GetFreeGift(slbid)
if not isCanGetGift then
return false
end
end
local isopen=self:checkConditionHB()
return isopen


end

function ChangeActController:checkConditionHB()
local versionId=pfwindowslController:getGameVersion()
if not versionId then return false end
local config=cfg_huanbaozhiyinconfig_get(versionId)
if not config then return false end

local condition=config.condition
local flag=true
if condition then
for k,v in ipairs(condition)do
local type=v[1]
if type==1 then
local parem=v[2]
if zongmenModel:getLevel()<parem then
flag=false
break
end
elseif type==2 then
local parem=v[2]
if timeHelper.getServerOpenDay()<parem then
flag=false
break
end
elseif type==3 then
local startTime=v[2]
local endTime=v[3]
local startStamp=timeHelper.getDateStamp(startTime)
local endStamp=timeHelper.getDateStamp(endTime)
local stamp=timeHelper.getServerLongTime()
if stamp>=startStamp and endStamp>=stamp then
else
flag=false
break
end
elseif type==4 then
local pfid=loginModel:getPfid()
local platform=v[2]
if platform and pfid and platform[pfid]then
else
flag=false
break
end
elseif type==5 then
local pfid=loginModel:getPfid()
local platform=v[2]
if not platform or platform[pfid]then
flag=false
break
end
end
end
else
flag=false
end
return flag
end

function ChangeActController:checkHBZYReddot()
if not self:checkHBZYOpen()then
return false
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eHanBaoZhiYin)
if not flag then
return true
end
local versionId=pfwindowslController:getGameVersion()
local config=cfg_huanbaozhiyinconfig_get(versionId)
if config then
local libaoid=config.freelsit
local isCanGetGift=FreeGiftController.GetFreeGift(libaoid)
local checkapi=config.checkapi
local api=deviceHelper.getAPILevel()
if isCanGetGift and api>=checkapi then
return true
end
end
return false
end




