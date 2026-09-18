







discipleNoteModel={}

discipleNoteGroupType={
eSP=1,
eJK=2,
}

discipleNoteType={
eRuMen=1,
eJingJieLevel=2,
eLianTiLevel=3,
eJobLevel=4,
eEventInfo=5,
eLearnGongFa=6,
ePostChange=7,
eMakeFaBao=8,
eMakeSpeFaBao=9,
eMakeFuBao=10,
eInjury=11,
eShouYuan=12,
eSpeciality=13,
eNameChange=14,
eSystemZongMenExpelJoin=15,
}

local discipleNoteFunc={
[discipleNoteType.eRuMen]={
checkCond=function(...)return discipleNoteModel.checkCond_1(...)end,
setNote=function(...)return discipleNoteModel.setNote_1(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_1(...)end,
},
[discipleNoteType.eJingJieLevel]={
checkCond=function(...)return discipleNoteModel.checkCond_2(...)end,
setNote=function(...)return discipleNoteModel.setNote_2(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_2(...)end,
},
[discipleNoteType.eLianTiLevel]={
checkCond=function(...)return discipleNoteModel.checkCond_3(...)end,
setNote=function(...)return discipleNoteModel.setNote_3(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_3(...)end,
},
[discipleNoteType.eJobLevel]={
checkCond=function(...)return discipleNoteModel.checkCond_4(...)end,
setNote=function(...)return discipleNoteModel.setNote_4(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_4(...)end,
},
[discipleNoteType.eEventInfo]={
checkCond=function(...)return discipleNoteModel.checkCond_5(...)end,
setNote=function(...)return discipleNoteModel.setNote_5(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_5(...)end,
},
[discipleNoteType.eLearnGongFa]={
checkCond=function(...)return discipleNoteModel.checkCond_6(...)end,
setNote=function(...)return discipleNoteModel.setNote_6(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_6(...)end,
},
[discipleNoteType.ePostChange]={
checkCond=function(...)return discipleNoteModel.checkCond_7(...)end,
setNote=function(...)return discipleNoteModel.setNote_7(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_7(...)end,
},
[discipleNoteType.eMakeFaBao]={
checkCond=function(...)return discipleNoteModel.checkCond_8(...)end,
setNote=function(...)return discipleNoteModel.setNote_8(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_8(...)end,
},
[discipleNoteType.eMakeSpeFaBao]={
checkCond=function(...)return discipleNoteModel.checkCond_9(...)end,
setNote=function(...)return discipleNoteModel.setNote_9(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_9(...)end,
},
[discipleNoteType.eMakeFuBao]={
checkCond=function(...)return discipleNoteModel.checkCond_10(...)end,
setNote=function(...)return discipleNoteModel.setNote_10(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_10(...)end,
},
[discipleNoteType.eInjury]={
checkCond=function(...)return discipleNoteModel.checkCond_11(...)end,
setNote=function(...)return discipleNoteModel.setNote_11(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_11(...)end,
},
[discipleNoteType.eShouYuan]={
checkCond=function(...)return discipleNoteModel.checkCond_12(...)end,
setNote=function(...)return discipleNoteModel.setNote_12(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_12(...)end,
},
[discipleNoteType.eSpeciality]={
checkCond=function(...)return discipleNoteModel.checkCond_13(...)end,
setNote=function(...)return discipleNoteModel.setNote_13(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_13(...)end,
},
[discipleNoteType.eNameChange]={
checkCond=function(...)return discipleNoteModel.checkCond_14(...)end,
setNote=function(...)return discipleNoteModel.setNote_14(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_14(...)end,
},
[discipleNoteType.eSystemZongMenExpelJoin]={
checkCond=function(...)return discipleNoteModel.checkCond_15(...)end,
setNote=function(...)return discipleNoteModel.setNote_15(...)end,
getNoteDesc=function(...)return discipleNoteModel.getNoteDesc_15(...)end,
},
}

local discipleNoteTypeLookup={}

function discipleNoteModel.InitLookup()
discipleNoteTypeLookup={}
local cfgs=cfg_dizijianwenconfig()
for k,v in pairs(cfgs)do
local noteType=v.typeParams[1]
if discipleNoteTypeLookup[noteType]==nil then
discipleNoteTypeLookup[noteType]={}
end
table.insert(discipleNoteTypeLookup[noteType],v)
end
end

function discipleNoteModel.clear()
discipleNoteTypeLookup={}
end

function discipleNoteModel.checkNote(params)
if params.time==nil then
params.time=gameUtilityModel.getServerShortTime()
end
local noteType=params.noteType
local func=discipleNoteFunc[noteType]
if func then
local result=func.checkCond(params)
if result~=nil then








func.setNote(result,params)
end
end
end

function discipleNoteModel.getTimeDesc(time)
local create_time=gameUtilityModel.getPlayerCreateTime()
local lerp=time-create_time
if lerp<0 then



lerp=0
end
local str=tostring(gameUtilityModel.calculateGameYearCeil(lerp))
return str
end

function discipleNoteModel.getNoteDesc(disguid,notedata)
local desc_str
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
if cfg==nil then
return FMT.fmt('见闻id：{0}已删除',descid)
end
local noteType=cfg.typeParams[1]
local func=discipleNoteFunc[noteType]
if func then
desc_str=func.getNoteDesc(disguid,notedata)
end
return desc_str
end

function discipleNoteModel.setNoteParamsIndex(intlist,stringlist)
local indexlist={}
if intlist~=nil and#intlist>0 then
for i,v in ipairs(intlist)do
table.insert(indexlist,1)
end
end
if stringlist~=nil and#stringlist>0 then
for i,v in ipairs(stringlist)do
table.insert(indexlist,2)
end
end
return indexlist
end



function discipleNoteModel.checkCond_1(params)
local noteType=params.noteType
local lookup=discipleNoteTypeLookup[noteType]or{}
if lookup then
return lookup[1]
end
return nil
end

function discipleNoteModel.setNote_1(cfg,params)
local disguid=params.disguid
local time=params.time
local descid=cfg.id
local intlist={}
local stringlist={}
local indexlist=discipleNoteModel.setNoteParamsIndex(intlist,stringlist)
discipleNoteDataSet:setData(disguid,time,descid,intlist,stringlist,indexlist)
end

function discipleNoteModel.getNoteDesc_1(disguid,notedata)

local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)

local str=FMT.fmt(cfg.desc,timer_str,UISettingModel:getZMName())
return str
end




function discipleNoteModel.checkCond_2(params)
local noteType=params.noteType
local jjlv=params.jjlv
local lookup=discipleNoteTypeLookup[noteType]
if lookup then
for i,v in ipairs(lookup)do
if v.typeParams[2]==jjlv then
return v
end
end
end
return nil
end

function discipleNoteModel.setNote_2(cfg,params)
discipleNoteModel.setNote_1(cfg,params)
end

function discipleNoteModel.getNoteDesc_2(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)
local jjlv=cfg.typeParams[2]

local str=FMT.fmt(cfg.desc,timer_str,UIDiscipleModel:getJJNameEx(jjlv))
return str
end




function discipleNoteModel.checkCond_3(params)
local noteType=params.noteType
local ltlv=params.ltlv
local lookup=discipleNoteTypeLookup[noteType]
if lookup then
for i,v in ipairs(lookup)do
if v.typeParams[2]==ltlv then
return v
end
end
end
return nil
end

function discipleNoteModel.setNote_3(cfg,params)
discipleNoteModel.setNote_1(cfg,params)
end

function discipleNoteModel.getNoteDesc_3(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)
local ltlv=cfg.typeParams[2]

local str=FMT.fmt(cfg.desc,timer_str,UIDiscipleModel:getLTNameEx(ltlv))
return str
end




function discipleNoteModel.checkCond_4(params)
local noteType=params.noteType
local jobid=params.jobid
local joblv=params.joblv
local lookup=discipleNoteTypeLookup[noteType]
if lookup then
for i,v in ipairs(lookup)do
if v.typeParams[2]==jobid and v.typeParams[3]==joblv then
return v
end
end
end
return nil
end

function discipleNoteModel.setNote_4(cfg,params)
discipleNoteModel.setNote_1(cfg,params)
end

function discipleNoteModel.getNoteDesc_4(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)
local joblv=cfg.typeParams[3]

local str=FMT.fmt(cfg.desc,timer_str,joblv)
return str
end




function discipleNoteModel.checkCond_5(params)
return discipleNoteModel.checkCond_1(params)
end

function discipleNoteModel.setNote_5(cfg,params)
local disguid=params.disguid
local time=params.time
local descid=cfg.id
local intlist={}
local stringlist={params.txt}
local indexlist=discipleNoteModel.setNoteParamsIndex(intlist,stringlist)
discipleNoteDataSet:setData(disguid,time,descid,intlist,stringlist,indexlist)
end


function discipleNoteModel.getNoteDesc_5(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)
local stringlist=notedata.stringlist
local eventstr=stringlist[1]









local str=FMT.fmt(cfg.desc,timer_str,eventstr)
return str
end




function discipleNoteModel.checkCond_6(params)
local noteType=params.noteType
local gfid=params.gfid
local lookup=discipleNoteTypeLookup[noteType]
if lookup then
for i,v in ipairs(lookup)do
if v.typeParams[2]==gfid then
return v
end
end
end
return nil
end

function discipleNoteModel.setNote_6(cfg,params)
discipleNoteModel.setNote_1(cfg,params)
end

function discipleNoteModel.getNoteDesc_6(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)
local gfid=cfg.typeParams[2]
local gfname=cfgHelper.get(cfg_disciplegongfaconfig_get,gfid,'name')

local str=FMT.fmt(cfg.desc,timer_str,gfname)
return str
end




function discipleNoteModel.checkCond_7(params)
local noteType=params.noteType
local oldpostid=params.oldpostid
local newpostid=params.newpostid
local lookup=discipleNoteTypeLookup[noteType]
if lookup then
for i,v in ipairs(lookup)do
if v.typeParams[2]==oldpostid and v.typeParams[3]==newpostid then
return v
end
end
end
return nil
end

function discipleNoteModel.setNote_7(cfg,params)
discipleNoteModel.setNote_1(cfg,params)
end

function discipleNoteModel.getNoteDesc_7(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)
local oldpostid=cfg.typeParams[2]
local newpostid=cfg.typeParams[3]
local newpostname=eZongMenPostType.getName(newpostid)

local str=FMT.fmt(cfg.desc,timer_str,newpostname)
return str
end




function discipleNoteModel.checkCond_8(params)
local noteType=params.noteType
local fabaoid=params.fabaoid
local itemConfig=itemsConfig.getConfig(fabaoid)
local lookup=discipleNoteTypeLookup[noteType]
if lookup then
for i,v in ipairs(lookup)do
if v.typeParams[2]==itemConfig.color then
return v
end
end
end
return nil
end

function discipleNoteModel.setNote_8(cfg,params)
local disguid=params.disguid
local time=params.time
local descid=cfg.id
local intlist={}
local stringlist={params.fabaoname}
local indexlist=discipleNoteModel.setNoteParamsIndex(intlist,stringlist)
discipleNoteDataSet:setData(disguid,time,descid,intlist,stringlist,indexlist)
end

function discipleNoteModel.getNoteDesc_8(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)
local fbcolor=cfg.typeParams[2]
local fabaoname=notedata.stringlist[1]
local n=FMT.fmt('<{0}>',fabaoname)
local name_str=helper.getQColorString(fbcolor,n)

local str=FMT.fmt(cfg.desc,timer_str,name_str)
return str
end









function discipleNoteModel.checkCond_10(params)
local noteType=params.noteType
local fubaoid=params.fubaoid
local fubaocfg=itemsConfig.getConfig(fubaoid)
local lookup=discipleNoteTypeLookup[noteType]
if lookup then
for i,v in ipairs(lookup)do
if v.typeParams[2]==fubaocfg.color then
return v
end
end
end
return nil
end

function discipleNoteModel.setNote_10(cfg,params)
local disguid=params.disguid
local time=params.time
local descid=cfg.id
local intlist={}
local stringlist={params.fubaoname}
local indexlist=discipleNoteModel.setNoteParamsIndex(intlist,stringlist)
discipleNoteDataSet:setData(disguid,time,descid,intlist,stringlist,indexlist)
end

function discipleNoteModel.getNoteDesc_10(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)
local fbcolor=cfg.typeParams[2]
local fubaoname=notedata.stringlist[1]
local n=FMT.fmt('<{0}>',fubaoname)
local name_str=helper.getQColorString(fbcolor,n)

local str=FMT.fmt(cfg.desc,timer_str,name_str)
return str
end




function discipleNoteModel.checkCond_11(params)
local noteType=params.noteType
local disguid=params.disguid
local old_injury=params.old_injury
local cur_injury=params.cur_injury
local lookup=discipleNoteTypeLookup[noteType]
if lookup then
for i,v in ipairs(lookup)do
local injury=v.typeParams[2]
if old_injury<injury and cur_injury>=injury then
return v
end
end
end
return nil
end

function discipleNoteModel.setNote_11(cfg,params)
discipleNoteModel.setNote_1(cfg,params)
end

function discipleNoteModel.getNoteDesc_11(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)

local str=FMT.fmt(cfg.desc,timer_str)
return str
end




function discipleNoteModel.checkCond_12(params)
local noteType=params.noteType
local disguid=params.disguid
local old_shouyuan=params.old_shouyuan
local cur_shouyuan=params.cur_shouyuan
local lookup=discipleNoteTypeLookup[noteType]
if lookup then
for i,v in ipairs(lookup)do
local shouyuan=v.typeParams[2]
if old_shouyuan>shouyuan and cur_shouyuan<=shouyuan then
return v
end
end
end
return nil
end

function discipleNoteModel.setNote_12(cfg,params)
discipleNoteModel.setNote_1(cfg,params)
end

function discipleNoteModel.getNoteDesc_12(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)

local str=FMT.fmt(cfg.desc,timer_str)
return str
end




function discipleNoteModel.checkCond_13(params)
local noteType=params.noteType
local disguid=params.disguid
local specialityType=params.specialityType
local specialityID=params.specialityID
local flag=params.flag
local lookup=discipleNoteTypeLookup[noteType]
if lookup then
for i,v in ipairs(lookup)do
local typeParams=v.typeParams
if specialityType==typeParams[2]and specialityID==typeParams[3]and flag==typeParams[4]then
return v
end
end
end
return nil
end

function discipleNoteModel.setNote_13(cfg,params)
discipleNoteModel.setNote_1(cfg,params)
end

function discipleNoteModel.getNoteDesc_13(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local typeParams=cfg.typeParams
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)
local specialityType=typeParams[2]
local specialityID=typeParams[3]
local spe_name=UIDiscipleModel:getSpecialityName(specialityType,specialityID)

local str=FMT.fmt(cfg.desc,timer_str,spe_name)
return str
end




function discipleNoteModel.checkCond_14(params)
return discipleNoteModel.checkCond_1(params)
end

function discipleNoteModel.setNote_14(cfg,params)
local disguid=params.disguid
local time=params.time
local descid=cfg.id
local intlist={}
local stringlist={params.oldName,params.curName}
local indexlist=discipleNoteModel.setNoteParamsIndex(intlist,stringlist)
discipleNoteDataSet:setData(disguid,time,descid,intlist,stringlist,indexlist)
end

function discipleNoteModel.getNoteDesc_14(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)
local oldName=notedata.stringlist[1]
local curName=notedata.stringlist[2]

local str=FMT.fmt(cfg.desc,timer_str,oldName,curName)
return str
end




function discipleNoteModel.checkCond_15(params)
return discipleNoteModel.checkCond_1(params)
end

function discipleNoteModel.setNote_15(cfg,params)
local disguid=params.disguid
local time=params.time
local descid=cfg.id
local intlist={}
local stringlist={params.zmName}
local indexlist=discipleNoteModel.setNoteParamsIndex(intlist,stringlist)
discipleNoteDataSet:setData(disguid,time,descid,intlist,stringlist,indexlist)
end

function discipleNoteModel.getNoteDesc_15(disguid,notedata)
local descid=notedata.descid
local cfg=cfgHelper.get(cfg_dizijianwenconfig_get,descid)
local time=notedata.time
local timer_str=discipleNoteModel.getTimeDesc(time)
local zmName=notedata.stringlist[1]
local str=FMT.fmt(cfg.desc,timer_str,zmName)
return str
end

