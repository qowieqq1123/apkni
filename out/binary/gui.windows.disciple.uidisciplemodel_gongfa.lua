







function UIDiscipleModel:getDiscipleGFData(guid,gfID)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.gongfaListlookup[gfID]
end

function UIDiscipleModel:getDiscipleGFDataEx(netData,gfID)
return netData.gongfaListlookup[gfID]
end

function UIDiscipleModel:isDiscipleLearnGF(guid,gfID)
return UIDiscipleModel:getDiscipleGFData(guid,gfID)~=nil
end

function UIDiscipleModel:getDiscipleAllGFData(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.gongfaList or{}
end

function UIDiscipleModel:getDiscipleAllGFNum(guid)
local list=UIDiscipleModel:getDiscipleAllGFData(guid)
return#list
end

function UIDiscipleModel:getDiscipleGFLevel(guid,gfID)
local gfData=UIDiscipleModel:getDiscipleGFData(guid,gfID)
if gfData then
return gfData.param_2
end
return 0
end

function UIDiscipleModel:getDiscipleGFLevelEx(netData,gfID)
local gfData=UIDiscipleModel:getDiscipleGFDataEx(netData,gfID)
if gfData then
return gfData.param_2
end
return 0
end

function UIDiscipleModel:getDiscipleSlotGFData(netData,slotIdx)
local slotGFID=netData.gongfaidList[slotIdx]
if slotGFID~=nil and slotGFID>0 then
local gfData=UIDiscipleModel:getDiscipleGFDataEx(netData,slotGFID)
return gfData
end
end

function UIDiscipleModel:checkDiscipleGFSlotCanUp(netData,slotIdx)
local minNeed=100000
if not moneyModel.checkEnoughMoney(eMoneyType.mtChuanDao,minNeed)then

return false
end

local gfData=UIDiscipleModel:getDiscipleSlotGFData(netData,slotIdx)
if gfData then
local gfID=gfData.param_1
local gfLv=gfData.param_2
local gfExp=gfData.param_3
local gfMaxLv=UIGongFaModel:getGFMaxLevel(gfID)
if gfLv<gfMaxLv then
local gfMaxExp=cfgHelper.get3(cfg_disciplegongfaconfig_get,gfID,'exp',gfLv)
local need=gfMaxExp-gfExp
if need>0 and moneyModel.checkEnoughMoney(eMoneyType.mtChuanDao,need)then
return true
end
end
end
return false
end

function UIDiscipleModel:checkDiscipleGFCanUpById(dis_guid,gfID)
if not UIDiscipleModel:isDiscipleGFUsing(dis_guid,gfID)then

return false
end

local minNeed=100000
if not moneyModel.checkEnoughMoney(eMoneyType.mtChuanDao,minNeed)then

return false
end

local gfData=UIDiscipleModel:getDiscipleGFData(dis_guid,gfID)
if gfData then
local gfID=gfData.param_1
local gfLv=gfData.param_2
local gfExp=gfData.param_3
local gfMaxLv=UIGongFaModel:getGFMaxLevel(gfID)
if gfLv<gfMaxLv then
local gfMaxExp=cfgHelper.get3(cfg_disciplegongfaconfig_get,gfID,'exp',gfLv)
local need=gfMaxExp-gfExp
if need>0 and moneyModel.checkEnoughMoney(eMoneyType.mtChuanDao,need)then
return true
end
end
end
return false
end

function UIDiscipleModel:checkDiscipleGFSlotCanSetup(netData,slotIdx)
local slotGFID=netData.gongfaidList[slotIdx]
if slotGFID==nil then return false end
local jjlv=netData.jingjielv
if slotGFID==0 then
local unlock,limitjj=UIDiscipleModel.checkGFPosUnLock(slotIdx,jjlv,false)
if not unlock then return false end


local gongfaList=netData.gongfaList
if gongfaList~=nil then
for i,v in ipairs(gongfaList)do
if netData.gongfaUsinglookup[v.param_1]==nil then
return true
end
end
end


local dis_guid=netData.discipleguid
if dis_guid then
return gongfaLookup:checkCanLearnGongFaReddot(dis_guid)
end
end
return false
end

function UIDiscipleModel:isDiscipleGFUsing(guid,gfID)
local pos=UIDiscipleModel:getDiscipleGFUsingPos(guid,gfID)
return pos~=nil
end

function UIDiscipleModel:getDiscipleGFUsingPos(guid,gfID)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.gongfaUsinglookup[gfID]
end

function UIDiscipleModel:getDiscipleUsingGFList(netData)
return netData.gongfaidList
end

function UIDiscipleModel:getDiscipleUnusingGFList(guid)
local list={}
local netData=UIDiscipleModel:getDiscipleData(guid)
local all=netData.gongfaList
if all~=nil and#all>0 then
for i,v in ipairs(all)do
local gfID=v.param_1
if netData.gongfaUsinglookup[gfID]==nil then
table.insert(list,gfID)
end
end
end
return list
end


function UIDiscipleModel:getDiscipleUnuseGFPos(netData)
local poslist={}
local list=UIDiscipleModel:getDiscipleUsingGFList(netData)
for i,v in ipairs(list)do
if v==0 then
local unlock=UIDiscipleModel.checkGFPosUnLock(i,netData.jingjielv,false)
if unlock then
table.insert(poslist,i)
end
end
end
return poslist
end


function UIDiscipleModel:getDiscipleUsingGFSkillList(guid,changLv)
local result={}
local netData=UIDiscipleModel:getDiscipleData(guid)
local gongfaidList=netData.gongfaidList
for i,v in ipairs(gongfaidList)do
local gfID=v
if gfID>0 then
local gflv=UIDiscipleModel:getDiscipleGFLevel(guid,gfID)
local levels=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'level')
local level=levels[gflv]
local skills=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'skill')
for i1,skillID in ipairs(skills)do
local lv=level[i1]
if changLv then
lv=UIDiscipleModel:getSkillLv(guid,skillID,lv)
end
result[#result+1]={skillID,lv}
end
end
end
return result
end

function UIDiscipleModel:getDiscipleUsingGFSkillList2(guid)
local result={}
local netData=UIDiscipleModel:getDiscipleData(guid)
local gongfaidList=netData.gongfaidList
for i,v in ipairs(gongfaidList)do
local gfID=v
if gfID>0 then
local skills=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'skill')
for i1,skillID in ipairs(skills)do
result[#result+1]={gfID,skillID,i1}
end
end
end
return result
end

function UIDiscipleModel:getDiscipleUsingGFSkillList2Ex(netData)
local result={}
local gongfaidList=netData.gongfaidList
for i,v in ipairs(gongfaidList)do
local gfID=v
if gfID>0 then
local skills=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'skill')
for i1,skillID in ipairs(skills)do
result[#result+1]={gfID,skillID,i1}
end
end
end
return result
end

function UIDiscipleModel:getDiscipleStudyGFSkillList(guid)
local result={}
local gongfaidList=UIGongFaModel:getDiscipleAllStudyGF(guid)
if#gongfaidList>0 then
for i,v in ipairs(gongfaidList)do
local gfID=v[1]
local studylv=v[2]
local skills=UIGongFaModel:getGFStudySkillList(gfID,studylv)
if skills~=nil and#skills>0 then
for i1,v1 in ipairs(skills)do
result[#result+1]=v1
end
end
end
end
return result
end

function UIDiscipleModel:discipleSetupGongFa(guid,pos,gfID)
local netData=UIDiscipleModel:getDiscipleData(guid)
local gongfaidList=netData.gongfaidList
local isSetup=gfID>0
local oldpos=nil
if isSetup then

oldpos=netData.gongfaUsinglookup[gfID]

local oldgfid=gongfaidList[pos]
if oldgfid>0 then
gongfaidList[pos]=0
netData.gongfaUsinglookup[oldgfid]=nil
end
if oldpos~=nil and oldpos~=pos then
gongfaidList[oldpos]=0
end
gongfaidList[pos]=gfID
netData.gongfaUsinglookup[gfID]=pos

if UIGongFaModel:checkGFHasBDSkill(oldgfid)or UIGongFaModel:checkGFHasBDSkill(gfID)then
UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eGongFa,true)
end
else

local oldgfid=gongfaidList[pos]
if oldgfid>0 then
gongfaidList[pos]=0
netData.gongfaUsinglookup[oldgfid]=nil
end

if UIGongFaModel:checkGFHasBDSkill(oldgfid)then
UIDiscipleModel:setDiscipleAttrListDirtyX(guid,DISCIPLE_ATTRIBUTE_TYPE.eGongFa,true)
end
end
return oldpos
end

function UIDiscipleModel:discipleLearnGongFa(guid,gfID)
local netData=UIDiscipleModel:getDiscipleData(guid)
local gongfaList=netData.gongfaList
if netData.gongfaList==nil then
netData.gongfaList={}
end
local d={param_1=gfID,param_2=1,param_3=0}
table_insert(netData.gongfaList,d)
netData.gongfaListlookup[gfID]=d
end

function UIDiscipleModel:discipleForgetGongFa(guid,gfID)
local netData=UIDiscipleModel:getDiscipleData(guid)
local gongfaList=netData.gongfaList
if netData.gongfaList==nil then
return
end
if netData.gongfaListlookup[gfID]~=nil then
netData.gongfaListlookup[gfID]=nil
for i,v in ipairs(netData.gongfaList)do
if v.param_1==gfID then
table.remove(netData.gongfaList,i)
break
end
end
end

local pos=UIDiscipleModel:getDiscipleGFUsingPos(guid,gfID)
if pos then
UIDiscipleModel:discipleSetupGongFa(guid,pos,0)
end
return pos
end


function UIDiscipleModel:getGFStudySkillLvPlus()
local lookup={}
local activeList=UIGongFaModel:getAcitveGFList()
for gfID,gfData in pairs(activeList)do
local studylv=UIGongFaModel:getStudyLevel(gfID)
local pluslist=UIGongFaModel:getGFStudySkillLvPlus(gfID,studylv)
if pluslist then
for i2,v2 in ipairs(pluslist)do
local skillId=v2[1]
local skillLv=v2[2]
if lookup[skillId]==nil then
lookup[skillId]=skillLv
else
lookup[skillId]=lookup[skillId]+skillLv
end
end
end
end
return lookup
end

function UIDiscipleModel.checkGFPosUnLock(pos,jjlv,isWarning)
local poslimit=cfgHelper.getdef1(cfg_disciplegongfaconfig,'poslimit')
local limitjj=poslimit[pos]
if limitjj~=nil then
if jjlv<limitjj then
if isWarning then
UIManager.error(FMT.fmt('弟子境界需达到{0}',UIDiscipleModel.getJJNameCommon(limitjj,3)))
end
return false,limitjj
end
end
return true
end

function UIDiscipleModel:getHasGongFaDZNum(gfID)
if gfID~=0 then
return dataControl:getValue(DATA_TYPE.dzGfCount,SUB_DATA_TYPE.eDZGD_1,gfID)or 0
end

local all=UIDiscipleModel:getAllDiscipleDataX()
local num=0
if all then
for k,v in pairs(all)do
local netData=v.netData.net
local gongfaidList=netData.gongfaidList
for pos,gfID_ in ipairs(gongfaidList)do
if gfID_>0 then
num=num+1
break
end
end
end
end
return num
end

function UIDiscipleModel:getHasGongFaNumDZNum(gf_num)
gf_num=gf_num or 0
local num=dataControl:getValue(DATA_TYPE.dzGfCount,SUB_DATA_TYPE.eDZGD_2,0)or 0
if gf_num<=0 then return num end
local list=dataControl:getList(DATA_TYPE.dzGfCount,SUB_DATA_TYPE.eDZGD_2)
return dataControl:getBiggerListCount(list,gf_num)
end


function UIDiscipleModel:getHasGongFaLevelDZNum(gfID,gfLv)
local num=0
local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
for k,v in pairs(all)do
local netData=v.netData.net
local gongfaidList=netData.gongfaidList
for pos,gfID_ in ipairs(gongfaidList)do
if gfID==0 then
if gfID_>0 then
local gfLv_=UIDiscipleModel:getDiscipleGFLevel(netData.discipleguid,gfID_)
if gfLv_>=gfLv then
num=num+1
break
end
end
else
if gfID_==gfID then
local gfLv_=UIDiscipleModel:getDiscipleGFLevel(netData.discipleguid,gfID_)
if gfLv_>=gfLv then
num=num+1
break
end
end
end
end
end
end
return num
end