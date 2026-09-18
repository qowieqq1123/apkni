





bagProtocolControl=gameState.addListener({})










function bagProtocolControl:onAppStart()
socketManager:register_receiver(1,1,self.onInitBagData)
socketManager:register_receiver(1,2,self.onBagItemListChange)

socketManager:register_receiver(1,6,self.onItemLock)

socketManager:register_receiver(1,11,self.onDzItemUse)
socketManager:register_receiver(1,14,self.onItemUse)
socketManager:register_receiver(1,15,self.do_protocol_1_15)
socketManager:register_receiver(1,17,self.do_protocol_1_17)
socketManager:register_receiver(1,18,self.onDzItemListUse)
socketManager:register_receiver(1,19,self.recv_1_19)
socketManager:register_receiver(1,20,self.recv_1_20)
socketManager:register_receiver(1,21,self.recv_1_21)
socketManager:register_receiver(1,22,self.recv_1_22)
socketManager:register_receiver(1,23,self.recv_1_23)
socketManager:register_receiver(15,82,self.recv_15_82)
socketManager:register_receiver(1,28,self.recv_1_28)

socketManager:register_receiver(1,29,self.recv_1_29)
end

function bagProtocolControl:onEnterState()

end

function bagProtocolControl:onLeaveState()

end





function bagProtocolControl.onInitBagData(len,array)
bagModel.onInitItems(len,array)
bagModel.checkCombine()

reddotControl.on_change_catch_type(CATCH_TYPE.eInitBagData)
end

function bagProtocolControl.onBagItemListChange(len,array)
bagModel.onChangeItemList(len,array)
bagModel.checkCombine()
end








function bagProtocolControl.onItemLock(guid,pos,lockflag)
local isLock=lockflag~=0
local item
if pos==0 then
item=bagModel.getItem(guid)
elseif pos==-1 then
item=fabaoModel.getFabaoByDizi(guid)
elseif pos>0 then
item=equipsModel.getEquipByDizi(guid,pos)
elseif pos==-11 or pos==-12 then
item=UIFuLuFangModel:getFubaoData(guid,-pos-10)
elseif pos==-21 then
item=daobingModel:getEquipByDizi(guid)
elseif pos==-31 then
item=mountModel:getMountByDZ(guid)
elseif pos==-41 then
item=vocEquipModel:getEquipByDizi(guid)
end
if item==nil then
loggerUtil.logErrFMT('没有找到锁定的道具/装备:{0} pos:{1} flag:{2}',tostring(guid),pos,lockflag)
return
end
bagModel.onItemLock(item,lockflag)
if itemsConfig.isFubao(item.itemid)then
if isLock then
UIManager.info('已锁定，该玉符将不可分解')
else
UIManager.info('解锁成功')
end
else
if isLock then
UIManager.info('装备已锁定，将无法摧毁或消耗')
else
UIManager.info('装备已解锁')
end
end
end

function bagProtocolControl.onDzItemUse(diziguid,itemid,num)
if itemsLookup.checkParamType(itemid,item_funtion_type.eFulu)then
local name=itemsConfig.getColorName(itemid)
UIManager.info(FMT.fmt('使用{0}成功',name))
elseif itemsLookup.checkParamType(itemid,item_funtion_type.eXianMoDaoHengExp)then
local funcparam=itemsConfig.getConfig(itemid).funcparam
if funcparam then
local exp=funcparam.exp
if exp then
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(diziguid)
local exp_rate=gubaoModel:getXianMo_DaoHangEXPSpeed(xm_voc)/100
local singleExp=mathHelper.safe_floor(exp*(1+exp_rate))
commonTipsHelper.addThrowOutAndSliderTips(2,string.format("道行经验+%d",singleExp*num))
end
end
end
end

function bagProtocolControl.onDzItemListUse(len,array)
UIManager:callWindowFunc('UIDiscipleBatchZhiliaoWin','onDzItemListUse',array or{})
UIManager:callWindowFunc('UIXM_ZZSH_resourceDiZiWin','onDzItemListUse',array or{})
end

function bagProtocolControl.recv_1_19(len,arr)
bagModel:addItemUseCount_list(len,arr)
notifySystem:postNotify(notifyConfig.onItemUseInBatch,len,arr)
end

function bagProtocolControl.onItemUse(itemid,num)
local funcparam=itemsConfig.getConfig(itemid).funcparam
if funcparam then
local ftype=funcparam.type
if ftype and BAG_ITEM_USE_CALLBACK_BY_FUNCTION_TYPE[ftype]then
local fun=BAG_ITEM_USE_CALLBACK_BY_FUNCTION_TYPE[ftype]
fun(itemid,funcparam,num)
end
end

bagModel:addItemUseCount(itemid)
notifySystem:postNotify(notifyConfig.onItemUse,itemid,num)
end

function bagProtocolControl.req_init_bag()
socketManager:send_1_1()
end

function bagProtocolControl.req_zhengli_bag_items(combineList)
if combineList==nil or#combineList==0 then return end
socketManager:send_1_3(#combineList,combineList)
end


function bagProtocolControl.req_dizi_use_item(discipleguid,itemid,usenum,isNotTips,backFunc)
local okcallback=function()



socketManager:send_1_11(discipleguid,itemid,usenum)

if backFunc then
backFunc()
end
end
if isNotTips then
okcallback()
else
UIFuncItemUseModel:checkTezhiAddTips(discipleguid,itemid,okcallback)
end
end


function bagProtocolControl.req_sell_item(itemguid,count)
socketManager:send_1_12(itemguid,count)
end

function bagProtocolControl.req_dizi_use_item_list(len,array)



socketManager:send_1_18(len,array)
end

function bagProtocolControl.req_use_item_list(len,arr)
socketManager:send_1_19(len,arr)
end

function bagProtocolControl.req_use_item(itemId,count)
socketManager:send_1_14(itemId,count)
end


function bagProtocolControl.req_lingshou_use_item(ls_guid,itemid,usenum)



socketManager:send_1_15(ls_guid,itemid,usenum)
end

function bagProtocolControl.req_change_bag_item_lockflag(itemguid,isUnlock)
local flag=isUnlock and 0 or 1
socketManager:send_1_6(itemguid,0,flag)
end

function bagProtocolControl.req_change_bag_dizi_equip_lockflag(diziguid,equipType,isUnlock)
local flag=isUnlock and 0 or 1
socketManager:send_1_6(diziguid,equipType,flag)
end

function bagProtocolControl.req_change_bag_dizi_fabao_lockflag(diziguid,isUnlock)
local flag=isUnlock and 0 or 1
socketManager:send_1_6(diziguid,-1,flag)
end

function bagProtocolControl.req_change_bag_dizi_daobing_lockflag(diziguid,isUnlock)
local flag=isUnlock and 0 or 1
socketManager:send_1_6(diziguid,-21,flag)
end

function bagProtocolControl.req_change_bag_dizi_munt_lockflag(diziguid,isUnlock)
local flag=isUnlock and 0 or 1
socketManager:send_1_6(diziguid,-31,flag)
end

function bagProtocolControl.req_change_bag_dizi_vocequip_lockflag(diziguid,isUnlock)
local flag=isUnlock and 0 or 1
socketManager:send_1_6(diziguid,-41,flag)
end


function bagProtocolControl.req_use_item_by_itemguid(itemguid,num)
if num==nil then
local item=bagModel.getItem(itemguid)
num=item.itemcount
end
socketManager:send_1_22(itemguid,num)
end

function bagProtocolControl.req_sell_item_list(len,arr)
socketManager:send_1_27(len,arr)
end


function bagProtocolControl.reqReuseItem(itemguid)
socketManager:send_15_82(itemguid)
end


function bagProtocolControl.req_lingshou_use_item_list(len,list)



socketManager:send_1_28(len,list)
end



function bagProtocolControl.do_protocol_1_15(ls_guid,itemid,usenum)



local data={
param_1=ls_guid,
param_2=itemid,
param_3=usenum,
}
local list={data}
notifySystem:postNotify(notifyConfig.onLingShouUseItemList,list)
end



function bagProtocolControl.recv_1_28(len,list)
if len>0 then
notifySystem:postNotify(notifyConfig.onLingShouUseItemList,list)
end
end




function bagProtocolControl.recv_1_29(lenList,dropList)

if not dropList or type(dropList)~='table'or#dropList<=0 then
return
end

local showList={}
local lookup={}
for _,v in ipairs(dropList)do
local itemid=v.itemId or v.itemid or v.param_1 or v.id or v[1]
local num=v.itemNum or v.num or v.param_2 or v[2]or 1
local lsList=v.lsList
if itemid and num and num>0 then
if itemsConfig.getMainType(itemid)==ITEM_MAIN_TYPE.eLingShou and lsList and type(lsList)=='table'and#lsList>0 then
for _,lsGuid in ipairs(lsList)do
showPrizeControl.insertCommon(showList,lookup,nil,itemid,1,false)
local info=showList[#showList]
if info then
info.conf=info.conf or{}
info.conf.attach=lsGuid
end
end
else

showPrizeControl.insertCommon(showList,lookup,nil,itemid,num,false)
end
end
end

if#showList>0 then
UIManager:showWindow('UICommonShowPrizeWin',{list=showList})
end
end




function bagProtocolControl.req_1_17(box_guid,usecount,len,item_index_list)
socketManager:send_1_17(box_guid,usecount,len,item_index_list)
end


function bagProtocolControl.do_protocol_1_17(itemListLen,itemList)


local list={}
for i,v in ipairs(itemList)do
table.insert(list,{itemid=v.param_1,num=v.param_2})
end

UIManager:closeWindow("UIBoxSelectWin")

end



function bagProtocolControl.req_1_20(itemid,usenum,idxlistlen,idxList)
socketManager:send_1_20(itemid,usenum,idxlistlen,idxList)
end


function bagProtocolControl.recv_1_20(itemid,usenum,idxlistlen,idxList)


UIManager:closeWindow("UIItemSelectRecruitDiscipleWin")
bagUseControl.onUseItemid(itemid)
bagModel:addItemUseCount(itemid)
end



function bagProtocolControl.req_1_21(itemid,itemnum,pram)
socketManager:send_1_21(itemid,itemnum,pram)
end


function bagProtocolControl.recv_1_21(itemid,itemnum,pram)


end

function bagProtocolControl.recv_1_22(itemguid,num)
local itemid=bagModel.getItemIdByGUID(itemguid)
bagUseControl.onUseItem(itemguid,num)

local showUseTips=true
local itemConfig=itemsConfig.getConfig(itemid)
local getusetype=itemConfig and itemConfig.getusetype
if getusetype then
local usetype=getusetype[1]
local useParams=getusetype[2]
if usetype==2 then

showUseTips=false
end
end

if showUseTips then
UIManager.info(FMT.fmt('{0}使用成功',itemsModel.getName(itemid)))
end
end


function bagProtocolControl.recv_1_23(len,useCountList)
if not len or len<=0 then
return
end
bagModel:setItemUseCountList(useCountList)
end

function bagProtocolControl.recv_15_82(itemguid,cd_time,use_times)
bagModel.changeItemData(itemguid,cd_time,use_times)
reddotControl.on_change_catch_type(REDDIT_TYPE.eStoreHouseBase)
bagUseControl.clearAskUse(itemguid)
UIManager:callWindowFunc('UIItemUseTipWin','moveNext')

UIManager:callWindowFunc('UIBagWin','freshItemByGuid',itemguid)
end