







mysterySkillEffectManager={}

local _HexMapManager=CS.HexagonMapManagerInterface
local SetPosition=_HexMapManager.SetPosition


mysterySkillEffectManager.handle=
{

[eMysterySkillType.eExplore]=
{
func=function(args)

mysterySkillController.req_use_skill(MysteryModel:get_cur_fbid(),args)
end,
recvFunc=function(args)

local skillType=eMysterySkillType.eExplore
local skillCfg=mysterySkillModel.get_skill_config(skillType)
local effect=skillCfg.effect[2]
local range=math.floor(effect[1]*(1+mysteryDiscipleEffectModel:get_skill_explore_range()/100))
local rangeView=math.floor(effect[2]*(1+mysteryDiscipleEffectModel:get_skill_explore_range()/100))

local player=mysteryPlayerModel:get_player()
local roomId=mysteryRoomModel:get_cur_roomID()

local exploreList={}


local allHideList=mysteryEntityController.invokeAllModelsFunc("get_hide_list")
for entityType,hideList in pairs(allHideList)do
for i,v in pairs(hideList)do
if mysteryPosHelper.is_in_check_range(player.pos,v.pos,range,player.roomId,roomId)then
local key=table.concat({v.pos.x,v.pos.y},"-")
if not exploreList[key]then
exploreList[key]={v.pos.x,v.pos.y}
end
MysteryModel:set_mystery_hide_cache(key,v)
end
end
end


local roomID=mysteryRoomModel:get_cur_roomID()
mysteryAIManager:set_mystery_state(true)
mysteryFogController:createEffect(10097,mysteryPlayerModel:get_player_pos(),mysteryRoomModel:get_GroundLayer(roomID),1,function()
local posList={}
for i,v in pairs(exploreList)do
table.insert(posList,v)
end

if#posList>0 then
socketManager:send_4_43(#posList,posList)
end


local yaranzoList=mysteryYaranzoModel:get_entity_list()
local sendYaranzoList={}
for i,v in pairs(yaranzoList)do
if mysteryPosHelper.is_in_check_range(player.pos,v.pos,range,player.roomId,roomId)then
table.insert(sendYaranzoList,v)
end
end
if next(sendYaranzoList)then
mysteryTreasureController.req_prize(sendYaranzoList)
end

mysteryFogController:updateFog(MysteryModel:get_cur_fbid(),mysteryPlayerModel:get_player_pos(),rangeView)

mysteryAIManager:set_mystery_state(false)


end)
end
},

[eMysterySkillType.eCure]=
{
func=function(args)

local skillType=eMysterySkillType.eCure




mysterySkillController.req_use_skill(MysteryModel:get_cur_fbid(),args)

end,
recvFunc=function(args)
mysteryAIManager:set_mystery_state(true)
local roomID=mysteryRoomModel:get_cur_roomID()

mysteryFogController:createEffect(3023,mysteryPlayerModel:get_player_pos(),mysteryRoomModel:get_GroundLayer(roomID),1,function()
mysteryAIManager:set_mystery_state(false)
end)
end
},

[eMysterySkillType.eHide]=
{
func=function(args)

mysterySkillController.req_use_skill(MysteryModel:get_cur_fbid(),args)
end,
recvFunc=function(args)

local skillType=eMysterySkillType.eHide
local skillCfg=mysterySkillModel.get_skill_config(skillType)
local effect=skillCfg.effect[2]
local steps=effect[1]+mysteryDiscipleEffectModel:get_hide_step()
mysteryAIManager:set_mystery_state(true)
local roomID=mysteryRoomModel:get_cur_roomID()
UIManager:invokeUIMethod("UIMysteryWin","showEffect",10098,true)
mysteryFogController:createEffect(10092,mysteryPlayerModel:get_player_pos(),mysteryRoomModel:get_GroundLayer(roomID),0.5,function()
mysteryAIManager:set_mystery_state(false)

mysterySkillController:set_hide_steps(steps)
end)
end
},

[eMysterySkillType.eHold]=
{
func=function(args)

local skillType=eMysterySkillType.eHold
local skillCfg=mysterySkillModel.get_skill_config(skillType)
local effect=skillCfg.effect[2]
local range=effect[1]


if mysterySkillModel:is_in_skill_effect(skillType)then

local isHold=mysterySkillModel:is_hold_pos(args.pos)
local monster
for i,etType in ipairs(eHoldEtType)do
monster=mysteryEntityController.invokeFuncByMysteryEntityType(etType,'get_entity_by_pos',args.pos,mysteryRoomModel:get_cur_roomID())
if monster then
break
end
end
if isHold and monster then

mysterySkillController.req_use_skill(MysteryModel:get_cur_fbid(),args)
elseif isHold and not monster then
UIManager.error("所选范围暂无敌人")

else
UIManager.error("超出技能范围")
end
else

mysterySkillModel:handle_ready_skill(skillType)

mysterySkillModel:create_hold(range)

mysterySkillModel:set_in_skill_effect(skillType,args.skillId)

end
end,
recvFunc=function(args)
local skillCfg=mysterySkillModel.get_skill_config(args.skillId)
local effect=skillCfg.effect[2]
local steps=effect[2]
local isHold=mysterySkillModel:is_hold_pos(args.pos)
local monster
for i,etType in ipairs(eHoldEtType)do
monster=mysteryEntityController.invokeFuncByMysteryEntityType(etType,'get_entity_by_pos',args.pos,mysteryRoomModel:get_cur_roomID())
if monster then
break
end
end

if isHold and monster then

mysterySkillController.req_use_skill(MysteryModel:get_cur_fbid(),args)

local role=_HexMapManager.GetRole(monster.guid)
local playerRole=mysteryPlayerModel:get_role_entity(mysteryPlayerModel:get_player_guid())


mysterySkillModel:set_hold_steps(args.pos,steps)

mysterySkillModel:set_in_skill_effect(eMysterySkillType.eHold)

mysterySkillModel:remove_all_hold()

local roomID=mysteryRoomModel:get_cur_roomID()
mysteryAIManager:set_mystery_state(true)
if playerRole then
playerRole:RunAnimator(eAnimationID.attack4,1)
end
mysteryFogController:createEffect(10095,mysteryPlayerModel:get_player_pos(),mysteryRoomModel:get_GroundLayer(roomID),2.2,function()
mysteryAIManager:set_mystery_state(false)
if not monster.holdEffect then
monster.holdEffect=role:PlayEffect(10096,Vector2(0,0),Vector3(1,1,1),true,true)

end
end)
end
end
},

[eMysterySkillType.eFlash]=
{
func=function(args)

local skillType=eMysterySkillType.eFlash

if mysterySkillModel:is_in_skill_effect(eMysterySkillType.eFlash)then

if mysterySkillModel:is_flash_pos(args.pos)then


mysterySkillController.req_use_skill(MysteryModel:get_cur_fbid(),args)

else
UIManager.error("超出技能范围")
end

else

local skillCfg=mysterySkillModel.get_skill_config(args.skillId)
local effect=skillCfg.effect[2]
local range=effect[1]

mysterySkillModel:handle_ready_skill(skillType)

mysterySkillModel:create_flash(range)

mysterySkillModel:set_in_skill_effect(skillType,args.skillId)

end
end,
recvFunc=function(args)
if mysterySkillModel:is_flash_pos(args.pos)then
local roomID=mysteryRoomModel:get_cur_roomID()
mysteryAIManager:set_mystery_state(true)

mysterySkillModel:remove_all_flash()
mysteryFogController:createEffect(10093,mysteryPlayerModel:get_player_pos(),mysteryRoomModel:get_GroundLayer(roomID),1.2)
timeEventController.delayDo(0.5,function()

mysteryPlayerModel:flash(mysteryPlayerModel:get_player_guid(),args.pos)
mysteryFogController:createEffect(10094,args.pos,mysteryRoomModel:get_GroundLayer(roomID),2.1)
mysteryAIManager:set_mystery_state(false)
mysterySkillModel:set_in_skill_effect(eMysterySkillType.eFlash,nil)
end)
end
end
},

[eMysterySkillType.eYuFengHanYing]=
{
func=function(args)

local skillType=eMysterySkillType.eYuFengHanYing

if mysterySkillModel:is_in_skill_effect(skillType)then

local isyfhy,arrow,range=mysterySkillModel:is_yfhy_pos(args.pos)
if isyfhy then

local skillCfg=mysterySkillModel.get_skill_config(args.skillId)
local effect=skillCfg.effect[2]
local skillRange=effect[1]
local steps=effect[2]
local posList=mysteryPosHelper.getLinePosList(mysteryPlayerModel:get_player_pos(),arrow,skillRange,true)
local monsterList={}
local mList={}
local roomId=mysteryRoomModel:get_cur_roomID()
local eTypeList={eMysteryEntityType.eMonster,eMysteryEntityType.eBoomMonster}
local haveBoss=false

for i,pos in ipairs(posList)do
for a,t in ipairs(eTypeList)do
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
table.insert(mList,entity)
else
if monType<2 then
have=true
table.insert(mList,entity)
else
haveBoss=true
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
if next(mList)then
args.mList=mList
args.steps=steps

mysterySkillController.req_use_skill(MysteryModel:get_cur_fbid(),args)
else
if haveBoss then
UIManager.error("该技能无法对首领生效")
else
UIManager.error("前方范围没有怪物")
end
end

else
UIManager.error("超出技能范围")
end

else

local skillCfg=mysterySkillModel.get_skill_config(args.skillId)
local effect=skillCfg.effect[2]
local range=effect[1]

mysterySkillModel:handle_ready_skill(skillType)


mysterySkillModel:create_yfhy(range)

mysterySkillModel:set_in_skill_effect(skillType,args.skillId)


end
end,
recvFunc=function(args)
local isyfhy,arrow,range=mysterySkillModel:is_yfhy_pos(args.pos)

if isyfhy then
local mList=args.mList
local steps=args.steps
if next(mList)then
local playerGuid=mysteryPlayerModel:get_player_guid()
local playerRole=mysteryPlayerModel:get_role_entity(playerGuid)
if playerRole then
playerRole:RunAnimator(eAnimationID.attack4,1)
end


timeEventController.delayDo(0.5,function()
local effect=10491
local layer=mysteryRoomModel:get_GroundLayer(mysteryRoomModel:get_cur_roomID())
local time=0.75
local effectPos=mysteryPosHelper.getLinePosList(args.pos,arrow,1)
MysteryController.addUIHUD(eMysteryHUDType.eModel,{pos=mysteryPlayerModel:get_player_pos(),layer=layer,sortLayer="UIWindow",sortOrder=100,effectArgs={effectId=effect,endPos=effectPos[1],scale=75},destoryTime=time*steps})

end)

mysteryPlayerModel:set_entity_forward(playerGuid,args.pos)
timeEventController.delayDo(1,function()

for i,entity in ipairs(mList)do
local monType=nil
if entity.entityType==eMysteryEntityType.eMonster then
monType=mysteryMonsterModel:get_monster_type(entity.id)
end
if(not monType)or(monType and monType<2)then
mysteryEntityController.invokeControllerFuncByMysteryEntityType(entity.entityType,'push_to_move',entity,steps,arrow)
end
end
end)
end


mysterySkillModel:remove_all_yfhy()


end
mysterySkillModel:set_in_skill_effect(eMysterySkillType.eYuFengHanYing)
end
},

[eMysterySkillType.eTanYunShou]=
{
func=function(args)
if mysterySkillModel:is_in_skill_effect(eMysterySkillType.eTanYunShou)then

local istys,arrow,range,haveMon=mysterySkillModel:is_tys_pos(args.pos)
if istys then

if haveMon then

mysterySkillController.req_use_skill(MysteryModel:get_cur_fbid(),args)
else
UIManager.error("该位置无目标")
end

else
UIManager.error("超出技能范围")
end

else

local skillCfg=mysterySkillModel.get_skill_config(args.skillId)
local effect=skillCfg.effect[2]
local range=effect[1]
local etTypeList=effect[2]


local playerPos=mysteryPlayerModel:get_player_pos()

local posList=mysteryPosHelper.getRangeSixPosList(playerPos,range)
if not next(posList)then
return
end
local entity

mysterySkillModel:set_in_skill_effect(eMysterySkillType.eTanYunShou,args.skillId)

mysterySkillModel:handle_ready_skill(eMysterySkillType.eTanYunShou)

for a,data in pairs(posList)do
for r,pos in pairs(data)do
entity=nil
for i,etType in ipairs(etTypeList)do
entity=mysteryEntityController.invokeFuncByMysteryEntityType(etType,'get_entity_by_pos',pos,mysteryRoomModel:get_cur_roomID())
if entity then
break
end
end
mysterySkillModel:add_tys(a,r,pos,entity~=nil)
end
end
end
end,
recvFunc=function(args)

local istys,arrow,range=mysterySkillModel:is_tys_pos(args.pos)
if istys then
local skillCfg=mysterySkillModel.get_skill_config(args.skillId)
local effect=skillCfg.effect[2]
local etTypeList=effect[2]
local etList
local mList={}
for i,etType in ipairs(etTypeList)do
etList=mysteryEntityController.invokeFuncByMysteryEntityType(etType,'get_all_entity_list_by_pos',args.pos,mysteryRoomModel:get_cur_roomID())
if etList and next(etList)then
for i,entity in ipairs(etList)do
if entity and not entity.data.huge then
if etType==eMysteryEntityType.eMonster then
local monType=mysteryMonsterModel:get_monster_type(entity.id)
if monType<2 then
table.insert(mList,entity)
end
else
table.insert(mList,entity)
end
end
end
end
end

if next(mList)then
local playerGuid=mysteryPlayerModel:get_player_guid()
local playerRole=mysteryPlayerModel:get_role_entity(playerGuid)
if playerRole then
playerRole:RunAnimator(eAnimationID.attack4,1)
end
local playerPos=mysteryPlayerModel:get_player_pos()
mysteryPlayerModel:set_entity_forward(playerGuid,args.pos)
timeEventController.delayDo(1,function()
local linePosList=mysteryPosHelper.getLinePosList(playerPos,arrow,1,true)
local entityRole=nil

if next(linePosList)then
for i,entity in ipairs(mList)do
local range=mysteryPosHelper.get_pos_distance(entity.pos,playerPos)
if range>1 then
entityRole=_HexMapManager.GetRole(entity.guid)
if entityRole then
entityRole:FadeToColor(Color.New(1,1,1,0),0.5,function()
mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'flash',entity.guid,linePosList[1])
entityRole:FadeToColor(Color.New(1,1,1,1),0.5,nil)
end)
end
else
entityRole=_HexMapManager.GetRole(entity.guid)
if entityRole then
entityRole:FadeToColor(Color.New(1,1,1,0),0.5,function()
mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'flash',entity.guid,playerPos,true)
mysteryEntityController.handle_meet()
entityRole:FadeToColor(Color.New(1,1,1,1),0.5,nil)
end)
end
end
end
else
local posList=mysteryPosHelper.getLinePosList(playerPos,arrow,1,false)
for i,entity in ipairs(mList)do
mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'setUseRemoveBehavior',entity.guid,true)
local role=_HexMapManager.GetRole(entity.guid)
local roleTrans=role:GetActorTransform()
mysteryEntityController.invokeFuncByMysteryEntityType(entity.entityType,'play_animation',entity.guid,eAnimationID.jump1)

local layer=mysteryRoomModel:get_GroundLayer(entity.roomId)
local worldPos=_HexMapManager.GetCellCenterWorld(posList[1],layer)
Lua.DOTweenProxyExtensions.DOJump(roleTrans,worldPos+Vector3(0,-1,0),1,1,0.5)
local scaleTween=Lua.DOTweenProxyExtensions.DOScale(roleTrans,0,0.5)
if entity.hud then
entity.hud:recycleSelf()
end
scaleTween:OnComplete(function()
if i==#mList then
mysteryEntityController.send_4_50(mList)
end
end)
end

end
end)
end


mysterySkillModel:remove_all_tys()
end
mysterySkillModel:set_in_skill_effect(eMysterySkillType.eTanYunShou)
end
}
}







function mysterySkillEffectManager:use_skill(skillId,args)
mysterySkillController.skillCD=mysterySkillController.skillCD or{}
if mysterySkillController.skillCD[skillId]then
return
end

args=args or{}
local skillCfg=cfgHelper.get(cfg_ssprobeskillconfig_get,skillId)
if not skillCfg then
return
end
local effect=skillCfg.effect
if not effect then
return
end
local effectId=effect[1]
args.skillId=skillId
self.handle[effectId].func(args)

mysterySkillController.skillCD[skillId]=true
timeEventController.delayDo(0.5,function()
mysterySkillController.skillCD[skillId]=nil
end)
end

function mysterySkillEffectManager:recv_skill(skillId,args)
args=args or{}
local skillCfg=cfgHelper.get(cfg_ssprobeskillconfig_get,skillId)
if not skillCfg then
return
end
local effect=skillCfg.effect
if not effect then
return
end
local effectId=effect[1]
args.skillId=skillId
self.handle[effectId].recvFunc(args)
end



