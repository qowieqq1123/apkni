






local _MODULENAME="bingGongChangController"

gameState.addListener(def_table(_MODULENAME))
bingGongChangController.name=_MODULENAME
bingGongChangController.data={}

function bingGongChangController:onAppStart()

bingGongChangModel:onAppStart()



socketManager:register_receiver(6,95,bingGongChangController.recv_6_95)
socketManager:register_receiver(6,96,bingGongChangController.recv_6_96)
socketManager:register_receiver(6,97,bingGongChangController.recv_6_97)





notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
end


function bingGongChangController:onEnterState(isReconnect)
bingGongChangModel:onEnterState()
end


function bingGongChangController:onProtocolReq()
bingGongChangModel:onProtocolReq()
bingGongChangController:initBuildingData()
end


function bingGongChangController:onLeaveState(isReconnect)
bingGongChangModel:onLeaveState(isReconnect)

self.data={}
end


function bingGongChangController:onLostConnection()

end

function bingGongChangController:initBuildingData()
local bdData=zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eBingGongFang)
if bdData then
socketManager:send_6_95()
end
end


function bingGongChangController:onReConnection(isInitPro)

end


function bingGongChangController.req_6_96()
socketManager:send_6_96()
end

function bingGongChangController.req_6_97()
socketManager:send_6_97()
end

function bingGongChangController.req_6_98(itemId,equipNum,tsItemId,dzGuid)
tsItemId=tsItemId or 0
socketManager:send_6_98(itemId,equipNum,tsItemId,dzGuid)
end

function bingGongChangController.recv_6_95(arg)
local startTime,itemId,equipNum,tsItemId,jingLianVal=arg[1],arg[2],arg[3],arg[4],arg[5]
local lqLevel,dzName,pos,discipledata,discipleimage,specialitylistlen,specialityList,dzGuid=arg[6],arg[7],arg[8],arg[9],arg[10],arg[11],arg[12],arg[13]

if mathHelper.compareInt64(dzGuid,int64.new('0'))then
dzGuid=nil
else
if not UIDiscipleModel:getDiscipleData(dzGuid)then
dzGuid=nil
end
end
if discipleimage~=0 then
bingGongChangModel:setDiziData({guid=dzGuid,lqLevel=lqLevel,dzName=dzName,pos=pos,discipledata=discipledata,discipleimage=discipleimage,specialityList=specialityList})
end
bingGongChangModel:setStartTime(startTime)
bingGongChangModel:setLianZhiData({equipItemId=itemId,equipNum=equipNum,tsItemId=tsItemId})
bingGongChangModel:setJingLianVal(jingLianVal)

UIManager:callWindowFunc("UIBingGongChangWin","refreshState")
UIManager:callWindowFunc("UIBingGongChangWin","refreshJingLianVal")
UIManager:callWindowFunc("UIBingGongChangWin","resetSliderInit")

bingGongChangController.refreshBuildingReddot()

local state=bingGongChangModel:lianZhiState()
if state==1 then
local bdData=zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eBingGongFang)
if bdData then
buildingCDControl:addCDData(buildingCDType.binggongfang,bdData)
end
else
local bdData=zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eBingGongFang)
if bdData then
buildingCDControl:removeCDData(buildingCDType.build,bdData.un_build_id)
end
end
end

function bingGongChangController.recv_6_96(len,itemList,startTime,equipNum,jingLianVal)

if equipNum==0 then
bingGongChangModel:setLianZhiData()
else
bingGongChangModel:updateLianZhiData("equipNum",equipNum)
end

bingGongChangModel:setStartTime(startTime)
bingGongChangModel:setJingLianVal(jingLianVal)

UIManager:callWindowFunc("UIBingGongChangWin","freshInfo")

UIManager:callWindowFunc("UIFastManagerWin","refreshComplete")

bingGongChangController.refreshBuildingReddot()
end


function bingGongChangController.recv_6_97(len,itemList)
bingGongChangModel:setJingLianVal(0)

UIManager:callWindowFunc("UIBingGongChangWin","refreshJingLianVal")

bingGongChangController.refreshBuildingReddot()

end


function bingGongChangController:getEquipFilter(bgfEquipType,stage)

if bgfEquipType==0 then
self.filterlist={}
local typeList=BGF_EQUIP_TYPE.getBGFEquipTypeList()
for i,v in ipairs(typeList)do
local l=bingGongChangModel:getEquipByType(v,stage)or{}
for _,v2 in pairs(l)do
table.insert(self.filterlist,v2)
end

end
return self.filterlist
else
self.filterlist={}
local l=bingGongChangModel:getEquipByType(bgfEquipType,stage)or{}
for _,v2 in pairs(l)do
table.insert(self.filterlist,v2)
end
return self.filterlist
end
end

function bingGongChangController.getItemsMaterials(useCache)
local itemlist={}
local config=cfg_binggongfangteshumaterialsconfig()
for itemid,_ in pairs(config)do
itemlist[#itemlist+1]=itemid
end
local filter={}
filter[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,itemlist}
return bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter,false,useCache)
end

function bingGongChangController.onShowPrize(prizeType,prizelist)
if prizeType==ePrizeType.eBingGongFang then
table.sort(prizelist,function(a,b)
return a.sortWeight>b.sortWeight
end)

local argstable={list=prizelist}
UIManager:showWindow("UIBingGongFangShowPrizeWin",argstable)
end
end

function bingGongChangController.checkLianLingValReddot()
local jlVal=bingGongChangModel:getJingLianVal()
return jlVal>=50
end

function bingGongChangController.refreshBuildingReddot()
local sfId=zongmenModel:getMountainId()
if sfId then
local bdDatas=zongmenModel:getBuildingDataByBdType(sfId,SLG_SYSTEM_TYPE.eBingGongFang)
for i,v in ipairs(bdDatas)do
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end
end
end

