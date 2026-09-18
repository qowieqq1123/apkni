






local _MODULENAME="LZDiaoKeModel"
LZDKSTATE={
eDKing=1,
eNotDk=2,
eHoldDKReward=3
}

def_table(_MODULENAME)
LZDiaoKeModel.name=_MODULENAME
LZDiaoKeModel.data={}

function LZDiaoKeModel:onAppStart()

end


function LZDiaoKeModel:onEnterState(isReconnect)

end


function LZDiaoKeModel:onProtocolReq()

end


function LZDiaoKeModel:onLeaveState(isReconnect)

self.data={}
end



function LZDiaoKeModel:setData(data)
self.data=data
end

function LZDiaoKeModel:getData()
return self.data
end

function LZDiaoKeModel:getSFData(sfid)




if not self.data[sfid]then
self.data[sfid]={}
end
return self.data[sfid]
end

function LZDiaoKeModel:getJZData(sfid,jzGuid)
local sfData=self:getSFData(sfid)





if not sfData[jzGuid]then
sfData[jzGuid]={}
sfData[jzGuid].u_jzGuid=jzGuid
end
return sfData[jzGuid]
end

function LZDiaoKeModel:getJZData_Lgz(sfid,jzGuid)
local isNeedupdate,updateCnt=LZDiaoKeModel:checkUpdateJZData_Lgz(sfid,jzGuid)
local jzData=self:getJZData(sfid,jzGuid)
if not jzData.lgz then
jzData.lgz=0
end
local temp=jzData.lgz
if isNeedupdate then

temp=temp+updateCnt
timeEventController.delayDo(3,function()
LZDiaoKeController:req_AddLingGan(sfid,jzGuid)
end)
end
return temp
end

function LZDiaoKeModel:getJZData_lgzAddCount(sfid,jzGuid)
local jzData=self:getJZData(sfid,jzGuid)
if not jzData.lgzAddCount then
jzData.lgzAddCount=0
end
return jzData.lgzAddCount
end


function LZDiaoKeModel:getJZData_DkNum(sfid,jzGuid)
local jzData=self:getJZData(sfid,jzGuid)
if not jzData.dkNum then
jzData.dkNum=0
end
return jzData.dkNum
end

function LZDiaoKeModel:getJZData_StartTime(sfid,jzGuid)
local jzData=self:getJZData(sfid,jzGuid)
if not jzData.startTime then
jzData.startTime=0
end
return jzData.startTime
end

function LZDiaoKeModel:getJZData_DzdkList(sfid,jzGuid)
local jzData=self:getJZData(sfid,jzGuid)
if not jzData.dzdkList then
jzData.dzdkList={1,2,3,4,5}
end
return jzData.dzdkList
end

function LZDiaoKeModel:getJZData_Dzlen(sfid,jzGuid)
local jzData=self:getJZData(sfid,jzGuid)
if not jzData.dzlen then
jzData.dzlen=5
end
return jzData.dzlen
end

function LZDiaoKeModel:getJZData_DkItemList(sfid,jzGuid)
local jzData=self:getJZData(sfid,jzGuid)
if not jzData.dkItemList then
jzData.dkItemList={}
end
return jzData.dkItemList
end

function LZDiaoKeModel:CheckDKState(sfid,jzGuid)
local startTime=self:getJZData_StartTime(sfid,jzGuid)
if startTime==0 then
return LZDKSTATE.eNotDk,0,0
else
local sumNum=self:getJZData_DkNum(sfid,jzGuid)
local needTime=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"dktime")
local curTime=timeHelper.getServerShortTime()


local curNum=math.floor((curTime-startTime)/needTime)
if curNum>=sumNum then
return LZDKSTATE.eHoldDKReward,sumNum,sumNum
end

return LZDKSTATE.eDKing,curNum,sumNum
end

end


function LZDiaoKeModel:getMaxDKCount(sfid,jzGuid)
local dzlen=LZDiaoKeModel:getJZData_Dzlen(sfid,jzGuid)
local useItem=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"useItem")
local costItem=useItem[dzlen]
local maxCnt=999
local itemId
for i,v in ipairs(costItem)do
local itemid=v[1]
local needCount=v[2]
local hasCount=itemsModel.getCount(itemid)
local canDkCnt=math.floor(hasCount/needCount)
if canDkCnt<=0 and not itemId then
itemId=itemid
end
maxCnt=canDkCnt<maxCnt and canDkCnt or maxCnt
end
maxCnt=999<maxCnt and 999 or maxCnt
local isCan=maxCnt~=0
maxCnt=isCan and maxCnt or 1
return maxCnt,isCan,itemId
end

function LZDiaoKeModel:isDKing(jzGuid)
if not LZDiaoKeController.checkOpen()then
return false
end
local sfid=zongmenModel:getMountainId()
return LZDiaoKeModel:CheckDKState(sfid,jzGuid)==LZDKSTATE.eDKing
end

function LZDiaoKeModel:hasHoldDKReward()
if not LZDiaoKeController.checkOpen()then
return false
end
local sfid=zongmenModel:getMountainId()
local sfData=LZDiaoKeModel:getSFData(sfid)
for i,v in pairs(sfData)do
if LZDiaoKeModel:CheckDKState(sfid,i)==LZDKSTATE.eHoldDKReward then
return true
end
end
return false
end

function LZDiaoKeModel:hasReward(jzGuid)
if not LZDiaoKeController.checkOpen()then
return false
end
local sfid=zongmenModel:getMountainId()
local lgz=LZDiaoKeModel:getJZData_Lgz(sfid,jzGuid)
if lgz>=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"lgz")then
return true
end
local dkState,curNum,sumNum=self:CheckDKState(sfid,jzGuid)
return curNum>0
end

function LZDiaoKeModel:checkUpdateJZData_Lgz(sfid,jzGuid)
local dkState,curNum,sumNum=self:CheckDKState(sfid,jzGuid)
local lgzAddCount=self:getJZData_lgzAddCount(sfid,jzGuid)
if curNum>lgzAddCount then
return true,curNum-lgzAddCount
end
return false,0
end

function LZDiaoKeModel:checkReddot(un_build_id)
if not LZDiaoKeController.checkOpen()or not un_build_id then
return false
end
local sfid,jzGuid=zongmenModel:getMountainId(),un_build_id

local lgz=LZDiaoKeModel:getJZData_Lgz(sfid,jzGuid)
return lgz>=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"lgz")
end

function LZDiaoKeModel:checkDayRedot()
local useItems=cfgHelper.get(cfg_lingzhendiaokebaseconfig_get,1,"useItem")
local items=useItems[5]
for i,v in ipairs(items)do
local have=bagModel.getItemCountById(v[1])
if have<v[2]then
return false
end
end

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLZDKTips)
return not flag
end




