






local _MODULENAME="worldBillBoardModel"




def_table(_MODULENAME)
worldBillBoardModel.name=_MODULENAME

local data={}
local _this=worldBillBoardModel


function worldBillBoardModel:onAppStart()

end


function worldBillBoardModel:onEnterState()

end


function worldBillBoardModel:onLeaveState()

end


function worldBillBoardModel:onServerDataInitFinish()

end

function worldBillBoardModel:pushData(unitKey,slotName,handleName,offset)
table.insert(data,{unitKey,slotName,handleName,offset or Vector3.zero})
end

function worldBillBoardModel:getAllData()
return data
end