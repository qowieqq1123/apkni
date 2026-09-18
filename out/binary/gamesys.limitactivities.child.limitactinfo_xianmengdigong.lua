









local limitActInfo_xianmengdigong={name='xianmengdigong'}


function limitActInfo_xianmengdigong:onInit()
self:listenNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
end


function limitActInfo_xianmengdigong:onStart()
msgWinControl:addMsgWin(msgWinType.eXianMengDiGong,{act_id=LIMIT_ACT_TYPE.eXianMengDiGong})
end


function limitActInfo_xianmengdigong:onUpdate()
if self:checkDoing()then
if self.refreshRoomTimer==nil then
self.refreshRoomTimer=Time.realtimeSinceStartup
end
if self.eventRoomsLookup==nil then
self.eventRoomsLookup=xianmengdigongModel:getAllEventLookup_doing_idle()
end
if Time.realtimeSinceStartup-self.refreshRoomTimer>=5 then
self.refreshRoomTimer=Time.realtimeSinceStartup
local lp=xianmengdigongModel:getAllEventLookup_doing_idle()
local rooms={}
local temp={}
for roomid,num in pairs(lp)do
temp[roomid]=true
local num_=self.eventRoomsLookup[roomid]
if num_==nil or num_~=num then
rooms[roomid]=true
end
end
for roomid,num in pairs(self.eventRoomsLookup)do
if temp[roomid]==nil then
local num_=lp[roomid]
if num_==nil or num_~=num then
rooms[roomid]=true
end
end
end
self.eventRoomsLookup=lp
if next(rooms)then
UIManager:invokeUIMethod('UIXM_XMDG_MainWin','refreshEventBtn')
for roomid,v in pairs(rooms)do
UIManager:invokeUIMethod('UIXM_XMDG_MapWin','rec_roomEvent',roomid)
end
end
end
end
end

function limitActInfo_xianmengdigong:onFinish()
self.eventRoomsLookup=nil
self.refreshRoomTimer=nil
end


function limitActInfo_xianmengdigong:onDelete()
self.rewardlist=nil
end


function limitActInfo_xianmengdigong:checkReddot()
return xianmengdigongModel:getAllDGNoteReddot()or xianmengdigongModel:check_XMDG_shopManageReddot()or xianmengdigongModel:checkPassReddot()
end


function limitActInfo_xianmengdigong:jump(extraParams)
local isdong=self:checkDoing()
if isdong then
if not xianmengdigongModel:checkInitEx()then
return
end
end
if UIManager:findActiveWindow('UIFightPrepareLoading')then
return
end
extraParams=extraParams or{}
local cb=function(isFull)
local panelparams={}
panelparams.isFull=isFull
panelparams.extraParams=extraParams
UIFullCommonControl:showCommonWindow('UIXM_XMDG_MainWin',panelparams,true,nil,true,fullScreenSkinType.eSkin15)
xianmengdigongController:send_20_134()
end
local showCloud
local findTarget
if UIManager:findActiveWindow('UIXM_XMDG_MainWin')then
showCloud=false
else
showCloud=true
local has=false
if isdong then
local win=UIManager:findActiveWindow('UIXM_XMDG_MapWin')
if win then
findTarget=false
if not UIManager:isActive('UIXM_XMDG_MapWin')then
has=true
end
else
findTarget=true
end
else
local win=UIManager:findActiveWindow('UIXM_XMDG_MapNoneWin')
if win then
if not UIManager:isActive('UIXM_XMDG_MapNoneWin')then
has=true
end
end
end
if extraParams.showCloud==false then
if has then
showCloud=false
end
end
end
if showCloud then
if findTarget then
extraParams.movePos=xianmengdigongModel:getTargetRoomPos2()
end
local callback=function()
cb(true)

end
UIManager:showWindow("UIFightPrepareLoading",{para=1,startCallback=callback})
else
cb(true)
end
end

function limitActInfo_xianmengdigong:checkJump_time(isWarning)
if self:checkFinish()then
if isWarning then
UIManager.error('活动已结束')
end
return false
end
return true
end

function limitActInfo_xianmengdigong:onShowPrize(prizeType,temp,effectData)
if prizeType==ePrizeType.eXianMengDiGong then
self.rewardlist=temp
local data=xianmengdigongModel:getFastResultData()
if data then
local winArgs={
extraWin="UIXM_XMDG_resultWin",
extraParams={
data=data
},
isHideFightBtn=true,
callback=function()
UIManager:closeWindow("UICommonVictoryWin")
end,
}
UIManager:showWindow("UICommonVictoryWin",winArgs)
xianmengdigongModel:setFastResultData()
end
end
end

function limitActInfo_xianmengdigong:getRewardList()
return self.rewardlist or{}
end

return limitActInfo_xianmengdigong