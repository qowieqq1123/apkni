







local _MODULENAME="lingshouModel"


def_table(_MODULENAME)

lingshouModel.name=_MODULENAME
lingshouModel.data={}

lingshouModel.sortTypeKey='lingshouSelectSortType'
lingshouModel.sortCondKey='lingshouSelectSortCond'
lingshouModel.sortTypeKey2='lingshouSelectSortType2'


lingshouModel.lsSelectStackOnKey='lingshou_lsSelect_stackOn'

lingshouColorToFrame={
[eQualityColor.eGreen]='image_lingshou_bg1',
[eQualityColor.eBlue]='image_lingshou_bg2',
[eQualityColor.ePurple]='image_lingshou_bg3',
[eQualityColor.eOrange]='image_lingshou_bg4',
[eQualityColor.eRed]='image_lingshou_bg5',
}
local _LuaHelper=CS.LuaHelper


function lingshouModel:onAppStart()

end


function lingshouModel:onEnterState(isReconnect)
self:init()
self:loadOnlyXueMaiSelect()
self:loadJiuLiDianSelect1()
self:loadJiuLiDianSelect2()

self:onEnterState_xuemai(isReconnect)
end


function lingshouModel:onProtocolReq()
self:onProtocolReq_xuemai()
end


function lingshouModel:onLeaveState(isReconnect)
self:onLeaveState_xuemai()


self.data={}
self:clearData()
end


function lingshouModel:setTempLsSelectStackBefore(isOn)
self.data=self.data or{}
self.data._lsSelect_stackBefore=isOn and true or false
end

function lingshouModel:getTempLsSelectStackBefore()
return self.data and self.data._lsSelect_stackBefore
end

function lingshouModel:clearTempLsSelectStackBefore()
if self.data then
self.data._lsSelect_stackBefore=nil
end
end


function lingshouModel:setSaveLsSelectStackOn(isOn)
userActorSetting.flushVal(self.lsSelectStackOnKey,isOn and 1 or 0,0)
end

function lingshouModel:getSaveLsSelectStackOn()
return userActorSetting.get(self.lsSelectStackOnKey,0)==1
end

function lingshouModel:init()
self.diziLookup={}
self.lingShouDatas={}
self.lingShouDatas_lookup={}
self.lingShowSwitchIdxLookup={}
self.lingShouCnt=0
self.lingShouJJListDirty=0
end

function lingshouModel:initLingShouDatas(lingshouList)
self.lingShouDatas={}
self.lingShouCnt=0

if lingshouList then
for i,v in ipairs(lingshouList)do
local guid=v.guid
local guid_str=tostring(guid)
v.guid_str=guid_str
v.jj_exp_int64=v.jj_exp
v.jj_exp=mathHelper.int64_to_number(v.jj_exp)
self.lingShouCnt=self.lingShouCnt+1
self.lingShouDatas[guid_str]=v
lingshouModel:applyLingShouAllWord(v)
lingshouModel:initAttrLookup(v)

local dzGuid=lingshouModel:getDiziguidByLsGuid(guid)
if dzGuid then
UIDiscipleModel:setSkillLvPlusLookupDirty(dzGuid,false)
lingshouModel:setAttrListDirtyX(guid,lingshouAttributeType.eDzGongFa,false)
end

if dzGuid then
UIDiscipleModel:setDiscipleAttrListDirtyX(dzGuid,DISCIPLE_ATTRIBUTE_TYPE.eEquip,false)
end
end
end
end

function lingshouModel:getLingShouDatas()
return self.lingShouDatas or{}
end

function lingshouModel:clearData()
self.lingShouDatas=nil
self.lingShouCnt=0
self.fightFreshTag=nil
self.equipFightFreshTag=nil
end

function lingshouModel:getLingShouData(guid)
if self.lingShouDatas==nil then return nil end
local guid_str=tostring(guid)
return self.lingShouDatas[guid_str]
end

function lingshouModel:getLingShouData2(lsGuid)
if lsGuid==nil then
logErr("lsGuid == nil")
return
end
local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData==nil then
logErr("灵兽数据缺失",lsGuid,tostring(lsGuid))
return
end
return lsData
end


function lingshouModel:getLingShouModel(guid)
local lsData=lingshouModel:getLingShouData2(guid)
if lsData then
return lsData.cfg.model
end
end


function lingshouModel:getLingShouData_res(guid)
local lsData=lingshouModel:getLingShouData(guid)
if lsData then
local resDta={}
resDta.isOther=true
resDta.guid=lsData.guid
resDta.guid_str=lsData.guid_str
resDta.id=lsData.id
resDta.name=lsData.name
resDta.jj_lvl=lsData.jj_lvl
resDta.jj_exp=lsData.jj_exp
resDta.zizhi=lsData.zizhi
resDta.qianli=lsData.qianli
resDta.xuemai_type=lsData.xuemai_type
resDta.xuemai_val=lsData.xuemai_val
resDta.sex=lsData.sex
resDta.generation=lsData.generation
resDta.xinqing=lsData.xinqing
resDta.born_times=lsData.born_times
resDta.pet_state=lsData.pet_state
resDta.qianli_item_len=lsData.qianli_item_len
resDta.qianliItemList=table.deepCopy(lsData.qianliItemList)
resDta.word_len=lsData.word_len
resDta.wordList=table.deepCopy(lsData.wordList)
resDta.xuemai_dianshu=lsData.xuemai_dianshu
resDta.skill_level=lsData.skill_level
resDta.tianfu_skill_id=lsData.tianfu_skill_id
resDta.qianli_init=lsData.qianli_init
resDta.skill_level_init=lsData.skill_level_init
return resDta
end
return nil
end

function lingshouModel:addLingShouData(lsData)
local isnew=false
local guid=lsData.guid
local guid_str=tostring(guid)
lsData.guid_str=guid_str
lsData.jj_exp_int64=lsData.jj_exp
lsData.jj_exp=mathHelper.int64_to_number(lsData.jj_exp)
if self.lingShouDatas[guid_str]==nil then
lsData.isnew=true
self.lingShouDatas[guid_str]=lsData
self.lingShouCnt=self.lingShouCnt+1
isnew=true
else
if lsData.fightValue==nil then
local oldFight=self.lingShouDatas[guid_str].fightValue
lsData.fightValue=oldFight
end
self.lingShouDatas[guid_str]=lsData
end
lingshouModel:applyLingShouAllWord(lsData)
lingshouModel:initAttrLookup(lsData)
return isnew
end

function lingshouModel:removeLingShouData(guid)
local guid_str=tostring(guid)
if self.lingShouDatas[guid_str]~=nil then
self.lingShouDatas[guid_str]=nil
self.lingShouCnt=self.lingShouCnt-1
return true
end
return false
end

function lingshouModel:clearAllLingShouNewSign()
if self.lingShouDatas then
for guid_str,lsData in pairs(self.lingShouDatas)do
lsData.isnew=nil
end
end
end

function lingshouModel:clearLingShouNewSignByLsGuid(lsGuid)
local guid_str=tostring(lsGuid)
if self.lingShouDatas and self.lingShouDatas[guid_str]then
local lsData=self.lingShouDatas[guid_str]
if lsData.isnew then
lsData.isnew=nil
end
end
end

function lingshouModel:getLSCount()
return self.lingShouCnt
end

function lingshouModel:getLSMaxCount()
local cfg=cfgHelper.get2(cfg_lingshoubasicconfig_get,1,'max_cnt')
local zmLevel=zongmenModel:getLevel()
local maxCount=0
for _,v in ipairs(cfg)do
local needZmLv=v[2]
local count=v[1]
if zmLevel>=needZmLv then
maxCount=count
else
break
end
end
return maxCount
end

function lingshouModel:getLsSortWordList(lsGuid)
local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData then
return self:getLsSortWordListEx(lsData)
end
return nil
end

function lingshouModel:getLsSortWordListEx(lsData)
local sortList={}
local lsWordList=lsData.wordList
if lsWordList then
for i,wordId in ipairs(lsWordList)do
local wordCfg=cfgHelper.get(cfg_lingshouwordconfig_get,wordId)
local color=wordCfg.framecolor
sortList[#sortList+1]={
wordId=wordId,
color=color,
}
end

if#sortList>1 then
table.sort(sortList,function(a,b)
if a.color==b.color then
return a.wordId<b.wordId
else
return a.color>b.color
end
end)
end
end

return sortList
end

function lingshouModel:getTalentSkillList(guid)
local lsData=lingshouModel:getLingShouData(guid)
if lsData then
return lingshouModel.getTalentSkillListEx(lsData)
end
return nil
end

function lingshouModel.getTalentSkillListEx(lsData)
local list={}
if lsData.tianfu_skill_id~=nil then
local level=1
local talentSkillId=lsData.tianfu_skill_id
if talentSkillId>0 then

table.insert(list,{talentSkillId,level,true,level})
end
end
return list
end

function lingshouModel.getTalentSkillMaxListEx(lsData)
local list={}
if lsData.tianfu_skill_id~=nil then

table.insert(list,{lsData.tianfu_skill_id,1})
end
return list
end

function lingshouModel.getSkillMaxList(lsID)
local list={}
local type2=cfgHelper.get2(cfg_lingshouconfig_get,lsID,'type2')
local jjCfg=cfg_lingshoujingjieconfig()
local jjMax=#jjCfg
local skills=cfgHelper.get2(cfg_lingshoujingjieconfig_get,jjMax,'skills')
local raceSkill=skills[type2]
if raceSkill~=nil then
for i,skill in ipairs(raceSkill)do
table.insert(list,{skill[1],skill[2]})
end
end
return list
end

function lingshouModel:getSkillList(guid)
local lsData=lingshouModel:getLingShouData(guid)
if lsData then
local addSLV=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.MAIN_SKILL_LEVEL)
local addPLV=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.PASSIVE_SKILL_LEVEL)
return lingshouModel.getSkillListEx(lsData.id,lsData.jj_lvl,lsData.xuemai_val,lsData.skill_level,addSLV,addPLV)
end
return{}
end

function lingshouModel.getSkillListEx(lsID,jjlv,xmlv,jnlv,jnplv,pplv)


local lsCfg=cfgHelper.get(cfg_lingshouconfig_get,lsID)
local type2=lsCfg.type2
local skills={}



if lsCfg.normal_skill then
table.insert(skills,{lsCfg.normal_skill,1,true})
end


local mainSkillId=lsCfg.skill
if mainSkillId then
local unlockSystemID=cfgHelper.get(cfg_lingshoubasicconfig_get,1,'skill_open_sys_id')
skills[#skills+1]={mainSkillId,jnplv,systemModel.isOpen(unlockSystemID),jnlv}
end


local xueMaiLv=xmlv or 1
local passiveSkillList=lsCfg.passive_skill
if passiveSkillList then
for i,skillId in ipairs(passiveSkillList)do
local skillLv=0
local skillLevelUpCfg=cfgHelper.get(cfg_lingshoupassiveskillconfig_get,skillId)
if skillLevelUpCfg then
local lvCfg=skillLevelUpCfg.up_level_conf
for level,cnd in ipairs(lvCfg)do
local needXmLv=cnd[1]
local needJJLv=cnd[2]
if xueMaiLv>=needXmLv and jjlv>=needJJLv then
skillLv=level
else
break
end
end
end
table.insert(skills,{skillId,pplv,skillLv>0,skillLv})
end
end

return skills
end

function lingshouModel:getColor(guid)
local lsData=lingshouModel:getLingShouData(guid)
return lingshouModel.getColorEx(lsData)
end

function lingshouModel:isMyActorLS(guid)
local lsData=lingshouModel:getLingShouData(guid)
return lsData~=nil
end

function lingshouModel.getColorEx(lsData)















local lsId=lsData.id
local lsCfg=cfgHelper.get1(cfg_lingshouconfig_get,lsId)
local color
if lsCfg then
color=lsCfg.color
end
return color
end

function lingshouModel:getXueMaiDesc(guid)
local lsData=lingshouModel:getLingShouData(guid)
return lingshouModel:switchLevelToStageName_XueMai(lsData.xuemai_val)
end

function lingshouModel.getXueMaiDescEx(race,xuemai_type,xuemai_val)
if xuemai_type==0 then
return'无'
else
if lingshouModel.checkZhenLingEx(race)then
local name=cfgHelper.get2(cfg_lingshouxuemaiconfig_get,xuemai_type,'name')
return FMT.fmt('{0}(觉醒)',name)
else
return FMT.fmt('{0}%',xuemai_val)
end
end
end

function lingshouModel.getXueMaiDescEx2(xuemaiLv)
return lingshouModel:switchLevelToStageName_XueMai(xuemaiLv)
end

function lingshouModel:getFanYanLeast(guid)
local lsData=self:getLingShouData(guid)
return lingshouModel.getFanYanLeastEx(lsData)
end

function lingshouModel.getFanYanLeastEx(lsData)
local lscfg=lsData.cfg
local fyCfg=cfgHelper.get1(cfg_lingshoubornconfig_get,lsData.id)
fyCfg=fyCfg and fyCfg[lsData.generation]or nil
local fyMax=fyCfg and fyCfg.born_times or 0
local fyNum=math.max(fyMax-lsData.born_times,0)
return fyNum
end

function lingshouModel:checkZhenLing(guid)
local lsData=lingshouModel:getLingShouData(guid)
return lingshouModel.checkZhenLingEx(lsData.cfg.race)
end

function lingshouModel.checkZhenLingEx(race)
return race<=0
end

function lingshouModel:checkCanAwake(guid)
local lsData=lingshouModel:getLingShouData(guid)
return self.checkCanAwakeEx(lsData.id)and lsData.xuemai_val>=100
end

function lingshouModel.checkCanAwakeEx(id)
local cfg=cfgHelper.get1(cfg_lingshouconfig_get,id)
local newId=cfg.new_id
if newId then
local newCfg=cfgHelper.get1(cfg_lingshouconfig_get,newId)
return newCfg~=nil
end
return false
end

function lingshouModel.checkEnoughAwake(xuemai_val,lsID,isWarning)
if xuemai_val<100 then
if isWarning then
UIManager.error('血脉浓度需达到100%')
end
return false
end
local juexing_cost=cfgHelper.get2(cfg_lingshouconfig_get,lsID,'juexing_cost')
for i,v in ipairs(juexing_cost)do
local itemid=v[1]
local itemnum=v[2]
local hasnum
if itemsConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
else
hasnum=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if hasnum<itemnum then
if isWarning then
UIManager.error('材料不足')
gainControl:showGainWin(itemid)
end
return false
end
end
return true
end

function lingshouModel:getModelParams(guid)
local lsData=lingshouModel:getLingShouData(guid)
return lingshouModel.getModelParamsEx(lsData.cfg.model)
end

function lingshouModel.getModelParamsEx(modelID)
local modelParams=comHelper.getMonsterModelParamsEx(modelID)
return modelParams
end

function lingshouModel:getFreeLingShouList()
local list={}
local lslookup=lingshouModel:getLingShouDatas()
for k,v in pairs(lslookup)do
if UIDiscipleModel:checkHasLingShouDZ(v.guid)==nil then
table.insert(list,v)
end
end
return list
end

function lingshouModel:hasFreeLingShou()
local list=lingshouModel:getFreeLingShouList()
return#list>0
end

function lingshouModel.getSearchName(guid_str,name,state_str)
local py=_LuaHelper.ToPinYin(name)
local str=FMT.fmt('{0}_{1}',name,py)
if state_str then
str=FMT.fmt('{0}_{1}',str,state_str)
end



return str
end

function lingshouModel:checkLingShouBatterReddot(dzGuid)

local isOpenLingShou=systemModel.isOpen(SYSTEM_DEFINE.eLingShou)
if not isOpenLingShou then
return false
end


local ls_guid=UIDiscipleModel:getDZLingShou(dzGuid)
local lsFight
if ls_guid then
lsFight=lingshouModel:getFightValue(ls_guid)
end


local lslookup=self.lingShouDatas
for lsGuidStr,lsData in pairs(lslookup)do
local guid=lsData.guid
local isFree=self.diziLookup and self.diziLookup[lsGuidStr]==nil
if isFree then
local fight=lingshouModel:getFightValue(guid)
if not lsFight or fight>lsFight then
return true
end
end
end

return false
end

function lingshouModel:checkLingShouQianLiRedDot(lsData)

local isOpenLingShou=systemModel.isOpen(SYSTEM_DEFINE.eLingShou)
if not isOpenLingShou then
return false
end

local qianLiItemCfgList=itemsLookup:get_function_items(item_funtion_type.eLingShouBaseAttr2)
local ownedItems=self:getOwnedQianLiItems(qianLiItemCfgList)
local canUse=false
for _,item in ipairs(ownedItems)do
if self:isCanUseQianLiDanYaoItem(lsData,item)then
canUse=true
break
end
end

return canUse
end



function lingshouModel:getOwnedQianLiItems(qlItemCfgList)
local ownedItems={}
for _,config in pairs(qlItemCfgList)do
local itemCount=bagModel.getItemCountById(config.id)

if itemCount>0 then
table.insert(ownedItems,config)
end
end

return ownedItems
end




function lingshouModel:isCanUseQianLiDanYaoItem(lsData,dyCfg)
if lsData==nil then
return true
end
local condInfo=dyCfg.funcparam.extra[1][1][ITEM_FUNC_CND_TYPE.eLingShouAttr2]
local targetRange={condInfo[2],condInfo[3]}
local qianli=lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)

return qianli>=targetRange[1]and qianli<=targetRange[2]
end





function lingshouModel:checkEnterLingShouReddot()
local reddot=false

if lingshouModel:getTop5MainSkillReddot()then
return true
end

if lingshouModel:getLingShouXueMaiReddot_Top5()then
return true
end

return reddot
end


function lingshouModel:checkLingShouReddot(lsGuid)
if self:checkLingShouReddot_info(lsGuid)then
return true
end

if self:checkLingShouReddot_jingjie(lsGuid)then
return true
end

if self:checkLingShouReddot_XueMai(lsGuid)then
return true
end

return false
end

function lingshouModel:checkLingShouReddotAndDiscipleEquip(lsGuid)
local isEquiped=lingshouModel:checkLsIsEquip(lsGuid)

if not isEquiped then return false end

if self:checkLingShouReddot_info(lsGuid)then
return true
end

if self:checkLingShouReddot_jingjie(lsGuid)then
return true
end

if self:checkLingShouReddot_XueMai(lsGuid)then
return true
end

return false
end
function lingshouModel:checkLingShouReddotByDzid(dzGuid)
local lsGuid=lingshouModel:getLingShouByDizi(dzGuid)

if not lsGuid then return false end

if self:checkLingShouReddot_info(lsGuid)then
return true
end

if self:checkLingShouReddot_jingjie(lsGuid)then
return true
end

if self:checkLingShouReddot_XueMai(lsGuid)then
return true
end

return false
end



function lingshouModel:checkLingShouReddot_info(lsGuid)
if lingshouModel:getMainSkillReddot(lsGuid)then
return true
end

return false
end


function lingshouModel:checkLingShouReddot_jingjie(lsGuid)
local reddot=false

return reddot
end


function lingshouModel:checkLingShouReddot_XueMai(lsGuid)
if lingshouModel:getLingShouXueMaiReddot(lsGuid)then
return true
end

return false
end



function lingshouModel:initLingShouEquip(diziArray)
self.lingShowSwitchIdxLookup={}
self.lingShouDatas_lookup={}
self.equipLsDiscipleCount=0
for i,v in ipairs(diziArray)do
self:addNewDizi(v,true)
end
end

function lingshouModel:deleDizi(diziguid)
self:deleteDzLingShou(diziguid)
end

function lingshouModel:addNewDizi(dizidata)
local diziguid=dizidata.discipleguid
local lsGuid=dizidata.lingshou_guid
if lsGuid and not mathHelper.compareInt64(lsGuid,Int64_0)then
self:addDzLingShou(diziguid,lsGuid)
end

if dizidata.switchList and next(dizidata.switchList)then
for switchidx,data in ipairs(dizidata.switchList)do
local lsGuid=data.lingshou_guid
if lsGuid and not mathHelper.compareInt64(lsGuid,Int64_0)then
self:addDzLingShou(diziguid,lsGuid,nil,switchidx)
end
end
end
end

function lingshouModel:addDzLingShou(diziguid,addLsGuid,showFightTips,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
local lsGuid=self.lingShouDatas_lookup[diziguidStr]and self.lingShouDatas_lookup[diziguidStr][switchidx]or nil
if lsGuid and tostring(lsGuid)==tostring(addLsGuid)then return end
if not self.lingShouDatas_lookup[diziguidStr]then
self.lingShouDatas_lookup[diziguidStr]={}
end
self.lingShouDatas_lookup[diziguidStr][switchidx]=addLsGuid
if switchidx~=0 then
self.lingShowSwitchIdxLookup[tostring(addLsGuid)]=switchidx
end

self.diziLookup[tostring(addLsGuid)]={guid=diziguid,switchidx=switchidx}

if switchidx==0 then

end

if lsGuid==nil then

self.equipLsDiscipleCount=self.equipLsDiscipleCount+1
end


lingshouModel:resetEquipFightLingShouGuidList()
end


function lingshouModel:deleteDzLingShou(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
local lsGuid=self.lingShouDatas_lookup[diziguidStr]and self.lingShouDatas_lookup[diziguidStr][switchidx]or nil
if lsGuid==nil then return end
self.lingShouDatas_lookup[diziguidStr][switchidx]=nil
self.diziLookup[tostring(lsGuid)]=nil
self.lingShowSwitchIdxLookup[tostring(lsGuid)]=nil
if switchidx==0 then

end


self.equipLsDiscipleCount=self.equipLsDiscipleCount-1
if self.equipLsDiscipleCount<0 then
self.equipLsDiscipleCount=0
end


lingshouModel:resetEquipFightLingShouGuidList()

return EQUIP_TYPE.eZhuZhan
end

function lingshouModel:switchDzLingShou(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if not self.lingShouDatas_lookup[diziguidStr]then
self.lingShouDatas_lookup[diziguidStr]={}
end
local useSwitchIdx=0
local originalLsGuid=self.lingShouDatas_lookup[diziguidStr][useSwitchIdx]
local switchLsGuid=self.lingShouDatas_lookup[diziguidStr][switchidx]
self.lingShouDatas_lookup[diziguidStr][useSwitchIdx]=switchLsGuid
self.lingShouDatas_lookup[diziguidStr][switchidx]=originalLsGuid

if originalLsGuid then
self.diziLookup[tostring(originalLsGuid)]={guid=diziguid,switchidx=switchidx}
self.lingShowSwitchIdxLookup[tostring(originalLsGuid)]=switchidx

end
if switchLsGuid and next(switchLsGuid)then
self.diziLookup[tostring(switchLsGuid)]={guid=diziguid,switchidx=useSwitchIdx}
self.lingShowSwitchIdxLookup[tostring(switchLsGuid)]=nil

end


lingshouModel:resetEquipFightLingShouGuidList()
end

function lingshouModel:onDressLingShou(diziguid,lsGuid)
self:addDzLingShou(diziguid,lsGuid,true)
end

function lingshouModel:onTakeOffLingShou(diziguid)
self:deleteDzLingShou(diziguid)
end

function lingshouModel:getLingShouByDizi(diziguid,switchidx)
if not diziguid then
return nil
end
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if self.lingShouDatas_lookup[diziguidStr]==nil then return end
if self.lingShouDatas_lookup[diziguidStr][switchidx]==nil then return end
return self.lingShouDatas_lookup[diziguidStr][switchidx]
end

function lingshouModel:getAnyDiziLingShou()
if self.lingShouDatas_lookup==nil then return end
return self.lingShouDatas_lookup
end

function lingshouModel:getLingShouSwitchIdx(lsGuid)
return self.lingShowSwitchIdxLookup[tostring(lsGuid)]
end

function lingshouModel:getDiziguidByLsGuid(lsGuid)
local data=self.diziLookup[tostring(lsGuid)]
return data and data.guid or nil
end

function lingshouModel:checkLsIsEquip(lsGuid)
local data=self.diziLookup[tostring(lsGuid)]
if data and data.guid then
return true
end
return false
end


function lingshouModel:getEquipLsDiscipleCount()
return self.equipLsDiscipleCount or 0
end


function lingshouModel:refreshFightList()
local lsDatas=lingshouModel:getLingShouDatas()
if lsDatas==nil then return end

local needIterateSortList=self.fightFreshTag~=false or self.equipFightFreshTag~=false

if self.fightFreshTag~=false then
self.fightFreshTag=false

local sortTag={}
local sortList={}
for _,v in pairs(lsDatas)do
local ls_guid=v.guid
local fight=lingshouModel:getFightValue(ls_guid)
sortTag[v.guid_str]=fight
sortList[#sortList+1]=v
end

_sort(sortList,function(a,b)
return sortTag[a.guid_str]>sortTag[b.guid_str]
end)

self.topFightSortList=sortList
end

if needIterateSortList then
if self.equipFightFreshTag~=false then
self.equipFightFreshTag=false
end
local sortList=self.topFightSortList

local top5List={}
local top5EquipList={}
for i=1,#sortList do
local lsData=sortList[i]
local lsGuid=lsData.guid
local lsGuidStr=lsData.guid_str


if i<=5 then
_insert(top5List,{
topIndex=i,
lsGuid=lsGuid,
lsGuidStr=lsGuidStr,
})
end

local isEquip=lingshouModel:checkLsIsEquip(lsGuid)
if isEquip then
local top5EquipCount=#top5EquipList
if top5EquipCount<5 then
_insert(top5EquipList,{
topIndex=i,
equipTopIndex=top5EquipCount+1,
lsGuid=lsGuid,
lsGuidStr=lsGuidStr,
})
else

break
end
end
end
self.top5FightList=top5List
self.top5FightEquipList=top5EquipList
end
end

function lingshouModel:resetFightLingShouGuidList()
self.fightFreshTag=true
end

function lingshouModel:resetEquipFightLingShouGuidList()
self.equipFightFreshTag=true
end


function lingshouModel:getFightTop5LingShouGuidList()
lingshouModel:refreshFightList()

if self.top5FightList==nil then self.top5FightList={}end

return self.top5FightList
end


function lingshouModel:getFightTop5EquipLingShouGuidList()
lingshouModel:refreshFightList()

if self.top5FightEquipList==nil then self.top5FightEquipList={}end

return self.top5FightEquipList
end




function lingshouModel:getLingShouByFightIndex(fightIndex)
if fightIndex==nil or fightIndex<=0 then return nil end
local list=lingshouLookup:getSortList(eLingShouSortType.eFightSort,nil,nil)
local c=#list
if c>0 then
local temp=list[fightIndex]
if temp==nil then
temp=list[1]
end
return temp
end
return nil
end

function lingshouModel.refreshSpecialityItem(item,speCfg,clickFunc,name)
name=lingshouModel.getSpecialityNameStr(name or speCfg.name)
item:SetChildText(0,name)
local abName,frameIcon=lingshouModel.getSpecialityColorFrame(speCfg.framecolor)
item:SetChildCSImageSprite(1,abName,frameIcon)

local showEffect=speCfg.effectID~=nil
item:SetChildActive(2,showEffect)
if showEffect then
item:SetChildAnimationStringID(2,speCfg.effectID,true)
end

if clickFunc then
item:SetChildButtonClick(1,clickFunc)
end
end

function lingshouModel.getSpecialityColorFrame(color)
local abName=globalABLookup.lingshoumain

local frameIcon
if color==2 then
frameIcon="image_lingshou_8"
elseif color==6 then
frameIcon="image_lingshou_9"
elseif color==4 then
frameIcon="image_lingshou_11"
elseif color==1 then
frameIcon="image_lingshou_10"
else
frameIcon=FMT.fmt("frame_tytezhikuang_{0}",color)
end

return abName,frameIcon
end

function lingshouModel.getSpecialityNameStr(name)
if pfwindowslController:checkIsGameVersion_yuenan()then
name=string.addNewlineAfterSecondWord(name)
if string.lenEx(name)>22 then
name=utf8.sub(name,1,22)
name=string.format("%s...",name)
end
else
if string.lenEx(name)>4 then
name=utf8.sub(name,1,4)
name=string.format("%s...",name)
end
end
return name
end





function lingshouModel:setSaveSortType(idx)

onlineDataSetting:setData(onlineDataKeyType.eLingShouSelectSortType,idx)
end
function lingshouModel:getSaveSortType()

return onlineDataSetting:getData(onlineDataKeyType.eLingShouSelectSortType,eLingShouSortType.eFightSort)
end
function lingshouModel:setSaveSortCondition(sortCondition)
local saveSortCondition={}
for k,v in pairs(sortCondition)do
saveSortCondition[tostring(k)]=v
end

onlineDataSetting:setData(onlineDataKeyType.eLingShouSelectSortCond,saveSortCondition)
end
function lingshouModel:getSaveSortCondition()

local temp=onlineDataSetting:getData(onlineDataKeyType.eLingShouSelectSortCond,{})
local saveSortCondition={}
for k,v in pairs(temp)do
saveSortCondition[tonumber(k)]=v
end
return saveSortCondition
end

function lingshouModel:setSaveSortType2(idx)
userActorSetting.flushVal(self.sortTypeKey2,idx)
end

function lingshouModel:getSaveSortType2()
return userActorSetting.get(self.sortTypeKey2,eLingShouSortType.eFightSort)
end




function lingshouModel:checkLSqianliReddot(select_guid)
local lsData=lingshouModel:getLingShouData(select_guid)
if lsData then

local ls_generation=lsData.generation or 0
local fyCfg=cfgHelper.get1(cfg_lingshouconfig_get,lsData.id)
local ls_color=fyCfg.color
local config=cfgHelper.get1(cfg_lingshoubasicconfig_get,1)
local color_ql_max=config.color_ql_max
local generation_ql_max=config.generation_ql_max
local ql_itemlist=config.ql_itemlist
for k,v in ipairs(ql_itemlist)do
local itemid=v[1]
local bagcount=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if bagcount>0 then
local max=0
if generation_ql_max[ls_generation]and generation_ql_max[ls_generation][itemid]then
max=generation_ql_max[ls_generation][itemid]
end
if color_ql_max[ls_color]and color_ql_max[ls_color][itemid]then
max=max+color_ql_max[ls_color][itemid]
end
local now_Num=0
if lsData.qianliItemList then
for k,v in ipairs(lsData.qianliItemList)do
if v.param_1==itemid then
now_Num=v.param_2
break
end
end
end
if now_Num<max then
return true
end
end
end
return false
end
end

function lingshouModel:getLSOrder(lsGuid)
if lsGuid==nil then return 0 end
local lsData=self:getLingShouData(lsGuid)
if lsData~=nil then
local v=lsData.follow_level
if v==nil then
return 0
end
return tonumber(v)or 0
end
return 0
end

function lingshouModel:checkLSHasOrder(lsGuid)
return self:getLSOrder(lsGuid)>0
end

function lingshouModel:setLSOrder(lsGuid,order,silent)
if lsGuid==nil then return end

local newOrder=mathHelper.int64_to_number(order)
local oldOrder=self:getLSOrder(lsGuid)
local lsData=self:getLingShouData(lsGuid)
if lsData~=nil then
lsData.follow_level=newOrder
end

if silent then return end
if oldOrder~=newOrder then
notifySystem:postNotify(notifyConfig.onLingShouOrderChange,lsGuid,oldOrder,newOrder)
end
end






function lingshouModel:checkIsInitLingShou(lsGuid)
if lingshouModel:checkIsUpJingJie(lsGuid)then
return false
end

if lingshouModel:checkIsUpXueMai(lsGuid)then
return false
end

if lingshouModel:checkIsUpQianLi(lsGuid)then
return false
end

return true
end




function lingshouModel:checkIsInitLingShou_onlyJingJie(lsGuid)
if lingshouModel:checkIsUpXueMai(lsGuid)then
return false
end

if lingshouModel:checkIsUpQianLi(lsGuid)then
return false
end

if lingshouModel:checkIsUpJingJie(lsGuid)then
return true
end

return false
end




function lingshouModel:checkIsUpJingJie(lsGuid)
local lsData=self:getLingShouData2(lsGuid)

return lsData.jj_lvl>lsData.cfg.init_lv
end




function lingshouModel:checkIsUpXueMai(lsGuid)
local lsData=self:getLingShouData2(lsGuid)

return lsData.xuemai_val>1 or lsData.xuemai_dianshu>0
end




function lingshouModel:checkIsUpQianLi(lsGuid)
local lsData=self:getLingShouData2(lsGuid)

return lsData.qianli_item_len>0
end


function lingshouModel:getLSXinQingValue(lsGuid)
if lsGuid then
local lsData=self:getLingShouData(lsGuid)
return self:getLSXinQingValueEx(lsData)
end
return 0
end


function lingshouModel:getLSXinQingValueEx(lsData)
if lsData and lsData.xinqing then
return lsData.xinqing/100
end
return 0
end


function lingshouModel:getLSXinQingMaxValue(lsGuid)
if lsGuid then
local lsData=self:getLingShouData(lsGuid)
return self:getLSXinQingMaxValueEx(lsData)
end
return 0
end


function lingshouModel:getLSXinQingMaxValueEx(lsData)
local maxCfgValue=lsData.cfg.max_love
return maxCfgValue
end

function lingshouModel:checkNoOptState(lsGuid)
local dzGuid=lingshouModel:getDiziguidByLsGuid(lsGuid)
if dzGuid==nil then return false end

local isLDLock=UIDiscipleModel:checkDZClientState(dzGuid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return true
end

return false
end

