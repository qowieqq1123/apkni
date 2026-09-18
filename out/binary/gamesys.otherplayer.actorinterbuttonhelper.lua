







actorInterButtonHelper={}


actorInterFromType={
eCommon=1,
eXianMeng=2,
eSuoYaoTa=3,
}








local funcLookup={

[actorInterButtonType.eChat]={
cond=function(actorid,fromType)
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
return check
end,
cond_xj=function(actorid,fromType)
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
return check
end,
jump=function(actorid,fromType,serverid)
local actorInfo=nil
local ftype=nil
local data=friendModel:getFriendInfo(actorid)
if data then
actorInfo=chatActorInfo.convertByFriendInfo(data)
ftype=CHAT_PRIVATE_PLAYER_FROM_TYPE.eFriend
else
data=otherPlayerModel:getActorData(actorid)
if data~=nil then
actorInfo=chatActorInfo.convertByOtherPlayerInfo(data)
ftype=CHAT_PRIVATE_PLAYER_FROM_TYPE.eRecent
end
end
if actorInfo~=nil then
local args=
{
channelId=CHAT_CHANNNEL.ePrivate,
actorInfo=actorInfo,
formType=ftype,
}
UIManager:showWindow('UIChatWin',args)
UIManager:closeWindow('UIOthePlayerInfoWin')
else
UIManager.error('查无此人')
end
end
},

[actorInterButtonType.eFriend]={
cond=function(actorid,fromType)
if not systemModel.isOpen(SYSTEM_DEFINE.eFriend)then
return false
end
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
if check then
local canAdd=friendModel:canAddFriend(actorid)
check=canAdd
end
return check
end,
cond_xj=function(actorid,fromType)
if not systemModel.isOpen(SYSTEM_DEFINE.eFriend)then
return false
end
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
if check then
local canAdd=friendModel:canAddFriend(actorid)
check=canAdd
end
return check
end,
jump=function(actorid,fromType,serverid)
if friendModel:isBlack(actorid)then
UIManager.error('该仙友在您黑名单中')
elseif friendModel:isFriend(actorid)then
UIManager.error('该仙友已是您的好友')
else
local data=friendModel:getFromList(eFriendDataType.eRequire,actorid)
if data then
UIManager.info("已添加对方为好友请稍后")
else
local list={actorid}
friendProtocolController.req_add_friend(eFriendListType.eLocal,list)
end
end
end
},

[actorInterButtonType.eRemoveFriend]={
cond=function(actorid,fromType)
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
if check then
local isFriend=friendModel:isFriend(actorid)
check=isFriend
end
return check
end,
cond_xj=function(actorid,fromType)
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
if check then
local isFriend=friendModel:isFriend(actorid)
check=isFriend
end
return check
end,
jump=function(actorid,fromType,serverid)
if friendModel:isFriend(actorid)then
local playerIdList={actorid}
friendProtocolController.req_remove_friend(playerIdList)
else
UIManager.info("好友已删除")
end
end
},

[actorInterButtonType.eBlack]={
cond_xj=function(actorid,fromType,serverid)
return true
end,
cond_kf=function(actorid,fromType,serverid)
return true
end,
cond=function(actorid,fromType)
if not systemModel.isOpen(SYSTEM_DEFINE.eFriend)then
return false
end
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
if check then
local isBlack=friendModel:isBlack(actorid)
check=not isBlack
end
return check
end,
jump=function(actorid,fromType,serverid)
if friendModel:isBlack(actorid)then
UIManager.error('该仙友在您黑名单中')
else
local myServerID=playerModel:getActorServerID()
if serverid~=myServerID then
local actorData=otherPlayerModel:getActorData(actorid)
friendProtocolController.req_black_kuafu_list(serverid,actorid,actorData.iconInfo,actorData.name,actorData.zmLevel,actorData.zmName)
else
friendProtocolController.req_black_list(eFriendBlackOper.eAdd,actorid)
end
end
end
},

[actorInterButtonType.eRemoveBlack]={
cond_xj=function(actorid,fromType,serverid)
return true
end,
cond_kf=function(actorid,fromType,serverid)
return true
end,
cond=function(actorid,fromType)
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
if check then
local isBlack=friendModel:isBlack(actorid)
check=isBlack
end
return check
end,
jump=function(actorid,fromType,serverid)
if friendModel:isBlack(actorid)then
friendProtocolController.req_black_list(eFriendBlackOper.eRemove,actorid)
else
UIManager.error('已移除黑名单')
end
end
},

[actorInterButtonType.eVisit]={
cond_kf=function(actorid,fromType,serverid)
return true
end,
cond=function(actorid,fromType)
return false
end,
cond_xj=function(actorid,fromType)
return true
end,
jump=function(actorid,fromType,serverid)

local isSelf=actorid==playerModel:getActorID()
local isVisit=visitControl:getCurrentActor()==actorid
local isZMScene=mainControl:isSceneType(eSceneType.eZongmen)
local isBattle=fightModel:haveBattleShow()
if isBattle then
UIManager.error("战斗中无法访问其他仙友")
return
end
if fromType==actorInterFromType.eXianMeng then

local isVisitMt=zongmenModel:getMountainId()==mapIdType.zhufeng_hy
if not isSelf then
if isZMScene then
if not isVisitMt or not isVisit then
visitControl:reqEnterVisitMap(serverid,actorid)
UIManager:closeWindow("UIOthePlayerInfoWin")
fullScreenUI.closeActiveUI(true)
else
UIManager.info("已在好友宗门")
end
else
UIManager:closeWindow("UIOthePlayerInfoWin")
fullScreenUI.closeActiveUI(true)
mainControl:enterHome({mapIdType.zhufeng},function()
visitControl:reqEnterVisitMap(serverid,actorid)
end)
end
else
if not isZMScene then
UIManager:closeWindow("UIOthePlayerInfoWin")
fullScreenUI.closeActiveUI(true)
mainControl:enterHome()
else
UIManager.info("已在宗门")
end
end
end

if fromType==actorInterFromType.eSuoYaoTa then
if not isSelf and not isVisit then
local callback=function()
UIManager:closeWindow("UIOthePlayerInfoWin")
UIManager:closeWindow("UIShiLianTaRankBackWin")
UIManager:closeWindow("UIShiLianTaRankWin")

shiLianTaModel.data.selectStage=nil
UIFullFightPrepareControl:closeUI(true,true)
fightController:closeSelectStage()
end
visitControl:reqEnterVisitMap(serverid,actorid,callback)
end
end


if fromType==actorInterFromType.eCommon then
local callback=function()
UIManager:closeWindow("UIOthePlayerInfoWin")
fullScreenUI.closeActiveUI(true)
JiuYouTaModel.data.selectStage=nil
fightController:closeSelectStage()
end
if isZMScene then
visitControl:reqEnterVisitMap(serverid,actorid,callback)
else
mainControl:enterHome({mapIdType.zhufeng},function()
visitControl:reqEnterVisitMap(serverid,actorid,callback)
end)
end
end

end,
check=function(actorid,fromType)
















return true
end,
},

[actorInterButtonType.eInviteXM]={
cond_kf=function(actorid,fromType,serverid)
return xianmengController:checkKuafuMemberOpen()
end,
cond_xj=function(actorid,fromType)
return xianmengController:checkKuafuMemberOpen()
end,
cond=function(actorid,fromType)
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
if check then

local myActorid=playerModel:getActorID()
check=xianmengModel:hasXM()and not xianmengModel:checkActorInXM(actorid)
and xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptInvite)
and not xianmengModel:checkInviteJoinState(actorid)
end
return check
end,
jump=function(actorid,fromType,serverid)
xianmengController:reqInviteJoinXM(actorid)
end
},

[actorInterButtonType.eXMKickout]={
cond_kf=function(actorid,fromType,serverid)
return xianmengController:checkKuafuMemberOpen()
end,
cond_xj=function(actorid,fromType)
return xianmengController:checkKuafuMemberOpen()
end,
cond=function(actorid,fromType)
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
if check then
if fromType==actorInterFromType.eXianMeng then

local myActorid=playerModel:getActorID()
check=xianmengModel:hasXM()and xianmengModel:checkActorInXM(actorid)
and xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptKickMember)
else
check=false
end
end
return check
end,
jump=function(actorid,fromType,serverid)
if fromType==actorInterFromType.eXianMeng then
local func=function()
xianmengController:reqXMKickout(actorid)
end
local name=xianmengModel:getXMMemberName(actorid)
local content=FMT.fmt('确定要将<color=#ca631d>{0}</color>踢出仙盟吗？',name)
UIDialogManager.getCommonDialog(nil,content,func)
end
end
},

[actorInterButtonType.eXMTransferLeader]={
cond_kf=function(actorid,fromType,serverid)
return xianmengController:checkKuafuMemberOpen()
end,
cond_xj=function(actorid,fromType,serverid)
return xianmengController:checkKuafuMemberOpen()
end,
cond=function(actorid,fromType)
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
if check then
if fromType==actorInterFromType.eXianMeng then

local myActorid=playerModel:getActorID()
check=xianmengModel:hasXM()and xianmengModel:checkActorInXM(actorid)
and xianmengModel.checkActorPost(myActorid,GUILD_POST_TYPE.gpAllyLeader)
else
check=false
end
end
return check
end,
jump=function(actorid,fromType,serverid)
if fromType==actorInterFromType.eXianMeng then
local name=xianmengModel:getXMMemberName(actorid)
local showdata=
{
type='UIDialouge',
title='转让盟主',
content=FMT.fmt("是否将盟主职位转让给玩家<color=#549327>{0}</color>",name),
oktext='确定',
canceltext='取消',
allowclickBG='false',
useTimeCount=true,
timeCount=3,
okcallback=function(...)
xianmengController:reqChangeXMPost(actorid,GUILD_POST_TYPE.gpAllyLeader)
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()


end
end
},

[actorInterButtonType.eXMUpPost]={
cond_kf=function(actorid,fromType,serverid)
return xianmengController:checkKuafuMemberOpen()
end,
cond_xj=function(actorid,fromType,serverid)
return xianmengController:checkKuafuMemberOpen()
end,
cond=function(actorid,fromType)
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
if check then
if fromType==actorInterFromType.eXianMeng then

local myActorid=playerModel:getActorID()
check=xianmengModel:hasXM()and xianmengModel:checkActorInXM(actorid)
and xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptChangePos)

else
check=false
end
end
return check
end,
jump=function(actorid,fromType,serverid)
if fromType==actorInterFromType.eXianMeng then
local post=xianmengModel:getXMMemberPost(actorid)
local tarPos=post-1
if tarPos<=GUILD_POST_TYPE.gpViceLeader then
local name=xianmengModel:getXMMemberName(actorid)
local posName1=xianmengModel.getXMPostName(tarPos,true)
local posName2=xianmengModel.getXMPostName(tarPos,false)
local showdata=
{
type='UIDialouge',
title='提升职位',
content=FMT.fmt("{0}可参与管理仙盟事务\n是否将<color=#549327>{1}</color>提升为{2}",posName2,name,posName1),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
xianmengController:reqChangeXMPost(actorid,tarPos)
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
xianmengController:reqChangeXMPost(actorid,tarPos)
end
end
end,
enable=function(actorid,fromType)
local myActorid=playerModel:getActorID()
return xianmengModel.compareTwoActorPost(myActorid,actorid,2)
end,
},

[actorInterButtonType.eXMDowmPost]={
cond_kf=function(actorid,fromType,serverid)
return xianmengController:checkKuafuMemberOpen()
end,
cond_xj=function(actorid,fromType,serverid)
return xianmengController:checkKuafuMemberOpen()
end,
cond=function(actorid,fromType)
local isMyself=playerModel:checkActorId(actorid)
local check=not isMyself
if check then
if fromType==actorInterFromType.eXianMeng then

local myActorid=playerModel:getActorID()
check=xianmengModel:hasXM()and xianmengModel:checkActorInXM(actorid)
and xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptChangePos)
and xianmengModel.compareTwoActorPost(myActorid,actorid,1)

else
check=false
end
end
return check
end,
jump=function(actorid,fromType,serverid)
if fromType==actorInterFromType.eXianMeng then
local post=xianmengModel:getXMMemberPost(actorid)
xianmengController:reqChangeXMPost(actorid,post+1)
end
end,
enable=function(actorid,fromType)
return not xianmengModel.checkActorPost(actorid,GUILD_POST_TYPE.gpCivilian)
end,
},

[actorInterButtonType.eQieCuo]={
cond_kf=function(actorid,fromType,serverid)
return true
end,
cond_xj=function(actorid,fromType,serverid)
return true
end,
cond=function(actorid,fromType)
local isopen=false
if otherPlayerModel:getActorData(actorid)and otherPlayerModel:getActorData(actorid).zmLevel then
local zmLevel=cfg_globalconfig_get(1).duel[1]
if otherPlayerModel:getActorData(actorid).zmLevel>=zmLevel then
isopen=true
end
end
local selfactorid=playerModel:getActorID()
if selfactorid==actorid then
isopen=false
end
if isopen then
local otherseverid=otherPlayerModel:getActorData(actorid).serverid or playerModel:getActorServerID()
DiZiDuelController.send_254_72(otherseverid,actorid)
end
return isopen
end,
jump=function(actorid,fromType,serverid)
local severdata=DiZiDuelModel:getAllData()

local otherallow=severdata.findret
if otherallow==3 then
UIManager.error('您已被对方祖师拉黑，暂无法切磋')
return
end

if otherallow~=0 then
UIManager.error('对方闭关修炼中，拒绝切磋请求')
return
end
local actorData=otherPlayerModel:getActorData(actorid)
local check=zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eDouFaTai)
if not check then
UIManager.error('请先修复斗法台')
return
end
if fightModel:haveBattleShow()then
UIManager.error('战斗中不能切磋')
return
end
local otherseverid=otherPlayerModel:getActorData(actorid).serverid or playerModel:getActorServerID()
if UIManager:isActive('UIChatWin')then
DiZiDuelModel:setCallBackType(DiZiqiecuotype.liaotian)
end
if UIManager:isActive('UIFriendListWin')or UIManager:isActive('UIFriendAddWin')or UIManager:isActive('UIFriendApplyWin')then
DiZiDuelModel:setCallBackType(DiZiqiecuotype.xianyou)
end

if zongmenControl:isMountid(mapIdType.xianmeng)then
if UIManager:isActive('UIXianMengPalaceWin')then
DiZiDuelModel:setCallBackType(DiZiqiecuotype.xmdadain)
end
if UIManager:isActive('UIXianMengListWin')then
DiZiDuelModel:setCallBackType(DiZiqiecuotype.xmddother)
end
if UIManager:isActive('UIXianMengGXBRankWin')then
DiZiDuelModel:setCallBackType(DiZiqiecuotype.xmgfb)
end
end

if UIManager:isActive('UIRankListBackgroundWin')then
if UIManager:isActive('UIRankListWanLingBeiWin')then
DiZiDuelModel:setCallBackType(DiZiqiecuotype.wanlingbei)
end
if UIManager:isActive('UIRankListHunDunBeiWin')then
DiZiDuelModel:setCallBackType(DiZiqiecuotype.hundunbei)
end
if UIManager:isActive('UIRankListWuJiBeiWin')then
DiZiDuelModel:setCallBackType(DiZiqiecuotype.wujibei)
end
end

if UIManager:isActive('UIShiLianTaRankWin')then
DiZiDuelModel:setCallBackType(DiZiqiecuotype.suoyaota)
end
DiZiDuelController:checkDouFaTaiTeamlist(actorid,otherseverid,actorData)
end
},
}

function actorInterButtonHelper.getButtonList(actorid,fromType,serverid,isXianJie)
local localServerId=playerModel:getActorServerID()
local iskuafu=serverid~=localServerId
local list={}
local cfgs=cfg_actorinterbuttonconfig()
for k,cfg in pairs(cfgs)do
local check=funcLookup[cfg.id]
if check~=nil then
local flag=false
if isXianJie and iskuafu then
if check.cond_xj and check.cond_xj(actorid,fromType,serverid)then
if check.cond(actorid,fromType)then
flag=true
end
end
else
if iskuafu then
if check.cond_kf and check.cond_kf(actorid,fromType,serverid)then
if check.cond(actorid,fromType)then
flag=true
end
end
else
if check.cond(actorid,fromType)then
flag=true
end
end
end

if flag then
table.insert(list,cfg)
end
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.sortWeight>b.sortWeight
end)
end
return list
end

function actorInterButtonHelper.getIconList(actorid,fromType,serverid,isXianJie)
local localServerId=playerModel:getActorServerID()
local iskuafu=serverid~=localServerId
local list={}
local cfgs=cfg_actorinterbuttonconfig()
for k,cfg in pairs(cfgs)do
local check=funcLookup[cfg.id]
if check~=nil and check.check~=nil then
local flag=false
if isXianJie and iskuafu then
if check.cond_xj and check.cond_xj(actorid,fromType,serverid)then
if check.cond(actorid,fromType)then
flag=true
end
end
else
if iskuafu then
if check.cond_kf and check.cond_kf(actorid,fromType,serverid)then
if check.check(actorid,fromType)then
flag=true
end
end
else
if check.check(actorid,fromType)then
flag=true
end
end
end
if flag then
table.insert(list,cfg)
end
end
end
return list
end

function actorInterButtonHelper.buttonJump(btnType,actorid,fromType,serverid)
local check=funcLookup[btnType]
if check~=nil then
check.jump(actorid,fromType,serverid)
end
end

function actorInterButtonHelper.checkEnable(btnType,actorid,fromType)
local check=funcLookup[btnType]
if check~=nil and check.enable then
return check.enable(actorid,fromType)
end
return true
end