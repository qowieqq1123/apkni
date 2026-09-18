function tiandaoshuModel:checkCorrectAllVoc()
local vocList={}
local stageList={}
local fruitList={}
local config=tiandaoshuConfig:getConfig(voc)
for voc,cfg in pairs(config)do
if self:needCorrectVoc(voc)then
local sList,fList=self:checkCorrectVocStage(voc)
table.concatTableX(stageList,sList)
table.concatTableX(fruitList,fList)
table.insert(vocList,voc)
end
end
return vocList,stageList,fruitList
end

function tiandaoshuModel:checkCorrectVocStage(voc)
local config=tiandaoshuConfig:getConfig(voc)
local vocData=tiandaoshuModel:getVocData(voc)
local count=#vocData.list
local stageList={}
local fruitList={}
for stage=1,count do
local fList=self:checkCorrectStageFruit(voc,stage)
fruitList=table.concatTableX(fruitList,fList)
end
for stage=count+1,vocData.max do
local conditions=config.unlock[stage]
if not conditions then
table.insert(stageList,{voc,stage})
else
break
end
end
return stageList,fruitList
end

function tiandaoshuModel:checkCorrectStageFruit(voc,stage)
local list={}
local stageConfig=tiandaoshuConfig:getStageConfig(voc,stage)
for fruit,fruitCfg in pairs(stageConfig)do
if self:needCorrectFruit(voc,stage,fruit)then
table.insert(list,{voc,stage,fruit})
end
end
return list
end

function tiandaoshuModel:needCorrectVoc(voc)
local vocCheck=UIDiscipleModel:getDiscipleJobCount(voc)>0
local vocActive=tiandaoshuModel:isVocActive(voc)
return vocCheck and not vocActive
end

function tiandaoshuModel:needCorrectStage(voc,stage)
local vocConfig=tiandaoshuConfig:getConfig(voc)
local conditions=vocConfig.unlock[stage]
local stageActive=tiandaoshuModel:isStageActive(voc,stage)
local stageCheck=self:checkConditions(voc,conditions)
return stageCheck and not stageActive
end

function tiandaoshuModel:needCorrectFruit(voc,stage,fruit)
local fruitConfig=tiandaoshuConfig:getFruitConfig(voc,stage,fruit)
local conditions=fruitConfig.unlock
local fruitActive=tiandaoshuModel:isFruitActive(voc,stage,fruit)
local fruitCheck=self:checkConditions(voc,conditions)
return fruitCheck and not fruitActive
end

function tiandaoshuModel:findVocDefaultStages(voc,startStage)
local conditions=tiandaoshuConfig:getConfig(voc,"unlock")
local vocConfig=tiandaoshuConfig:getVocConfig(voc)
local stageList={}
local start=startStage or 1
for stage=start,#vocConfig do
local condition=conditions[stage]
if condition==nil or#condition<=0 then
table.insert(stageList,stage)
else
break
end
end
return stageList
end

function tiandaoshuModel:findStageDefaultFruits(voc,stage)
local stageConfig=tiandaoshuConfig:getStageConfig(voc,stage)
local actives={}
local unactives={}
for fruitId,fruitCfg in ipairs(stageConfig)do
if self:checkConditions(voc,fruitCfg.unlock)then
table.insert(actives,{voc,stage,fruitId})
else
table.insert(unactives,{voc,stage,fruitId})
end
end
return actives,unactives
end

function tiandaoshuModel:checkAllFruitActive(conditionType)
local temp={}
for voc,vocData in pairs(self.data)do
for stage,stageData in pairs(vocData.list)do
local stageCfg=tiandaoshuConfig:getStageConfig(voc,stage)
for fruit,fruitCfg in pairs(stageCfg)do
if not tiandaoshuModel:isFruitActive(voc,stage,fruit)then
if conditionType==nil or tiandaoshuModel:containConditionType(fruitCfg.unlock,conditionType)then
local check=tiandaoshuModel:checkConditions(voc,fruitCfg.unlock)
if check then
table.insert(temp,{voc,stage,fruit})
end
end
end
end
end
end
return temp
end

function tiandaoshuModel:checkVocFruitActive(voc,conditionType)
local temp={}
local vocData=self:getVocData(voc)
for stage,stageData in pairs(vocData.list)do
local stageCfg=tiandaoshuConfig:getStageConfig(voc,stage)
for fruit,fruitCfg in pairs(stageCfg)do
if not tiandaoshuModel:isFruitActive(voc,stage,fruit)then
if conditionType==nil or tiandaoshuModel:containConditionType(fruitCfg.unlock,conditionType)then
local check=tiandaoshuModel:checkConditions(voc,fruitCfg.unlock)
if check then
table.insert(temp,{voc,stage,fruit})
end
end
end
end
end
return temp
end