
local xianjie_RDPosPintData={}
local RDlookup={}

function xianjieModel:onAppStart_RDPosPint()

end

function xianjieModel:onEnterState_RDPosPint(isReconnet)
xianjie_RDPosPintData={}
end

function xianjieModel:onLeaveState_RDPosPint(isReconnet)
xianjie_RDPosPintData=nil
end

function xianjieModel:onProtocolReq_RDPosPint(isReconnet)

end



function xianjieModel.getPosbyGuid(guid)
local pos=RDlookup[guid]
if pos and pos[1]and pos[2]and pos[3]then
return pos
else
return nil
end
end

function xianjieModel.getPosKeybyGuid(guid)
local pos=RDlookup[guid]
if pos and pos[1]and pos[2]and pos[3]then
return string.format("%d_%d_%d",pos[1],pos[2],pos[3])
else
return nil
end
end

function xianjieModel.getPosKey(x,y,sceneidx)
return string.format("%d_%d_%d",x,y,sceneidx)
end



function xianjieModel:initRDPosPint(len,arry)
if len>0 and arry then
for k,v in ipairs(arry)do
local key=xianjieModel.getPosKey(v.x,v.y,v.sceneidx)
xianjie_RDPosPintData[key]=v
RDlookup[v.guid]={v.x,v.y,v.sceneidx}
end
end
end

function xianjieModel:newRDdata(ret,icon,content,sceneidx,x,y)
UIManager.info('标记已新增')
end

function xianjieModel:setDdata(guid,icon,content,sceneidx,x,y)
UIManager.info('标记已修改')
end

function xianjieModel:deletRDdata(guid)
UIManager.info('标记已删除')
end


function xianjieModel:freshRDdatalist(len,arry)
if len>0 and arry then
local addlist={}
local deletlist={}
for k,v in ipairs(arry)do
local key=xianjieModel.getPosKey(v.x,v.y,v.sceneidx)
local old_data=xianjie_RDPosPintData[key]
if not old_data then
xianjie_RDPosPintData[key]=v
RDlookup[v.guid]={v.x,v.y,v.sceneidx}
table.insert(addlist,v)
else
if v.icon==0 then
table.insert(deletlist,xianjie_RDPosPintData[key])
xianjie_RDPosPintData[key]=nil
RDlookup[v.guid]=nil
else
xianjie_RDPosPintData[key]=v
RDlookup[v.guid]={v.x,v.y,v.sceneidx}
end
end
end



if#deletlist>0 then
xianjieController:DeletOnlyZuobiao(deletlist)
deletlist={}
end
if#addlist>0 then
xianjieController:CreateOnlyZuobiao(addlist)
addlist={}
end
end
end


function xianjieModel:getRDdata()
return xianjie_RDPosPintData
end


function xianjieModel:getRDdataByPos(x,y,sceneidx)
local key=xianjieModel.getPosKey(x,y,sceneidx)
if xianjie_RDPosPintData[key]then
return xianjie_RDPosPintData[key]
else
return nil
end
end



function xianjieModel:checkprintdata()


end
function xianjieModel:checkdatabyxysceneidx(x,y,sceneidx)
local key=xianjieModel.getPosKey(x,y,sceneidx)
if xianjie_RDPosPintData[key]then
UIManager.info(FMT.fmt("有数据 打印checkdatabyxysceneidx，坐标为{0}、{1}、{2}",x,y,sceneidx))

else
UIManager.info(FMT.fmt("无数据 打印checkdatabyxysceneidx，坐标为{0}、{1}、{2}",x,y,sceneidx))

end
end






function xianjieModel:initAllZBDatas()
xianjieModel:clearData_allZB()
self.allZBDatas={}
self.allZBCreateEntFlag={}
end

function xianjieModel:clearData_allZB()
if self.allZBDatas and next(self.allZBDatas)then
for i,data in pairs(self.allZBDatas)do
xianjieController:removeXJClass(data)
end
self.allZBDatas=nil
self.allZBCreateEntFlag=nil
end
end

function xianjieModel:clearData_zb_bykeyId(key)
if self.allZBDatas and self.allZBDatas[key]then
local data=self.allZBDatas[key]
xianjieController:removeXJClass(data)
self.allZBDatas[key]=nil
self.allZBCreateEntFlag[key]=nil
end
end

function xianjieModel:createZBData(x,y,sceneidx,content,iconid,cbid)
if not self.allZBDatas then
self:initAllZBDatas()
end
local key=xianjieModel.getPosKey(x,y,sceneidx)
if not self.allZBDatas[key]and initProControl:isDoneKF()and xianjieModel:checkInit()then

local data=
{
keyId=key,
bj_x=x,
bj_y=y,
bj_sceneidx=sceneidx,
bj_content=content,
bj_iconid=iconid,
bj_cbid=cbid,
}
self.allZBDatas[key]=xianjieController:createXJClass(xjDataType.eZuoBiao,data)
return true
end
end

function xianjieModel:getZBDataBykeyId(key)
if not self.allZBDatas then
return nil
end
return self.allZBDatas[key]
end

function xianjieModel:getZBDataList()
return self.allZBDatas
end


function xianjieModel:createSingleZBEntities(key,needRefreshAOI)
if self.allZBDatas and key then
local data=self.allZBDatas[key]
if data and not self.allZBCreateEntFlag[key]then
local ret=data:createEntity(needRefreshAOI)
if ret then
self.allZBCreateEntFlag[key]=true
end
end
end
end

function xianjieModel:createAllZBEntities(needRefreshAOI)
local lp=self.allZBDatas
if lp then

for key,data in pairs(lp)do
if not self.allZBCreateEntFlag[key]then
local ret=data:createEntity(needRefreshAOI)
if ret then
self.allZBCreateEntFlag[key]=true
end
end
end
end
end

function xianjieModel:removeAllZBEntities()
local lp=self.allZBDatas
if lp then

for key,data in pairs(lp)do
if self.allZBCreateEntFlag[key]then
data:removeEntity()
self.allZBCreateEntFlag[key]=nil
end
end
end
end





