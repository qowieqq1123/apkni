






local _MODULENAME="yandaotaiModel"


def_table(_MODULENAME)
yandaotaiModel.name=_MODULENAME
yandaotaiModel.data={}

local technologyHeight={}
local technologyCurLevelLookup={}
local changecurLevelLookup={}
local technologyIdsLookup
local technologyTreeTypeLookup
local technologyTreeIdLookup
local technologyTabIdxLookup
local technologyAllLevelLookup
local technologyIdByTreeIdLookup
local technologyMaxLevelLookup


function yandaotaiModel:onAppStart()

end


function yandaotaiModel:onEnterState(isReconnect)

end


function yandaotaiModel:onProtocolReq()
yandaotaiModel:initDatas()
end


function yandaotaiModel:onLeaveState(isReconnect)

self.data={}
self.idList={}
self.treeList={}
self.previewList={}
self.addrateDatas={}
self.technologyMaxLevelList={}

technologyHeight={}
technologyCurLevelLookup={}
changecurLevelLookup={}
technologyIdsLookup=nil
technologyTreeTypeLookup=nil
technologyTreeIdLookup=nil
technologyTabIdxLookup=nil
technologyAllLevelLookup=nil
technologyIdByTreeIdLookup=nil
technologyMaxLevelLookup=nil
end

YDT_TREE_TYPE=
{
eChuanCheng=1,
eDaoZang=2,
}


function yandaotaiModel:getTechnologyHeight(treeId)
local height=technologyHeight[treeId]
if height==nil then
local maxY=0
local list=cfgHelper.get2(cfg_technologytreeconfig_get,treeId,"technology_list")
for i,technology_id in ipairs(list)do
local winParams=cfgHelper.get3(cfg_technologyconfig_get,technology_id,1,"winParams")
local posY=winParams[2][2]
if posY>maxY then
maxY=posY
end
end

height=math.max(maxY+356,500)
technologyHeight[treeId]=height
end
return height
end

function yandaotaiModel:initLookup()
technologyTreeIdLookup={}
technologyIdsLookup={}
technologyTabIdxLookup={}
technologyAllLevelLookup={}
local cfgs=cfg_technologytreeconfig()
for treeId,cfg in pairs(cfgs)do
if not technologyTreeIdLookup[cfg.type]then
technologyTreeIdLookup[cfg.type]={}
end
if not technologyTreeIdLookup[cfg.type][cfg.tabIdx]then
technologyTreeIdLookup[cfg.type][cfg.tabIdx]=treeId
end

if not technologyAllLevelLookup[treeId]then
technologyAllLevelLookup[treeId]=0
end

if not technologyIdsLookup[cfg.type]then
technologyIdsLookup[cfg.type]={}
end
if not technologyIdsLookup[cfg.type][cfg.tabIdx]then
technologyIdsLookup[cfg.type][cfg.tabIdx]={}
end
for i,technology_id in ipairs(cfg.technology_list)do
table.insert(technologyIdsLookup[cfg.type][cfg.tabIdx],technology_id)

local configs=cfgHelper.get1(cfg_technologyconfig_get,technology_id)
technologyAllLevelLookup[treeId]=technologyAllLevelLookup[treeId]+#configs
end


if not technologyTabIdxLookup[cfg.type]then
technologyTabIdxLookup[cfg.type]={}
end
table.insert(technologyTabIdxLookup[cfg.type],cfg)
end

for i,v in ipairs(technologyTabIdxLookup)do
table.sort(technologyTabIdxLookup[i],function(a,b)
return a.tabIdx<b.tabIdx
end)
end

technologyMaxLevelLookup={}
local confs=cfg_technologyconfig()
for id,list in ipairs(confs)do
for level,cfg in ipairs(list)do
if cfg.unlock_condition then
for i,v in ipairs(cfg.unlock_condition)do
if v[1]==2 and v[2]==102 then
if not technologyMaxLevelLookup[id]then
technologyMaxLevelLookup[id]={}
end
technologyMaxLevelLookup[id][v[3]]=level
break
end
end
end
end
end
end

function yandaotaiModel:updateTechnologyMaxLevelList()
self.technologyMaxLevelList={}
local bdLevel=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYanDaoTai)
local bd_level=bdLevel or 1
for id,list in pairs(technologyMaxLevelLookup)do
local minLv
for bdlv,lv in pairs(list)do
if not minLv or minLv>lv then
minLv=lv
end
end
if list[bd_level]then
self.technologyMaxLevelList[id]=list[bd_level]
else
self.technologyMaxLevelList[id]=minLv-1
end
end
end

function yandaotaiModel:getTreeIdByTypeAndTabIdx(treeType,tabIdx)
treeType=treeType or YDT_TREE_TYPE.eChuanCheng
tabIdx=tabIdx or 1
if technologyTreeIdLookup==nil then
self:initLookup()
end
return technologyTreeIdLookup[treeType][tabIdx]
end

function yandaotaiModel:getTechnologyTabList(treeType)
treeType=treeType or YDT_TREE_TYPE.eChuanCheng
if technologyTabIdxLookup==nil then
self:initLookup()
end
return technologyTabIdxLookup[treeType]
end

function yandaotaiModel:getTechnologyIds(treeType,tabIdx)
treeType=treeType or YDT_TREE_TYPE.eChuanCheng
tabIdx=tabIdx or 1
if technologyIdsLookup==nil then
self:initLookup()
end
return technologyIdsLookup[treeType][tabIdx]
end

function yandaotaiModel:getTechnologyAllLevel(treeId)
treeId=treeId or 1
if technologyAllLevelLookup==nil then
self:initLookup()
end
return technologyAllLevelLookup[treeId]
end

function yandaotaiModel:getTechnologyIsTreeId(_treeId,technology_id)
if technologyIdByTreeIdLookup==nil then
technologyIdByTreeIdLookup={}
local cfgs=cfg_technologytreeconfig()
for treeId,cfg in pairs(cfgs)do
if not technologyIdByTreeIdLookup[treeId]then
technologyIdByTreeIdLookup[treeId]={}
end
for i,id in ipairs(cfg.technology_list)do
technologyIdByTreeIdLookup[treeId][id]=true
end
end
end
return technologyIdByTreeIdLookup[_treeId][technology_id]==true
end

function yandaotaiModel:getTechnologyTreeId(technology_id)
if technologyTreeTypeLookup==nil then
technologyTreeTypeLookup={}
local cfgs=cfg_technologytreeconfig()
for treeId,cfg in pairs(cfgs)do
for i,id in ipairs(cfg.technology_list)do
technologyTreeTypeLookup[id]=cfg.id
end
end
end
return technologyTreeTypeLookup[technology_id]or 1
end

function yandaotaiModel:getTechnologyCurLevel(treeId)
local allLevel=technologyCurLevelLookup[treeId]
if not allLevel or changecurLevelLookup[treeId]then
allLevel=0
changecurLevelLookup[treeId]=nil
local cfg=cfgHelper.get1(cfg_technologytreeconfig_get,treeId)
for i,id in ipairs(cfg.technology_list)do
local level=yandaotaiModel:getTechnologyListLevel(id)or 0
allLevel=allLevel+level
end
technologyCurLevelLookup[treeId]=allLevel
end
return allLevel
end



function yandaotaiModel:initDatas()
self.idList={}
self.treeList={}
self.previewList={}
local cfgs=cfg_technologytreeconfig()
for treeId,cfg in pairs(cfgs)do
self.idList[treeId]=self.idList[treeId]or{}
self.treeList[treeId]=self.treeList[treeId]or{}
self.previewList[treeId]=self.previewList[treeId]or{}
local config=cfg_technologybonusconfig()
local bonusname=cfg.bonusname

for k,v in ipairs(config)do
if v[bonusname]then
local list
for i,j in pairs(v[bonusname])do
local level=yandaotaiModel:getTechnologyListLevel(j)
if level then
if not list then list={}end
table.insert(list,j)
end

if not self.treeList[treeId][k]then self.treeList[treeId][k]={}end
local id=tostring(j)
self.idList[treeId][id]=k
table.insert(self.treeList[treeId][k],j)
end
if list then
local tempList={}
tempList.name=v.name
tempList.list=list
table.insert(self.previewList[treeId],tempList)
end

end
end
end



end

function yandaotaiModel:getTreeId(id,treeId)
treeId=treeId or 1
local idStr=tostring(id)
return self.idList[treeId][idStr]
end

function yandaotaiModel:getTreeList(id,treeId)
treeId=treeId or 1
return self.treeList[treeId][id]
end

function yandaotaiModel:getPreviewList(treeId)
treeId=treeId or 1
return self.previewList[treeId]
end

function yandaotaiModel:isMaxLevel(id)
local configs=cfgHelper.get1(cfg_technologyconfig_get,id)
local limitLevel=yandaotaiModel:getMinLimitLevel(id)
local maxLevel=#configs
local level=yandaotaiModel:getTechnologyListLevel(id)or 0
return level,limitLevel,maxLevel,level>=maxLevel
end

function yandaotaiModel:getMinLimitLevel(id)
local cfg=cfg_technologybaseconfig()
local bdLevel=zongmenModel:getBuildingLevel(mapIdType.fort,SLG_SYSTEM_TYPE.eYanDaoTai)
local bd_level=bdLevel or 1
local limitLevel=cfg[bd_level].uplimit
local maxLimitLevel=self.technologyMaxLevelList[id]
if maxLimitLevel~=nil then
limitLevel=math.min(maxLimitLevel,limitLevel)
end
return limitLevel
end

function yandaotaiModel:isTreeIdMaxLevel(treeId)
local cfg=cfgHelper.get1(cfg_technologytreeconfig_get,treeId)
local ids=yandaotaiModel:getTechnologyIds(cfg.type,cfg.tabIdx)

for i,id in ipairs(ids)do
local time=yandaotaiModel:getStudyListTime(id)

if time then
return false
end
local configs=cfgHelper.get1(cfg_technologyconfig_get,id)
local maxLevel=#configs
local level=yandaotaiModel:getTechnologyListLevel(id)or 0

if level<maxLevel then
return false
end
end
return true
end


function yandaotaiModel:initTechnologyListDatas(len,technologyList)
if not self.data.technologyList then self.data.technologyList={}end

if len>0 then
for k,v in ipairs(technologyList)do
local id=tostring(v.param_1)
self.data.technologyList[id]=v.param_2
end
end
end


function yandaotaiModel:addTechnologyListLevel(id)
local _id=id
id=tostring(id)
local level=self.data.technologyList[id]
if level then
level=level+1
else
level=1
yandaotaiModel:initDatas()
end
self.data.technologyList[id]=level

local list={}
for k,v in pairs(self.data.technologyList)do
local temp={}
local curId=tonumber(k)
temp.param_1=curId
temp.param_2=v
table.insert(list,temp)
end

if#list>0 then
yandaotaiModel:initTechnologyAddrateDatas(list)
end

local treeId=yandaotaiModel:getTechnologyTreeId(_id)
changecurLevelLookup[treeId]=true


notifySystem:postNotify(notifyConfig.technologyUpLevelFinish,id,level)
end


function yandaotaiModel:setTechnologyListLevel(id,level)
local idstr=tostring(id)
self.data.technologyList[idstr]=level

local treeId=yandaotaiModel:getTechnologyTreeId(id)
changecurLevelLookup[treeId]=true
end


function yandaotaiModel:getTechnologyListLevel(id)
local idstr=tostring(id)

if self.data.technologyList and self.data.technologyList[idstr]then
return self.data.technologyList[idstr]
else
return nil
end
end

function yandaotaiModel:getTechnologyList()
if self.data and self.data.technologyList then
return self.data.technologyList
else
return nil
end
end


function yandaotaiModel:initStudyListDatas(len,studyList)
if not self.data.studyList then self.data.studyList={}end

if len>0 then




local data=studyList[1]
self.data.studyList.id=data.param_1
self.data.studyList.starTime=data.param_2
end
end


function yandaotaiModel:accelerateStudyTime(time)
self.data.studyList.starTime=self.data.studyList.starTime-time

end

function yandaotaiModel:cancelStudy()
self.data.studyList.id=nil
self.data.studyList.starTime=nil
end


function yandaotaiModel:setStudyListTime(id,value)
if not self.data.studyList then self.data.studyList={}end

self.data.studyList.id=id
self.data.studyList.starTime=value
end


function yandaotaiModel:getStudyListTime(id)
if self.data.studyList and self.data.studyList.id==id then
return self.data.studyList.starTime
end
return nil
end

function yandaotaiModel:getStudyList()
return self.data.studyList
end


function yandaotaiModel:getTypeAttrDesc(list,flag)
local id=list[1]
local desc=''
local add='+'
local color=flag and'000000'or'229f00'

if id==1 then
local text
local value
local idList=list[2]



if idList then
for k,v in pairs(idList)do
local buildID=k
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildID)
local buildName=cfg.name
if not text then

text=buildName
value=string.format('%s%%',v)
else
local str=string.format('%s%%',v)
text=string.format('%s、%s',text,buildName)
value=string.format('%s、%s',value,str)
end
end
desc=string.format('%s收益加成：<color=#%s>%s%s</color>',text,color,add,value)
end

return desc
elseif id==2 then
local mo=list[2][1]
local xian=list[2][2]

if mo>0 and xian==0 then

desc=string.format('魔气收益加成：<color=#%s>%s%s%%</color>',color,add,mo)
elseif mo==0 and xian>0 then

desc=string.format('仙气收益加成：<color=#%s>%s%s%%</color>',color,add,xian)

elseif mo>0 and xian>0 and mo==xian then
desc=string.format('魔气、仙气收益加成：<color=#%s>%s%s%%</color>',color,add,xian)
elseif mo>0 and xian>0 then
desc=string.format('提升拘天仪仙气%s%%、魔气%s%%的生产收益',xian,mo)
end

return desc
elseif id==3 then
desc=string.format('伤兵容量加成：<color=#%s>%s%s</color>',color,add,list[2][1])
return desc
elseif id==4 then
desc=string.format('训练上限加成：<color=#%s>%s%s</color>',color,add,list[2][1])
return desc
elseif id==5 then
local text
local attrList=list[2]

for k,v in pairs(attrList)do
local str
local attrType=v[1]
local attrValue=v[2]

local attrName=helper.getAttributeName(attrType)
local value=helper.getAttributeStrEx(attrType,attrValue)








str=string.format('%s加成：<color=#%s>%s%s</color>',attrName,color,add,value)
if attrType==138 then
str=string.format('携带修士上限：<color=#%s>%s%s</color>',color,add,value)
end
if not text then
text=str
else
text=string.format('%s、%s',text,str)
end
end
desc=text
return desc
elseif id==6 then
desc=string.format('云舟建造数: <color=#%s>%s%s</color>',color,add,list[2])
return desc
elseif id==7 then
local text
local xmType=list[2]
local attrList=list[3]

if attrList then
for k,v in pairs(attrList)do
local attrId=v[1]
local attrValue=v[2]
local attrCfg=cfgHelper.get1(cfg_attributesconfig_get,attrId)

if xmType==1 then
text=string.format('仙修%s加成：<color=#%s>%s%s</color>',attrCfg.attrname,color,add,helper.getAttributeStrEx(attrId,attrValue,2))
elseif xmType==2 then
text=string.format('魔修%s加成：<color=#%s>%s%s</color>',attrCfg.attrname,color,add,helper.getAttributeStrEx(attrId,attrValue,2))
else
text=string.format('%s：<color=#%s>%s%s</color>',attrCfg.attrname,color,add,helper.getAttributeStrEx(attrId,attrValue,2))
end
if desc==''then
desc=text
else
desc=string.format('%s\n%s',desc,text)
end
end
end

return desc
end
end


function yandaotaiModel:checkStudyisFinishTime(id,time)
local starTime=self:getStudyListTime(id)
if starTime then
local curTime=timeHelper.getServerShortTime()
local passTime=curTime-starTime
local allTime=tonumber(time)

if passTime>allTime then
return true,passTime,0,starTime
else
local cd=allTime-passTime
return false,passTime,cd,starTime
end
else
return false
end
end


function yandaotaiModel:checkIsEnoughCost(cfg)
local cost=cfg
for k,v in ipairs(cost)do
local itemId=v[1]
local needNum=v[2]
local haveNum=itemsModel.getCount(itemId)

if haveNum<needNum then
return false,itemId
end
end
return true
end


function yandaotaiModel:checkIsEnoughUpLevel(cfg)
if cfg then
for k,v in ipairs(cfg)do
if v[1]==1 then
local level=yandaotaiModel:getTechnologyListLevel(v[2])or 0
if level<v[3]then
local config=cfgHelper.get2(cfg_technologyconfig_get,v[2],1)
local name=config.technology_name
local text=string.format("%s科技等级需达到%s级",name,v[3])
return false,text
end
elseif v[1]==2 then
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.fort,v[2])
local level=0
if bdDatas[1]and bdDatas[1].level then
level=bdDatas[1].level
end

if not level or level<v[3]then
local config=cfgHelper.get1(cfg_monijybuildconfig_get,v[2])
local name=config.name
local text=string.format("%s等级需达到%s级",name,v[3])
return false,text
end
end
end
end

return true
end


function yandaotaiModel:initTechnologyAddrateDatas(technologyList,flag)
self.addrateDatas=self:getTechnologyAddrateDatas(technologyList,flag)
end

function yandaotaiModel:getTechnologyAddrateDatas(technologyList,flag)
local cfg=cfg_technologyconfig()
local addrateDatas=
{
[1]={},
[2]={0,0},
[3]={},
[4]={},
[5]={},
[6]=0,
[7]={},
}

if technologyList then
for k,v in ipairs(technologyList)do
if v then
local id=v.param_1
local level=v.param_2
local config=cfg[id][level]
local effect=config.study_effect

if effect and next(effect)then
for i,j in ipairs(effect)do
local effectType=j[1]

if effectType==1 then
local list=addrateDatas[effectType]
for key,value in pairs(j[2])do
local strKey=tostring(key)
local val=list[strKey]or 0
list[strKey]=val+value
end
elseif effectType==2 then
addrateDatas[effectType][1]=addrateDatas[effectType][1]+j[2][1]
addrateDatas[effectType][2]=addrateDatas[effectType][2]+j[2][2]

elseif effectType==3 then
local val=addrateDatas[effectType][1]or 0
addrateDatas[effectType]={val+j[2][1]}
elseif effectType==4 then
local val=addrateDatas[effectType][1]or 0
addrateDatas[effectType]={val+j[2][1]}
elseif effectType==5 then
local list=j[2]

for k,v in ipairs(list)do
local key=v[1]
local absolute=v[2]
local precentage=v[3]

local val=addrateDatas[effectType][key]or 0
addrateDatas[effectType][key]=val+absolute
end
elseif effectType==6 then
addrateDatas[effectType]=addrateDatas[effectType]+j[2]
elseif effectType==7 then
local xmType=j[2]
local list=j[3]

if not addrateDatas[effectType][xmType]then
addrateDatas[effectType][xmType]={}
end
for k,v in ipairs(list)do
local attrId=v[1]
local attrValue=v[2]
local val=addrateDatas[effectType][xmType][attrId]or 0
addrateDatas[effectType][xmType][attrId]=val+attrValue
end
end
end
end
end
end
end
return addrateDatas
end










function yandaotaiModel:getAddrateDatasByEffectId(effectType)
if self.addrateDatas then
return self.addrateDatas[effectType]
else
return effectType==6 and 0 or{}
end
end


function yandaotaiModel:getFrotYanDaoTaiFightValue()
local fortfight=0
local cfgs=cfg_technologytreeconfig()
for treeId,cfg in pairs(cfgs)do
if self:getIsOpenTree(treeId)then
local list=cfg.technology_list
for i,technology_id in ipairs(list)do
local level=yandaotaiModel:getTechnologyListLevel(technology_id)
if level then
local curCfg=cfgHelper.get2(cfg_technologyconfig_get,technology_id,level)
fortfight=fortfight+(curCfg.fortfight or 0)
end
end
end
end
return fortfight
end


function yandaotaiModel:getIsOpenTree(treeId,isWarning)
local open_cdn=cfgHelper.get2(cfg_technologytreeconfig_get,treeId,"open_cdn")
if not open_cdn then
return true
end

return self:getIsUnlock(open_cdn,isWarning)
end


function yandaotaiModel:getIsShowTree(treeId)
local show_cdn=cfgHelper.get2(cfg_technologytreeconfig_get,treeId,"show_cdn")
if not show_cdn then
return true
end

return self:getIsUnlock(show_cdn)
end

function yandaotaiModel:getIsUnlock(conf,isWarning)
for i,v in ipairs(conf)do
local type=v[1]
if type==1 then
if not self:isTreeIdMaxLevel(v[2])then
if isWarning then
local name=cfgHelper.get2(cfg_technologytreeconfig_get,v[2],"name")
UIManager.error(FMT.fmt("{0}科技全部满级后开启",name))
end
return false
end
elseif type==2 then
local zmLevel=zongmenModel:getLevel()or 0
if zmLevel<v[2]then
if isWarning then
UIManager.error(FMT.fmt("宗门达到{0}级后开启",v[2]))
end
return false
end
elseif type==3 then
local level=yandaotaiModel:getTechnologyListLevel(v[2])or 0
if level<v[3]then
if isWarning then
local config=cfgHelper.get2(cfg_technologyconfig_get,v[2],1)
local name=config.technology_name
local text=string.format("%s科技等级需达到%s级",name,v[3])
UIManager.error(text)
end
return false
end
elseif type==4 then
local pfid=loginModel:getPfid()or 0
local pfidList=v[2]
if not pfidList[pfid]then
if isWarning then
UIManager.error("当前平台未开启")
end
return false
end
elseif type==5 then
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.fort,v[2])
local level=0
if bdDatas[1]and bdDatas[1].level then
level=bdDatas[1].level
end
if not level or level<v[3]then
if isWarning then
local config=cfgHelper.get1(cfg_monijybuildconfig_get,v[2])
local name=config.name
local text=string.format("%s等级需达到%s级",name,v[3])
UIManager.error(text)
end
return false
end
end
end

return true
end


function yandaotaiModel:getTreeTypeReddot(treeType)
local list=yandaotaiModel:getTechnologyTabList(treeType)
for i,cfg in ipairs(list)do
if self:getTreeIdReddot(cfg.id)then
return true
end
end
return false
end


function yandaotaiModel:getTreeIdReddot(treeId)
if not yandaotaiModel:getIsOpenTree(treeId)then
return false
end
local studyList=yandaotaiModel:getStudyList()
local isHasYJ=studyList and studyList.id~=nil
if isHasYJ and not yandaotaiModel:getTechnologyIsTreeId(treeId,studyList.id)then
return false
end

local cfg=cfgHelper.get1(cfg_technologytreeconfig_get,treeId)
local list=cfg.technology_list
for i,technology_id in ipairs(list)do
if self:getTechnologyIdReddot(technology_id)then
return true
end
end
return false
end


function yandaotaiModel:getTechnologyIdReddot(id)
local studyList=yandaotaiModel:getStudyList()
local isHasYJ=studyList and studyList.id~=nil
if isHasYJ and studyList.id~=id then
return false
end
local buildLevel=yandaotaiController:getBuildLevel()
local curMaxLevel=cfgHelper.get2(cfg_technologybaseconfig_get,buildLevel,'uplimit')
local cfg
local cfgs=cfgHelper.get1(cfg_technologyconfig_get,id)
local maxLevel=#cfgs
local level=yandaotaiModel:getTechnologyListLevel(id)
if not level then
cfg=cfgHelper.get2(cfg_technologyconfig_get,id,1)
else
if level+1<=maxLevel then
cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level+1)
else
cfg=cfgHelper.get2(cfg_technologyconfig_get,id,level)
end
end
local maxlv
if maxLevel>curMaxLevel then
maxlv=curMaxLevel
else
maxlv=maxLevel
end

local isUnlock=true
local flag=yandaotaiModel:checkIsEnoughUpLevel(cfg.unlock_condition)
if not level and not flag then isUnlock=false end
if isUnlock then
if not level then level=0 end
local value2=DianFengLevelModel:getDFXianBaoBuildPercent(3)
local study_time=yandaotaiController.getchangeSpeed(cfg.study_time,value2)
local isComplete=yandaotaiModel:checkStudyisFinishTime(id,study_time)
if isComplete then
return true
end
local flag2=yandaotaiModel:checkIsEnoughCost(cfg.study_cost)and level<maxlv
if not isHasYJ and flag2 then
return true
end
end
return false
end


function yandaotaiModel:getYanDaoTaiSaveTreeId()
if not self.oldTreeId then
self.oldTreeId=userActorSetting.get("YanDaoTaiSaveTreeId",1)
end
return self.oldTreeId
end

function yandaotaiModel:setYanDaoTaiSaveTreeId(treeId)
if self.oldTreeId~=treeId then
self.oldTreeId=treeId
userActorSetting.set("YanDaoTaiSaveTreeId",treeId)
userActorSetting.flush()
end
end