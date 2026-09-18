









local xj2DEntity_icon={}

function xj2DEntity_icon:getIconName()
local sceneEnity=self:getSceneEnity()
local data=sceneEnity:getData()
local abname,iconname,desc,iconExtra

local entityType=self.entityType
if entityType==XJ_ENTITY_TYPE.eMonster then
local infoguid=data[1]
local monsterData=xianjieModel:getMonsterData(infoguid)
local cfg=monsterData:getCfg()
if xjMapHideStage[monsterData.entitytype]~=1 then
desc={}
desc[2]=tostring(cfg.stage)
if cfg.stage==0 then
desc={}
end
end
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(self.xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
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
elseif entityType==XJ_ENTITY_TYPE.eXianMeng then
local guildid=data[1]
local xmData=xianjieModel:getXianMengData(guildid)
local enemyType=xianjieModel:checkEnemyType3(guildid,xmData.ownersceneidx)
if enemyType==xjEnemyType.eSelf then
iconname='icon_xbenzongmen_1'
desc={}
desc[1]={'本仙盟',0,-23}
elseif enemyType==xjEnemyType.eAllies then
iconname='icon_xjyouzongmen_1'
elseif enemyType==xjEnemyType.eEnemy then
iconname='icon_xjdizongmen_1'
elseif enemyType==xjEnemyType.eStranger then
iconname='icon_xjyouzongmen_2'
end
abname=globalABLookup.xjhud2icons
elseif entityType==XJ_ENTITY_TYPE.eRPMonster then
local dataGuid=data.guid
local monsterData=xianjieModel:getResPointData(dataGuid)
local cfg=monsterData:getCfg()
desc={}
desc[2]=tostring(cfg.stage)
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(self.xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
elseif entityType==XJ_ENTITY_TYPE.eMoJiang then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,data.build_id)
local entityData=xianjieModel:getMoJiangEntity(data.seasonType,data.stageIndex,data.build_id)
if entityData.killTime<=0 then
desc={}
desc[2]=buildCfg.name
end
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(self.xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
elseif entityType==XJ_ENTITY_TYPE.eMoJun then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,data.build_id)
local mojunData=xianjieModel:getMoJunData()
if mojunData.killTime<=0 then
desc={}
desc[2]=buildCfg.name
end
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(self.xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
elseif entityType==XJ_ENTITY_TYPE.ePuTongZhenJi then
desc={}
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(self.xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
elseif entityType==XJ_ENTITY_TYPE.eBenYuanZhenJi then
desc={}

abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(self.xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
elseif entityType==XJ_ENTITY_TYPE.eZhenTai then
local buildCfg=cfgHelper.get1(cfg_fairylandclientbuildconfig_get,data.client_build_id)
desc={}
desc[2]=buildCfg.name

abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(self.xjicontype)
iconExtra=cfg.extra
iconname=cfg.icon
else
abname=globalABLookup.xjhud2icons
local cfg=cfg_fairylandentityicontypeconfig2_get(self.xjicontype)
if cfg then
iconExtra=cfg.extra
iconname=cfg.icon
end
end
return abname,iconname,desc,iconExtra
end


function xj2DEntity_icon:onCreateWidget(widget)
local entityType=self.entityType
if entityType==XJ_ENTITY_TYPE.eMonster then
local sceneEnity=self:getSceneEnity()
local data=sceneEnity:getData()
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
self.xjIconGUID=xianjieController:createXjIcon(abname,iconname,iconExtra,widget,0)

self:onInitZongMenData()

widget:SetChildActive(-1,true)
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
widget:SetChildButtonClick(4,function()
self:onClick()
end)

if self.isHideModel then
widget:SetChildActive(-1,false)
end
end


function xj2DEntity_icon:onRemoveWidget(widget)
self.isHideModel=nil
widget:SetChildActive(-1,true)
widget:SetChildIcon(0,'',false)
if self.xjIconGUID then
xianjieController:removeXjIcon(self.xjIconGUID)
end
self.xjIconGUID=nil
end

function xj2DEntity_icon:onMyClick()
local sceneEnity=self:getSceneEnity()
local data=sceneEnity:getData()
local entityType=self.entityType
local check=false
if entityType==XJ_ENTITY_TYPE.eMonster then
local infoguid=data[1]
xianjieController:openMonsterInfoWin(infoguid)
check=true
elseif entityType==XJ_ENTITY_TYPE.eRPMonster then
local dataGuid=data.guid
xianjieController:onClickResPoint(dataGuid)
check=true
elseif entityType==XJ_ENTITY_TYPE.eZongMen then
local actorid=data[1]
local ismy=data[2]
xianjieController:openZmInfoWin(ismy,actorid)
check=true
elseif entityType==XJ_ENTITY_TYPE.eXianMeng then
local guildid=data[1]
xianjieController:openXianMengWin(guildid)
check=true
elseif entityType==XJ_ENTITY_TYPE.eMoJiang then
xianjieController:openMoJiangWin(data.seasonType,data.stageIndex,data.build_id)
check=true
elseif entityType==XJ_ENTITY_TYPE.eMoJun then
xianjieController:openMoJunWin()
check=true
elseif entityType==XJ_ENTITY_TYPE.eMoGong then
xianjieController:openMGZDMoGongInfoWin(data.arenaId)
check=true
elseif entityType==XJ_ENTITY_TYPE.eMGZDZhanHunGe then
xianjieController:openMGZDZhanHunGeInfoWin(data.buildID)
check=true
elseif entityType==XJ_ENTITY_TYPE.eMGZDHuLingTa then
xianjieController:openMGZDHuLingTaInfoWin(data.buildID)
check=true
elseif entityType==XJ_ENTITY_TYPE.ePuTongZhenJi then
local infoguid=data.infoguid
xianjieController:openPuTongZhenJiInfoWin(infoguid)
check=true
elseif entityType==XJ_ENTITY_TYPE.eBenYuanZhenJi then
xianjieController:reqBenYuanZhenJiData(data.season_id,data.chapter_idx,data.entityId,true)
check=true
elseif entityType==XJ_ENTITY_TYPE.eZhenTai then
xianjieController:openZhenTaiWin(data.seasonType,data.stageIndex,data.build_id)
check=true
end
if check then
UIManager:invokeUIMethod('UIXianJie_mapWin','onCloseBtn2')
end
end


function xj2DEntity_icon:onDelete()

end

function xj2DEntity_icon:onInitZongMenData()
self.enemyType=nil
self.isHideModel=self.isHideModel
if self.isHideModel==nil then
self.isHideModel=false
if self.entityType==XJ_ENTITY_TYPE.eZongMen then

local sceneEnity=self:getSceneEnity()
local data=sceneEnity:getData()
local actorid=data[1]
local ismy=data[2]
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
return xj2DEntity_icon