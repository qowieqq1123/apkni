






local _MODULENAME="daobingController"

gameState.addListener(def_table(_MODULENAME))
daobingController.name=_MODULENAME
daobingController.data={}

function daobingController:onAppStart()

daobingModel:onAppStart()


socketManager:register_receiver(2,94,daobingController.recv_2_94)
socketManager:register_receiver(2,95,daobingController.recv_2_95)
socketManager:register_receiver(2,96,daobingController.recv_2_96)
socketManager:register_receiver(2,97,daobingController.recv_2_97)
socketManager:register_receiver(2,98,daobingController.recv_2_98)
socketManager:register_receiver(2,99,daobingController.recv_2_99)



























end


function daobingController:onEnterState(isReconnect)
daobingModel:onEnterState()
end


function daobingController:onProtocolReq()
end


function daobingController:onLeaveState(isReconnect)
daobingModel:onLeaveState(isReconnect)

self.data={}
end


function daobingController:onLostConnection()

end


function daobingController:onReConnection(isInitPro)

end






function daobingController.recv_2_94(diziguid,daobingguid)
daobingModel:onDressEquip(diziguid,daobingguid)
local equipType=EQUIP_TYPE.eDaoBing
equipsControl.freshWindow('onChangeItem',diziguid,equipType)
equipsControl.freshAttrWindow()
UIManager:callWindowFunc('UIEquipFilterWin','onDressEquip',diziguid,equipType)
UIManager.info('装备成功')

AudioManager.playAudio(632)
end




function daobingController.recv_2_95(diziguid,pos)
local equipType=EQUIP_TYPE.eDaoBing
daobingModel:onTakeOffEquip(diziguid)
equipsControl.freshWindow('onChangeItem',diziguid,equipType)
equipsControl.freshAttrWindow()
end









function daobingController.recv_2_96(guid,pos,level)
if pos==0 then
local oldlv=daobingModel:getJilianLv(guid)
daobingController.showLxUpTips(guid,oldlv,level)
daobingModel:onJilian(guid,level)
equipsControl.freshBagWindow('onEquipJinglian',guid)
UIManager:callWindowFunc('UIDaoBingBagWin','onChangItemRet',guid)
UIManager:callWindowFunc('UIDaoBingUpWin','onJinglianRet',guid,oldlv,level)
UIManager:callWindowFunc('UIBagWin','freshItemByGuid',guid)
else
local equip=daobingModel:getEquipByDizi(guid)
local itemguid=equip.itemguid
local oldlv=daobingModel:getJilianLvByDizi(guid)
daobingController.showLxUpTips(itemguid,oldlv,level)
daobingModel:onJilianByDizi(guid,level)
equipsControl.freshWindow('onChangeDaoBing',guid)
UIManager:callWindowFunc('UIDaoBingBagWin','onChangItemRet',itemguid)
UIManager:callWindowFunc('UIDaoBingUpWin','onJinglianRet',itemguid,oldlv,level)
end
notifySystem:postNotify(notifyConfig.onDaoBingJingLianChange,guid,pos,level)
equipsControl.freshAttrWindow()
end










function daobingController.recv_2_97(guid,pos,star,num)

if pos==0 then
local oldlv=daobingModel:getStarLv(guid)
daobingModel:onEquipStar(guid,star)
equipsControl.freshBagWindow('onEquipStar',guid)
UIManager:callWindowFunc('UIDaoBingUpWin','onStarRet',guid,oldlv,star)
UIManager:callWindowFunc('UIDaoBingBagWin','onChangItemRet',guid)
UIManager:callWindowFunc('UIBagWin','freshItemByGuid',guid)
daobingController.showUpStarTips(guid,oldlv,star)
local equip=equipsHelper.getEquip(guid)
if equip then
local equipitemid=equip.itemid
local itemData=equip.itemData
itemData.num=num
end
else
local equip=daobingModel:getEquipByDizi(guid)
local itemguid=equip.itemguid
local oldlv=daobingModel:getStarByDizi(guid)
daobingModel:onEquipStarByDizi(guid,star)
equipsControl.freshWindow('onChangeDaoBing',guid)
UIManager:callWindowFunc('UIDaoBingUpWin','onStarRet',itemguid,oldlv,star)
UIManager:callWindowFunc('UIDaoBingBagWin','onChangItemRet',itemguid)
daobingController.showUpStarTips(itemguid,oldlv,star)
local equip=daobingModel:getEquipByDizi(guid)
if equip then
local equipitemid=equip.itemid
local itemData=equip.itemData
itemData.num=num
end
end


notifySystem:postNotify(notifyConfig.onDaoBingStarChange,guid,pos,star)
equipsControl.freshAttrWindow()
end

function daobingController.recv_2_98(itemid,cnt)
end


function daobingController.recv_2_99(guid,pos)
if pos==0 then
local oldlv=daobingModel:getJilianLv(guid)

daobingModel:onJilian(guid,0)
equipsControl.freshBagWindow('onEquipJinglian',guid)
UIManager:callWindowFunc('UIDaoBingBagWin','onChangItemRet',guid)
UIManager:callWindowFunc('UIDaoBingUpWin','onJinglianRet',guid,oldlv,0)
UIManager:callWindowFunc('UIBagWin','freshItemByGuid',guid)
else
local equip=daobingModel:getEquipByDizi(guid)
local itemguid=equip.itemguid
local oldlv=daobingModel:getJilianLvByDizi(guid)

daobingModel:onJilianByDizi(guid,0)
equipsControl.freshWindow('onChangeDaoBing',guid)
UIManager:callWindowFunc('UIDaoBingBagWin','onChangItemRet',itemguid)
UIManager:callWindowFunc('UIDaoBingUpWin','onJinglianRet',itemguid,oldlv,0)
end
notifySystem:postNotify(notifyConfig.onDaoBingJingLianChange,guid,pos,0)

if pos==0 then
local oldlv=daobingModel:getStarLv(guid)
daobingModel:onEquipStar(guid,0)
equipsControl.freshBagWindow('onEquipStar',guid)
UIManager:callWindowFunc('UIDaoBingUpWin','onStarRet',guid,oldlv,0)
UIManager:callWindowFunc('UIDaoBingBagWin','onChangItemRet',guid)
UIManager:callWindowFunc('UIBagWin','freshItemByGuid',guid)

else
local equip=daobingModel:getEquipByDizi(guid)
local itemguid=equip.itemguid
local oldlv=daobingModel:getStarByDizi(guid)
daobingModel:onEquipStarByDizi(guid,0)
equipsControl.freshWindow('onChangeDaoBing',guid)
UIManager:callWindowFunc('UIDaoBingUpWin','onStarRet',itemguid,oldlv,0)
UIManager:callWindowFunc('UIDaoBingBagWin','onChangItemRet',itemguid)

end
notifySystem:postNotify(notifyConfig.onDaoBingStarChange,guid,pos,0)
equipsControl.freshAttrWindow()
end






function daobingController.reqDress(diziguid,equipguid)
socketManager:send_2_94(diziguid,equipguid)
end

function daobingController.reqTakeOff(diziguid)
local equip=daobingModel:getEquipByDizi(diziguid)
if equip==nil then return end
local itemid=equip.itemid
local itemsCfg=itemsConfig.getConfig(itemid)
socketManager:send_2_95(diziguid,itemsCfg.type1)
end

function daobingController.reqJinglian(itemguid,times)
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemsCfg=itemsConfig.getConfig(itemid)
local type1=itemsCfg.type1
local dzguid=daobingModel:getDiziguidByItemguid(itemguid)
local guid=dzguid and dzguid or itemguid
local pos=dzguid and type1 or 0
socketManager:send_2_96(guid,pos,times)
end

function daobingController.reqStar(itemguid,list)
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
local itemsCfg=itemsConfig.getConfig(itemid)
local type1=itemsCfg.type1
local dzguid=daobingModel:getDiziguidByItemguid(itemguid)
local guid=dzguid and dzguid or itemguid
local pos=dzguid and type1 or 0
socketManager:send_2_97(guid,pos,#list,list)
end

function daobingController.reqCombine(itemid,cnt)
socketManager:send_2_98(itemid,cnt)
end


function daobingController.reqResetDaoBing(guid)
local dzguid=daobingModel:getDiziguidByItemguid(guid)
local guid=dzguid and dzguid or guid
local pos=dzguid and 1 or 0
socketManager:send_2_99(guid,pos)
end



function daobingController.showLxUpTips(itemguid,oldlv,newlv)
if oldlv==newlv then return end
local equip=daobingHelper.getEquip(itemguid)
local starlv=daobingModel:getStarLvByEquip(equip)
local itemid=equip.itemid
local nexttplv=daobingConfig.getNextTuPoLv(itemid,oldlv)
local isTuPo=newlv==nexttplv
local itemCfg=itemsConfig.getConfig(itemid)

local baseAttrList=daobingHelper.getBaseAttrsList(itemCfg)
local baseAttrLookup=daobingHelper.getEquipBaseAttrsLookupByItemid(itemid,starlv,oldlv)
local nextAttrLookup=daobingHelper.getEquipBaseAttrsLookupByItemid(itemid,starlv,newlv)

local strs={}
for i,v in ipairs(baseAttrList)do
local attrType=v[1]
local old=baseAttrLookup[attrType]or 0
local new=nextAttrLookup[attrType]or 0
local add=new-old
local name,str=equipsHelper.getAttr(attrType,add)
strs[#strs+1]=FMT.fmt('{0}<color=#aae252>+{1}</color>',name,str)
end
local args={}
args.effect=isTuPo and 10255 or 10253
args.strs=strs
if UIManager:isActive('UIUpFlowWin')then
UIManager:closeWindow('UIUpFlowWin')
end
UIManager:showWindow('UIUpFlowWin',args)

AudioManager.playAudio(576)
end

function daobingController.showUpStarTips(itemguid,oldlv,newlv)
if UIManager:isActive('UIDaoBingUpStarSuccessWin')then
UIManager:closeWindow('UIDaoBingUpStarSuccessWin')
end
UIManager:showWindow('UIDaoBingUpStarSuccessWin',{itemguid,oldlv,newlv})

end
