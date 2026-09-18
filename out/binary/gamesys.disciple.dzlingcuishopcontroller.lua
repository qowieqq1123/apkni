







local _MODULENAME="dzLingCuiShopController"
gameState.addListener(def_table(_MODULENAME))
dzLingCuiShopController.name=_MODULENAME

local shopNewFlag=nil
local yuanpo2dzidLookup=nil

function dzLingCuiShopController:onAppStart()

end

function dzLingCuiShopController:onEnterState(isReconnet)
dzLingCuiShopController:initData()
notifySystem:listenNotify(notifyConfig.onCommonShopData,self.onCommonShopData)
notifySystem:listenNotify(notifyConfig.onCommonShopChange,self.onCommonShopChange)
notifySystem:listenNotify(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end

function dzLingCuiShopController:onLeaveState(isReconnet)
dzLingCuiShopController:clearData()
notifySystem:removelistener(notifyConfig.onCommonShopData,self.onCommonShopData)
notifySystem:removelistener(notifyConfig.onCommonShopChange,self.onCommonShopChange)
notifySystem:removelistener(notifyConfig.onNewDay5am,self.onNewDay5am)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
end

function dzLingCuiShopController:onPlayerCreate(...)

end

function dzLingCuiShopController:onProtocolReq(isReconnet)

end

function dzLingCuiShopController:onLostConnection()

end

function dzLingCuiShopController:onOpenView(isReconnect)
if mainControl:isInScene(eSceneType.eZongmen)then
local list=dzLingCuiShopController:findFullTianMingItems()
if#list>0 then
msgWinControl:addMsgWin(msgWinType.eUseTianMingItem,{})
end
end
end

function dzLingCuiShopController.on_system_open(sysid,flag)
if flag then
if sysid==SYSTEM_DEFINE.eLingCuiShangDian then
if not UIManager:isActive('UIUseTianMingItemWin')then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.LingCuiShopLuaFunc)
end
end
end
end

function dzLingCuiShopController.onNewDay5am()
dzLingCuiShopController:setShopNewFlag(true)
end

function dzLingCuiShopController.onCommonShopData(shopType)
if shopType==eFuncShopType.eLingCui then
dzLingCuiShopController:setShopNewFlag(nil)
UIManager:invokeUIMethod('UILingCuiShopWin','initView')
end
end

function dzLingCuiShopController.onCommonShopChange(shopType,buyId,buyNum)
if shopType==eFuncShopType.eLingCui then
UIManager:invokeUIMethod('UILingCuiShopWin','refreshItemByID',buyId)
end
end

function dzLingCuiShopController:setShopNewFlag(flag)
shopNewFlag=flag
end

function dzLingCuiShopController:checkNeedNewShopItems()
local shopType=eFuncShopType.eLingCui
local flag=true
if funcShopModel:checkInit(shopType)then
if shopNewFlag==nil then
flag=false
end
end
if flag then
funcShopController.send_23_1(shopType)
end
return flag
end

function dzLingCuiShopController:initData()
yuanpo2dzidLookup={}
local cfgs=cfg_discipleconfig()
for k,cfg in pairs(cfgs)do
local yuanpo=cfg.yuanpo
if yuanpo then
local d=yuanpo2dzidLookup[yuanpo[1]]
if d==nil then
d={}
yuanpo2dzidLookup[yuanpo[1]]=d
end
table.insert(d,cfg.id)
end
end
end

function dzLingCuiShopController:clearData()
shopNewFlag=nil
yuanpo2dzidLookup=nil
end

function dzLingCuiShopController:getYuanPo2dzid(itemid)
return yuanpo2dzidLookup[itemid]
end


function dzLingCuiShopController:findFullTianMingItems()
local list={}
local temp=bagControl.invokeFuncByBagType(BAG_TYPE.eItemBag,'getBagItems')
if temp and#temp>0 then
local lookup={}
for i,v in ipairs(temp)do
local itemid=v.itemid
local dzids=yuanpo2dzidLookup[itemid]
if dzids~=nil then
if lookup[itemid]==nil then
lookup[itemid]={v.itemguid,dzids,0}
end
lookup[itemid][3]=lookup[itemid][3]+v.itemcount
end
end
for itemid,d in pairs(lookup)do

local dzids=d[2]
local itemguid=d[1]
local itemcount=d[3]
local cfg=itemsConfig.getConfig(itemid)
if cfg.funcparam~=nil and cfg.funcparam.type==item_funtion_type.duihuan then
if#dzids>1 then
local f=nil
local diziid=nil
for i,dzid in ipairs(dzids)do
if not UIDiscipleModel:isShuWuDisciple(dzid)then
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
if netData then
f=netData
diziid=dzid
break
else
local glid=liandonModel:CheckDiZi_Guanlian(dzid)

if glid then
local netData2=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(glid)
if netData2 then
f=netData2
diziid=glid
break
end
end
end
end
end
if f then
local itemnum=itemcount
local neednum=UIDiscipleModel:getFullTianMingCostItem(f)
local glitemid
local glnum=0
if diziid then
glitemid,glnum=liandonModel:CheckDiZiItem_Guanlian(diziid)
end

itemnum=itemnum-neednum
if itemnum>0 then
table.insert(list,{itemguid,itemid,itemnum})
if glnum>0 then
local item,glitemguid=bagControl.invokeFuncByItemId(glitemid,'getItemByItemID',glitemid)
table.insert(list,{glitemguid,glitemid,glnum})
end
else
local allnum=itemnum+glnum
if allnum>0 then
if glitemid then

local item,glitemguid=bagControl.invokeFuncByItemId(glitemid,'getItemByItemID',glitemid)
table.insert(list,{glitemguid,glitemid,allnum})
end
end
end
end
else


local dzid=dzids[1]
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
if netData and not UIDiscipleModel:isShuWuDisciple(netData.id)then
local itemnum=itemcount
local neednum=UIDiscipleModel:getFullTianMingCostItem(netData)

itemnum=itemnum-neednum
if itemnum>0 then
table.insert(list,{itemguid,itemid,itemnum})
end
else
local glid=liandonModel:CheckDiZi_Guanlian(dzid)

if glid then
local netData2=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(glid)
if netData2 and not UIDiscipleModel:isShuWuDisciple(netData2.id)then
local itemnum=itemcount
local neednum=UIDiscipleModel:getFullTianMingCostItem(netData2)
local glitemid
local glnum=0

if dzid then
glitemid,glnum=liandonModel:CheckDiZiItem_Guanlian(dzid)
end
glnum=glnum-neednum
if glnum>0 then
if glnum>0 then

table.insert(list,{itemguid,itemid,itemnum})
end
else


local exnum=itemnum+glnum
if exnum>0 then
table.insert(list,{itemguid,itemid,exnum})
end
end
end
end
end

end
end
end
end
return list
end


function dzLingCuiShopController:checkFullTianMingItem(itemid)
local dzids=yuanpo2dzidLookup[itemid]
if dzids~=nil then

local cfg=itemsConfig.getConfig(itemid)
if cfg.funcparam~=nil and cfg.funcparam.type==item_funtion_type.duihuan then
if#dzids>1 then
local f=nil
for i,dzid in ipairs(dzids)do
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
if netData then
f=netData
break
end
end
if f then
local itemnum=itemsModel.getCount(itemid)
local neednum=UIDiscipleModel:getFullTianMingCostItem(f)
itemnum=itemnum-neednum
if itemnum>0 then
return itemnum
end
end
else

local dzid=dzids[1]
local glid=liandonModel:CheckDiZi_Guanlian(dzid)
if not glid then
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
if netData then
local itemnum=itemsModel.getCount(itemid)
local neednum=UIDiscipleModel:getFullTianMingCostItem(netData)
itemnum=itemnum-neednum
if itemnum>0 then
return itemnum
end
end
else

local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
if netData then

local glyuanpoid=liandonModel:CheckDiZiItem_Guanlian(dzid)
local glitemnum=itemsModel.getCount(glyuanpoid)
local itemnum=itemsModel.getCount(itemid)
local neednum=UIDiscipleModel:getFullTianMingCostItem(netData)
local allnum=itemnum+glitemnum-neednum
if allnum>0 then
return allnum





end
else

local glnetData=liandonModel:CheckDiZiActive_Guanlian(dzid)
if glnetData then

local glyuanpoid=liandonModel:CheckDiZiItem_Guanlian(dzid)
local glitemnum=itemsModel.getCount(glyuanpoid)
local itemnum=itemsModel.getCount(itemid)
local neednum=UIDiscipleModel:getFullTianMingCostItem(glnetData)
local allnum=itemnum+glitemnum-neednum
if allnum>0 then
return allnum





end
end
end

end

end
end
end
return nil
end


function dzLingCuiShopController:checkFullTianMingItemEx(itemid)
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemid)
local dzid=dzData.id
local dzCfg=cfgHelper.get1(cfg_discipleconfig_get,dzid)

local cfg=itemsConfig.getConfig(dzCfg.yuanpo[1])
if cfg.funcparam~=nil and cfg.funcparam.type==item_funtion_type.duihuan then

local glid=liandonModel:CheckDiZi_Guanlian(dzid)
if not glid then
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
if netData then
local itemnum=itemsModel.getCount(dzCfg.yuanpo[1])
local neednum=UIDiscipleModel:getFullTianMingCostItem(netData)
itemnum=itemnum-neednum
if itemnum>=0 then
return true,itemnum
end
end
else

local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
if netData then

local glyuanpoid=liandonModel:CheckDiZiItem_Guanlian(dzid)
local glitemnum=itemsModel.getCount(glyuanpoid)
local itemnum=itemsModel.getCount(dzCfg.yuanpo[1])
local neednum=UIDiscipleModel:getFullTianMingCostItem(netData)
local allnum=itemnum+glitemnum-neednum
if allnum>=0 then
return true,allnum





end
else

local glnetData=liandonModel:CheckDiZiActive_Guanlian(dzid)
if glnetData then

local glyuanpoid=liandonModel:CheckDiZiItem_Guanlian(dzid)
local glitemnum=itemsModel.getCount(glyuanpoid)
local itemnum=itemsModel.getCount(dzCfg.yuanpo[1])
local neednum=UIDiscipleModel:getFullTianMingCostItem(glnetData)
local allnum=itemnum+glitemnum-neednum
if allnum>=0 then
return true,allnum





end
end
end
end
end
return false,nil
end