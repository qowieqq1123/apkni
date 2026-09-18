
local deadDealFunc=
{
[MysterySenceType.ShangGuXianDi]=
function(fbid)
local pos=mysteryPlayerModel:get_last_pos()
if pos then
mysteryPlayerModel:flash(mysteryPlayerModel:get_player_guid(),pos)
end
MysteryModel:set_team_dead(true)
end,
}

function MysteryController:bloodCheck()
if mysteryFightModel:is_fighting()then
return
end

local teamData=MysteryModel:get_fb_probeTeam()
local allDead=true
for i,v in ipairs(teamData)do
if tonumber(tostring(v.blood))>0 then
allDead=false
end
end
if allDead then


local trapDelay=mysteryTrap:getTrapEffectDelay()or 0

if trapDelay>0 then
timeEventController.delayDo(trapDelay,function()
if not MysteryModel.currentFBData.isPlayerBoomDead then
mysteryPlayerController.runBehavior("PlayerBoomDeadAction")
MysteryModel.currentFBData.isPlayerBoomDead=true
end
timeEventController.delayDo(2,function()
MysteryController:bloodCheckQuit()
end)
end)
else
if not MysteryModel.currentFBData.isPlayerBoomDead then
mysteryPlayerController.runBehavior("PlayerBoomDeadAction")
MysteryModel.currentFBData.isPlayerBoomDead=true
end
timeEventController.delayDo(2,function()
MysteryController:bloodCheckQuit()
end)
end





end
end

function MysteryController:commonDeadDual(fbid)
if MysteryModel:get_fb_progress()>=100 then
MysteryModel:set_fb_finish(eMysteryQuitType.eFinish)
notifySystem:postNotify(notifyConfig.on_mystery_finish,fbid)
MysteryController.send_4_27()
else
MysteryModel:set_fb_finish(eMysteryQuitType.eFail)
MysteryController.send_4_27()
end
end

function MysteryController:bloodCheckQuit()
local fbid=MysteryModel:get_cur_fbid()
local sence_type=MysteryModel:get_mystery_sence_type(fbid)

local deadDeal=deadDealFunc[sence_type]
if deadDeal then
deadDeal(fbid)
else
MysteryController:commonDeadDual(fbid)
end
end

function MysteryController:checkTeamDead(teamList)
local allDie=true
for i,v in pairs(teamList)do
if v.unitType~=0 and v.blood>0 then
allDie=false
break
end
end

if allDie then
local fbid=MysteryModel:get_cur_fbid()
local sence_type=MysteryModel:get_mystery_sence_type(fbid)
if sence_type==MysterySenceType.ShangGuXianDi then
timeEventController.delayDo(2,function()
local pos=mysteryPlayerModel:get_last_pos()
if pos then
mysteryPlayerModel:flash(mysteryPlayerModel:get_player_guid(),pos)
end
end)
end
end
MysteryModel:set_team_dead(allDie)
end


function MysteryController:fightCommonDeal()
local showdata=
{
type='UIDialougeHighest',
title='提示',
content='是否重新挑战该秘境？',
oktext='重新挑战',
canceltext='撤离秘境',
allowclickBG='false',
okcallback=function(...)
local fbid=MysteryModel:get_cur_fbid()
MysteryController.send_4_13(fbid)
end,
cancelcallback=function()

MysteryModel:set_fb_finish(eMysteryQuitType.eFail)

MysteryController.send_4_27()
UIFullMysteryMainControl:closeMysteryMainWindow()
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end