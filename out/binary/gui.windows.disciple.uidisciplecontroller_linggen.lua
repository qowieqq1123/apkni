





function UIDiscipleController:onAppStart_linggen()
socketManager:register_receiver(2,131,UIDiscipleController.do_protocol_2_131)
socketManager:register_receiver(2,132,UIDiscipleController.do_protocol_2_132)
socketManager:register_receiver(2,133,UIDiscipleController.do_protocol_2_133)
socketManager:register_receiver(2,134,UIDiscipleController.do_protocol_2_134)
socketManager:register_receiver(2,135,UIDiscipleController.do_protocol_2_135)
socketManager:register_receiver(2,136,UIDiscipleController.do_protocol_2_136)
socketManager:register_receiver(2,137,UIDiscipleController.do_protocol_2_137)
socketManager:register_receiver(2,140,UIDiscipleController.do_protocol_2_140)
end

function UIDiscipleController:onEnterState_linggen()
notifySystem:listenNotify(notifyConfig.onDiscipleGongFaChange,self.onDiscipleGongFaChange)

UIDiscipleModel:initHiddenSkillLookup()
end

function UIDiscipleController:onLeaveState_linggen()
notifySystem:removelistener(notifyConfig.onDiscipleGongFaChange,self.onDiscipleGongFaChange)
end



function UIDiscipleController:do_send_2_131(dz_guid,linggen_id)
socketManager:send_2_131(dz_guid,linggen_id)
end


function UIDiscipleController:do_send_2_132(dz_guid,linggen_id)
socketManager:send_2_132(dz_guid,linggen_id)
end


function UIDiscipleController:do_send_2_133(dz_guid,linggen_id)
socketManager:send_2_133(dz_guid,linggen_id)
end


function UIDiscipleController:do_send_2_134(dz_guid,linggen_id)
socketManager:send_2_134(dz_guid,linggen_id)
end


function UIDiscipleController:do_send_2_135(dz_guid,pos,free,sureState,useitemid)
socketManager:send_2_135(dz_guid,pos,free,sureState,useitemid)
end


function UIDiscipleController:do_send_2_136(dz_guid,pos,idx,giveuppos)
giveuppos=giveuppos or 0
socketManager:send_2_136(dz_guid,pos,idx,giveuppos)
end


function UIDiscipleController:do_send_2_137(dz_guid)
socketManager:send_2_137(dz_guid)
end


function UIDiscipleController:do_send_2_140(dz_guid,pos,free,ensure,itemid,times,len,list)
socketManager:send_2_140(dz_guid,pos,free,ensure,itemid,times,len,list)
end



function UIDiscipleController.do_protocol_2_131(dz_guid,linggen_id,linggen_lv)
local strGuid=tostring(dz_guid)
local lglist=UIDiscipleModel:getDiscipleSpeciality(strGuid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
if lglist==nil then return end

for k,v in pairs(lglist)do
if v.param_1==linggen_id then
v.param_2=linggen_lv
break
end
end

UIDiscipleModel:resetEffectTypoLookup(strGuid)
notifySystem:postNotify(notifyConfig.onDiscipleLingGenUpLevel,strGuid,linggen_id,linggen_lv)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleSpriteRoot)

UIDiscipleController.refreshDiscipleLingGenEffect(dz_guid)

AudioManager.playAudio(634)
end


function UIDiscipleController.do_protocol_2_132(dz_guid,linggen_id,linggen_lv)
local strGuid=tostring(dz_guid)
local lglist=UIDiscipleModel:getDiscipleSpeciality(strGuid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
if lglist==nil then return end

for k,v in pairs(lglist)do
if v.param_1==linggen_id then
v.param_2=linggen_lv
break
end
end


UIDiscipleModel:resetEffectTypoLookup(strGuid)
notifySystem:postNotify(notifyConfig.onDiscipleLingGenResetLevel,strGuid,linggen_id,linggen_lv)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleSpriteRoot)

UIDiscipleController.refreshDiscipleLingGenEffect(dz_guid)
end



function UIDiscipleController.do_protocol_2_133(dz_guid,linggen_id,vary)
local strGuid=tostring(dz_guid)
local lglist=UIDiscipleModel:getDiscipleSpeciality(dz_guid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
if lglist==nil then return end

for k,v in pairs(lglist)do
if v.param_1==linggen_id then
v.param_3=vary
break
end
end

UIDiscipleModel:resetEffectTypoLookup(strGuid)
dzSpecialityEffectManager.onDiscipleLingGenVary(dz_guid)
notifySystem:postNotify(notifyConfig.onDiscipleLingGenVary,dz_guid,linggen_id,vary)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleSpriteRoot)

UIDiscipleController.refreshDiscipleLingGenEffect(dz_guid)
end


function UIDiscipleController.do_protocol_2_134(dz_guid,linggen_id)
local netData=UIDiscipleModel:getDiscipleData(dz_guid)
if netData==nil then return end

if netData.varysrid>0 then
local lglist,lglist_lookup,lglen=UIDiscipleModel:getDiscipleLingGenData(dz_guid)
local averageLv=UIDiscipleModel:getLingGenAverageMaxLevel(dz_guid)
local lglv=lglist_lookup[netData.varysrid].source.param_2
lglist_lookup[netData.varysrid].source.param_2=Mathf.Min(averageLv,lglv)
end

netData.varysrid=linggen_id

dzSpecialityEffectManager.onDiscipleLingGenChangeVary(dz_guid)
notifySystem:postNotify(notifyConfig.onDiscipleLingGenChangeVary,dz_guid,linggen_id)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleSpriteRoot)

UIDiscipleController.refreshDiscipleLingGenEffect(dz_guid)
end



function UIDiscipleController.do_protocol_2_135(dz_guid,pos,free,randlistlen,randlist)
local netData=UIDiscipleModel:getDiscipleData(dz_guid)
if netData==nil then return end

netData.randhoardpos=pos
netData.randhoardlistlen=randlistlen
netData.randHoardList=randlist

local hoardList=netData.hoardList or{}
local hasHoard=false
for k,v in pairs(hoardList)do
if v.pos==pos then
hasHoard=true
if v.activelistlen==0 then
v.activeList={}
end
end
end
if not hasHoard then
table.insert(hoardList,{pos=pos,activelistlen=0,activeList={}})
end


notifySystem:postNotify(notifyConfig.onDiscipleLingGenRandomBoard,dz_guid,pos)
end



function UIDiscipleController.do_protocol_2_136(dz_guid,pos,idx,giveuppos)
local netData=UIDiscipleModel:getDiscipleData(dz_guid)
if netData==nil or netData.randHoardList==nil then return end

local data
local hoardList=netData.hoardList or{}
local ischange=false
for k,v in pairs(hoardList)do
if v.pos==pos then
v.activelistlen=1
v.activeList={[1]=table.deepCopy(netData.randHoardList[idx])}
ischange=true
data=v
break
end
end
if not ischange then
local temp={}
temp.pos=pos
temp.activelistlen=1
temp.activeList={[1]=table.deepCopy(netData.randHoardList[idx])}
table.insert(hoardList,temp)
data=temp
end
netData.hoardList=hoardList
netData.randhoardpos=0
netData.randhoardlistlen=0
netData.randHoardList=nil

if giveuppos~=0 then
UIDiscipleModel:resetHiddenSkill(dz_guid,giveuppos)
end

notifySystem:postNotify(notifyConfig.onDiscipleLingGenEquipBoard,dz_guid,pos,data)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleSpriteRoot)


UIDiscipleController.refreshDiscipleLingGenEffect(dz_guid)
end

function UIDiscipleController.do_protocol_2_137(dz_guid)
local netData=UIDiscipleModel:getDiscipleData(dz_guid)
if netData==nil or netData.randHoardList==nil then return end

local pos=netData.randhoardpos
local hoardList=netData.hoardList or{}
local ischange=false
for k,v in pairs(hoardList)do
if v.pos==pos then
ischange=true
break
end
end
if not ischange then
local temp={}
temp.pos=pos
temp.activelistlen=0
table.insert(hoardList,temp)
end
netData.hoardList=hoardList

netData.randhoardpos=0
netData.randhoardlistlen=0
netData.randHoardList={}

notifySystem:postNotify(notifyConfig.onDiscipleLingGenGiveUpBoard,dz_guid)
end

function UIDiscipleController.do_protocol_2_140(args)
local discipleguid=args[1]
local pos=args[2]
local free=args[3]
local randlistlen=args[4]
local randList=args[5]or{}
local times=args[6]

local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

netData.randhoardpos=pos
netData.randhoardlistlen=randlistlen
netData.randHoardList=randList

local hoardList=netData.hoardList or{}
local hasHoard=false
for k,v in pairs(hoardList)do
if v.pos==pos then
hasHoard=true
if v.activelistlen==0 then
v.activeList={}
end
end
end
if not hasHoard then
table.insert(hoardList,{pos=pos,activelistlen=0,activeList={}})
end


notifySystem:postNotify(notifyConfig.onDiscipleLingGenQuickFind,discipleguid,pos,times)
end

function UIDiscipleController.refreshDiscipleLingGenEffect(guid)

UIDiscipleModel:refreshVaryLingGenSkillLookup(guid)


UIDiscipleModel:setSkillLvPlusLookupDirty(guid,true)


UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eVaryLingGen,true)

UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eSkill,true)

end

function UIDiscipleController.onDiscipleGongFaChange(discipleguid,pos,gongfaid)
UIDiscipleController.refreshDiscipleLingGenEffect(discipleguid)
end
