









tianmingzengliModel={}


tianmingzengliModel.data={}

function tianmingzengliModel:onAppStart()

end


function tianmingzengliModel:onEnterState(isReconnect)
tianmingzengliModel:loadTMZLLastUnlockPosList()
end


function tianmingzengliModel:onProtocolReq()

end


function tianmingzengliModel:onLeaveState(isReconnect)


self.data={}
end



function tianmingzengliModel:getTMZLAllList()
if self.data and self.data.tmzlAllList then
return self.data.tmzlAllList
end
return nil
end


function tianmingzengliModel:setTMZLAllData(len,dataList)
self.data.tmzlAllList={}

if len>0 then
for i,v in ipairs(dataList)do
table.insert(self.data.tmzlAllList,v)
tianmingzengliModel:addTMZLShowItemList(v)
end
end
end


function tianmingzengliModel:checkTMZLAllData()
local allConfig=cfg_tianmingzengliconfig()
if allConfig then
for _,v in pairs(allConfig)do
local dzId=v.id
self:checkTMZLAddDzDataByDzId(dzId)
end
end
end


function tianmingzengliModel:checkTMZLAddDzDataByDzId(dzId)
local cfg=cfgHelper.get(cfg_tianmingzengliconfig_get,dzId)
if not cfg then
return
end


local isHide=tianmingzengliModel:checkTMZLDzIsHideByDzId(dzId)
if isHide then
return
end

if not self.data.tmzlShowItemList_lookup or not self.data.tmzlShowItemList_lookup[dzId]then

local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzId)
if dzData then

local defaultData={
id=dzId,
len=0,
list=nil,
}
tianmingzengliModel:addTMZLShowItemList(defaultData)
end
end
end


function tianmingzengliModel:getTMZLShowItemList()
if self.data and self.data.tmzlShowItemList then
return self.data.tmzlShowItemList
end
return nil
end



function tianmingzengliModel:addTMZLShowItemList(tmzlData)
if not self.data.tmzlShowItemList then
self.data.tmzlShowItemList={}
end

if not self.data.tmzlShowItemList_lookup then
self.data.tmzlShowItemList_lookup={}
end

if not self.data.tmzlHideItemList_lookup then
self.data.tmzlHideItemList_lookup={}
end

local dzId=tmzlData.id
if self.data.tmzlShowItemList_lookup[dzId]then
return
end
local libaoDataList={}
if tmzlData.len>0 then
for i,v in ipairs(tmzlData.list)do
local libaoId=v.param_1
local libaoData={
libaoId=libaoId,
freeGotCount=v.param_2,
buyCount=v.param_3,
lastBuyTime=v.param_4,
}
libaoDataList[libaoId]=libaoData
end
end
local data={
id=dzId,
libaoDataList=libaoDataList
}
local isGotAll=self:getTMZLDzGotAllReward(dzId,data)
if not isGotAll then
local idx=#self.data.tmzlShowItemList+1
self.data.tmzlShowItemList[idx]=data
self.data.tmzlShowItemList_lookup[dzId]=idx
else
self.data.tmzlHideItemList_lookup[dzId]=true
end
end


function tianmingzengliModel:checkAndClearTMZLShowItemList()
if self.data.tmzlShowItemList and next(self.data.tmzlShowItemList)then
local newList={}
local newList_lookup={}
local newHideList_lookup={}
for i,v in ipairs(self.data.tmzlShowItemList)do
local dzId=v.id
local isGotAll=tianmingzengliModel:getTMZLDzGotAllRewardEx(dzId)
if not isGotAll then
local idx=#newList+1
newList[idx]=v
newList_lookup[dzId]=idx
else
newHideList_lookup[dzId]=true
end
end

self.data.tmzlShowItemList=newList
self.data.tmzlShowItemList_lookup=newList_lookup
self.data.tmzlHideItemList_lookup=newHideList_lookup
end
end


function tianmingzengliModel:checkTMZLDzIsShowByDzId(dzId)
if not self.data.tmzlShowItemList_lookup or not next(self.data.tmzlShowItemList_lookup)then
return false
end

if self.data.tmzlShowItemList_lookup[dzId]then
return true
end
return false
end


function tianmingzengliModel:checkTMZLDzIsHideByDzId(dzId)
if not self.data.tmzlHideItemList_lookup or not next(self.data.tmzlHideItemList_lookup)then
return false
end

if self.data.tmzlHideItemList_lookup[dzId]then
return true
end
return false
end


function tianmingzengliModel:setTMZLShowItemLibaoData(dzId,libaoId,free,recharge)
if not self.data.tmzlShowItemList then
return
end

if not self.data.tmzlShowItemList_lookup then
return
end

if self.data.tmzlShowItemList_lookup[dzId]then
local dataIdx=self.data.tmzlShowItemList_lookup[dzId]
local data=self.data.tmzlShowItemList[dataIdx]
if data then
if not data.libaoDataList then
data.libaoDataList={}
end
if not data.libaoDataList[libaoId]then
data.libaoDataList[libaoId]={}
end
data.libaoDataList[libaoId].libaoId=libaoId
data.libaoDataList[libaoId].freeGotCount=free
data.libaoDataList[libaoId].buyCount=recharge
end
end
end


function tianmingzengliModel:getTMZLFreeLibaoGotCount(dzId,libaoId)
local count=0
if self.data.tmzlShowItemList_lookup and self.data.tmzlShowItemList_lookup[dzId]then
local dataIdx=self.data.tmzlShowItemList_lookup[dzId]
local data=self.data.tmzlShowItemList[dataIdx]
if data then
if data.libaoDataList[libaoId]then
count=data.libaoDataList[libaoId].freeGotCount
end
end
end
return count
end


function tianmingzengliModel:getTMZLLibaoBuyCount(dzId,libaoId)
local count=0
if self.data.tmzlShowItemList_lookup and self.data.tmzlShowItemList_lookup[dzId]then
local dataIdx=self.data.tmzlShowItemList_lookup[dzId]
local data=self.data.tmzlShowItemList[dataIdx]
if data then
if data.libaoDataList[libaoId]then
count=data.libaoDataList[libaoId].buyCount
end
end
end
return count
end


function tianmingzengliModel:checkTMZLFreeLibaoIsGot(dzId,libaoId)
local freeGotCount=tianmingzengliModel:getTMZLFreeLibaoGotCount(dzId,libaoId)
return freeGotCount>0
end


function tianmingzengliModel:getTMZLDzReddot(dzId)

local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzId)
local cfg=cfgHelper.get(cfg_tianmingzengliconfig_get,dzId)
if dzData and cfg then
local libaoCfgList=tianmingzengliModel:changeRewards(cfg.rewards)
for i=1,#libaoCfgList do
local libaoCfg=libaoCfgList[i]
local libaoId=i
local targetTianmingLv=libaoCfg[1]

local dzNowTmLv=-1
if dzData then
dzNowTmLv=UIDiscipleModel:getTianMingLevelEx(dzData)
end
local openLibao=dzNowTmLv>=targetTianmingLv or false
local isGot=tianmingzengliModel:checkTMZLFreeLibaoIsGot(dzId,libaoId)
if openLibao and not isGot then
return true
end
end
end
return false
end


function tianmingzengliModel:getTMZLEnterReddot()
local tmzlShowList=tianmingzengliModel:getTMZLShowItemList()
if not tmzlShowList or not next(tmzlShowList)then
return false
end

for i,v in ipairs(tmzlShowList)do
local dzId=v.id
local reddot=tianmingzengliModel:getTMZLDzReddot(dzId)
if reddot then
return true,dzId
end
end

return false
end


function tianmingzengliModel:getTMZLDzGotAllRewardEx(dzId)
if self.data.tmzlShowItemList_lookup and self.data.tmzlShowItemList_lookup[dzId]then
local dataIdx=self.data.tmzlShowItemList_lookup[dzId]
local data=self.data.tmzlShowItemList[dataIdx]
return self:getTMZLDzGotAllReward(dzId,data)
end

return false
end


function tianmingzengliModel:getTMZLDzGotAllReward(dzId,data)
local cfg=cfgHelper.get(cfg_tianmingzengliconfig_get,dzId)
if data and cfg and data.libaoDataList and next(data.libaoDataList)then
local libaoCfgList=tianmingzengliModel:changeRewards(cfg.rewards)
for i,v in ipairs(libaoCfgList)do
local libaoData=data.libaoDataList[i]
if not libaoData then

return false
end
local libaoId=libaoData.libaoId

local freeGotCount=libaoData.freeGotCount or 0
if freeGotCount<=0 then

return false
end


local libaoCfg=libaoCfgList[libaoId]
local buyLimitCount=libaoCfg[5]
local nowBuyCount=libaoData.buyCount or 0
if not buyLimitCount or nowBuyCount<buyLimitCount then

return false
end
end
return true
end
return false
end



function tianmingzengliModel:loadTMZLLastUnlockPosList()
self.data.tmzlLastUnlockPosList=userActorSetting.get('tmzlLastUnlockPosList',{})
end


function tianmingzengliModel:saveTMZLLastUnlockPosList()
if not self.data.tmzlLastUnlockPosList then
self.data.tmzlLastUnlockPosList={}
end
userActorSetting.set('tmzlLastUnlockPosList',self.data.tmzlLastUnlockPosList)
userActorSetting.flush()
end


function tianmingzengliModel:getTMZLLastUnlockPos(dzId)
local dzIdStr=tostring(dzId)
if self.data.tmzlLastUnlockPosList then
return self.data.tmzlLastUnlockPosList[dzIdStr]
end
end


function tianmingzengliModel:setTMZLLastUnlockPos(dzId,pos)
if dzId then
local dzIdStr=tostring(dzId)
if not self.data.tmzlLastUnlockPosList then
self.data.tmzlLastUnlockPosList={}
end
self.data.tmzlLastUnlockPosList[dzIdStr]=pos

tianmingzengliModel:saveTMZLLastUnlockPosList()
end
end



function tianmingzengliModel:changeRewards(libaoCfgList)
local gversion=pfwindowslController:getGameVersion()
local pfId=loginModel:getPfid()
local list={}
if gversion and libaoCfgList then
local temp=libaoCfgList[gversion]or libaoCfgList[1]
if temp then
list=temp[pfId]or temp[-1]
end
end

return list or{}
end