




chatEmotModel={}

local _data={}

function chatEmotModel.init()
_data={}
_data.itemEmotList={}
_data.emotCostList=nil
end

function chatEmotModel.initPackageEmot(len,array)
_data.packageList={}
_data.packageLookup={}
for i=1,len do
chatEmotModel.addUnlockPackageEmot(array[i])
end
end

function chatEmotModel.addUnlockPackageEmot(info)
local packageId=info.param_1
local endStamp=info.param_2
if _data.packageList==nil then _data.packageList={}end
if _data.packageLookup==nil then _data.packageLookup={}end
local packageLookup=_data.packageLookup
local packageList=_data.packageList
local flag=packageLookup[packageId]
packageLookup[packageId]=endStamp
if not flag then
packageList[#packageList+1]=packageId
end
end

function chatEmotModel.isUnlockPackageEmot(packageId)
if _data.packageLookup and _data.packageLookup[packageId]then
local endStamp=_data.packageLookup[packageId]
if endStamp==-1 then return true end
return timeHelper.getServerShortTime()<=endStamp
end
return false
end

function chatEmotModel.isUnlockItemEmot(tid,idx)
if _data.itemEmotList and _data.itemEmotList[tid]then
return(_data.itemEmotList[tid][idx]or 0)==1
end
return false
end

function chatEmotModel.initDefineEmotDesc(len,array)
_data.defineList={}
_data.defineLookup={}
for i=1,len do
chatEmotModel.addDefineEmotInfo(array[i])
end
chatEmotModel.sortDefineEmot()
end

function chatEmotModel.addDefineEmotInfo(info)
if _data.defineList==nil then _data.defineList={}end
if _data.defineLookup==nil then _data.defineLookup={}end
local lookup=_data.defineLookup
local list=_data.defineList
local guid=info.param_1
if lookup[guid]==nil then
list[#list+1]=info
end
lookup[guid]=info
end


function chatEmotModel.sortDefineEmot()
if _data.defineList and#_data.defineList>1 then
table.sort(_data.defineList,function(a,b)
return a.param_1>b.param_1
end)
end
end

function chatEmotModel.topDefineEmot(guid)
if _data.defineLookup==nil or _data.defineList==nil then return end
local info=_data.defineLookup[guid]
if info==nil then return end
for i,v in ipairs(_data.defineList)do
if v.param_1==guid then
table.remove(_data.defineList,i)
break
end
end
table.insert(_data.defineList,1,info)
end

function chatEmotModel.deleteDefineEmot(len,array)
if _data.defineLookup==nil or _data.defineList==nil then return end
local defineList=_data.defineList
local len=#defineList
local contains=function(guid)
for i,v in ipairs(array)do
if v==guid then
return true
end
end
return false
end
for i=len,1,-1 do
local info=defineList[i]
local guid=info.param_1
if contains(guid)then
table.remove(_data.defineList,i)
_data.defineLookup[guid]=nil
end
end
end

function chatEmotModel.getDefineEmotInfo(guid)
if _data.defineLookup==nil or _data.defineList==nil then return end
for i,v in ipairs(_data.defineList)do
if v.param_1==guid then
return v
end
end
end

function chatEmotModel.getDefineEmotDesc(guid)
if _data.defineLookup==nil then return''end
local info=_data.defineLookup[guid]
if info then
return info.param_3 or''
end
return''
end

function chatEmotModel.getDefineEmotList()
return _data.defineList or{}
end


function chatEmotModel.getDefineEmotNum()
return#chatEmotModel.getDefineEmotList()
end

function chatEmotModel.getDefineIndexByGuid(guid)
local defineList=chatEmotModel.getDefineEmotList()
for i,v in ipairs(defineList)do
if v.param_1==guid then return i end
end
end

function chatEmotModel.initItemEmotEmot(len,array)
_data.itemEmotList={}
for i=1,len do
chatEmotModel.addItemEmotInfo(array[i])
end
end

function chatEmotModel.addItemEmotInfo(info)
local tabid=info.id
local cfgs=cfgHelper.get1(cfg_itemchatemotpackageconfig_get,tabid)

if _data.itemEmotList==nil then _data.itemEmotList={}end
if _data.itemEmotList[tabid]==nil then _data.itemEmotList[tabid]={}end

local list=_data.itemEmotList[tabid]
local clen=#cfgs
for i=1,clen do
local index=Mathf.Ceil(clen/32)
local state=bit.band(bit.rshift(info.list[index],i-1),0x0001)
list[i]={state=state==1,isnew=false}
end
end

function chatEmotModel.setItemEmotState(tabid,tabidx)
if not _data.itemEmotList[tabid]then
_data.itemEmotList[tabid]={}
end
if not _data.itemEmotList[tabid][tabidx]then
_data.itemEmotList[tabid][tabidx]={state=false,isnew=false}
end
_data.itemEmotList[tabid][tabidx].state=true
_data.itemEmotList[tabid][tabidx].isnew=true
end

function chatEmotModel.setItemEmotNew(tabid,tabidx)
_data.itemEmotList[tabid][tabidx].isnew=false
end

function chatEmotModel.getItemEmotState(tabid,tabidx)
local state=false
if not _data.itemEmotList then
return state
end
if not _data.itemEmotList[tabid]then
return state
end
if not _data.itemEmotList[tabid][tabidx]then
return state
end
if _data.itemEmotList[tabid]then
state=_data.itemEmotList[tabid][tabidx].state
end
return state
end

function chatEmotModel.getItemEmotNew(tabid,tabidx)
local state=false
if not _data.itemEmotList[tabid]then
_data.itemEmotList[tabid]={}
end
if not _data.itemEmotList[tabid][tabidx]then
_data.itemEmotList[tabid][tabidx]={state=false,isnew=false}
end
if _data.itemEmotList[tabid]then
state=_data.itemEmotList[tabid][tabidx].isnew
end
return state
end


function chatEmotModel.getChatWinEmotReddot()
local state=false
local acfg=cfg_chatemotinfoconfig()
for k,v in pairs(acfg)do
if v.type==3 then
if chatEmotModel.reddotUnLockEmoById(v.idx)then
state=true
break
end
elseif v.type==4 then
if chatEmotModel.reddotUnLockItemPackageEmot(v.idx)then
state=true
break
end
end
end
return state
end


function chatEmotModel.reddotUnLockEmo()
local state=false
local configs=chatConfig.getPackageEmotConfig()
for _,v in ipairs(configs)do
local id=v.id
if not chatEmotModel.isUnlockPackageEmot(id)and chatConfig.isPackageEmotShow(id)then
if v.unlockitem then
local itemcount=bagModel.getItemCountById(v.unlockitem)
state=state or itemcount>0
if state then
break
end
end
end
end
return state
end

function chatEmotModel.reddotUnLockEmoById(id)
local state=false
local config=chatConfig.getPackageEmotConfigById(id)
if config and not chatEmotModel.isUnlockPackageEmot(id)then
if config.unlockitem then
local itemcount=bagModel.getItemCountById(config.unlockitem)
state=state or itemcount>0
end
end
return state
end

function chatEmotModel.reddotUnLockItemPackageEmot(tabid)
local cfgs=cfgHelper.get1(cfg_itemchatemotpackageconfig_get,tabid)
local reddot=false
for _,cfg in pairs(cfgs)do
if not chatEmotModel.isUnlockItemEmot(tabid,cfg.tabidx)then
if not chatEmotModel.getItemEmotState(tabid,cfg.tabidx)then
local state=chatEmotModel.isCanUnlockItemPackage(tabid,cfg.tabidx)
if state then
reddot=true
break
end
end
if chatEmotModel.getItemEmotNew(tabid,cfg.tabidx)then
reddot=true
break
end
end
end
return reddot
end

function chatEmotModel.isShowItemEmotPackage(tabid)
local state=false
if _data.itemEmotList[tabid]then
for k,v in pairs(_data.itemEmotList[tabid])do
if v.state then
state=true
break
end
end
end
return state
end

function chatEmotModel.reddotPackage(cfg)
if cfg.type==3 then
return chatEmotModel.reddotUnLockEmoById(cfg.idx)
elseif cfg.type==4 then
return chatEmotModel.reddotUnLockItemPackageEmot(cfg.idx)
end
return false
end

function chatEmotModel.isCanUnlockItemPackage(tabid,tabidx)
local cfgs=cfg_itemchatemotpackageconfig_get(tabid)
local cfg=cfgs[tabidx]
local state=true
for k,v in pairs(cfg.consume)do
local itemId=v[1]
local needNum=v[2]
local hasNum=itemsModel.getCount(itemId)
if hasNum<needNum then
state=false
break
end
end
return state
end

function chatEmotModel.isUnlockAllEmotByItemPackageid(tabid)
local cfgs=cfgHelper.get1(cfg_itemchatemotpackageconfig_get,tabid)
local state=true
for i=1,#cfgs do
if _data.itemEmotList[tabid]and _data.itemEmotList[tabid][i]then
state=_data.itemEmotList[tabid][i].state and state
else
state=false
end
end
return state
end

function chatEmotModel:getEmoId(type,packageid,idx)
if type==2 then
elseif type==3 then
local package=cfgHelper.get2(cfg_chatemotpackageconfig_get,packageid,'package')
local emoid=package[idx]
return emoid
elseif type==4 then
local emoid=cfgHelper.get3(cfg_itemchatemotpackageconfig_get,packageid,idx,'emoid')
return emoid
end
end


function chatEmotModel:getEmotCostList()
if _data.emotCostList~=nil then
return _data.emotCostList
end
local costList={}
local emotpackagecfgs=cfg_chatemotpackageconfig()
for i,v in pairs(emotpackagecfgs)do
costList[v.unlockitem]=v.unlockitem
end
local cfgs=cfg_itemchatemotpackageconfig()
for i,v in pairs(cfgs)do
for i1,v1 in pairs(v)do
local consume=v1.consume
for _,cost in pairs(consume)do
costList[cost[1]]=cost[1]
end
end
end
_data.emotCostList=costList
return _data.emotCostList
end



function chatEmotModel.setSelectPage(page)
_data.page=page
end

function chatEmotModel.getSelectPage()
return _data.page or 1
end



