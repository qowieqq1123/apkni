







mysterySkillModel={}

local _HexMapManager=CS.HexagonMapManagerInterface
local SetTileColor=_HexMapManager.SetTileColor
local SetTileAddColor=_HexMapManager.SetTileAddColor
local Vector3ToVector3Int=_HexMapManager.Vector3ToVector3Int
local StopEffect=CS.GameInterface.StopEffect
local _DOTweenProxy=Lua.DOTweenProxyExtensions

mysterySkillModel.data={}


mysterySkillModel.isFlash=false

mysterySkillModel.flash={}


mysterySkillModel.hideSteps=0


mysterySkillModel.holdSteps={}

mysterySkillModel.hold={}


mysterySkillModel.sim={}

eHoldEtType=
{
eMysteryEntityType.eMonster,
eMysteryEntityType.eBoomMonster,
eMysteryEntityType.eMoveTreasure,
}




function mysterySkillModel.get_skill_config(id)
local config=cfg_ssprobeskillconfig_get(id)
return config
end


function mysterySkillModel.get_genius_config(id)
local config=cfg_ssprobeskillgeniusconfig_get(id)
return config
end


function mysterySkillModel.get_skill_name(id)
local config=cfg_ssprobeskillconfig_get(id)
return config and config.name
end


function mysterySkillModel.get_skill_type(skillId)
local config=cfg_ssprobeskillconfig_get(skillId)
return config and config.skilltype
end


function mysterySkillModel.get_skill_times(id)
local config=cfg_ssprobeskillconfig_get(id)
return config and config.times
end


local cacheColor={}

function mysterySkillModel:init_data()
self.data=
{
probeSkill={},
inSkillEffect={},
readySkill=nil,
silentFlag=nil,
}
self.isFlash=false
self.flash={}
self.hideSteps=0
self.holdSteps={}
self.isHold=false
self.hold={}
self.sim={
hideSteps=0,
holdSteps={},
}
if self.tweeners and next(self.tweeners)then
for i,v in pairs(self.tweeners)do
v:Kill()
end
end
self.tweeners={}
self.tweenerVal={}
end


function mysterySkillModel:set_fb_probeSkill(probeSkill)
probeSkill=probeSkill or{}
self.data.probeSkill={}

for i,v in pairs(probeSkill)do
self.data.probeSkill[#self.data.probeSkill+1]=
{
skill_id=v.param_1,
skill_num=v.param_2,
}
end
end


function mysterySkillModel:get_add_count()
local addCount=0

if QianJiGeModel:is_skill_unlock(9)then
local skillConfig=mysterySkillModel.get_skill_config(9)
addCount=addCount+skillConfig.effect[2][1]
end

return addCount
end


function mysterySkillModel:get_fb_probeSkill()
return self.data.probeSkill
end


function mysterySkillModel:get_fb_active_skill(fbid)
local cfg=cfgHelper.get(cfg_secretscenefubenconfig_get,fbid)
local mustUseSkill=cfg.mustUseSkill or{}
local skillList={}
local noUseList={}
for i,v in ipairs(self.data.probeSkill)do
if self.get_skill_type(v.skill_id)==1 then
local isUse=false
for index,sid in pairs(mustUseSkill)do
if v.skill_id==sid then
skillList[index]=v
isUse=true
break
end
end
if not isUse then
table.insert(noUseList,v)
end
end
end
for i=1,3 do
if not skillList[i]then
if next(noUseList)then
skillList[i]=noUseList[1]
table.remove(noUseList,1)
end
end
end
return skillList
end


function mysterySkillModel:get_fb_passive_skill()
local skillList={}
local unlockList=QianJiGeModel:get_skill_unlock_data()
for k,v in pairs(unlockList)do
if self.get_skill_type(k)==2 then
table.insert(skillList,k)
end
end
table.sort(skillList,function(a,b)return a<b end)
return skillList
end


function mysterySkillModel:set_fb_probeSkill_use_count(skillId,skillNum)
if not self.data.probeSkill then
return
end

for i,v in ipairs(self.data.probeSkill)do
if v.skill_id==skillId then
v.skill_num=skillNum
end
end
end


function mysterySkillModel:get_fb_probeSkill_use_count(skillId)
if not self.data.probeSkill then
return 0
end

for i,v in ipairs(self.data.probeSkill)do
if v.skill_id==skillId then
return v.skill_num
end
end
end


function mysterySkillModel:set_fb_probeSkill_silent(flag)
self.data.silentFlag=flag
end

function mysterySkillModel:is_fb_probeSkill_silent(warring)
if warring and self.data.silentFlag then
UIManager.info("该秘境无法使用探索技能")
end
return self.data.silentFlag
end


function mysterySkillModel:set_in_skill_effect(skillEffectType,skillId)
self.data.inSkillEffect[skillEffectType]=skillId
end

function mysterySkillModel:is_in_skill_effect(skillEffectType)
return self.data.inSkillEffect[skillEffectType]
end


function mysterySkillModel:remove_grid_color(pos)

local roomID=mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)
local posKey=mysteryPosHelper.get_pos_key(pos)
if self.tweeners[posKey]then
self.tweeners[posKey]:Kill()
self.tweeners[posKey]=nil
end
SetTileAddColor(pos,Color.New(0,0,0,1),groundLayer)
end




function mysterySkillModel:handle_ready_skill(skillType)
local oldSkillType=self.data.readySkill
self.data.readySkill=skillType

if oldSkillType==nil then
return
end

if oldSkillType==eMysterySkillType.eHold then
mysterySkillModel:set_in_skill_effect(eMysterySkillType.eHold)

mysterySkillModel:remove_all_hold()
elseif oldSkillType==eMysterySkillType.eFlash then
mysterySkillModel:set_in_skill_effect(eMysterySkillType.eFlash)

mysterySkillModel:remove_all_flash()
elseif oldSkillType==eMysterySkillType.eYuFengHanYing then
mysterySkillModel:set_in_skill_effect(eMysterySkillType.eYuFengHanYing)

mysterySkillModel:remove_all_yfhy()
elseif oldSkillType==eMysterySkillType.eTanYunShou then
mysterySkillModel:set_in_skill_effect(eMysterySkillType.eTanYunShou)

mysterySkillModel:remove_all_tys()
end
end


function mysterySkillModel:clear_ready_skill()
self.data.readySkill=nil
end


function mysterySkillModel:is_ready()
return self.data.readySkill~=nil
end




function mysterySkillModel:create_flash(range)

local playerPos=mysteryPlayerModel:get_player_pos()

local posList=mysteryPosHelper.get_all_round_pos_list(playerPos,range)
if not posList then
return
end
for i,pos in pairs(posList)do
if not mysteryPosHelper.is_same_pos(pos,playerPos)then
mysterySkillModel:add_flash(pos)
end
end
end

function mysterySkillModel:is_flash_pos(selectPos)
for i,pos in pairs(self.flash)do
if mysteryPosHelper.is_same_pos(pos,selectPos)then
return true
end
end
return false
end

function mysterySkillModel:add_flash(pos)


local roomID=mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)


local posKey=mysteryPosHelper.get_pos_key(pos)


if self.tweeners[posKey]then
self.tweeners[posKey]:Kill()
self.tweeners[posKey]=nil
end
local startColor=Color.New(0,0,0,1)
local endColor=Color.New(0.2,0.2,0,1)
self.tweenerVal["flash"..posKey]=0
self.tweeners[posKey]=_DOTweenProxy.DoValueTo(function()
return self.tweenerVal["flash"..posKey]or 0
end,function(val)
self.tweenerVal["flash"..posKey]=val
local lerpColor=Color.Lerp(startColor,endColor,val)
SetTileAddColor(pos,lerpColor,groundLayer)
end,1,1)
self.tweeners[posKey]:SetLoops(-1,_LoopType.Yoyo)

self.flash[#self.flash+1]=pos
end

function mysterySkillModel:remove_all_flash()

for i,pos in pairs(self.flash)do
self:remove_grid_color(pos)
end

self.flash={}
end




function mysterySkillModel:create_hold(range)

local playerPos=mysteryPlayerModel:get_player_pos()

local posList=mysteryPosHelper.get_passable_near_pos_list(playerPos,range)
if not posList then
return
end
for i,pos in pairs(posList)do
mysterySkillModel:add_hold(pos)
end
end

function mysterySkillModel:is_hold_pos(selectPos)
for i,pos in pairs(self.hold)do
if mysteryPosHelper.is_same_pos(pos,selectPos)then
return true
end
end
return false
end

function mysterySkillModel:add_hold(pos)


local roomID=mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)

local posKey=mysteryPosHelper.get_pos_key(pos)
if self.tweeners[posKey]then
self.tweeners[posKey]:Kill()
self.tweeners[posKey]=nil
end
local startColor=Color.New(0,0,0,1)
local endColor=Color.New(0.2,0.2,0,1)
self.tweenerVal["flash"..posKey]=0
self.tweeners[posKey]=_DOTweenProxy.DoValueTo(function()
return self.tweenerVal["flash"..posKey]or 0
end,function(val)
self.tweenerVal["flash"..posKey]=val
local lerpColor=Color.Lerp(startColor,endColor,val)
SetTileAddColor(pos,lerpColor,groundLayer)
end,1,1)
self.tweeners[posKey]:SetLoops(-1,_LoopType.Yoyo)

self.hold[#self.hold+1]=pos
end

function mysterySkillModel:remove_all_hold()

for i,pos in pairs(self.hold)do
self:remove_grid_color(pos)
end

self.hold={}
end




function mysterySkillModel:create_yfhy(range)

local playerPos=mysteryPlayerModel:get_player_pos()

local posList=mysteryPosHelper.getRangeSixPosList(playerPos,range)
if not next(posList)then
return
end
self.yfhy={}
local monsterList={}
local eTypeList={eMysteryEntityType.eMonster,eMysteryEntityType.eBoomMonster}
local roomId=mysteryRoomModel:get_cur_roomID()
MysteryModel.currentFBData.yfhyHUD=MysteryModel.currentFBData.yfhyHUD or{}
for a,data in pairs(posList)do
for r,pos in pairs(data)do
mysterySkillModel:add_yfhy(a,r,pos)

for _,t in ipairs(eTypeList)do
monsterList=mysteryEntityController.invokeFuncByMysteryEntityType(t,'get_all_entity_list_by_pos',pos,roomId)
if monsterList and next(monsterList)then
for i,entity in ipairs(monsterList)do
if entity and not entity.data.huge then
local have=false
local monType=nil
if entity.entityType==eMysteryEntityType.eMonster then
monType=mysteryMonsterModel:get_monster_type(entity.id)
end
if not monType then
have=true
else
if monType<2 then
have=true
end
end
if have then
if not MysteryModel.currentFBData.yfhyHUD[a]then
MysteryModel.currentFBData.yfhyHUD[a]=MysteryController.addUIHUD(eMysteryHUDType.eArrow,{pos=pos,layer=mysteryRoomModel:get_GroundLayer(mysteryRoomModel:get_cur_roomID()),arrow=a})
end
end
end
end
end
end
end
end



end

function mysterySkillModel:is_yfhy_pos(selectPos)
if self.yfhy then
for a,data in pairs(self.yfhy)do
for r,pos in pairs(data)do
if mysteryPosHelper.is_same_pos(pos,selectPos)then
return true,a,r
end
end
end
end
return false
end

function mysterySkillModel:add_yfhy(arrow,range,pos)


local roomID=mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)

local posKey=mysteryPosHelper.get_pos_key(pos)
if self.tweeners[posKey]then
self.tweeners[posKey]:Kill()
self.tweeners[posKey]=nil
end
local startColor=Color.New(0,0,0,1)
local endColor=Color.New(0.2,0.2,0,1)
self.tweenerVal["yfhy"..posKey]=0
self.tweeners[posKey]=_DOTweenProxy.DoValueTo(function()
return self.tweenerVal["yfhy"..posKey]or 0
end,function(val)
self.tweenerVal["yfhy"..posKey]=val
local lerpColor=Color.Lerp(startColor,endColor,val)
SetTileAddColor(pos,lerpColor,groundLayer)
end,1,1)
self.tweeners[posKey]:SetLoops(-1,_LoopType.Yoyo)

self.yfhy[arrow]=self.yfhy[arrow]or{}
self.yfhy[arrow][range]=pos
end

function mysterySkillModel:remove_all_yfhy()

for a,data in pairs(self.yfhy)do
for r,pos in pairs(data)do
self:remove_grid_color(pos)
end
end
self.yfhy={}

if MysteryModel.currentFBData.yfhyHUD then
for i,v in pairs(MysteryModel.currentFBData.yfhyHUD)do
MysteryController.removeUIHUD(v)
end
MysteryModel.currentFBData.yfhyHUD=nil
end
end



function mysterySkillModel:is_tys_pos(selectPos)
if self.tys then
for a,data in pairs(self.tys)do
for r,v in pairs(data)do
if mysteryPosHelper.is_same_pos(v[1],selectPos)then
return true,a,r,v[2]
end
end
end
end
return false
end

function mysterySkillModel:add_tys(arrow,range,pos,haveMon)


local roomID=mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)

local posKey=mysteryPosHelper.get_pos_key(pos)
if self.tweeners[posKey]then
self.tweeners[posKey]:Kill()
self.tweeners[posKey]=nil
end
local startColor=Color.New(0,0,0,1)
local endColor



endColor=Color.New(0.4,0,0,1)

self.tweenerVal["tys"..posKey]=0
self.tweeners[posKey]=_DOTweenProxy.DoValueTo(function()
return self.tweenerVal["tys"..posKey]or 0
end,function(val)
self.tweenerVal["tys"..posKey]=val
local lerpColor=Color.Lerp(startColor,endColor,val)
SetTileAddColor(pos,lerpColor,groundLayer)
end,1,1)
self.tweeners[posKey]:SetLoops(-1,_LoopType.Yoyo)

self.tys=self.tys or{}
self.tys[arrow]=self.tys[arrow]or{}
self.tys[arrow][range]={pos,haveMon}

if haveMon then
MysteryModel.currentFBData.tysHUD=MysteryModel.currentFBData.tysHUD or{}
local key=table.concat({pos.x,pos.y},'-')
if not MysteryModel.currentFBData.tysHUD[key]then
MysteryModel.currentFBData.tysHUD[key]=MysteryController.addUIHUD(eMysteryHUDType.eArrow,{pos=pos,layer=mysteryRoomModel:get_GroundLayer(mysteryRoomModel:get_cur_roomID()),arrow=arrow,flip=true})
end
end
end

function mysterySkillModel:remove_all_tys()

for a,data1 in pairs(self.tys)do
for r,data2 in pairs(data1)do
self:remove_grid_color(data2[1])
end
end
self.tys={}

if MysteryModel.currentFBData.tysHUD then
for i,v in pairs(MysteryModel.currentFBData.tysHUD)do
MysteryController.removeUIHUD(v)
end
MysteryModel.currentFBData.tysHUD=nil
end
end




function mysterySkillModel:update_skill_steps()
self.hideSteps=(self.hideSteps>0)and(self.hideSteps-1)or 0
for guid,steps in pairs(self.holdSteps)do
self.holdSteps[guid]=(steps>0)and(steps-1)or 0
if self.holdSteps[guid]<=0 then
for i,etType in ipairs(eHoldEtType)do
local monster=mysteryEntityController.invokeFuncByMysteryEntityType(etType,'get_entity',guid)
if monster and monster.holdEffect then
StopEffect(monster.holdEffect)
monster.holdEffect=nil
end
end
end
end
end




function mysterySkillModel:set_hide_steps(steps)
self.hideSteps=steps
end


function mysterySkillModel:get_hide_steps()
return self.hideSteps
end


function mysterySkillModel:has_hide_steps()
return self.hideSteps>0
end




function mysterySkillModel:set_hold_steps(pos,steps)
for i,etType in ipairs(eHoldEtType)do
local monsters=mysteryEntityController.invokeFuncByMysteryEntityType(etType,'get_entity_list')
for guid,monster in pairs(monsters)do
if mysteryPosHelper.is_same_pos(monster.pos,pos,monster.roomId,mysteryRoomModel:get_cur_roomID())then
self.holdSteps[monster.guid]=steps
end
end
end
end


function mysterySkillModel:get_hold_steps(guid)
return self.holdSteps[guid]
end


function mysterySkillModel:has_hold_steps(guid)
return self.holdSteps[guid]and self.holdSteps[guid]>0 or false
end




function mysterySkillModel:reset_sim_skill_steps()

self.sim.hideSteps=self.hideSteps

self.sim.holdSteps={}
for guid,steps in pairs(self.holdSteps)do
self.sim.holdSteps[guid]=steps
end
end


function mysterySkillModel:update_sim_skill_steps()

self.sim.hideSteps=(self.sim.hideSteps>0)and(self.sim.hideSteps-1)or 0

for guid,steps in pairs(self.sim.holdSteps)do
self.sim.holdSteps[guid]=(steps>0)and(steps-1)or 0
end
end


function mysterySkillModel:has_sim_hide_steps(guid)
return self.sim.hideSteps>0
end


function mysterySkillModel:has_sim_hold_steps(guid)
return self.sim.holdSteps[guid]and self.sim.holdSteps[guid]>0 or false
end

