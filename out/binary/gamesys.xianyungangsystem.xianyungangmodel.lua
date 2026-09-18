






local _MODULENAME="XianYunGangModel"


def_table(_MODULENAME)
XianYunGangModel.name=_MODULENAME
XianYunGangModel.data={}

local _reddotFlag=nil


function XianYunGangModel:onAppStart()

end


function XianYunGangModel:onEnterState(isReconnect)
XianYunGangModel:initYunZhouComponentsWarehouseFilterData()
end


function XianYunGangModel:onProtocolReq()

end


function XianYunGangModel:onLeaveState(isReconnect)

self.data={}
self.filterData=nil
self.xygReddot=nil
_reddotFlag=nil
end



function XianYunGangModel:initBoatShow()
local list=cfg_fairylandboatconfig()
for i,v in pairs(list)do
XianYunGangModel:setBoatShow(v.id)
end
end

function XianYunGangModel:setBoatShow(id)
if not zongmenControl:isMountid(mapIdType.fort)then
return
end
local cfg=cfgHelper.get1(cfg_fairylandboatconfig_get,id)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,cfg.build_id)
if bdData and bdData.entityId then
local dzList=xianjieModel:getXJYZChuZhenTeamList(id)
if dzList then
_MapManager.SetFadeToColor(bdData.entityId,Color.New(1,1,1,0),0,nil)
else
_MapManager.SetFadeToColor(bdData.entityId,Color.New(1,1,1,1),0,nil)
end
end
UIManager:invokeUIMethod("UIXianYunGangWin","refresh")
end

function XianYunGangModel:setBoatList(boat_list_len,boat_list)
if not self.data.boatList then
self.data.boatList={}
end
for i=1,boat_list_len do
local data=boat_list[i]
self.data.boatList[data.boatid]=data
end
XianYunGangModel:refreshBoatList()
XianYunGangModel:refreshCanBuildBoatList()
end


function XianYunGangModel:getIsBoatBybdId(build_id)
if not self.data.bdIdBylookup then
self.data.bdIdBylookup={}
local cfgs=cfg_fairylandboatconfig()
for i,v in ipairs(cfgs)do
self.data.bdIdBylookup[tostring(v.build_id)]=true
end
end
return self.data.bdIdBylookup[tostring(build_id)]
end


function XianYunGangModel:refreshBoatList()
if not self.data.boatList then
self.data.unlockBoatList={}
return
end
local list={}
for i,v in pairs(self.data.boatList)do
local cfg=cfgHelper.get1(cfg_fairylandboatconfig_get,v.boatid)
if cfg then
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,cfg.build_id)
if bdData and bdData.flag~=buildingStateType.eBuilding then
v.name=bdData.name
table.insert(list,v)
end
end
end
self.data.unlockBoatList=list
end


function XianYunGangModel:getBoatList()
return self.data.unlockBoatList
end


function XianYunGangModel:refreshCanBuildBoatList()
local list={}
local cfgs=cfg_fairylandboatconfig()
for i,v in ipairs(cfgs)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
local isOpen,tipsData=XianYunGangModel:checkRepairBuildOpen(cfg)
if isOpen then
table.insert(list,v)
end
end
self.data.canBuildBoatList=list

XianYunGangModel:setBoatMoneyLookup()
XianYunGangModel:setReddotFlag(true)
end


function XianYunGangModel:getCanBuildBoatList()
return self.data.canBuildBoatList
end


function XianYunGangModel:getEquipdBoatList()
if not self.data.boatList then
return{}
end
local list={}
for i,v in pairs(self.data.boatList)do
local cfg=cfgHelper.get1(cfg_fairylandboatconfig_get,v.boatid)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,cfg.build_id)
if v.zq4List and#v.zq4List>0 and bdData and bdData.flag~=buildingStateType.eBuilding then
v.name=bdData.name
table.insert(list,v)
end
end
if#list>1 then
table.sort(list,function(a,b)
return a.boatid<b.boatid
end)
end
return list
end

function XianYunGangModel:getBoatData(boatid)
if not self.data.boatList then
return nil
end
return self.data.boatList[boatid]
end


function XianYunGangModel:getMyAllBoatFight()
local totlefortfight=0
local list=XianYunGangModel:getBoatList()
for i=1,#list do
local fortfight=XianYunGangModel:getBoatFightEx(list[i])
totlefortfight=totlefortfight+fortfight
end
return totlefortfight
end


function XianYunGangModel:getMyAllBoatEquipAttrList()
local attrList={}
local list=XianYunGangModel:getBoatList()
for i=1,#list do
local yunZhouComponentsAttrsLookup=XianYunGangModel:getYunZhouComponentsAttrsLookup(list[i].boatid)
attrList=attrListHelper.concatLookup(attrList,yunZhouComponentsAttrsLookup)
end
return attrList
end


function XianYunGangModel:getBoatFight(boatData)
local fortfight1=XianYunGangModel:getBoatBuildFight(boatData)
local fortfight2=XianYunGangModel:getBoatFightEx(boatData)
return fortfight1+fortfight2
end


function XianYunGangModel:getBoatFightEx(boatData)
local fortfight=0

local zq4List=boatData.zq4List or{}
for i,v in ipairs(zq4List)do
local itemid=v.itemid
local jinglianlv=v.itemData and v.itemData.jinglianlv or 0
local config=itemsConfig.getConfig(itemid)
local jinglianConfig=cfgHelper.get1(cfg_boatequipenhanceconfig_get,jinglianlv)
fortfight=fortfight+(config.fortfight or 0)+(jinglianConfig.fortfight or 0)
end
return fortfight
end


function XianYunGangModel:getBoatBuildFight(boatData)
local boatCfg=cfgHelper.get1(cfg_fairylandboatconfig_get,boatData.boatid)
local lvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,boatCfg.build_id,1)
local fortfight=lvCfg.fortfight or 0
return fortfight
end


function XianYunGangModel:getYunZhouComponentsData(boatid)
if not self.data.boatList or not self.data.boatList[boatid]then
return nil
end
local data=self.data.boatList[boatid]
local zq4listlen=data.zq4listlen
local zq4List=data.zq4List
return zq4List
end

function XianYunGangModel:setYunZhouComponentsPosData(boatid,itemguid,pos)
if not self.data.boatList or not self.data.boatList[boatid]then
return nil
end
if itemguid==0 then
local data=self.data.boatList[boatid]
local zq4List=data.zq4List or{}
local removeIdx
for i,v in ipairs(zq4List)do
local itemid=v.itemid
local type1=itemsConfig.getConfig(itemid).type1
if type1==pos then
removeIdx=i
break
end
end
if removeIdx then
table.remove(zq4List,removeIdx)
data.zq4listlen=data.zq4listlen-1
end
notifySystem:postNotify(notifyConfig.onYunZhouZhenQiPosChange)
return
end
local item=bagModel.getItem(itemguid)
if item==nil then
logErr('背包云舟阵器不存在',itemguid)
return
end
local pos=itemsConfig.getConfig(item.itemid).type1
local data=self.data.boatList[boatid]
data.zq4List=data.zq4List or{}
local zq4List=data.zq4List

local isReplace=false
for i,v in ipairs(zq4List)do
local itemid=v.itemid
local type1=itemsConfig.getConfig(itemid).type1
if type1==pos then
isReplace=true
v.itemguid=item.itemguid
v.itemid=item.itemid
v.itemcount=item.itemcount
v.itemflag=item.itemflag
v.itemData=item.itemData
v.itemtime=item.itemtime
break
end
end
if not isReplace then
local itemStruct={
itemguid=item.itemguid,
itemid=item.itemid,
itemcount=item.itemcount,
itemflag=item.itemflag,
itemData=item.itemData,
itemtime=item.itemtime,
}
table.insert(zq4List,itemStruct)
end
data.zq4listlen=#zq4List
notifySystem:postNotify(notifyConfig.onYunZhouZhenQiPosChange)

end








function XianYunGangModel:getYunZhouComponentsPosData(boatid,pos)
if not self.data.boatList or not self.data.boatList[boatid]then
return nil
end
local data=self.data.boatList[boatid]
local zq4listlen=data.zq4listlen
local zq4List=data.zq4List
for i,v in ipairs(zq4List or{})do
local itemid=v.itemid
local type1=itemsConfig.getConfig(itemid).type1
if type1==pos then
return v
end
end
return nil
end

function XianYunGangModel:setYunZhouComponentsStrengthenData(guid,pos,level,exp)
if pos==0 then
local item=bagModel.getItem(guid)
if item==nil then
logErr('背包云舟阵器不存在',guid)
return
end
local otherData=item.itemData
otherData.jinglianlv=level
otherData.jinglianexp=exp
else
local boatid=tonumber(tostring(guid))
if not self.data.boatList or not self.data.boatList[boatid]then
logErr('云舟数据不存在',boatid)
return
end
local data=self.data.boatList[boatid]
local zq4listlen=data.zq4listlen
local zq4List=data.zq4List
local check=false
for i,v in ipairs(zq4List or{})do
local itemid=v.itemid
local type1=itemsConfig.getConfig(itemid).type1
if type1==pos then
check=true
local otherData=v.itemData
otherData.jinglianlv=level
otherData.jinglianexp=exp
break
end
end
if not check then
logErr(string.format('云舟穿戴中阵器不存在该部位阵器  云舟id：%d 部位：%d',boatid,pos))
end
end
end

function XianYunGangModel:getYunZhouComponentsStrengthenData(boatid,pos)
if not self.data.boatList or not self.data.boatList[boatid]then
return nil
end
local data=self.data.boatList[boatid]
local zq4listlen=data.zq4listlen
local zq4List=data.zq4List
for i,v in ipairs(zq4List or{})do
local itemid=v.itemid
local type1=itemsConfig.getConfig(itemid).type1
if type1==pos then
local otherData=v.itemData
return{otherData.jinglianlv,otherData.jinglianexp}
end
end
return nil
end

function XianYunGangModel:getYunZhouComponentsSuitData(boatid)
if not self.data.boatList or not self.data.boatList[boatid]then
return{}
end
local data=self.data.boatList[boatid]
local zq4listlen=data.zq4listlen
local zq4List=data.zq4List
local suitData={}
for i,v in ipairs(zq4List or{})do
local itemid=v.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local suitid=itemConfig.type2
local color=itemConfig.color
if not suitData[suitid]then
suitData[suitid]={}
local data=suitData[suitid]
data.num=1
data.lv=color
else
local data=suitData[suitid]
data.num=data.num+1
data.lv=math.min(data.lv,color)
end
end
return suitData
end


function XianYunGangModel:getOtherPlayerYunZhouComponentsSuitData(zq4List)
local suitData={}
for i,v in ipairs(zq4List or{})do
local itemid=v.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local suitid=itemConfig.type2
local color=itemConfig.color
if not suitData[suitid]then
suitData[suitid]={}
local data=suitData[suitid]
data.num=1
data.lv=color
else
local data=suitData[suitid]
data.num=data.num+1
data.lv=math.min(data.lv,color)
end
end
return suitData
end

function XianYunGangModel:initYunZhouComponentsWarehouseFilterData()
self.filterData={}
self.filterData[1]=eQualityColor.eRed
local filterType={}
for i=1,3 do
filterType[i]=true
end
self.filterData[2]=filterType
end


function XianYunGangModel:setYunZhouComponentsWarehouseFilterData(data)
self.filterData=data
end

function XianYunGangModel:getYunZhouComponentsWarehouseFilterData()
if not self.filterData then
self:initYunZhouComponentsWarehouseFilterData()
end
return self.filterData
end

function XianYunGangModel:checkRepairBuildOpen(cfg)
if cfg.repair_tips then
local tipsData
for i,v in ipairs(cfg.repair_tips)do
local pass=isometricMapSystem:checkRepairTips(v)
if not pass then
tipsData=v
break
end
end
return tipsData==nil,tipsData
end
return true
end





function XianYunGangModel:getYunZhouZhenQiStar(boatid,color,star)
local zq4List=XianYunGangModel:getYunZhouComponentsData(boatid)
if not zq4List then
return 0
end
local num=0
for k,v in ipairs(zq4List)do
local itemid=v.itemid
local cfg=itemsConfig.getConfig(itemid)
local itemcolor=cfg.color
local stage=cfg.stage
if stage>=star and itemcolor>=color then
num=num+1
end
end
return num
end



function XianYunGangModel:getYunZhouZhenQiLv(boatid,lv)
local zq4List=XianYunGangModel:getYunZhouComponentsData(boatid)
if not zq4List then
return 0
end
local num=0
for k,v in ipairs(zq4List)do
local itemid=v.itemid
local itemData=v.itemData
local jinglianlv=itemData.jinglianlv
if jinglianlv>=lv then
num=num+1
end
end
return num
end




function XianYunGangModel:GetAllYunZhouZhenQiStar(color,star)
if not self.data.boatList or not color or not star then
return 0
end
local allnum=0
for i,v in pairs(self.data.boatList)do
local num=XianYunGangModel:getYunZhouZhenQiStar(v.boatid,color,star)
allnum=allnum+num
end
return allnum
end


function XianYunGangModel:GetAllYunZhouZhenQiLv(lv)
if not self.data.boatList or not lv then
return 0
end
local allnum=0
for i,v in pairs(self.data.boatList)do
local num=XianYunGangModel:getYunZhouZhenQiLv(v.boatid,lv)
allnum=allnum+num
end
return allnum
end

function XianYunGangModel:checkOpen()
return XianYunGangController:getBuildingLevel()>0
end

function XianYunGangModel:checkReddot()
if not XianYunGangModel:checkOpen()then
return false
end
XianYunGangModel:refreshReddot()
return self.xygReddot
end

function XianYunGangModel:setReddotFlag(flag)
_reddotFlag=flag
end

function XianYunGangModel:refreshReddot()
if not _reddotFlag then
return
end
_reddotFlag=false

local cfgs=cfg_fairylandboatconfig()
for i,v in ipairs(cfgs)do
local _data=isometricMapSystem:getRepairDataByID(mapIdType.fort,v.build_id)
if _data then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
local isOpen,tipsData=XianYunGangModel:checkRepairBuildOpen(cfg)
if isOpen and XianYunGangModel:getIsCanBuild(v.build_id,false)then
self.xygReddot=true
return
end
else
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,v.build_id)
if bdData.flag==buildingStateType.eBuilding then
local cddata=buildingCDControl:getCDData(buildingCDType.build,bdData.un_build_id)
if cddata.complete then
self.xygReddot=true
return
end
end
end
end
self.xygReddot=false
end

function XianYunGangModel:setBoatMoneyLookup()
self.boatMoneyLookup={}
local cfgs=cfg_fairylandboatconfig()
for i,v in ipairs(cfgs)do
local _data=isometricMapSystem:getRepairDataByID(mapIdType.fort,v.build_id)
if _data then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
for ii,vv in ipairs(cfg.repair_cost[1])do
if moneyConfig.isMoney(vv[1])then
self.boatMoneyLookup[vv[1]]=true
end
end
end
end
end

function XianYunGangModel:getIsBoatMoney(moneyType)
return self.boatMoneyLookup and self.boatMoneyLookup[moneyType]~=nil
end

function XianYunGangModel:getIsCanBuild(build_id,wraning)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,build_id)
local lvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,build_id,1)
local _data=isometricMapSystem:getRepairDataByID(mapIdType.fort,build_id)

if not isometricMapSystem:checkRepairLevel(_data.id,_data.mapId,wraning)then
return false
end

if not isometricMapSystem:checkRepairTask(_data.id,_data.mapId,wraning)then
return false
end

if not zongmenControl:checkCondition(lvCfg,wraning,mapIdType.fort)then
return false
end

if not isometricMapSystem:checkRepairCost(cfg,nil,wraning)then
return false
end
return true
end


function XianYunGangModel:checkYZEquipsNum(num,level,color)
local now_num=0
local yzList=self:getBoatList()
if yzList then
for i,v in ipairs(yzList)do
local boatid=v.boatid
for idx=1,3 do
local equip=XianYunGangModel:getYunZhouComponentsPosData(boatid,idx)
if equip then
local itemConfig=itemsConfig.getConfig(equip.itemid)
local itemcolor=itemConfig.color
local stage=itemConfig.stage
if stage>=level then
if itemcolor>=color then
now_num=now_num+1
end
end
end
end
end
end
if now_num<num then
local bagList=bagControl.getBagItemsByFilter(BAG_TYPE.eYunZhou)
if bagList then
for i,v in ipairs(bagList)do
local itemConfig=itemsConfig.getConfig(v.itemid)
local itemcolor=itemConfig.color
local stage=itemConfig.stage
if stage>=level then
if itemcolor>=color then
now_num=now_num+1
end
end
end
end
end
return now_num>=num
end