






local _MODULENAME="baoLingShuModel"




def_table(_MODULENAME)



baoLingShuModel.data={}

function baoLingShuModel:onAppStart()

end


function baoLingShuModel:onEnterState()
baoLingShuModel:loadBLSPassAniState()
end


function baoLingShuModel:onLeaveState()

self.data={}
end


function baoLingShuModel:onServerDataInitFinish()

end


function baoLingShuModel:initBaoLingShuData(data)
self.confId=data[1]
self.data[self.confId]=data

self:setBLSPickUpLiBaoBuyNumList(self.confId,data[9],data[10])
self:setBLSPickUpShopExchangeData(self.confId,data[13],data[14])
end

function baoLingShuModel:get_baolingshu_data(id)
if self.data then
return self.data[id]
end
end

function baoLingShuModel:saveRewardsTemp(confId,itemList)
self.rewradCfgId=confId
self.rewardsTemp=itemList
end

function baoLingShuModel:getRewardsTemp()
return self.rewradCfgId,self.rewardsTemp
end


function baoLingShuModel:setBuyDialougeState(flag)
self.data.dialougeState=flag
end

function baoLingShuModel:getBuyDialougeState()
return self.data.dialougeState
end


function baoLingShuModel:loadBLSPassAniState()
self.passAni=userActorSetting.get('baoLingShuPassAniState',false)
end

function baoLingShuModel:saveBLSPassAniState()
userActorSetting.set('baoLingShuPassAniState',self.passAni)
userActorSetting.flush()
end

function baoLingShuModel:changeBLSPassAniState(val)
self.passAni=val
end

function baoLingShuModel:getBLSPassAniState()
return self.passAni
end

function baoLingShuModel:setShowItemList(list,num)
self.showItems=list
self.showNum=num
end

function baoLingShuModel:getShowItemid()
local showItems=self.showItems
if showItems then
local rand
if#showItems<=self.showNum then
rand=math.random(1,#showItems)
else
rand=math.random(self.showNum+1,#showItems)
end
local itemid=showItems[rand]
table.remove(showItems,rand)
table.insert(showItems,1,itemid)
return showItems[1]
end
end

function baoLingShuModel:setShowPoints(points)
self.showPoints=points
end

function baoLingShuModel:getShowPosition()
local points=self.showPoints
local rand=math.random(1,#points)
local pos=points[rand]
table.remove(points,rand)
return pos
end

function baoLingShuModel:isBigReward(itemid)
local bigConfig=cfg_baolingtreebigrewardconfig()
return bigConfig[itemid]~=nil and bigConfig[itemid].bigReward==1
end

function baoLingShuModel:getShowBehaviorName()
local color=0
local one=#self.rewardsTemp==1
local behaviorNameList={
[1]={
[1]='baolinshu_1',
[2]='baolinshu_2',
[3]='baolinshu_7',
[4]='baolinshu_3',
},
[2]={
[1]='baolinshu_4',
[2]='baolinshu_5',
[3]='baolinshu_8',
[4]='baolinshu_6',
},
}
local numIndex=one and 1 or 2
for k,v in pairs(self.rewardsTemp)do
local itemid=v.param_1
if self:isBigReward(itemid)then

return behaviorNameList[numIndex][1]
end
local itemConfig=itemsConfig.getConfig(itemid)
if color<=itemConfig.color then
color=itemConfig.color
end
end
if color>=5 then

return behaviorNameList[numIndex][2]
elseif color>=3 then

return behaviorNameList[numIndex][3]
end

return behaviorNameList[numIndex][4]
end



function baoLingShuModel:getShowDatas(list)
local lv=zongmenModel:getLevel()
for i,v in ipairs(list)do
if lv>=v[1]and lv<=v[2]then
return v
end
end
return list[#list]
end

function baoLingShuModel:get_baolingshu_free_num()
local configId=baoLingShuModel:getConfId()
local num=0
local d=baoLingShuModel:get_baolingshu_data(configId)
if d then
local max_free=cfgHelper.get2(cfg_baolingtreeconfig_get,configId,'freeNum')
local lerp=max_free-d[3]
if lerp>0 then
num=num+lerp
end
local max_gubao=gubaoModel:getGBSkil_BaoLingShuFreeNum()
if max_gubao>0 then
lerp=max_gubao-d[4]
if lerp>0 then
num=num+lerp
end
end
end
return num
end

function baoLingShuModel:check_baolingshu_reddot()
return baoLingShuModel:check_baolingshu_free()and not baoLingShuModel:check_baolingshu_limit()
end

function baoLingShuModel:check_baolingshu_free()
local num=baoLingShuModel:get_baolingshu_free_num()
if num>0 then
return true
end
return false
end

function baoLingShuModel:check_baolingshu_limit()
local configId=baoLingShuModel:getConfId()
local d=baoLingShuModel:get_baolingshu_data(configId)
if d then
local config=cfgHelper.get1(cfg_baolingtreeconfig_get,configId)
local limit=config.numLimit
local cur=d[5]
if cur>=limit then
return true
end
end
return false
end

function baoLingShuModel:checkBaolingshuEnterReddot()
return baoLingShuModel:check_baolingshu_reddot()or baoLingShuModel:checkBLSPickUpEnterReddot()
end

function baoLingShuModel:getBugNum()
local configId=baoLingShuModel:getConfId()
local d=baoLingShuModel:get_baolingshu_data(configId)
return d and d[2]or 0
end


function baoLingShuModel:initPickUpTime()

local configId=baoLingShuModel:getConfId()
local config=cfgHelper.get1(cfg_baolingtreeconfig_get,configId)

local cfgList=config.gubaoIndex or{}
local defaultVersionId=pfwindowslController.sdkPFVersion.game_jianti
local defaultPfId=-1
local versionId=pfwindowslController:getGameVersion()
local pfId=loginModel:getPfid()

local timeCfgList
if cfgList[versionId]then
if cfgList[versionId][pfId]then
timeCfgList=cfgList[versionId][pfId]
else

timeCfgList=cfgList[versionId][defaultPfId]
end
else

if cfgList[defaultVersionId][pfId]then
timeCfgList=cfgList[defaultVersionId][pfId]
else
timeCfgList=cfgList[defaultVersionId][defaultPfId]
end
end

local timeCfg
local openStamp=timeHelper.getServerOpenLongTime()
for i,v in ipairs(timeCfgList)do
local minTime=timeHelper.dataToTimeStam(v[1])
local maxTime
if v[2]then
if v[2]~="0"then
maxTime=timeHelper.dataToTimeStam(v[2])
end
end
if openStamp>=minTime and(not maxTime or openStamp<=maxTime)then
timeCfg=v
break
end
end
if not timeCfg then

return
end

local nowTime=timeHelper.getServerLongTime()







































































local s_time
local e_time
local ns_time
local first_s_time
if timeCfg then
local openDayLimit=timeCfg[3]
local durationDay=timeCfg[4]
local durationTime=durationDay*86400
local openZeroStamp=timeHelper.getServerOpenZeroLongStamp(openStamp)
first_s_time=openZeroStamp+(openDayLimit-1)*86400
local first_e_time=first_s_time+durationTime

if first_e_time<=nowTime then
local minRoundCount=math.floor((nowTime-first_s_time)/durationTime)
s_time=first_s_time+durationTime*minRoundCount
e_time=first_e_time+durationTime*minRoundCount
ns_time=s_time+durationTime
else
s_time=first_s_time
e_time=first_e_time
ns_time=s_time
end
end

if self.data and self.data[configId]then
self.data[configId].startTime=s_time
self.data[configId].endTime=e_time
self.data[configId].nextStartTime=ns_time
self.data[configId].firstStartTime=first_s_time
end
end


function baoLingShuModel:getGBPickUpTime()
local configId=baoLingShuModel:getConfId()
local data=baoLingShuModel:get_baolingshu_data(configId)
if data then
return data.startTime,data.endTime,data.nextStartTime
end
end


function baoLingShuModel:getGBFirstPickUpTime()
local configId=baoLingShuModel:getConfId()
local data=baoLingShuModel:get_baolingshu_data(configId)
if data then
return data.firstStartTime
end
end

function baoLingShuModel:getGotTargetRewardMaxId()
local configId=baoLingShuModel:getConfId()
local data=baoLingShuModel:get_baolingshu_data(configId)
return data and data[8]or nil
end

function baoLingShuModel:setGotTargetRewardMaxId(maxId,cjTotalGuBaoAct)
local configId=baoLingShuModel:getConfId()
if self.data and self.data[configId]then
self.data[configId][8]=maxId
self.data[configId][11]=cjTotalGuBaoAct
end
end

function baoLingShuModel:getTotalGBDrawNum()
local configId=baoLingShuModel:getConfId()
local data=baoLingShuModel:get_baolingshu_data(configId)
return data and data[11]or 0
end

function baoLingShuModel:setBLSPickUpLiBaoBuyNumList(confId,len,data)
local libaoBuyNumList={}
if len and len>0 then
local libaoAllInfoList=data
for i,v in ipairs(libaoAllInfoList)do
local libaoId=v.param_1
local libaoBuyNum=v.param_2
libaoBuyNumList[libaoId]=libaoBuyNum
end
end
self.data[confId].libaoBuyNumList=libaoBuyNumList
end

function baoLingShuModel:setBLSPickUpLiBaoBuyNumByLiBaoId(libaoId,buyNum)
local configId=baoLingShuModel:getConfId()
if self.data and self.data[configId]then
if not self.data[configId].libaoBuyNumList then
self.data[configId].libaoBuyNumList={}
end

self.data[configId].libaoBuyNumList[libaoId]=buyNum
end
end

function baoLingShuModel:getBLSPickUpLiBaoBuyNum(libaoId)
local configId=baoLingShuModel:getConfId()
local data=baoLingShuModel:get_baolingshu_data(configId)
if data and data.libaoBuyNumList and data.libaoBuyNumList[libaoId]then
return data.libaoBuyNumList[libaoId]
end
return nil
end

function baoLingShuModel:getConfId()
return self.confId or 1
end


function baoLingShuModel:checkIsInPickUpNow()

if verifyManager:isHideBusinessActivity()then
return false
end
local sTime,eTime,nsTime=baoLingShuModel:getGBPickUpTime()
local nowTime=timeHelper.getServerLongTime()
local isInPickUpNow=sTime and eTime and nowTime>=sTime and nowTime<eTime or false
return isInPickUpNow
end


function baoLingShuModel:setPickUpShowGBListIndex(listIndex)
local configId=baoLingShuModel:getConfId()
local data=baoLingShuModel:get_baolingshu_data(configId)
if data then
data[12]=listIndex
end
end


function baoLingShuModel:getPickUpShowGBList()
local configId=baoLingShuModel:getConfId()
local listIndex=baoLingShuModel:getPickUpShowGBListIndex()
local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
local roundCount,roundId=baoLingShuModel:getPickUpShowGBPickUpRoundCount()
if not isInPickUpNow then

local nowTime=timeHelper.getServerLongTime()
local firstStartTime=baoLingShuModel:getGBFirstPickUpTime()
local isStartFirst=true
if not firstStartTime or nowTime<firstStartTime then

isStartFirst=false
end

if isStartFirst then

listIndex=listIndex+1
end
end
local gubaoList=cfgHelper.get2(cfg_baolingtreeconfig_get,configId,'gubaoList')
local maxIndex=#gubaoList[roundId]
if listIndex<=0 or listIndex>maxIndex then
listIndex=1
end

return gubaoList[roundId][listIndex]
end


function baoLingShuModel:getPickUpShowGBListIndex()
local configId=baoLingShuModel:getConfId()
local data=baoLingShuModel:get_baolingshu_data(configId)
return data and data[12]or 0
end


function baoLingShuModel:getPickUpShowGBPickUpRoundCount()
local configId=baoLingShuModel:getConfId()






local nowTime=timeHelper.getServerLongTime()
local firstStartTime=baoLingShuModel:getGBFirstPickUpTime()
if not firstStartTime or nowTime<firstStartTime then

return 0
end
local config=cfgHelper.get1(cfg_baolingtreeconfig_get,configId)


local cfgList=config.gubaoIndex or{}
local defaultVersionId=pfwindowslController.sdkPFVersion.game_jianti
local defaultPfId=-1
local versionId=pfwindowslController:getGameVersion()
local pfId=loginModel:getPfid()

local timeCfgList
if cfgList[versionId]then
if cfgList[versionId][pfId]then
timeCfgList=cfgList[versionId][pfId]
else

timeCfgList=cfgList[versionId][defaultPfId]
end
else

if cfgList[defaultVersionId][pfId]then
timeCfgList=cfgList[defaultVersionId][pfId]
else
timeCfgList=cfgList[defaultVersionId][defaultPfId]
end
end

local timeCfg
local openStamp=timeHelper.getServerOpenLongTime()
for i,v in ipairs(timeCfgList)do
local minTime=timeHelper.dataToTimeStam(v[1])
local maxTime
if v[2]then
if v[2]~="0"then
maxTime=timeHelper.dataToTimeStam(v[2])
end
end
if openStamp>=minTime and(not maxTime or openStamp<=maxTime)then
timeCfg=v
break
end
end
if not timeCfg then

return
end
local sTime,eTime,nsTime=baoLingShuModel:getGBPickUpTime()
local durationDay=timeCfg[4]
local durationTime=durationDay*86400
local lerp=eTime-firstStartTime
local roundCount=math.floor(lerp/durationTime)
return roundCount,timeCfg[5]

end


function baoLingShuModel:getPickUpShowGBPickUpRoundList()
local roundCount,roundId=baoLingShuModel:getPickUpShowGBPickUpRoundCount()
if not roundCount or roundCount<=1 then
return nil
end

local roundList={}
local configId=baoLingShuModel:getConfId()
local gubaoList=cfgHelper.get2(cfg_baolingtreeconfig_get,configId,'gubaoList')
local maxIndex=#gubaoList[roundId]

local endIndex
if roundCount<=maxIndex then
endIndex=1
else
endIndex=roundCount-maxIndex+1
end

for i=roundCount,endIndex,-1 do
local listIndex=i
if listIndex>maxIndex then
listIndex=(i-1)%maxIndex+1
end
table.insert(roundList,listIndex)
end

return roundList
end

function baoLingShuModel:setBLSPickUpShopExchangeData(configId,len,data)
local shopExchangeData={}
if len and len>0 then
for i,v in ipairs(data)do
local gubaoItemId=v.param_1
local exchangeNum=v.param_2 or 0
shopExchangeData[gubaoItemId]=exchangeNum
end
end
self.data[configId].shopExchangeData=shopExchangeData
end

function baoLingShuModel:getBLSPickUpShopExchangeNumByGBItemId(gubaoItemId)
local configId=baoLingShuModel:getConfId()
local data=baoLingShuModel:get_baolingshu_data(configId)
if data and data.shopExchangeData and data.shopExchangeData[gubaoItemId]then
return data.shopExchangeData[gubaoItemId]or 0
end
return 0
end

function baoLingShuModel:setBLSPickUpShopExchangeNumByGBItemId(gubaoItemId,num)
local configId=baoLingShuModel:getConfId()
if self.data and self.data[configId]then
if not self.data[configId].shopExchangeData then
self.data[configId].shopExchangeData={}
end
self.data[configId].shopExchangeData[gubaoItemId]=num
end
end


function baoLingShuModel:clearBLSPickUpShopAllExchangeNum()
local configId=baoLingShuModel:getConfId()
if self.data and self.data[configId]then
self.data[configId].shopExchangeData={}
end
end


function baoLingShuModel:checkBLSPickUpTargetReddot()
local configId=baoLingShuModel:getConfId()
if not self.data or not self.data[configId]then
return false
end
if not baoLingShuModel:checkIsInPickUpNow()then
return false
end

local taskCfg=cfg_baolingtreegoalconfig()
local drawNum=baoLingShuModel:getTotalGBDrawNum()
local nowMaxGotRewardId=baoLingShuModel:getGotTargetRewardMaxId()or 0
for i,v in ipairs(taskCfg)do
if nowMaxGotRewardId<v.id and drawNum>=v.xynum then

return true
end
end

return false
end


function baoLingShuModel:checkBLSPickUpLiBaoReddot()
local configId=baoLingShuModel:getConfId()
if not self.data or not self.data[configId]then
return false
end
if not baoLingShuModel:checkIsInPickUpNow()then
return false
end

local libaoCfg=cfg_baolingtreelibaoconfig()
for i,v in ipairs(libaoCfg)do
local isFree=v.buyType==nil
if isFree then
local libaoId=v.id
local buyNum=baoLingShuModel:getBLSPickUpLiBaoBuyNum(libaoId)or 0
local limitCount=v.buyNum
local isSellOut=buyNum>=limitCount
if not isSellOut then

return true
end
end
end

return false
end


function baoLingShuModel:checkBLSPickUpShopReddot()
local configId=baoLingShuModel:getConfId()
if not self.data or not self.data[configId]then
return false
end
if not baoLingShuModel:checkIsInPickUpNow()then
return false
end



















local gbExchangeList=baoLingShuModel:getPickUpShowGBList()or{}
for i,v in ipairs(gbExchangeList)do
local gubaoItemId=v[1]
local moneyType=v[3]
local price=v[4]
local limitCount=v[5]
local exchangeNum=baoLingShuModel:getBLSPickUpShopExchangeNumByGBItemId(gubaoItemId)
local remainingExchangeCount=limitCount-exchangeNum
local isSellOut=false
if remainingExchangeCount<=0 then
remainingExchangeCount=0
isSellOut=true
end

if not isSellOut then
local isEoughMoney=moneyModel.checkEnoughMoney(moneyType,price)
if isEoughMoney then
return true
end
end
end

return false
end


function baoLingShuModel:checkBLSPickUpEnterReddot()
return self:checkBLSPickUpTargetReddot()or self:checkBLSPickUpLiBaoReddot()or self:checkBLSPickUpShopReddot()
end


function baoLingShuModel.test_printGubaoPickUpTime()
local sTime,eTime,nsTime=baoLingShuModel:getGBPickUpTime()
local nowTime=timeHelper.getServerLongTime()
local isInPickUpNow=nowTime>=sTime and nowTime<eTime
local firstStartTime=baoLingShuModel:getGBFirstPickUpTime()
local listIndex=baoLingShuModel:getPickUpShowGBListIndex()


end
