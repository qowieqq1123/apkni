









local limitActInfo_tianyuanshouchao={name='tianyuanshouchao'}


function limitActInfo_tianyuanshouchao:onInit()
self:listenNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
end


function limitActInfo_tianyuanshouchao:onStart(isNew,isReconnect)
if not isNew and not isReconnect then

if self:checkOpen()and xianmengModel:hasXM()then
xianmengController:send_248_11()
end
end
xianmengModel:clearBossLookFlag(self.start_time,self.end_time)
end


function limitActInfo_tianyuanshouchao:onUpdate()

end


function limitActInfo_tianyuanshouchao:onDelete()
self:clearRewardList()
end


function limitActInfo_tianyuanshouchao:checkReddot()
if self:checkOpen()and xianmengModel:hasXM()then
return xianmengModel:checkReddot_TYSC()
end
return false
end

function limitActInfo_tianyuanshouchao:checkJump_time(isWarning)
if self:checkFinish()then
if isWarning then
UIManager.error('活动已结束')
end
return false
end
return true
end

function limitActInfo_tianyuanshouchao:checkJump_data(isWarning)
if self:checkDoing()then
if not xianmengModel:checkInit_TYSC()then



return false
end
if not xianmengModel:checkInitMonster_TYSC()then



logErr('兽潮怪物数据还没准备好，请稍后再尝试！')
return false
end
else
if not xianmengModel:checkInit_TYSC()then



return false
end
end
return true
end



function limitActInfo_tianyuanshouchao:jump(extraParams)
local closeCloud=extraParams~=nil and extraParams.closeCloud or false
local panelparams={}
if extraParams and extraParams.Callback then
panelparams.Callback=extraParams.Callback
end
panelparams.isFull=true
local panelname
if self:checkDoing()then
panelname='UIXM_TYSC_BattleWin'
else
panelname='UIXM_TYSC_MainWin'
end
UIFullCommonControl:showCommonWindow(panelname,panelparams,nil,nil,true,fullScreenSkinType.eSkin15,true)
if closeCloud then
loadingControl.closeCloud()
end
end

function limitActInfo_tianyuanshouchao:onShowPrize(prizeType,temp,effectData)
if prizeType==ePrizeType.eTianYuanShouChao then
self.rewardlist=temp
elseif prizeType==ePrizeType.eTianYuanShouChao2 then
self.rewardlist2=temp
end
end

function limitActInfo_tianyuanshouchao:clearRewardList()
self.rewardlist=nil
self.rewardlist2=nil
end

function limitActInfo_tianyuanshouchao:getRewardList()
return table.concatTableX(self.rewardlist,self.rewardlist2)or{}
end


function limitActInfo_tianyuanshouchao:SetRewardFlag()
self.quickrewardflag=true
end
function limitActInfo_tianyuanshouchao:GetRewardFlag()
return self.quickrewardflag
end

return limitActInfo_tianyuanshouchao
