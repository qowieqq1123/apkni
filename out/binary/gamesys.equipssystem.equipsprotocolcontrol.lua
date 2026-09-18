





equipsProtocolControl=gameState.addListener({})

function equipsProtocolControl:onAppStart()
socketManager:register_receiver(2,31,self.on_equip_dress)
socketManager:register_receiver(2,32,self.on_equip_take_off)
socketManager:register_receiver(2,33,self.on_equip_jinglian)
socketManager:register_receiver(2,34,self.on_equip_dress_list)
socketManager:register_receiver(2,35,self.on_equip_jinglian_list)

socketManager:register_receiver(2,23,self.on_equip_dress_onekey)
socketManager:register_receiver(2,26,self.on_equip_take_off_onekey)

socketManager:register_receiver(2,91,self.on_recv_equip_2_91)
socketManager:register_receiver(2,92,self.on_recv_equip_2_92)
socketManager:register_receiver(2,93,self.on_recv_equip_2_93)

socketManager:register_receiver(2,138,self.recv_2_138)
socketManager:register_receiver(2,139,self.recv_2_139)


socketManager:register_receiver(2,162,self.recv_2_162)
socketManager:register_receiver(2,163,self.recv_2_163)
socketManager:register_receiver(2,164,self.recv_2_164)

end

function equipsProtocolControl:onEnterState()
equipsModel.init()
notifySystem:listenNotify(notifyConfig.on_bagtype_item_list_changed,self.on_item_list_changed)
end

function equipsProtocolControl:onLeaveState()
equipsModel.init()
notifySystem:removelistener(notifyConfig.on_bagtype_item_list_changed,self.on_item_list_changed)
end

function equipsProtocolControl.on_equip_dress(diziguid,equipguid)
local equipType=equipsModel.onDressEquip(diziguid,equipguid)
equipsControl.freshWindow('onChangeItem',diziguid,equipType)
equipsControl.freshWindow('onWeaponChanged',diziguid,equipType)
equipsControl.freshJinglianWindow('onChangeItem',diziguid,equipType)
equipsControl.freshAttrWindow()
UIManager:callWindowFunc('UIEquipFilterWin','onDressEquip',diziguid,equipType)
UIManager.info('装备成功')

AudioManager.playAudio(632)
end

function equipsProtocolControl.on_equip_take_off(diziguid,equipType)
equipsModel.onTakeoffEquip(diziguid,equipType)
equipsControl.freshWindow('onChangeItem',diziguid,equipType)
equipsControl.freshWindow('onWeaponChanged',diziguid,equipType)
equipsControl.freshAttrWindow()
end





function equipsProtocolControl.on_equip_jinglian(argstable)
local guid=argstable[1]
local pos=argstable[2]
local level=argstable[3]
local exp=argstable[4]
local len=argstable[5]
local list=argstable[6]
local changeLv=false
local addExp=0
if pos==0 then
local equip=equipsHelper.getEquip(guid)
local oldlv,oldexp=equipsModel.getEquipJinglianLevel(equip)
changeLv=oldlv~=level
addExp=exp-oldexp
equipsModel.onJinglianEquipByEquip(equip,level,exp,list)
bagEquipControl:onChangeEquipJllv(oldlv,level)
equipsControl.freshBagWindow('onEquipJinglian',guid)
equipsControl.freshJinglianWindow('onJinglian',oldlv,level)
UIManager:callWindowFunc('UIEquipFilterWin','freshListPanel')
else
local oldlv,oldexp=equipsModel.getEquipJinglianLevelByDizi(guid,pos)
changeLv=oldlv~=level
addExp=exp-oldexp
equipsModel.onJinglianEquip(guid,pos,level,exp,list)
dataControl.onDZEquipJilvChange()
equipsControl.freshJinglianWindow('onJinglian',oldlv,level)
UIManager:callWindowFunc('UIEquipFilterWin','onTakeEquips',guid)
end
equipsControl.freshWindow('freshEquips')
equipsControl.freshAttrWindow()
if not changeLv and addExp>0 then
commonTipsHelper.addThrowOutAndSliderTips(2,FMT.fmt('+{0}经验',addExp))
end
if changeLv then
notifySystem:postNotify(notifyConfig.onEquipJingLianLevelChange,guid,pos,level)
end
end

function equipsProtocolControl.on_equip_dress_list(len,array)
if len>0 then
for i=1,len do
local v=array[i]
local diziguid=v.discipleguid
local equiplen=v.guidlistlen
local equipList=v.guidlist
if equiplen>0 then
for j=1,equiplen do
local equipguid=equipList[j]
local item=bagModel.getItem(equipguid)
if item==nil then
logErr('穿戴装备已删除')
else
local itemid=item.itemid
local equipType=equipsConfig.getEquipType(itemid)
if itemsConfig.isFabao(itemid)then
fabaoModel.onFabaoDress(diziguid,equipguid)
elseif itemsConfig.isEquip(itemid)then
equipsModel.onDressEquip(diziguid,equipguid)
elseif itemsConfig.isDaoBing(itemid)then
daobingModel:onDressEquip(diziguid,equipguid)
elseif itemsConfig.isMount(itemid)then
mountModel:onDress(diziguid,equipguid)
elseif itemsConfig.isClothing(itemid)then
ClothingModel:onDressEquip(diziguid,equipguid)
elseif itemsConfig.isVocEquip(itemid)then
vocEquipModel:onDressEquip(diziguid,equipguid)
end
equipsControl.freshWindow('onChangeItem',diziguid,equipType)
equipsControl.freshWindow('onWeaponChanged',diziguid,equipType)
end
end
end
end
equipsControl.freshAttrWindow()
UIManager.info('一键装备成功')

AudioManager.playAudio(632)
end
end

function equipsProtocolControl.on_equip_dress_onekey(diziguid,equiplen,equipList)
if equiplen>0 then
for j=1,equiplen do
local equipguid=equipList[j].param_2
local item=bagModel.getItem(equipguid)
if item==nil then
logErr('穿戴装备已删除')
else
local itemid=item.itemid
local equipType=equipsConfig.getEquipType(itemid)
if itemsConfig.isFabao(itemid)then
fabaoModel.onFabaoDress(diziguid,equipguid)
elseif itemsConfig.isEquip(itemid)then
equipsModel.onDressEquip(diziguid,equipguid)
elseif itemsConfig.isDaoBing(itemid)then
daobingModel:onDressEquip(diziguid,equipguid)
elseif itemsConfig.isMount(itemid)then
mountModel:onDress(diziguid,equipguid)
elseif itemsConfig.isClothing(itemid)then
ClothingModel:onDressEquip(diziguid,equipguid)
elseif itemsConfig.isVocEquip(itemid)then
vocEquipModel:onDressEquip(diziguid,equipguid)
end
equipsControl.freshWindow('onChangeItem',diziguid,equipType)
equipsControl.freshWindow('onWeaponChanged',diziguid,equipType)
end
end
equipsControl.freshWindow('OneKeyDressRet',diziguid)
equipsControl.freshAttrWindow()
UIManager.info('一键装备成功')

AudioManager.playAudio(632)







end
end

function equipsProtocolControl.on_equip_take_off_onekey(diziguid)
local equipTypes=equipsModel.deleDiziEquip(diziguid,true)
local equipType1=fabaoModel.deleteFabao(diziguid)
local equipType2=daobingModel:deleteEquip(diziguid)

if equipType1 then
equipTypes[#equipTypes+1]=equipType1
end
if equipType2 then
equipTypes[#equipTypes+1]=equipType2
end



equipsControl.freshWindow('OneKeyTakeOffRet',diziguid,equipTypes)
equipsControl.freshAttrWindow()
UIManager:callWindowFunc('UIEquipFilterWin','onTakeEquips',diziguid)








end




function equipsProtocolControl.on_recv_equip_2_91(argstable)
local guid=argstable[1]
local pos=argstable[2]
local flag=argstable[3]
local attrLen=argstable[4]
local randattrList=argstable[5]
local suitid=argstable[6]

if pos==0 then
local equip=equipsHelper.getEquip(guid)
equipsModel:saveChongZhuEquipByEquip(equip,flag,randattrList,suitid)
else
local equip=equipsModel.getEquipByDizi(guid,pos)
equipsModel:saveChongZhuEquipByEquip(equip,flag,randattrList,suitid)
end

UIManager:callWindowFunc('UIEquipChongZhuWin',"onRecvData",true)

reddotControl.on_change_catch_type(CATCH_TYPE.eChongZhu)
end


function equipsProtocolControl.on_recv_equip_2_92(argstable)
local guid=argstable[1]
local pos=argstable[2]
local flag=argstable[3]
local attrLen=argstable[4]
local randattrList=argstable[5]
local suitid=argstable[6]

if pos==0 then
local equip=equipsHelper.getEquip(guid)
equipsModel:saveChongZhuEquipByEquip(equip,flag,randattrList,suitid)
else
local equip=equipsModel.getEquipByDizi(guid,pos)
equipsModel:saveChongZhuEquipByEquip(equip,flag,randattrList,suitid)
end

UIManager:callWindowFunc('UIEquipChongZhuWin',"onRecvData")

reddotControl.on_change_catch_type(CATCH_TYPE.eChongZhu)
end


function equipsProtocolControl.on_recv_equip_2_93(guid,pos,flag)
if pos==0 then
local equip=equipsHelper.getEquip(guid)
equipsModel:onChongZhuEquipByEquip(equip,flag)
UIManager:callWindowFunc('UIEquipFilterWin','freshListPanel')
else
local equip=equipsModel.getEquipByDizi(guid,pos)
equipsModel:onChongZhuEquipByEquip(equip,flag)
equipsModel.onChangeAttrsOnJinglianEquip(guid,equip.itemguid)
UIManager:callWindowFunc('UIEquipFilterWin','onTakeEquips',guid)
end

UIManager:callWindowFunc('UIEquipChongZhuWin',"onRecvData")

UIManager:callWindowFunc('UIBagWin','freshItemByGuid',guid)
equipsControl.freshWindow('freshEquips')

notifySystem:postNotify(notifyConfig.onEquipChongZhu,guid)
reddotControl.on_change_catch_type(CATCH_TYPE.eChongZhu)
end









function equipsProtocolControl.recv_2_138(guid,pos,reveal_times)
if pos==0 then
local equip=equipsHelper.getEquip(guid)
local old=equipsModel:getDianHuaCnt(equip)
equipsModel:onDianHuaByEquip(equip,reveal_times)
equipsControl.freshBagWindow('onEquipJinglian',guid)
UIManager:callWindowFunc('UIEquipDianHuaWin','onDianHua',equip.itemguid,old,reveal_times)
else
local equip=equipsModel.getEquipByDizi(guid,pos)
local old=equipsModel:getDianHuaCnt(equip)
equipsModel:onDianHuaByDZ(guid,pos,reveal_times)
UIManager:callWindowFunc('UIEquipDianHuaWin','onDianHua',equip.itemguid,old,reveal_times)
equipsControl.freshWindow('freshEquips')
end
end








function equipsProtocolControl.recv_2_139(guid,pos)
if pos==0 then
local equip=equipsHelper.getEquip(guid)
equipsModel:onUnDianHuaByEquip(equip)
equipsControl.freshBagWindow('onEquipJinglian',guid)
else
local equip=equipsModel.getEquipByDizi(guid,pos)
equipsModel:onUnDianHuaByDZ(guid,pos)
equipsControl.freshWindow('freshEquips')
end
UIManager.info('返璞成功')
end


function equipsProtocolControl.recv_2_162(guid,pos)
if pos==0 then
local equip=equipsHelper.getEquip(guid)
equipsModel:onNingLianByEquip(equip)
equipsModel.freshBagWindow('onEquipJinglian',guid)
UIManager:invokeUIMethod('UIEquipNingLianWin','RefreshNingLing')
else


equipsModel:onNingLianByDZ(guid,pos)
UIManager:invokeUIMethod('UIEquipNingLianWin','RefreshNingLing')
end
equipsControl.freshWindow('freshEquips')
UIManager:invokeUIMethod('UIEquipNingLianWin','chenggongEffect')
end

function equipsProtocolControl.recv_2_163(guid,pos)
if pos==0 then
local equip=equipsHelper.getEquip(guid)
equipsModel:onUnNingLianByEquip(equip)
equipsModel.freshBagWindow('onEquipJinglian',guid)
UIManager:invokeUIMethod('UIEquipNingLianWin','RefreshNingLing')
else
equipsModel:onUnNingLianByDZ(guid,pos)
UIManager:invokeUIMethod('UIEquipNingLianWin','RefreshNingLing')
end
equipsControl.freshWindow('freshEquips')
UIManager:invokeUIMethod('UIEquipNingLianWin','chenggongEffect')
end

function equipsProtocolControl.recv_2_164(arg)
local guid=arg[1]
local pos=arg[2]
local other_guid=arg[3]
local len=arg[4]
local old_randattrList=arg[5]
local jinglian_lvl=arg[6]
local jinglian_exp=arg[7]
if pos==0 then
local equip=equipsHelper.getEquip(guid)
if len>0 and old_randattrList then
equipsModel:onFusionByEquip(equip,old_randattrList,jinglian_lvl,jinglian_exp)
UIManager:invokeUIMethod('UIEquipRongHeWin','RefreshRongHE')
end
else
if len>0 and old_randattrList then
equipsModel:onFusionByDZ(guid,pos,old_randattrList,jinglian_lvl,jinglian_exp)
UIManager:invokeUIMethod('UIEquipRongHeWin','RefreshRongHE')
end
end
reddotControl.on_change_catch_type(CATCH_TYPE.eChongZhu)
equipsControl.freshWindow('freshEquips')
UIManager:invokeUIMethod('UIEquipRongHeWin','chenggongEffect')

end


function equipsProtocolControl.req_equip_dress(diziguid,equipguid)
if diziguid and equipguid then
local xmtype=equipsHelper.getEquipXMType(equipguid)
if xmtype>0 then
local xm_voc=UIDiscipleModel:getDiscipleXianMoVoc(diziguid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(diziguid)
local jobid=imageInfo.job
local equipData=equipsHelper.getEquip(equipguid)
local itemConfig=itemsConfig.getConfig(equipData.itemid)
local joblist=equipsModel.getEquipXMJobList(equipData.itemid)
local xm_name=''
local iscanDress=false
if joblist[jobid]and joblist[jobid]==1 then
iscanDress=true
end
for k,v in pairs(joblist)do
xm_name=cfgHelper.get2(cfg_disciplevocationconfig_get,k,"xm_name")
end
if iscanDress then
if xmtype==EQUIP_XianMo_TYPES.eXian and xmtype~=xm_voc then
local _str=FMT.fmt("仙武<color=#c82c2c>[{0}]</color>，只能<color=#c82c2c>[{1}]</color>才能穿戴",itemConfig.name,xm_name[1])
UIManager.info(_str)
return
elseif xmtype==EQUIP_XianMo_TYPES.eMo and xmtype~=xm_voc then
local _str=FMT.fmt("魔武<color=#c82c2c>[{0}]</color>，只能<color=#c82c2c>[{1}]</color>才能穿戴",itemConfig.name,xm_name[2])
UIManager.info(_str)
return
end
else
if xmtype==EQUIP_XianMo_TYPES.eXian then
local _str=FMT.fmt("仙武<color=#c82c2c>[{0}]</color>，只能<color=#c82c2c>[{1}]</color>才能穿戴",itemConfig.name,xm_name[1])
UIManager.info(_str)
return
elseif xmtype==EQUIP_XianMo_TYPES.eMo then
local _str=FMT.fmt("魔武<color=#c82c2c>[{0}]</color>，只能<color=#c82c2c>[{1}]</color>才能穿戴",itemConfig.name,xm_name[2])
UIManager.info(_str)
return
end
end
end
end
socketManager:send_2_31(diziguid,equipguid)
end

function equipsProtocolControl.req_equip_take_off(diziguid,equipType)
socketManager:send_2_32(diziguid,equipType)
end

function equipsProtocolControl.req_equip_jinglian(guid,pos,itemsLen,items,equipsLen,equipguids)
local itemnums={}
local itemguids={}
if itemsLen>0 then
for i,v in ipairs(items)do
itemguids[#itemguids+1]=v[1]
itemnums[#itemnums+1]=v[2]
end
end
socketManager:send_2_33(guid,pos,itemsLen,itemguids,itemsLen,itemnums,equipsLen,equipguids)
end









function equipsProtocolControl.req_equip_dress_onekey(diziguid,equipguidList)
local len=#equipguidList
if len<=0 then return end
local list={}
for i,itemguid in ipairs(equipguidList)do
local item=bagModel.getItem(itemguid)
local itemid=item.itemid
local isEquip=itemsConfig.isEquip(itemid)
local isFabao=itemsConfig.isFabao(itemid)
local isDaoBing=itemsConfig.isDaoBing(itemid)
local isMount=itemsConfig.isMount(itemid)
local isClothing=itemsConfig.isClothing(itemid)
local typo=isEquip and 1 or
isFabao and 2 or
isDaoBing and 3 or
isMount and 4 or
isClothing and 5
list[#list+1]={typo,itemguid}
end
socketManager:send_2_23(diziguid,len,list)
end

function equipsProtocolControl.req_equip_take_off_onekey(diziguid)
socketManager:send_2_26(diziguid)
end

function equipsProtocolControl.req_equip_2_91(guid,pos)
socketManager:send_2_91(guid,pos)
end

function equipsProtocolControl.req_equip_2_91_ex(itemguid)
local dzguid=equipsModel.getDiziguidByItemguid(itemguid)
if dzguid then
local equip=equipsHelper.getEquip(itemguid)
local pos=itemsConfig.getConfig(equip.itemid).type1
socketManager:send_2_91(dzguid,pos)
else
socketManager:send_2_91(itemguid,0)
end
end

function equipsProtocolControl.req_equip_2_92(guid,pos,flag)
socketManager:send_2_92(guid,pos,flag)
end

function equipsProtocolControl.req_equip_2_93(guid,pos,flag)
socketManager:send_2_93(guid,pos,flag)
end

function equipsProtocolControl.req_equip_2_138(itemguid)
local dzguid=equipsModel.getDiziguidByItemguid(itemguid)
if dzguid then
local equip=equipsHelper.getEquip(itemguid)
local pos=itemsConfig.getConfig(equip.itemid).type1
socketManager:send_2_138(dzguid,pos)
else
socketManager:send_2_138(itemguid,0)
end
end

function equipsProtocolControl.req_equip_2_139(itemguid)
local dzguid=equipsModel.getDiziguidByItemguid(itemguid)
if dzguid then
local equip=equipsHelper.getEquip(itemguid)
local pos=itemsConfig.getConfig(equip.itemid).type1
socketManager:send_2_139(dzguid,pos)
else
socketManager:send_2_139(itemguid,0)
end
end



function equipsProtocolControl:send_2_162(itemguid)
local dzguid=equipsModel.getDiziguidByItemguid(itemguid)
if dzguid then
local equip=equipsHelper.getEquip(itemguid)
local pos=itemsConfig.getConfig(equip.itemid).type1
socketManager:send_2_162(dzguid,pos)
else
socketManager:send_2_162(itemguid,0)
end
end

function equipsProtocolControl:send_2_163(itemguid)
local dzguid=equipsModel.getDiziguidByItemguid(itemguid)
if dzguid then
local equip=equipsHelper.getEquip(itemguid)
local pos=itemsConfig.getConfig(equip.itemid).type1
socketManager:send_2_163(dzguid,pos)
else
socketManager:send_2_163(itemguid,0)
end
end

function equipsProtocolControl:send_2_164(itemguid,other_guid)
local other_dzguid=equipsModel.getDiziguidByItemguid(other_guid)
if other_dzguid then
UIManager.info("请先脱下被融合消耗的装备")
return
end
local dzguid=equipsModel.getDiziguidByItemguid(itemguid)
if dzguid then
local equip=equipsHelper.getEquip(itemguid)
local pos=itemsConfig.getConfig(equip.itemid).type1
socketManager:send_2_164(dzguid,pos,other_guid)
else
socketManager:send_2_164(itemguid,0,other_guid)
end
end


function equipsProtocolControl.on_item_list_changed(bagType,args,lookup_guidStr,lookup_itemid,lookup_change)
if bagType~=BAG_TYPE.eEquipBag then return end
if lookup_change[CHANGE_TYPE.eAdd]==nil then return end

if not systemModel.isOpen(SYSTEM_DEFINE.eXianMoEquip)then return end
local takeOffLookup=equipsModel:getTakeOffEquiplist()

local v
if args[2]then
v=args[2]
else
v=args[1]
end
local itemid=v[3]
if equipsHelper.isEquipXMbyItemid(itemid)then
local guidStr=v[6]
if not takeOffLookup[guidStr]then
local itemConfig=itemsConfig.getConfig(itemid)
local name=itemConfig.name
local desc=FMT.fmt("<color=#171311>恭喜</color><color=#ca631d>[{2}]</color><color=#171311>祖师，获得了1件仙魔装备</color><color={1}>[{0}]</color><color=#171311>！轰动三界！</color>",name,FONT_COLOR_VAL[itemConfig.color],playerModel:getActorName())
UIManager.topHourceLamp(desc)
end
equipsModel:clearTakeOffEquiplist()
end

end

function equipsProtocolControl.req_equip_mutiple_jinglian(equipGuidListLen,equipGuidList,costItemListLen,costItemList,costEquipListLen,costEquipList,toLevel)
socketManager:send_2_35(equipGuidListLen,equipGuidList,costItemListLen,costItemList,costEquipListLen,costEquipList,toLevel)
end

function equipsProtocolControl.on_equip_jinglian_list(len,resultBackList)

for index=1,len do
local resultData=resultBackList[index]

local guid=resultData.guid
local level=resultData.level
local exp=resultData.exp
local list=resultData.randattrList or defaultT

local equipData=itemsModel.getItem(guid)
local oldlv=equipData.itemData.jinglianlv

equipsModel.onJinglianEquipByEquip(equipData,level,exp,list)
bagEquipControl:onChangeEquipJllv(oldlv,level)
end

UIManager:invokeUIMethod("UIBagWin",'outMutipleJingLianModel')

if not UIManager:isActive("UIMutipleJingLianEquipWin")then
UIManager:showWindow("UIMutipleJingLianEquipWin",{isRecvJingLian=true})
end
end

