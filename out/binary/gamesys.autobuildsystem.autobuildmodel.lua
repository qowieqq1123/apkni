






local _MODULENAME="AutoBuildModel"


def_table(_MODULENAME)
AutoBuildModel.name=_MODULENAME
AutoBuildModel.data={}

function AutoBuildModel:onAppStart()

end


function AutoBuildModel:onEnterState(isReconnect)

end


function AutoBuildModel:onProtocolReq()

end


function AutoBuildModel:onLeaveState(isReconnect)

self.data={}
end



function AutoBuildModel:setAutoBuildingData(len,buildList)
if not self.data.buildList then
self.data.buildList={}
end

if len>0 and buildList then
for k,v in ipairs(buildList)do
self.data.buildList[v.un_build_id]=v
end
end
end


function AutoBuildModel:setAutoBuildingSingleData(buildList)
if not self.data.buildList then
self.data.buildList={}
end
if buildList and buildList.un_build_id then
self.data.buildList[buildList.un_build_id]=buildList
end
end


function AutoBuildModel:setAutoBuildingLevelUp(sf_id,un_build_id,level,exp)
if self.data.buildList[un_build_id]then
self.data.buildList[un_build_id].level=level
self.data.buildList[un_build_id].exp=exp
end
end


function AutoBuildModel:getAutoBuildingSfid(un_build_id)
if self.data.buildList[un_build_id]then
return self.data.buildList[un_build_id].sf_id or 1
end
return 1
end

function AutoBuildModel:getAutoBuildingLvl(un_build_id)
if self.data.buildList[un_build_id]then
return self.data.buildList[un_build_id].level or 1
end
return 1
end

function AutoBuildModel:getAutoBuildingExp(un_build_id)
if self.data.buildList[un_build_id]then
return self.data.buildList[un_build_id].exp or 0
end
return 0
end

function AutoBuildModel:getAutoBuildingCreateList(un_build_id)
if self.data.buildList[un_build_id]then
return self.data.buildList[un_build_id].createList or defaultT
end
return defaultT
end

