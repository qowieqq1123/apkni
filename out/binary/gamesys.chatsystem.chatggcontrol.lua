chatGGControl=gameState.addListener({})
local _stamp={}
local _div=5


function chatGGControl:onAppStart()
notifySystem:listenNotify(notifyConfig.onDiscipleInjuryChange,self.onDiscipleInjuryChange)
notifySystem:listenNotify(notifyConfig.onDiscipleJobChange,self.onDiscipleJobChange)
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
end

function chatGGControl:onEnterState()
chatEmotModel.init()
_stamp={}
end

function chatGGControl:onLeaveState()
chatEmotModel.init()
_stamp={}
end


function chatGGControl.onDiscipleInjuryChange(dzguid,old,injury)
local filterType=CHAT_MSG_TYPE.eDiziChuiWei
local old_injuryType=eInjuryType.getType(old)
local new_injuryType=eInjuryType.getType(injury)
if old_injuryType==new_injuryType then return end
local dzname=UIDiscipleModel:getDiscipleName(dzguid)
local key=FMT.fmt('gg_fushang_{0}',new_injuryType)
chatGGControl.reqMesg(filterType,key,{dzname})
end


function chatGGControl.onDiscipleJJChange(dzguid,oldlv,newlv)
if oldlv==newlv then return end
local filterType=CHAT_MSG_TYPE.eDiziJingjieUpLevel
local jjfloor=cfgHelper.get2(cfg_disciplejingjieconfig_get,newlv,'floor')

local key=FMT.fmt('gg_djingjie_{0}',jjfloor)
local jjname=UIDiscipleModel:getJJName4(newlv)
local floorname=UIDiscipleModel:getJJFloorNameEx(newlv)
local dzname=UIDiscipleModel:getDiscipleName(dzguid)


local now=timeHelper.getServerShortTime()
local djxdStamp=jctjDuJieXianDanModel:getDuJieJJUpDizi(dzguid)
if djxdStamp and now<djxdStamp then
chatGGControl:setDuJieJJChangeCache(dzguid,jjfloor,dzname,jjname)
else
chatGGControl.reqMesg(filterType,key,{dzname,jjname})
end
end

function chatGGControl:setDuJieJJChangeCache(dzguid,jjfloor,dzname,jjname)
local key=FMT.fmt('gg_djingjie_djxd_{0}',jjfloor)
if not self.djJJChangeCache then self.djJJChangeCache={}end
if not next(self.djJJChangeCache)then
table.insert(self.djJJChangeCache,{dzguid,key,dzname,jjname})
chatGGControl:startDuJieJJChangeCache()
else
table.insert(self.djJJChangeCache,{dzguid,key,dzname,jjname})
end
end

function chatGGControl:startDuJieJJChangeCache()
if not self.djJJChangeCache then
return
end
local v=self.djJJChangeCache[1]
if v then
local filterType=CHAT_MSG_TYPE.eDiziJingjieUpLevel
chatGGControl.reqMesg(filterType,v[2],{v[3],v[4]})
table.remove(self.djJJChangeCache,1)
timeEventController.delayDo(3,function()
chatGGControl:startDuJieJJChangeCache()
end)
end
end



function chatGGControl.onDiscipleJobChange(dzguid,jobtype,oldlv,newlv,oldexp,exp)
if oldlv==newlv then return end
local filterType=CHAT_MSG_TYPE.eDiziZhuanyeUpLevel
local name=cfgHelper.get2(cfg_discipleproskillconfig_get,jobtype,'name')
local key=FMT.fmt('gg_zhuanye_{0}',jobtype)
local dzname=UIDiscipleModel:getDiscipleName(dzguid)
chatGGControl.reqMesg(filterType,key,{dzname,name,newlv})
end

function chatGGControl.onBuildEvent(buildData,diziguid,plantId)
if buildData==nil then return end
local filterType=CHAT_MSG_TYPE.eFinishShengchan
local buildid=buildData.build_id
local buildname=cfgHelper.get2(cfg_monijybuildconfig_get,buildid,'name')
local key=FMT.fmt('gg_shengchan_{0}_{1}',buildid,plantId)
chatGGControl.reqMesg(filterType,key,{buildname})
end

function chatGGControl.onYinXianTaiNumFresh(lastnum,newnum)
local filterType=CHAT_MSG_TYPE.eFreshYinXianTai
local key='gg_yinxiantaishuaxin'
chatGGControl.reqMesg(filterType,key)
end

function chatGGControl.onMonsterFresh()
local filterType=CHAT_MSG_TYPE.eFreshYeWaiMonster
if not chatGGControl.checkReq(filterType)then return end
local key='gg_monster'
chatGGControl.reqMesg(filterType,key)
end

function chatGGControl.onHomeBuffAdd(buffid,stableVal)
local filterType=CHAT_MSG_TYPE.eZongmenStatus
local key='gg_home_buff_notice'
local buffCfg=cfg_guildstateconfig_get(buffid)
local name=buffCfg.name
if buffCfg.specialMsgTipsKey then

key=buffCfg.specialMsgTipsKey
end
chatGGControl.reqMesg(filterType,key,{stableVal,name})
end

function chatGGControl.onFangke(type)

end


function chatGGControl.onJiaZuFresh()
local filterType=CHAT_MSG_TYPE.eFreshJiZhu
if not chatGGControl.checkReq(filterType)then return end
local key='gg_jiazu'
chatGGControl.reqMesg(filterType,key)
end


function chatGGControl.onMiJingFresh()
local filterType=CHAT_MSG_TYPE.eFreshMiJing
if not chatGGControl.checkReq(filterType)then return end
local key='gg_mijing'
chatGGControl.reqMesg(filterType,key)
end


function chatGGControl.onFangshiFresh()
local filterType=CHAT_MSG_TYPE.eFreshFangshi
local key='gg_fangshi'
chatGGControl.reqMesg(filterType,key)
end


function chatGGControl.reqMesg(filterType,key,args)
local desc=cfg_lang_get(key,false)
if desc==nil then return end
local channel=chatMesgFilterControl.getCfg(filterType).channels or CHAT_CHANNNEL.eSystem
local isJianwen=channel==CHAT_CHANNNEL.eJianwen
local mesg=args~=nil and FMT.fmt(desc,unpack(args))or desc
local title
local timeStamp=timeHelper.getServerLongTime()
local year=gameUtilityModel.getGameYearPassByLongStamp(timeStamp)
local yearStr=FMT.fmt('第{0}年',year)
if isJianwen then
title=FMT.cfmt(FONT_COLOR.eNomalGrayColor,yearStr)
else
title='系统'
mesg=FMT.fmt('{0}，{1}',yearStr,mesg)
end
chatControl.reqSystemMesg(filterType,{channel},mesg,title)
end

function chatGGControl.checkReq(filterType)
if filterType==nil then return false end
local stamp=timeHelper.getServerShortTime()
local canReq=_stamp[filterType]==nil or(stamp-_stamp[filterType])>=_div
if canReq then
_stamp[filterType]=stamp
end
return canReq
end
