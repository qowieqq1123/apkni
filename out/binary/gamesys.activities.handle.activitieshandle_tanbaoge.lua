







activitiesHandle_tanbaoge=new_activitiesHandle('activitiesHandle_tanbaoge',activitiesHandle)

function activitiesHandle_tanbaoge:onInit()

end

function activitiesHandle_tanbaoge.recv_249_52(args)
local subType=SUB_ACTIVITY_TYPE.eTanBaoGe
local actId=args[1]
local subId=args[2]
local freeNum=args[3]
local layer=args[4]
local layerIndex=args[5]
local hopeVal=args[6]
local doubleLayer=args[7]
local jmpGoldFlag=args[8]
local nowSelectItemFloor=args[9]
local nowSelectItemId=args[10]
local selectItemLen=args[11]
local selectItemList=args[12]
local nextMustKeyCount=args[13]


local needReqRank=false

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
if not data.isInit then
data.isInit=true
needReqRank=true
end

data.freeNum=freeNum
data.layer=layer
data.layerIndex=layerIndex
data.hopeVal=hopeVal
data.doubleLayer=doubleLayer
data.jmpGoldFlag=jmpGoldFlag
data.nowSelectItemFloor=nowSelectItemFloor
data.nowSelectItemId=nowSelectItemId
data.nextMustKeyCount=nextMustKeyCount


local list={}
if selectItemLen>0 then
for i,v in ipairs(selectItemList)do
local itemId=v.itemId
list[itemId]=v.chNum or 0
end
end
data.selectItemCountList=list

activitiesModel:setSubActInfoData(actId,subType,subId,data)

if needReqRank then

local subActInfo=activitiesModel:getSubActInfo(actId,subType,subId)
subActInfo:reqTanBaoGeGetFirstClearInfo()
end

local win=UIManager:findActiveWindow('UISubAct_tanbaogeWin')
if win then
win:refresh()
end

win=UIManager:findActiveWindow('UISubAct_tanbaoge_wishWin')
if win then
win:refreshFloorData()
win:refreshWishVal(true)
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_tanbaoge.recv_249_53(actId,subId,len,layerList)
local subType=SUB_ACTIVITY_TYPE.eTanBaoGe
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
local rankRewardInfoList_lookup={}
for i=1,len do
local info=layerList[i]
local floor=info.layer
rankRewardInfoList_lookup[floor]=info
end
data.rankRewardInfoList_lookup=rankRewardInfoList_lookup
data.rankRewardInfoList=layerList
data.rankRewardReddot=nil

activitiesModel:setSubActInfoData(actId,subType,subId,data)
local win=UIManager:findActiveWindow('UISubAct_tanbaoge_rewardWin')
if win then
win:refresh()
end

win=UIManager:findActiveWindow('UISubAct_tanbaogeWin')
if win then
win:refreshBtnPanel()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function activitiesHandle_tanbaoge.recv_249_54(actId,subId,randIndex,len,itemList)
local subType=SUB_ACTIVITY_TYPE.eTanBaoGe

local list={}
if len>0 then
for i,v in ipairs(itemList)do
table.insert(list,{itemid=v.param_1,num=v.param_2})
end
end

local win=UIManager:findActiveWindow('UISubAct_tanbaoge_wishWin')
if win then
win:recvWish(randIndex,list)
end
end


function activitiesHandle_tanbaoge.recv_249_55(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eTanBaoGe

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
data.rankRewardReddot=true
activitiesModel:setSubActInfoData(actId,subType,subId,data)

local win=UIManager:findActiveWindow('UISubAct_tanbaoge_rewardWin')
if win then

local subActInfo=activitiesModel:getSubActInfo(actId,subType,subId)
subActInfo:reqTanBaoGeGetFirstClearInfo()
end

win=UIManager:findActiveWindow('UISubAct_tanbaogeWin')
if win then
win:refreshBtnPanel()
end

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end


function activitiesHandle_tanbaoge.recv_249_203(actId,subId,nowSelectItemFloor,nowSelectItemId)
local subType=SUB_ACTIVITY_TYPE.eTanBaoGe

local data=activitiesModel:getSubActInfoData(actId,subType,subId)
data.nowSelectItemFloor=nowSelectItemFloor
data.nowSelectItemId=nowSelectItemId
activitiesModel:setSubActInfoData(actId,subType,subId,data)

UIManager.info("选择成功")
local win=UIManager:findActiveWindow('UISubAct_tanbaogeWin')
if win then
win:refresh()
end

local win=UIManager:findActiveWindow('UISubAct_tanbaoge_selectWin')
if win then
win:onCloseBtn()
end
end

