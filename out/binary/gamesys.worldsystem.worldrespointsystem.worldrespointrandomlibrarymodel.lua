






local _MODULENAME="worldResPointRandomLibraryModel"




def_table(_MODULENAME)
worldResPointRandomLibraryModel.name=_MODULENAME








local templateLibrary={}




local randomLibrary={}

local refreshTime={}

function worldResPointRandomLibraryModel:onAppStart()
self:initTemplateLibrary()
local ruleCfg=cfgHelper.get1(cfg_worldresruleconfig_get,1)
self.freshInterval=ruleCfg.freshInterval
self.maxnum=ruleCfg.maxnum
self.minnum=ruleCfg.minnum
self.eachnum=ruleCfg.eachnum
end


function worldResPointRandomLibraryModel:onEnterState()

end


function worldResPointRandomLibraryModel:onLeaveState()

refreshTime={}
randomLibrary={}
end


function worldResPointRandomLibraryModel:onServerDataInitFinish()

end



function worldResPointRandomLibraryModel:getTemplateLibrary()
return templateLibrary
end


function worldResPointRandomLibraryModel:initTemplateLibrary()
local list={}
local cfg=cfg_worldresrandomweightconfig()
for i,v in pairs(cfg)do
local total=0
local info={}
for j,w in ipairs(v.weight)do
total=total+w[2]
table.insert(info,{w[1],total})
end
list[i]=info
end
templateLibrary=list
end

function worldResPointRandomLibraryModel:initExtractLibrary()
randomLibrary={}
local cfg=cfg_worldblockconfig()
for world,worldCfg in pairs(cfg)do
local temp={}
for block,blockCfg in pairs(worldCfg)do
if worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)then
local extractCfg=cfgHelper.get2(cfg_worldresrandompointconfig_get,world,block)
if extractCfg then
temp=table.concatTable(temp,extractCfg.random)
end
end
end
randomLibrary[world]=temp
end

end

function worldResPointRandomLibraryModel:addRandomLibrary(world,block)
local extractCfg=cfgHelper.get2(cfg_worldresrandompointconfig_get,world,block)
local temp=randomLibrary[world]or{}
if extractCfg then
temp=table.concatTable(temp,extractCfg.random)
end
randomLibrary[world]=temp
end

function worldResPointRandomLibraryModel:checkRandomLibrary(world)
return#randomLibrary[world]>0
end




function worldResPointRandomLibraryModel:randomTemplateLibrary(libraryID)
local library=templateLibrary[libraryID]
local maxWeight=library[#library][2]
local value=math.random(maxWeight)
for i,v in ipairs(library)do
if value<=v[2]then
return v[1]
end
end
loggerUtil.logErrFMT("资源点抽取模板数据失败，信息：{0},{1},{2}",libraryID,maxWeight,value)
end



function worldResPointRandomLibraryModel:extractRandomRefresh()

local data={}
for i,v in pairs(randomLibrary)do
if self:checkRefreshTime(i)then
data[i]=self:extractWorldRandomRefresh(i)
else

end
end
return data
end




function worldResPointRandomLibraryModel:extractWorldRandomRefresh(world)
local library=randomLibrary[world]
if#library>0 then
local templates={}
local check,list=worldPositionLibrary:extract(library,self.eachnum,false)
local num=#list
local randomCnt,fixCnt=worldResPointDataModel:countWorldData(world)
if fixCnt<=0 and randomCnt<=self.minnum then
num=math.min(num,self.maxnum-randomCnt)
end

for i=1,num do
local libId=list[i].library
local libCfg=cfgHelper.get1(cfg_worldpositionlibraryconfig_get,libId)
local templdate=self:randomTemplateLibrary(world)
local block=libCfg.blockId

table.insert(templates,{templdate,block})
end
return templates
end
end



function worldResPointRandomLibraryModel:getRefreshTime(world)
return refreshTime[world]
end


function worldResPointRandomLibraryModel:setRefreshTime(world,last)
refreshTime[world]=last or timeHelper.getTodayZeroStamp()
end



function worldResPointRandomLibraryModel:checkRefreshTime(world)
return(timeHelper.getTodayZeroStamp()-(self:getRefreshTime(world)or 0))>=86400*self.freshInterval
end


function worldResPointRandomLibraryModel:clearRefreshTimer(world)
refreshTime[world]=nil
end
