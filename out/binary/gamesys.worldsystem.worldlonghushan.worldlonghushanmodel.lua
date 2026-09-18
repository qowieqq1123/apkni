






local _MODULENAME="worldLongHuShanModel"




def_table(_MODULENAME)
worldLongHuShanModel.name=_MODULENAME




function worldLongHuShanModel:onAppStart()

end


function worldLongHuShanModel:onEnterState()
self.data={}
self.data.eventData={}
end


function worldLongHuShanModel:onLeaveState(isReconnet)

self.data={}

if not isReconnet then

end
end


function worldLongHuShanModel:onServerDataInitFinish()

end

function worldLongHuShanModel:onReConnection()

end

function worldLongHuShanModel:isShowUnit()

local sub_actList=activitiesModel:getActSubList_subType_doing(SUB_ACTIVITY_TYPE.eLongHuHuiJuan)
if#(sub_actList or{})>0 then
for i,sub_actInfo in ipairs(sub_actList)do
local act_id=sub_actInfo.act_id
if sub_actInfo:checkOpen()and activitiesModel:checkActOpen(act_id)then
local check=false
local actInfo=activitiesModel:getActInfo(act_id)
local plotParams=actInfo:getActStartPlot()
if plotParams then
if activitiesModel:isPlotPlayed(act_id)then
check=true
end
else
check=true
end

if check then
return true,1,sub_actInfo.sub_act_id,sub_actInfo.act_id
end
end
end
end


local npcData=emergenciesControl_HuiJuan:getAllNPCData()
if npcData then
local now=timeHelper.getServerShortTime()
for i,v in pairs(npcData)do
if v.isGot==0 and now<v.endTime then
return true,2,i
end
end
end


end

function worldLongHuShanModel:showUnitImp(cfg,world,x,z,flip)
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.LONGHUSHAN,1})
local modelSettings=worldModel:getModelSettings(cfg.modelRes,eWorldUnitTpye.LONGHUSHAN)
local hudSettings=worldModel:getHUDSetting(cfg.hudRes)
local luaData={eWorldUnitTpye.LONGHUSHAN,1}
local position=worldPositionConfig:getPosition(world,{x,z})
worldController:pushUnit(unitKey,position,luaData,modelSettings,hudSettings)
worldController:setUnitFlipX(unitKey,flip or false)
end

function worldLongHuShanModel:hideUnitImp()
local unitKey=worldModel:convertUnitKey({eWorldUnitTpye.LONGHUSHAN,1})
worldController:popUnit(unitKey)
end

