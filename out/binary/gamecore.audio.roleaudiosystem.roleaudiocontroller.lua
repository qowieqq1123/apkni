






local _MODULENAME="roleAudioController"

gameState.addListener(def_table(_MODULENAME))
roleAudioController.name=_MODULENAME
roleAudioController.data={}



roleAudioNodeType=
{
ZhaoMuChengGong='note_1',
ZongMenDiBao='note_2',
JingJieTiSheng_succes='note_3',
JingJieTiSheng_defead='note_4',
ClickLiHui='note_5',
AnPaiZhiWei='note_6',
RenMingJianZu='note_7',
FanAnShengChan='note_8',
ChuWuDai_ZengSong='note_9',
ChuWuDai_MoShou='note_10',
World_TaoFaGuaiWu='note_11',
Fight_Shangzhen='note_12',
Fight_ShifangFB='note_13',
Fight_ShiWan='note_14',
Fight_ShengLi='note_15',
Fight_ShiBai='note_16',

}


local qieshiDiZi=
{
[3001]=11,
[3003]=9,
[3008]=11,
}


function roleAudioController:onAppStart()
roleAudioModel:onAppStart()
end


function roleAudioController:onEnterState(isReconnect)
roleAudioModel:onEnterState()
end


function roleAudioController:onProtocolReq()

end


function roleAudioController:onLeaveState(isReconnect)
roleAudioModel:onLeaveState(isReconnect)

self.data={}
end


function roleAudioController:onLostConnection()

end


function roleAudioController:onReConnection(isInitPro)

end

function roleAudioController:testts(role_id)
roleAudioController:playRoleSpeak(role_id,roleAudioNodeType.ZhaoMuChengGong)
end



function roleAudioController:stopRoleSpeak()
if verifyManager:isHideYuyin()then
return
end
local ret=systemModel.isOpen(SYSTEM_DEFINE.eRoleSpeak)
if ret then
if roleAudioController.data.roleaudio then


AudioManager.fadeOutStopAudioById(roleAudioController.data.roleaudio,0.5,false)
roleAudioController.data.roleaudio=nil
end
end
end


function roleAudioController:playRoleSpeak(actor_id,note_type)
if verifyManager:isHideYuyin()then
return
end


local ret=systemModel.isOpen(SYSTEM_DEFINE.eRoleSpeak)
if ret then
local videosid

if type(actor_id)=="number"then
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(actor_id)
local sex=dzData.imageInfo.sex
local jobid=dzData.imageInfo.job
local vocvgidx=cfg_discipleconfig_get(actor_id).vocvoicelib
if vocvgidx then
videosid=cfg_disciplevocationconfig_get(jobid).voices[vocvgidx]
end

else
local netData=UIDiscipleModel:getDiscipleData(actor_id)
if netData then
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(netData.discipleguid)
local jobid=imageInfo.job
local sex=imageInfo.sex
local diziid=netData.id
local disguise=netData.disguise
if disguise and disguise>0 then
diziid=disguise
end
local vocvgidx=netData.vocvgidx

if vocvgidx and vocvgidx~=0 then
local diziCfg=cfgHelper.get1(cfg_discipleconfig_get,diziid)
if diziCfg and diziCfg.vocvoicelib then
vocvgidx=diziCfg.vocvoicelib
end
videosid=cfg_disciplevocationconfig_get(jobid).voices[vocvgidx]
else

local diziCfg=cfgHelper.get1(cfg_discipleconfig_get,diziid)
if diziCfg and diziCfg.vocvoicelib then
vocvgidx=diziCfg.vocvoicelib
videosid=cfg_disciplevocationconfig_get(jobid).voices[vocvgidx]
else
local voiceJob=cfg_jianwendisciplevoicejobconfig_get(1).voiceJob
if voiceJob and voiceJob[jobid]then
if voiceJob[jobid][sex]then
videosid=voiceJob[jobid][sex]
end
end

end
end

end
end


if videosid then
local cfg=cfg_disciplevoiceconfig_get(videosid)
if cfg==nil then
loggerUtil.logErrFMT('没有找到弟子配音配置 id：{0}',videosid)
return
end
local notedata=cfg[note_type]
if notedata then
local yinxiaoID,idx,info=roleAudioModel:randomByWeight(notedata[2])
if yinxiaoID then
roleAudioController:stopRoleSpeak()
roleAudioController.data.roleaudio=AudioManager.playAudio(yinxiaoID)

end
end
end
end
end


function roleAudioController:playRoleSpeakByVoiceid(yinxiaoID)
if verifyManager:isHideYuyin()then
return
end
local ret=systemModel.isOpen(SYSTEM_DEFINE.eRoleSpeak)
if ret then
if yinxiaoID then
local speaktxtdata=cfg_soundconfig_get(yinxiaoID)
if speaktxtdata then
roleAudioController:stopRoleSpeak()
roleAudioController.data.roleaudio=AudioManager.playAudio(yinxiaoID)

end
end
end
end


function roleAudioController:getplayRoleSpeakTxt(actor_id,note_type)
if verifyManager:isHideYuyin()then
return
end
local videosid
local speaktxt=nil
local ret=systemModel.isOpen(SYSTEM_DEFINE.eRoleSpeak)
if ret then

if type(actor_id)=="number"then
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(actor_id)
local jobid=dzData.imageInfo.job
local vocvgidx=cfg_discipleconfig_get(actor_id).vocvoicelib
if vocvgidx then
videosid=cfg_disciplevocationconfig_get(jobid).voices[vocvgidx]
end
else
local netData=UIDiscipleModel:getDiscipleData(actor_id)
if netData then
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(netData.discipleguid)
local jobid=imageInfo.job
local sex=imageInfo.sex
local vocvgidx=netData.vocvgidx
local diziid=netData.id
local disguise=netData.disguise
if disguise and disguise>0 then
diziid=disguise
end
if vocvgidx and vocvgidx~=0 then
local diziCfg=cfgHelper.get1(cfg_discipleconfig_get,diziid)
if diziCfg and diziCfg.vocvoicelib then
vocvgidx=diziCfg.vocvoicelib
end
videosid=cfg_disciplevocationconfig_get(jobid).voices[vocvgidx]
else

local diziCfg=cfgHelper.get1(cfg_discipleconfig_get,diziid)
if diziCfg and diziCfg.vocvoicelib then
vocvgidx=diziCfg.vocvoicelib
videosid=cfg_disciplevocationconfig_get(jobid).voices[vocvgidx]
else
local voiceJob=cfg_jianwendisciplevoicejobconfig_get(1).voiceJob
if voiceJob and voiceJob[jobid]then
if voiceJob[jobid][sex]then
videosid=voiceJob[jobid][sex]
end
end
end
end
end
end

if videosid then
local cfg=cfg_disciplevoiceconfig_get(videosid)
local notedata=cfg[note_type]
if notedata then
local yinxiaoID,idx,info=roleAudioModel:randomByWeight(notedata[2])
if yinxiaoID then
roleAudioController:stopRoleSpeak()
roleAudioController.data.roleaudio=AudioManager.playAudio(yinxiaoID)
local speaktxtdata=cfg_soundconfig_get(yinxiaoID)
if speaktxtdata and speaktxtdata.speaktxt then
speaktxt=speaktxtdata.speaktxt
end

end
end
end
end
return speaktxt
end


function roleAudioController:BigWorldRoleSpeak(discipleslist,note_type)
if verifyManager:isHideYuyin()then
return
end
local ret=systemModel.isOpen(SYSTEM_DEFINE.eRoleSpeak)
if ret then
if discipleslist and#discipleslist>0 then
for k,v in ipairs(discipleslist)do
if v and v~=0 then
local disciple=v

roleAudioController:playRoleSpeak(disciple,roleAudioNodeType.World_TaoFaGuaiWu)
break
end
end
end
end
end


function roleAudioController:fightOneKeyRoleSpeak(discipleslist,note_type)
if verifyManager:isHideYuyin()then
return
end
local ret=systemModel.isOpen(SYSTEM_DEFINE.eRoleSpeak)
if ret then
if discipleslist and#discipleslist>0 then
local randomrole=math.random(1,#discipleslist)
local roleId=int64.new(FMT.fmt("{0}",discipleslist[randomrole]))

roleAudioController:playRoleSpeak(roleId,roleAudioNodeType.Fight_Shangzhen)
end
end
end


function roleAudioController:playRoleSpeakMany(actor_id,note_type)
if verifyManager:isHideYuyin()then
return
end
local ret=systemModel.isOpen(SYSTEM_DEFINE.eRoleSpeak)
if ret then
local videosid

if type(actor_id)=="number"then
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(actor_id)
local sex=dzData.imageInfo.sex
local jobid=dzData.imageInfo.job
local vocvgidx=cfg_discipleconfig_get(actor_id).vocvoicelib
if vocvgidx then
videosid=cfg_disciplevocationconfig_get(jobid).voices[vocvgidx]
end

else
local netData=UIDiscipleModel:getDiscipleData(actor_id)
if netData then
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(netData.discipleguid)
local jobid=imageInfo.job
local sex=imageInfo.sex
local vocvgidx=netData.vocvgidx
local diziid=netData.id
local disguise=netData.disguise
if disguise and disguise>0 then
diziid=disguise
end
if vocvgidx and vocvgidx~=0 then
local diziCfg=cfgHelper.get1(cfg_discipleconfig_get,diziid)
if diziCfg and diziCfg.vocvoicelib then
vocvgidx=diziCfg.vocvoicelib
end
videosid=cfg_disciplevocationconfig_get(jobid).voices[vocvgidx]
else

local diziCfg=cfgHelper.get1(cfg_discipleconfig_get,diziid)
if diziCfg and diziCfg.vocvoicelib then
vocvgidx=diziCfg.vocvoicelib
videosid=cfg_disciplevocationconfig_get(jobid).voices[vocvgidx]
else
local voiceJob=cfg_jianwendisciplevoicejobconfig_get(1).voiceJob
if voiceJob and voiceJob[jobid]then
if voiceJob[jobid][sex]then
videosid=voiceJob[jobid][sex]
end
end
end
end

end
end


if videosid then
local cfg=cfg_disciplevoiceconfig_get(videosid)
local notedata=cfg[note_type]
if notedata then
local yinxiaoID,idx,info=roleAudioModel:randomByWeight(notedata[2])
if yinxiaoID then
roleAudioController.data.roleaudio=AudioManager.playAudio(yinxiaoID)

end
end
end
end
end


function roleAudioController:fightingRoleSpeak(dizitemp,note_type,playdizi)
if verifyManager:isHideYuyin()then
return
end
local ret=systemModel.isOpen(SYSTEM_DEFINE.eRoleSpeak)
if ret then
local baattleid=shiLianTaModel:getPlayingBattle()
if baattleid then
if not shiLianTaModel:isFightShow()then
return
end
end
if#dizitemp==0 then
return
end
local data={}
local randomrole=math.random(1,#dizitemp)
data=dizitemp[randomrole]
if data.disguise and data.disguise>0 then
data.diziId=data.disguise
end

if playdizi then
for k,v in ipairs(dizitemp)do
if v.diziId==playdizi then
data=dizitemp[k]
end
end
if data.disguise and data.disguise>0 then
data.diziId=data.disguise
end
local vocvoicelib=cfgHelper.get2(cfg_discipleconfig_get,data.diziId,"vocvoicelib")
if vocvoicelib then
data.cvId=vocvoicelib
end
roleAudioController:setSinglePlayDizi(nil)
end
local diziCfg=cfgHelper.get1(cfg_discipleconfig_get,data.diziId)
if diziCfg and diziCfg.vocvoicelib then
data.cvId=diziCfg.vocvoicelib
end
local jobid=data.jobid
local vocvgidx=data.cvId
local videosid

if vocvgidx then
videosid=cfg_disciplevocationconfig_get(jobid).voices[vocvgidx]
end


if videosid then
local cfg=cfg_disciplevoiceconfig_get(videosid)
local notedata=cfg[note_type]
if notedata then
local yinxiaoID,idx,info=roleAudioModel:randomByWeight(notedata[2])
if yinxiaoID then
roleAudioController.data.roleaudio=AudioManager.playAudio(yinxiaoID)


end
end
end
end
end


function roleAudioController:checkRoleSpeak(winArgs)

local flag=false
if winArgs and winArgs.guid then
local guid=winArgs.guid
local diziid=UIDiscipleModel:getDiscipleID(guid)
if diziid then
local cfg_voice=cfg_jianwendisciplevoiceconfig_get(diziid)
if cfg_voice then
flag=true
end
end
end
return flag
end


function roleAudioController:roleaudiotest()
local ret=systemModel.isOpen(SYSTEM_DEFINE.eRoleSpeak)

end


function roleAudioController:setSinglePlayDizi(diziID)
self.data.playdiziID=diziID
end
function roleAudioController:getSinglePlayDizi()
return self.data.playdiziID
end
