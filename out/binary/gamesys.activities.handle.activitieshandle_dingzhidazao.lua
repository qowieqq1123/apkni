







activitiesHandle_dingzhidazao=new_activitiesHandle('activitiesHandle_dingzhidazao',activitiesHandle)

function activitiesHandle_dingzhidazao:onEnterState()
notifySystem:listenNotify(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
end

function activitiesHandle_dingzhidazao:onLeaveState()
notifySystem:removelistener(notifyConfig.onShowPrize,self.onShowPrize)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)
end


function activitiesHandle_dingzhidazao.on_item_list_changed(args)
local sub_actcfg=cfg_dingzhidazaoactconfig_get(1)
local costCfg=sub_actcfg.useItem[1][1]
local costId=costCfg[1]
if costId==nil then return end

local has=false
for _,v in ipairs(args)do
if costId==v[3]then
has=true
break
end
end

if has then
local subType=SUB_ACTIVITY_TYPE.eDingZhiDaZao
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
end

function activitiesHandle_dingzhidazao.onShowPrize(prizeType,prizelist,effectData)

if prizeType==ePrizeType.eDingZhiDaZao then
showPrizeControl.showWindow(prizelist)
end
end

function activitiesHandle_dingzhidazao.recv_249_207(args)
local subType=SUB_ACTIVITY_TYPE.eDingZhiDaZao
local actID=args[1]
local subid=args[2]
local data=activitiesModel:getSubActInfoData(actID,subType,subid)
if data==nil then return end
data.stepIndex=args[3]
data.type1=args[4]
data.type2=args[5]
data.stage=args[6]
data.color=args[7]
data.suitId=args[8]
data.jinglianlv=args[9]
data.attrLen=args[10]
data.attrList=args[11]
data.attrRefreshLen=args[12]
data.attrRefreshList=args[13]
data.attrRefineLen=args[14]
data.attrRefineList=args[15]
data.equipId=args[16]
data.free=args[17]
activitiesModel:setSubActInfoData(actID,subType,subid,data)
UIManager:invokeUIMethod("UISubAct_dzdzWin","refreshActivityData")
UIManager:invokeUIMethod("UISubAct_dzdzWin","refreshPanel")

reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end
