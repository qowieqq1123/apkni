






xianjie_HuZhuTypeFunc=
{
[6]={
getDesc=function(params)
local cfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,tonumber(params[1])or 1)
return FMT.fmt("训练{0}修士",cfg.name)
end,
checkQiuZhu=function()
return yunjiayingModel:checkHasQiuZhu()
end,
sendQiuZhu=function()
local flag,id=yunjiayingModel:checkHasQiuZhu()
local params={tostring(id)}
local pstr=jsonHelper.encode(params)
xianjieController.reqQiuZhu(speedUpType.eYunJiaYingTrain,speedUpMode.eAskHelp,pstr)
end,
},
[7]={
getDesc=function(params)
return"治疗受伤修士"
end,
checkQiuZhu=function()
return YuLingZhaiModel:checkHasQiuZhu()
end,
sendQiuZhu=function()
xianjieController.reqQiuZhu(speedUpType.eYuLingZhai,speedUpMode.eAskHelp,nil)
end,
},
[9]={
getDesc=function(params)
local cfg=cfgHelper.get2(cfg_technologyconfig_get,tonumber(params[1]),tonumber(params[2]))
local name=cfg.technology_name
return FMT.fmt("研究{0}",name)
end,
checkQiuZhu=function()
local state,icon,id=yandaotaiController:checkHudState()
if state==3 then
return xianjieModel:getIsCanQiuzhu(speedUpMode.eAskHelp,speedUpType.eYanDaoTai)
end
return false
end,
sendQiuZhu=function()
local state,icon,id=yandaotaiController:checkHudState()
local level=yandaotaiModel:getTechnologyListLevel(id)or 0
local params={tostring(id),tostring(level+1)}
local pstr=jsonHelper.encode(params)
xianjieController.reqQiuZhu(speedUpType.eYanDaoTai,speedUpMode.eAskHelp,pstr)
end,
}
}

function xianjieController:onAppStart_huzhu()
socketManager:register_receiver(20,91,xianjieController.recv_20_91)
socketManager:register_receiver(20,92,xianjieController.recv_20_92)
socketManager:register_receiver(20,93,xianjieController.recv_20_93)
socketManager:register_receiver(20,94,xianjieController.recv_20_94)
socketManager:register_receiver(20,95,xianjieController.recv_20_95)
socketManager:register_receiver(20,96,xianjieController.recv_20_96)
end


function xianjieController.reqCooperationList()
socketManager:send_20_91()
end





function xianjieController.reqQiuZhu(type1,type2,params)
if not xianmengModel:hasXM()then
UIManager.info('加入仙盟才可寻求盟友帮助')
return
end
socketManager:send_20_92(type2,type1,params or"")
end



function xianjieController.reqCooperation(guid)
socketManager:send_20_93(guid)
end


function xianjieController:reqHelpAll()
if not xianmengModel:hasXM()then
UIManager.info('加入仙盟才可帮助盟友')
return
end


if self.touchTime and timeHelper.getServerShortTime()<self.touchTime+2 then
return
end
self.touchTime=timeHelper.getServerShortTime()

local helpList={}
local list=xianjieModel:getCooperaionList()
for i,v in ipairs(list)do
local addTime,maxCount=YingXianGeModel:getReduceTimesData(v.actorid)
local isMax=v.times>=maxCount
local isSelfPlayer=playerModel:checkActorId(v.actorid)
local isHelp=xianjieModel:getIsHelp(v.guid)
if not isHelp and not isSelfPlayer and not isMax then
table.insert(helpList,v.guid)
end
end

if#helpList>0 then
socketManager:send_20_95(#helpList,helpList)
else
UIManager.info("暂无可帮助的盟友")
end
end









function xianjieController.recv_20_91(args)
local cooperaionlistlen=args[1]
local cooperaionList=args[2]
local helplistlen=args[3]
local helpList=args[4]
local len=args[5]
local limitList=args[6]
xianjieModel:setHuZhuList(cooperaionList,helpList,limitList)

UIManager:invokeUIMethod("UIYingXianGeXMHZWin","refresh")
UIManager:invokeUIMethod("UIMainBottomWin","freshHuZhuBtn")

notifySystem:postNotify(notifyConfig.onYingXianGe_XMHZChange)

YingXianGeController:refreshYXGHUD()
yunjiayingController:refreshYJYHUD()
YuLingZhaiController:refreshYLZHUD()
end






function xianjieController.recv_20_92(type1,type2,guid)
xianjieModel:setQiuZhuData(type1,type2,guid)
UIManager.info("成功向盟友发出求助")

yunjiayingController:refreshYJYHUD()
YuLingZhaiController:refreshYLZHUD()
UIManager:invokeUIMethod("UIYuLingZhaiWin","freshHuZhuBtn")
end




function xianjieController.recv_20_93(guid,ret,cooperation_earn)
local oldCooperationEarn=xianmengModel:getXMCooperationEarn()
xianmengModel:setXMCooperationEarn(cooperation_earn)
xianjieModel:setHuZhuState(guid,ret)

if ret==0 then
local addNum=cooperation_earn-oldCooperationEarn
if addNum>0 then
UIManager.info(FMT.fmt("祖师成功帮助盟友,仙盟功勋+{0}",addNum))
else
UIManager.info("祖师成功帮助盟友")
end

UIManager:invokeUIMethod("UIYingXianGeXMHZWin","refresh")
UIManager:invokeUIMethod("UIMainBottomWin","freshHuZhuBtn")
elseif ret==2 then
UIManager.info("求助已完成")

UIManager:invokeUIMethod("UIYingXianGeXMHZWin","refresh")
end
notifySystem:postNotify(notifyConfig.onYingXianGe_XMHZChange)
YingXianGeController:refreshYXGHUD()
end



function xianjieController.recv_20_94(cooperaionInfo)
local oldData=xianjieModel:getCooperaionDataByGuid(cooperaionInfo.guid)
xianjieModel:setHuZhuData(cooperaionInfo)

if oldData and cooperaionInfo.actorid~=0 and cooperaionInfo.actorid~=int64.zero then
local isSelfPlayer=playerModel:checkActorId(oldData.actorid)
if isSelfPlayer then
local _params={}
if oldData.params and oldData.params~=""then
_params=jsonHelper.decode(oldData.params)
end

local addTime,maxCount=YingXianGeModel:getReduceTimesData(oldData.actorid)
local times=math.min(maxCount,cooperaionInfo.times)
local desc=xianjie_HuZhuTypeFunc[oldData.type2]and xianjie_HuZhuTypeFunc[oldData.type2].getDesc(_params)or FMT.fmt("类型{0}",oldData.type2)
UIManager.info(FMT.fmt("盟友帮助祖师加快了{0}({1}/{2})",desc,times,maxCount))
end
end

UIManager:invokeUIMethod("UIYingXianGeXMHZWin","refresh")
UIManager:invokeUIMethod("UIYuLingZhaiWin","freshHuZhuBtn")
UIManager:invokeUIMethod("UIMainBottomWin","freshHuZhuBtn")
notifySystem:postNotify(notifyConfig.onYingXianGe_XMHZChange)
YingXianGeController:refreshYXGHUD()
end




function xianjieController.recv_20_95(guid_list_len,guid_list,cooperation_earn)
local oldCooperationEarn=xianmengModel:getXMCooperationEarn()
xianmengModel:setXMCooperationEarn(cooperation_earn)

if guid_list_len>0 then
for i,guid in ipairs(guid_list)do
xianjieModel:setHuZhuState(guid,0)
end

local addNum=cooperation_earn-oldCooperationEarn
if addNum>0 then
UIManager.info(FMT.fmt("祖师成功帮助盟友,仙盟功勋+{0}",addNum))
else
UIManager.info("祖师成功帮助盟友")
end

UIManager:invokeUIMethod("UIYingXianGeXMHZWin","refresh")
UIManager:invokeUIMethod("UIMainBottomWin","freshHuZhuBtn")
else
UIManager.info("求助已完成")
end
notifySystem:postNotify(notifyConfig.onYingXianGe_XMHZChange)
YingXianGeController:refreshYXGHUD()
end



function xianjieController.recv_20_96(len,cooperaionInfoList)
for i=1,len do
local cooperaionInfo=cooperaionInfoList[i]
local oldData=xianjieModel:getCooperaionDataByGuid(cooperaionInfo.guid)
xianjieModel:setHuZhuData(cooperaionInfo)

if oldData then
local isSelfPlayer=playerModel:checkActorId(oldData.actorid)
if isSelfPlayer then
local limit,maxLimit=xianjieModel:getHuZhuLimitTimes(oldData.type2)
if not maxLimit or limit<maxLimit then
local addTime,maxCount=YingXianGeModel:getReduceTimesData(oldData.actorid)
local times
if cooperaionInfo.actorid~=0 and cooperaionInfo.actorid~=int64.zero then
times=math.min(maxCount,cooperaionInfo.times)
else
times=maxCount
end
local _params={}
if oldData.params and oldData.params~=""then
_params=jsonHelper.decode(oldData.params)
end
local desc=xianjie_HuZhuTypeFunc[oldData.type2]and xianjie_HuZhuTypeFunc[oldData.type2].getDesc(_params)or FMT.fmt("类型{0}",oldData.type2)
UIManager.info(FMT.fmt("盟友帮助祖师加快了{0}({1}/{2})",desc,times,maxCount))
end
if maxLimit~=nil and limit<maxLimit then
xianjieModel:setAddHuZhuLimitTimes(oldData.type2,1)
end
end
end
end

UIManager:invokeUIMethod("UIYingXianGeXMHZWin","refresh")
UIManager:invokeUIMethod("UIYuLingZhaiWin","freshHuZhuBtn")
UIManager:invokeUIMethod("UIMainBottomWin","freshHuZhuBtn")
notifySystem:postNotify(notifyConfig.onYingXianGe_XMHZChange)
YingXianGeController:refreshYXGHUD()
end