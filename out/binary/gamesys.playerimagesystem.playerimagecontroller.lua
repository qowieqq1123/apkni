






local _MODULENAME="playerImageController"

gameState.addListener(def_table(_MODULENAME))
playerImageController.name=_MODULENAME
playerImageController.data={}

function playerImageController:onAppStart()

playerImageModel:onAppStart()



socketManager:register_receiver(254,64,playerImageController.recv_254_64)
socketManager:register_receiver(254,66,playerImageController.recv_254_66)
socketManager:register_receiver(254,65,playerImageController.recv_254_65)
socketManager:register_receiver(254,117,playerImageController.recv_254_117)
socketManager:register_receiver(254,118,playerImageController.recv_254_118)
socketManager:register_receiver(254,125,playerImageController.recv_254_125)
























notifySystem:listenNotify(notifyConfig.onNewWeek5am,self.eNewWeek5am)
end


function playerImageController:onEnterState(isReconnect)
playerImageModel:onEnterState()
if not isReconnect then
playerImageConfig:onReset()
end
self.unlockImageCall=nil
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
end


function playerImageController:onProtocolReq()
playerImageModel:onProtocolReq()
end


function playerImageController:onLeaveState(isReconnect)
playerImageModel:onLeaveState(isReconnect)
if not isReconnect then
playerImageConfig:onReset()
end

self.data={}
self.unlockImageCall=nil
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
end


function playerImageController:onLostConnection()

end


function playerImageController:onReConnection(isInitPro)

end

function playerImageController.eNewWeek5am()
playerImageModel:resetCnt()
UIManager:callWindowFunc('UIPlayerChangeImageWin','freshCost')
end







function playerImageController.recv_254_67(actorid,pilistlen,piList)

end











function playerImageController.recv_254_64(args)
playerImageModel:onInit(args)
UIManager:callWindowFunc('UIPlayerInfoWin','setModel')
notifySystem:postNotify(notifyConfig.onPlayerImageChanged,true)
end




function playerImageController.recv_254_66(pilistlen,piList)
playerImageModel:savePreviewPlayerImage()
playerImageModel:onSetPlayerImage(pilistlen,piList,playerImageController.send_254_66_hideTips)
if playerImageController.send_254_66_hideTips then
UIManager:callWindowFunc('UIPlayerChangeImageWin','changeNewModel')
UIManager:callWindowFunc('UIPlayerChangeImageWin','freshInfo')
else
UIManager:callWindowFunc('UIPlayerChangeImageWin','onSetPlayerImage')
end
UIManager:callWindowFunc('UIPlayerInfoWin','setModel')
notifySystem:postNotify(notifyConfig.onPlayerImageChanged,false)
if not playerImageController.send_254_66_hideTips then
UIManager.info('已成功重塑肉身')
else
playerImageController.send_254_66_hideTips=nil
end
end




function playerImageController.recv_254_65(len,list,duration)
playerImageModel:onUnlockImage(len,list,duration)
UIManager:callWindowFunc('UIPlayerChangeImageWin','onUnlockRet',list)

if playerImageController.unlockImageCall then
playerImageController.unlockImageCall()
end
playerImageController.unlockImageCall=nil
UIManager:callWindowFunc('UIPlayerInfoWin','refreshImageReddot')
UIManager:callWindowFunc('UIMain','refreshActorHeadReddot')
end



function playerImageController.recv_254_117(suitid)
playerImageModel:setSuitAttrActiveState(suitid,true)
playerImageController.SuitActiveStateChange()
UIManager:callWindowFunc('UIPlayerChangeSuitWin','playEffect')
end



function playerImageController.recv_254_118(suitid)
playerImageModel:setSuitAttrActiveState(suitid,false)
playerImageController.SuitActiveStateChange()
end


function playerImageController.recv_254_125(result,changeSex)
if result==0 then
playerModel:setActorSex(changeSex)
UISettingModel:initHeadCfg()
UIManager:callWindowFunc('UIPlayerInfoWin','refreshChangeSex')
notifySystem:postNotify(notifyConfig.onPlayerImageChanged,false)
end
end

function playerImageController:reqUnlockImage(array,call)
if array==nil or#array==0 then return end
local args={}
for i,v in ipairs(array)do
args[#args+1]={v[1],v[2]}
end
socketManager:send_254_65(#args,args)
self.unlockImageCall=call
end

function playerImageController:reqSetPlayerImage(array,hideTips)
local len=#array
local has=false
for i,v in ipairs(array)do
has=has or not playerImageModel:isImageEnable(i,v)
end

if has then
playerImageController.send_254_66_hideTips=hideTips
socketManager:send_254_66(len,array)
else
UIManager.error('当前形象未发生改变')
end
end

function playerImageController:reqWatchPlayerImage(actorid)
socketManager:send_254_67(actorid)
end

function playerImageController:reqWatchKuaFuPlayerImage(serverid,actorid)
socketManager:send_254_68(serverid,actorid)
end



function playerImageController:reqActiveSuitAttr(suitId)
socketManager:send_254_117(suitId)
end



function playerImageController:reqSuitAttrOverTime(suitId)
socketManager:send_254_118(suitId)
end


function playerImageController:reqChangeSex()
socketManager:send_254_125()
end



function playerImageController.getPlayerImageSuitAni(playerImage,sex)
local suitid=playerImageModel:getFullSuit(playerImage,sex)
if suitid then
return cfgHelper.get2(cfg_playersuitconfig_get,suitid,'ani')
end
end


function playerImageController.setPlayerModel(widget,index,playerImage,scale,ani,offsetX,offsetY,dynamic,action,enableFadeCompatible)
playerImage=playerImage or playerImageModel:getPlayerImage()

local sex
for tabid,id in pairs(playerImage)do
local cfg=playerImageConfig.getSubConfig(tabid,id)
if cfg then
sex=cfg.sex
break
end
end

for k,v in pairs(PLAYER_IMAGE_TYPE)do
if playerImage[v]==nil then
playerImage[v]=playerImageConfig.getDefaultImage(v,sex)
end
end




comHelper.setChildPlayerImage(widget,index,playerImage,sex,scale,ani,offsetX,offsetY,dynamic,action,enableFadeCompatible)
end

function playerImageController.setPlayerRawImage(widget,index,playerImage,scale,ani,offsetX,offsetY,headCenterType,size,gray,dynamic)
playerImage=playerImage or playerImageModel:getPlayerImage()

local sex
for tabid,id in pairs(playerImage)do
local cfg=playerImageConfig.getSubConfig(tabid,id)
if cfg then
sex=cfg.sex
break
end
end

for k,v in pairs(PLAYER_IMAGE_TYPE)do
if playerImage[v]==nil then
playerImage[v]=playerImageConfig.getDefaultImage(v,sex)
end
end
comHelper.setChildPlayerRawImage(widget,index,playerImage,sex,scale or 1,ani or 0,offsetX or 0,offsetY or 0,headCenterType,size,gray,dynamic)
end

function playerImageController.getSuitImageList(itemIdList)
local sex=playerModel:getActorSex()
local playerImageList=playerImageModel:getDefaultImage(sex)
for k,itemid in pairs(itemIdList)do
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.funcparam and itemCfg.funcparam.list then
for _,partData in pairs(itemCfg.funcparam.list[sex])do
playerImageList[partData[1]]=partData[2]
end
end
end
return playerImageList
end

function playerImageController.SuitActiveStateChange()
UIManager:callWindowFunc('UIPlayerChangeSuitWin','activeStateChange')
UIManager:callWindowFunc('UIPlayerInfoWin','refreshImageReddot')
UIManager:callWindowFunc('UIMain','refreshActorHeadReddot')
UIManager:callWindowFunc('UIPlayerChangeImageWin','refreshSuitReddot')
end

function playerImageController:on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
local lookupActiveItem=playerImageModel:getLookupActiveItem()
if lookupActiveItem[itemid]then
playerImageController.SuitActiveStateChange()
end
end
