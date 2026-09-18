






UISchoolModel={}

UISchoolModel.data={}


UISchoolModel.curAniState={
changeDZ=1,
classOver=2,
}

UISchoolModel.achieveType={
course=1,
studyStatus=2,
}


function UISchoolModel:on_enter_state()
self.data.classInfo={}
self.data.studyResult={}
self.data.saveOldProSkill={}
self.data.stateCntList={}
self.data.rewardIdList={}
self:loadClassIsNewState()
self:loadClassSelectDzDataList()
self:initAchieveReward()
end

function UISchoolModel:on_leave_state()
self:saveClassSelectDzDataList()

self.data={}
end

function UISchoolModel:init_data(num,maxNum,len,classInfo,stateCntList,rewardIdLen,rewardIdList)
self.data.teachNum=num

if len>0 then
self.data.classInfo=classInfo
else
self.data.classInfo={}
end
if rewardIdLen>0 then
self.data.rewardIdList=rewardIdList
else
self.data.rewardIdList={}
end
self.data.stateCntList=stateCntList
end


function UISchoolModel:get_study_remainNum()
local teachNum=self.data.teachNum or 0
local maxNum=UISchoolModel:get_study_maxNum()
local remainNum=maxNum-teachNum
if remainNum<0 then
remainNum=0
end
return remainNum
end

function UISchoolModel:getSchoolBDData()
local bdData
if not self.data.schoolUnBdId then
bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXueShiShuYuan)
if not bdData then
return
end
self.data.schoolUnBdId=bdData.un_build_id
else
bdData=zongmenModel:getBuildingData(self.data.schoolUnBdId)
end
return bdData
end


function UISchoolModel:get_study_maxNum()












local bdData=self:getSchoolBDData()
if not bdData then
return 0
end

local cfgMaxTeachNum=cfgHelper.get2(cfg_collegearchitectureconfig_get,bdData.level,'teachnum')
local maxNum=cfgMaxTeachNum or 0


local gubaoAddCount=gubaoModel:getGBSkil_SchoolMaxCount()
maxNum=maxNum+gubaoAddCount
return maxNum
end


function UISchoolModel:get_study_classInfo()
return self.data.classInfo
end


function UISchoolModel:getStudyStatusNum(state)
return self.data.stateCntList[state]or 0
end

function UISchoolModel:set_study_result(array)
self.data.studyResult=array
end


function UISchoolModel:get_study_result()
return self.data.studyResult
end


function UISchoolModel:get_classData_byType(classType)
local classInfo=UISchoolModel:get_study_classInfo()
for k,v in pairs(classInfo)do
if v.courseId==classType then
return v
end
end
end






function UISchoolModel:getDZListSortResult(sixAttrType,classType,sortOrder,sordType)
local list=discipleLookup:getSortDiscipleList()

local canOption={}
for i,v in ipairs(list)do
local netData=v.netData
local net=netData.net
local guid=net.discipleguid
local sixAttrValue=UIDiscipleModel:getDiscipleBaseAttr(guid,sixAttrType)
local classLevel=UIDiscipleModel:getDiscipleJobLevel(guid,classType)
local fightVal=UIDiscipleModel:getDiscipleFightValue(net.discipleguid)
if sordType==1 then
v.sortFlag=classLevel*10000000+fightVal
else
v.sortFlag=sixAttrValue*10000000+fightVal
end

local proSkillConst=cfgHelper.getdef(cfg_discipleproskillconfig)
local expList=proSkillConst.exp
local maxLevel=#expList



if classLevel<maxLevel then
table.insert(canOption,v)
end
end

local notOption={}
for i,v in ipairs(list)do
v.sortFlag2=i
local netData=v.netData
local net=netData.net
local guid=net.discipleguid
local classLevel=UIDiscipleModel:getDiscipleJobLevel(guid,classType)

local proSkillConst=cfgHelper.getdef(cfg_discipleproskillconfig)
local expList=proSkillConst.exp
local maxLevel=#expList



if classLevel>=maxLevel then
local sixAttrValue=UIDiscipleModel:getDiscipleBaseAttr(guid,sixAttrType)
local fightVal=UIDiscipleModel:getDiscipleFightValue(guid)
v.sortFlag2=sixAttrValue*10000000+fightVal
table.insert(notOption,v)
end
end
if sortOrder==eSortOrder.eDown then
table.sort(canOption,function(a,b)return a.sortFlag>b.sortFlag end)
table.sort(notOption,function(a,b)return a.sortFlag2>b.sortFlag2 end)
else
table.sort(canOption,function(a,b)return a.sortFlag<b.sortFlag end)
table.sort(notOption,function(a,b)return a.sortFlag2<b.sortFlag2 end)
end
local temp=table.concatTableX(canOption,notOption)
return temp
end


function UISchoolModel:setOldDiZiProSkillData(guid,skillData)
self.data.saveOldProSkill[tostring(guid)]=skillData
end

function UISchoolModel:getOldDiZiProSkillData(guid)
return self.data.saveOldProSkill[tostring(guid)]
end


function UISchoolModel:getUpLevelNum(guid,classType,addExp,skillData)
local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
skillData=skillData or self.data.saveOldProSkill[tostring(guid)]
local oldLevel=skillData[1]
local curExp=skillData[2]
local upLevel=0
for i=oldLevel,#explist do
local curNeed=explist[i]
if addExp+curExp>=curNeed then
addExp=addExp+curExp-curNeed
upLevel=upLevel+1
curExp=0
else
return upLevel
end
end
return upLevel
end


function UISchoolModel:get_sort_class()
local classConfig=cfg_collegecourseconfig()
local zongmengLv=zongmenModel:getLevel()
local sortConfig={}
for i,v in ipairs(classConfig)do
if zongmengLv>=v.showlevel then
sortConfig[#sortConfig+1]=v
end
end
table.sort(sortConfig,function(a,b)
return a.sort<b.sort
end)
return sortConfig
end


function UISchoolModel:set_class_isNewState()
local classConfig=cfg_collegecourseconfig()
local zongmengLv=zongmenModel.data and zongmenModel:getLevel()or 1
for i,v in ipairs(classConfig)do
UISchoolModel:changeClassIsNewState(v.id,zongmengLv<v.showlevel)
end
end


function UISchoolModel:loadClassIsNewState()
self.classIsNewState=userActorSetting.get('schoolClassIsNewState',{})
end

function UISchoolModel:saveClassIsNewState()
userActorSetting.set('schoolClassIsNewState',self.classIsNewState)
userActorSetting.flush()
end

function UISchoolModel:changeClassIsNewState(id,val)
self.classIsNewState[id]=val
end

function UISchoolModel:getClassIsNewState(id)
return self.classIsNewState[id]
end


function UISchoolModel:saveLastSelectDzList(list)
self.data.lastSDzList=list
end

function UISchoolModel:clearSaveDzList()
self.data.lastSDzList={}
end


function UISchoolModel:loadClassSelectDzDataList()
local list=userActorSetting.get('schoolClassSelectDzDataList',{})
self.data.classSelectDzDataList={}
if list then
for classTypeStr,classList in pairs(list)do
local classType=tonumber(classTypeStr)
self.data.classSelectDzDataList[classType]={}
for indexStr,dzGuidStr in pairs(classList)do
local index=tonumber(indexStr)
if dzGuidStr=='0'then
self.data.classSelectDzDataList[classType][index]=0
else
local dzGuid=int64.new(dzGuidStr)
self.data.classSelectDzDataList[classType][index]=dzGuid
end
end
end
end
end


function UISchoolModel:saveClassSelectDzDataList()

if self.data and self.data.classSelectDzDataList then
local list={}
for classType,classList in pairs(self.data.classSelectDzDataList)do
local classTypeStr=tostring(classType)
list[classTypeStr]={}
for i,dzGuid in pairs(classList)do
local indexStr=tostring(i)
if dzGuid==0 then
list[classTypeStr][indexStr]='0'
else
local dzGuidStr=mathHelper.int64_to_string(dzGuid)
list[classTypeStr][indexStr]=dzGuidStr
end
end
end
userActorSetting.flushVal('schoolClassSelectDzDataList',list)
end
end


function UISchoolModel:test_clearClassSelectDzDataList()
userActorSetting.flushVal('schoolClassSelectDzDataList',nil)
end


function UISchoolModel:getClassSelectDzDataListByClassType(classType)
if not self.data.classSelectDzDataList then
self:loadClassSelectDzDataList()
end

self:checkSelectDzListEmptyDz(classType)
return self.data.classSelectDzDataList[classType]
end


function UISchoolModel:changeClassSelectDzDataListByClassType(classType,dzList)
if not self.data.classSelectDzDataList then
self:loadClassSelectDzDataList()
end
self.data.classSelectDzDataList[classType]=dzList
self:saveClassSelectDzDataList()
end

function UISchoolModel:checkSelectDzListEmptyDz(classType)
if self.data.classSelectDzDataList[classType]then
for i,dzGuid in ipairs(self.data.classSelectDzDataList[classType])do
if dzGuid~=0 then
local isZMDz=UIDiscipleModel:isZMDisciple(dzGuid)or false
if not isZMDz then
self.data.classSelectDzDataList[classType][i]=0
end
end
end
end
end

function UISchoolModel:checkIsOldSelectDz(guid)
if self.data.lastSDzList then
for i,v in ipairs(self.data.lastSDzList)do
if v==guid then
return i
end
end
end
end

function UISchoolModel:checkOldIndexReEnter(index)
local lastSDzList=self.data.lastSDzList
if lastSDzList and lastSDzList[index]then
return lastSDzList[index]==0
end
end

function UISchoolModel:checkDiZiNeedLeave(index,guid)
local lastSDzList=self.data.lastSDzList
if lastSDzList and lastSDzList[index]then
if guid==0 then
return lastSDzList[index]~=0
elseif lastSDzList[index]~=0 then
return lastSDzList[index]~=guid
end
end
end

function UISchoolModel:getDiZiList(list)
local temp={}
for i,v in ipairs(list)do
temp[#temp+1]=0
end

local newFlag={}
for i,guid in ipairs(list)do
local guidStr=tostring(guid)
local oldIndex=self:checkIsOldSelectDz(guid)
if oldIndex then
temp[oldIndex]=guid
newFlag[guidStr]=0
else
newFlag[guidStr]=guid
end
end

for _,guid in ipairs(list)do
local guidStr=tostring(guid)
for i,v1 in ipairs(temp)do
if v1==0 and newFlag[guidStr]~=0 then
temp[i]=newFlag[guidStr]
newFlag[guidStr]=0
end
end
end
return temp
end

function UISchoolModel:getAutoDiZiList(list,count)
local lastList=self.data.lastSDzList
if lastList==nil or#lastList==0 then return list end
local temp={}





local index=0
for i=1,count do
if not lastList[i]or lastList[i]==0 then
index=index+1
temp[i]=list[index]
else
temp[i]=lastList[i]
end
end
return temp
end



function UISchoolModel:set_classData_byType(rewardId)
table.insert(self.data.rewardIdList,rewardId)
end


function UISchoolModel:set_sendReward_id(rewardId)
self.data.rewardId=rewardId
end

function UISchoolModel:get_sendReward_id()
return self.data.rewardId
end


function UISchoolModel:initAchieveReward()
self.data.rewardTable={}
local rewardConfig=cfg_collegechengjiuconfig()
for i,v in ipairs(rewardConfig)do
if v.courseid then
local t=self.data.rewardTable[self.achieveType.course]
if t==nil then
t={}
self.data.rewardTable[self.achieveType.course]=t
end
local t1=t[v.courseid]
if t1==nil then
t1={}
t[v.courseid]=t1
end
t1.courseid=v.courseid
t1.rewardType=self.achieveType.course
t1.cfg=cfgHelper.get1(cfg_collegecourseconfig_get,v.courseid)
table.insert(t1,v)
elseif v.xyStatus then
local t=self.data.rewardTable[self.achieveType.studyStatus]
if t==nil then
t={}
self.data.rewardTable[self.achieveType.studyStatus]=t
end
local t1=t[v.xyStatus]
if t1==nil then
t1={}
t[v.xyStatus]=t1
end
t1.xyStatus=v.xyStatus
t1.rewardType=self.achieveType.studyStatus
t1.cfg=cfgHelper.get1(cfg_collegestudystatusconfig_get,v.xyStatus)
table.insert(t1,v)
end
end

self.data.allRewardList={}
for i,v in ipairs(self.data.rewardTable)do
for k,v1 in pairs(v)do
table.insert(self.data.allRewardList,v1)
end
end
table.sort(self.data.allRewardList,function(a,b)return a[1].id<b[1].id end)
end

function UISchoolModel:getShowRewardList()
return self.data.allRewardList
end

function UISchoolModel:getAchieveRewardTypeConfig(typo)
return self.data.rewardTable[typo]or{}
end


function UISchoolModel:getAchieveRewardConfig(typo,subId)
local rewardList=self:getAchieveRewardTypeConfig(typo)
local config=rewardList[subId]
local index=0
if config then
for i,v in ipairs(config)do
for _,v1 in ipairs(self.data.rewardIdList)do
if v.id==v1 then
index=i
break
end
end
end
return config[index],config[index+1]
end
end









function UISchoolModel:checkReward()
local rewardList=self:getShowRewardList()
local check=false
for i,v in ipairs(rewardList)do
check=self:checkSingleReward(v)
if check then
break
end
end
return check
end

function UISchoolModel:checkSingleReward(data)
if data.rewardType==self.achieveType.course then
local lastConfig,config=self:getAchieveRewardConfig(data.rewardType,data.courseid)
if config then
local proData=self:get_classData_byType(config.courseid)
local curStudyNum=0
if proData then
curStudyNum=proData.teachNum
end
local needTeachNum=config.num
if curStudyNum>=needTeachNum then
return true
end
end
else
local lastConfig,config=self:getAchieveRewardConfig(data.rewardType,data.xyStatus)
if config then
local state=config.xyStatus
local needStateNum=config.statusNum
local totalNum=self:getStudyStatusNum(state)
local stateCfg=data.cfg
if totalNum>=needStateNum then
return true
end
end
end
return false
end

function UISchoolModel:getSortRewardList()
local list={}
local rewardList=self:getShowRewardList()
for i,v in ipairs(rewardList)do
local canReward=self:checkSingleReward(v)
v.sortTag=v[1].id
if canReward then
v.sortTag=v[1].id-1000000
end
table.insert(list,v)
end
table.sort(list,function(a,b)return a.sortTag<b.sortTag end)
return list
end


function UISchoolModel:getIsSkipClassAnim()
local isSkip=false

if not UISchoolModel:checkIsCanSkipClassAnim()then

return false
end


isSkip=userActorSetting.get('skipSchoolClassAnim',false)

return isSkip
end


function UISchoolModel:setIsSkipClassAnim(flag)

if not UISchoolModel:checkIsCanSkipClassAnim()then

return
end


userActorSetting.flushVal('skipSchoolClassAnim',flag)
end


function UISchoolModel:checkIsCanSkipClassAnim()

local skipAnimCnd=cfgHelper.get2(cfg_collegebaseconfig_get,1,'skipAnimCnd')
if skipAnimCnd then
for i,v in ipairs(skipAnimCnd)do
local checkType=v[1]
local checkVal=v[2]
local checkVal2=v[3]
if checkType==1 then

if not systemModel.isOpen(checkVal)then
return false
end
elseif checkType==2 then

if playerModel:getActorLevel()<checkVal then
return false
end
elseif checkType==3 then

local book_id=checkVal
local index=checkVal2
if index and index>0 then
local chapterid=zheXianLingConfig.getChapterId(book_id,index)
if not zheXianLingModel:isRewardChapter(chapterid)then
return false
end
else
if not zheXianLingModel:isRewardBook(book_id)then
return false
end
end
end
end
end

return true
end