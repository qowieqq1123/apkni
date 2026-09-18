







def_class("UIXianJie_emptyPosWin",UIWindowBase)









function UIXianJie_emptyPosWin:bindComponents()

self.costTimeItem=UIObject.get(self,0)
self.mask=UIButton.get(self,1)
self.moveXMBtn=UIButton.get(self,2)
self.moveXMCost=UILinkImageText.get(self,3)
self.moveZM=UIObject.get(self,4)
self.moveZMBtn=UIButton.get(self,5)
self.moveZMTimeTxt=UIText.get(self,6)
self.posTxt=UIText.get(self,7)
self.recordBtn=UIButton.get(self,8)
self.root=UIObject.get(self,9)
self.ruleBtn=UIButton.get(self,10)
self.shareBtn=UIButton.get(self,11)
self.stationBtn=UIButton.get(self,12)
self.xgTqInfo=UIBaseItem.get(self,13)
self.xjbjbtn=UIButton.get(self,14)
self.xksTqIcon=UIObject.get(self,15)
self.xksTqTims=UIText.get(self,16)
self.xmItem=UIObject.get(self,17)

self.mask:setButtonClick(function()self:onMask()end)

self.moveXMBtn:setButtonClick(function()self:onMoveXMBtn()end)

self.moveZMBtn:setButtonClick(function()self:onMoveZMBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.stationBtn:setButtonClick(function()self:onStationBtn()end)

self.xjbjbtn:setButtonClick(function()self:onXjbjbtn()end)



end


function UIXianJie_emptyPosWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costTimeItem);self.costTimeItem=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.moveXMBtn);self.moveXMBtn=nil;
_UIObject_release(self.moveXMCost);self.moveXMCost=nil;
_UIObject_release(self.moveZM);self.moveZM=nil;
_UIObject_release(self.moveZMBtn);self.moveZMBtn=nil;
_UIObject_release(self.moveZMTimeTxt);self.moveZMTimeTxt=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.stationBtn);self.stationBtn=nil;
_UIObject_release(self.xgTqInfo);self.xgTqInfo=nil;
_UIObject_release(self.xjbjbtn);self.xjbjbtn=nil;
_UIObject_release(self.xksTqIcon);self.xksTqIcon=nil;
_UIObject_release(self.xksTqTims);self.xksTqTims=nil;
_UIObject_release(self.xmItem);self.xmItem=nil;
end
















local _this


function UIXianJie_emptyPosWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
end


function UIXianJie_emptyPosWin:__delete()
_this=nil
self:clearMgReadyTimer()
self:unbindComponents()
if self.m_entKey then
xianjieController:removeEntity(self.m_entKey)
self.m_entKey=nil
end
xianjieController:closeWin2('UIXianJie_emptyPosWin')
end


function UIXianJie_emptyPosWin:onHide()

end



function UIXianJie_emptyPosWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXianJie_emptyPosWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end






function UIXianJie_emptyPosWin:onShow(argtable,afterOnloaded)
self.curPos=argtable.pos
self.sharex=self.curPos[1]
self.sharez=self.curPos[2]
self.curPos_c=argtable.pos_c
self.width=argtable.width
self.height=argtable.height
self:refreshPosEntity()
self:refreshInfo()


if systemModel.isOpen(SYSTEM_DEFINE.eXianJieBiaoJi)then
self.xjbjbtn:setActive(false)
local actorid=playerModel:getActorID()
local pos=xianmengModel:getXMMemberPost(actorid)
if pos then
if pos==GUILD_POST_TYPE.gpAllyLeader or pos==GUILD_POST_TYPE.gpViceLeader then
self.xjbjbtn:setActive(true)
end
end
else
self.xjbjbtn:setActive(false)
end
end

function UIXianJie_emptyPosWin:onShowArgRecv(argtable)
self.curPos=argtable.pos
self.sharex=self.curPos[1]
self.sharez=self.curPos[2]
self.curPos_c=argtable.pos_c
self:refreshPosEntity()
self:refreshInfo()
end

function UIXianJie_emptyPosWin:refreshPosEntity()
local gridX=self.curPos[1]
local gridZ=self.curPos[2]
local m_entKey=self.m_entKey
if m_entKey then
local ent=xianjieController:getEntity(m_entKey)
if ent then
ent:refreshPos(gridX,gridZ)
else
self.moveEntKey=nil
end
else
self.m_entKey=xianjieController:addEntity(XJ_ENTITY_TYPE.eEmptyPos,{gridX,gridZ,self.width,self.height},true)
end
end

function UIXianJie_emptyPosWin:refreshInfo()

local pos_str=FMT.fmt('（X:{0},Y:{1}）',self.sharex,self.sharez)
self.posTxt:setText(pos_str)


local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isOhterXianYu(sceneidx)then

self.costTimeItem:setActive(false)
else
self.costTimeItem:setActive(true)
local costTimeWidget=self.costTimeItem:getWidgetBase()
local gridX_c=self.curPos_c[1]
local gridZ_c=self.curPos_c[2]
local speed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eStation,1)
local wayTime=xianjieModel:getZongMenToPosWayTime(sceneidx,gridX_c,gridZ_c,speed,nil,nil,nil)
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
costTimeWidget:SetChildText(0,time_str)
end


local xmData=nil
local hasXM=xmData~=nil
local xmWidget=self.xmItem:getWidgetBase()
xmWidget:SetChildActive(1,hasXM)
xmWidget:SetChildActive(4,hasXM)
local xmName_str
if hasXM then
xmName_str=xmData.guildname
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

xmWidget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

xmWidget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

xmWidget:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))


local guildid=xmData.guildid
xmWidget:SetChildButtonClick(4,function()
return xianmengController:openXMDetailInfoWin(guildid)
end,true)
else
xmName_str='无'
end
xmWidget:SetChildText(0,xmName_str)


local sceneidx=xianjieModel:getSceneIndex()
local isshow=not xianjienSceneIndexType:isOhterXianYu(sceneidx)

self.moveZMBtn:setActive(isshow)

local moveBuff
local mgReady
if isshow==true then
if xianjienSceneIndexType:isMoJie(sceneidx)then
local flag,lp=xianjieModel:getBuffIDsByBuffType(xjBuffEffectType.eCantLeaveSafeArea)
if flag==true then

local zmData=xianjieModel:getMyZongMenData()
local r_areaID=zmData:getBornAreaID()
local gridX=self.curPos[1]
local gridZ=self.curPos[2]
local t_areaID=xianjieModel:checkMapGridDataAreaID(sceneidx,gridX,gridZ)
if r_areaID~=t_areaID then
moveBuff=true
end
end
end
if xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)then
mgReady=moGongZhengDuoActModel:checkInReadyTime()
end
self.moveZMBtn:setChildImageExGray(moveBuff==true or mgReady==true)
self.moveZMTimeTxt:setActive(moveBuff==true or mgReady==true)
end
if moveBuff==true then
if self.moveBuffTimer==nil then
self.moveBuffTimer=self:setTimer(1,0,function()
self:refreshBuffTimer()
end)
self:refreshBuffTimer()
end
else
self:clearMoveBuffTimer()
end

if mgReady==true then
if self.mgReadyTimer==nil then
self.mgReadyTimer=self:setTimer(1,0,function()
self:refreshMgReadyTimer()
end)
self:refreshMgReadyTimer()
end
else
self:clearMgReadyTimer()
end

self.stationBtn:setActive(isshow)

local tqId=XIANGUAN_PRIVILEGE_ENUM.eYiTianYiRi
local isShowPrivilege=xianguanController:checkSelfHasTeQuanByType(tqId,XIANGUAN_TYPE_ENUM.eYiTianShenJiang)and xianguanHelper.checkSpecialUseCondition(XIANGUAN_TYPE_ENUM.eYiTianShenJiang,tqId)
self.xgTqInfo:setActive(isShowPrivilege)
if isShowPrivilege then
local maxTimes=xianguanConfig.getTeQuanCfg(tqId,'times')
local xgInfo=xianguanController:getSelfHasTeQuanByType(tqId,XIANGUAN_TYPE_ENUM.eYiTianShenJiang)
local curTimes=xianguanModel:callTeQuanObjFunc(xgInfo.jobId,tqId,"getTimes")
local color=maxTimes>curTimes and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
local desc=FMT.fmt("免费次数：<color={0}>{1}/{2}</color>",FONT_COLOR_VAL[color],maxTimes-curTimes,maxTimes)
self.xksTqTims:setText(desc)

local icon=xianguanConfig.getTeQuanCfg(tqId,'icon')
local iconName=xianguanConfig.getTeQuanIconName(icon)
self.xksTqIcon:setChildIcon(iconName,false)

local tipsClick=function()
local posVector2=self.xksTqIcon:getChildScreenPointToLocalPointRectangle()
local pos={posVector2.x,posVector2.y}
local offset={-200,85}
local args={
privilegeId=tqId,
}
UIManager:showWindow("UIXianGuanPrivilegeTipsWin",{pos=pos,showData=args,offset=offset,arrowType=2,})
end
self.xgTqInfo:setBaseItemClickEvent(tipsClick)
end

local showXM=xianjieModel:isInMoJie()and isshow and xianmengModel:hasXM()and xianjieModel:getMoJieEnterConfig('guild')==true and xianmengModel:checkPostSelfPrivile(GUILD_PRIVILE_TYPE.gptDevildom)
self.moveXMBtn:setActive(showXM)
if showXM then
local costStr=""
self.moveXMCost:setText(costStr)
end
end

function UIXianJie_emptyPosWin:refreshBuffTimer()
local flag,lp=xianjieModel:getBuffIDsByBuffType(xjBuffEffectType.eCantLeaveSafeArea)
local ltime

local sceneidx=xianjieModel:getSceneIndex()
local isInBornArea=true
if xianjienSceneIndexType:isMoJie(sceneidx)then
local zmData=xianjieModel:getMyZongMenData()
local r_areaID=zmData:getBornAreaID()
local gridX=self.curPos[1]
local gridZ=self.curPos[2]
local t_areaID=xianjieModel:checkMapGridDataAreaID(sceneidx,gridX,gridZ)
if r_areaID~=t_areaID then
isInBornArea=false
end
end

if flag==true and not isInBornArea then
for buffID,_ in pairs(lp)do
local ltime_=xianjieModel:getBuffLeftTime(buffID)
if ltime_>0 then
if ltime==nil or ltime_>ltime then
ltime=ltime_
end
end
end
end
if ltime~=nil and ltime>0 then
self.moveBuffLeftTime=ltime
self.moveZMTimeTxt:setText(timeHelper.format_time_stamp3(ltime))
else
self.moveZMBtn:setChildImageExGray(false)
self.moveZMTimeTxt:setActive(false)
self:clearMoveBuffTimer()
end
end

function UIXianJie_emptyPosWin:clearMoveBuffTimer()
self.moveBuffLeftTime=nil
if self.moveBuffTimer~=nil then
self:stopTimerByID(self.moveBuffTimer)
self.moveBuffTimer=nil
end
end

function UIXianJie_emptyPosWin:refreshMgReadyTimer()
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eMoGongZhengDuo)
local nowTime=timeHelper.getServerShortTime()
local readyTime=moGongZhengDuoActModel:getBaseConfig('readyTime')
local endTime=actInfo.start_time+readyTime
local left=endTime-nowTime

nowTime=timeHelper.getServerShortTime()
left=endTime-nowTime
if left>=0 then
self.moveZMTimeTxt:setText(timeHelper.format_time_stamp3(left))
else
self.moveZMBtn:setChildImageExGray(false)
self.moveZMTimeTxt:setActive(false)
self:clearMgReadyTimer()
end
end

function UIXianJie_emptyPosWin:clearMgReadyTimer()
if self.mgReadyTimer~=nil then
self:stopTimerByID(self.mgReadyTimer)
self.mgReadyTimer=nil
end
end

function UIXianJie_emptyPosWin:onMoveZMBtn()
if self.moveBuffLeftTime~=nil then
local str=FMT.fmt('{0}后可迁移出仙域本阵',timeHelper.format_time_stamp3(self.moveBuffLeftTime))
UIManager.error(str)
return
end

local sceneidx=xianjieModel:getSceneIndex()
if sceneidx==xianjienSceneIndexType.eXianJie then
if not seasonController:checkSeasonStageBegined(0,7)then

local seasonName=seasonModel:getHandleConfig(0,"name")
local stageName=seasonModel:getStageConfigEx(0,7,"name")
return UIManager.error(FMT.fmt("开启【{0}·{1}】后方可在本场景迁移",seasonName,stageName))
end
end

local gridX=self.curPos[1]
local gridZ=self.curPos[2]
if xianjienSceneIndexType:isMoJie(sceneidx)then
local isUnLockFog=xianjieController:checkMoJiePosOpenFog(sceneidx,gridX,gridZ)
if not isUnLockFog then
UIManager.info("该区域暂被迷雾笼罩")
return
end
end

local gridX_c=self.curPos_c[1]
local gridZ_c=self.curPos_c[2]
local gridX_c_,gridZ_c_,sceneidx_,bornAreaID=xianjieModel:getZongMenWorldGridCenterPos()
local flag,g_list=xianjieController:checkMovePath(bornAreaID,sceneidx_,gridX_c_,gridZ_c_,sceneidx,gridX_c,gridZ_c,true,nil,true)
if not flag then
local gateId=g_list and g_list[1]or nil
if gateId then
local content="是否前往最近的关口？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
return xianjieController:jumpMoJieGateByGateId(gateId)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
return
end


local isWaiPai=xianjieModel:checkIsWaiPaiIng(sceneidx)
if not isWaiPai then
UIManager.error('行军中，不可迁移宗门')
return
end

if xianjienSceneIndexType:isMoGongZhengDuo(sceneidx)and moGongZhengDuoActModel:checkInReadyTime()then
UIManager.error('准备阶段期间无法迁移')
return
end

local buffList=xianjieModel:getBuffList()
local nowTime=timeHelper.getServerShortTime()
for index,buffData in pairs(buffList)do
local buffId=buffData.buffid
local endsec=buffData.endsec
if nowTime<endsec then
local buffCfg=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffId)
for i,v in pairs(buffCfg.effects)do
local effectType=v[1]
if effectType==xjBuffEffectType.eBanMoveZongMen then
UIManager.error(FMT.fmt("宗门封锁中无法迁城"))
return
end
end
end
end












local content='有队伍正赶往本宗门，现在迁移宗门,攻击本宗门的队伍将立即到达发起进攻，援助本宗门队伍将返回，是否继续？'
local gridX=self.curPos[1]
local gridZ=self.curPos[2]

local isAttack=false
local curSceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(curSceneidx)then
isAttack=xianjieModel:isZMUnderAttack_TabType(ATTACKTABTYPE.eMJ)
else
isAttack=xianjieModel:isZMUnderAttack_TabType(ATTACKTABTYPE.eXJ)
end

local field=function(marchTeamData)
local isInSameScene=false
if xianjienSceneIndexType:isMoJie(curSceneidx)then
isInSameScene=xianjienSceneIndexType:isMoJie(marchTeamData.tarsceneidx)
else
isInSameScene=not xianjienSceneIndexType:isMoJie(marchTeamData.tarsceneidx)
end

return playerModel:checkActorId(marchTeamData.srcactorid)and isInSameScene
end
local isYuanZhu=xianjieModel:isExistMatrchTeamData(xjServerMarchType.eYuanZhu,field)

local callback=function()
xianjieModel:enterSceneState(xjSceneStateType.eMoveZongMen,gridX,gridZ,self.width,self.height)
xianjieController:closeWin3()
end

if isAttack or isYuanZhu then
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=callback,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
callback()
end
end

function UIXianJie_emptyPosWin:onRecordBtn()
local temp=
{
gridX=self.sharex,
gridZ=self.sharez,
Point_Share=xianjie_Point_Share.kongdi,
nameStr="空地",
sharename="空地",
ishujian=true,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end

function UIXianJie_emptyPosWin:onShareBtn()
local _sceneType=xianjieModel:getScenceType()
local data=
{
x=self.sharex,
y=self.sharez,
icon1="icon_sjgdbiaoshi_1",
msgName="空地",
shareType=xianjie_Point_Share.kongdi,
scenceType=_sceneType,
name="空地",
shareName="空地",
}
local str=xianjieController:getShareStr(data)
str=chatLinkHelper.clearLink(str)
local sceneidx=xianjieModel:getSceneIndex(_sceneType)
local jsonStr=jsonHelper.encode({data.shareType,data.shareName,sceneidx,data.x,data.y})
local args={
channels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.eXianmeng},
counterType=gameCounterType.eXianjiePointShareNum,
regexType=CHAT_REGEX_TYPE.csFairyLand,
descStr=str,
jsonStr=jsonStr,
title='坐标分享',
shareName=data.msgName,
sharePosStr=FMT.fmt('X <color=#171311>{0},</color> Y <color=#171311>{1}</color>',data.x,data.y)
}
UIManager:showWindow("UICommonShareTwoWin",args)
end

function UIXianJie_emptyPosWin:checkCost(costData,wraning)
for i,v in ipairs(costData)do
local id=v[1]
local need=v[2]
if moneyConfig.isMoney(id)then
local have=moneyModel.getMoney(id)
if have<need then
if wraning then
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(id)))
gainControl:showGainWin(id)
end
return false,id
end
else
local have=bagModel.getItemCountById(id)
if have<need then
if wraning then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(id)))
gainControl:showGainWin(id)
end
return false,id
end
end
end
return true
end

function UIXianJie_emptyPosWin:checkCostEx()
local order=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'order')
local costs=order[xjOrderType.eStation][4]
local ret=self:checkCost(costs,true)
return ret
end

function UIXianJie_emptyPosWin:onStationBtn()
if not self:checkCostEx()then
return
end
local gridX=self.curPos[1]
local gridZ=self.curPos[2]
local gridX_c=self.curPos_c[1]
local gridZ_c=self.curPos_c[2]
local sceneidx=xianjieModel:getSceneIndex()
if not xianjieModel:checkRangeBlink(gridX,gridZ,1,1)then
UIManager.error("此处无法驻扎")
return
end
if not xianjieModel:checkScopeGridsCanPlace(sceneidx,gridX,gridZ,0,0,'此处无法驻扎')then
return
end
if xianjienSceneIndexType:isMoJie(sceneidx)then
local isUnLockFog=xianjieController:checkMoJiePosOpenFog(sceneidx,gridX,gridZ)
if not isUnLockFog then
UIManager.info("该区域暂被迷雾笼罩")
return
end
end
if xianjieModel:checkGridLimit(sceneidx,gridX,gridZ)then
UIManager.info("演武台附近无法驻扎")
return
end
local gridX_c_,gridZ_c_,sceneidx_,bornAreaID=xianjieModel:getZongMenWorldGridCenterPos()

local flag,g_list,errorParams=xianjieController:checkMovePath(bornAreaID,sceneidx_,gridX_c_,gridZ_c_,sceneidx,gridX_c,gridZ_c,true)
if not flag then
local gateId=g_list and g_list[1]or nil
if gateId then
local content="是否前往最近的关口？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
return xianjieController:jumpMoJieGateByGateId(gateId)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法向本阵内驻扎修士"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法向阵外驻扎修士"
else

errStr="处于本阵内无法向其他本阵内驻扎修士"
end
UIManager.error(errStr)
end
end
return
end

local speed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eStation,1)
local wayTime=xianjieModel:getZongMenToPosWayTime(sceneidx,gridX_c,gridZ_c,speed,nil,nil,nil)

local orderType=xjOrderType.eStation
local isChuZheng,isCanChuZheng,errStr=xianjieModel:checkXJIsChuZheng(orderType,true)
if not isChuZheng or not isCanChuZheng then
local orderCfg=xianjieModel:getOrderConfig(orderType)
local needYzType=orderCfg[1]
if needYzType==1 then
UIManager.error("当前没有可用云舟")
end

return
end
local extraCost={}

local func=function(selectDzList,selectMoneyList,boatId)
local guid=int64.new('0')
local ordertype=orderType
local params={sceneidx,gridX,gridZ}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,pstr,boatId,nil,g_list)
end
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({callback=func,extraCost=extraCost,wayTime=wayTime,orderType=orderType})
end

function UIXianJie_emptyPosWin:onCloseClick(atOnce)
xianjieController:closeWin('UIXianJie_emptyPosWin',atOnce)
end

function UIXianJie_emptyPosWin:onMask()
xianjieController:closeWin('UIXianJie_emptyPosWin')
end

function UIXianJie_emptyPosWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.eEmptyPos
local langId=ruleLangIdList and ruleLangIdList[ruleType]or''








local screenPos=self.ruleBtn:getChildUIScreenPos(false)
screenPos.x=screenPos.x-50
local winParams={
parentWin=self,
lang=langId,
num=nil,
screenPos=screenPos,
}
self:showWindow("UIXianJie_commonRuleWin",winParams)
end

function UIXianJie_emptyPosWin:onXjbjbtn()
local _posx=self.sharex
local _posy=self.sharez
local _sceneidx=xianjieModel:getSceneIndex()
local cbid=xianjieController.getZuoBiaoType(1)
xianjieController.openBJwin(_posx,_posy,_sceneidx,cbid)
end

function UIXianJie_emptyPosWin:onMoveXMBtn()
if not xianjieModel:isInMoJie()or
xianjienSceneIndexType:isOhterXianYu(xianjieModel:getSceneIndex())or
not xianmengModel:hasXM()or
not xianmengModel:checkPostSelfPrivile(GUILD_PRIVILE_TYPE.gptDevildom)then
return
end

local sceneidx=xianjieModel:getSceneIndex()
local gridX=self.curPos[1]
local gridZ=self.curPos[2]
local gridX_c=self.curPos_c[1]
local gridZ_c=self.curPos_c[2]
local myXMData=xianjieModel:getMyXianMengData()
local gridX_c_=myXMData.gridX_c
local gridZ_c_=myXMData.gridZ_c
local sceneidx_=myXMData.sceneidx
local bornAreaID=myXMData:getBornAreaID()
local flag,g_list=xianjieController:checkMovePath(bornAreaID,sceneidx_,gridX_c_,gridZ_c_,sceneidx,gridX_c,gridZ_c,true,nil,true)
if not flag then
local gateId=g_list and g_list[1]or nil
if gateId then
local content="是否前往最近的关口？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
return xianjieController:jumpMoJieGateByGateId(gateId)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end
return
end

local content='有队伍正赶往本仙盟，现在迁移仙盟,攻击本仙盟的队伍将立即到达发起进攻，援助本仙盟队伍将返回，是否继续？'
local gridX=self.curPos[1]
local gridZ=self.curPos[2]
local field=function(marchTeamData)
local isInSameScene=false
local curSceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(curSceneidx)then
isInSameScene=xianjienSceneIndexType:isMoJie(marchTeamData.tarsceneidx)
else
isInSameScene=not xianjienSceneIndexType:isMoJie(marchTeamData.tarsceneidx)
end

return playerModel:checkActorId(marchTeamData.srcactorid)and isInSameScene
end
local isAttack=xianjieModel:isExistMatrchTeamData(xjServerMarchType.eAttackXianMeng,field)

local callback=function()
xianjieModel:enterSceneState(xjSceneStateType.eMoveXianMeng,gridX,gridZ,self.width,self.height)
xianjieController:closeWin3()
end

if isAttack then
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=callback,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
callback()
end
end
