






local _MODULENAME="instructionbookModel"


def_table(_MODULENAME)
instructionbookModel.name=_MODULENAME

instructionbookModel.mainLock={}

instructionbookModel.subLock={}

instructionbookModel.lookup={}

instructionbookModel.eConditionType={
eZongmenLv=1,
eSystemOpen=2,
}

instructionbookModel.eContentType={
eTextWithBullets=1,
eTextWithoutBullets=2,
eImage=3,
}

local _condition_check={
[instructionbookModel.eConditionType.eZongmenLv]=function(param)
local level=zongmenModel:getLevel()
return level and level>=param or false
end,
[instructionbookModel.eConditionType.eSystemOpen]=function(param)
local open=systemModel.isOpen(param)
return open
end,
}


function instructionbookModel:onAppStart()
local tabCfg=cfg_instructionbookmaintabconfig()
for mainId,mainCfg in ipairs(tabCfg)do
for index,subId in ipairs(mainCfg.list)do
self.lookup[subId]=mainId
end
end
end


function instructionbookModel:onEnterState(isReconnect)

end


function instructionbookModel:onProtocolReq()
self:initData()
end


function instructionbookModel:onLeaveState(isReconnect)

self.mainLock={}
self.subLock={}
end



function instructionbookModel:getLookup(subId)
return self.lookup[subId]
end

function instructionbookModel:getConditionLock(condition)
local list={}
if condition then
for i,v in ipairs(condition)do
local type=v[1]
local param=v[2]
if not _condition_check[type](param)then
list[type]=param
end
end
end
return list
end

function instructionbookModel:isMainTabOpen(mainId)
return next(self.mainLock[mainId])==nil
end

function instructionbookModel:isSubTabOpen(subId)
return next(self.subLock[subId])==nil
end

function instructionbookModel:initData()
local tabCfg=cfg_instructionbookmaintabconfig()
for mainId,mainCfg in ipairs(tabCfg)do
for index,subId in ipairs(mainCfg.list)do
local subCfg=cfgHelper.get1(cfg_instructionbooksubtabconfig_get,subId)
local subLock=self:getConditionLock(subCfg.show)
self.subLock[subId]=subLock
end

local mainLock=self:getConditionLock(mainCfg.show)
self.mainLock[mainId]=mainLock
end
end

function instructionbookModel:getSortList()
local list={}
local tabCfg=cfg_instructionbookmaintabconfig()
for mainId,mainCfg in ipairs(tabCfg)do
if self:isMainTabOpen(mainId)then
local temp={}
for index,subId in ipairs(mainCfg.list)do
if self:isSubTabOpen(subId)then
table.insert(temp,subId)
end
end
table.insert(list,{id=mainId,list=temp})
end
end
if houtaiModel:isOpenGongLue()then
table.insert(list,{id=0,list={},name="【更多攻略】"})
end
return list
end

function instructionbookModel:triggerUnlockEqual(type,param)
for mainId,locks in pairs(self.mainLock)do
local temp=locks[type]
if temp and temp==param then
self.mainLock[type]=nil
end
end

for subId,locks in pairs(self.subLock)do
local temp=locks[type]
if temp and temp==param then
self.subLock[type]=nil
end
end
end

function instructionbookModel:triggerUnlockBigEqual(type,param)
for mainId,locks in pairs(self.mainLock)do
local temp=locks[type]
if temp and temp<=param then
self.mainLock[type]=nil
end
end

for subId,locks in pairs(self.subLock)do
local temp=locks[type]
if temp and temp<=param then
self.subLock[type]=nil
end
end
end

function instructionbookModel:triggerUnlockRefresh(type)
for mainId,locks in pairs(self.mainLock)do
local temp=locks[type]
if temp and _condition_check[type](temp)then
self.mainLock[type]=nil
end
end

for subId,locks in pairs(self.subLock)do
local temp=locks[type]
if temp and _condition_check[type](temp)then
self.subLock[type]=nil
end
end
end