








zhengzhanshanhaiModel.ShanHaiYbdData={}

function zhengzhanshanhaiModel:onEnterStateModelYBD(isReconnet)
self.ShanHaiYbdData={}
end


function zhengzhanshanhaiModel:onLeaveStateModelYBD(isReconnet)

self.ShanHaiYbdData={}
end



function zhengzhanshanhaiModel:initShanHaiYbdData(data)

self.ShanHaiYbdData={}
self.ShanHaiYbdData.openflag=data[1]or 1
self.ShanHaiYbdData.ybdmoney=data[2]or 0
self.ShanHaiYbdData.ybdstage=data[3]or 1
self.ShanHaiYbdData.guildlist={}
self.ShanHaiYbdData.allguildlist={}
self.ShanHaiYbdData.playerlist={}
self.ShanHaiYbdData.guild={}
if data[4]>0 and data[5]then

local isNill=true
for k,v in ipairs(data[5])do
if v and tonumber(tostring(v))~=0 then
isNill=false
break
end
end
if isNill then
self.ShanHaiYbdData.guildlist={}
else
self.ShanHaiYbdData.guildlist=data[5]
for k,v in ipairs(self.ShanHaiYbdData.guildlist)do
self.ShanHaiYbdData.guild[tostring(v)]=true
end

end
end
end


function zhengzhanshanhaiModel:getybd_openflag()
return self.ShanHaiYbdData.openflag or 0
end

function zhengzhanshanhaiModel:getybd_ybdmoney()
return self.ShanHaiYbdData.ybdmoney
end

function zhengzhanshanhaiModel:getybd_ybdstage()
return self.ShanHaiYbdData.ybdstage or 0
end

function zhengzhanshanhaiModel:getybd_guildlist()
return self.ShanHaiYbdData.guildlist
end

function zhengzhanshanhaiModel:getybd_Allguildlist()
return self.ShanHaiYbdData.allguildlist
end

function zhengzhanshanhaiModel:getybd_playerlist()
return self.ShanHaiYbdData.playerlist
end



function zhengzhanshanhaiModel:setybd_openflag(openflag)
self.ShanHaiYbdData.openflag=openflag
end

function zhengzhanshanhaiModel:setybd_ybdmoney(ybdmoney)
self.ShanHaiYbdData.ybdmoney=ybdmoney
end

function zhengzhanshanhaiModel:setybd_ybdstage(ybdstage)
self.ShanHaiYbdData.ybdstage=ybdstage
end

function zhengzhanshanhaiModel:setybd_guildlist(len,guildlist)
if len>0 and guildlist then
local isNill=true
for k,v in ipairs(guildlist)do
if v and tonumber(tostring(v))~=0 then
isNill=false
break
end
end
if isNill then
self.ShanHaiYbdData.guildlist={}
else
self.ShanHaiYbdData.guildlist=guildlist
end
else
self.ShanHaiYbdData.guildlist={}
end
if self.ShanHaiYbdData.guildlist and next(self.ShanHaiYbdData.guildlist)then
self.ShanHaiYbdData.guild={}
for k,v in ipairs(self.ShanHaiYbdData.guildlist)do
self.ShanHaiYbdData.guild[tostring(v)]=true
end
end
end

function zhengzhanshanhaiModel:setybd_Allguildlist(len,allguildlist)
if len>0 and allguildlist then
self.ShanHaiYbdData.playerlist={}

for k,v in ipairs(allguildlist)do
local _fight_num=0
local dzlist=v.discipleList or{}
for i,j in ipairs(dzlist)do
if j and j.flag and j.flag>0 then
_fight_num=_fight_num+tonumber(tostring(j.fightvalue))
end
end
v.fight_num=_fight_num
end
self.ShanHaiYbdData.allguildlist=allguildlist
else
self.ShanHaiYbdData.allguildlist={}
end
end

function zhengzhanshanhaiModel:setybd_playerlist(guid,len,playerlist)
if len>0 and playerlist then
if not self.ShanHaiYbdData.playerlist then
self.ShanHaiYbdData.playerlist={}
end
local isfresh=false
for k,v in ipairs(playerlist)do
local _playguid=v.param_1
local _playflag=v.param_2
local id=tostring(_playguid)


if _playflag==0 then
isfresh=true
local temp=
{
playguid=_playguid,
playflag=_playflag,
qbguid=guid,
playchuzhan=true,
}
self.ShanHaiYbdData.playerlist[id]=temp
elseif _playflag==1 then
UIManager.info("非本盟成员")
elseif _playflag==2 then
UIManager.info("对方已关闭")
elseif _playflag==3 then
UIManager.info("对方山海令预存不足")
elseif _playflag==4 then
UIManager.info("对方设置阶数较高")
elseif _playflag==5 then
UIManager.info("对方队伍已被占用")
elseif _playflag==6 then
UIManager.info("对方无设置预备队")
elseif _playflag==7 then
UIManager.info("对方今日已参与")
elseif _playflag==8 then
UIManager.info("集结已满员")
elseif _playflag==9 then
UIManager.info("对方外派队伍超限")
end
end

if isfresh then
UIManager:invokeUIMethod("UIXMZZSH_YuBeiDuiMainWin","refreshDZlist")
UIManager:invokeUIMethod("UIXMZZSH_YuBeiDuiMainWin","refreshtemnum")
end

end
end


function zhengzhanshanhaiModel:setybd_playerflag(playguid,flag)
local playerlist=zhengzhanshanhaiModel:getybd_playerlist()

if playerlist then
if playerlist[playguid]then
playerlist[playguid].playchuzhan=flag

UIManager:invokeUIMethod("UIXMZZSH_YuBeiDuiMainWin","refreshDZlist")
UIManager:invokeUIMethod("UIXMZZSH_YuBeiDuiMainWin","refreshtemnum")
end
end
end








function zhengzhanshanhaiModel:checkDZFreeSelfYBD(guid,iswarning)
local isfree=zhengzhanshanhaiModel:checkDZFree(guid,iswarning)
return isfree
end


function zhengzhanshanhaiModel:setqbguid(qbguid)
self.ShanHaiYbdData.qbguid=qbguid
end
function zhengzhanshanhaiModel:getqbguid()
return self.ShanHaiYbdData.qbguid
end


function zhengzhanshanhaiModel:setkitoutplayerid(playerid)
self.ShanHaiYbdData.qbplayerid=playerid
end
function zhengzhanshanhaiModel:getkitoutplayerid()
return self.ShanHaiYbdData.qbplayerid
end


function zhengzhanshanhaiModel:checkIsSetZZSHYbd()
local selflist=zhengzhanshanhaiModel:getybd_guildlist()
if selflist and next(selflist)then
return true
end
return false
end


function zhengzhanshanhaiModel:checkIsZZSHYbd_DZ(diziguid)
local selflist=zhengzhanshanhaiModel:getybd_guildlist()
if selflist and next(selflist)then
return self.ShanHaiYbdData.guild[tostring(diziguid)]or false
end
return false
end