









local xjEntityHud2_icon={}


function xjEntityHud2_icon:onInit()
self.needFollow=true
self.enemyType=nil
if self.isHideModel==nil then
self.isHideModel=false
if self.entityType==XJ_ENTITY_TYPE.eZongMen then

local actorid=self.data[1]
local ismy=self.data[2]
local zmData
if not ismy then
zmData=xianjieModel:getZongMenData(actorid)
else
zmData=xianjieModel:getMyZongMenData()
end
local enemyType=xianjieModel:checkEnemyType2(actorid,zmData.ownersceneidx)
self.enemyType=enemyType
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
if not isFriend then
self.isHideModel=xianjieModel:isZmInvisible(actorid)
end
end
end
end

function xjEntityHud2_icon:getIconName()
local abname,iconname,desc,iconExtra

local data=self.data
local entityType=self.entityType
if entityType==XJ_ENTITY_TYPE.eMonster then
local infoguid=data[1]
local monsterData=xianjieModel:getMonsterData(infoguid)
local hideStage
if monsterData.entitytype==xjServerEnityType.eMoJieMoJunYaoMo then
hideStage=true
end
local cfg=monsterData:getCfg()
desc={}
desc[2]=tostring(cfg.stage)
if cfg.stage==0 or hideStage then
desc={}
end
local xjicontype=self.data.xjicontype
if not xjicontype then

logErr("entityType==XJ_ENTITY_TYPE.eMonster 没有xjicontype ")
return
end
local cfg=cfg_fairylandentityicontypeconfig2_get(xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
abname=globalABLookup.xjhud2icons
elseif entityType==XJ_ENTITY_TYPE.eZongMen then
local actorid=data[1]
local ismy=data[2]
local zmData
if not ismy then
zmData=xianjieModel:getZongMenData(actorid)
else
zmData=xianjieModel:getMyZongMenData()
end
local enemyType=xianjieModel:checkEnemyType2(actorid,zmData.ownersceneidx)
if enemyType==xjEnemyType.eSelf then
iconname='icon_xbenzongmen_1'
desc={}
desc[1]={'本宗门',0,-23}
elseif enemyType==xjEnemyType.eAllies then
iconname='icon_xjyouzongmen_1'
elseif enemyType==xjEnemyType.eEnemy then
iconname='icon_xjdizongmen_1'
elseif enemyType==xjEnemyType.eStranger then
iconname='icon_xjyouzongmen_2'
end
abname=globalABLookup.xjhud2icons
elseif entityType==XJ_ENTITY_TYPE.eStation then
iconname='icon_xjmijing_1'
abname=globalABLookup.xjhud2icons
elseif entityType==XJ_ENTITY_TYPE.eYuanJun then
iconname='icon_xjmijing_1'
abname=globalABLookup.xjhud2icons
elseif entityType==XJ_ENTITY_TYPE.eRPMonster then
local dataGuid=data.guid
local monsterData=xianjieModel:getResPointData(dataGuid)
local cfg=monsterData:getCfg()
desc={}
desc[2]=tostring(cfg.stage)
local xjicontype=self.data.xjicontype
if not xjicontype then
local data=xianjieModel:getResPointData(self.data.guid)
local cfg=data:getCfg()

logErr("entityType==XJ_ENTITY_TYPE.eRPMonster 没有xjicontype ")
return
end
local cfg=cfg_fairylandentityicontypeconfig2_get(xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
iconExtra=cfg.extra
abname=globalABLookup.xjhud2icons
elseif entityType==XJ_ENTITY_TYPE.eCloudQiYu then
iconname='icon_xjmijing_1'
abname=globalABLookup.xjhud2icons
elseif entityType==XJ_ENTITY_TYPE.eArena then
iconname='icon_xianjieleitai_2'
abname=globalABLookup.xjhud2icons
elseif entityType==XJ_ENTITY_TYPE.eMoJiang then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.data.build_id)
local entityData=xianjieModel:getMoJiangEntity(self.data.seasonType,self.data.stageIndex,self.data.build_id)
if entityData.killTime<=0 then
desc={}
desc[2]=buildCfg.name
end
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(self.data.xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
elseif entityType==XJ_ENTITY_TYPE.eMoJun then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.data.build_id)
local mojunData=xianjieModel:getMoJunData()
if mojunData.killTime<=0 then
desc={}
desc[2]=buildCfg.name
end
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(self.data.xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
elseif entityType==XJ_ENTITY_TYPE.eMoGong then
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(1501)
iconExtra=cfg.extra
iconname=cfg.icon
elseif entityType==XJ_ENTITY_TYPE.eMGZDZhanHunGe then
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(1502)
iconExtra=cfg.extra
iconname=cfg.icon
abname=globalABLookup.xjhud2icons
elseif entityType==XJ_ENTITY_TYPE.eMGZDHuLingTa then
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(1504)
iconExtra=cfg.extra
iconname=cfg.icon
elseif entityType==XJ_ENTITY_TYPE.ePuTongZhenJi then
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(1701)
iconExtra=cfg.extra
iconname=cfg.icon
elseif entityType==XJ_ENTITY_TYPE.eBenYuanZhenJi then
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(1702)
iconExtra=cfg.extra
iconname=cfg.icon
elseif entityType==XJ_ENTITY_TYPE.eZhenTai then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,self.data.client_build_id)
desc={}
desc[2]=buildCfg.name
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(self.data.xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
end
return abname,iconname,desc,iconExtra
end


function xjEntityHud2_icon:onCreateWidget(widget)
local data=self.data
local entityType=self.entityType
if entityType==XJ_ENTITY_TYPE.eMonster then
local infoguid=data[1]
local monsterData=xianjieModel:getMonsterData(infoguid)
if monsterData and monsterData.entitytype==xjServerEnityType.eMoJieBox then
return
end
end

local abname,iconname,desc,iconExtra=self:getIconName()
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
widget:SetChildActive(-1,true)
self.xjIconGUID=xianjieController:createXjIcon(abname,iconname,iconExtra,widget,0)
if desc then
if desc[1]then
widget:SetChildText(1,desc[1][1])
widget:SetChildAnchoredPos(1,desc[1][2],desc[1][3])
else
widget:SetChildText(1,'')
end
if desc[2]then
widget:SetChildActive(2,true)
widget:SetChildText(3,desc[2])
else
widget:SetChildActive(2,false)
end
else
widget:SetChildText(1,'')
widget:SetChildActive(2,false)
end
widget:SetChildButtonClick(0,function()
self:onClick()
end)

if self.isHideModel then
widget:SetChildActive(-1,false)
end
end


function xjEntityHud2_icon:onRemoveWidget(widget)
self:stopInvisibleEffect(widget,nil,true)
self.isHideModel=nil
widget:SetChildIcon(0,'',false)
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
self.xjIconGUID=nil
self.enemyType=nil
end

function xjEntityHud2_icon:onClick()
if not self:checkWidget()then return end

local data=self.data
local entityType=self.entityType
if entityType==XJ_ENTITY_TYPE.eMonster then
local infoguid=data[1]
xianjieController:openMonsterInfoWin(infoguid)
elseif entityType==XJ_ENTITY_TYPE.eRPMonster then
xianjieController:onClickResPoint(self.data.guid)
elseif entityType==XJ_ENTITY_TYPE.eZongMen then
local actorid=data[1]
local ismy=data[2]
xianjieController:openZmInfoWin(ismy,actorid)
elseif entityType==XJ_ENTITY_TYPE.eStation then
local infoguid=data[1]
xianjieController:openStationInfoWin(infoguid)
elseif entityType==XJ_ENTITY_TYPE.eCloudQiYu then
local cloudid=data[1]
xianjieController:jumpOpenCloudQiYu(cloudid)
elseif entityType==XJ_ENTITY_TYPE.eArena then
local arenaId=data[1]
xianjieController:openArenaInfoWin(arenaId)
elseif entityType==XJ_ENTITY_TYPE.eMoJiang then
xianjieController:openMoJiangWin(self.data.seasonType,self.data.stageIndex,self.data.build_id)
elseif entityType==XJ_ENTITY_TYPE.eMoJun then
xianjieController:openMoJunWin()
elseif entityType==XJ_ENTITY_TYPE.eMoGong then
xianjieController:openMGZDMoGongInfoWin(data.arenaId)
elseif entityType==XJ_ENTITY_TYPE.eMGZDZhanHunGe then
xianjieController:openMGZDZhanHunGeInfoWin(data.buildID)
elseif entityType==XJ_ENTITY_TYPE.eMGZDHuLingTa then
xianjieController:openMGZDHuLingTaInfoWin(data.buildID)
elseif entityType==XJ_ENTITY_TYPE.ePuTongZhenJi then
local infoguid=data.infoguid
xianjieController:openPuTongZhenJiInfoWin(infoguid)
elseif entityType==XJ_ENTITY_TYPE.eBenYuanZhenJi then
xianjieController:reqBenYuanZhenJiData(self.data.season_id,self.data.chapter_idx,self.data.entityId,true)
elseif entityType==XJ_ENTITY_TYPE.eZhenTai then
xianjieController:openZhenTaiWin(self.data.seasonType,self.data.stageIndex,self.data.build_id)
end
end



function xjEntityHud2_icon:playInvisibleEffect(widget,isDisable)
local entityType=self.entityType
if entityType~=XJ_ENTITY_TYPE.eZongMen then
return
end

local isExecuteFunc=true
if not isDisable then

if self.showivbe then return end

if self.showdivbe then
isExecuteFunc=false
end
else

if not self.showdivbe then return end

if not self.showivbe then
isExecuteFunc=false
end
end

if isExecuteFunc then
local data=self.data
local actorid=data[1]
local ismy=data[2]
local zmData
if not ismy then
zmData=xianjieModel:getZongMenData(actorid)
else
zmData=xianjieModel:getMyZongMenData()
end
local enemyType=self.enemyType
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
if not isFriend then

widget=widget or self:getWidget()
if widget then
widget:SetChildActive(-1,false)
end
self.isHideModel=true
end
end

if not isDisable then
self.showivbe=true
else
self.showdivbe=nil
end
end


function xjEntityHud2_icon:stopInvisibleEffect(widget,isDisable,isForceStop)
local entityType=self.entityType
if entityType~=XJ_ENTITY_TYPE.eZongMen then
return
end

local isExecuteFunc=true
if not isForceStop then
if not isDisable then

if not self.showivbe then return end

if self.showdivbe then
isExecuteFunc=false
end
else

if self.showdivbe then return end

if not self.showivbe then
isExecuteFunc=false
end
end
end

if isExecuteFunc then
widget=widget or self:getWidget()
if widget then
widget:SetChildActive(-1,true)
end
self.isHideModel=false
end

if isForceStop then
self.showivbe=nil
self.showdivbe=nil
else
if not isDisable then
self.showivbe=nil
else
self.showdivbe=true
end
end
end

return xjEntityHud2_icon
