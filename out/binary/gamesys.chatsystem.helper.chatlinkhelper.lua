





chatLinkHelper={}






eLinkType=
{
eItem=1,
eJump=2,
eVisitURL=3,
eZhanBao=4,
eGuBao=5,
eDiZi=6,
eWatchMesg=8,
eAddBlack=9,
eFengxian=10,
eZMVisitor=11,
eXianMengCreate=12,
eGMLog=13,
eOtherPlayerInfo=14,
eQieChuoZhanBao=15,
eZZSHPosShare=16,
eZZSHGuidShare=17,
eZZSHGuidZhaoJi=18,
eZZSHnoteJump=19,
ePlantGetWin=20,
eXJkongdiShare=21,
eXJzongmenShare=22,
eXJMonsterShare=23,
eXJPosShare=24,
eYunZhouComponentsGain=25,
eXJRZText=26,
eXGTQNoticeJump=27,
eMXSLShipJump=28,
eMGZDJump=29,
eOMJumpURL=30,
eXJLingShou=31,
}






function chatLinkHelper.OnHRefClick(name,args)


if args then

local result=string.split(args,',')
if chatLinkHelper.HRefHandlers==nil then
chatLinkHelper.HRefHandlers=chatLinkHelper:getHRefHandlers()
end
for k,v in ipairs(chatLinkHelper.HRefHandlers)do
if v(args,result)then
break
end
end
end
end






function chatLinkHelper.getItemText(itemguid,itemid,dzguid)
assert(itemid)
itemguid=itemguid or-1
local actorid=playerModel:getActorID()
local config=itemsConfig.getConfig(itemid)
local isFabao=itemsConfig.isFabao(itemid)
local name=config.name
if isFabao then
local item=itemsModel.getItem(itemguid)
name=fabaoHelper.getFabaoName(item)
end
local serverid=playerModel:getActorServerID()
local color=config.color
local key=FMT.fmt('{0}',name)
local args=FMT.fmt('{0},{1},{2},{3},{4},{5}',eLinkType.eItem,tostring(actorid),itemid,tostring(itemguid),serverid,dzguid or Int64_0)
local str=chatConfig.getLinkStr(name,color,true,args)
return key,str
end

function chatLinkHelper.getItemText2(itemid)
assert(itemid)
local config=itemsConfig.getConfig(itemid)
local name=config.name
local color=config.color
local args=FMT.fmt('{0},{1},{2},{3}',eLinkType.eItem,'0',itemid,'-1')
local str=chatConfig.getLinkStr(name,color,true,args)
return str
end

function chatLinkHelper.getFengxianText(mesg)
local id=tostring(playerModel:getPlayerID())
local name=playerModel:getName()
local level=playerModel:getLevel()
local icon=playerModel:getPlayer():get_icon()
local fengxianLink=chatConfig.getLinkStr('风险',5,false,FMT.fmt('{0},{1}',eLinkType.eFengxian,id))
local watchLink=chatConfig.getLinkStr('查看',8,false,FMT.fmt('{0},{1}',eLinkType.eWatchMesg,id))
local blackLink=chatConfig.getLinkStr('拉黑',8,false,FMT.fmt('{0},{1},{2},{3}',eLinkType.eAddBlack,id,name,level,icon))
local str=FMT.fmt('{0}...{1}　{2}',fengxianLink,watchLink,blackLink)
return str
end

function chatLinkHelper.getDiZi(diziguid)
local color=UIDiscipleModel:getDiscipleColor(diziguid)
local name=UIDiscipleModel:getDiscipleName(diziguid)
local serverid=playerModel:getActorServerID()
local args=FMT.fmt('{0},{1},{2},{3}',eLinkType.eDizi,tostring(actorid),tostring(diziguid),serverid)
local str=chatConfig.getLinkStr(name,color,true,args)
end


function chatLinkHelper.getHRefHandlers()
return{
chatLinkHelper.checkItemLink,
chatLinkHelper.checkVisitURLLink,
chatLinkHelper.checkJumpLink,
chatLinkHelper.checkFengxian,
chatLinkHelper.checkZhanBao,
chatLinkHelper.checkDiZi,
chatLinkHelper.checkZMVisitor,
chatLinkHelper.checkXianMengCreate,
chatLinkHelper.checkGMLogLink,
chatLinkHelper.checkOtherPlayerInfoLink,
chatLinkHelper.checkQieChuoZhanBaoLink,
chatLinkHelper.checkZZSHPosLink,
chatLinkHelper.checkZZSHGuidLink,
chatLinkHelper.checkZZSHGuidZhaoJiLink,
chatLinkHelper.checkZZSHnoteJump,
chatLinkHelper.checkPlantGetWin,
chatLinkHelper.checkXJKDLink,
chatLinkHelper.checkXJZMLink,
chatLinkHelper.checkXJMWLink,
chatLinkHelper.checkXJCJDLink,
chatLinkHelper.checkYunZhouComponentsGainLink,
chatLinkHelper.checkXJRZText,
chatLinkHelper.checkXGTQNoticeJump,
chatLinkHelper.checkMXSLShipLink,
chatLinkHelper.checkMGZDLink,
chatLinkHelper.checkVisitURLLink_OM,
chatLinkHelper.checkXianJieLingShouLink,
}
end





function chatLinkHelper.checkItemLink(str,argstable)
if argstable then
if not chatLinkHelper.checkLinkType(argstable[1],eLinkType.eItem)then return false end
local actorid=int64.new(argstable[2])
local itemid=tonumber(argstable[3])
local guidStr=tostring(argstable[4])
local serverid=tonumber(argstable[5])
local discipleguid=argstable[6]and int64.new(argstable[6])or Int64_0
local itemguid
if guidStr and guidStr~='-1'then
itemguid=int64.new(guidStr)
if itemguid then
local item=itemsModel.getItem(itemguid)
if item==nil then
watchControl.sendWatchItem(actorid,itemguid,discipleguid,serverid)
return
end
end
end
tipsManager.showTips({formType=TIPS_FORM_TYPE.eLink,itemid=itemid,itemguid=itemguid})
end
end



function chatLinkHelper.checkFengxian(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eWatchMesg)then
local mesg=argstable[2]

UIManager:showWindow('UIChatTipsMesgPanel',mesg)
return true
end
return false
end
end



function chatLinkHelper.checkVisitURLLink(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eVisitURL)then
local url=argstable[2]


LuaApplication.GetApplication().OpenURL(url)
return true
end
return false
end
end



function chatLinkHelper.checkVisitURLLink_OM(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eOMJumpURL)then
local url=argstable[2]

local loginParam=pfwindowslController.getLoginParam()
if not loginParam then
platformSDK.printSDK("checkVisitURLLink not loginParam")
return
end
url=url..loginParam

LuaApplication.GetApplication().OpenURL(url)
return true
end
return false
end
end



function chatLinkHelper.checkXianJieLingShouLink(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eXJLingShou)then
local infoGuid=argstable[2]
if infoGuid==nil then return false end
local lsData=xianjieController:getLingShouData_exExpire(infoGuid)
if lsData then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMiCangOtherHoldAutoFind)
local callback=function()
local sceneIdx=lsData.sceneidx
xianjieController:jumpGrid(sceneIdx,lsData.gridX_c,lsData.gridZ_c,nil,true,nil)
end
if not flag then
local showdata=
{
type='UIDialouge',
title='提示',
content="是否前往目标所在处",
oktext='确定',
okcallback=callback,
allowclickBG=true,
showclosebtn=true,
choosetext='今日不再提示',
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianJieLingShouShare,flag)
end
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
callback()
end
else
local showdata=
{
type='UIDialouge',
title='提示',
content="目标已从仙界消失",
oktext='确定',
allowclickBG=true,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end
return true
end
return false
end
end


function chatLinkHelper.checkGubaoLink(str,argstable)
if argstable then
if not chatLinkHelper.checkLinkType(argstable[1],eLinkType.eGubao)then return false end
local actorid=int64.new(argstable[2])
local itemid=tonumber(argstable[3])
tipsManager.showTips({funcType=TIPS_FUNC_TYPE.eGubao,formType=TIPS_FORM_TYPE.eLink,itemid=itemid})
end
end




function chatLinkHelper.checkJumpLink(str,argstable)
if argstable then
if not chatLinkHelper.checkLinkType(argstable[1],eLinkType.eJump)then
return false
end
local jumpType=tonumber(argstable[2])
local jumpId=tonumber(argstable[3])
local len=string.len(argstable[1])+string.len(argstable[2])+string.len(argstable[3])+3
local maxLen=string.len(str)
local jumpParam
if len<maxLen then
local argsStr=string.sub(str,len+1,maxLen)
jumpParam=loadstring("return {"..argsStr..'}')()
else
jumpParam={}
end
jumpParam.type=jumpType
jumpParam.id=jumpId
jumpManager:jump(jumpParam)
return true
end
end


function chatLinkHelper.checkZhanBao(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eZhanBao)then
local log_id=argstable[2]
fightController:send_254_29(log_id,argstable)
return true
end
return false
end
end

function chatLinkHelper.checkDiZi(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eDiZi)then
local actorid=int64.new(argstable[2])
local diziguid=int64.new(argstable[3])
local selfserverid=playerModel:getActorServerID()
local serverid=tonumber(argstable[4]or selfserverid)
if serverid==0 or serverid==selfserverid then
serverid=nil
end
otherPlayerController:reqOtherPlayerDZList(actorid,1,{diziguid},serverid)
return true
end
return false
end
end


function chatLinkHelper.checkZMVisitor(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eZMVisitor)then
if fightModel:haveBattleShow()then
return UIManager.error("战斗中无法前往好友宗门")
end
local actorid=int64.new(argstable[2])
local endStamp=tonumber(argstable[3])
local nowStamp=timeHelper.getServerShortTime()
if nowStamp>=endStamp then
UIManager.error('访客已离开')
return false
end
local isZMScene=mainControl:isSceneType(eSceneType.eZongmen)
local isSelf=actorid==playerModel:getActorID()
local isVisit=visitControl:getCurrentActor()==actorid
local isVisitMt=zongmenModel:getMountainId()==mapIdType.zhufeng_hy

if not isSelf then
if isZMScene then
if not isVisitMt or not isVisit then
zongmenVisitorController:setShowOther(true)
visitControl:reqEnterVisitMap(nil,actorid)
UIManager:closeWindow("UIChatWin")
else
UIManager.info("已在好友宗门")
end
else
UIManager:closeWindow("UIChatWin")
mainControl:enterHome({eSceneType.eZongmen},function()

zongmenVisitorController:setShowOther(true)
visitControl:reqEnterVisitMap(nil,actorid)
end)
end
else

end
return true
end
return false
end
end


function chatLinkHelper.checkXianMengCreate(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eXianMengCreate)then
if fightModel:haveBattleShow()then
UIManager.info("战斗中无法进入仙盟")
return
end
local xmGuidStr=argstable[2]
local xmGuid=int64.new(xmGuidStr)
if systemModel.isOpen(SYSTEM_DEFINE.eXianMeng)then
if not xianmengModel:hasXM()then
local func=function()
UIManager:closeWindow("UIChatWin")
xianmengController:reqApllyJoinXM({xmGuid})
end
xianmengController:checkFreeCDTimes(func)
else
if xianmengModel:isMyXM(xmGuid)then
UIManager.info("祖师已在该仙盟，无法再次加入")
else
UIManager.info("祖师已有仙盟")
end
end
else
UIManager.info(systemModel.getOpenTips(SYSTEM_DEFINE.eXianMeng))
end
end
end
end


function chatLinkHelper.checkGMLogLink(str,argstable)
if argstable then
if not chatLinkHelper.checkLinkType(argstable[1],eLinkType.eGMLog)then
return false
end
local page=tonumber(argstable[2])
local str=argstable[3]
UIManager:callWindowFunc('UIDownloadLogWin','showSearchPage',str,page)
return true
end
end




function chatLinkHelper.checkOtherPlayerInfoLink(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eOtherPlayerInfo)then

local actorId=int64.new(argstable[2])
local myActorid=playerModel:getActorID()
if not mathHelper.compareInt64(myActorid,actorId)then
local _server_id=tonumber(argstable[3])
local now_severid=playerModel:getActorServerID()
local attach=nil
if now_severid~=_server_id then
attach={serverid=_server_id}
end
otherPlayerController:openOtherPlayerInfoWin(actorId,nil,nil,attach)
else
UIManager.info("目标为自己，查看失败")
end
return true
end
return false
end
end



function chatLinkHelper.checkQieChuoZhanBaoLink(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eQieChuoZhanBao)then
local _myseverid=playerModel:getActorServerID()
local _myname=playerModel:getActorName()
local selfactordata=playerModel:getActorIconInfo()
local _myactoricon=selfactordata.actoricon
local _mypiList=selfactordata.piList

local _otherseverid=tonumber(argstable[3])
local _otheractorid=int64.new(argstable[4])
local _othername=argstable[5]

local key=mathHelper.int64_to_string(_otheractorid)
local otheractordata=DiZiDuelModel:getOtherIconInfo(key)
if otheractordata then
local _otheractoricon=otheractordata.actoricon
local _otherpiList=otheractordata.piList
local _fightresult=tonumber(argstable[6])or 0
local _zhanbao=argstable[2]

local _selfFright=nil
local _otherFright=nil
if argstable[7]then
_selfFright=int64.new(argstable[7]or 0)
end
if argstable[8]then
_otherFright=int64.new(argstable[8]or 0)
end

local qiecuoData={
myseverid=_otherseverid or 0,
myname=_othername,
myactoricon=_otheractoricon or 0,
mypiList=_otherpiList,

otherseverid=_myseverid or 0,
othername=_myname,
otheractoricon=_myactoricon or 0,
otherpiList=_mypiList,

fightresult=_fightresult or 0,
zhanbao=_zhanbao,


selfFright=_selfFright,
otherFright=_otherFright,
}
fightController:send_log_list({_zhanbao},{eReplayType=eRePlayerType.diziqiecuo,showBattle=true,showWinTimes=true,data=qiecuoData},true)
end
end
return false
end
end



function chatLinkHelper.checkZZSHPosLink(str,argstable)
if argstable then
local typo=argstable[1]

if chatLinkHelper.checkLinkType(typo,eLinkType.eZZSHPosShare)then
UIManager:closeWindow("UIChatWin")
local x=tonumber(argstable[2])
local y=tonumber(argstable[3])
local extraParams={
jumpPos={x,y},
}
return limitActivitiesController:jump(LIMIT_ACT_TYPE.eZhengZhanShanHai,extraParams)
end
return false
end
end



function chatLinkHelper.checkZZSHGuidLink(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eZZSHGuidShare)then
UIManager:closeWindow("UIChatWin")
local guid=tonumber(argstable[2])
local extraParams={
jumpQB=guid,
}
return limitActivitiesController:jump(LIMIT_ACT_TYPE.eZhengZhanShanHai,extraParams)
end
return false
end
end



function chatLinkHelper.checkZZSHGuidZhaoJiLink(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eZZSHGuidZhaoJi)then
UIManager:closeWindow("UIChatWin")
local guid=tonumber(argstable[2])
local extraParams={
jumpQB=guid,
}
return limitActivitiesController:jump(LIMIT_ACT_TYPE.eZhengZhanShanHai,extraParams)
end
return false
end
end


function chatLinkHelper.checkZZSHnoteJump(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eZZSHnoteJump)then

local guid=tonumber(argstable[2])
local extraParams={
jumpQB=guid,
}
local qbData=zhengzhanshanhaiModel:getQingBaoData(guid)
if guid and qbData then
UIManager:invokeUIMethod("UIBackgroundComponent",'onCloseButton')
else
UIManager.info("目标已消失")
end

return limitActivitiesController:jump(LIMIT_ACT_TYPE.eZhengZhanShanHai,extraParams)
end
return false
end
end



function chatLinkHelper.checkPlantGetWin(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.ePlantGetWin)then
YiFangLingTianModel:openPlantGainWin()
return true
end
return false
end
end



function chatLinkHelper.checkXJKDLink(str,argstable)
if argstable then
local typo=argstable[1]

if chatLinkHelper.checkLinkType(typo,eLinkType.eXJkongdiShare)then
UIManager:closeWindow("UIChatWin")
local x=tonumber(argstable[2])
local y=tonumber(argstable[3])
local sceneidx=tonumber(argstable[4])
local func=function()
oneTabScreenController:closeUI()
end
return xianjieController:jumpGrid(sceneidx,x,y,func,true)
end
return false
end
end
function chatLinkHelper.checkXJZMLink(str,argstable)
if argstable then
local typo=argstable[1]

if chatLinkHelper.checkLinkType(typo,eLinkType.eXJzongmenShare)then
UIManager:closeWindow("UIChatWin")
local x=tonumber(argstable[2])
local y=tonumber(argstable[3])
local sceneidx=tonumber(argstable[4])
local func=function()

end
return xianjieController:jumpGrid(sceneidx,x,y,func,true)
end
return false
end
end
function chatLinkHelper.checkXJMWLink(str,argstable)
if argstable then
local typo=argstable[1]

if chatLinkHelper.checkLinkType(typo,eLinkType.eXJMonsterShare)then
UIManager:closeWindow("UIChatWin")
local x=tonumber(argstable[2])
local y=tonumber(argstable[3])
local sceneidx=tonumber(argstable[4])
local func=function()

end
return xianjieController:jumpGrid(sceneidx,x,y,func,true)
end
return false
end
end
function chatLinkHelper.checkXJCJDLink(str,argstable)
if argstable then
local typo=argstable[1]

if chatLinkHelper.checkLinkType(typo,eLinkType.eXJPosShare)then
UIManager:closeWindow("UIChatWin")
local x=tonumber(argstable[2])
local y=tonumber(argstable[3])
local sceneidx=tonumber(argstable[4])
local func=function()

end
return xianjieController:jumpGrid(sceneidx,x,y,func,true)
end
return false
end
end



function chatLinkHelper.checkYunZhouComponentsGainLink(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eYunZhouComponentsGain)then
UIManager:closeWindow("UIYunZhouComponentsGainWin")
local itemid=tonumber(argstable[2])
return gainControl:showGainWin(itemid)
end
return false
end
end



function chatLinkHelper.checkXJRZText(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eXJRZText)then
return true
end
return false
end
end



function chatLinkHelper.checkXGTQNoticeJump(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eXGTQNoticeJump)then
local xgid=tonumber(argstable[2])
local tqid=tonumber(argstable[3])
return xianguanConfig.commonLogJump(xgid,tqid)
end
return false
end
end

function chatLinkHelper.checkMXSLShipLink(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eMXSLShipJump)then
local x=tonumber(argstable[2])
local y=tonumber(argstable[3])
local sceneidx=tonumber(argstable[4])
local shipGuidStr=argstable[5]
local shipGuid=int64.new(shipGuidStr)
local actorIdStr=argstable[7]
local isSelf=actorIdStr and playerModel:checkActorId(actorIdStr)or false

local openFunc=function()
local isCanJumpMXSL=xianJieCaravanEscortModel:checkCanXJCaravanEscortWinJump()
if not isCanJumpMXSL then
return false
end


local sceneIdx
local isXJ=mainControl:isSceneType(eSceneType.eXianJie)
if isXJ then
sceneIdx=xianjieModel:getSceneIndex()
end

local openFunc=function()
local showType=2
local guid=shipGuid
xianjieController:openXJCaravanEscortShipMsgWin(showType,guid,false)
end

if isXJ then

xianJieCaravanEscortController:addCaravanEscortTeamByShipGuid(shipGuid)
local shipData=xianJieCaravanEscortModel:getShipTeamDataByShipGuid(shipGuid)
local hasPath=false
if shipData then
hasPath=xianJieCaravanEscortModel:checkHasPathData(shipData)
end

if not hasPath then
UIManager.error("无法确定该仙舟所在位置")
return false
end

local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
if entityData then
local getEntityDataFunc=function()
return xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
end

local clickEntKey=entityData:getTeamEnityKey()
if not clickEntKey then

local shipNowSceneIdx,pos=entityData:getTeamPos()
if shipNowSceneIdx then
local nowSceneIdx=sceneIdx
if nowSceneIdx~=shipNowSceneIdx then
local content="该队伍不在当前场景 是否跳转至对应场景？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
local sceneType=xianjieModel:sceneIndex2SceneType(shipNowSceneIdx)
return xianjieController:jumpXianJie(sceneType,nil,function()
local entityData=xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc,openFunc)

end
end)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return true
end
end
return false
else
xianjieModel:enterSceneState_clickTeam_before_notTeam(clickEntKey,getEntityDataFunc,openFunc)

return true
end
end
else

























local show_data=
{
title='提示',
_okText="确定",
_cancelText="取消",
tipsText="喵行商旅需前往仙界查看，是否前往？",
closetopbtn=true,
cellcallback=function()
fullScreenUI.closeActiveUI(false,true)
xianJieCaravanEscortController:setJumpOpenFunc(function()

xianJieCaravanEscortController:addCaravanEscortTeamByShipGuid(shipGuid)
return openFunc()
end)
return xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil)
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
return true
end
return false
end






local isNeedCloseWin=openFunc()
if isNeedCloseWin then
UIManager:closeWindow("UIChatWin")
end
end
return false
end
end

function chatLinkHelper.checkMGZDLink(str,argstable)
if argstable then
local typo=argstable[1]
if chatLinkHelper.checkLinkType(typo,eLinkType.eMGZDJump)then
UIManager:closeWindow("UIChatWin")

local sceneIdx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoGongZhengDuo(sceneIdx)then
UIManager.info("已处于魔宫争夺场景")
return true
else
return xianjieController:jumpXianJie(xianjienSceneType.eMoGongZhengDuo)
end
end
return false
end
end

function chatLinkHelper.checkLinkType(inTypo,matchTypo)
local typo=0
local s,e=pcall(function()
typo=tonumber(inTypo)
end)
if s==nil or typo~=matchTypo then
return false
end
return true
end


function chatLinkHelper.getLink(mesg)
local name,color,underline,args=string.match(mesg,chatConfig.linkRegex)
return name,color,underline,args
end


function chatLinkHelper.tryClearFengxian(mesg,isFengXianLink)
local name,color,underline,args=chatLinkHelper.getLink(mesg)
if name then
local linkType=args[1]
if linkType==eLinkType.eFengxian then
local actorid=args[2]
if not playerModel:checkActorId(actorid)then
mesg=string.gsub(mesg,chatConfig.linkRegex,FMT.cfmt(tonumber(color),name),1)
return chatLinkHelper.tryClearFengxian(mesg,true)
end
elseif linkType==eLinkType.eWatchMesg then
if isFengXianLink then
return args[2]
end
end
end
return false
end


function chatLinkHelper.clearFengxian(mesg)
local ret=chatLinkHelper.tryClearFengxian(mesg)

if ret then
return ret
end
return mesg
end

function chatLinkHelper.clearRich(mesg)
local s1=string.match(mesg,'<color=(.-)>')
if s1 then
local stt='<color='..s1..'>'
s1=string.replace(mesg,stt,'')
end
s1=string.replace(s1,'</color>','')
s1=string.replace(s1,'</a>','')
s1=string.replace(s1,'<b>','')
s1=string.replace(s1,'</b>','')
s1=string.replace(s1,'<i>','')
s1=string.replace(s1,'</i>','')
return s1
end

function chatLinkHelper.clearLink(mesg)
local name,color,underline,args=chatLinkHelper.getLink(mesg)
while(name)do
mesg=string.gsub(mesg,chatConfig.linkRegex,FMT.cfmt(tonumber(color),name),1)
name,color,underline,args=chatLinkHelper.getLink(mesg)
end
return mesg
end


function chatLinkHelper.checkLink(mesg)
local name,color,underline,args=chatLinkHelper.getLink(mesg)
local num=0
while(name)do
num=num+1
mesg=string.gsub(mesg,chatConfig.linkRegex,FMT.cfmt(tonumber(color),name),1)
name,color,underline,args=chatLinkHelper.getLink(mesg)
end
return num
end

function chatLinkHelper.replaceLink(mesg,linkTable)
if linkTable==nil then return mesg end
for name,link in pairs(linkTable)do
mesg=string.replace(mesg,name,link)
return mesg
end
return mesg
end


