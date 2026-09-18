






local _MODULENAME="DiscipleCoupleModel"


def_table(_MODULENAME)
DiscipleCoupleModel.name=_MODULENAME
DiscipleCoupleModel.coupleList={}
DiscipleCoupleModel.reqCoupleList={}
DiscipleCoupleModel.coupleListLookup={}
DiscipleCoupleModel.reqCoupleListLookup={}
local openPrint=true
local _print=print
local print=function(...)
if openPrint then
_print(...)
end
end

function DiscipleCoupleModel:onAppStart()

end


function DiscipleCoupleModel:onEnterState(isReconnect)

end


function DiscipleCoupleModel:onProtocolReq()
DiscipleCoupleController.reqDaoLvDatas()
end


function DiscipleCoupleModel:onLeaveState(isReconnect)

self.coupleList={}
self.reqCoupleList={}
self.coupleListLookup={}
self.reqCoupleListLookup={}
end


function DiscipleCoupleModel:checkSingleDiscipleCoupleValid(guid1,isWarning,extraCheck)
if mathHelper.validInt64(guid1)then
local imageInfo1=UIDiscipleModel:getDiscipleImageInfo(guid1)
if not imageInfo1 then
if isWarning then
loggerUtil.logErrFMT('获取不到弟子形象数据 guid：{0}',guid1)
end
return false
end
if self.coupleListLookup[tostring(guid1)]then
if isWarning then
loggerUtil.logErrFMT('弟子已有道侣 弟子guid：{0} 道侣guid：{1}',guid1,self.coupleListLookup[tostring(guid1)])
end
return false,1
end
local haveFateCouple,fateCoupleId=DiscipleCoupleModel:getDiscipleFateCouple(guid1)
if haveFateCouple then
if isWarning then
loggerUtil.logErrFMT('弟子已有指定道侣 弟子guid：{0} 指定道侣id：{1}',guid1,fateCoupleId)
end
return false,1
end
local coupleCfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local job=imageInfo1.job
if not coupleCfg.voc[job]then
if isWarning then
loggerUtil.logErrFMT('弟子职业不符合 弟子guid：{0} 职业id：{1}',guid1,job)
end
return false,2
end
local netData=UIDiscipleModel:getDiscipleData(guid1)
local isShuWUDZ=UIDiscipleModel:isShuWuDisciple(netData.id)
if isShuWUDZ and not coupleCfg.shuwu[netData.id]then
if isWarning then
loggerUtil.logErrFMT('弟子为庶务弟子 弟子guid：{0} 弟子id：{1}',guid1,netData.id)
end
return false,3
end
if netData.jingjielv<coupleCfg.jingjie then
if isWarning then
loggerUtil.logErrFMT('弟子境界等级不足 弟子guid：{0} 弟子境界等级：{1}',guid1,netData.jingjielv)
end
return false,4
end
if coupleCfg.disciple[netData.id]then
if isWarning then
loggerUtil.logErrFMT('弟子为特殊配置弟子 弟子guid：{0} 弟子id：{1}',guid1,netData.id)
end
return false,5
end
if dzSpecialitySpecialEffectController:getNotAcceptCouple(netData)then
if isWarning then
loggerUtil.logErrFMT('弟子受特质效果影响 不接受道侣 弟子guid：{0}',guid1)
end
return false,6
end
if extraCheck then
local meili=UIDiscipleModel:getDiscipleBaseAttr(guid1,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
if meili<coupleCfg.attr5 then
if isWarning then
loggerUtil.logErrFMT('弟子魅力值不足 弟子guid：{0} 弟子魅力值：{1}',guid1,meili)
end
return false
end
end
else
if isWarning then
loggerUtil.logErrFMT('弟子guid为空或0 guid1：{0}',guid1)
end
return false
end
return true
end
function DiscipleCoupleModel:checkDiscipleCoupleValid(guid1,guid2,isWarning,extraCheck)
if not DiscipleCoupleModel:checkSingleDiscipleCoupleValid(guid1,isWarning,extraCheck)then return end
if not DiscipleCoupleModel:checkSingleDiscipleCoupleValid(guid2,isWarning,extraCheck)then return end

local imageInfo1=UIDiscipleModel:getDiscipleImageInfo(guid1)
local imageInfo2=UIDiscipleModel:getDiscipleImageInfo(guid2)
local sex1=imageInfo1.sex
local sex2=imageInfo2.sex
if sex1==sex2 then
loggerUtil.logErrFMT('弟子性别相同 guid1：{0} sex1：{1} guid2：{2} sex2：{3}',guid1,sex1,guid2,sex2)
return false
end
if extraCheck then
local coupleCfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local releationValue1=UIDiscipleModel:getReleationValue(guid1,guid2,DISCIPLE_RELATION_TYPE.eFriend)
local relationType1=UIDiscipleModel:getRelationChildType(DISCIPLE_RELATION_TYPE.eFriend,releationValue1)
if relationType1<coupleCfg.relation then
if isWarning then
loggerUtil.logErrFMT('弟子关系未达到要求 弟子guid：{0} 弟子关系：{1}',guid1,relationType1)
end
return false
end
local releationValue2=UIDiscipleModel:getReleationValue(guid2,guid1,DISCIPLE_RELATION_TYPE.eFriend)
local relationType2=UIDiscipleModel:getRelationChildType(DISCIPLE_RELATION_TYPE.eFriend,releationValue2)
if relationType2<coupleCfg.relation then
if isWarning then
loggerUtil.logErrFMT('弟子关系未达到要求 弟子guid：{0} 弟子关系：{1}',guid1,relationType2)
end
return false
end
end

return true
end


function DiscipleCoupleModel:getDiscipleCoupleGuid(guid)
if not self.coupleListLookup then self.coupleListLookup={}end
return self.coupleListLookup[tostring(guid)]
end


function DiscipleCoupleModel:getDiscipleFateCouple(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
if not netData then return false end
local fateCouple=cfgHelper.get1(cfg_disciplecoupleconfig_get,1).couple
for _,v in ipairs(fateCouple or{})do
if v[1]==netData.id then
return true,v[2]
end
if v[2]==netData.id then
return true,v[1]
end
end
return false
end


function DiscipleCoupleModel:checkDiscipleCouple(guid)
local coupleGuid=self:getDiscipleCoupleGuid(guid)
local fateCouple=self:getDiscipleFateCouple(guid)
return mathHelper.validInt64(coupleGuid)or fateCouple
end


function DiscipleCoupleModel:getDiscipleCoupleNum()
if not self.coupleList then self.coupleList={}end
local netNum=#self.coupleList
local fateCouple=cfgHelper.get1(cfg_disciplecoupleconfig_get,1).couple or{}
local cfgNum=#fateCouple
return netNum+cfgNum
end


function DiscipleCoupleModel:initCoupleList(coupleList)
self.coupleList={}
self.coupleListLookup={}
for _,v in ipairs(coupleList)do
local guid1=v.param_1
local guid2=v.param_2
local check=true
local imageInfo1=UIDiscipleModel:getDiscipleImageInfo(guid1)
if not imageInfo1 then
loggerUtil.logErrFMT('获取不到弟子形象数据 guid：{0}',guid1)
check=false
end
local imageInfo2=UIDiscipleModel:getDiscipleImageInfo(guid2)
if not imageInfo2 then
loggerUtil.logErrFMT('获取不到弟子形象数据 guid：{0}',guid2)
check=false
end
if check then
local sex1=imageInfo1.sex
local sex2=imageInfo2.sex
local manGuid=sex1==1 and guid1 or guid2
local womanGuid=sex1==1 and guid2 or guid1
table.insert(self.coupleList,{man=manGuid,woman=womanGuid})
self.coupleListLookup[tostring(manGuid)]=womanGuid
self.coupleListLookup[tostring(womanGuid)]=manGuid
end
end
end


function DiscipleCoupleModel:AddCoupleList(guid1,guid2)
if not self.coupleList then self.coupleList={}end
if not self.coupleListLookup then self.coupleListLookup={}end
local check=true
local imageInfo1=UIDiscipleModel:getDiscipleImageInfo(guid1)
if not imageInfo1 then
loggerUtil.logErrFMT('获取不到弟子形象数据 guid：{0}',guid1)
check=false
end
local imageInfo2=UIDiscipleModel:getDiscipleImageInfo(guid2)
if not imageInfo2 then
loggerUtil.logErrFMT('获取不到弟子形象数据 guid：{0}',guid2)
check=false
end
if check then
local sex1=imageInfo1.sex
local sex2=imageInfo2.sex
local manGuid=sex1==1 and guid1 or guid2
local womanGuid=sex1==1 and guid2 or guid1
table.insert(self.coupleList,{man=manGuid,woman=womanGuid})
self.coupleListLookup[tostring(manGuid)]=womanGuid
self.coupleListLookup[tostring(womanGuid)]=manGuid
end
end


function DiscipleCoupleModel:DelCoupleList(guid1,guid2)
local imageInfo1=UIDiscipleModel:getDiscipleImageInfo(guid1)
local imageInfo2=UIDiscipleModel:getDiscipleImageInfo(guid2)
if imageInfo1 and imageInfo2 then
local sex1=imageInfo1.sex
local sex2=imageInfo2.sex
local manGuid=sex1==1 and guid1 or guid2
local womanGuid=sex1==1 and guid2 or guid1
for i,v in ipairs(self.coupleList or{})do
if mathHelper.compareInt64(manGuid,v.man)and mathHelper.compareInt64(womanGuid,v.woman)then
table.remove(self.coupleList,i)
self.coupleListLookup[tostring(manGuid)]=nil
self.coupleListLookup[tostring(womanGuid)]=nil
break
end
end
end
end


function DiscipleCoupleModel:DelCoupleListByGuid(guid)
for i,v in ipairs(self.coupleList or{})do
if mathHelper.compareInt64(guid,v.man)or mathHelper.compareInt64(guid,v.woman)then
self.coupleListLookup[tostring(v.man)]=nil
self.coupleListLookup[tostring(v.woman)]=nil
table.remove(self.coupleList,i)
break
end
end
end

function DiscipleCoupleModel:getCoupleList()
return self.coupleList
end


function DiscipleCoupleModel:initReqCoupleList(reqList)
self.reqCoupleList={}
local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local NowTimeStamp=timeHelper.getServerShortTime()
for _,v in ipairs(reqList)do
local timeStamp=v.param_1
local guid1=v.param_2
local guid2=v.param_3
local pastTime=NowTimeStamp-timeStamp
if pastTime<cfg.duration and not DiscipleCoupleModel:checkDiscipleCouple(guid1)and not DiscipleCoupleModel:checkDiscipleCouple(guid2)then
local imageInfo1=UIDiscipleModel:getDiscipleImageInfo(guid1)
local imageInfo2=UIDiscipleModel:getDiscipleImageInfo(guid2)
if imageInfo1 and imageInfo2 then
local sex1=imageInfo1.sex
local sex2=imageInfo2.sex
local manGuid=sex1==1 and guid1 or guid2
local womanGuid=sex1==1 and guid2 or guid1
table.insert(self.reqCoupleList,{timeStamp=timeStamp,man=manGuid,woman=womanGuid,dialogueId=v.param_4})
self.reqCoupleListLookup[tostring(manGuid)]=womanGuid
self.reqCoupleListLookup[tostring(womanGuid)]=manGuid
end
end
end
end


function DiscipleCoupleModel:AddReqCoupleList(guid1,guid2,dialogueid)
if not self.reqCoupleList then self.reqCoupleList={}end
if DiscipleCoupleModel:checkDiscipleCoupleValid(guid1,guid2,true)then
local imageInfo1=UIDiscipleModel:getDiscipleImageInfo(guid1)
local imageInfo2=UIDiscipleModel:getDiscipleImageInfo(guid2)
local sex1=imageInfo1.sex
local sex2=imageInfo2.sex
local manGuid=sex1==1 and guid1 or guid2
local womanGuid=sex1==1 and guid2 or guid1
local timeStamp=timeHelper.getServerShortTime()
table.insert(self.reqCoupleList,{timeStamp=timeStamp,man=manGuid,woman=womanGuid,dialogueId=dialogueid})
self.reqCoupleListLookup[tostring(manGuid)]=womanGuid
self.reqCoupleListLookup[tostring(womanGuid)]=manGuid
end
end


function DiscipleCoupleModel:DelReqCoupleList(guid1,guid2)
local imageInfo1=UIDiscipleModel:getDiscipleImageInfo(guid1)
local imageInfo2=UIDiscipleModel:getDiscipleImageInfo(guid2)
if imageInfo1 and imageInfo2 then
local sex1=imageInfo1.sex
local sex2=imageInfo2.sex
local manGuid=sex1==1 and guid1 or guid2
local womanGuid=sex1==1 and guid2 or guid1
for i,v in ipairs(self.reqCoupleList or{})do
if mathHelper.compareInt64(manGuid,v.man)and mathHelper.compareInt64(womanGuid,v.woman)then
table.remove(self.reqCoupleList,i)
DiscipleCoupleModel:RebuildReqCoupleListLookup()
break
end
end
end
end


function DiscipleCoupleModel:RebuildReqCoupleListLookup()
self.reqCoupleListLookup={}
for i,v in ipairs(self.reqCoupleList or{})do
self.reqCoupleListLookup[tostring(v.man)]=v.woman
self.reqCoupleListLookup[tostring(v.woman)]=v.man
end
end


function DiscipleCoupleModel:DelReqCoupleListByGuid(guid)
local temp={}
for i,v in ipairs(self.reqCoupleList or{})do
if mathHelper.compareInt64(guid,v.man)or mathHelper.compareInt64(guid,v.woman)then
self.reqCoupleListLookup[tostring(v.man)]=nil
self.reqCoupleListLookup[tostring(v.woman)]=nil
else
table.insert(temp,v)
end
end
self.reqCoupleList=temp
end


function DiscipleCoupleModel:CheckDelReqCoupleList()
local temp={}
local refresh=false
for i,v in ipairs(self.reqCoupleList or{})do
if DiscipleCoupleModel:getDiscipleCoupleGuid(v.man)~=nil or DiscipleCoupleModel:getDiscipleCoupleGuid(v.woman)~=nil then
refresh=true
else
table.insert(temp,v)
end
end
if refresh then
self.reqCoupleList=temp
DiscipleCoupleModel:RebuildReqCoupleListLookup()
UIManager:invokeUIMethod('UIFuncStorageWin','refreshCoupleRequestBtn')
end
end


function DiscipleCoupleModel:CheckReqCoupleListContain(guid1)
if not self.reqCoupleListLookup then self.reqCoupleListLookup={}end
return self.reqCoupleListLookup[tostring(guid1)]~=nil
end

function DiscipleCoupleModel:getReqCoupleList()
return self.reqCoupleList
end

function DiscipleCoupleModel:getDiscipleDiffSexRelationList(guid1)
local coupleCfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local relationTypes={}
for _,v in pairs(DISCIPLE_FRIEND_RELATION_TYEP)do
if v>=coupleCfg.relation then
table.insert(relationTypes,v)
end
end
local temp={}
local relations=UIDiscipleModel:getRelationDiscipleList(guid1,DISCIPLE_RELATION_TYPE.eFriend,relationTypes,true)
for _,friend in ipairs(relations)do
local guid2=friend[1]
local imageInfo1=UIDiscipleModel:getDiscipleImageInfo(guid1)
local imageInfo2=UIDiscipleModel:getDiscipleImageInfo(guid2)
if imageInfo1 and imageInfo2 then
local sex1=imageInfo1.sex
local sex2=imageInfo2.sex
if sex1~=sex2 then
table.insert(temp,guid2)
end
elseif not imageInfo1 then
loggerUtil.logErrFMT('获取不到弟子形象数据 guid：{0}',guid1)
break
elseif not imageInfo2 then
loggerUtil.logErrFMT('获取不到弟子形象数据 guid：{0}',guid2)
end
end
return temp
end


function DiscipleCoupleModel:getCoupleWishRate(guid1,guid2)
local total_rate=0
local netData1=UIDiscipleModel:getDiscipleData(guid1)
local netData2=UIDiscipleModel:getDiscipleData(guid2)
local dzId1=netData1.id
local dzId2=netData2.id
local special_CONF=cfgHelper.get1(cfg_disciplecoupleconfig_get,1).special
for i,v in ipairs(special_CONF)do
if(v[1]==dzId1 and v[2]==dzId2)or(v[2]==dzId1 and v[1]==dzId2)then
return 100
end
end
local RATE_CONF=cfgHelper.get1(cfg_disciplecoupleconfig_get,1).rate
local attr_value=UIDiscipleModel:getDiscipleBaseAttr(guid2,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
local stand1=netData1.stand
local stand2=netData2.stand
for _,conf in ipairs(RATE_CONF)do
local condition_type,condition_param=unpack(conf)
if condition_type==1 then

local releationValue=UIDiscipleModel:getReleationValue(guid1,guid2,DISCIPLE_RELATION_TYPE.eFriend)
local relationType=UIDiscipleModel:getRelationChildType(DISCIPLE_RELATION_TYPE.eFriend,releationValue)
local rate=condition_param[relationType]
if rate then

total_rate=total_rate+rate
end
elseif condition_type==2 then

for _,v in ipairs(condition_param)do
local min_attr_value=v[1]
if attr_value<min_attr_value then
local rate=v[2]

total_rate=total_rate+rate
break
end
end
elseif condition_type==3 then

local min_attr_value=condition_param[1]
if attr_value>=min_attr_value then
local base_rate,base_attr_value,rate_fix=unpack(condition_param,2)
local rate=base_rate+(attr_value-base_attr_value)*rate_fix

total_rate=total_rate+rate
end
elseif condition_type==4 then

for _,v in ipairs(condition_param)do
local stand_map1,stand_map2=unpack(v,1,2)
if stand_map1[stand1]and stand_map2[stand2]then
local rate=v[3]

total_rate=total_rate+rate
break
end
end
else
logErr("undefined condition_type:",condition_type)
end
end


return total_rate
end

function DiscipleCoupleModel:getIsCouple(guid)
local str=tostring(guid)
return self.coupleListLookup[str]
end

function DiscipleCoupleModel:setCoupleLiveId(len,array,promote_len,promote_array)

if not self.coupleLiveList then
self.coupleLiveList={}
end

if not self.couplePromoteList then
self.couplePromoteList={}
end

if not self.coupleBuildLiveList then
self.coupleBuildLiveList={}
end

if len>0 then
for i=1,len do
local datas=array[i]
if datas then
local index=tostring(datas.un_build_id)
local dzIdStr1=tostring(datas.dizi_id_1)
local dzIdStr2=tostring(datas.dizi_id_2)

self.coupleBuildLiveList[index]={dizi_id_1=datas.dizi_id_1,dizi_id_2=datas.dizi_id_2,promote_cnt=datas.promote_cnt}
if dzIdStr1~="0"and dzIdStr2~="0"then
self.coupleLiveList[dzIdStr1]={check_in=true,build_id=datas.un_build_id}
self.coupleLiveList[dzIdStr2]={check_in=true,build_id=datas.un_build_id}

zongmenModel:setHomelessRecord(datas.dizi_id_1,nil)
zongmenModel:setHomelessRecord(datas.dizi_id_2,nil)

zongmenModel:setDiZiHome(datas.dizi_id_1,datas.un_build_id)
zongmenModel:setDiZiHome(datas.dizi_id_2,datas.un_build_id)


notifySystem:postNotify(notifyConfig.building_event,buildingEvent.switchRoomDizi,nil,datas.un_build_id,nil,datas.dizi_id_1,nil,nil)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.switchRoomDizi,nil,datas.un_build_id,nil,datas.dizi_id_2,nil,nil)
end
hudControl:refreshBuildingStatusHUD(datas.un_build_id)
end
end
end

if promote_len>0 then
for k,v in ipairs(promote_array)do
local index=tostring(v.param_2)
self.couplePromoteList[index]=v.param_1
end
else
self.couplePromoteList={}
end



end

function DiscipleCoupleModel:addCoupleLiveId(un_build_id,dizi_id_1,dizi_id_2)
local un_build_id_str=tostring(un_build_id)

local dzIdStr1=tostring(dizi_id_1)
local dzIdStr2=tostring(dizi_id_2)

self.coupleBuildLiveList[un_build_id_str].dizi_id_1=dizi_id_1
self.coupleBuildLiveList[un_build_id_str].dizi_id_2=dizi_id_2
self.coupleLiveList[dzIdStr1]={check_in=true,build_id=un_build_id}
self.coupleLiveList[dzIdStr2]={check_in=true,build_id=un_build_id}


zongmenModel:setHomelessRecord(dizi_id_1,nil)
zongmenModel:setHomelessRecord(dizi_id_2,nil)

zongmenModel:setDiZiHome(dizi_id_1,un_build_id)
zongmenModel:setDiZiHome(dizi_id_2,un_build_id)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.switchRoomDizi,nil,un_build_id,nil,dizi_id_1,nil,nil)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.switchRoomDizi,nil,un_build_id,nil,dizi_id_2,nil,nil)

end

function DiscipleCoupleModel:reduceCoupleLiveId(un_build_id)
local un_build_id_str=tostring(un_build_id)
local dzId1=self.coupleBuildLiveList[un_build_id_str].dizi_id_1
local dzId2=self.coupleBuildLiveList[un_build_id_str].dizi_id_2
local dzIdStr1=tostring(self.coupleBuildLiveList[un_build_id_str].dizi_id_1)
local dzIdStr2=tostring(self.coupleBuildLiveList[un_build_id_str].dizi_id_2)


zongmenModel:setHomelessRecord(dzId1,true)
zongmenModel:setHomelessRecord(dzId2,true)

zongmenModel:setDiZiHome(dzId1,nil)
zongmenModel:setDiZiHome(dzId2,nil)

notifySystem:postNotify(notifyConfig.building_event,buildingEvent.switchRoomDizi,nil,un_build_id,nil,nil,dzId1,nil)
notifySystem:postNotify(notifyConfig.building_event,buildingEvent.switchRoomDizi,nil,un_build_id,nil,nil,dzId2,nil)

self.coupleLiveList[dzIdStr1]={check_in=false,build_id=0}
self.coupleLiveList[dzIdStr2]={check_in=false,build_id=0}
self.coupleBuildLiveList[un_build_id_str].dizi_id_1=0
self.coupleBuildLiveList[un_build_id_str].dizi_id_2=0

end

function DiscipleCoupleModel:getCoupleLiveId(id)
if self.coupleBuildLiveList then
local index=tostring(id)
if self.coupleBuildLiveList[index]then
return self.coupleBuildLiveList[index]
else
return nil
end
end
return nil
end

function DiscipleCoupleModel:setCoupleRepairRewardId(un_build_id,xiuwei1,lianti1,tiaits1,sixAttr1,xiuwei2,lianti2,tiaits2,sixAttr2,speList)
if not self.repairRewardList then
self.repairRewardList={}
end

local index=tostring(un_build_id)
self.repairRewardList[index]=
{
xiuwei1=xiuwei1,
lianti1=lianti1,
tiaits1=tiaits1,
sixAttr1=sixAttr1,
xiuwei2=xiuwei2,
lianti2=lianti2,
tiaits2=tiaits2,
sixAttr2=sixAttr2,
oldSpeList=speList,
}

end

function DiscipleCoupleModel:getCoupleRepairRewardId(un_build_id)
local index=tostring(un_build_id)
if self.repairRewardList[index]then
return self.repairRewardList[index]
end
end

function DiscipleCoupleModel:addCouplePromote_cnt(un_build_id)

local index=tostring(un_build_id)
local dzIdStr1=tostring(self.coupleBuildLiveList[index].dizi_id_1)
local dzIdStr2=tostring(self.coupleBuildLiveList[index].dizi_id_2)
self.coupleBuildLiveList[index].promote_cnt=1
self.couplePromoteList[dzIdStr1]=1
self.couplePromoteList[dzIdStr2]=1

end

function DiscipleCoupleModel:clearPromoteList()
self.couplePromoteList={}
end

function DiscipleCoupleModel:getPromoteList(guid)
local index=tostring(guid)

if self.couplePromoteList then
return self.couplePromoteList[index]
end
end

function DiscipleCoupleModel:getCoupleDzRate(guidstr)
if self.coupleLiveList[guidstr]then
if self.coupleLiveList[guidstr].check_in then
if self.coupleLiveList[guidstr].build_id>0 then
local bdData=zongmenModel:getBuildingData(self.coupleLiveList[guidstr].build_id)
if bdData then
local level=bdData.level
local config=cfgHelper.get2(cfg_monijydaolvcaveconfig_get,SLG_SYSTEM_TYPE.eDaoLv,level)
if config then
return config.jj_xiulian_up
else
return 0
end
end
end
end
else
return 0
end
return 0
end

function DiscipleCoupleModel:getCoupleDzIsLive(guidstr)
if self.coupleLiveList[guidstr]then
if self.coupleLiveList[guidstr].check_in then
return true
end
end
return false
end

function DiscipleCoupleModel:getBuildState(unbuildid)
local index=tostring(unbuildid)
if not self.coupleBuildLiveList then return 1 end

if self.coupleBuildLiveList then
local data=self.coupleBuildLiveList[index]
if data then
if UIDiscipleModel:checkDiscipleState2(data.dizi_id_1,DISCIPLE_STATE_TYPE.eChuiWei)then
return 0
end
if UIDiscipleModel:checkDiscipleState2(data.dizi_id_2,DISCIPLE_STATE_TYPE.eChuiWei)then
return 0
end
if tostring(data.dizi_id_1)~="0"then
local flag1=DiscipleCoupleModel:getPromoteList(data.dizi_id_1)
local flag2=DiscipleCoupleModel:getPromoteList(data.dizi_id_2)
if data.promote_cnt==0 and not flag1 and not flag2 then
return 2
end
else
return 1
end
end
end
end

function DiscipleCoupleModel:checkAttrsFull(guid1,guid2)

local level=UIDiscipleModel:getDiscipleJJLevel(guid1)
if UIDiscipleModel:checkJJLevelFull(level)or
(UIDiscipleModel:isDiscipleJJLevelWillChange(guid1)and UIDiscipleModel:checkNextJJNeedBroke(level)and UIDiscipleModel:checkJJBrokeByHand(level))then
local name=UIDiscipleModel:getDiscipleName(guid1)
return 1,name
end

level=UIDiscipleModel:getDiscipleJJLevel(guid2)
if UIDiscipleModel:checkJJLevelFull(level)or
(UIDiscipleModel:isDiscipleJJLevelWillChange(guid2)and UIDiscipleModel:checkNextJJNeedBroke(level)and UIDiscipleModel:checkJJBrokeByHand(level))then
local name=UIDiscipleModel:getDiscipleName(guid2)
return 1,name
end


level=UIDiscipleModel:getDiscipleLTLevel(guid1)
if UIDiscipleModel.checkLTFull(level)or UIDiscipleModel:checkDiscipleLTNeedBroke(guid1)then
local name=UIDiscipleModel:getDiscipleName(guid1)
return 2,name
end

level=UIDiscipleModel:getDiscipleLTLevel(guid2)
if UIDiscipleModel.checkLTFull(level)or UIDiscipleModel:checkDiscipleLTNeedBroke(guid1)then
local name=UIDiscipleModel:getDiscipleName(guid2)
return 2,name
end
end
