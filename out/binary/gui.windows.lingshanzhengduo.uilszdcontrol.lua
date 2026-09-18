

UILSZDControl=gameState.addListener(fullScreenUI.create())

function UILSZDControl:onAppStart()
socketManager:register_receiver(44,1,self.recv_44_1)
socketManager:register_receiver(44,2,self.recv_44_2)
socketManager:register_receiver(44,3,self.recv_44_3)
socketManager:register_receiver(44,4,self.recv_44_4)

self.lingShanInfo={
[1]={
name='素尘灵山',
mapIcon='icon_lsbsi_1'
},
[2]={
name='混元灵山',
mapIcon='icon_lsbsi_2'
}
}

local args=
{
fullType=FULL_TYPE.eLingShanZhenDuo,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UILSZDControl:onEnterState(isReconnect)
self.nextReqTime=0
if isReconnect then
return
end

self.datas={}
self.lingShanDiZiDict={}
end

function UILSZDControl:onLeaveState(isReconnect)
if isReconnect then
return
end
end

function UILSZDControl:showLSZDWin(argstable)
UILSZDControl:reqDiscipleList(function()
local viewName='UILingShanZhengDuoWin'
local args=
{
tabType=FULL_TAB_TYPE.eLingShanZhenDuo,
showBg=true,
viewNames={viewName},
viewArgs={[viewName]=argstable},
}
self:showUI(args)
end)
end

function UILSZDControl:showLSZDWinWithCloud(argstable)
local startCallback=function()
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
UILSZDControl:showLSZDWin(argstable)
end
UIFullDouFaTaiControl:showWindow("UIFightPrepareLoading",{
startCallback=startCallback
})
end

function UILSZDControl:showLSZDWinEx(argstable,openZZSH,noCloud)
local qbType
if openZZSH then
local win=UIManager:findActiveWindow('UILingShanIntelligenceWin')
if win then
qbType=win:getSelectMpuntType()
end
end

if noCloud then
self:showLSZDWin(argstable)
else
self:showLSZDWinWithCloud(argstable)
end

if openZZSH then
local mdata=self:getDataById(argstable.mountId)
local jumpPos={mdata.x,mdata.y}
local args={showCloud=false,jumpPos=jumpPos}
if qbType then
args.jumpLSQBPage=true
args.mountType=qbType
end
fullScreenUI.setNextActiveUICallback(function()
zhengzhanshanhaiController:finishFightOpen(args)
end)
end
end

function UILSZDControl:openIntelligenceWin(mountType)
local id=zhengzhanshanhaiModel:getLunState()
if id==eZZSH_State.ePVPFight or id==eZZSH_State.ePVPStandby then
UIManager.info('山海世界战争期不能入驻灵山')
return
end
UIManager:showWindow('UIXM_ZZSH_entitySelectWin',{page=3,data={mount_type=mountType}})
end



function UILSZDControl:reqDatas()
socketManager:send_44_1()
end

function UILSZDControl.recv_44_1(len,datas)
UILSZDControl:setDatas(datas or{})
UILSZDControl:reqDiscipleList(function()
UIManager:callWindowFunc('UILingShanZhengDuoWin','refresh')
end,true)
end

function UILSZDControl:reqLeaveMount(mountId,areaId,pos)
socketManager:send_44_2(mountId,areaId,pos)
end

function UILSZDControl.recv_44_2(mountId,areaId,pos)








end

function UILSZDControl.recv_44_3(mountId,data,dzData)
local areaData=UILSZDControl:getAreaDataById(mountId,data.area_id)
if areaData then
data.mountId=mountId
local pos=data.pos
if areaData[pos]then
UILSZDControl:recordLingShanDiZi(areaData[pos],false)
areaData[pos]=nil
end
if tostring(data.actor_id)~='0'then
areaData[pos]=data

if dzData.disciple_list_len>0 then
for _,v in ipairs(dzData.disciple_list)do
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(v.dzAttrList)
end
end
data.disciple_list_len=dzData.disciple_list_len
data.disciple_list=dzData.disciple_list
data.fight=dzData.fight

UILSZDControl:recordLingShanDiZi(data,true)
end

UILSZDControl:refreshLingShanEntity(mountId)
UIManager:callWindowFunc('UILingShanZhengDuoWin','refresh')
UIManager:callWindowFunc('UILingShanZTCJPageWin','refresh')
end
end

function UILSZDControl:reqDiscipleList(callbcak,ignoreTime)
local time=gameUtilityModel.getServerShortTime()
if ignoreTime or time>=self.nextReqTime then
self.nextReqTime=time+3600
socketManager:send_44_4()
self.reqDiscipleListCallback=callbcak
else
callbcak()
end
end

function UILSZDControl.recv_44_4(len,list)
if len>0 then
for i,v in ipairs(list)do
local pdata=UILSZDControl:getAreaPosDataById(v.mount_id,v.area_id,v.pos)
if pdata then
if v.disciple_list_len>0 then
for _,vv in ipairs(v.disciple_list)do
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(vv.dzAttrList)
end
end
pdata.disciple_list_len=v.disciple_list_len
pdata.disciple_list=v.disciple_list
pdata.fight=v.fight

UILSZDControl:recordLingShanDiZi(pdata,true)
else
logErr(FMT.fmt('不存在灵山队伍数据，无法设置队伍弟子数据 mount:{0} area:{1} pos:{2}',v.mount_id,v.area_id,v.pos))
end
end
end
if UILSZDControl.reqDiscipleListCallback then
UILSZDControl.reqDiscipleListCallback()
UILSZDControl.reqDiscipleListCallback=nil
end
end



function UILSZDControl:handleLingShanEntityData(ldData,cfg)
local model=cfg.model
local coordinates=cfg.coordinates
ldData.modelId=model[1]
ldData.scale=model[2]
ldData.radius=model[3]
ldData.x=coordinates[1]
ldData.y=coordinates[2]
ldData.clickOffset=model[4]
ldData.clickSize=model[5]

ldData.refreshData=function(self_,d)
self_.guildid=d.guildid
self_.guildid_str=tostring(self_.guildid)
end
ldData.setObjID=function(self_,ojbID)
self_.ojbID=ojbID
end
ldData.isAddEntity=function(self_)
return self_.ojbID~=nil
end

ldData.distance=function(self_,g_x,g_y)
return mathHelper.distance(g_x,g_y,self_.x,self_.y)
end

ldData.getWayTime=function(self_,g_x,g_y)
local dis=self_:distance(g_x,g_y)
local step=zhengzhanshanhaiModel:getPvEMoveStep()
return math.max(1,math.ceil(dis/step))
end

ldData.checkIn=function(self_,g_x,g_y)
return mathHelper.isInRadius(g_x,g_y,self_.x,self_.y,self_.radius)
end
end



function UILSZDControl:getLingShanInfo(mtype)
return self.lingShanInfo[mtype]
end

function UILSZDControl:recordLingShanDiZi(data,isAdd)
if not data.disciple_list_len or data.disciple_list_len<=0 then
return
end
for i,v in ipairs(data.disciple_list)do
if v.flag==1 then
local key=v.discipleguidStr
if not key then
key=tostring(v.discipleguid)
v.discipleguidStr=key
end
if isAdd then
self.lingShanDiZiDict[key]=v
else
self.lingShanDiZiDict[key]=nil
end
end
end
end

function UILSZDControl:isDiZiInLingShan(key)
return self.lingShanDiZiDict[key]~=nil
end

function UILSZDControl:isForbidDisciple(mountType,guid)
if mountType==1 then
if UIDiscipleModel:isSpecialDZEx(guid,discipleconfigFlag.forbidSuChenLingShan)then
return true
end
end
return false
end

function UILSZDControl:setDatas(dataList)

self.lingShanDiZiDict={}
local datas={}
for i,v in ipairs(dataList)do
local data={}
local fazeList={}
if v.faze_list then
for ii,vv in ipairs(v.faze_list)do
table.insert(fazeList,{id=vv.param_1,level=vv.param_2})
end
end
data.fazeList=fazeList
local areaData={{},{},{}}
if v.team_list then
for ii,vv in ipairs(v.team_list)do
local ad=areaData[vv.area_id]or{}
vv.mountId=v.mount_id
ad[vv.pos]=vv

areaData[vv.area_id]=ad
end
end
data.areaData=areaData
data.mountId=v.mount_id
local cfg=UILSZDControl:getLingShanConfig(v.mount_id)
data.mountType=cfg.mount_type
data.mountName=cfg.mount_name
self:handleLingShanEntityData(data,cfg)
datas[v.mount_id]=data
end
self.datas=datas
end

function UILSZDControl:getDatas()
return self.datas
end

function UILSZDControl:getDataById(mountId)
return self.datas[mountId]
end

function UILSZDControl:getDataByMountType(mountType)
local list={}
for k,v in pairs(self.datas)do
if v.mountType==mountType then
table.insert(list,v)
end
end
return list
end

function UILSZDControl:getAreaDataById(mountId,areaId)
local mountData=self:getDataById(mountId)
if mountData then
return mountData.areaData[areaId]
end
end

function UILSZDControl:getAreaPosDataById(mountId,areaId,pos)
local areaData=self:getAreaDataById(mountId,areaId)
if areaData then
return areaData[pos]
end
end

function UILSZDControl:getFaZeData(mountId)
local mountData=self:getDataById(mountId)
if mountData then
return mountData.fazeList
end
end

function UILSZDControl:getAllMyTeam(mtype)
local list={}
local playerId=playerModel:getActorID()
if mtype then
for k,v in pairs(self.datas)do
if v.mountType==mtype then
for kk,vv in pairs(v.areaData)do
for kkk,vvv in pairs(vv)do
if vvv.actor_id==playerId then
table.insert(list,vvv)
end
end
end
end
end
else
for k,v in pairs(self.datas)do
for kk,vv in pairs(v.areaData)do
for kkk,vvv in pairs(vv)do
if vvv.actor_id==playerId then
table.insert(list,vvv)
end
end
end
end
end
return list
end

function UILSZDControl:getTeamNumByMountType(mountType,checkXM)
local datas=self:getDataByMountType(mountType)
local count=0
for i,mdata in ipairs(datas)do
if checkXM then
for k,v in pairs(mdata.areaData)do
for kk,vv in pairs(v)do
if xianmengModel:isMyXM2(vv.guild_id)then
count=count+1
end
end
end
else
for k,v in pairs(mdata.areaData)do
for kk,vv in pairs(v)do
count=count+1
end
end
end
end
return count
end

function UILSZDControl:getMountTeamNum(mountId,checkXM)
local mdata=self:getDataById(mountId)
if not mdata then
return 0
end
local count=0
if checkXM then
for k,v in pairs(mdata.areaData)do
for kk,vv in pairs(v)do
if xianmengModel:isMyXM2(vv.guild_id)then
count=count+1
end
end
end
else
for k,v in pairs(mdata.areaData)do
for kk,vv in pairs(v)do
count=count+1
end
end
end
return count
end

function UILSZDControl:hasMyTeam(mountId,areaId)
local mdata=self:getDataById(mountId)
if not mdata then
return false
end
local pId=playerModel:getActorID()
if areaId then
local datas=mdata.areaData[areaId]
for kk,vv in pairs(datas)do
if vv.actor_id==pId then
return true
end
end
else
for k,v in pairs(mdata.areaData)do
for kk,vv in pairs(v)do
if vv.actor_id==pId then
return true
end
end
end
end
return false
end

function UILSZDControl:getMountAreaTeamNum(mountId,areaId)
local mdata=self:getDataById(mountId)
if not mdata then
return 0
end
local areaData=mdata.areaData[areaId]
if not areaData then
return 0
end
local count=0
for k,v in pairs(areaData)do
count=count+1
end
return count
end

function UILSZDControl:getMountMaxTeamNum(mountId)
local config=UILSZDControl:getLingShanConfig(mountId)
local versionId=pfwindowslController:getGameVersion()
local limit=config.set_up_team_limit[1]
if versionId and config.set_up_team_limit[versionId]then
limit=config.set_up_team_limit[versionId]
end
local count=limit[1]+limit[2]+limit[3]
return count
end

function UILSZDControl:getMountAreaMaxTeamNum(mountId,areaId)
local config=UILSZDControl:getLingShanConfig(mountId)
local versionId=pfwindowslController:getGameVersion()
local limit=config.set_up_team_limit
if versionId and config.set_up_team_limit[versionId]then
limit=config.set_up_team_limit[versionId]
end
local count=limit[areaId]
return count
end

function UILSZDControl:getLingShanConfig(mountId)
local cfg=cfgHelper.get1(cfg_lingshanbattlemountconfig_get,mountId)
return cfg
end

function UILSZDControl:refreshLingShanEntity(mountId)
local mdata=self:getDataById(mountId)
if not mdata then
return
end
local ent=zhengzhanshanhaiModel:getEntity(mdata.ojbID)
if ent then
ent:setTeamCount()
end
end

function UILSZDControl:getBuffInfo(buffData)
local buffType=buffData[1]
local cfg=cfgHelper.get1(cfg_lingshanbuffconfig_get,buffType)
local desc=FMT.fmt(cfg.desc,unpack(buffData[2]))
return cfg.icon,cfg.name,desc
end

function UILSZDControl:isLingShanOpen(checkPVP)
local id=zhengzhanshanhaiModel:getSHSeasonId()
if id==-1 then
return false
end
if not checkPVP then
local state=zhengzhanshanhaiModel:getLunState()
return state~=eZZSH_State.ePVPFight and state~=eZZSH_State.ePVPStandby
end
return true
end

function UILSZDControl:checkTeamLimit(mountType)
local teamMaxNum=cfgHelper.get2(cfg_lingshanbattlebaseconfig_get,1,'actor_team_limit')
local max=teamMaxNum
local teamDatas=UILSZDControl:getAllMyTeam()
local count=#teamDatas
return count<max
end

function UILSZDControl:getLingShanRecord(key,def)
local val=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLingShan,key,def)
return val
end

function UILSZDControl:setLingShanRecord(key,val)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLingShan,key,val)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLingShan)
end

function UILSZDControl:checkQingBaoReddot()
local flag=self:getLingShanRecord('LSZD_QB_FLAG',true)
return flag
end

function UILSZDControl:setQingBaoReddot()
self:setLingShanRecord('LSZD_QB_FLAG',false)
end

function UILSZDControl:countBuffArgs(buffType)

local args={0}
local datas=UILSZDControl:getDatas()
for mountId,mountData in pairs(datas)do
for areaId,areaData in pairs(mountData.areaData)do
for pos,teamData in pairs(areaData)do
if xianmengModel:isMyXM2(teamData.guild_id)then
local mcfg=UILSZDControl:getLingShanConfig(mountId)
local buffs=mcfg.set_up_buff[areaId]
for i,v in ipairs(buffs)do
if v[1]==buffType then
for ii,vv in ipairs(v[2])do
local val=args[ii]or 0
val=val+vv
args[ii]=val
end
end
end
end
end
end
end
return args
end
















function UILSZDControl:handleFight(mountId,areaId,pos,flag)
flag=flag or 0
local config=UILSZDControl:getLingShanConfig(mountId)
local mount_type=config.mount_type
local versionId=pfwindowslController:getGameVersion()
local monster_group=config.monster_group[1]
if versionId and config.monster_group[versionId]then
monster_group=config.monster_group[versionId]
end
local mgData=monster_group[areaId][pos]
local mgId=mgData[1]
local mcfg=cfgHelper.get1(cfg_monstergroup_get,mgId)
local title='灵山问道'
local faZeData=UILSZDControl:getFaZeData(mountId)
local fzlist={}
if faZeData then
for i,v in ipairs(faZeData)do
table.insert(fzlist,v.id)
end
end
if mgData[2]then
table.insert(fzlist,mgData[2][1])
end
local checkDZSortFunc=function(guid)
local check=UILSZDControl:isDiZiInLingShan(tostring(guid))
if check then
return false
end
local check2=UILSZDControl:isForbidDisciple(mount_type,guid)
if check2 then
return false
end
return true
end
zhengzhanshanhaiController:setFigthReady(true)
local args={
enterTxt=title,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
isHomeBattle=true,




groupId=mgId,

showZhenFa=false,
faZeData=fzlist,
statePriorityCheck=false,
isCheckLingShanState=true,
lsMountType=config.mount_type,
checkDZSortFunc=checkDZSortFunc,
enterCallBack=function(teamList,zfId)

local pdata=UILSZDControl:getAreaPosDataById(mountId,areaId,pos)
if pdata then
local xmId=xianmengModel:getMyXMGuildID()
if xmId==pdata.guild_id then
UIManager.info('盟友无法挑战')
return
else
if pdata.battle_flag==1 then
local protectTime=cfgHelper.get2(cfg_lingshanbattlebaseconfig_get,1,'protect_sec')
local currtime=gameUtilityModel.getServerShortTime()
local dtime=currtime-pdata.set_up_sec
if dtime<protectTime then
UIManager.info('该位置处于保护期')
return
end
end
end
end
fightLaunchController:sendFight(eBattleLaunch.lingShanZhengDuo,teamList,nil,zfId,{mountId,areaId,pos})
end,
cancelCallBack=function()
UILSZDControl:showLSZDWinEx({mountId=mountId,areaId=areaId},true)
end,
}

if flag==0 then
args.monsterList=mcfg.monList
else
local list={}
local pdata=UILSZDControl:getAreaPosDataById(mountId,areaId,pos)
local disciple_list=pdata.disciple_list or{}
for i,v in ipairs(disciple_list)do
if v.flag==1 then
local data={
pos=i,
typo=fightEntityType.diZi,
guid=v.discipleguid,
netData=v
}
table.insert(list,data)
end
end
args.monsterListEx=list
end

if mount_type==1 then
args.dzSelectTips='素尘灵山只可上阵普通弟子'
end

fightController.showPrepareWin(fightPreSelectModel.fightType.lingShanZhengDuo,args)
end