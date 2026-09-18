





function wanBaoXunBaoDuiController:onEnterState_xzs(isReconnect)
self.data.xzsAutoDispatchList={}
self.data.xzsPreSelectCatList={}
end

function wanBaoXunBaoDuiController:onLeaveState_xzs(isReconnect)

end


function wanBaoXunBaoDuiController:startDoProcess(autoData)
self.data.xzsAutoDispatchList[autoData.id]=autoData
self:doProcessByChannelId(autoData.id)
end

function wanBaoXunBaoDuiController:doProcessByChannelId(id)
local data=self.data.xzsAutoDispatchList[id]
if data==nil then return end

local pid=data.plist[data.processIdx]
if pid==nil then return end

if pid==WBXBD_XZS_Process.ReceiveTask then
wanBaoXunBaoDuiController:reqTakeAdventureTask(data.taskId,id)
end

if pid==WBXBD_XZS_Process.RestoreTili then
wanBaoXunBaoDuiController:reqRecoverCatTiliByUseMoney(#data.restoreList,data.restoreList,true)
end

if pid==WBXBD_XZS_Process.DispatchGo then
wanBaoXunBaoDuiController:reqGoAdventure(id,#data.catList,data.catList)
end



data.processIdx=data.processIdx+1
end

function wanBaoXunBaoDuiController:doProcessByEmployeeList(list)
if list==nil then return end
if#list==0 then return end
if table.numsEx(self.data.xzsAutoDispatchList)==0 then return end


local autoDispatchData
for index,data in pairs(self.data.xzsAutoDispatchList)do
for _,catData in ipairs(list)do
if table.findValue(data.catList,catData.guid)then
autoDispatchData=data
break
end
end
if autoDispatchData then
break
end
end

if autoDispatchData then
wanBaoXunBaoDuiController:doProcessByChannelId(autoDispatchData.id)
end
end

function wanBaoXunBaoDuiController:finishDispatchByChannelId(id)
local data=self.data.xzsAutoDispatchList[id]
if data==nil then return end

if table.numsEx(self.data.xzsAutoDispatchList)==1 then
self.data.xzsAutoDispatchList={}
self.data.xzsPreSelectCatList={}
else
self.data.xzsAutoDispatchList[id]=nil
end
end

function wanBaoXunBaoDuiController:failExecute()
self.data.xzsPreSelectCatList={}
end

function wanBaoXunBaoDuiController:getDispatchCat_XZS(channelData,taskId)

local needTx=cfgHelper.get2(cfg_catmapconfig_get,taskId,'needTx')
local tili=cfgHelper.get2(cfg_catmapconfig_get,taskId,'tili')

local employeeList=wanBaoXunBaoDuiModel:getSelectEmployeeDatas()

local txConditionListLookUp={}
for k,v in pairs(needTx)do
txConditionListLookUp[v]=true
end

local catlist={}

local isExinclude=#self.data.xzsPreSelectCatList>0
for index,catData in pairs(employeeList)do
if isExinclude then
if not table.findValue(self.data.xzsPreSelectCatList,catData.guid)then
catlist[#catlist+1]=table.weakCopy(catData)
end
else
catlist[#catlist+1]=table.weakCopy(catData)
end
end


for k,catData in pairs(catlist)do

catData.sortWeigetHight=(catData.color+catData.lv)
if not bitHelper.check_pos(catData.state,0)then

catData.sortWeigetHight=catData.sortWeigetHight*100

for _,attr in pairs(catData.propList)do
catData.sortWeigetHight=catData.sortWeigetHight+attr
end

if catData.tili>=tili then
catData.sortWeigetHight=catData.sortWeigetHight*10000
end

if catData.texing_num>0 then
for _,txid in pairs(catData.txList)do
if txConditionListLookUp[txid]~=nil then
catData.sortWeigetHight=catData.sortWeigetHight*10
if catData.tili>=tili then
catData.tuijian=true
end
end
end
end
end
end

table.sort(catlist,function(catA,catB)
if catA.sortWeigetHight==catB.sortWeigetHight then
return catA.tili>catB.tili
else
return catA.sortWeigetHight>catB.sortWeigetHight
end
end)

local isNeedRestore=false
local quickList={}
local needNum=3-channelData.employeeLen
for k=1,#catlist do
local catinfo=catlist[k]
if catinfo then
local catMaxTili=wanBaoXunBaoDuiModel:caculationMaxTili(catinfo)
if catMaxTili>=tili then
if tili>catinfo.tili then
isNeedRestore=true
end
quickList[#quickList+1]=catinfo.guid
needNum=needNum-1
end
end
if needNum<=0 then
break
end
end

local posQuickList={}
if channelData.employeeLen>0 then
local c=1
posQuickList=table.weakCopy(channelData.employeeList)
for index=1,3 do
if posQuickList==nil then
posQuickList=quickList[c]
c=c+1
end
end
else
posQuickList=quickList
end

if#quickList>0 then
self.data.xzsPreSelectCatList=table.concatTable(self.data.xzsPreSelectCatList,quickList)
end

return quickList,isNeedRestore
end

function wanBaoXunBaoDuiController:setXZSReceiveFlag(flag)
self.isXZSFlag=flag==1
end

function wanBaoXunBaoDuiController:getXZSReceiveFlag()
return self.isXZSFlag
end
