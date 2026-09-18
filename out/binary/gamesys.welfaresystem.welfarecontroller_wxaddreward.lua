function welfareController:onAppStart_WXAddReward()
welfareModel:onAppStart_WXAddReward()
end

function welfareController:onEnterState_WXAddReward(isReconnet)
welfareModel:onEnterState_WXAddReward(isReconnet)
if not isReconnet then
notifySystem:listenNotify(notifyConfig.on_minigame_show,self.on_minigame_show)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end
end

function welfareController:onLeaveState_WXAddReward(isReconnet)
welfareModel:onLeaveState_WXAddReward(isReconnet)
if not isReconnet then
notifySystem:removelistener(notifyConfig.on_minigame_show,self.on_minigame_show)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
end
end

function welfareController:onProtocolReq_WXAddReward(isReconnet)
welfareModel:onProtocolReq_WXAddReward(isReconnet)
end

function welfareController:onServerDataInitFinish_WXAddReward()
welfareModel:onServerDataInitFinish_WXAddReward()
end

function welfareController:onLostConnection_WXAddReward()
welfareModel:onLostConnection_WXAddReward()
end

function welfareController.onNewDay_WXAddReward()

end

function welfareController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eWXAddReward then
webGLHelper:checkAndShowMGEntryIcon()
end
end

function welfareController:isAddRewardCanReceive()
local cfgs=welfareController:getAddRewardConfig()
for i,v in ipairs(cfgs)do
local giftId=v.giftId
local upgiftId=v.upgiftId
if FreeGiftController.GetFreeGift(giftId)or FreeGiftController.GetFreeGift(upgiftId)then
return true
end
end
return false
end


function welfareController:checkAlipayFirstRewardCanReceive()
local cfgs=welfareController:getAddRewardConfig()
for i,v in ipairs(cfgs)do
if v.jumpType==1 then
local giftId=v.giftId
local upgiftId=v.upgiftId
if FreeGiftController.GetFreeGift(giftId)or FreeGiftController.GetFreeGift(upgiftId)then
return true
end
end
end
return false
end

function welfareController:checkVerify()
if verifyManager:isOpen()and(webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative())then
return true
end

return false
end
function welfareController:getAddRewardConfig()
if webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative()then
if webGLHelper:isDouYin_HeTu()then
return cfg_douyinhetuaddrewardconfig()
end
return cfg_douyinaddrewardconfig()
elseif webGLHelper:isRunHuaWeiMiniGame()then
return cfg_huaweiaddrewardconfig()
elseif webGLHelper:isRunAlipayMiniGame()then
return cfg_alipayaddrewardconfig()
elseif webGLHelper:isRunKuaiShouMiniGame()then
return cfg_kuaishouaddrewardconfig()
elseif webGLHelper:isRunWeiXinTwo()then
return cfg_wechattwoaddrewardconfig()
elseif webGLHelper:isRunBzhan()then
return cfg_bzhanaddrewardconfig()
else
return cfg_wechataddrewardconfig()
end
end

function welfareController:checkWXAddRewardTabOpen(noCloseCheck)
if welfareController:checkVerify()then
return true
end
if not self:checkWXAddRewardOpen()then
return false
end

local config=welfareController:getAddRewardConfig()


if webGLHelper:isRunDouYin()or webGLHelper:isRunDouYinNative()then
if not noCloseCheck then
for i,v in ipairs(config)do
if v.dontClose then
return true
end
end
end
end
if webGLHelper:isRunBzhan()then
return true
end

for i,v in ipairs(config)do
local ftype=v.ftype or 0
if ftype==0 then
local giftId=v.giftId
if FreeGiftController.GetFreeGift(giftId)then
return true
end
local upgiftId=v.upgiftId
if FreeGiftController.GetFreeGift(upgiftId)then
return true
end
elseif ftype==1 then
if deviceHelper.getAPILevel()<360 then
return false
end
for i,v in ipairs(v.imageContent)do
local canRecv=FreeGiftController.GetFreeGift(v[2])
if canRecv then
return true
end
end
end
end
return false
end

function welfareController:checkWXAddRewardOpen()
if welfareController:checkVerify()then
return true
end
if not(webGLHelper:isRunMiniGame()or webGLHelper:isRunMGNative())and not deviceHelper.isRunEditor()then
return false
end
if webGLHelper:isRunAlipayMiniGame()then
if webGLHelper:getCreateRoleDay()>7 then
return false
end
end
return systemModel.isOpen(SYSTEM_DEFINE.eWXAddReward)
end

function welfareController:checkWXAddRewardReddot()
if welfareController:checkVerify()then
return true
end
if not self:checkWXAddRewardOpen()then
return false
end
local config=welfareController:getAddRewardConfig()
for i,v in ipairs(config)do









local ftype=v.ftype or 0
if ftype==0 then
local giftId=v.giftId
if FreeGiftController.GetFreeGift(giftId)then
return true
end
local upgiftId=v.upgiftId
if welfareModel:getWXEnterFlag(i)and FreeGiftController.GetFreeGift(upgiftId)then
return true
end
elseif ftype==1 then
if deviceHelper.getAPILevel()<360 then
return false
end
local enterIdStr=v.enterIdList[1]
local loginDays=webGLHelper:getEnterLoginDay(enterIdStr)
for i,v2 in ipairs(v.imageContent)do
local canRecv=FreeGiftController.GetFreeGift(v2[2])
if loginDays>=v2[1]and canRecv then
return true
end
end
end

end
return false
end

function welfareController.initWXEnter_ID(len,arr)



welfareModel:setWXAddRewardData(arr)
end

function welfareController.on_minigame_show(scene)
welfareController.checkWXAddReward()
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
UIManager:invokeUIMethod("UIWXAddRewardWin","refreshVerContent")
UIManager:invokeUIMethod("UIWXAddRewardWin","refreshItemContent")
end


function welfareController.setWXAddRewardData_Edtior(index,value)
if not deviceHelper:isRunEditor()then
return false
end
local data=welfareModel:getWXAddRewardData()
if not data then
UIManager.error("没有WXAddRewardData")
return
end
local config=welfareController:getAddRewardConfig()
for i,v in ipairs(config)do
if not data[i]then
data[i]=0
end
if i==index then
data[i]=value
end
end

serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.WXEnter_ID,#data,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eWelfare)
UIManager:invokeUIMethod("UIWXAddRewardWin","refreshVerContent")
UIManager:invokeUIMethod("UIWXAddRewardWin","refreshItemContent")
end


function welfareController.checkWXAddReward()
if not welfareController:checkWXAddRewardOpen()then
return
end
local data=welfareModel:getWXAddRewardData()
if not data then
return
end
local config=welfareController:getAddRewardConfig()
local needSave
if webGLHelper:isRunAlipayMiniGame()then
local query=webGLHelper:getQueryArgs()
local visitData=webGLHelper:getVisitResult()
for i,v in ipairs(config)do

if not data[i]then
data[i]=0
end
if data[i]==0 then
if(v.jumpType==1 and visitData.data.consult_result=='Y')
or(v.jumpType==2 and query.gameCenterBackFlow==true)then
needSave=true
data[i]=1
end
end
end
else

local scene=welfareModel:getWXEnterID()
for i,v in ipairs(config)do

if not data[i]then
data[i]=0
end

for ii,vv in ipairs(v.enterIdList)do

if vv==scene and data[i]==0 then
needSave=true
data[i]=1
end
end
end
end
if not needSave then
return
end

serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.WXEnter_ID,#data,data)
end

function welfareController.setWXSDKVersion(version)
welfareController.WXSDKVersion=version
end

function welfareController.getWXSDKVersion()
if not deviceHelper.isRunWeiXin()then
return welfareController.WXSDKVersion or"5.0.0"
end
local sysInfo=webGLHelper:getSystemInfoSync(true)
local versionStr=sysInfo.SDKVersion
return versionStr
end

