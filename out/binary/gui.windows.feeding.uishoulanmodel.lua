
UIShouLanModel={}

ShouLanChangeType={
eAdd=1,
eRemove=2,
}

local _elementFrameIconNameLookup={
[1]="image_shoulan_jin",
[2]="image_shoulan_mu",
[3]="image_shoulan_shui",
[4]="image_shoulan_huo",
[5]="image_shoulan_tu",
}
local _colorFrameIconNameLookup={
[1]="image_shoulan_jin",
[2]="image_shoulan_mu",
[3]="image_shoulan_shui",
[4]="image_shoulan_huo",
[5]="image_shoulan_tu",
}
function UIShouLanModel:onEnterState(...)
self.data={sldatas={},unlockDatas={}}
self.lsGuid2ShouLanLookup={}
end

function UIShouLanModel:onLeaveState(...)

end

function UIShouLanModel:setDatas(datas)
local sldatas={}
for i,v in ipairs(datas)do
sldatas[v.un_build_id]=self:handleData(v)
end
self.data.sldatas=sldatas
end

function UIShouLanModel:setUnlockDatas(datas)
local ldatas={}
for i,v in ipairs(datas)do
ldatas[v]=true
end
self.data.unlockDatas=ldatas
end

function UIShouLanModel:isShouLanUnlock(slId)
local cfg=cfgHelper.get1(cfg_petbuildconfig_get,slId)
if not cfg.unlock_cost then
return true
end
return self.data.unlockDatas[slId]==true
end

function UIShouLanModel:unlockShouLan(slId)
self.data.unlockDatas[slId]=true
end

function UIShouLanModel:getDatas()
return self.data.sldatas or{}
end

function UIShouLanModel:handleData(data)
local petBaseInfoList=data.petBaseInfo or{}
local petBaseInfoLookup={}
local slId=data.un_build_id
for i,v in ipairs(petBaseInfoList)do
v.commItem=v.commItem or{}
local lsGuidStr=tostring(v.guid)
petBaseInfoLookup[lsGuidStr]=v
self.lsGuid2ShouLanLookup[lsGuidStr]=slId
end
data.petBaseInfoLookup=petBaseInfoLookup
return data
end

function UIShouLanModel:resetData(data)
data=self:handleData(data)
local sdata=self.data.sldatas[data.un_build_id]
if sdata then
for k,v in pairs(data)do
sdata[k]=v
end
else
self.data.sldatas[data.un_build_id]=data
end
end

function UIShouLanModel:clearData(bdId)
self:removeShouLanAllLingShou(bdId)
self.data.sldatas[bdId]=nil
end

function UIShouLanModel:setStopReason(slId,stop_reason)
local data=self:getShouLanData(slId)
data.stop_reason=stop_reason
end

function UIShouLanModel:getStopReason(slId)
local data=self:getShouLanData(slId)
return data.stop_reason
end

function UIShouLanModel:isShouLanStop(slId)
local data=self:getShouLanData(slId)
local str

if data.stop_reason==1 then

str="维护费用不足"
return true,str
end


local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,data.build_id)
local maxVal=slcfg.max_item_cnt
local currVal=self:getStoreNum(slId)
if currVal>=maxVal then

str="材料已满"
return true,str
end

return false
end

function UIShouLanModel:isShouLanCanCreate(slId,lsGuid)
local isShouLanStop=UIShouLanModel:isShouLanStop(slId)
if isShouLanStop then

return false
end


local lsData=lingshouModel:getLingShouData(lsGuid)
if lsData then
local xqLimitCfgVal=feedingSystem:getShouLanCreateXinQingLimitCfgValue()
local xqValue=lingshouModel:getLSXinQingValueEx(lsData)
if xqValue<xqLimitCfgVal then

return false
end
else

return false
end

return true
end

function UIShouLanModel:getShouLanData(slId)
return self.data.sldatas[slId]
end

function UIShouLanModel:getMonsterData(slId,lsGuid)
local data=self:getShouLanData(slId)
return data and data.petBaseInfoLookup[tostring(lsGuid)]
end

function UIShouLanModel:addMonster(slId,datas,infoLen,infoList)
local data=self:getShouLanData(slId)
for i,v in ipairs(datas)do
local lsGuid=v
local lsGuidStr=tostring(lsGuid)
local lsData=lingshouModel:getLingShouData(lsGuid)
local xqVal=lingshouModel:getLSXinQingValueEx(lsData)
local info=infoList[i]
local beginTime=info.param_1
local sec=info.param_2
self.lsGuid2ShouLanLookup[lsGuidStr]=slId
data.petBaseInfoLookup[lsGuidStr]={
guid=v,
begin_time=beginTime,
sec=sec,
love=xqVal,
len=0,
commItem={},
}
end
end

function UIShouLanModel:removeMonster(slId,datas)
local data=self:getShouLanData(slId)
for i,lsGuid in ipairs(datas)do
local lsGuidStr=tostring(lsGuid)
data.petBaseInfoLookup[lsGuidStr]=nil
if self.lsGuid2ShouLanLookup[lsGuidStr]then
self.lsGuid2ShouLanLookup[lsGuidStr]=nil
end
end
end

function UIShouLanModel:removeShouLanAllLingShou(slId)
local data=self:getShouLanData(slId)
if data and data.petBaseInfoLookup then
for lsGuidStr,v in pairs(data.petBaseInfoLookup)do
if self.lsGuid2ShouLanLookup[lsGuidStr]then
self.lsGuid2ShouLanLookup[lsGuidStr]=nil
end
end
end
end

function UIShouLanModel:getShouLanLingShouRaceList(slId)
local list={}
local data=self:getShouLanData(slId)
if data then
for lsGuidStr,v in pairs(data.petBaseInfoLookup)do
local lsData=lingshouModel:getLingShouData2(int64.new(lsGuidStr))
if lsData then
list[lsData.cfg.race]=1
else
list={1,1,1,1}
logErr("兽栏lsGuidStr转int64获取不到灵兽数据",serializeHelper.serialize(lsGuidStr))
end
end
end
return list
end

function UIShouLanModel:checkShouLanNoLingShouRaceTrait(slId,race)
local data=self:getShouLanData(slId)
if data then
for lsGuidStr,v in pairs(data.petBaseInfoLookup)do
local lsGuid=int64.new(lsGuidStr)
local isHas,wordID=lingshouModel:checkLingShouHasTraitTypeEx(lsGuid,lingshouTraitEffectEnum.LINGSHOU_LIVE_NO_OTHER_RACE)
if isHas then
local lsData=lingshouModel:getLingShouData2(lsGuid)
if lsData.cfg.race~=race then
return true,lsGuid,wordID
end
end
end
end
return false
end

function UIShouLanModel:getShouLanUbdIdByLsGuid(lsGuid)
local lsGuidStr=tostring(lsGuid)
local ubdId=self.lsGuid2ShouLanLookup[lsGuidStr]
return ubdId
end

function UIShouLanModel:changeShouLanStyle(ubdId,bdId)
local data=self:getShouLanData(ubdId)
data.build_id=bdId
end

function UIShouLanModel:changeShouLanDecorate(ubdId,bdId)
local data=self:getShouLanData(ubdId)
data.decorate_id=bdId
end

function UIShouLanModel:setCurrReward(slId,lsGuid,time,xinqingVal,sec,len,datas)
local data=self:getShouLanData(slId)
if data then
local lsdata=data.petBaseInfoLookup[tostring(lsGuid)]
lsdata.begin_time=time or lsdata.begin_time
lsdata.sec=sec or lsdata.sec
lsdata.love=xinqingVal or lsdata.love
lsdata.len=len
lsdata.commItem=datas or{}


data.storeNum=nil
end
end

function UIShouLanModel:clearReward(slId,slist)
for i,v in ipairs(slist)do
local lsGuid=v


self:setCurrReward(slId,v,nil,nil,nil,0)
feedingSystem:addCountDownData(slId,lsGuid)
end
end

function UIShouLanModel:getStoreNum(slId)
local data=self:getShouLanData(slId)
if not data.storeNum then
UIShouLanModel:refreshStoreNum(slId)
end
return data.storeNum
end

function UIShouLanModel:refreshStoreNum(slId)
local data=self:getShouLanData(slId)
local count=0
local slCfg=cfgHelper.get1(cfg_petbuildconfig_get,data.build_id)
if slCfg.max_item_map then
local checkLookup=slCfg.max_item_map
for k,v in pairs(data.petBaseInfoLookup)do
for ii,vv in ipairs(v.commItem)do
local itemId=vv.param_1
if checkLookup[itemId]then
count=count+vv.param_2
end
end
end
end
data.storeNum=count
end

function UIShouLanModel:hasRewardCanReceive(slId)
local data=self:getShouLanData(slId)
if data then
for k,v in pairs(data.petBaseInfoLookup)do
if v.len>0 then
return true
end
end
end
return false
end

function UIShouLanModel:getCanReceiveRewardFirstItemId(slId)
local data=self:getShouLanData(slId)
if data then
for k,v in pairs(data.petBaseInfoLookup)do
if v.len>0 then
local reward=v.commItem[1]
local itemId=reward.param_1
return itemId
end
end
end
return
end

function UIShouLanModel:getMonsterVolume(slId)
local count=0
local data=self:getShouLanData(slId)
for k,v in pairs(data.petBaseInfoLookup)do
local volume=lingshouModel.getLingShouPropertyValEx(v.guid,lingshouPropertyType.VOLUME)
count=count+volume
end
return count
end

function UIShouLanModel:isCanPutIn(slId,addVolume,isWarning)
local data=self:getShouLanData(slId)

local bdData=zongmenModel:getBuildingData(data.un_build_id)
local dzId=bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
if not hasDZ then
if isWarning then
UIManager.error("请先选择入驻弟子")
end
return false
end


local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,data.build_id)
local currVal=self:getMonsterVolume(slId)
if currVal+addVolume>slcfg.volume then
if isWarning then
UIManager.error("兽栏容积上限，请重新选择")
end
return false
end
return true
end



function UIShouLanModel:isCanPutIn_reasonType(slId,addVolume,isWarning)
local data=self:getShouLanData(slId)

local bdData=zongmenModel:getBuildingData(data.un_build_id)
local dzId=bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
if not hasDZ then
if isWarning then
UIManager.error("请先选择入驻弟子")
end
return 1
end


local slcfg=cfgHelper.get1(cfg_petbuildconfig_get,data.build_id)
local currVal=self:getMonsterVolume(slId)
if currVal+addVolume>slcfg.volume then
if isWarning then
UIManager.error("兽栏容积上限，请重新选择")
end
return 2
end
return 0
end

function UIShouLanModel:isCanStorage(slId)
local data=self:getShouLanData(slId)
return next(data.petBaseInfoLookup)==nil
end

function UIShouLanModel.refreshSpecialityItemEx(item,speCfg,name,isElement)
name=UIShouLanModel.getSpecialityNameStr(name or speCfg.name)
if isElement then
name=FMT.fmt("{0}属性",name)
end
item:SetChildText(1,name)
local color=speCfg.framecolor or speCfg.color
if isElement then
color=speCfg.id
end
local abName,frameIcon=UIShouLanModel.getSpecialityColorFrame(color,isElement)
item:SetChildCSImageSprite(0,abName,frameIcon)
end

function UIShouLanModel.getSpecialityColorFrame(color,isElement)
local abName="ui/windows/feeding/shoulan_atlas_pak.ab"
local frameIcon
if isElement then
frameIcon=_elementFrameIconNameLookup[color]
else
frameIcon=_colorFrameIconNameLookup[color]
end

return abName,frameIcon
end

function UIShouLanModel.getSpecialityNameStr(name)
if pfwindowslController:checkIsGameVersion_yuenan()then
name=string.addNewlineAfterSecondWord(name)
if string.lenEx(name)>22 then
name=utf8.sub(name,1,22)
name=string.format("%s...",name)
end
else
if string.lenEx(name)>4 then
name=utf8.sub(name,1,4)
name=string.format("%s...",name)
end
end
return name
end

function UIShouLanModel:getLsXinQingAddCreateTimeRate(lsGuid,slId)

local slLingShouData=UIShouLanModel:getMonsterData(slId,lsGuid)
local xqVal=slLingShouData.love
return UIShouLanModel:getLsXinQingAddCreateTimeRateEx(xqVal)
end

function UIShouLanModel:getLsXinQingAddCreateTimeRateEx(xinQingValue)
local rateCfg=cfgHelper.getdef1(cfg_lingshouconfig,'love_create_time')
if rateCfg then
for i,v in ipairs(rateCfg)do
local minXqValue=v[1]
local maxXqValue=v[2]
local rate=v[3]
if xinQingValue>=minXqValue and xinQingValue<=maxXqValue then
return rate
end
end
end

return 1
end


function UIShouLanModel:getShouLanHasDzCount()
local slDataList=self:getDatas()
local count=0
for i,slData in pairs(slDataList)do
local bdData=zongmenModel:getBuildingData(slData.un_build_id)
local dzId=bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
if hasDZ then
count=count+1
end
end

return count
end


function UIShouLanModel:getShouLanHasLsCount()
local count=0
if self.lsGuid2ShouLanLookup then
for lsGuidStr,slId in pairs(self.lsGuid2ShouLanLookup)do
count=count+1
end
end

return count
end
