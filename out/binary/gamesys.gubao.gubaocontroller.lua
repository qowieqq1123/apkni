







gubaoController=gameState.addListener({})

local isInit=false
local initCheckFunctions=nil
local getRewardMark=nil

function gubaoController:onAppStart()
socketManager:register_receiver(16,1,gubaoController.do_protocol_16_1)
socketManager:register_receiver(16,2,gubaoController.do_protocol_16_2)
socketManager:register_receiver(16,3,gubaoController.do_protocol_16_3)
socketManager:register_receiver(16,4,gubaoController.do_protocol_16_4)
socketManager:register_receiver(16,5,gubaoController.do_protocol_16_5)
socketManager:register_receiver(16,6,gubaoController.do_protocol_16_6)
socketManager:register_receiver(16,7,gubaoController.do_protocol_16_7)
socketManager:register_receiver(16,8,gubaoController.do_protocol_16_8)
socketManager:register_receiver(16,11,gubaoController.do_protocol_16_11)
socketManager:register_receiver(16,12,gubaoController.do_protocol_16_12)
socketManager:register_receiver(16,21,gubaoController.do_protocol_16_21)
end

function gubaoController:onEnterState()
gubaoLookup:initLookup()

initCheckFunctions={
{

cond=function()

return gubaoController:checkInit()and bagModel.checkInit()
end,

func=function()

local baglist=bagControl.invokeFuncByBagType(BAG_TYPE.eGubaoBag,'getBagItems')
if baglist~=nil and#baglist>0 then
local list={}
for i,v in ipairs(baglist)do
local itemid=v.itemid
local gbid=gubaoLookup:good2GuBaoActive(itemid)
if gbid then
local active=gubaoModel:checkActive_OrGLgubao(gbid)
if active then
table.insert(list,v)
end
end
end
gubaoController:reqFenJie(list)
end
end,
},


}
timeEventController.createConditionTimer('gubaoFenJieInit',initCheckFunctions)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.onGameCounterChange,self.onGameCounterChange)
end

function gubaoController:onLeaveState()
gubaoModel:clearData()
gubaoLookup:clearLookup()
getRewardMark=nil
isInit=false
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.onGameCounterChange,self.onGameCounterChange)
end

function gubaoController:onPlayerCreate()


end

function gubaoController:onLostConnection()

end

function gubaoController:checkInit()
return isInit==true
end

function gubaoController.onGameCounterChange(accutype)
if initProControl.isDone()then
gubaoModel:checkCounterToChange(accutype)
end
end

function gubaoController.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if changeType~=CHANGE_TYPE.eAdd then return end

local gbid=gubaoLookup:good2GuBaoActive(itemid)
if gbid then

local active=gubaoModel:checkActive_OrGLgubao(gbid)
if active then
local goodlist={itemguid}
local goodcountlist={newcount}
gubaoController:reqFenJieEx(1,goodlist,1,goodcountlist)
end

end
end

function gubaoController:doActive(gbid)
local itemid=nil
local needChangePiece=false
if gubaoLookup:checkEnoughActiveGood(gbid)then
itemid=gubaoLookup:gubao2GoodActive(gbid)
elseif gubaoLookup:checkEnoughPieceGood(gbid)then
itemid=gubaoLookup:gubao2GoodPiece(gbid)
elseif gubaoLookup:checkEnoughPieceGoodWithChangePiece(gbid)then
itemid=gubaoLookup:gubao2GoodPiece(gbid)
needChangePiece=true
end
if itemid==nil then return end

local item,itemguid=bagControl.invokeFuncByItemId(itemid,'getItemByItemID',itemid)
if item==nil then return end
if not needChangePiece then
gubaoController:reqActive(gbid,itemguid)
else
local color=itemsConfig.getItemColor(itemid)
local changePieceItemList=gubaoLookup:getChangePieceItemListByColor(color)
local changeItemId=changePieceItemList[1]
local changeItem,changeItemGuid=bagControl.invokeFuncByItemId(changeItemId,'getItemByItemID',changeItemId)
local itemname=itemsConfig.getItemName(itemid)
local itemname2=itemsConfig.getItemName(changeItemId)
local needNum=gubaoLookup:checkNeedChangePieceNum(gbid)
local desc_str=FMT.fmt('{0}不足，是否消耗{1}个{2}转换为{0}？',itemname,needNum,itemname2)
local func=function()
gubaoController:reqActive(gbid,itemguid,changeItemGuid)
end
local args={
desc=desc_str,
itemid=changeItemId,
itemnum=needNum,
itemid2=itemid,
itemnum2=needNum,
showCancel=true,
cancelCB=nil,
commitCB=function()
func()
end,
}
UIManager:showWindow('UICommonUseItem_goodChangeWin',args)
end
end


function gubaoController:gubaoShowTips(itemid,index,itemguid,attach)
local gbid=gubaoLookup:good2GuBao(itemid)
local tipsType
if gbid then
tipsType=TIPS_TYPE.eCommonGubaoMetrial
else
tipsType=TIPS_TYPE.eCommonGubaoMetrial2
end
tipsManager.showTips({formType=TIPS_FORM_TYPE.eGubaoCheck,tipsType=tipsType,
itemid=itemid,itemguid=itemguid,attach=attach})
end




function gubaoController:reqInfo()
socketManager:send_16_1()
end


function gubaoController:reqActive(gubaoid,guid,changeItemGuid)



if not changeItemGuid then

changeItemGuid=int64.zero
end
socketManager:send_16_2(gubaoid,guid,changeItemGuid)
end


function gubaoController:reqLianHua(gubaoid,list)
if list==nil then return end
local c=#list
if c>0 then
local goodlist={}
local goodcountlist={}
for i,v in ipairs(list)do
goodlist[i]=v.item.itemguid
goodcountlist[i]=v.cnt
end
gubaoController:reqLianHuaEx(gubaoid,c,goodlist,c,goodcountlist)
end
end
function gubaoController:reqLianHuaEx(gubaoid,goodlistlen,goodlist,goodcountlistlen,goodcountlist)





socketManager:send_16_3(gubaoid,goodlistlen,goodlist,goodcountlistlen,goodcountlist)
end


function gubaoController:reqUpStar(gubaoid,list)
if list==nil then return end
local c=#list
local goodlist={}
local goodcountlist={}
if c>0 then
for i,v in ipairs(list)do
goodlist[i]=v.item.itemguid
goodcountlist[i]=v.cnt
end
end
gubaoController:reqUpStarEx(gubaoid,c,goodlist,c,goodcountlist)
end
function gubaoController:reqUpStarEx(gubaoid,goodlistlen,goodlist,goodcountlistlen,goodcountlist)





socketManager:send_16_4(gubaoid,goodlistlen,goodlist,goodcountlistlen,goodcountlist)
end


function gubaoController:reqAwake(gubaoid,list)
if list==nil then return end
local c=#list
if c>0 then
local goodlist={}
local goodcountlist={}
for i,v in ipairs(list)do
goodlist[i]=v.item.itemguid
goodcountlist[i]=v.cnt
end
gubaoController:reqAwakeEx(gubaoid,c,goodlist,c,goodcountlist)
end
end
function gubaoController:reqAwakeEx(gubaoid,goodlistlen,goodlist,goodcountlistlen,goodcountlist)





socketManager:send_16_5(gubaoid,goodlistlen,goodlist,goodcountlistlen,goodcountlist)
end


function gubaoController:reqFenJie(list)
if list==nil then return end
local c=#list
if c>0 then
local goodlist={}
local goodcountlist={}
for i,v in ipairs(list)do
goodlist[i]=v.itemguid
goodcountlist[i]=v.itemcount
end
gubaoController:reqFenJieEx(c,goodlist,c,goodcountlist)
end
end
function gubaoController:reqFenJieEx(goodlistlen,goodlist,goodcountlistlen,goodcountlist)




socketManager:send_16_6(goodlistlen,goodlist,goodcountlistlen,goodcountlist)
end

function gubaoController:reqReward(rewardtype,rewardid)


getRewardMark=nil
socketManager:send_16_11(rewardtype,rewardid)
end

function gubaoController:reqRewardEx(rewardtype,rewardidList)
if rewardidList==nil then return end
getRewardMark=rewardidList
for i,rewardid in ipairs(rewardidList)do
socketManager:send_16_11(rewardtype,rewardid)
end
end

function gubaoController:reqRewardList(rewardtype,rewardidList)
if rewardidList==nil then return end
socketManager:send_16_12(rewardtype,#rewardidList,rewardidList)
end

function gubaoController:req_16_7(gubaoid)
socketManager:send_16_7(gubaoid)


end


function gubaoController:req_activeCollect(color,num)
socketManager:send_16_21(color,num)
end


function gubaoController:reqBaoShuZhuLing(guid_list_len,guid_list,count_list_len,count_list)
socketManager:send_16_8(guid_list_len,guid_list,count_list_len,count_list)
end





function gubaoController.do_protocol_16_1(args)

















local gubaolistlen=args[1]
local gubaoList=args[2]
local rewardlistlen=args[3]
local rewardList=args[4]
local collectList=args[6]
local bszl_level=args[7]
local bszl_exp=args[8]
gubaoModel:setBSZLData(bszl_level,bszl_exp)
gubaoModel:initData(gubaolistlen,gubaoList or{},rewardList,collectList)
isInit=true
gubaoModel:setAttrAllDirty()
gubaoLookup:setlianhuaitemDirtyEx()
gubaoModel:clearAllSkillEffect()
reddotControl.on_change_catch_type(CATCH_TYPE.eGuBao)
end


function gubaoController.do_protocol_16_2(gubaoid)


gubaoModel:rec_active(gubaoid)
gubaoModel:setAttrDirty(gubaoid,true)
local lookup=cfgHelper.get1(cfg_lookupxiantuachieveconfig_get,gubaoid)
if not lookup then
if xianzhiConfig.checkIsXianZhiGb(gubaoid)then

else
UIManager:showWindow('UIGuBaoAcitveWin',{gbid=gubaoid})
end
else
local id=lookup[1]
local unLock=cfgHelper.get2(cfg_xiantuachieveconfig_get,id,"unlock")
if unLock then

UIFullXianTuChengJiuControl:addPopUpWin('UIGuBaoAcitveWin',{gbid=gubaoid})
end
end
UIManager:invokeUIMethod('UIGuBaoCollectWin','rec_active',gubaoid)
UIManager:invokeUIMethod('UIGuBaoBagWin','rec_active',gubaoid)
UIManager:invokeUIMethod('UIGuBaoMainWin','rec_active',gubaoid)
reddotControl.on_change_catch_type(CATCH_TYPE.eGuBao)

notifySystem:postNotify(notifyConfig.onGuBaoActive,gubaoid)


local itemid=gubaoLookup:gubao2GoodActive(gubaoid)
if itemid then
local all=bagControl.invokeFuncByItemId(itemid,'getAllItemByItemID',itemid)
gubaoController:reqFenJie(all)
end

local glitemid=liandonModel:CheckGB_Guanlian_Item(gubaoid)
if glitemid then
local all=bagControl.invokeFuncByItemId(glitemid,'getAllItemByItemID',glitemid)
gubaoController:reqFenJie(all)
end

end


function gubaoController.do_protocol_16_3(gubaoid,gubaolhlv,gubaolhexp)



local gbData=gubaoModel:getDataByID(gubaoid)
if gbData==nil then return end
local oldlv=gbData.gubaolhlv

gubaoModel:rec_lianhua(gubaoid,gubaolhlv,gubaolhexp)
gubaoModel:setAttrDirty(gubaoid)
gubaoLookup:setlianhuaitemDirtyEx()

UIManager:invokeUIMethod('UIGuBaoCollectWin','rec_lianhua',gubaoid,oldlv,gubaolhlv)
UIManager:invokeUIMethod('UIGuBaoLianHuaWin','rec_lianhua',gubaoid,oldlv,gubaolhlv)
UIManager:invokeUIMethod('UIGuBaoMainWin','rec_lianhua',gubaoid)
reddotControl.on_change_catch_type(CATCH_TYPE.eGuBao)


rankListController.onGuBaoChange(gubaoid)

notifySystem:postNotify(notifyConfig.onGuBaoLianHua,gubaoid)
end


function gubaoController.do_protocol_16_4(gubaoid,gubaostar)



UIManager.info('升星成功')
gubaoModel:rec_upstar(gubaoid,gubaostar)
gubaoModel:setAttrDirty(gubaoid,true)

UIManager:invokeUIMethod('UIGuBaoCollectWin','rec_upStar',gubaoid)
UIManager:invokeUIMethod('UIGuBaoUpStarWin','rec_upStar',gubaoid)
UIManager:invokeUIMethod('UIGuBaoMainWin','rec_upStar',gubaoid)
reddotControl.on_change_catch_type(CATCH_TYPE.eGuBao)


local isfull=gubaoModel:checkFullUpStar(gubaoid)
if isfull then
if UIManager:isActive('UIGuBaoUpStarWin')then
if gubaoModel:checkOpenAwake(gubaoid)then
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.gubaoawake,{gbid=gubaoid})


end
end

end


rankListController.onGuBaoChange(gubaoid)
gubaoLookup:setGoodsSortList3Dirty()
notifySystem:postNotify(notifyConfig.onGuBaoShengXing,gubaoid)
end


function gubaoController.do_protocol_16_5(gubaoid,gubaojxlv)



UIManager.info('觉醒成功')
gubaoModel:rec_awake(gubaoid,gubaojxlv)
gubaoModel:setAttrDirty(gubaoid,true)

UIManager:invokeUIMethod('UIGuBaoCollectWin','rec_awake',gubaoid)
UIManager:invokeUIMethod('UIGuBaoUpStarWin','rec_awake',gubaoid)
UIManager:invokeUIMethod('UIGuBaoMainWin','rec_awake',gubaoid)
reddotControl.on_change_catch_type(CATCH_TYPE.eGuBao)







rankListController.onGuBaoChange(gubaoid)
notifySystem:postNotify(notifyConfig.onGuBaoAwake,gubaoid)
end


function gubaoController.do_protocol_16_6(goodlistlen,goodlist,goodcountlistlen,goodcountlist)




gubaoLookup:setGoodsSortList3Dirty()
UIManager:invokeUIMethod('UIGuBaoBagWin','rec_fenjie',goodlist)
end


function gubaoController.do_protocol_16_11(rewardtype,rewardid)



UIManager.info('领取 成功')
gubaoModel:rec_reward(rewardtype,rewardid)

local change=true
if getRewardMark~=nil and#getRewardMark>0 then
for i,rewardid_ in ipairs(getRewardMark)do
if rewardid_==rewardid then
table.remove(getRewardMark,i)
break
end
end
if#getRewardMark>0 then
change=false
end
end
if change then
UIManager:invokeUIMethod('UIGuBaoRewardWin','rec_reward',rewardtype)
UIManager:invokeUIMethod('UIGuBaoMainWin','refreshRewardBtn')
reddotControl.on_change_catch_type(CATCH_TYPE.eGuBao)
end
end


function gubaoController.do_protocol_16_12(rewardtype,len,rewardidList)
if len>0 then
for i,rewardid in ipairs(rewardidList)do
gubaoModel:rec_reward(rewardtype,rewardid)
end

UIManager:invokeUIMethod('UIGuBaoRewardWin','rec_reward',rewardtype)
UIManager:invokeUIMethod('UIGuBaoMainWin','refreshRewardBtn')
reddotControl.on_change_catch_type(CATCH_TYPE.eGuBao)
end
end


function gubaoController.do_protocol_16_7(gbid,skilllv)
local data,oldLv=gubaoModel:rec_skilllv(gbid,skilllv)

if oldLv~=skilllv then
gubaoModel:setAttrDirty(gbid)

notifySystem:postNotify(notifyConfig.onGuBaoSkillLevelChange,gbid,skilllv,oldLv)
reddotControl.on_change_catch_type(CATCH_TYPE.eGuBaoSkillLevelChange)

UIManager:callWindowFunc("UIXianTuChengJiuWin","refreshGuBao",false)
if fullScreenUI.checkFull(UIFullXianTuChengJiuControl)then
if xianzhiConfig.checkIsXianZhiGb(gbid)then
if xianzhiModel:checkXzFull()then
UIFullXianTuChengJiuControl:showGuBaoLvUpWin(gbid,oldLv,skilllv)
end
else
UIFullXianTuChengJiuControl:showGuBaoLvUpWin(gbid,oldLv,skilllv)
end
end
end
end


function gubaoController.do_protocol_16_21(color,num)



gubaoModel:activeColorCollect(color,num)
gubaoModel:setAttrDirty2()

UIManager.info('激活成功')
UIManager:invokeUIMethod('UIGuBaoAttrWin','rec_active')
UIManager:invokeUIMethod('UIGuBaoMainWin','rec_colorCollect')
reddotControl.on_change_catch_type(CATCH_TYPE.eGuBao)
end


function gubaoController.do_protocol_16_8(bszl_level,bszl_exp)
local oldLevel=gubaoModel:getBSZLData()
gubaoModel:setBSZLData(bszl_level,bszl_exp)
if bszl_level~=oldLevel then
gubaoModel:setGuBaoAllDirty()
end
UIManager:invokeUIMethod("UIBaoShuZhuLingWin","zhulingBack")
UIManager:invokeUIMethod("UIGuBaoMainWin","refreshBSZLBtn")
reddotControl.on_change_catch_type(CATCH_TYPE.eGuBao)
end
