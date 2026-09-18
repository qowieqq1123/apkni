






local _MODULENAME="TeZhiTuJianModel"


def_table(_MODULENAME)
TeZhiTuJianModel.name=_MODULENAME
TeZhiTuJianModel.data={}

local FilterCdnType={
eActive=1,
eNotActive=2,
eFight_effects=3,
eBuild_effects=4,
eGrow_effects=5,
eSearch_effects=6,
eSpecial_effects=7,
}

local effectKeyList={
{"fight_effects","战斗类",FilterCdnType.eFight_effects},
{"build_effects","经营类",FilterCdnType.eBuild_effects},
{"grow_effects","成长类",FilterCdnType.eGrow_effects},
{"search_effects","探索类",FilterCdnType.eSearch_effects},
{"special_effects","特殊类",FilterCdnType.eSpecial_effects},
}
TeZhiTuJianModel.TempState={
eNone=0,
eRecved=1,
eNotRecv=2,
eRecv=3,
}

addSpeType=
{
item=1,
normal=2,
home=3,
mountain=4,
}


function TeZhiTuJianModel:onAppStart()

end


function TeZhiTuJianModel:onEnterState(isReconnect)
self.lookupData={}
self:initBookIdToSpeId()
self:initBookIdActiveState()
end


function TeZhiTuJianModel:onProtocolReq()

end


function TeZhiTuJianModel:onLeaveState(isReconnect)

self.data={}
self.config=nil
self.config2=nil
self:clearSpeData()
end



function TeZhiTuJianModel:setData(data)
self.data=data
end

function TeZhiTuJianModel:getData()
if not self.data then
self.data={}
end
return self.data
end

function TeZhiTuJianModel:getDataIdx()
local data=self:getData()
if not data.target_idx then
data.target_idx=0
end
return data.target_idx
end


function TeZhiTuJianModel:checkChildReddot()












return self.lookupData.sysReddot==true
end

function TeZhiTuJianModel:checkShowTypeReddot(showType)











return self.lookupData.typeReddot[showType]==true
end

function TeZhiTuJianModel:checkStageProReddot()









return self.lookupData.proReddot==true
end

function TeZhiTuJianModel:getAllRecvCount()













return self.lookupData.allrecvcount,2
end

function TeZhiTuJianModel:getAllActiveJiFen()













return self.lookupData.allActiveJiFen or 0
end

function TeZhiTuJianModel:getFirstNotRecvJiFen()











return self.lookupData.fisrttagetNum or 0
end

function TeZhiTuJianModel:checkTuJianActive(book_id)
local state=self:getTuJianState(book_id)
return state~=TeZhiTuJianModel.TempState.eNotRecv
end

function TeZhiTuJianModel:getTuJianState(book_id)
local data=self:getData()
if not data.book_list then
data.book_list={}
end
if data.book_list[book_id]==1 then
return TeZhiTuJianModel.TempState.eRecv
elseif data.book_list[book_id]==2 then
return TeZhiTuJianModel.TempState.eRecved
end
return TeZhiTuJianModel.TempState.eNotRecv
end

function TeZhiTuJianModel:getTypePro(showType)
local cfg=self:getConfigLoolup()
local typeCfg=cfg[showType]
local childList=typeCfg.childList
local maxCount=#childList
local curCount=0
for i,v in ipairs(childList)do
if self:checkTuJianActive(v.id)then
curCount=curCount+1
end
end
return curCount,maxCount
end



















local FilterCdnFun={
[FilterCdnType.eActive]=function(childTemp)
local book_id=childTemp.id
return TeZhiTuJianModel:checkTuJianActive(book_id)
end,
[FilterCdnType.eNotActive]=function(childTemp)
local book_id=childTemp.id
return not TeZhiTuJianModel:checkTuJianActive(book_id)
end,
[FilterCdnType.eFight_effects]=function(childTemp)
return childTemp.fight_effects~=nil
end,
[FilterCdnType.eBuild_effects]=function(childTemp)
return childTemp.build_effects~=nil
end,
[FilterCdnType.eGrow_effects]=function(childTemp)
return childTemp.grow_effects~=nil
end,
[FilterCdnType.eSearch_effects]=function(childTemp)
return childTemp.search_effects~=nil
end,
[FilterCdnType.eSpecial_effects]=function(childTemp)
return childTemp.special_effects~=nil
end,
}
function TeZhiTuJianModel:getSortChildList(showType,sortCnd)
local cfg=self:getConfigLoolup()
local typeCfg=cfg[showType]
local childList=typeCfg.childList
local tempList=table.deepCopy(childList)
local sortChildList={}
if sortCnd then
for i,v in ipairs(tempList)do
local cdnFlag=true
for ii,vv in ipairs(sortCnd)do
if not FilterCdnFun[vv](v)then
cdnFlag=false
break
end
end
if cdnFlag then
table.insert(sortChildList,v)
end
end
else
sortChildList=tempList
end
for i,v in ipairs(sortChildList)do
local book_id=v.id
local spetype=v.type
local speid=v.spe_id
local sorts={}
if UIDiscipleModel.checkSpecialityLove(spetype,speid)then
sorts[1]=1
else
sorts[1]=0
end
local n=0
local state=self:getTuJianState(book_id)
if state==TeZhiTuJianModel.TempState.eRecv then
n=3
elseif state==TeZhiTuJianModel.TempState.eRecved then
n=2
elseif state==TeZhiTuJianModel.TempState.eNotRecv then
n=1
end
sorts[2]=n
sorts[3]=10000-book_id
v.sorts=sorts
end
mathHelper.sortWeightList(sortChildList)


return sortChildList
end

function TeZhiTuJianModel:getConfigLoolup()
if not self.config then
self:initConfig()
end
return self.config,self.len,self.configIndexlookup,self.config2
end

function TeZhiTuJianModel:getConfigLoolup2()
if not self.config then
self:initConfig()
end
return self.config2
end

function TeZhiTuJianModel:getCofig(spetype,speid)
if self.config2 then
if self.config2[spetype]then
return self.config2[spetype][speid]
end
end
end


function TeZhiTuJianModel:hideShowFlag(id,hideShowFlag)
if not hideShowFlag or hideShowFlag~=1 then
return true
end
local stage=TeZhiTuJianModel:getTuJianState(id)
return stage~=TeZhiTuJianModel.TempState.eNotRecv
end

function TeZhiTuJianModel:getTeZhiCfg(spetype,speid)
if spetype==DISCIPLE_SPECIALITY_TYPE.eSpiritRoot then
return cfg_disciplespiritrootbookconfig_get(speid)
else
return UIDiscipleModel:getSpecialityConfig(spetype,speid)
end
end

function TeZhiTuJianModel:initConfig()
self.config={}
self.config2={}
self.configIndexlookup={}
local cfg=cfg_disciplespecialitybookconfig()
local showType
local len=0
for k,v in pairs(cfg)do

if(not v.hideFlag or v.hideFlag~=1)and TeZhiTuJianModel:hideShowFlag(v.id,v.hideShowFlag)then
local typeCfg=cfg_disciplespecialitytypeconfig_get(v.type)
showType=typeCfg.showType
if not self.config[showType]then
len=len+1
self.configIndexlookup[len]=showType
local temp={}
temp.name=typeCfg.showTypeName
temp.showType=showType
temp.childList={}
temp.effectList={}
temp.filterName={}
temp.filterFlag={}
temp.filterName[1]={
'状态',
{
{name='激活',cdnType=FilterCdnType.eActive},
{name='未激活',cdnType=FilterCdnType.eNotActive},
},
}

temp.filterFlag[1]={
false,
false,
}
temp.filterName[2]={
'特质加成',
{},
}

temp.filterFlag[2]={}
self.config[showType]=temp
end
local spetype=v.type
local speid=v.spe_id
local childTemp={}
childTemp.childIndex=#self.config[showType].childList+1
childTemp.showType=showType
childTemp.id=v.id
childTemp.type=spetype
childTemp.spe_id=speid
childTemp.active_reward=v.active_reward
childTemp.point=v.point
childTemp.getDesc=v.desc
childTemp.canLove=v.canLove
if childTemp.canLove==nil then
childTemp.canLove=true
end
local specialityConfig=TeZhiTuJianModel:getTeZhiCfg(spetype,speid)
childTemp.effects_desc_overseas=specialityConfig.effects_desc_overseas
childTemp.effects_desc=specialityConfig.effects_desc_tujian or specialityConfig.effects_desc
childTemp.effects_adddesc=specialityConfig.effects_adddesc_tujian or specialityConfig.effects_adddesc
childTemp.framecolor=specialityConfig.framecolor
childTemp.name=v.name or specialityConfig.name
childTemp.nameEx=specialityConfig.name
childTemp.fight_effects=specialityConfig.fight_effects
childTemp.build_effects=specialityConfig.build_effects
childTemp.grow_effects=specialityConfig.grow_effects
childTemp.search_effects=specialityConfig.search_effects
childTemp.special_effects=specialityConfig.special_effects
if self.config2[spetype]==nil then
self.config2[spetype]={}
end
self.config2[spetype][speid]=childTemp
for ii,vv in ipairs(effectKeyList)do
if specialityConfig[vv[1]]and not self.config[showType].effectList[vv[1]]then
self.config[showType].effectList[vv[1]]=vv
local filterNameTemp={name=vv[2],cdnType=vv[3]}
table.insert(self.config[showType].filterName[2][2],filterNameTemp)
table.insert(self.config[showType].filterFlag[2],false)
end
end
table.insert(self.config[showType].childList,childTemp)
end
end
self.len=len
table.sort(self.configIndexlookup,function(a,b)
return a<b
end)
end



function TeZhiTuJianModel:clearSpeData()
self.speList=nil
self.checkList=nil
self.activeStateList=nil
self.activeStateList=nil
end


function TeZhiTuJianModel:initBookIdToSpeId()
self.speList={}
local config=cfg_disciplespecialitybookconfig()

for k,v in pairs(config)do
local bookId=v.id
local type=v.type
local speId=v.spe_id

if not self.speList[type]then
self.speList[type]={}
end
if not self.speList[type][speId]then
self.speList[type][speId]={}
end

self.speList[type][speId]=bookId
end

end


function TeZhiTuJianModel:initBookIdActiveState()
if self.activeStateList then
return
end

self.activeStateList={}
local config=cfg_disciplespecialitybookconfig()

for k,v in pairs(config)do
local bookId=v.id
self.activeStateList[bookId]=0
end

end


function TeZhiTuJianModel:setBookIdActiveState(bookId,state)
if not self.activeStateList then
self.activeStateList={}
end

self.activeStateList[bookId]=state
end


function TeZhiTuJianModel:getBookIdActiveState(bookId)
if not self.activeStateList then
self.activeStateList={}
end

return self.activeStateList[bookId]
end

function TeZhiTuJianModel:getbookIdBySpeTypo(typo,id)
if not self.speList then return nil end
if not self.speList[typo]or not self.speList[typo][id]then return nil end

return self.speList[typo][id]
end

function TeZhiTuJianModel:judgeIsApply(typo,id)
local id=tostring(id)
local typo=tostring(typo)

if not self.checkList then
self.checkList={}
end

if not self.checkList[typo]then
self.checkList[typo]={}
end

if not self.checkList[typo][id]then
self.checkList[typo][id]=true
return true
end

return false
end

function TeZhiTuJianModel:checkOneIsHaveSpeCanActive(data,type,tempList,guid,isSystemOpen)
local netData=data
local desclist=UIDiscipleModel:getDiscipleSpecialityConfigByData(netData,true)

if not desclist then
local str=string.format("检查类型：%s--弟子%s读取不到特质列表，请联系前端排查！！！",type,netData.disciplename)
logErr(str)
return
end

for k,v in ipairs(desclist)do
local id=v.id
local typo=v.typo
if v.srid then id=v.srid end


if typo==1 then
local disciple_guid=netData.discipleguid
local data=UIDiscipleModel:getDiscipleLingGenData(disciple_guid)

if data then
for k,v in ipairs(data)do
if v.type==id and v.varyState==1 then
id=id+5
end
end
end
end

if typo==7 and isSystemOpen then
TeZhiTuJianController.onDiscipleSpecialityChange(guid,typo,id)
end

local bookId=self:getbookIdBySpeTypo(typo,id)

if bookId then
if self:getBookIdActiveState(bookId)==0 then
local flag=self:judgeIsApply(typo,id)
if flag then
local temp={type,guid,typo,id}
table.insert(tempList,temp)
end
end
end
end

return tempList
end

function TeZhiTuJianModel:checkIsHaveSpeCanActive(dataList,type,len,index,guid,isSystemOpen)
if not TeZhiTuJianController:checkSysOpen()then
return
end

local list={}
if len>1 then
for i=1,len do

local data
local guid=guid
if not guid then guid=int64.new(i)end

if type==addSpeType.normal then
data=dataList[i].discipleInfo
elseif type==addSpeType.mountain then
data=dataList[i]
end

local temp=self:checkOneIsHaveSpeCanActive(data,type,list,guid,isSystemOpen)
list=temp
end
else
local guid=guid
local data=dataList
if not guid then guid=int64.new(index)end
local temp=self:checkOneIsHaveSpeCanActive(data,type,list,guid,isSystemOpen)
list=temp
end


if next(list)then
local len=#list
TeZhiTuJianController.req_2_149(len,list)
end
end

function TeZhiTuJianModel:checkSpecialityLoveReddot()
local flag=userActorSetting.get('specialityLoveFisrt',false)
return flag==false
end

function TeZhiTuJianModel:recordSpecialityLoveFisrt()
userActorSetting.set('specialityLoveFisrt',true)
userActorSetting.flush(true)
notifySystem:postNotify(notifyConfig.onTeZhiTujianReddotChange)
end

function TeZhiTuJianModel:refreshLookup()
self.lookupData.sysReddot=false
self.lookupData.typeReddot={}

local cfg=self:getConfigLoolup()
local childList,state
local num=0
local count=0
for k,v in pairs(cfg)do
childList=v.childList
self.lookupData.typeReddot[k]=false
for ii,vv in ipairs(childList)do
state=self:getTuJianState(vv.id)
if state==TeZhiTuJianModel.TempState.eRecv then
self.lookupData.sysReddot=true
self.lookupData.typeReddot[k]=true
count=count+1
elseif state==TeZhiTuJianModel.TempState.eRecved then
num=num+vv.point
end
end
end
self.lookupData.proReddot=false
local cfg=cfg_disciplespebookrewardconfig()
local target_idx=self:getDataIdx()
local tagetNum=nil
for i,v in ipairs(cfg)do
if num>=v.point and v.id>target_idx and not self.lookupData.proReddot then
self.lookupData.proReddot=true
end
if v.id>target_idx and not tagetNum then
tagetNum=v.point
end
if self.lookupData.proReddot and tagetNum then
break
end
end

tagetNum=tagetNum or cfg[#cfg].point

self.lookupData.allActiveJiFen=num
self.lookupData.allrecvcount=count
self.lookupData.fisrttagetNum=tagetNum
end