






local _MODULENAME="ClothingController"

gameState.addListener(def_table(_MODULENAME))
ClothingController.name=_MODULENAME
ClothingController.data={}

function ClothingController:onAppStart()

ClothingModel:onAppStart()

socketManager:register_receiver(2,121,self.recv_2_121)
socketManager:register_receiver(2,122,self.recv_2_122)
socketManager:register_receiver(2,123,self.recv_2_123)
socketManager:register_receiver(2,124,self.recv_2_124)
socketManager:register_receiver(2,147,self.recv_2_147)


socketManager:register_receiver(2,120,self.recv_2_120)
end


function ClothingController:onEnterState(isReconnect)
ClothingModel:onEnterState()
end


function ClothingController:onProtocolReq()

end


function ClothingController:onLeaveState(isReconnect)
ClothingModel:onLeaveState(isReconnect)

self.data={}
end


function ClothingController:onLostConnection()

end


function ClothingController:onReConnection(isInitPro)

end

function ClothingController.req_2_122(discipleguid,dressguid)
socketManager:send_2_122(discipleguid,dressguid)
end

function ClothingController.req_2_123(discipleguid)
socketManager:send_2_123(discipleguid)
end

function ClothingController.req_2_124(itemguid,list)




local dzguid=ClothingModel:getDiziguidByItemguid(itemguid)
local guid=dzguid and dzguid or itemguid
local pos=dzguid and 1 or 0
socketManager:send_2_124(guid,pos,#list,list)
end

function ClothingController.req_2_120(discipleguid,hide)
socketManager:send_2_120(discipleguid,hide)
end

function ClothingController.recv_2_120(discipleguid,hide)
ClothingModel:hideDress(discipleguid,hide)

equipsControl.freshWindow('showModel')
equipsControl.freshWindow('onChangeClothing',discipleguid)
UIManager:callWindowFunc("UIDiscipleShiZhuangComponent","recvToggleBtn")
equipsControl.freshWindow('onChangeClothing',discipleguid)
UIManager:callWindowFunc("UIDiscipleRoleInfo2Win","refreshDiscipleInfo")
UIManager:callWindowFunc("UIDiscipleMainWin","refreshDiscipleList")
UIManager:callWindowFunc("UIDiscipleListComponent","freshDZList")

if mainControl:isInScene(eSceneType.eZongmen)then
discipleStateManager:refreshDiscipleModel(discipleguid)
end
if MysteryModel:is_in_mystery()then
mysteryPlayerController.setPlayerModel()
end
end

function ClothingController.recv_2_121(len,list)
ClothingModel:initClotingData(len,list)
end

function ClothingController.recv_2_122(discipleguid,clothingguid)
ClothingModel:onDressEquip(discipleguid,clothingguid)

equipsControl.freshWindow('showModel')
equipsControl.freshWindow('onChangeClothing',discipleguid)
UIManager:callWindowFunc("UIDiscipleShiZhuangComponent","onDressUp",discipleguid)
equipsControl.freshWindow('onChangeClothing',discipleguid)
UIManager:callWindowFunc("UIDiscipleRoleInfo2Win","refreshDiscipleInfo")
UIManager:callWindowFunc("UIDiscipleMainWin","refreshDiscipleList")
UIManager:callWindowFunc("UIDiscipleListComponent","freshDZList")


if mainControl:isInScene(eSceneType.eZongmen)then
discipleStateManager:refreshDiscipleModel(discipleguid)
end
if MysteryModel:is_in_mystery()then
mysteryPlayerController.setPlayerModel()
end

AudioManager.playAudio(632)
end

function ClothingController.recv_2_123(discipleguid)
ClothingModel:onTakeOffEquip(discipleguid)

equipsControl.freshWindow('onChangeClothing',discipleguid)
equipsControl.freshWindow('showModel')
UIManager:callWindowFunc("UIDiscipleShiZhuangComponent","onTakeDown",discipleguid)
UIManager:callWindowFunc("UIDiscipleRoleInfo2Win","refreshDiscipleInfo")
UIManager:callWindowFunc("UIDiscipleMainWin","refreshDiscipleList")
UIManager:callWindowFunc("UIDiscipleListComponent","freshDZList")


equipsControl.freshWindow('onChangeClothing',discipleguid)



if mainControl:isInScene(eSceneType.eZongmen)then
discipleStateManager:refreshDiscipleModel(discipleguid)
end
if MysteryModel:is_in_mystery()then
mysteryPlayerController.setPlayerModel()
end
end

function ClothingController.recv_2_124(guid,pos,star,consumeLen,consumeList)
local diziguid
local equip
if pos==0 then
local oldlv=ClothingModel:getStarLv(guid)
equip=equipsHelper.getEquip(guid)
local oldCollectLv=ClothingModel:getClothingCollectStarLvById(equip.itemid)
ClothingModel:onEquipStar(guid,star)
equipsControl.freshWindow('onChangeClothing',guid)


ClothingController.showUpStarTips(guid,oldlv,star,oldCollectLv)
diziguid=ClothingModel:getDiziguidByItemguid()
else
equip=ClothingModel:getEquipByDizi(guid)
local itemguid=equip.itemguid
local oldlv=ClothingModel:getStarByDizi(guid)
local oldCollectLv=ClothingModel:getClothingCollectStarLvById(equip.itemid)
ClothingModel:onEquipStarByDizi(guid,star)
equipsControl.freshWindow('onChangeClothing',guid)

ClothingController.showUpStarTips(itemguid,oldlv,star,oldCollectLv)
diziguid=guid
end

if equip and equip.itemData and consumeLen>0 and consumeList~=nil then

if equip.itemData.consumeLlist==nil then
equip.itemData.consumeLlist=consumeList
equip.itemData.consumeListLen=consumeLen
else
local list={}
local flist={}
for i,v in ipairs(consumeList)do
list[v.param_1]=v.param_2
end
for i,v in ipairs(equip.itemData.consumeLlist)do
list[v.param_1]=(list[v.param_1]or 0)+v.param_2
end

for i,v in pairs(list)do
table.insert(flist,{param_1=i,param_2=v})
end
equip.itemData.consumeListLen=#flist
equip.itemData.consumeLlist=flist
end


end

equipsControl.freshWindow('showModel')
UIManager:callWindowFunc("UIDiscipleShiZhuangComponent","onStarUp")
UIManager:callWindowFunc("UIDiscipleShiZhuangStarWin","freshInfo")
UIManager:callWindowFunc("UIDiscipleRoleInfo2Win","refreshDiscipleInfo")
UIManager:callWindowFunc("UIDiscipleMainWin","refreshDiscipleList")
UIManager:callWindowFunc("UIDiscipleListComponent","freshDZList")
equipsControl.freshAttrWindow()
notifySystem:postNotify(notifyConfig.onDressEquipUpStar)

if mainControl:isInScene(eSceneType.eZongmen)then
if diziguid then
discipleStateManager:refreshDiscipleModel(diziguid)
end
end
if MysteryModel:is_in_mystery()then
mysteryPlayerController.setPlayerModel()
end
end

function ClothingController:showClotingSelectWin(itemguid,selectList,baglist,call)
local args={}
args.titleName="时装列表"
args.pos=1
args.extraWin='UIDaoBingSelectWin'
local extraParams={}



extraParams.selectList=selectList

extraParams.list=baglist
extraParams.call=call
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function ClothingController.showUpStarTips(itemguid,oldlv,newlv,oldCollectLv)
if UIManager:isActive('UIDiscipleShiZhuangStarUpWin')then
UIManager:closeWindow('UIDiscipleShiZhuangStarUpWin')
end
UIManager:showWindow('UIDiscipleShiZhuangStarUpWin',{itemguid,oldlv,newlv,oldCollectLv})

end

function ClothingController.fastDressClothing(itemid,itemguid,num)
local diziguid=ClothingHelper.findDizi(itemid,nil,true)
if diziguid then


oneTabScreenController:openUI(SEC_FULL_TYPE.discipleClothing,{guid=diziguid,sortType=eDiscipleSortType.eClothing,checkClothing=true})
end
end


function ClothingController.reqDiscipleFashionReset(guid,pos)
socketManager:send_2_147(guid,pos)
end

function ClothingController.recv_2_147(guid,pos)
UIManager.info("时装重置成功")

local star=0
local diziguid
local equip
if pos==0 then
equip=equipsHelper.getEquip(guid)
ClothingModel:onEquipStar(guid,star)
equipsControl.freshWindow('onChangeClothing',guid)

diziguid=ClothingModel:getDiziguidByItemguid()
else
equip=ClothingModel:getEquipByDizi(guid)
ClothingModel:onEquipStarByDizi(guid,star)
equipsControl.freshWindow('onChangeClothing',guid)

diziguid=guid
end


if equip and equip.itemData then
equip.itemData.consumeListLen=0
equip.itemData.consumeLlist=nil
end

equipsControl.freshWindow('showModel')
UIManager:callWindowFunc("UIDiscipleShiZhuangComponent","onStarUp")
UIManager:callWindowFunc("UIDiscipleShiZhuangStarWin","freshInfo")
UIManager:callWindowFunc("UIDiscipleRoleInfo2Win","refreshDiscipleInfo")
UIManager:callWindowFunc("UIDiscipleMainWin","refreshDiscipleList")
UIManager:callWindowFunc("UIDiscipleListComponent","freshDZList")
equipsControl.freshAttrWindow()


if mainControl:isInScene(eSceneType.eZongmen)then
if diziguid then
discipleStateManager:refreshDiscipleModel(diziguid)
end
end
if MysteryModel:is_in_mystery()then
mysteryPlayerController.setPlayerModel()
end

UIManager:closeWindow("UIDiscipleFashionClothResetWin")
end