






local _MODULENAME="zongmenBuildingSuitModel"




def_table(_MODULENAME)
zongmenBuildingSuitModel.name=_MODULENAME

zongmenBuildingSuitModel.data={}



zongmenBuildingSuitModel.fastlookup_build2suit={}
zongmenBuildingSuitModel.fastlookup_suit2build={}
zongmenBuildingSuitModel.fastlookup_item2build={}
zongmenBuildingSuitModel.fastlookup_build2item={}
zongmenBuildingSuitModel.fastlookup_partbd2suit={}


function zongmenBuildingSuitModel:onAppStart()

end


function zongmenBuildingSuitModel:onEnterState(isReconnect)

end


function zongmenBuildingSuitModel:onLeaveState(isReconnect)

self.data={}
self.ready={}
end

function zongmenBuildingSuitModel:onProtocolReq()

end



function zongmenBuildingSuitModel:setActives(list)
self.data={}
if list then
for i,v in ipairs(list)do
self.data[v.param_1]=v.param_2==1
end
end
end

function zongmenBuildingSuitModel:getActive(id)
return self.data[id]~=nil
end

function zongmenBuildingSuitModel:setActive(id)
self.data[id]=false
end

function zongmenBuildingSuitModel:setReward(id)
self.data[id]=true
end

function zongmenBuildingSuitModel:getReward(id)
return self.data[id]
end

function zongmenBuildingSuitModel:pushReady(sfId,x,y,bdId,orientation,callback)
local data={
sfId=sfId,
x=x,
y=y,
bdId=bdId,
orientation=orientation,
callback=callback,
}
table.insert(self.ready,data)
end

function zongmenBuildingSuitModel:popReady()
local readyData=table.remove(self.ready,1)
if readyData then
if readyData.callback then
readyData.callback(sfId,x,y,bdId,orientation)
end
else
loggerUtil.logErrFMT("不存在对应格子检查数据")
end
end

function zongmenBuildingSuitModel:clearReady()
self.ready={}
end









function zongmenBuildingSuitModel:checkEnough(id)
local cfg=cfgHelper.get1(cfg_buildsuitconfig_get,id)
for i,v in ipairs(cfg.needbuild)do
local neednum=v[2]
local havenum=self:getPartCount(id,i)
if neednum>havenum then
return false
end
end

if cfg.needroad then
for i,v in ipairs(cfg.needroad)do
if not zongmenModel:isActiveRoad(v)then
return false
end
end
end
return true
end

function zongmenBuildingSuitModel:checkShow(id)
local cfg=cfgHelper.get1(cfg_buildsuitconfig_get,id)
if cfg.show==1 then
for i,v in ipairs(cfg.needbuild)do
local havenum=self:getPartCount(id,i)
if havenum>0 then
return true
end
end
if cfg.needroad then
for i,v in ipairs(cfg.needroad)do
if zongmenModel:isActiveRoad(v)then
return true
end
end
end
return false
elseif cfg.show==2 then
for i,v in ipairs(cfg.needbuild)do
local neednum=v[2]
local havenum=self:getPartCount(id,i)
if neednum>havenum then
return false
end
end
if cfg.needroad then
for i,v in ipairs(cfg.needroad)do
if not zongmenModel:isActiveRoad(v)then
return false
end
end
end
return true
end
return true
end

function zongmenBuildingSuitModel:getPartCount(id,part)
local buildid=cfgHelper.get4(cfg_buildsuitconfig_get,id,"needbuild",part,1)
local itemid=self:findPartItemByBuilding(buildid)
local itemnum=bagModel.getItemCountById(itemid)
local storgenum=zongmenModel:findStorageCountByID(buildid)

local buildnum=0
local buildNumList={}
local checkSfIdList={mapIdType.zhufeng,mapIdType.lingshoudao}
for _,sfId in ipairs(checkSfIdList)do
local num=zongmenModel:findBuildingCountByID(sfId,buildid)
buildnum=buildnum+num
buildNumList[sfId]=num
end

return itemnum+storgenum+buildnum,itemnum,storgenum,buildnum,buildNumList
end

function zongmenBuildingSuitModel:getReddot(id)
local active=self:getActive(id)
if active then
return not self:getReward(id)
else
return self:checkEnough(id)
end
end

function zongmenBuildingSuitModel:checkReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eBuildSuit)then
return false
end
local cfg=cfg_buildsuitconfig()
for i,v in pairs(cfg)do
if self:getReddot(i)then
return true
end
end
return false
end





function zongmenBuildingSuitModel:findSuitIdByPartBuildID(bdId)
if self.fastlookup_partbd2suit[bdId]then
return self.fastlookup_partbd2suit[bdId]
end
local cfg=cfg_buildsuitconfig()
for i,v in pairs(cfg)do
for j,w in ipairs(v.needbuild)do
if w[1]==bdId then
self.fastlookup_partbd2suit[bdId]=v.id
return v.id
end
end
end
end

function zongmenBuildingSuitModel:findPartItemByBuilding(bdId)
if self.fastlookup_build2item[bdId]then
return self.fastlookup_build2item[bdId]
end
local upCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdId,1)
local costList=upCfg.uplevel_cost



local firstCost=costList[1]
self.fastlookup_build2item[bdId]=firstCost[1]
return firstCost[1]
end

function zongmenBuildingSuitModel:findPartBuildingByItem(itemId)
if self.fastlookup_item2build[itemId]then
return self.fastlookup_item2build[itemId]
end
local itemCfg=itemsConfig.getConfig(itemId)
local jumpParam=itemCfg.jump
if jumpParam then
if jumpParam.args.id==JUMP_TYPE.eLayout then
local bdId=jumpParam.args.bdId or jumpParam.fastBuildId
self.fastlookup_item2build[itemId]=bdId
return bdId
end
end
local upCfg=cfg_monijybuilduplvlconfig()
for bdId,bdUp in pairs(upCfg)do
local cfg=bdUp[1]
local costList=cfg.uplevel_cost
if costList then
local cost=costList[1]
if cost and cost[1]==itemId then
self.fastlookup_item2build[itemId]=bdId
return bdId
end
end
end
end

function zongmenBuildingSuitModel:findPartRoadByItem(itemId)
local cfg=cfg_roadstyleconfig()
for i,v in pairs(cfg)do
if v.activate_cost==itemId then
return i
end
end
end

function zongmenBuildingSuitModel:findSuitIdByBuilding(bdId)
if self.fastlookup_build2suit[bdId]then
return self.fastlookup_build2suit[bdId]
end
local cfg=cfg_buildsuitconfig()
for i,v in pairs(cfg)do
if v.map==bdId then
self.fastlookup_build2suit[bdId]=v.id
return v.id
end
end
end

function zongmenBuildingSuitModel:findSuitBuildingById(suit)
if self.fastlookup_suit2build[suit]then
return self.fastlookup_suit2build[suit]
end
local suitCfg=cfgHelper.get1(cfg_buildsuitconfig_get,suit)
self.fastlookup_suit2build[suit]=suitCfg.map
return suitCfg.map
end

function zongmenBuildingSuitModel:checkEnter()
return systemModel.isOpen(SYSTEM_DEFINE.eBuildSuit)and isometricMapSystem:getLayoutMode()==layoutMode.eBuild and(zongmenModel:getMountainId()==mapIdType.zhufeng or zongmenModel:getMountainId()==mapIdType.lingshoudao)
end

function zongmenBuildingSuitModel:isSuitBuff(id)
local cfg=cfg_buildsuitconfig()
for i,v in pairs(cfg)do
if table.containsValue(v.guild_buffs,id)then
return true
end
end
return false
end

function zongmenBuildingSuitModel:countBuffManufactureEffect(bdType,checkType)
local count=0
local stateList=homeBuffModel.getEffectList()
for i,v in ipairs(stateList)do
local id=v[1]
if zongmenBuildingSuitModel:isSuitBuff(id)then
local cfg=cfgHelper.get1(cfg_guildstateconfig_get,id)
local effects=cfg.effects
for ii,vv in ipairs(effects)do
local ecfg=cfgHelper.get1(cfg_guildstateeffectconfig_get,vv)
local etype=ecfg.effect_type
if etype==checkType then
for iii,vvv in ipairs(ecfg.param[1])do
if vvv==bdType then
count=count+ecfg.param[2]
break
end
end
end
end
end
end
return count
end