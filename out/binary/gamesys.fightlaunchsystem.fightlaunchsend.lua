









local _MODULENAME="fightLaunchSend"




def_table(_MODULENAME)
fightLaunchSend.name=_MODULENAME

local send={

[eBattleLaunch.zongmenMonster]=function(eTpye,id,guid)
return{eTpye,id,guid}
end,

[eBattleLaunch.monsterInvade]=function(eTpye,id)
return{eTpye,id}
end,

[eBattleLaunch.shilianta]=function(eType,layer)
return{eType,layer}
end,

[eBattleLaunch.wudaotang]=function(eType,guid)
return{eType,guid}
end,

[eBattleLaunch.doufatai]=function(eType,subType,dftRobotType,dftRobotId)
return{eType,subType,dftRobotType,dftRobotId}
end,

[eBattleLaunch.mystery]=function(eType,childType,entityList)
return{eType,childType,#entityList,entityList}
end,





[eBattleLaunch.experience]=function(eType,point)
return{eType,point}
end,

[eBattleLaunch.worldMonster]=function(eTpye,areaid,dataidx)
return{eTpye,areaid,dataidx}
end,

[eBattleLaunch.resPoint]=function(eType,world,guid,subIdx)
return{eType,world,guid,subIdx}
end,

[eBattleLaunch.family]=function(eType,subType,world,guid)
return{eType,subType,world,guid}
end,

[eBattleLaunch.qiyuEvent]=function(eType,sysId,monLen,mons,qyguid,resultIndex,choiceEventGroupId,qiyuClient)
return{eType,sysId,monLen,mons,qyguid,resultIndex,choiceEventGroupId,qiyuClient}
end,

[eBattleLaunch.npcPK]=function(eType,npctype,npcid)
return{eType,npctype,npcid}
end,

[eBattleLaunch.tuitu]=function(eType,id)
return{eType,id}
end,
[eBattleLaunch.huanjing]=function(eType,id,ftype,is_assistant)
return{eType,id,ftype,is_assistant or 0}
end,
[eBattleLaunch.lingShanZhengDuo]=function(eType,mountId,areaId,pos)
return{eType,mountId,areaId,pos}
end,

[eBattleLaunch.tianyuanshouchao]=function(eType,monType,gwzId,guid,is_assistant)
return{eType,monType,gwzId,guid,is_assistant or 0}
end,

[eBattleLaunch.xianmengdigong]=function(eType,x,y,nanDu)



return{eType,x,y,nanDu}
end,

[eBattleLaunch.fabaoshilian]=function(eType,actid,subid,monidx)
return{eType,actid,subid,monidx}
end,

[eBattleLaunch.worldLeader]=function(eType,is_assistant)
return{eType,is_assistant or 0}
end,

[eBattleLaunch.jiucengyaolou]=function(eType,actid,actType,subid,floor,citiaoListlen,citiaoList)
return{eType,actid,actType,subid,floor,citiaoListlen,citiaoList}
end,

[eBattleLaunch.zongmendabi]=function(eType,actid,actType,subid,select_idx)
return{eType,actid,actType,subid,select_idx}
end,

[eBattleLaunch.lingxuwenjian]=function(eType,lxwjtype,lxwjkey)
return{eType,lxwjtype,lxwjkey}
end,

[eBattleLaunch.xianfawendao]=function(eType,index,flag)
return{eType,index,flag}
end,

[eBattleLaunch.yunchengtanbao]=function(eType,actid,actType,subid)
return{eType,actid,actType,subid}
end,

[eBattleLaunch.qiecuo]=function(eType,severid,actorid)
return{eType,severid,actorid}
end,

[eBattleLaunch.wuxingdian]=function(...)
return{...}
end,

[eBattleLaunch.tianmoruqin_tm]=function(eType,actId,subType,subId,monsterGuid)
return{eType,actId,subType,subId,monsterGuid}
end,

[eBattleLaunch.tianmoruqin_sj]=function(eType,actId,subType,subId,aimidx,idx)
return{eType,actId,subType,subId,aimidx,idx}
end,

[eBattleLaunch.taigushilian]=function(eType,actId,subType,subId,bossidx,nanduidx)
return{eType,actId,subType,subId,bossidx,nanduidx}
end,

[eBattleLaunch.yunyouMerchant]=function(eType)
return{eType,-1}
end,

[eBattleLaunch.visitorChallenge]=function(eType)
return{eType,-1}
end,

[eBattleLaunch.fuyaoshilian]=function(eType,actId,subType,subId,bossidx,nanduidx)
return{eType,actId,subType,subId,bossidx,nanduidx}
end,

[eBattleLaunch.houshanzhenling]=function(eType,eZlType,eLayer)
return{eType,eZlType,eLayer}
end,

[eBattleLaunch.longhuxiangyao]=function(eType,actId,subType,subId,monIndex)
return{eType,actId,subType,subId,monIndex}
end,

[eBattleLaunch.sifangpingyao]=function(eType,demons_point)
return{eType,demons_point}
end,
[eBattleLaunch.dujiexiandan]=function(eType)
return{eType,-1}
end,

[eBattleLaunch.zhenyaoshilian]=function(eType,actid,actType,subid,bossidx)
return{eType,actid,actType,subid,bossidx}
end,

[eBattleLaunch.tianmojie]=function(eType,actorId,monsterGuid)
return{eType,actorId,monsterGuid}
end,

[eBattleLaunch.xianjiePlotMonster]=function(eType,cloudid,plotIdx,march)
return{eType,cloudid,plotIdx,march}
end,

[eBattleLaunch.xunbaoshilian]=function(eType,chapterId,trainingIdx,isDifficulty)
return{eType,chapterId,trainingIdx,isDifficulty}
end,

[eBattleLaunch.wdcqxiweisai]=function(eType,group,pos)
return{eType,group,pos}
end,

[eBattleLaunch.xianjieResPoint]=function(eType,guid,json,sceneidx,x,z)
return{eType,guid,json,sceneidx,x,z}
end,

[eBattleLaunch.xianjieFuMo]=function(eType,is_assistant)
return{eType,is_assistant or 0}
end,

[eBattleLaunch.jiuyouta]=function(eType,layer_id)
return{eType,layer_id}
end,

[eBattleLaunch.gubaoshilian]=function(eType,actId,subType,subId)
return{eType,actId,subType,subId}
end,

[eBattleLaunch.yanfage]=function(eType,dzGuidListLen,dzGuidList)
return{eType,dzGuidListLen,dzGuidList}
end,

[eBattleLaunch.xianjunyanzhen]=function(eType,gx_id,mon_groub_idx,boat_len,boatList,xiushi_len,xiushiList)
return{eType,gx_id,mon_groub_idx,boat_len,boatList,xiushi_len,xiushiList}
end,

[eBattleLaunch.activitiesPushMap]=function(eType,index)
return{eType,index}
end,

[eBattleLaunch.xjCaravanEscort]=function(eType,guid,flag)
return{eType,guid,flag}
end,

[eBattleLaunch.mingyuanzhusha]=function(eType)
return{eType,-1}
end,
}

function fightLaunchSend:getHandle(eType)
return send[eType]
end




