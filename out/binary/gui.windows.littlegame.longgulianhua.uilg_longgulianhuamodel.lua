







local _MODULENAME="UILG_LongGuLianHuaModel"


def_table(_MODULENAME)
UILG_LongGuLianHuaModel.name=_MODULENAME
UILG_LongGuLianHuaModel.data={}


function UILG_LongGuLianHuaModel:onAppStart()

end


function UILG_LongGuLianHuaModel:onEnterState()
self:init_data()
end


function UILG_LongGuLianHuaModel:onLeaveState()

self:init_data()
end


function UILG_LongGuLianHuaModel:init_data()
self.data={}
self.data.mapData={}
end

function UILG_LongGuLianHuaModel:get_map_index(x,y)
if not self.data.areaY then return end
return(x-1)*(self.data.areaY)+y
end

function UILG_LongGuLianHuaModel:init_map_data(mapId,areaX,areaY,mapData,times)
self.data.mapId=mapId
self.data.times=times
self.data.areaX=areaX
self.data.areaY=areaY
self.data.mapData=mapData
end

function UILG_LongGuLianHuaModel:clear_map_data()
self:init_map_data()
end

function UILG_LongGuLianHuaModel:get_cur_mapId()
return self.data.mapId
end

function UILG_LongGuLianHuaModel:set_times(times)
self.data.times=times
end

function UILG_LongGuLianHuaModel:get_times()
return self.data.times
end

function UILG_LongGuLianHuaModel:set_map_data(x,y,lgType)
local index=self:get_map_index(x,y)
self.data.mapData[index]=lgType
end

function UILG_LongGuLianHuaModel:get_map_data(x,y)
local index=self:get_map_index(x,y)
return self.data.mapData[index]
end

function UILG_LongGuLianHuaModel:get_map_all_data()
return self.data.mapData
end

function UILG_LongGuLianHuaModel:check_finish()
return(not self.data.times)or(self.data.times<=0 or self:check_success())
end

function UILG_LongGuLianHuaModel:check_success()
return self.data.times>=0 and next(self.data.mapData)==nil
end

function UILG_LongGuLianHuaModel:check_fail()
return self.data.times<=0 and next(self.data.mapData)~=nil
end