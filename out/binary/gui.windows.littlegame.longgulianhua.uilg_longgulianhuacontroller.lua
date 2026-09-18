







local _MODULENAME="UILG_LongGuLianHuaController"


def_table(_MODULENAME)
UILG_LongGuLianHuaController.name=_MODULENAME
UILG_LongGuLianHuaController.data={}


function UILG_LongGuLianHuaController:onAppStart()

end


function UILG_LongGuLianHuaController:onEnterState()

end


function UILG_LongGuLianHuaController:onLeaveState()


end

function UILG_LongGuLianHuaController:showLongGuLianHua(args,reset)
args=args or{}
local mapId=UILG_LongGuLianHuaModel:get_cur_mapId()
if not mapId then
mapId=self:randomMapId()
end
args.mapId=mapId
args.reset=reset
UIManager:showWindow("UILongGuLianHuaWin",args)
end

function UILG_LongGuLianHuaController:randomMapId()
local cfg=cfg_longgulianhuamapconfig()
local c=#cfg
return math.random(1,c)
end