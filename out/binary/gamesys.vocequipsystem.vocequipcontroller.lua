






local _MODULENAME="vocEquipController"

gameState.addListener(def_table(_MODULENAME))
vocEquipController.name=_MODULENAME
vocEquipController.data={}

function vocEquipController:onAppStart()

vocEquipModel:onAppStart()



socketManager:register_receiver(2,181,self.recv_2_181)
socketManager:register_receiver(2,182,self.recv_2_182)
socketManager:register_receiver(2,183,self.recv_2_183)
socketManager:register_receiver(2,184,self.recv_2_184)
socketManager:register_receiver(2,185,self.recv_2_185)

socketManager:register_receiver(2,186,self.recv_2_186)
socketManager:register_receiver(2,187,self.recv_2_187)






end


function vocEquipController:onEnterState(isReconnect)
vocEquipModel:onEnterState()
notifySystem:listenNotify(notifyConfig.onGuBaoActive,self.onGuBaoUpdate)
notifySystem:listenNotify(notifyConfig.onGuBaoAwake,self.onGuBaoUpdate)
notifySystem:listenNotify(notifyConfig.onGuBaoShengXing,self.onGuBaoUpdate)
notifySystem:listenNotify(notifyConfig.onNewMonth5am,self.onNewMonth5am)
end


function vocEquipController:onProtocolReq()
vocEquipModel:onProtocolReq()
end


function vocEquipController:onLeaveState(isReconnect)
vocEquipModel:onLeaveState(isReconnect)

self.data={}
notifySystem:removelistener(notifyConfig.onGuBaoActive,self.onGuBaoUpdate)
notifySystem:removelistener(notifyConfig.onGuBaoAwake,self.onGuBaoUpdate)
notifySystem:removelistener(notifyConfig.onGuBaoShengXing,self.onGuBaoUpdate)
notifySystem:removelistener(notifyConfig.onNewMonth5am,self.onNewMonth5am)
end


function vocEquipController:onLostConnection()

end


function vocEquipController:onReConnection(isInitPro)

end



function vocEquipController.req_vocEquip_put_on(discipleguid,itemguid)
socketManager:send_2_181(discipleguid,itemguid)
end


function vocEquipController.req_vocEquip_take_off(discipleguid)
local pos=1
socketManager:send_2_182(discipleguid,pos)
end


function vocEquipController.req_vocEquip_strengthen(guid,pos,itemsLen,items)
socketManager:send_2_183(guid,pos,itemsLen,items)
end


function vocEquipController.req_vocEquip_break(guid,pos)
socketManager:send_2_184(guid,pos)
end


function vocEquipController.req_vocEquip_resetLv(guid,pos)
socketManager:send_2_185(guid,pos)
end


function vocEquipController.req_vocEquip_ZhuanHuan(guid,pos,item_id)
socketManager:send_2_186(guid,pos,item_id)
end


function vocEquipController.recv_2_181(discipleguid,equipguid)
vocEquipModel:onDressEquip(discipleguid,equipguid)

equipsControl.freshWindow('showModel')
equipsControl.freshWindow('onChangeVocEquip',discipleguid)
UIManager:invokeUIMethod("UIVocEquipStrengthenWin","onChangeItem",discipleguid)
equipsControl.freshAttrWindow()

UIManager.info('装备成功')

AudioManager.playAudio(632)
end


function vocEquipController.recv_2_182(discipleguid,pos)
vocEquipModel:onTakeOffEquip(discipleguid)
equipsControl.freshWindow('showModel')
equipsControl.freshWindow('onChangeVocEquip',discipleguid)
equipsControl.freshAttrWindow()
end


function vocEquipController.recv_2_183(guid,pos,level,exp)
local changeLv=false
local addExp=0
local oldlv,oldexp
local equip
if pos==0 then
equip=equipsHelper.getEquip(guid)
oldlv,oldexp=vocEquipModel.getVocEquipStrengthenLevel(equip)
changeLv=oldlv~=level
vocEquipModel.onStrengthenEquipByEquip(equip,level,exp)
equipsControl.freshBagWindow('onVocEquipStrengthen',guid)
UIManager:invokeUIMethod("UIVocEquipStrengthenWin","onStrengthen",oldlv,level)
UIManager:callWindowFunc('UIEquipFilterWin','freshListPanel')
else
oldlv,oldexp=vocEquipModel.getVocEquipStrengthenLevelByDizi(guid)
changeLv=oldlv~=level
equip=vocEquipModel:getEquipByDizi(guid)
vocEquipModel.onStrengthenEquip(guid,level,exp)
UIManager:invokeUIMethod("UIVocEquipStrengthenWin","onStrengthen",oldlv,level)
UIManager:callWindowFunc('UIEquipFilterWin','onTakeEquips',guid)
end
equipsControl.freshWindow('freshEquips')
equipsControl.freshAttrWindow()

local itemid=equip.itemid
local vocId=vocEquipHelper.getEquipVocId(itemid)
local oldLevelExp=0
if oldlv>1 then
oldLevelExp=vocEquipHelper.getStrengthenExp(vocId,oldlv-1)
end
oldLevelExp=oldLevelExp+oldexp
local newLevelExp=0
if level>1 then
newLevelExp=vocEquipHelper.getStrengthenExp(vocId,level-1)
end
newLevelExp=newLevelExp+exp
addExp=newLevelExp-oldLevelExp

if not changeLv and addExp>0 then
commonTipsHelper.addThrowOutAndSliderTips(2,FMT.fmt('+{0}经验',addExp))
end
if changeLv then
notifySystem:postNotify(notifyConfig.onVocEquipStrengthenLevelChange,guid,pos,level)
end
end


function vocEquipController.recv_2_184(guid,pos)
local addExp=0
local oldlv,oldexp
local newlv
if pos==0 then
local equip=equipsHelper.getEquip(guid)
oldlv,oldexp=vocEquipModel.getVocEquipStrengthenLevel(equip)
newlv=oldlv+1
vocEquipModel.onStrengthenEquipByEquip(equip,newlv,oldexp)
equipsControl.freshBagWindow('onVocEquipStrengthen',guid)
UIManager:invokeUIMethod("UIVocEquipStrengthenWin","onStrengthen",oldlv,newlv)
UIManager:callWindowFunc('UIEquipFilterWin','freshListPanel')
else
oldlv,oldexp=vocEquipModel.getVocEquipStrengthenLevelByDizi(guid)
newlv=oldlv+1
vocEquipModel.onStrengthenEquip(guid,newlv,oldexp)
UIManager:invokeUIMethod("UIVocEquipStrengthenWin","onStrengthen",oldlv,newlv)
UIManager:callWindowFunc('UIEquipFilterWin','onTakeEquips',guid)
end
equipsControl.freshWindow('freshEquips')
equipsControl.freshAttrWindow()
notifySystem:postNotify(notifyConfig.onVocEquipStrengthenLevelChange,guid,pos,newlv)
end


function vocEquipController.recv_2_185(guid,pos)
local addExp=0
local oldlv,oldexp
local newlv=0
local newexp=0
if pos==0 then
local equip=equipsHelper.getEquip(guid)
oldlv,oldexp=vocEquipModel.getVocEquipStrengthenLevel(equip)
vocEquipModel.onStrengthenEquipByEquip(equip,newlv,newexp)
equipsControl.freshBagWindow('onVocEquipStrengthen',guid)
UIManager:invokeUIMethod("UIVocEquipStrengthenWin","onStrengthen",oldlv,newlv)
UIManager:callWindowFunc('UIEquipFilterWin','freshListPanel')
else
oldlv,oldexp=vocEquipModel.getVocEquipStrengthenLevelByDizi(guid)
vocEquipModel.onStrengthenEquip(guid,newlv,newexp)
UIManager:invokeUIMethod("UIVocEquipStrengthenWin","onStrengthen",oldlv,newlv)
UIManager:callWindowFunc('UIEquipFilterWin','onTakeEquips',guid)
end
equipsControl.freshWindow('freshEquips')
equipsControl.freshAttrWindow()
notifySystem:postNotify(notifyConfig.onVocEquipStrengthenLevelChange,guid,pos,newlv)
end


function vocEquipController.recv_2_186(guid,pos,item_id)
if pos==0 then
local equip=equipsHelper.getEquip(guid)
vocEquipModel.onChangeEquipByEquip(equip,item_id,guid)
equipsControl.freshBagWindow('onVocEquipStrengthen',guid)
UIManager:callWindowFunc('UIEquipFilterWin','freshListPanel')
else



UIManager:callWindowFunc('UIEquipFilterWin','freshListPanel')
end
local num=vocEquipModel:getSwitch_cnt()+1
vocEquipModel:setSwitch_cnt(num)
UIManager.info('转换成功')
equipsControl.freshWindow('freshEquips')
equipsControl.freshAttrWindow()
end

function vocEquipController.recv_2_187(switch_cnt)
vocEquipModel:setSwitch_cnt(switch_cnt)
end





function vocEquipController.onGuBaoUpdate(gbid)
vocEquipModel:onChangeAttrsOnGuBao(gbid)
end



function vocEquipController:vocEquipZhuanHuanOpen(itemguid,itemid)
UIManager:showWindow("UIZhiYeEquipZHWin",{itemguid=itemguid})
end

function vocEquipController:checkVocEquipZHSystem()
local sysid=cfgHelper.get(cfg_disciplevocequipswitchconfig_get,1,"sys_id")
if sysid and systemModel.isOpen(sysid)then
return true
end
end


function vocEquipController:checkVocEquipZhuanHuanReddot()

if self:checkVocEquipZHSystem()then
local Reddot=userActorSetting.get('VocEquipZHReddot',false)
if Reddot then
return false
else
return true
end
end
return false
end

function vocEquipController:checkVocEquipZhuanHuanReddot_diziid(dzguid)
if self:checkVocEquipZHSystem()then
local Reddot=userActorSetting.get('VocEquipZHReddot',false)
if Reddot then
return false
else
local equip=equipsHelper.getEquipByDizi(dzguid,EQUIP_TYPE.eVocEquip)
if equip then
return true
end
end
end
return false
end

function vocEquipController:checkVocEquipZhuanHuanReddot_Bag()
if self:checkVocEquipZHSystem()then
local Reddot=userActorSetting.get('VocEquipZHReddot',false)
if Reddot then
return false
else
local _cacheFilter={}
_cacheFilter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eVocEquip
return bagControl.hasBagItems(BAG_TYPE.eVocEquip,_cacheFilter)
end
end
return false
end
function vocEquipController.onNewMonth5am()
vocEquipModel:setSwitch_cnt(0)
UIManager:invokeUIMethod("UIZhiYeEquipZHWin","freshonNewMonth5am")
end