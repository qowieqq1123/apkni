






local _MODULENAME="XianMengBaoXiaModel"


def_table(_MODULENAME)
XianMengBaoXiaModel.name=_MODULENAME
XianMengBaoXiaModel.data={}

function XianMengBaoXiaModel:onAppStart()

end


function XianMengBaoXiaModel:onEnterState(isReconnect)

end


function XianMengBaoXiaModel:onProtocolReq()

end


function XianMengBaoXiaModel:onLeaveState(isReconnect)

self.data={}
end



function XianMengBaoXiaModel:setXZBXList(len,xzbxList)
if not self.data.xzbx_list then
self.data.xzbx_list={}
end


if len>0 and xzbxList then
for k,v in ipairs(xzbxList)do
self.data.xzbx_list[v.guid]=v
end
end
end


function XianMengBaoXiaModel:freshXZBXData(xzbxData)
if xzbxData and xzbxData.guid then
local guid=xzbxData.guid
if not self.data.xzbx_list then
self.data.xzbx_list={}
end
self.data.xzbx_list[guid]=xzbxData
end
end


function XianMengBaoXiaModel:freshPushXZBXData(bxType,xzbxData)
if bxType==1 then

elseif bxType==2 then

end
if xzbxData and xzbxData.guid then
local guid=xzbxData.guid
if not self.data.xzbx_list then
self.data.xzbx_list={}
end
self.data.xzbx_list[guid]=xzbxData
end
end


function XianMengBaoXiaModel:getXZBXData()
return self.data.xzbx_list
end
function XianMengBaoXiaModel:getXZBXDataByGuid(guid)
if self.data.xzbx_list then
return self.data.xzbx_list[guid]
end
return false
end
