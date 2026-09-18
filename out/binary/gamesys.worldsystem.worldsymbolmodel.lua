






local _MODULENAME="worldSymbolModel"




def_table(_MODULENAME)
worldSymbolModel.name=_MODULENAME

local _Creators={}
local _Components={}

local _this=worldSymbolModel


function worldSymbolModel:onAppStart()
self:registerCreator(eWorldUnitTpye.SCENERY,self.onZongMenSymbolCreate)
self:registerCreator(eWorldUnitTpye.WORLDLEADER,self.onWorldBigBossSymbolCreate)
end


function worldSymbolModel:onEnterState()

end


function worldSymbolModel:onLeaveState()

end


function worldSymbolModel:onServerDataInitFinish()

end




function worldSymbolModel:registerCreator(unitType,handle)
_Creators[unitType]=handle
end




function worldSymbolModel:excuteCreator(unitType,...)
if _Creators[unitType]then
_Creators[unitType](...)
else

end
end




function worldSymbolModel:recordSymbol(key,cmp)
_Components[key]=cmp
end



function worldSymbolModel:eraseSymbol(key)
_Components[key]=nil
end



function worldSymbolModel:getSymbol(key)
return _Components[key]
end



function worldSymbolModel.onSymbolCreate(data)

local key=data.Key
local unitType=data.LuaData[1]
local Symbol=data.Symbol.Symbol
_this:recordSymbol(unitType,key,Symbol)
_this:excuteCreator(unitType,key,Symbol,data)
end



function worldSymbolModel.onSymbolDestory(data)
end





function worldSymbolModel.onZongMenSymbolCreate(key,cmp,data)

local tableId=data.LuaData[2]
local sceneryCfg=cfgHelper.get1(cfg_worldsceneryconfig_get,tableId)
local symbolCfg=cfgHelper.get1(cfg_worldsymbolconfig_get,sceneryCfg.symbolRes)
cmp:SetChildCSImageSprite(1,symbolCfg.abName,symbolCfg.icon)
cmp:SetChildButtonClick(1,function()
worldController:lookAtUnit(key)
end)
end

function worldSymbolModel.onWorldBigBossSymbolCreate(key,cmp,data)



cmp:SetChildButtonClick(1,function()
worldController:lookAtUnit(key)
end)

local monsterIdx=worldLeaderModel:getMonsterIdx()
local stageIdx=worldLeaderModel:getStageIdx()

local cfg=cfgHelper.get3(cfg_worldbossconfig_get,1,"monster",monsterIdx)
if cfg then
local monsterId=cfg[1][stageIdx]

comHelper.setChildModelRawImage_monsterGroup(cmp,monsterId,2,0,eHeadCenterType.eSymbol)
end
end
