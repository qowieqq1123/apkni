






local table_insert=table.insert

local taskConditionFunc={

[taskConditionType.eZongMenLevel]={
events={taskConditionEventType.eZongMenLevelChange},
check=function(cond)
local fit=true
local w_str=nil
local num=cond[2]
local lv=zongmenModel:getLevel()
if lv<num then
fit=false
w_str=FMT.fmt('宗门达到{0}级',num)
end
return fit,w_str
end,
},

[taskConditionType.eTaskFinish]={
events={taskConditionEventType.eTaskChange},
check=function(cond)
local fit=true
local w_str=nil
local taskid=cond[2]
if not taskModel:checkTaskFinish(taskid)then
fit=false
local cfg=taskModel:getTaskConfig(taskid)
w_str=FMT.fmt('完成任务<{0}>',cfg.name)
end
return fit,w_str
end,
},

[taskConditionType.eZheXianLing]={
events={taskConditionEventType.eZheXianLingChange},
check=function(cond)
local fit=true
local w_str=nil
local book_id=cond[2]
local index=cond[3]
if index and index>0 then
local chapterid=zheXianLingConfig.getChapterId(book_id,index)
fit=zheXianLingModel:isRewardChapter(chapterid)
else
fit=zheXianLingModel:isRewardBook(book_id)
end
if not fit then
local bookStr=mathHelper.numberToChinese(book_id)
if index and index>0 then
local chapterStr=mathHelper.numberToChinese(index)
w_str=FMT.fmt('完成谪仙令{0}卷{1}章',bookStr,chapterStr)
else
w_str=FMT.fmt('完成谪仙令{0}卷',bookStr)
end
end
return fit,w_str
end,
},

[taskConditionType.eWorldBlockUnlock]={
events={taskConditionEventType.eWorldBlockUnlockChange},
check=function(cond)
local w_str=nil
local worldid=cond[2]
local blockid=cond[3]
local fit=worldBlockModel:checkBlockState(worldid,blockid,eWorldBlockState.OPEN)
if not fit then
local name=cfgHelper.get3(cfg_worldblockconfig_get,worldid,blockid,"name")
w_str=FMT.fmt('开启大世界{0}',name)
end
return fit,w_str
end,
},

[taskConditionType.eHasDiZiID]={
events={taskConditionEventType.eGetDiZiID},
check=function(cond)
local w_str=nil
local dzid=cond[2]
local num=UIDiscipleModel:getSameIdDiscipleCount(dzid)
local fit=num>0
if not fit then
local name=cfgHelper.get2(cfg_discipleconfig_get,dzid,"name")
w_str=FMT.fmt('拥有弟子{0}',name or'')
end
return fit,w_str
end,
},

[taskConditionType.eTaskLineCooldowm]={
events={taskConditionEventType.eTaskLineCooldowmChange},
check=function(cond)
local w_str=nil
local taskline=cond[2]
local time=cond[3]
local cur=taskModel:getTaskLineCoolDown(taskline)
local fit=(cur==nil)or(gameUtilityModel.getServerShortTime()-cur>=time)
if not fit then
w_str=cond[4]or'冷却时间未到'
end
return fit,w_str
end,
},

[taskConditionType.eSystemOpen]={
events={taskConditionEventType.eSystemOpen},
check=function(cond)
local w_str=nil
local sysid=cond[2]
local fit=systemModel.isOpen(sysid)
if not fit then
w_str=systemModel.getOpenTips(sysid)
end
return fit,w_str
end,
},

[taskConditionType.eSeverOpenDay]={
events={taskConditionEventType.eNewDay},
check=function(cond)
local w_str=nil
local day=cond[2]
local day_=timeHelper.getServerOpenDay()
local fit=day_>=day
if not fit then
w_str=FMT.fmt('开服天数达到{0}天',day)
end
return fit,w_str
end,
},

[taskConditionType.eSeverOpenDay2]={
events={taskConditionEventType.eNewDay5am},
check=function(cond)
local w_str=nil
local day=cond[2]
local day_=timeHelper.getServerOpenDay()
local fit=false
if day_>day then
fit=true
elseif day_==day then
local cur=gameUtilityModel.getServerLongTime()
local H=timeHelper.dateServerStamp('%H',cur)
if tonumber(H)>=5 then
fit=true
end
end
if not fit then
w_str=FMT.fmt('开服第{0}天5点开启',day)
end
return fit,w_str
end,
},

[taskConditionType.eBuilding]={
events={taskConditionEventType.eBuildingDone},
check=function(cond)
local w_str=nil
local build_id=cond[2]
local data,mountid,buildid=zongmenControl:getBuilding({type=build_id})
local fit=data~=nil
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
if not fit then
w_str=FMT.fmt('尚未建造{0}',cfg.name)
end
return fit,w_str
end,
},

[taskConditionType.eHasDiZiJJLevel]={
events={taskConditionEventType.eDiZiJJLevelChange,taskConditionEventType.eDiZiAdd,taskConditionEventType.eDiZiRemove},
check=function(cond)
local w_str=nil
local jjlv=cond[2]
local fit=UIDiscipleModel:checkHasDiZi_jingjie(jjlv)
if not fit then
local floorname=UIDiscipleModel:getJJName(jjlv)or''
w_str=FMT.fmt('拥有{0}期弟子',floorname)
end
return fit,w_str
end,
},

[taskConditionType.eBuildingLevel]={
events={taskConditionEventType.eBuildLevelChange},
check=function(cond)
local w_str=nil
local build_id=cond[2]
local build_lv=cond[3]
local fit=zongmenModel:hasBuildLevel(build_id,build_lv)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
if not fit then
w_str=FMT.fmt('尚未拥有{0}级{1}',build_lv,cfg.name)
end
return fit,w_str
end,
},

[taskConditionType.eShiLianTa]={
events={taskConditionEventType.eShiLianTa},
check=function(cond)
local fit=true
local w_str=nil
local num=cond[2]
local lv=shiLianTaModel:getClearLayer()
if lv<num then
fit=false
w_str=FMT.fmt('锁妖塔通关到{0}层',num)
end
return fit,w_str
end,
},

[taskConditionType.eJiuYouTaOpen]={
events={taskConditionEventType.eJiuYouTaOpen},
check=function(cond)
local fit=true
local w_str=nil

local open=JiuYouTaModel:isJiuYouTaUnlock()
if not open then
fit=false
w_str='九幽塔未开启'
end
return fit,w_str
end,
},

[taskConditionType.eZongMenLevelMax]={
events={},
check=function(cond)
local fit=true
local w_str=nil
local num=cond[2]
local limitLv=zongmenModel:getZongMenLimitLv()
if limitLv<num then
fit=false
w_str=FMT.fmt('宗门等级上限达到{0}级',num)
end
return fit,w_str
end,
},
}

function taskModel:checkConditions(condlist)
local fit=true
local w_str=nil
if condlist then
for i,v in ipairs(condlist)do
local ty=v[1]
local func=taskConditionFunc[ty]
if func then
fit,w_str=func.check(v)
if not fit then
break
end
end
end
end
return fit,w_str
end

function taskModel:hasConditionEvent(condlist,eventType)
if condlist then
for i,v in ipairs(condlist)do
local ty=v[1]
local func=taskConditionFunc[ty]
if func then
for i2,v2 in ipairs(func.events)do
if v2==eventType then
return true
end
end
end
end
end
return false
end

function taskModel:disposeConditionsEventInit()
local list={}
local tasklist=taskModel:getTaskList()
for i,v in ipairs(tasklist)do
if v.taskstate==taskModel.taskAcceptState then
local taskcfg=v.cfg
local changeType=0
if taskcfg.show_conditions~=nil then
changeType=mathHelper.setbit(changeType,0)
end
if taskcfg.conditions~=nil then
changeType=mathHelper.setbit(changeType,1)
end
if changeType>0 then

notifySystem:postNotify(notifyConfig.onTaskCondition,v.taskid,changeType)
table_insert(list,v.taskid)
end
end
end

taskModel:checkRecommandByCondition(list)
end

function taskModel:disposeConditionsEvent(eventType)
local list={}
local tasklist=taskModel:getTaskList()
for i,v in ipairs(tasklist)do
if v.taskstate==taskModel.taskAcceptState then
local taskcfg=v.cfg
local changeType=0
if taskModel:hasConditionEvent(taskcfg.show_conditions,eventType)then
changeType=mathHelper.setbit(changeType,0)
end
if taskModel:hasConditionEvent(taskcfg.conditions,eventType)then
changeType=mathHelper.setbit(changeType,1)
end
if changeType>0 then

notifySystem:postNotify(notifyConfig.onTaskCondition,v.taskid,changeType)
table_insert(list,v.taskid)
end
end
end

taskModel:checkRecommandByCondition(list)

taskModel:refreshNewLineTask()
taskModel:refreshNewNextTask()
end

function taskModel:checkRecommandByCondition(list)
local has=taskModel:hasRecommandTask(list)
if has then

notifySystem:postNotify(notifyConfig.onTaskRecommand)
end
end

function taskModel:hasRecommandTask(list)
for i,v in ipairs(list)do
local cfg=taskModel:getTaskConfig(v)
if taskModel:isRecommendTask(cfg)then
return true
end
end
return false
end


function taskModel:fitAcceptCondition(taskid)
local taskcfg=taskModel:getTaskConfig(taskid)
local fit,w_str=taskModel:checkConditions(taskcfg.conditions)
return fit,w_str
end


function taskModel:fitShowConditon(taskid)
local taskcfg=taskModel:getTaskConfig(taskid)
local fit,w_str=taskModel:checkConditions(taskcfg.show_conditions)
return fit,w_str
end


function taskModel:fitShowConditon_NPC(NPCid)
local NPCConfig=taskModel:getTaskNPCConfig(NPCid)
local fit,w_str=taskModel:checkConditions(NPCConfig.show_conditions)
return fit,w_str
end