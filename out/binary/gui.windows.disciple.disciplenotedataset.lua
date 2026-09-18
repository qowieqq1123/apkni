











discipleNoteDataSet={}

local datalist_sp
local datelist_jk
local saveKeySP='discipleSPNoteData'
local saveKeyJK='discipleJKNoteData'
local sp_notes_maxnum=100
local jk_notes_maxnum=100
local table_insert=table.insert
local table_remove=table.remove
local table_sort=table.sort



function discipleNoteDataSet:initData()
datelist_jk={}
datalist_sp={}
end

function discipleNoteDataSet:initJKData()
local t_datas=userActorSetting.get(saveKeyJK,nil)
local datas

if t_datas~=nil then
datas=t_datas
userActorSetting.flushVal(saveKeyJK,nil)
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eDZNote,saveKeyJK,datas)
else
datas=userActorArraySetting.get(ACTOR_SETTING_TYPE.eDZNote,saveKeyJK,nil)
end
if datas then
for guidkey,notelist in pairs(datas)do
if notelist~=nil and#notelist>0 then
datelist_jk[guidkey]=notelist
end
end
end
end

function discipleNoteDataSet:initSPData()
local flag=0
local t_datas=userActorSetting.get(saveKeySP,nil)
local datas

if t_datas~=nil then
datas=t_datas
userActorSetting.flushVal(saveKeySP,nil)
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eDZNote,saveKeySP,datas)
else
datas=userActorArraySetting.get(ACTOR_SETTING_TYPE.eDZNote,saveKeySP,nil)
end
local clearlist={}
if datas then
local disciplelist={}
local timelist={}
for guidkey,notelist in pairs(datas)do
local dis_guid=int64.new(guidkey)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if netData~=nil then
local tkey=#timelist+1
if notelist~=nil and#notelist>0 then

table_insert(disciplelist,dis_guid)
datalist_sp[guidkey]=notelist
for idx,notedata in ipairs(notelist)do
if timelist[tkey]then
if notedata.time>timelist[tkey]then
timelist[tkey]=notedata.time
end
else
timelist[tkey]=notedata.time
end
end
else

timelist[tkey]=0
end
else
table.insert(clearlist,guidkey)
end
end


if#disciplelist>0 then
discipleNoteController:reqSPData(#disciplelist,disciplelist,#timelist,timelist)
flag=1
end
else
local list=UIDiscipleModel:getAllDiscipleData()
local disciplelist={}
local timelist={}
for k,v in pairs(list)do
table_insert(disciplelist,v.netData.net.discipleguid)
table_insert(timelist,0)
end
if#disciplelist>0 then
discipleNoteController:reqSPData(#disciplelist,disciplelist,#timelist,timelist)
flag=1
end
end
if#clearlist>0 then
for i,guidkey in ipairs(clearlist)do
datas[guidkey]=nil
end
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eDZNote,saveKeySP,datas)
end
return flag
end

function discipleNoteDataSet:rec_SPDataList(datalist)
local ischange=false
for idx,disciplenote in ipairs(datalist)do
if disciplenote.lslist~=nil then
local disciplekey=tostring(disciplenote.discipleguid)

datalist_sp[disciplekey]={}
for idx2,notedata in ipairs(disciplenote.lslist)do
local d={}
d.time=notedata.time
d.descid=notedata.descid
d.intlist=notedata.intlist
d.stringlist=notedata.stringlist
d.indexlist=notedata.indexlist
table_insert(datalist_sp[disciplekey],d)
end
ischange=true
end
end
if ischange then

userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eDZNote,saveKeySP,datalist_sp)
end
end

function discipleNoteDataSet:clear()
datalist_sp=nil
datelist_jk=nil
end

function discipleNoteDataSet:setData(disguid,time,descid,intlist,stringlist,indexlist)
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
if cfg.groupType==discipleNoteGroupType.eSP then
discipleNoteDataSet:setSPData(disguid,time,descid,intlist,stringlist,indexlist)
else
discipleNoteDataSet:setJKData(disguid,time,descid,intlist,stringlist,indexlist)
end
end

function discipleNoteDataSet:setSPData(disguid,time,descid,intlist,stringlist,indexlist)
local guid_key=tostring(disguid)
local list=nil
if datalist_sp[guid_key]then
list=datalist_sp[guid_key]
local max=sp_notes_maxnum
if#list>=max then
table_remove(list,1)
end
else
list={}
datalist_sp[guid_key]=list
end
local d={}
d.time=time
d.descid=descid
d.intlist=intlist
d.stringlist=stringlist
d.indexlist=indexlist
table_insert(list,d)


userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eDZNote,saveKeySP,datalist_sp)


local intlistlen=0
if intlist then
intlistlen=#intlist
end
local stringlistlen=0
if stringlist then
stringlistlen=#stringlist
end
local indexlistlen=0
if indexlist then
indexlistlen=#indexlist
end
discipleNoteController:reqSPStorage(disguid,time,descid,intlistlen,intlist,stringlistlen,stringlist,indexlistlen,indexlist)
end

function discipleNoteDataSet:setJKData(disguid,time,descid,intlist,stringlist,indexlist)
local guid_key=tostring(disguid)
local list=nil
if datelist_jk[guid_key]then
list=datelist_jk[guid_key]
local max=sp_notes_maxnum
if#list>=max then
table_remove(list,1)
end
else
list={}
datelist_jk[guid_key]=list
end
local d={}
d.time=time
d.descid=descid
d.intlist=intlist
d.stringlist=stringlist
d.indexlist=indexlist
table_insert(list,d)


userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eDZNote,saveKeyJK,datelist_jk)
end

function discipleNoteDataSet:getNoteList(disguid)
local guid_key=tostring(disguid)
local list={}
if datalist_sp[guid_key]then
for idx,notedata in pairs(datalist_sp[guid_key])do
table_insert(list,notedata)
end
end
if datelist_jk[guid_key]then
for idx,notedata in pairs(datelist_jk[guid_key])do
table_insert(list,notedata)
end
end
if#list>0 then
table_sort(list,function(a,b)
return a.time>b.time
end)
end
return list
end

function discipleNoteDataSet:getSPNoteList(disguid)
local guid_key=tostring(disguid)
local list={}
if datalist_sp[guid_key]then
for idx,notedata in pairs(datalist_sp[guid_key])do
table_insert(list,notedata)
end
end
if#list>0 then
table_sort(list,function(a,b)
return a.time>b.time
end)
end
return list
end


function discipleNoteDataSet:checkNewDiscipleByNote(disguid)
local list=discipleNoteDataSet:getSPNoteList(disguid)
return#list<=0
end