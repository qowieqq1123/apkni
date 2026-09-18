






local _MODULENAME="worldResPointFightModel"




def_table(_MODULENAME)
worldResPointFightModel.name=_MODULENAME

worldResPointFightModel.data={}





local battle={}




local fightResult={}


function worldResPointFightModel:onAppStart()

end


function worldResPointFightModel:onEnterState()

end


function worldResPointFightModel:onLeaveState(isReconnet)
if not isReconnet then

battle={}
fightResult={}
end
end


function worldResPointFightModel:onServerDataInitFinish()

end




function worldResPointFightModel:setBattleData(guid,subIdx,battleId)
local key=FMT.fmt("{0}_{1}",tostring(guid),subIdx)
battle[key]=battleId
end




function worldResPointFightModel:getBattleData(guid,subIdx)
local key=FMT.fmt("{0}_{1}",tostring(guid),subIdx)
return battle[key]
end





function worldResPointFightModel:setFightResult(guid,subIdx,subId,world,result,logIdx,level)
local key=FMT.fmt("{0}_{1}",tostring(guid),subIdx)
fightResult[key]=
{
["guid"]=guid,
["result"]=result,
["logIdx"]=logIdx,
["subIdx"]=subIdx,
["level"]=level,
["subId"]=subId,
["world"]=world,
}
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")
end


function worldResPointFightModel:clearFightResult(guid,subIdx)
local key=FMT.fmt("{0}_{1}",tostring(guid),subIdx)
fightResult[key]=nil
UIManager:invokeUIMethod("UIWorldMonsterListWin","refreshUI")
end

function worldResPointFightModel:getAllFightResult()
return fightResult
end



function worldResPointFightModel:getFightResult(guid,subIdx)
local key=FMT.fmt("{0}_{1}",tostring(guid),subIdx)
return fightResult[key]
end



function worldResPointFightModel:showFightResult(guid,subIdx)
local result=self:getFightResult(guid,subIdx)

if result then
local logIdx=result.logIdx
local fightResult=result.result
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
self:afterFight(unitKey,fightResult,logIdx,guid,subIdx)
end
end





function worldResPointFightModel:afterFight(unitKey,result,logIdx,guid,subIdx)
if result==fightResultType.Victory then
local logPackage=fightResultModel:getPackageResutl(logIdx)
worldUnitModel:unitEmot(unitKey,"#21",1)
worldUnitModel:unitDead(unitKey,logPackage.prizeList or{},function()
worldController:popUnit(unitKey)
self:clearFightResult(guid,subIdx)
end)
else
local afterEmot=function()
worldUnitModel.speResPoint(unitKey)
self:clearFightResult(guid,subIdx)
end
worldUnitModel:unitEmot(unitKey,"#12",2)
worldUnitModel:unitAttack(unitKey,2,afterEmot)
end
end






function worldResPointFightModel:fight(guid,subIdx,fightResult,logIdx)
notifySystem:postNotify(notifyConfig.onTriggerBattle,eBattleType.worldResPoint,fightResult,logIdx,guid,subIdx)
end