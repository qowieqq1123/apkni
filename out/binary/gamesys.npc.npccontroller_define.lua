







NPC_GROUP_TYPE={
eWorld=1,
eZongMen=2,
}

local npcBattleMapConfig={
[NPC_GROUP_TYPE.eWorld]={
[0]=840002,
[1]=840001,
[2]=840002,
[3]=840003,
},
[NPC_GROUP_TYPE.eZongMen]={
[0]=840002,
},
}


NPC_TYPE={
eWorld=1,
eZongmen=2,
eWorldRandom=3,
eZongmenRandom=4,

isWorldNPC=function(self_,v)
return v==self_.eWorld or v==self_.eWorldRandom
end,
isZongMenNPC=function(self_,v)
return v==self_.eZongmen or v==self_.eZongmenRandom
end,
getNPCGroupType=function(self_,v)
if self_:isWorldNPC(v)then
return NPC_GROUP_TYPE.eWorld
elseif self_:isZongMenNPC(v)then
return NPC_GROUP_TYPE.eZongMen
end
return nil
end,
}


NPC_INTERACT_TYPE={
eAskfor=1,
eSteal=2,
eTalk=3,
ePK=4,
eGift=5,
eGame=6,
}


local npInteractLimit={

[NPC_INTERACT_TYPE.eAskfor]={
getMax=function(npcid)
return 1
end,
},

[NPC_INTERACT_TYPE.eSteal]={
getMax=function(npcid)
return 1
end,
},

[NPC_INTERACT_TYPE.eTalk]={
getMax=function(npcid)
return 1
end,
},

[NPC_INTERACT_TYPE.ePK]={
getMax=function(npcid)
return 1
end,
checkCond=function(npcid)
local time=npcModel:getNPCLastFightTime(npcid)
return not timeHelper.checkInSameWeek4(time)
end
},

[NPC_INTERACT_TYPE.eGift]={
getMax=function(npcid)
return npcModel:getNPCMaxGiftHaoGanDu(npcid)
end,
},

[NPC_INTERACT_TYPE.eGame]={
getMax=function(npcid)
return 1
end,
},
}
local npInteractNames={
[NPC_INTERACT_TYPE.eAskfor]='索要',
[NPC_INTERACT_TYPE.eSteal]='窃取',
[NPC_INTERACT_TYPE.eTalk]='对话',
[NPC_INTERACT_TYPE.ePK]='切磋',
[NPC_INTERACT_TYPE.eGift]='送礼',
[NPC_INTERACT_TYPE.eGame]='考验',
}
local npInteractTips={
[NPC_INTERACT_TYPE.eAskfor]='今天已进行过索要',
[NPC_INTERACT_TYPE.eSteal]='今天已进行过窃取',
[NPC_INTERACT_TYPE.eTalk]='今天已进行过谈话',
[NPC_INTERACT_TYPE.ePK]='本周已进行过切磋',
[NPC_INTERACT_TYPE.eGift]='对方表示装不下礼物了',
[NPC_INTERACT_TYPE.eGame]='今天已进行过考验',
}


local sendNPCDataLookup={

[NPC_INTERACT_TYPE.eAskfor]=function(otherData)



return{otherData.interacttype,otherData.guid}
end,

[NPC_INTERACT_TYPE.eSteal]=function(otherData)



return{otherData.interacttype,otherData.guid}
end,

[NPC_INTERACT_TYPE.eTalk]=function(otherData)



return{otherData.interacttype,otherData.rewardidx}
end,

[NPC_INTERACT_TYPE.ePK]=function(otherData)


return{otherData.interacttype}
end,

[NPC_INTERACT_TYPE.eGift]=function(otherData)






return{otherData.interacttype,#otherData.list,otherData.list}
end,

[NPC_INTERACT_TYPE.eGame]=function(otherData)



return{otherData.interacttype,otherData.rewardidx}
end,
}

local recNPCDataLookup={

[NPC_INTERACT_TYPE.eAskfor]=function(npcid,otherData)




local itemguid=otherData.guid
npcController:askforNPCBack(npcid,itemguid)
end,

[NPC_INTERACT_TYPE.eSteal]=function(npcid,otherData)





local itemguid=otherData.guid
local injury=otherData.injury
npcController:stealNPCBack(npcid,itemguid,injury)
end,

[NPC_INTERACT_TYPE.eTalk]=function(npcid,otherData)



local goodlist=npcController:getTempRewad()
if goodlist~=nil and#goodlist>0 then
local goodlist_=table.deepCopy(goodlist)
showPrizeControl.showWindow(goodlist_)
end
npcController.showIntimacyChange()
UIManager:invokeUIMethod('UINPCInteractWin','rec_talk')
end,

[NPC_INTERACT_TYPE.ePK]=function(npcid,otherData)




end,

[NPC_INTERACT_TYPE.eGift]=function(npcid,otherData)


npcController.showIntimacyChange()
local cavs=UIManager:invokeUIMethod('UINPCGiftSelectWin','getTalkCanvas')
local str=npcModel:getNPCGiftTalk(npcid)or''
npcController:worldInteractNPCTalk(str,5,cavs)

UIManager:invokeUIMethod('UINPCInteractWin','rec_gift')
UIManager:invokeUIMethod('UINPCGiftSelectWin','rec_gift')
end,

[NPC_INTERACT_TYPE.eGame]=function(npcid,otherData)




UIManager:invokeUIMethod('UINPCInteractWin','rec_game')

local func=function()


end
local goodlist=npcController:getTempRewad()
if goodlist~=nil and#goodlist>0 then
local goodlist_=table.deepCopy(goodlist)
showPrizeControl.showWindow(goodlist_,func)
else
func()
end

end,
}

function npcController:getSendHandle(interacttype)
local sendHandle=sendNPCDataLookup[interacttype]
if sendHandle==nil then
logErr(FMT.fmt('没有处理发送npc访问类型{0}数据的解码器',interacttype))
return nil
else
return sendHandle
end
end

function npcController:getRecvHandle(interacttype)
local recHandle=recNPCDataLookup[interacttype]
if recHandle==nil then
logErr(FMT.fmt('没有处理接收npc访问类型{0}数据的解码器',interacttype))
end
return recHandle
end

function npcController:getInteractMaxNum(interacttype,npcid)
local lp=npInteractLimit[interacttype]
return lp.getMax(npcid)
end

function npcController:checkInteractNumCond(interacttype,npcid)
local lp=npInteractLimit[interacttype]
local checkCond=lp.checkCond
if checkCond then
return checkCond(npcid)
end
return true
end

function npcController:getInteractName(interacttype)
return npInteractNames[interacttype]
end

function npcController:getInteractTips(interacttype)
return npInteractTips[interacttype]
end

function npcController:getNPCBattleMapId(npcData)
local groupType=NPC_TYPE:getNPCGroupType(npcData.npctype)
local cfg=npcBattleMapConfig[groupType]
if groupType==NPC_GROUP_TYPE.eWorld then
return cfg[npcData.worldid]or cfg[0]
elseif groupType==NPC_GROUP_TYPE.eZongMen then
return cfg[npcData.sfid]or cfg[0]
end
end