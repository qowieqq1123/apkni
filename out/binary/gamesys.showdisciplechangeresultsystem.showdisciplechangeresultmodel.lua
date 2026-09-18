






local _MODULENAME="showDiscipleChangeResultModel"




def_table(_MODULENAME)
showDiscipleChangeResultModel.name=_MODULENAME


showDiscipleChangeResultModel.data={}

local _insertFlag=false
local _insertList={}

local _insertFlagClient=false
local _insertListClient={}


function showDiscipleChangeResultModel:onAppStart()

end


function showDiscipleChangeResultModel:onEnterState()

end


function showDiscipleChangeResultModel:onLeaveState()

self.data={}
self:clearData()
self:clearDataClient()
end


function showDiscipleChangeResultModel:onServerDataInitFinish()

end



function showDiscipleChangeResultModel:insertCommon(list,discipleGuid,eType,datas)
table.checkCreateSubTable(list,{eType,tostring(discipleGuid)})
table.insert(list[eType][tostring(discipleGuid)],datas)
end


function showDiscipleChangeResultModel:clearData()
_insertFlag=false
_insertList={}
end

function showDiscipleChangeResultModel:onInsertStart()
_insertFlag=true
_insertList={}
end

function showDiscipleChangeResultModel:isState()
return _insertFlag
end

function showDiscipleChangeResultModel:onInsertEnd()
_insertFlag=false
end

function showDiscipleChangeResultModel:insertData(discipleGuid,eType,datas)
self:insertCommon(_insertList,discipleGuid,eType,datas)
end

function showDiscipleChangeResultModel:getData(eType)
return _insertList[eType]
end

function showDiscipleChangeResultModel:haveData(eType)
local data=self:getData(eType)
return data~=nil and next(data)~=nil
end

function showDiscipleChangeResultModel:allData()
return _insertList
end



function showDiscipleChangeResultModel:clearDataClient()
_insertFlagClient=false
_insertListClient={}
end

function showDiscipleChangeResultModel:onInsertClientStart()
_insertFlagClient=true
_insertListClient={}
end

function showDiscipleChangeResultModel:isStateClient()
return _insertFlagClient
end

function showDiscipleChangeResultModel:onInsertClientEnd(effectData)
local prizeType=effectData.effecttype
local temp=table.deepCopy(_insertListClient)
notifySystem:postNotify(notifyConfig.onShowDiscipleChanged,prizeType,temp,effectData)
self:clearDataClient()
end

function showDiscipleChangeResultModel:insertDataClient(discipleGuid,eType,datas)
self:insertCommon(_insertListClient,discipleGuid,eType,datas)
end

function showDiscipleChangeResultModel:getDataClient(eType)
return _insertListClient[eType]
end

function showDiscipleChangeResultModel:haveDataClient(eType)
local data=self:getDataClient(eType)
return data~=nil and next(data)~=nil
end

function showDiscipleChangeResultModel:getAllDataClient()
return _insertListClient
end



