function systemZongMenController:registerProtocol()
socketManager:register_receiver(26,1,self.do_protocol_26_1)
socketManager:register_receiver(26,2,self.do_protocol_26_2)
socketManager:register_receiver(26,3,self.do_protocol_26_3)
socketManager:register_receiver(26,4,self.do_protocol_26_4)
socketManager:register_receiver(26,5,self.do_protocol_26_5)
socketManager:register_receiver(26,6,self.do_protocol_26_6)
socketManager:register_receiver(26,7,self.do_protocol_26_7)
socketManager:register_receiver(26,8,self.do_protocol_26_8)
socketManager:register_receiver(26,9,self.do_protocol_26_9)
socketManager:register_receiver(26,10,self.do_protocol_26_10)
socketManager:register_receiver(26,11,self.do_protocol_26_11)
socketManager:register_receiver(26,12,self.do_protocol_26_12)
socketManager:register_receiver(26,13,self.do_protocol_26_13)
socketManager:register_receiver(26,14,self.do_protocol_26_14)
socketManager:register_receiver(26,15,self.do_protocol_26_15)
socketManager:register_receiver(26,16,self.do_protocol_26_16)
socketManager:register_receiver(26,17,self.do_protocol_26_17)
socketManager:register_receiver(26,100,self.do_protocol_26_100)
socketManager:register_receiver(26,101,self.do_protocol_26_101)

socketManager:register_receiver(26,18,self.do_protocol_26_18)
socketManager:register_receiver(26,20,self.do_protocol_26_20)
socketManager:register_receiver(26,21,self.do_protocol_26_21)
socketManager:register_receiver(26,22,self.do_protocol_26_22)
socketManager:register_receiver(26,23,self.do_protocol_26_23)
socketManager:register_receiver(26,24,self.do_protocol_26_24)
socketManager:register_receiver(26,25,self.do_protocol_26_25)
socketManager:register_receiver(26,26,self.do_protocol_26_26)
socketManager:register_receiver(26,27,self.do_protocol_26_27)
socketManager:register_receiver(26,28,self.do_protocol_26_28)
socketManager:register_receiver(26,29,self.do_protocol_26_29)
socketManager:register_receiver(26,30,self.do_protocol_26_30)

socketManager:register_receiver(26,31,self.do_protocol_26_31)
socketManager:register_receiver(26,32,self.do_protocol_26_32)
socketManager:register_receiver(26,33,self.do_protocol_26_33)
socketManager:register_receiver(26,34,self.do_protocol_26_34)
socketManager:register_receiver(26,35,self.do_protocol_26_35)
socketManager:register_receiver(26,36,self.do_protocol_26_36)
socketManager:register_receiver(26,37,self.do_protocol_26_37)
socketManager:register_receiver(26,38,self.do_protocol_26_38)
socketManager:register_receiver(26,39,self.do_protocol_26_39)
socketManager:register_receiver(26,40,self.do_protocol_26_40)
socketManager:register_receiver(26,41,self.do_protocol_26_41)
socketManager:register_receiver(26,42,self.do_protocol_26_42)
end




function systemZongMenController:req_infolist()
socketManager:send_26_1()
end


function systemZongMenController:req_detailInfoBase(serial)

socketManager:send_26_2(serial)
end


function systemZongMenController:req_detailInfoDZ(serial)

socketManager:send_26_3(serial)
end


function systemZongMenController:req_detailInfoBag(serial)

socketManager:send_26_4(serial)
end


function systemZongMenController:req_detailInfoCangJingGe(serial)

socketManager:send_26_5(serial)
end


function systemZongMenController:req_infiltrated(serial,discipleGuid)
socketManager:send_26_8(discipleGuid,serial)
end


function systemZongMenController:req_ransom(serial)
socketManager:send_26_11(serial)
end


function systemZongMenController:req_rumor(serial,discipleGuid)
socketManager:send_26_9(serial,discipleGuid)
end


function systemZongMenController:req_rubbing_start(serial)
socketManager:send_26_15(serial)
end


function systemZongMenController:req_rubbing_end(serial,life)
socketManager:send_26_16(serial,life<0 and 0 or life)
end


function systemZongMenController:req_detailInfo(partType,serial)
if partType==systemZongMenDetailDataPart.eBase then
socketManager:send_26_2(serial)
if not systemZongMenModel:checkDefenseInfo(serial)then
self:req_look_dazhen(serial)
end
elseif partType==systemZongMenDetailDataPart.eDZList then
socketManager:send_26_3(serial)
elseif partType==systemZongMenDetailDataPart.eBag then
socketManager:send_26_4(serial)
elseif partType==systemZongMenDetailDataPart.eCangJingGe then
socketManager:send_26_5(serial)
elseif partType==systemZongMenDetailDataPart.eTask then
socketManager:send_26_10(serial)
elseif partType==systemZongMenDetailDataPart.eShop then
socketManager:send_26_22(serial)
end
end


function systemZongMenController:req_giftInfo(serial)
socketManager:send_26_100(serial)
end


function systemZongMenController:req_gift(serial,items)
socketManager:send_26_101(serial,#items,items)
end

function systemZongMenController:req_task_accept(serial,taskId)
socketManager:send_26_18(serial,taskId)
end

function systemZongMenController:req_task_reward(serial,taskId)
socketManager:send_26_20(serial,taskId)
end


function systemZongMenController:req_renown_reward(serial,index)
socketManager:send_26_21(serial,index)
end


function systemZongMenController:req_buy_goods(serial,itemId,buyTimes)
socketManager:send_26_23(serial,itemId,buyTimes)
end


function systemZongMenController:req_outgoer_dataInfo(serial,discipleGuid)
socketManager:send_26_24(serial,discipleGuid)
end


function systemZongMenController:req_outgoer_detailInfo(serial,discipleGuid)
socketManager:send_26_25(serial,discipleGuid)
end


function systemZongMenController:req_outgoer_gift(serial,visitor,outgoer,itemGuid)
socketManager:send_26_26(serial,visitor,outgoer,itemGuid)
systemZongMenController:setOutgoerSceneDoing(1)
end


function systemZongMenController:req_outgoer_incite(serial,visitor,outgoer)
socketManager:send_26_27(serial,visitor,outgoer)
systemZongMenController:setOutgoerSceneDoing(2)
end


function systemZongMenController:req_outgoer_arrest(serial,visitors,outgoer)
socketManager:send_26_28(serial,#visitors,visitors,outgoer)
systemZongMenController:setOutgoerSceneDoing(3)
end


function systemZongMenController:req_attack(serial)
socketManager:send_26_31(serial)
end


function systemZongMenController:req_send_attackTeam(serial,team,commonFight)
socketManager:send_26_32(serial,#team,team,commonFight)
end


function systemZongMenController:req_attack_team(serial,teamIndex,mark)
if mark then
self:addAgainSend_26_33(serial,teamIndex)
end
socketManager:send_26_33(serial,teamIndex)
end


function systemZongMenController:req_deal_surrender(serial,dealType)
socketManager:send_26_34(serial,dealType)
end


function systemZongMenController:req_look_dazhen(serial)
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
local config=cfgHelper.get1(cfg_syssectconfig_get,infoData.id)
if config.type==1 then
socketManager:send_26_36(serial)
end
end
end


function systemZongMenController:req_destroy_dazhen(serial)
socketManager:send_26_37(serial)
end


function systemZongMenController:req_reward_vassal(len,serialList,is_assistant)
socketManager:send_26_39(len,serialList,is_assistant or 0)
end


function systemZongMenController:req_disciple_recruit(serial,discipleguid,deal_type)
socketManager:send_26_41(serial,discipleguid,deal_type)
end


function systemZongMenController:req_system_zongmen_permanent_vassal()
socketManager:send_26_42()
end





function systemZongMenController.do_protocol_26_1(args)

















local num=args[1]
local xtzmList=args[2]
local zy_num=args[3]
local ty_num=args[4]
local attack_num=args[5]
local attackList=args[6]
local attack_disciple_num=args[7]
local attackDiscipleList=args[8]
if systemZongMenModel.data==nil then return end
local isInWorld=worldController:isInWorld()
local worldId=worldModel.world
if isInWorld then
systemZongMenController:deleteWorldEntity(worldId)
systemZongMenController:deleteWorldOutgoerEntity(worldId)
end
worldTaskController:cancelAllFakeTask(worldId,eWorldUnitTpye.SYSTEMZM)

systemZongMenModel:initInfoList(num,xtzmList)
systemZongMenModel:setGlobalNum(systemZongMenFuncType.eZaoYao,zy_num)
systemZongMenModel:setGlobalNum(systemZongMenFuncType.eTaYin,ty_num)

systemZongMenModel:initBattleWaitResult(attackList,attackDiscipleList)

if systemZongMenModel:existAnyAttackInfo()and not systemZongMenModel:checkAttackWaitShow()then
if mainControl:isInScene(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then
self:createZongMenSceneEntity()
end
end

if isInWorld then
systemZongMenController:createWorldEntity(worldId)
systemZongMenController:createWorldOutgoerEntity(worldId)
end
worldTaskController:remakeFakeTask_SystemZongMen(worldId)

if mainControl:isInScene(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then
systemZongMenController:deleteZongMenSceneEntity()
systemZongMenController:createZongMenSceneEntity()
end

if initProControl.isDone()then
if not systemZongMenController:checkUpdateStop()then
systemZongMenController:startUpdateHandle()
else
systemZongMenController:stopUpdateHandle()
end
end

notifySystem:postNotify(notifyConfig.onSystemZMInit)
notifySystem:postNotify(notifyConfig.onSystemZMFunctionNumChange,systemZongMenFuncType.eZaoYao)
notifySystem:postNotify(notifyConfig.onSystemZMFunctionNumChange,systemZongMenFuncType.eTaYin)
end


function systemZongMenController.do_protocol_26_2(args)

if systemZongMenModel.data==nil then return end
local data={}
data.serial=args[1]
data.leader_name=args[2]
data.leader_id=args[3]
data.leader_jingjie=args[4]
data.leader_data=args[5]
data.leader_image=args[6]
data.firiend_num=args[7]
data.friendList=args[8]
data.enemy_num=args[9]
data.enemyList=args[10]

systemZongMenModel:initDetailInfo(systemZongMenDetailDataPart.eBase,data)
notifySystem:postNotify(notifyConfig.onSystemZMDetailInfo,systemZongMenDetailDataPart.eBase,data.serial)
end


function systemZongMenController.do_protocol_26_3(serial,num,discipleList)



if systemZongMenModel.data==nil then return end
local data={}
data.serial=serial
data.num=num
data.discipleList=discipleList
if num>0 then
for i,v in ipairs(data.discipleList)do
UIDiscipleController.changeDiscipleNetData(v)
end
end


systemZongMenModel:initDetailInfo(systemZongMenDetailDataPart.eDZList,data)
notifySystem:postNotify(notifyConfig.onSystemZMDetailInfo,systemZongMenDetailDataPart.eDZList,data.serial)
end


function systemZongMenController.do_protocol_26_4(serial,item_num,itemList,money_num,moneyList)





if systemZongMenModel.data==nil then return end
local data={}
data.serial=serial
data.item_num=item_num
data.itemList=itemList
data.money_num=money_num
data.moneyList=moneyList

systemZongMenModel:initDetailInfo(systemZongMenDetailDataPart.eBag,data)
notifySystem:postNotify(notifyConfig.onSystemZMDetailInfo,systemZongMenDetailDataPart.eBag,data.serial)
end


function systemZongMenController.do_protocol_26_5(serial,num,gongfaList)



if systemZongMenModel.data==nil then return end
local data={}
data.serial=serial
data.num=num
data.gongfaList=gongfaList or{}
table.sort(data.gongfaList,systemZongMenController.sortGongFaList)



systemZongMenModel:initDetailInfo(systemZongMenDetailDataPart.eCangJingGe,data)
notifySystem:postNotify(notifyConfig.onSystemZMDetailInfo,systemZongMenDetailDataPart.eCangJingGe,data.serial)
end


function systemZongMenController.do_protocol_26_6(serial,type,param,param2)


if systemZongMenModel.data==nil then return end
local infoData=systemZongMenModel:getInfoData(serial)
if infoData==nil then return end

local oldVal
if type==systemZongMenInfoUpdateType.eLevel then
oldVal=infoData.level
infoData.level=param
systemZongMenController:updateEntityModel(serial,oldVal,param)
elseif type==systemZongMenInfoUpdateType.eRelation then
oldVal=infoData.relation_num
infoData.relation_num=param

if oldVal~=param then
local check=false
if param==systemZongMenRelationType.eDiDui then
systemZongMenModel:addALetter(serial,systemZongMenRelationLetterType.eDeclareWar)
check=true
elseif oldVal==systemZongMenRelationType.eDiDui then
systemZongMenModel:addALetter(serial,systemZongMenRelationLetterType.eArmistice)
check=true
end
notifySystem:postNotify(notifyConfig.onSystemZMLetterChange,true)
end
elseif type==systemZongMenInfoUpdateType.eFightFlag then
if not systemZongMenModel:isFightingAboutFlag(param)then
systemZongMenModel:deleteDefenseInfo(infoData.serial)
systemZongMenModel:deleteAttackInfo(infoData.serial)
end

systemZongMenController:changeSystemZongMenFlag(infoData,param)
elseif type==systemZongMenInfoUpdateType.eHateWarn then
systemZongMenModel:addALetter(serial,systemZongMenRelationLetterType.eWarning)
notifySystem:postNotify(notifyConfig.onSystemZMLetterChange,true)

elseif type==systemZongMenInfoUpdateType.eXJxuanshang then

infoData.xs_level=param
infoData.xs_exp=param2
end

notifySystem:postNotify(notifyConfig.onSystemZMInfoChange,serial,type,oldVal,param)
end


function systemZongMenController.do_protocol_26_7(serial)
if systemZongMenModel.data==nil then return end

local infoData=systemZongMenModel:getInfoData(serial)
local isSurrender=false
if infoData then
isSurrender=infoData.flag==systemZongMenFightFlagType.eSurrender
local config=cfgHelper.get1(cfg_syssectconfig_get,infoData.id)
if config.firstTaskId then
local taskCfg=cfgHelper.get1(cfg_taskconfig_get,config.firstTaskId)
taskModel:removeTask(taskCfg.tasklineid)
end
end

systemZongMenModel:deleteZongMen(serial)
local outgoers=systemZongMenModel:deleteOutgoerDataBySerial(serial)

if worldController:isInWorld()then
systemZongMenController:deleteEntity(serial)
for i,v in ipairs(outgoers)do
systemZongMenController:deleteOutgoerEntity(v.discipleguid)
end
end

notifySystem:postNotify(notifyConfig.onSystemZMDelete,serial)
if isSurrender then
notifySystem:postNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,SYSTEM_DEFINE.eXiTongZongMen)
end
end


function systemZongMenController.do_protocol_26_8(discipleGuid,serial)
if systemZongMenModel.data==nil then return end
local data=systemZongMenModel:getInfoData(serial)
if data then
local oldVal=data.disciple_guid
data.disciple_guid=discipleGuid
notifySystem:postNotify(notifyConfig.onSystemZMDiscipleChange,serial,discipleGuid,oldVal)
end
end


function systemZongMenController.do_protocol_26_11(serial)
if systemZongMenModel.data==nil then return end
local data=systemZongMenModel:getInfoData(serial)
if data then
local oldVal=data.disciple_guid
data.disciple_guid=int64.zero
notifySystem:postNotify(notifyConfig.onSystemZMDiscipleChange,serial,int64.zero,oldVal)
end
end


function systemZongMenController.do_protocol_26_12(serial,discipleGuid)
if systemZongMenModel.data==nil then return end
local data=systemZongMenModel:getInfoData(serial)
if data then
local oldVal=data.disciple_guid
data.disciple_guid=int64.zero
notifySystem:postNotify(notifyConfig.onSystemZMDiscipleChange,serial,int64.zero,oldVal)
end
end


function systemZongMenController.do_protocol_26_9(args)
if systemZongMenModel.data==nil then return end
local result=args[1]
local serial=args[2]
local disciple_guid=args[3]
local sub_num=args[4]
local num=args[5]
local subList=args[6]
local detailData=systemZongMenModel:getDetailPartInfo(serial,systemZongMenDetailDataPart.eDZList)
if detailData then
if num>0 then
local list={}
if detailData.num>0 then
for i,v in ipairs(subList)do
for j,w in ipairs(detailData.discipleList)do
if v.param_1==w.discipleguid then
w.loyalty=math.max(w.loyalty-v.param_2,0)
table.insert(list,v.param_1)
end
end
end
notifySystem:postNotify(notifyConfig.onSystemZMLoyaltyChange,serial,list)
end
end
end

local num=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eZaoYao)
systemZongMenModel:setGlobalNum(systemZongMenFuncType.eZaoYao,num+1)
notifySystem:postNotify(notifyConfig.onSystemZMFunctionNumChange,systemZongMenFuncType.eZaoYao)

local infoData=systemZongMenModel:getInfoData(serial)
local data={
funcType=systemZongMenFuncType.eZaoYao,
result=result,
serial=serial,
datas={
sub_num=sub_num,
num=num,
subList=subList,
target=disciple_guid,
source=infoData.disciple_guid,
},
}
systemZongMenModel:pushOtherResultData(data)
if result==0 then
notifySystem:postNotify(notifyConfig.onSystemZMFunctionResult,serial)
else
systemZongMenController:startCatchResultPrize()
showDiscipleChangeResultModel:onInsertClientStart()

end
end


function systemZongMenController.do_protocol_26_10(serial,taskId)
if systemZongMenModel.data==nil then return end
local data={
serial=serial,
taskId=taskId,
}
systemZongMenModel:initDetailInfo(systemZongMenDetailDataPart.eTask,data)
systemZongMenModel:checkNextTask(serial,taskId)
notifySystem:postNotify(notifyConfig.onSystemZMDetailInfo,systemZongMenDetailDataPart.eTask,data.serial)
end


function systemZongMenController.do_protocol_26_13(serial)
if systemZongMenModel.data==nil then return end
systemZongMenController:endCatchResultPrize()
UIManager.enableMoneyTips(true)
showDiscipleChangeResultModel:onInsertClientEnd({effecttype=ePrizeType.eCommonClient})
notifySystem:postNotify(notifyConfig.onSystemZMFunctionResult,serial)
end


function systemZongMenController.do_protocol_26_100(serial,num)
if systemZongMenModel.data==nil then return end
systemZongMenModel:setGiftCount(serial,num)
notifySystem:postNotify(notifyConfig.onSystemZMGiftNum,serial,num)

end


function systemZongMenController.do_protocol_26_101(args)
if systemZongMenModel.data==nil then return end
local serial=args[1]
local itemLen=args[2]
local itemList=args[3]
local relationDelta=args[4]
local gxNum=args[5]
local isBack=args[6]
local num=systemZongMenModel:getGiftCount(serial)
systemZongMenModel:setGiftCount(serial,num+1)
notifySystem:postNotify(notifyConfig.onSystemZMGiftNum,serial,num)

UIManager:invokeUIMethod("UISystemZongMenGiftWin","afterGift",serial,relationDelta,itemList,gxNum,isBack)
end


function systemZongMenController.do_protocol_26_14(infoData)
if systemZongMenModel.data==nil then return end

systemZongMenModel:addInfoData(infoData)

if worldController:isInWorld()and worldModel.world==infoData.worldId then
if worldBlockModel:checkBlockState(infoData.worldId,infoData.blockId,eWorldBlockState.OPEN)then
systemZongMenController:createEntity(infoData)

if infoData.yl_num>0 then
for i,v in ipairs(infoData.ylList)do
local data=systemZongMenModel:getOutgoerData(v.discipleguid)
systemZongMenController:createOutgoerEntity(data)
end
end
end
end

notifySystem:postNotify(notifyConfig.onSystemZMAdd,infoData.serial)
if infoData.flag==systemZongMenFightFlagType.eSurrender then
notifySystem:postNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,SYSTEM_DEFINE.eXiTongZongMen)
end
end


function systemZongMenController.do_protocol_26_15(serial)
if systemZongMenModel.data==nil then return end
local infoData=systemZongMenModel:getInfoData(serial)
infoData.tayin=1
notifySystem:postNotify(notifyConfig.onSystemZMTaYinChange,1,serial)

local num=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eTaYin)
systemZongMenModel:setGlobalNum(systemZongMenFuncType.eTaYin,num+1)
notifySystem:postNotify(notifyConfig.onSystemZMFunctionNumChange,systemZongMenFuncType.eTaYin)


end


function systemZongMenController.do_protocol_26_16(serial,result,sub_num)
if systemZongMenModel.data==nil then return end
local infoData=systemZongMenModel:getInfoData(serial)
infoData.tayin=0
notifySystem:postNotify(notifyConfig.onSystemZMTaYinChange,0,serial)

local data={
funcType=systemZongMenFuncType.eTaYin,
result=result,
serial=serial,
datas={
sub_num=sub_num,
source=infoData.disciple_guid,
},
}
systemZongMenModel:pushOtherResultData(data)
systemZongMenController:startCatchResultPrize()
showDiscipleChangeResultModel:onInsertClientStart()
UIManager.enableMoneyTips(false)
end


function systemZongMenController.do_protocol_26_17(serial,money_type,val)
local infoData=systemZongMenModel:getInfoData(serial)
local oldVal=infoData.moneyLookup[money_type]

local limitCfg=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"sect_money_limit",money_type)
val=Mathf.Clamp(val,limitCfg[1],limitCfg[2])

infoData.moneyLookup[money_type]=val
for i,v in ipairs(infoData.moneyList)do
if v[1]==money_type then
infoData.moneyList[i][2]=val
end
end
notifySystem:postNotify(notifyConfig.onSystemZMMoneyNumChange,serial,money_type,val,oldVal)

if money_type==systemZongMenInfoMoneyType.eShengWang then
local oldIndex=systemZongMenModel:getRenownIndex(infoData.id,oldVal)
local newIndex=systemZongMenModel:getRenownIndex(infoData.id,val)
if oldIndex~=newIndex then
notifySystem:postNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,SYSTEM_DEFINE.eXiTongZongMen)
end
end

if not systemZongMenController:isOutgoerSceneDoing()then
local zmName=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
systemZongMenController:showMoneyNotify(zmName,money_type,val-oldVal)
end
end


function systemZongMenController.do_protocol_26_22(args)









if systemZongMenModel.data==nil then return end
local serial=args[1]
local list={}
for i=1,4 do
if args[i*2]>0 then
for i,v in ipairs(args[i*2+1])do
list[v.param_1]=v.param_2
end
end
end
local data={
serial=serial,
list=list,
}
systemZongMenModel:initDetailInfo(systemZongMenDetailDataPart.eShop,data)
notifySystem:postNotify(notifyConfig.onSystemZMDetailInfo,systemZongMenDetailDataPart.eShop,serial)
end


function systemZongMenController.do_protocol_26_23(serial,itemId,buyTimes)
if systemZongMenModel.data==nil then return end
local detailData=systemZongMenModel:getDetailPartInfo(serial,systemZongMenDetailDataPart.eShop)
if detailData then
local oldTimes=detailData.list[itemId]or 0
local newTimes=oldTimes+buyTimes
detailData.list[itemId]=newTimes
notifySystem:postNotify(notifyConfig.onSystemZMShopBuyNumChange,serial,itemId,newTimes,oldTimes)
end
end


function systemZongMenController.do_protocol_26_24(args)
if systemZongMenModel.data==nil then return end
if systemZongMenController:isSameOutgoerSceneInfo_OutgoerData(args[1],args[2])then
systemZongMenModel:setOutgoerFuncData(args)
notifySystem:postNotify(notifyConfig.onSystemZMOutgoerDataInfo)
end
end


function systemZongMenController.do_protocol_26_25(serial,discipleStruct)
if systemZongMenModel.data==nil then return end
if systemZongMenModel:isSameOutgoerFuncData(serial,discipleStruct.discipleguid)then
UIDiscipleController.changeDiscipleNetData(discipleStruct)
local args={}
args.dis_guid=discipleStruct.discipleguid
args.dislist={discipleStruct}
UIManager:invokeUIMethod('UISystemZongMenOutgoerInteractWin','showWindow','UIOtherDiscipleMainWin_SystemZongMen',args)
end
end


function systemZongMenController.do_protocol_26_26(serial,discipleguid,sub_loyalty,reGift)
if systemZongMenModel.data==nil then return end
if systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then
local funcData=systemZongMenModel:getOutgoerFuncData()
funcData.gift_num=funcData.gift_num+1
notifySystem:postNotify(notifyConfig.onSystemZMOutgoerFuncDataTimes,1)
local oldLoyalty=funcData.loyalty
funcData.loyalty=math.max(0,funcData.loyalty-sub_loyalty)
local loyaltyChange=funcData.loyalty-oldLoyalty
notifySystem:postNotify(notifyConfig.onSystemZMOutgoerFuncDataLoyalty,serial,discipleguid,loyaltyChange)

local outgoer=systemZongMenModel:getOutgoerData(discipleguid)
local time=3
local zmData=systemZongMenModel:getInfoData(serial)
local zmCfg=cfgHelper.get1(cfg_syssectconfig_get,zmData.id)
local zlCfg=cfgHelper.get1(cfg_syssectzlconfig_get,zmCfg.zlid)
local haveRegift=reGift==1
local word=haveRegift and zlCfg.backSay or zlCfg.notBackSay
word=word[math.random(1,#word)]
if haveRegift then
local prizeList=systemZongMenModel:getTempRewards()or{}

local args={
discipledata=outgoer.discipledata,
discipleimage=outgoer.discipleimage,
disciplename=outgoer.disciplename,
talkcontent=word,
callback=function()
if not systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then return end
if#prizeList>0 then
showPrizeControl.showWindow(prizeList,function()
if not systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then return end
systemZongMenController:setOutgoerSceneDoing()
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","closeWindow","UISystemZongMenDiscipleTalkWin")
systemZongMenController:showOutgoerLoyaltyNotify(outgoer.disciplename,loyaltyChange)
systemZongMenController:checkCloseSceneWhenAnimationFinish(serial)
end)
else
systemZongMenController:setOutgoerSceneDoing()
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","closeWindow","UISystemZongMenDiscipleTalkWin")
systemZongMenController:showOutgoerLoyaltyNotify(outgoer.disciplename,loyaltyChange)
systemZongMenController:checkCloseSceneWhenAnimationFinish(serial)
end
end,
}
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","showWindow","UISystemZongMenDiscipleTalkWin",args)
systemZongMenModel:clearTempRewards()
else
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","showTalk",outgoer.flip,word,time,function()
if not systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then return end
systemZongMenController:setOutgoerSceneDoing()
systemZongMenController:showOutgoerLoyaltyNotify(outgoer.disciplename,loyaltyChange)
systemZongMenController:checkCloseSceneWhenAnimationFinish(serial)
end)
end
systemZongMenController:setOutgoerSceneDoResult({outgoer.disciplename,loyaltyChange})
end
end


function systemZongMenController.do_protocol_26_27(serial,discipleguid,result,renown,loyalty)
if systemZongMenModel.data==nil then return end
if systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then
local funcData=systemZongMenModel:getOutgoerFuncData()
funcData.incite_num=funcData.incite_num+1
notifySystem:postNotify(notifyConfig.onSystemZMOutgoerFuncDataTimes,2)

local time=3
local outgoer=systemZongMenModel:getOutgoerData(discipleguid)
local zmData=systemZongMenModel:getInfoData(serial)
local zmName=systemZongMenModel:getNameStr(zmData.id,zmData.nameIdx)
local zmCfg=cfgHelper.get1(cfg_syssectconfig_get,zmData.id)
local cfCfg=cfgHelper.get1(cfg_syssectcfconfig_get,zmCfg.cfid)
local func=nil
local loyaltyChange=0
local renownChange=0

if renown>0 then
local infoData=systemZongMenModel:getInfoData(serial)
local oldVal=infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local money_limit=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"sect_money_limit",systemZongMenInfoMoneyType.eShengWang)
local newVal=Mathf.Clamp(oldVal-renown,money_limit[1],money_limit[2])
renownChange=newVal-oldVal
systemZongMenController.do_protocol_26_17(serial,systemZongMenInfoMoneyType.eShengWang,newVal)
end


if result==0 then
local prizeList=systemZongMenModel:getTempRewards()or{}
local giftFunc=nil
if#prizeList>0 then
local word=cfCfg.giftSay
word=word[math.random(1,#word)]
giftFunc=function()
local args={
discipledata=outgoer.discipledata,
discipleimage=outgoer.discipleimage,
disciplename=outgoer.disciplename,
talkcontent=word,
callback=function()
if not systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then return end
showPrizeControl.showWindow(prizeList,function()
systemZongMenController:setOutgoerSceneDoing()
systemZongMenController:exitOutgoerScene(true)
local mesgContent=cfgHelper.getlang("systemzongmen_incite_success")
local mesg=FMT.fmt(mesgContent,outgoer.disciplename,zmName)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
systemZongMenController:showMoneyNotify(zmName,systemZongMenInfoMoneyType.eShengWang,renownChange)
end)
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","closeWindow","UISystemZongMenDiscipleTalkWin")
end,
}
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","showWindow","UISystemZongMenDiscipleTalkWin",args)
end
end
systemZongMenModel:clearTempRewards()

func=function()
if not systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then return end
local word=cfCfg.succsay[math.random(1,#cfCfg.succsay)]
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","showTalk",outgoer.flip,word,3,function()
if not systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then return end
local callback=function()
if not systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then return end
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","closeWindow","UIWorldShowDiscipleWin")
if giftFunc then
giftFunc()
else
systemZongMenController:setOutgoerSceneDoing()
systemZongMenController:exitOutgoerScene(true)
local mesgContent=cfgHelper.getlang("systemzongmen_incite_success")
local mesg=FMT.fmt(mesgContent,outgoer.disciplename,zmName)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
systemZongMenController:showMoneyNotify(zmName,systemZongMenInfoMoneyType.eShengWang,renownChange)
end
end
local viewArgs={
disciple=discipleguid,
callback=callback,
isFullOpen=false,
}
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","showWindow","UIItemRecruitDiscipleWin",viewArgs)
end)
end

systemZongMenModel:deleteOutgoerData(discipleguid)
systemZongMenController:deleteOutgoerEntity(discipleguid)
notifySystem:postNotify(notifyConfig.onSystemZMOutgoerDataDelete,{discipleguid},1)

systemZongMenModel:deleteDefenseInfo(serial)
notifySystem:postNotify(notifyConfig.onSystemZMDefenseInfoServerChange,serial)









else
local word=cfCfg.failsay[math.random(1,#cfCfg.failsay)]

if loyalty>0 then
local oldLoyalty=funcData.loyalty
funcData.loyalty=math.min(oldLoyalty+loyalty,100)
loyaltyChange=funcData.loyalty-oldLoyalty
notifySystem:postNotify(notifyConfig.onSystemZMOutgoerFuncDataLoyalty,serial,discipleguid,loyalty)
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","setLoyalty",oldLoyalty)
end

func=function()
if not systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then return end
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","showTalk",outgoer.flip,word,3,function()
if not systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then return end
systemZongMenController:setOutgoerSceneDoing()
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","refreshLoyalty")
systemZongMenController:showOutgoerLoyaltyNotify(outgoer.disciplename,loyaltyChange)
systemZongMenController:showMoneyNotify(zmName,systemZongMenInfoMoneyType.eShengWang,renownChange)

local mesgContent=cfgHelper.getlang("systemzongmen_incite_failure")
local mesg=FMT.fmt(mesgContent,outgoer.disciplename,zmName)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)

systemZongMenController:checkCloseSceneWhenAnimationFinish(serial)
end)
end
end
UIManager:invokeUIMethod("UISystemZongMenOutgoerInteractWin","beginThink",time,func,nil)
systemZongMenController:setOutgoerSceneEntity_Emot(true,34,time)
systemZongMenController:setOutgoerSceneEntity_Expression(true,11,time)
systemZongMenController:setOutgoerSceneDoResult({result==0,zmName,outgoer.disciplename,loyaltyChange,renownChange})
end
end


function systemZongMenController.do_protocol_26_28(args)
if systemZongMenModel.data==nil then return end
local serial=args[1]
local len=args[2]
local list=args[3]
local discipleguid=args[4]
local result=args[5]
local renown=args[6]
if systemZongMenModel:isSameOutgoerFuncData(serial,discipleguid)then
local funcData=systemZongMenModel:getOutgoerFuncData()
local outgoer=systemZongMenModel:getOutgoerData(discipleguid)
local zmData=systemZongMenModel:getInfoData(serial)
local zmName=systemZongMenModel:getNameStr(zmData.id,zmData.nameIdx)
funcData.arrest_num=funcData.arrest_num+1
notifySystem:postNotify(notifyConfig.onSystemZMOutgoerFuncDataTimes,3)
local renownChange=0
if result==0 then



systemZongMenModel:deleteDefenseInfo(serial)
notifySystem:postNotify(notifyConfig.onSystemZMDefenseInfoServerChange,serial)
else
if renown>0 then
local infoData=systemZongMenModel:getInfoData(serial)
local oldVal=infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local money_limit=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"sect_money_limit",systemZongMenInfoMoneyType.eShengWang)
local newVal=Mathf.Clamp(oldVal-renown,money_limit[1],money_limit[2])
renownChange=newVal-oldVal
systemZongMenController.do_protocol_26_17(serial,systemZongMenInfoMoneyType.eShengWang,newVal)
end





end
systemZongMenModel:deleteOutgoerData(discipleguid)
systemZongMenController:deleteOutgoerEntity(discipleguid)
notifySystem:postNotify(notifyConfig.onSystemZMOutgoerDataDelete,{discipleguid},1)
UIPrisonControl:reqPrisonData()
systemZongMenController:setOutgoerSceneDoResult({result,zmName,outgoer.disciplename,renownChange})
systemZongMenController:showOutgoerSceneArrestAnimation(serial,discipleguid,list,result)
end
end

function systemZongMenController.do_protocol_26_29(serial,renown,discipleShow)
if systemZongMenModel.data==nil then return end
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
if renown>0 then
local oldVal=infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
systemZongMenController.do_protocol_26_17(serial,systemZongMenInfoMoneyType.eShengWang,oldVal-renown)
end
local zmName=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
local mesgContent=cfgHelper.getlang("systemzongmen_arrest_failure_exposure")
local mesg=FMT.fmt(mesgContent,zmName,discipleShow.disciplename)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)















systemZongMenModel:clearTempRewards()
end
end

function systemZongMenController.do_protocol_26_30(num,list)
if systemZongMenModel.data==nil then return end
if not initProControl.isDone()then return end

local isInWorld=worldController:isInWorld()
if isInWorld then
systemZongMenController:deleteWorldOutgoerEntity(worldModel.world)
end

systemZongMenController:exitOutgoerScene(true)
systemZongMenModel:clearOutgoerData()

worldPositionLibrary:checkDataEx(eWorldUnitTpye.SYSTEMZM_OUTGOER,{})

if num>0 then
for i,v in ipairs(list)do
systemZongMenModel:setOutgoerDatasEx(v)
end
end

if isInWorld then
systemZongMenController:createWorldOutgoerEntity(worldModel.world)
end

UIManager.info("系统宗门外出弟子已刷新")

notifySystem:postNotify(notifyConfig.onSystemZMOutgoerDataRefresh)
end


function systemZongMenController.do_protocol_26_18(serial,taskId)
if systemZongMenModel.data==nil then return end

taskController.do_protocol_7_22(taskId,0)
UIManager.info('已接取委托')
end


function systemZongMenController.do_protocol_26_20(serial,taskId)
if systemZongMenModel.data==nil then return end
local detailData=systemZongMenModel:getDetailPartInfo(serial,systemZongMenDetailDataPart.eTask)
if detailData then
detailData.taskId=taskId
end

taskController.do_protocol_7_23(taskId,1,0)




end


function systemZongMenController.do_protocol_26_21(serial,idx)
if systemZongMenModel.data==nil then return end
local infoData=systemZongMenModel:getInfoData(serial)
local oIdx=infoData.sw_reward
infoData.sw_reward=idx
notifySystem:postNotify(notifyConfig.onSystemZMRenownRewardFlag,serial,idx,oIdx)
notifySystem:postNotify(notifyConfig.on_UIWorldUnitListWin2_reddotChange,SYSTEM_DEFINE.eXiTongZongMen)
end


function systemZongMenController.do_protocol_26_31(serial)
if systemZongMenModel.data==nil then return end
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then

if infoData.relation_num~=systemZongMenRelationType.eDiDui then
local oldRelation=infoData.relation_num
infoData.relation_num=systemZongMenRelationType.eDiDui
notifySystem:postNotify(notifyConfig.onSystemZMInfoChange,serial,systemZongMenInfoUpdateType.eRelation,oldRelation,infoData.relation_num)
end

systemZongMenController:changeSystemZongMenFlag(infoData,systemZongMenFightFlagType.eBeAttacked)
end
end


function systemZongMenController.do_protocol_26_32(serial,teamIndex)
if systemZongMenModel.data==nil then return end
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
local nowTime=timeHelper.getServerShortTime()
local timeStamp=nowTime+cfgHelper.get3(cfg_syssectbaseconfig_get,1,"teamMoveTime",1)
systemZongMenModel:addBattleWaitResult(serial,teamIndex,timeStamp,nowTime)


local dzList={}
for i=1,fightPreSelectModel.maxPosNum do
table.insert(dzList,int64.zero)
end
worldTaskController:newFakeTask(eWorldUnitTpye.SYSTEMZM,serial,teamIndex,dzList)

if worldController:isInWorld()and worldModel:isSameWorld(infoData.worldId)then
worldController:lookAtCity(infoData.worldId,infoData.blockId)
end
UIManager.info("弟子队伍已出征")

systemZongMenController:startUpdateHandle()

notifySystem:postNotify(notifyConfig.onSystemZMFightWaitResultNew,serial,teamIndex)
end
end


function systemZongMenController.do_protocol_26_33(serial,teamIndex)
if systemZongMenModel.data==nil then return end
systemZongMenController:removeAgainSend_26_33(serial,teamIndex)
end


function systemZongMenController.do_protocol_26_34(serial,dealType,discipleLen,discipleList)
if systemZongMenModel.data==nil then return end
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
local newFlag=dealType==1 and systemZongMenFightFlagType.eVassal or systemZongMenFightFlagType.eExpel
systemZongMenController:changeSystemZongMenFlag(infoData,newFlag)
local rewards=systemZongMenModel:getTempRewards()
notifySystem:postNotify(notifyConfig.onSystemZMSurrenderHanlde,serial,newFlag,discipleList,rewards)
if rewards then
systemZongMenModel:clearTempRewards()
end
end
if dealType==2 then
XianjieXuanShangModel:clearXJXStaskidbyGuid(serial)
end
end


function systemZongMenController.do_protocol_26_35(serial)
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then

local haveNew=systemZongMenModel:addFinishWarReport(serial,fightResultType.Lose)

systemZongMenController:changeSystemZongMenFlag(infoData,systemZongMenFightFlagType.eNone,0)

if haveNew then
notifySystem:postNotify(notifyConfig.onSystemZMFightRecordNew)
end

local mesgContent=cfgHelper.getlang("systemZongMen_JianWen_WarDefeat")
local mesg=FMT.fmt(mesgContent,systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx))
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
end
end


function systemZongMenController.do_protocol_26_36(serial,hdValue,discipleLen,discipleList)
if systemZongMenModel.data==nil then return end
systemZongMenModel:setDefenseInfo(serial,hdValue,discipleList)
notifySystem:postNotify(notifyConfig.onSystemZMDefenseInfo,serial)
end




function systemZongMenController.do_protocol_26_37(serial,result,delta,wounded)
if systemZongMenModel.data==nil then return end
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then

if result==1 then
local info=systemZongMenModel:getDefenseInfo(serial)
if info then
local oldVal=info.value
info.value=math.max(oldVal-delta,0)
delta=oldVal-info.value
end
local mesgContent=cfgHelper.getlang("systemZongMen_JianWen_DestroyDaZhenSuccess")
local mesg=FMT.fmt(mesgContent,systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx),UIDiscipleModel:getDiscipleName(infoData.disciple_guid),delta)
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)

else
if delta>0 then
local infoData=systemZongMenModel:getInfoData(serial)
local oldVal=infoData.moneyLookup[systemZongMenInfoMoneyType.eShengWang]
local money_limit=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"sect_money_limit",systemZongMenInfoMoneyType.eShengWang)
local newVal=Mathf.Clamp(oldVal-delta,money_limit[1],money_limit[2])
systemZongMenController.do_protocol_26_17(serial,systemZongMenInfoMoneyType.eShengWang,newVal)
end

local mesgContent=cfgHelper.getlang("systemZongMen_JianWen_DestroyDaZhenFailure")
local mesg=FMT.fmt(mesgContent,systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx),UIDiscipleModel:getDiscipleName(infoData.disciple_guid))
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
end

if wounded>0 then
local oldInjury=UIDiscipleModel:getDiscipleInjury(infoData.disciple_guid)
local injury=oldInjury+wounded
UIDiscipleController.do_protocol_2_7(infoData.disciple_guid,injury)
end

notifySystem:postNotify(notifyConfig.onSystemZMDestroyDZResult,serial,result,delta,wounded)
end
end


function systemZongMenController.do_protocol_26_38(serial,discipleLen,discipleList)
if systemZongMenModel.data==nil then return end
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
systemZongMenModel:setAttackInfo(serial,discipleLen,discipleList)
if systemZongMenModel:checkAttackWaitShow()then
systemZongMenController:startUpdateHandle()
elseif systemZongMenModel:existAnyAttackInfo()then
if mainControl:isInScene(eSceneType.eZongmen)and isometricMapSystem:IsInHome()then
self:createZongMenSceneEntity()
end
end
systemZongMenController:changeSystemZongMenFlag(infoData,systemZongMenFightFlagType.eAttacking)


local mesgContent=cfgHelper.getlang("systemZongMen_JianWen_BeAttacked")
local mesg=FMT.fmt(mesgContent,systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx))
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
end
end


function systemZongMenController.do_protocol_26_39(num,serialList,is_assistant)
if systemZongMenModel.data==nil then return end

for index=1,num do
local serial=serialList[index]
local infoData=systemZongMenModel:getInfoData(serial)
if infoData then
local oldNum=infoData.sg_reward_num
infoData.sg_reward_num=0
notifySystem:postNotify(notifyConfig.onSystemZMVassalRewardChange,serial,oldNum,infoData.sg_reward_num)
end
end
if is_assistant~=1 then
local temp=systemZongMenModel:getTempRewards()
showPrizeControl.showWindow(temp)
end
end


function systemZongMenController.do_protocol_26_40(args)
if systemZongMenModel.data==nil then return end

local result=args[1]
local fightlistlen=args[2]
local fightList=args[3]
local serial=args[4]
local teamIndex=args[5]
local discipleguid=args[6]




if mathHelper.validInt64(discipleguid)then
UIPrisonControl:addSkipDropShow(discipleguid,serial)
end

local reports={}
for i,v in ipairs(fightList)do
reports[i]=v.param_2
end
local infoData=systemZongMenModel:getInfoData(serial)
if infoData==nil then return loggerUtil.logErrFMT("没有对应战斗内容的系统宗门:{0}",serial)end

local rewards={}
if teamIndex==0 then
if result==1 then
rewards=systemZongMenModel:getTempRewards2()or rewards
else
rewards=systemZongMenModel:getTempRewards()or rewards
end
elseif teamIndex>0 then
rewards=systemZongMenModel:getTempRewards()or rewards
end
local data=systemZongMenModel:deleteBattleWaitResult(serial,teamIndex)
local newReport=nil
if data then
newReport=systemZongMenModel:addBattleResultReport(data,result,reports,rewards)
end

systemZongMenController:pushBattleResultNotify(serial,teamIndex,result,reports,discipleguid,rewards)

if teamIndex==0 then
systemZongMenController:changeSystemZongMenFlag(infoData,systemZongMenFightFlagType.eNone,0)
if result~=fightResultType.Victory then
systemZongMenModel:deleteDefenseInfo(serial)
notifySystem:postNotify(notifyConfig.onSystemZMDefenseInfoServerChange,serial)
end
else
if result==fightResultType.Victory then
systemZongMenController:changeSystemZongMenFlag(infoData,systemZongMenFightFlagType.eSurrender)

local mesgContent=cfgHelper.getlang("systemZongMen_JianWen_WarVictory")
local infoData=systemZongMenModel:getInfoData(serial)
local mesg=FMT.fmt(mesgContent,systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx))
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
else

local mesgContent=cfgHelper.getlang("systemZongMen_JianWen_BattleDefeat")
local infoData=systemZongMenModel:getInfoData(serial)
local mesg=FMT.fmt(mesgContent,systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx))
chatControl.reqSystemMesg(CHAT_MSG_TYPE.eNoFitler,{CHAT_CHANNNEL.eJianwen},mesg)
end

systemZongMenModel:deleteDefenseInfo(serial)
notifySystem:postNotify(notifyConfig.onSystemZMDefenseInfoServerChange,serial)
end

systemZongMenModel:clearTempRewards()

if newReport then
notifySystem:postNotify(notifyConfig.onSystemZMFightRecordNew)
end
end


function systemZongMenController.do_protocol_26_41(serial,discipleguid,deal_type)
if systemZongMenModel.data==nil then return end
notifySystem:postNotify(notifyConfig.onSystemZMExpelDiscipleHandle,serial,discipleguid,deal_type)
end



function systemZongMenController.do_protocol_26_42()
local infoList=systemZongmenRelationModel:getWillChangeZm()

for index,info in ipairs(infoList)do
systemZongMenModel:addALetter(info.serial,systemZongMenRelationLetterType.eArmistice)
end



UIManager:invokeUIMethod("UIFuncStorageWin","refreshSystemZongMenLetterBtn")
UIManager:invokeUIMethod('UIBuildingMsgWin','showMsg',zmMsgType.zmRelationPlot,true)

systemZongmenRelationController:finishPlot()
end

