







UIFullYiYuHuiYouController=gameState.addListener(fullScreenUI.create())

function UIFullYiYuHuiYouController:onAppStart()
local args={
fullType=FULL_TYPE.eYiYuHuiYou,
skinType=fullScreenSkinType.eSkin19,
}
self:initUI(args)
end


function UIFullYiYuHuiYouController:showMainWindow(guid)
local npcdata_single=YiYuHuiYouModel:getNPCIdlistbyGuid(guid)
YiYuHuiYouModel:setNPCId(npcdata_single.npcid)



local args={
showBg=true,
viewNames={'UIYYHYWin'},
viewArgs={['UIYYHYWin']={isFull=true}},
blurParams={showBlack=false}
}
self:showUI(args)

end


function UIFullYiYuHuiYouController:showMainWindowZhiYin(guid)
local npcdata_single=YiYuHuiYouModel:getNPCIdlistbyGuid(guid)
YiYuHuiYouModel:setNPCId(npcdata_single.npcid)



local args={
showBg=true,
viewNames={'UIYYHYWinzhiyin'},
viewArgs={['UIYYHYWinzhiyin']={isFull=true}},
blurParams={showBlack=false}
}
self:showUI(args)

end


function UIFullYiYuHuiYouController:showRewardWindow(id)
local cfg=cfgHelper.get1(cfg_wendouleitaiconfig_get,id)
local level=zongmenModel:getLevel()
local rewards=nil
for i,v in ipairs(cfg.winRewards)do
if v[1]<=level and v[2]>=level then
rewards=v[3]
break
end
end
local args={
title='胜利奖励',
rewardTitle="",
desc1=FMT.fmt('答对{0}题可获得以下奖励',cfg.spfNum[1]),
rewards=rewards,
showCancel=false,
commitName='确定',
}
self:showWindow('UIDialougeRewardWin',args)
end


function UIFullYiYuHuiYouController:showSelectWindow(args)
self:showWindow("UIPoetryArenaSelectWin",args)
end


function UIFullYiYuHuiYouController:checkCloseWindow(guid)
if fullScreenUI.checkFull(self)then
if self.guid==guid then
self:closeUI(true)
end
end
end


function UIFullYiYuHuiYouController:showCommonWindow(winName,params,showBlur,id,showBg,skinType)
if showBlur==nil then showBlur=false end
if showBg==nil then showBg=false end
if skinType==nil then skinType=fullScreenSkinType.eSkin5 end
local isFull=params.isFull
if isFull then
local viewNames
local viewArgs={}
if type(winName)=='table'then
viewNames=winName
for i,v in ipairs(viewNames)do
viewArgs[v]=params or{}
end
else
viewNames={winName}
viewArgs[winName]=params or{}
end
local args=
{
skinType=skinType,
showBg=showBg,
subFullType=fullScreenUI.getSubFullType(winName,id),
showBlur=showBlur,
moneyWinType=params.moneyWinType,
moneyArgs=params.moneytypes,
viewNames=viewNames,
viewArgs=viewArgs,
}
self:showUI(args)
else
UIManager:showWindow(winName,params)
end
end




function UIFullYiYuHuiYouController:jumpWorldYYHYWindow()

local npcdata=YiYuHuiYouModel:getNPCIdlist()
if not npcdata then
loggerUtil.logErrFMT("以渔会友npc列表为nil，请检测协议248-51下发,参数11")
end
if npcdata and#npcdata==0 then
loggerUtil.logErrFMT("以渔会友npc列表为nil，请检测协议248-51下发,参数11")
end
if npcdata and#npcdata>0 then
local npcdata_single=npcdata[1]
local unitKey=YiYuHuiYouModel:convertUnitKey(npcdata_single.guid)
local worldName=cfgHelper.get2(cfg_worldconfig_get,npcdata_single.world,'name')






























local isFirst_jump=userActorSetting.get('YiYuHuiYouGame_firstjump',false)
if not isFirst_jump then
weakGuideController:beginGuide(1169)
userActorSetting.set('YiYuHuiYouGame_firstjump',true)
userActorSetting.flush()
else
local args={lookAtUnit=unitKey}


local showCB=function()
end
mainControl:enterWorld({npcdata_single.world,args},function()

local callback=function()
local minZoom=worldController:getCameraZoomRange_Normal()[1]
worldController:lookAtUnit_Duration(unitKey,minZoom,0.25,showCB)
end
worldController:lookAtUnit(unitKey,nil,false,callback,DG.Tweening.Ease.OutQuart)
end)
end
end
end



function UIFullYiYuHuiYouController:jumpWorldYYHYWindowbyYuBi(args)
local npcdata=YiYuHuiYouModel:getNPCIdlist()

local actId=LIMIT_ACT_TYPE.eYiYuHuiYou
if limitActivitiesModel:checkActOpen(actId)and limitActivitiesModel:checkActDoing(actId)then
else
UIManager.error('以渔会友活动尚未开启')
return
end

if npcdata and#npcdata>0 then
if UIManager:isActive("UIBottomMaskYYHYWin")then
if mainControl:isInScene(eSceneType.eWorld)then
UIManager:closeWindow('UICommonPageWin')
UIManager.info("活动进行中")
return
end
end
local npcdata_single=npcdata[1]
local unitKey=YiYuHuiYouModel:convertUnitKey(npcdata_single.guid)

local isworld=worldModel:isSameWorld(npcdata_single.world)
if isworld then

local call=function()
if args.type==1 then
UIFullYiYuHuiYouController:showMainWindow(npcdata_single.guid)
YiYuHuiYouController.send_248_58({page=2})
else
if not UIManager:isActive("UIWorldUnitListWin2")then
worldController:changeLeftView("UIWorldUnitListWin2",{tab=6})
end
end
end
local callback=function()
local minZoom=worldController:getCameraZoomRange_Normal()[1]
worldController:lookAtUnit_Duration(unitKey,minZoom,0.25,call)
end
worldController:lookAtUnit(unitKey,nil,false,callback,DG.Tweening.Ease.OutQuart)
return
end


UIManager:closeWindow('UICommonPageWin')
local _args={lookAtUnit=unitKey}
mainControl:enterWorld({npcdata_single.world,_args},function()
if args.type==1 then
UIFullYiYuHuiYouController:showMainWindow(npcdata_single.guid)
YiYuHuiYouController.send_248_58({page=2})
else
worldController:changeLeftView("UIWorldUnitListWin2",{tab=6})
end
local callback=function()
local minZoom=worldController:getCameraZoomRange_Normal()[1]
worldController:lookAtUnit_Duration(unitKey,minZoom,0.25,nil)
end
worldController:lookAtUnit(unitKey,nil,false,callback,DG.Tweening.Ease.OutQuart)
end)
end
end



function UIFullYiYuHuiYouController:jumpWorldYYHYWindowbyTuJian(args)
local npcdata=YiYuHuiYouModel:getNPCIdlist()


local actId=LIMIT_ACT_TYPE.eYiYuHuiYou
if not limitActivitiesModel:checkActOpen(actId)then
UIManager.error('该鱼群未出没')
return
end

if npcdata and#npcdata>0 then
local index=0
if args and#args>0 then
for k,v in ipairs(npcdata)do
for i,j in ipairs(args)do
if v.npcid==j then
index=k
end
end
end
end
if index==0 then
UIManager.info('该鱼群未出没')
return
end

local npcdata_single=npcdata[index]


local isworld=worldModel:isSameWorld(npcdata_single.world)
if isworld then

return
end

local unitKey=YiYuHuiYouModel:convertUnitKey(npcdata_single.guid)
local worldName=cfgHelper.get2(cfg_worldconfig_get,npcdata_single.world,'name')

UIManager:closeWindow('UICommonPageWin')

































local isFirst_jump=userActorSetting.get('YiYuHuiYouGame_firstjump',false)
if not isFirst_jump then
weakGuideController:beginGuide(1169)
userActorSetting.set('YiYuHuiYouGame_firstjump',true)
userActorSetting.flush()
else
local args={lookAtUnit=unitKey}




local showCB=function()
end
mainControl:enterWorld({npcdata_single.world,args},function()

local callback=function()
local minZoom=worldController:getCameraZoomRange_Normal()[1]
worldController:lookAtUnit_Duration(unitKey,minZoom,0.25,showCB)
end
worldController:lookAtUnit(unitKey,nil,false,callback,DG.Tweening.Ease.OutQuart)
end)
end
end
end



function UIFullYiYuHuiYouController:closeYYHYwindow()
local win=UIManager:findActiveWindow('UIYYHYJieShuanWin')
if win then
win:onClosebtn1()
end
self:closeUI()
end

