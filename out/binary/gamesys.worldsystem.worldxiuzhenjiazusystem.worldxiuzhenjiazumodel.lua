






local _MODULENAME="worldXiuZhenJiaZuModel"




def_table(_MODULENAME)
worldXiuZhenJiaZuModel.name=_MODULENAME



familyFightType={
quzhu=1,
zhanling=2,
jinzhu=3,
}

familyState={

neutral=0,
player=1,
system=2,
}

worldXiuZhenJiaZuModel.data={}
local _openFamilyData={}
local _librarys={}
local _isInit=false

function worldXiuZhenJiaZuModel:onAppStart()
self.fightResult={}
end


function worldXiuZhenJiaZuModel:onEnterState()



end


function worldXiuZhenJiaZuModel:onLeaveState(isReconnet)

if not isReconnet then
self.fightResult={}
self.data={}
_openFamilyData={}
_librarys={}
end
_isInit=false
end


function worldXiuZhenJiaZuModel:onServerDataInitFinish()

end

function worldXiuZhenJiaZuModel:getFamilyConfig(familyId)
return cfgHelper.get1(cfg_xiuzhenfamilydataconfig_get,familyId)
end

function worldXiuZhenJiaZuModel:getElderConfig(familyId)
local familyCfg=self:getFamilyConfig(familyId)
return cfgHelper.get1(cfg_xiuzhenfamilyelderconfig_get,familyCfg.elder_id)
end

function worldXiuZhenJiaZuModel:convertKey(guid)
return worldModel:convertUnitKey({eWorldUnitTpye.FAMILY,tostring(guid)})
end

function worldXiuZhenJiaZuModel:dealServerFamilyData(world,familyData)












local data={
world=world,
guid=familyData.guid,
unFamilyId=tostring(familyData.guid),
familyId=familyData.family_id,
peopleCnt=familyData.people_cnt,
tedianId=familyData.characteristic_id,
specialityId=familyData.speciality_id,
ownId=familyData.own_id,
state=familyData.state,
firstRewardFlag=familyData.first_reward_flag,
dzLen=familyData.dizi_len,
dzList=familyData.teamList,
elderNameIdx=familyData.elder_name_idx,
initId=familyData.initNo,

}
return data
end


function worldXiuZhenJiaZuModel:addFamilyObjData(world,familyData)
local data=self:dealServerFamilyData(world,familyData)
self.data[data.unFamilyId]=data
self:initFamilyPosition(data)
chatGGModel.changeJiazuData(data.unFamilyId,true)
end


function worldXiuZhenJiaZuModel:getAllFamilyData(world)
local list={}
for guidStr,data in pairs(self.data)do
if data.world==world then
table.insert(list,data)
end
end
return list
end


function worldXiuZhenJiaZuModel:removeFamilyData(guid)
self.data[tostring(guid)]=nil
worldPositionLibrary:eraseData(guid)

self:removeOpenFamily(guid)
chatGGModel.changeJiazuData(tostring(guid),false)
end

function worldXiuZhenJiaZuModel:getFamilyDataByGuid(guid)
return self.data[tostring(guid)]
end


function worldXiuZhenJiaZuModel:changeFamilyDzList(guid,dzLen,dzList)
local familyData=self:getFamilyDataByGuid(guid)
if familyData then
familyData.dzLen=dzLen
familyData.dzList=dzList
end
end


function worldXiuZhenJiaZuModel:changeFamilyState(guid,state)

local familyData=self:getFamilyDataByGuid(guid)
if familyData then
local oldState=familyData.state
familyData.state=state
if state==familyState.neutral then
familyData.dzLen=0
familyData.dzList=nil
end
notifySystem:postNotify(notifyConfig.on_family_state_change,familyData.world,familyData.guid,oldState,state)
end
UIRecruitModel:initFamilyNeedCost()
end


function worldXiuZhenJiaZuModel:changeFamilyPeople(familyLen,familyList)
if familyLen>0 then





for i,v in ipairs(familyList)do
local data=self:getFamilyDataByGuid(v.param_1)
if data then
data.peopleCnt=v.param_2
end
end
end
end


function worldXiuZhenJiaZuModel:getBlockFamilyData(world,block)
local list={}
for guidStr,data in pairs(self.data)do
if world==data.world and block==data.block then
table.insert(list,data)
end
end
return list
end


function worldXiuZhenJiaZuModel:getFamilyScaleData(guid)
local data=self:getFamilyDataByGuid(guid)
local num=data.peopleCnt

local cfg=cfg_xiuzhenfamilybasicconfig_get(data.world)
local guimoList=cfg.family_pre_names
for i,v in ipairs(guimoList)do
if(num>=v[1]and num<=v[2])or(i==#guimoList and num>=v[2])then
return i,v
end
end
return-1
end


function worldXiuZhenJiaZuModel:getFamilyName(guid,useAreaName)
local index,nameCfg=self:getFamilyScaleData(guid)
local name=''
if index~=-1 then
local data=self:getFamilyDataByGuid(guid)
local elderCfg=self:getElderConfig(data.familyId)
if elderCfg then

local lastName=''
if string.lenEx(elderCfg.elder_lastname)>1 then
lastName=elderCfg.elder_lastname
else
lastName=FMT.fmt('{0}氏',elderCfg.elder_lastname)
end
if useAreaName then
local qukuaiName=cfgHelper.get3(cfg_worldblockconfig_get,data.world,data.block,'name')
if pfwindowslController:checkIsGameVersion_yuenan()then
name=FMT.fmt('（{0}）{1} {2}',qukuaiName,nameCfg[3],lastName)
else
name=FMT.fmt('（{0}）{1}{2}',qukuaiName,lastName,nameCfg[3])
end
else
if pfwindowslController:checkIsGameVersion_yuenan()then
name=FMT.fmt('{0} {1}',nameCfg[3],lastName)
else
name=FMT.fmt('{0}{1}',lastName,nameCfg[3])
end
end
end
end
return name
end

function worldXiuZhenJiaZuModel:getFamilyName2(guid,useAreaName)
local index,nameCfg=self:getFamilyScaleData(guid)
local name=''
if index~=-1 then
local data=self:getFamilyDataByGuid(guid)
local elderCfg=self:getElderConfig(data.familyId)
if elderCfg then

local lastName=''
if string.lenEx(elderCfg.elder_lastname)>1 then
lastName=elderCfg.elder_lastname
else
lastName=FMT.fmt('{0}氏',elderCfg.elder_lastname)
end
if pfwindowslController:checkIsGameVersion_yuenan()then
name=FMT.fmt('{0} {1}',nameCfg[3],lastName)
else
name=FMT.fmt('{0}{1}',lastName,nameCfg[3])
end
end
end
return name
end


function worldXiuZhenJiaZuModel:getZuZhangName(guid)
local data=self:getFamilyDataByGuid(guid)
local elderCfg=self:getElderConfig(data.familyId)
local firsetName=elderCfg.elder_fisrtname
local name=FMT.fmt('{0}{1}',elderCfg.elder_lastname,firsetName[data.elderNameIdx])
return name
end


function worldXiuZhenJiaZuModel:getZuZhangImageInfoInSide(args)
local imageInfo={}
imageInfo.sex=args[1]
imageInfo.hair=args[2]
imageInfo.face=args[3]
imageInfo.body=args[4]
imageInfo.accessory=args[5]
local result=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
return result
end


function worldXiuZhenJiaZuModel:addOpenFamilyData(guid)






table.insert(_openFamilyData,guid)
end

function worldXiuZhenJiaZuModel:addNewOpenFamilyDataByUnlock(world,block)















local list=self:getBlockFamilyData(world,block)
for i,v in ipairs(list)do
worldXiuZhenJiaZuModel:addOpenFamilyData(v.guid)
end
end

function worldXiuZhenJiaZuModel:removeOpenFamily(guid)









table.removeValueEx(_openFamilyData,guid,function(value)return tostring(value)end)
end

function worldXiuZhenJiaZuModel:init()
_isInit=true
end

function worldXiuZhenJiaZuModel:isInit()
return _isInit==true
end

function worldXiuZhenJiaZuModel:clearOpenFamilyData()
_openFamilyData={}
end

function worldXiuZhenJiaZuModel:clearAllFamilyData()
self.data={}
end

function worldXiuZhenJiaZuModel:checkPosition(array)
if array==nil then

return
end
local posList={}
for i,v in pairs(array or{})do
if v.arr_len>0 then
for j,w in ipairs(v.xzfamilyList)do
table.insert(posList,w.guid)
end
end
end
worldPositionLibrary:checkData(eWorldUnitTpye.FAMILY,posList)
end


function worldXiuZhenJiaZuModel:getFamilyAreaList()






























local areaList={}
local cfg=cfg_worldareaconfig()
for areaId,areaCfg in pairs(cfg)do
local world=areaCfg.world
if worldBlockModel:getWorldStateCount(world,eWorldBlockState.OPEN)>0 then
areaList[areaId]={}
local blocks=areaCfg.blocks
for i,block in ipairs(blocks)do
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
local list=self:getBlockFamilyData(world,block)
areaList[areaId]=table.concatTable(areaList[areaId],list)
end
end
end




end

return areaList
end

function worldXiuZhenJiaZuModel:getOpenListIndexByGuid(guid)
local data=self:getFamilyDataByGuid(guid)
if data then
local areaList=self:getFamilyAreaList(data.world)
for i,list in ipairs(areaList)do
for j,v in ipairs(list)do
if mathHelper.compareInt64(v.guid,guid)then
return i,j
end
end
end
end
end


function worldXiuZhenJiaZuModel:setFirstRewardFlag(guid)
local familyData=self:getFamilyDataByGuid(guid)
if familyData then
familyData.firstRewardFlag=0
end

local areaFamily=worldXiuZhenJiaZuModel:getFamilyAreaList(familyData.world)
for k,openFamily in pairs(areaFamily)do
for i,v in ipairs(openFamily)do
if mathHelper.compareInt64(v.guid,guid)then
v.firstRewardFlag=0
end
end
end
end

function worldXiuZhenJiaZuModel:checkReddot()
local areaList=self:getFamilyAreaList()
for i,list in ipairs(areaList)do
for j,v in ipairs(list)do
if v.firstRewardFlag~=0 then
return true
end
end
end
return false
end

function worldXiuZhenJiaZuModel:checkDzIsInOtherFamily(dzId,guid)
local selfGuid=guid or self.curSelectGuid
for _,v in pairs(self.data)do
if v.guid~=selfGuid then
local dzList=v.dzList
if dzList then
for i,dzData in ipairs(dzList)do
if dzData.unitId==dzId then
return true
end
end
end
end
end
return false
end

function worldXiuZhenJiaZuModel:setCurSelectGuid(guid)
self.curSelectGuid=guid
end


function worldXiuZhenJiaZuModel:getAllSelfFamilyData()
local list={}
for guidStr,family in pairs(self.data)do
if family.state==familyState.player then
table.insert(list,family)
end
end
return list
end


function worldXiuZhenJiaZuModel:getAllSelfFamilyDataCount()
local num=0
for guidStr,family in pairs(self.data)do
if family.state==familyState.player then
num=num+1
end
end
return num
end

function worldXiuZhenJiaZuModel:isHaveFamilyData()
local selfFamilyList=worldXiuZhenJiaZuModel:getAllSelfFamilyData()
return#selfFamilyList>0
end

function worldXiuZhenJiaZuModel:initFamilyPosition(data)
if worldPositionLibrary:containData(data.guid)then
local info=worldPositionLibrary:getData(data.guid)
local position,block=worldPositionConfig:getPosition(data.world,{info.x,info.z})
data.x=info.x
data.z=info.z
data.flip=info.flip
data.block=block
data.position=position

if position~=Vector3.zero then
return
else
loggerUtil.logErrFMT("本地存在错误修真家族旧坐标数据:{0},({1},{2}),{3}",data.world,info.x,info.z,tostring(data.guid))
worldPositionLibrary:eraseData(data.guid)
end
end

local world=data.world
local x,z,flip,valid
if data.initId>0 then
local initCfg=cfgHelper.get1(cfg_xiuzhenfamilyinitdataconfig_get,data.initId)
x=initCfg.pos[1]
z=initCfg.pos[2]
flip=initCfg.flipX
valid=true
else
local library=self:getLibrary(world)
local check,temp=worldPositionLibrary:extract(library)
if check then
x=temp[1].x
z=temp[1].z
flip=temp[1].flip
valid=true
else
x=0
z=0
flip=false
valid=false
loggerUtil.logErrFMT("修真家族坐标随机库抽取失败,GUID:{0}",tostring(data.guid))
end
end
if valid then
worldPositionLibrary:markData(world,x,z,flip,eWorldUnitTpye.FAMILY,data.guid)
end
local position,block=worldPositionConfig:getPosition(world,{x,z})
data.x=x
data.z=z
data.flip=flip
data.block=block
data.position=position


end





















function worldXiuZhenJiaZuModel:getCurWorlSelfAllFamily()
local list={}
for guidStr,family in pairs(self.data)do
if family.state==familyState.player then
table.insert(list,family)
end
end
return list
end

function worldXiuZhenJiaZuModel:isJinZhuZhong(guid)
local unitKey=worldXiuZhenJiaZuModel:convertKey(guid)
local taskKey=worldTaskModel:findLastTaskKey_ByTarget(unitKey)
local jinzhuzhong=false
if taskKey then
local task=worldTaskModel:getTask(taskKey)
jinzhuzhong=task.progress_state==eWorldTripProgress.Work
end
return jinzhuzhong
end

function worldXiuZhenJiaZuModel:getFamilyLimit()
local zmLevel=zongmenModel:getLevel()
local basicCfg=cfgHelper.getdef(cfg_xiuzhenfamilybasicconfig,'family_cnt_limit')
local limit=basicCfg
local limitCnt=0

local idx=nil
for i,v in ipairs(limit)do
if zmLevel>=v[1]then
limitCnt=v[2]
idx=i
else
break
end
end

limitCnt=limitCnt+gubaoModel:getGBSkil_XiuZhenJiaZuAddNum()
return limitCnt,idx<#limit,limit[idx+1]
end

function worldXiuZhenJiaZuModel:checkFamilyLimit(reCnt)
local selfFamilyList=worldXiuZhenJiaZuModel:getCurWorlSelfAllFamily(worldModel.world)
local count=#selfFamilyList
local limitCnt,isMax,nextLv=worldXiuZhenJiaZuModel:getFamilyLimit()


local missionCnt=0
for k,v in pairs(self.data)do
local isSelf=v.state==familyState.player
if not isSelf and worldXiuZhenJiaZuController:checkMission(v.guid)then
local result=self:getFightResult(v.unFamilyId)
if result and result[1]==fightResultType.Victory then
missionCnt=missionCnt+1
end
end
end
local haveCnt=count+missionCnt
if reCnt then
return haveCnt>=limitCnt,haveCnt,limitCnt,isMax,nextLv
else
return haveCnt>=limitCnt
end
end



function worldXiuZhenJiaZuModel:setFightResult(guid,result,logIdx,world,subType)
self.fightResult[tostring(guid)]={result,logIdx,world,subType}
end

function worldXiuZhenJiaZuModel:clearFightResult(guid)
self.fightResult[tostring(guid)]=nil
end

function worldXiuZhenJiaZuModel:getFightResult(guid)
self.fightResult=self.fightResult or{}
return self.fightResult[tostring(guid)]
end

function worldXiuZhenJiaZuModel:showFightResult(guid)
local result=self:getFightResult(guid)
if result then
local subType=result[4]
local world=result[3]
local logIdx=result[2]
local fightResult=result[1]

self:afterFight(fightResult,guid,subType)
end
self:clearFightResult(guid)
end

function worldXiuZhenJiaZuModel:afterFight(result,guid,subType)

if result==fightResultType.Victory then
UIManager.info('交涉成功')
if subType==familyFightType.jinzhu then
worldXiuZhenJiaZuModel:changeFamilyState(guid,familyState.player)
end
else
UIManager.info('交涉失败')
if subType==familyFightType.jinzhu then
worldXiuZhenJiaZuModel:changeFamilyState(guid,familyState.neutral)
end
end

UIManager:callWindowFunc("UIWorldXiuZhenJiaZuListWin","refreshCount")




end

function worldXiuZhenJiaZuModel:initLibrary()
_librarys={}
local cfg=cfg_worldblockconfig()
for world,v in pairs(cfg)do
for block,w in pairs(v)do

self:addLibrary(world,block)

end
end
end

function worldXiuZhenJiaZuModel:addLibrary(world,block)
if not _librarys[world]then
_librarys[world]={}
end
local cfg=cfgHelper.get1(cfg_xiuzhenfamilyblockposconfig_get,world)
if cfg then
cfg=cfg[block]
if cfg then
_librarys[world]=table.concatTable(_librarys[world],cfg.library)
end
end
end

function worldXiuZhenJiaZuModel:getLibrary(world)
if not _librarys[world]then
_librarys[world]={}
end
return _librarys[world]
end
