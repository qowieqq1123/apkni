






function zongmenModel:loadDesignMonsterData()

end


function isometricMapSystem:handleDesignCreateSundrise()
local randomList=table.deepCopy(zongmenModel:getAllSundriseData(mapIdType.zhufeng)or{})

for k,v in pairs(randomList)do
local sType=cfgHelper.get2(cfg_monijyrandomitemconfig_get,v.rand_item_id,"type")
if sType==sundriseType.eStillSundrise then
randomList[k]=nil
else
if(v.end_times>0 and zongmenSundriseTempDataModel.getCDLastTime(v.end_times)<=0)then
randomList[k]=nil
end
end
end

if randomList then
zongmenModel.data.designSundries=zongmenModel.data.designSundries or{}
for k,v in pairs(randomList)do
local data=isometricMapSystem:getSundriesDataByServerGuid(v.rand_item_guid)
if data then
local posType=sundriseCreateControl:getSundriesPosType(v.rand_item_guid)
if posType~=sundrisePosType.eRandom then
local pos=_MapManager.ToVector3Int(data.x,data.y,0)
local sundries=isometricMapSystem:createSundries({serverGuid=v.rand_item_guid+60000,id=data.id,flip=v.flip==1,pos=pos,areaId=_MapManager.GetAreaID(mapIdType.zhufeng_design,pos),mapId=mapIdType.zhufeng_design})
sundries.posType=posType
zongmenModel.data.designSundries[sundries.guid]=sundries
end
end
end
end
















end

function isometricMapSystem:removeDesignSundrise()
if zongmenModel.data.designSundries then
for i,v in pairs(zongmenModel.data.designSundries)do
isometricMapSystem:receiveSundries(v.mapId,v.serverGuid)
end
end
end