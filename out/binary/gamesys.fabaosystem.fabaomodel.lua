





fabaoModel={}
local _tick=0.1
local _filter={}
local _temp={}
function fabaoModel.init()
fabaoModel.equips={}
fabaoModel.equipsLookup={}
fabaoModel.diziLookup={}
fabaoModel.diziStrLookup={}
fabaoModel.equipsSwitchIdxLookup={}
fabaoModel.initAttrsData()
fabaoModel.stopAllLianzhiTimer()
fabaoModel.stampLookup=nil
fabaoModel.lianzhiTimer={}
fabaoModel.absorbExp={}
fabaoModel.absorbExpRate={}
fabaoModel.absorbExpstamp={}
fabaoModel.absorbExpFabaoList={}

fabaoModel.ownerLookup={}
fabaoModel.ownerItemLookup={}

fabaoModel.isBatchMarkList={}
_temp={}
end

function fabaoModel:update()
if fightModel:haveBattleShow()then return end
if#_temp>0 then
local len=2
while#_temp>0 and len>0 do
len=len-1
local itemguid=_remove(_temp,1)
fabaoModel.bananceExp(itemguid)
end
else
for _,itemguid in ipairs(fabaoModel.absorbExpFabaoList)do
_temp[#_temp+1]=itemguid
end
end

if#fabaoModel.absorbExpFabaoList>0 then
reddotControl.onFabaoLxExpChange()
end
end





function fabaoModel.onFabaoCreate(guidlist,itemguid)

end

function fabaoModel.onFabaoDress(diziguid,itemguid)
local item=bagModel.getItem(itemguid)
if item==nil then
loggerUtil.logErrFMT('法宝背包不存在此装备',tostring(itemguid))
return
end
fabaoModel.addFabao(diziguid,item,true)
end

function fabaoModel.onFabaoTakeoff(dzguid)
local equip=fabaoModel.getFabaoByDizi(dzguid)
if equip==nil then return end
if fabaoConfig.isBenMingFabao(equip.itemid)then
fabaoModel.setAbsorbExp(dzguid,equip.itemguid,false)
end
fabaoModel.deleteFabao(dzguid)
end

function fabaoModel.onFabaoJilian(itemguid,level,exp)
local item=fabaoHelper.getFabao(itemguid)
if item and item.itemData then
local itemData=item.itemData
itemData.jilianlv=level
itemData.jilianexp=exp
end
end

function fabaoModel.onFabaoJilianByDizi(diziguid,level,exp)
local item=fabaoModel.getFabaoByDizi(diziguid)
if item and item.itemData then
local itemData=item.itemData
itemData.jilianlv=level
itemData.jilianexp=exp
fabaoModel.changeFabao(diziguid,item)
end
end

function fabaoModel.onFabaoLianhua(itemguid,times,len,list,isInit)
local item=fabaoHelper.getFabao(itemguid)
if item and item.itemData then
local itemData=item.itemData
itemData.lianhuanum=times
itemData.lianhualen=len
itemData.lianhuaList=list
if isInit then
itemData.initlianhualen=len
itemData.initlianhuaList=list
end
end
end

function fabaoModel.onFabaoLianhuaByDizi(diziguid,times,len,list,isInit)
local item=fabaoModel.getFabaoByDizi(diziguid)
if item and item.itemData then
local itemData=item.itemData
itemData.lianhuanum=times
itemData.lianhualen=len
itemData.lianhuaList=list
if isInit then
itemData.initlianhualen=len
itemData.initlianhuaList=list
end
fabaoModel.changeFabao(diziguid,item)
UIDiscipleModel:setSkillLvPlusLookupDirty(diziguid)
end
end

function fabaoModel.onFabaoLianhuaTimesByDizi(diziguid,val)
local item=fabaoModel.getFabaoByDizi(diziguid)
if item and item.itemData then
local itemData=item.itemData
itemData.lianhuatimes=val
fabaoModel.changeFabao(diziguid,item)
end
end

function fabaoModel.onFabaoLianhuaTimes(itemguid,val)
local item=fabaoHelper.getFabao(itemguid)
if item and item.itemData then
local itemData=item.itemData
itemData.lianhuatimes=val
end
end

function fabaoModel.onFabaoChangeName(itemguid,name)
local item=fabaoHelper.getFabao(itemguid)
if item and item.itemData then
local itemData=item.itemData
itemData.name=name
end
end

function fabaoModel.initFabao(diziArray)
fabaoModel.equips={}
fabaoModel.equipsLookup={}
fabaoModel.equipsSwitchIdxLookup={}
for i,v in ipairs(diziArray)do
fabaoModel.addNewDizi(v,true)
end
end

function fabaoModel.deleDizi(diziguid)
fabaoModel.removeBenMingOwner(diziguid)
fabaoModel.deleteFabao(diziguid)
end

function fabaoModel.addNewDizi(dizidata,init)
if fabaoModel.equips==nil then fabaoModel.equips={}end
if fabaoModel.equipsLookup==nil then fabaoModel.equipsLookup={}end
local diziguid=dizidata.discipleguid
local array=dizidata.fabaoList or{}
for i,v in ipairs(array)do
fabaoModel.addFabao(diziguid,v,nil,init)
end

if dizidata.switchList and next(dizidata.switchList)then
for switchidx,data in ipairs(dizidata.switchList)do
if data.fabaoList and next(data.fabaoList)then
local switchEquipList=data.fabaoList
for i,v in ipairs(switchEquipList)do
fabaoModel.addFabao(diziguid,v,nil,init,switchidx)
end
end
end
end
end

function fabaoModel.addFabao(diziguid,item,showFightTips,init,switchidx)
switchidx=switchidx or 0
fabaoHelper.handleItem(item)
local diziguidStr=tostring(diziguid)
local litem=fabaoModel.equipsLookup[diziguidStr]and fabaoModel.equipsLookup[diziguidStr][switchidx]or nil
if litem and tostring(litem.itemguid)==tostring(item.itemguid)then


return
end
local itemguid=item.itemguid
local itemguidStr=tostring(itemguid)
if not fabaoModel.equipsLookup[diziguidStr]then
fabaoModel.equipsLookup[diziguidStr]={}
end
fabaoModel.equipsLookup[diziguidStr][switchidx]=item
fabaoModel.equips[itemguidStr]=item
if switchidx~=0 then
fabaoModel.equipsSwitchIdxLookup[tostring(itemguid)]=switchidx
end


fabaoModel.diziLookup[itemguidStr]={guid=diziguid,switchidx=switchidx}
fabaoModel.diziStrLookup[itemguidStr]={guidStr=diziguidStr,switchidx=switchidx}
fabaoModel.addBenMingOwner(diziguid,item,true,init)
if switchidx==0 then
fabaoModel.onChangeAttrsOnFabao(diziguid,itemguid,showFightTips)
UIDiscipleModel:setSkillLvPlusLookupDirty(diziguid)
end
pushGiftTwoManager:onFabaoChange(init)
pushGiftThreeManager:onFabaoChange(init)
dataControl.onFaBaoChange()
end


function fabaoModel.deleteFabao(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
local item=fabaoModel.equipsLookup[diziguidStr]and fabaoModel.equipsLookup[diziguidStr][switchidx]or nil
if item==nil then return end
fabaoModel.equipsLookup[diziguidStr][switchidx]=nil
local itemguid=item.itemguid
local itemguidStr=tostring(itemguid)
fabaoModel.equips[itemguidStr]=nil
fabaoModel.diziLookup[itemguidStr]=nil
fabaoModel.diziStrLookup[itemguidStr]=nil
fabaoModel.equipsSwitchIdxLookup[itemguidStr]=nil
if switchidx==0 then
fabaoModel.onChangeAttrsOnFabao(diziguid,itemguid,true)
UIDiscipleModel:setSkillLvPlusLookupDirty(diziguid)
end
dataControl.onFaBaoChange()
return EQUIP_TYPE.eFabao
end


function fabaoModel.changeFabao(diziguid,item,switchidx)
switchidx=switchidx or 0
if item==nil then return end
local diziguidStr=tostring(diziguid)
local itemguid=item.itemguid
local itemguidStr=tostring(itemguid)
if not fabaoModel.equipsLookup[diziguidStr]then
fabaoModel.equipsLookup[diziguidStr]={}
end
fabaoModel.equipsLookup[diziguidStr][switchidx]=item
fabaoModel.equips[itemguidStr]=item


fabaoModel.diziLookup[itemguidStr]={guid=diziguid,switchidx=switchidx}
fabaoModel.diziStrLookup[itemguidStr]={guidStr=diziguidStr,switchidx=switchidx}
if switchidx==0 then
fabaoModel.onChangeAttrsOnFabao(diziguid,itemguid,true)
end
end

function fabaoModel.switchFabao(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if not fabaoModel.equipsLookup[diziguidStr]then
fabaoModel.equipsLookup[diziguidStr]={}
end

local useSwitchIdx=0
local originalEquip=fabaoModel.equipsLookup[diziguidStr][useSwitchIdx]
local switchEquip=fabaoModel.equipsLookup[diziguidStr][switchidx]
fabaoModel.equipsLookup[diziguidStr][useSwitchIdx]=switchEquip
fabaoModel.equipsLookup[diziguidStr][switchidx]=originalEquip

if originalEquip and next(originalEquip)then
fabaoModel.diziLookup[tostring(originalEquip.itemguid)]={guid=diziguid,switchidx=switchidx}
fabaoModel.diziStrLookup[tostring(originalEquip.itemguid)]={guidStr=diziguidStr,switchidx=switchidx}
fabaoModel.equipsSwitchIdxLookup[tostring(originalEquip.itemguid)]=switchidx
fabaoModel.onChangeAttrsOnFabao(diziguid,originalEquip.itemguid)
end
if switchEquip and next(switchEquip)then
fabaoModel.diziLookup[tostring(switchEquip.itemguid)]={guid=diziguid,switchidx=useSwitchIdx}
fabaoModel.diziStrLookup[tostring(switchEquip.itemguid)]={guidStr=diziguidStr,switchidx=useSwitchIdx}
fabaoModel.equipsSwitchIdxLookup[tostring(switchEquip.itemguid)]=nil
fabaoModel.addBenMingOwner(diziguid,switchEquip,true)
fabaoModel.onChangeAttrsOnFabao(diziguid,switchEquip.itemguid)
end
UIDiscipleModel:setSkillLvPlusLookupDirty(diziguid)
pushGiftTwoManager:onFabaoChange()
pushGiftThreeManager:onFabaoChange()
dataControl.onFaBaoChange()
end





function fabaoModel.getFabao(itemguid)
return fabaoModel.equips[tostring(itemguid)]
end

function fabaoModel.getFabaoByDzStr(dzguidStr,switchidx)
switchidx=switchidx or 0
if fabaoModel.equipsLookup[dzguidStr]==nil then return end
if fabaoModel.equipsLookup[dzguidStr][switchidx]==nil then return end
return fabaoModel.equipsLookup[dzguidStr][switchidx]
end

function fabaoModel.getFabaoByDizi(diziguid,switchidx)
switchidx=switchidx or 0
local diziguidStr=tostring(diziguid)
if fabaoModel.equipsLookup[diziguidStr]==nil then return end
if fabaoModel.equipsLookup[diziguidStr][switchidx]==nil then return end
return fabaoModel.equipsLookup[diziguidStr][switchidx]
end

function fabaoModel.getEquipByFilter(filter,useCache)
return itemsFilterHelper.filterLookItems(fabaoModel.equips,filter,useCache)
end

function fabaoModel.getDiziguidByItemguid(itemguid)
local data=fabaoModel.diziLookup[tostring(itemguid)]
return data and data.guid or nil
end

function fabaoModel.getDiziguidStrByItemguid(itemguid)
local data=fabaoModel.diziStrLookup[tostring(itemguid)]
return data and data.guidStr or nil
end

function fabaoModel.getFabaoLianhuanum(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.lianhuanum or 0
end
end
return 0
end


function fabaoModel.getFabaoJilianLevel(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.jilianlv,itemData.jilianexp
end
end
return 0,0
end

function fabaoModel.getFabaoJilianExp(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.jilianexp,itemData.jilianexp
end
end
return 0,0
end

function fabaoModel.getFabaoJilianExpByDizi(diziguid)
local equip=fabaoModel.getFabaoByDizi(diziguid)
if equip then
local itemData=equip.itemData
if itemData then
return itemData.jilianlv,itemData.jilianexp
end
end
return 0,0
end

function fabaoModel.getFabaoSwitchIdx(itemguid)
return fabaoModel.equipsSwitchIdxLookup[tostring(itemguid)]
end





function fabaoModel.isEquipedOnAnyDizi(itemguid)





return fabaoModel.getFabao(itemguid)~=nil
end


function fabaoModel.isEquipedOnDizi(diziguid,itemguid)
local item=fabaoModel.getFabaoByDizi(diziguid)
if item and tostring(item.itemguid)==tostring(itemguid)then
return true
end
return false
end


function fabaoModel.setYunYang(equip,num)
equip.itemData.yunyang=num
end

function fabaoModel.isYunYang(equip)
return equip.itemData.yunyang==1
end

function fabaoModel.getLingXingLvByEquip(equip)
return equip.itemData.lingxinglv
end

function fabaoModel.getMianidxByEquip(equip)
return equip.itemData.mainidx
end

function fabaoModel.getLingXingLv(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
local lv=fabaoModel.getLingXingLvByEquip(equip)
return lv
end

function fabaoModel.getFabaoLingXingExp(itemguid)
local equip=fabaoHelper.getFabao(itemguid)
if equip then
return fabaoModel.getLingXingExp(equip)
end
return 0
end

function fabaoModel.getFabaoReallyLingXingLvByDizi(dzguid)
local equip=fabaoModel.getFabaoByDizi(dzguid)
local reallylv=fabaoModel.getLingXingLvByEquip(equip)
return reallylv
end

function fabaoModel.onYunYang(itemguid,num)
local equip=fabaoHelper.getFabao(itemguid)
if equip then
fabaoModel.setYunYang(equip,num)
local dzguid=fabaoModel.getDiziguidByItemguid(itemguid)
local flag=num==1 and true or false
fabaoModel.setAbsorbExp(dzguid,itemguid,flag)
end
end

function fabaoModel.onYunYangByDZ(dzguid,num)
local equip=fabaoModel.getFabaoByDizi(dzguid)
if equip then
fabaoModel.setYunYang(equip,num)
local flag=num==1 and true or false
fabaoModel.setAbsorbExp(dzguid,equip.itemguid,flag)
end
end

function fabaoModel.onFabaoLingXing(itemguid,level,exp)
local equip=fabaoHelper.getFabao(itemguid)
if equip and equip.itemData then
local itemData=equip.itemData
itemData.lingxinglv=level
itemData.lingxingexp=exp
fabaoModel.clearBananceExp(itemguid)
end
end

function fabaoModel.onFabaoLingXingByDizi(dzguid,level,exp)
local equip=fabaoModel.getFabaoByDizi(dzguid)
if equip and equip.itemData then
local itemData=equip.itemData
local old=itemData.lingxinglv
itemData.lingxinglv=level
itemData.lingxingexp=exp
if old~=level then
fabaoModel.setAbsorbExp(dzguid,equip.itemguid,true)
end
fabaoModel.changeFabao(dzguid,equip)
end
end

function fabaoModel.onFabaoLingXingExp(itemguid,exp)
local equip=fabaoHelper.getFabao(itemguid)
if equip and equip.itemData then
equip.itemData.lingxingexp=exp
fabaoModel.clearBananceExp(itemguid)
end
end

function fabaoModel.onFabaoLingXingExpByDizi(dzguid,exp)
local equip=fabaoModel.getFabaoByDizi(dzguid)
if equip and equip.itemData then
local itemData=equip.itemData
itemData.lingxingexp=exp
fabaoModel.clearBananceExp(equip.itemguid)
end
end

function fabaoModel.onFabaoShengTongChange(itemguid,mainidx)
local equip=fabaoHelper.getFabao(itemguid)
if equip and equip.itemData then
equip.itemData.mainidx=mainidx
end
end


function fabaoModel.onChangeOwner(itemguid,dzguid,lastguid)
local equip=fabaoHelper.getFabao(itemguid)
benMingFaBaoHelper.setOwnerByEquip(equip,dzguid)
end

function fabaoModel.findTopLingXingBenMingFaBao()
table.clear(_filter)
_filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eFabao
_filter[ITEM_FILTER_TYPE.eItemType1]=FABAO_TYPE.eBenMing

local top=nil
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,_filter,false,true)
for i,v in ipairs(baglist)do
if top then
if top.itemData.lingxinglv<v.itemData.lingxinglv then
top=v
end
else
top=v
end
end
local equiplist=fabaoModel.getEquipByFilter(_filter,true)
for i,v in ipairs(equiplist)do
if top then
if top.itemData.lingxinglv<v.itemData.lingxinglv then
top=v
end
else
top=v
end
end
if top then
return top.itemguid
end
end








function fabaoModel.setLianzhiInfoArray(len,array)
fabaoModel.stampLookup=nil
if len>0 then
fabaoModel.stampLookup={}
local stampLookup=fabaoModel.stampLookup
for i,v in ipairs(array)do
local ubdId=v.param_2
local sfId=v.param_1
local fabaoid=v.param_3
local mainid=v.param_4
local stamp=v.param_5

fabaoModel.setLianzhiInfo(sfId,ubdId,fabaoid,mainid,stamp)
fabaoModel.startLianzhiTimer(sfId,ubdId)
end
end
end

function fabaoModel.setLianzhiInfoByBatchList(len,batchList)
if len>0 then
for i,v in ipairs(batchList)do
local sfid=v.sfid
local ubdId=v.buildguid
local list=v.list
local stamp=v.beginsec
if list then
local lastEndTime=stamp
for _,lianzhiData in ipairs(list)do
local idList=lianzhiData.idList
local materialid=lianzhiData.materialid
local fabaoid=nil
local mainid=idList[1]
local stage=itemsConfig.getConfig(mainid).stage
local needtime=fabaoConfig.getCreateTime(stage)
local endTimeStamp=lastEndTime+needtime
fabaoModel.setLianzhiInfo(sfid,ubdId,fabaoid,mainid,endTimeStamp,true)
lastEndTime=endTimeStamp
end
end
fabaoModel.startLianzhiTimer(sfid,ubdId)
end
end
end









function fabaoModel.getLianzhiInfoNowIdx(ubdId)
if fabaoModel.stampLookup==nil or fabaoModel.stampLookup[ubdId]==nil or fabaoModel.stampLookup[ubdId].infoList==nil then return end
local nowIndex
local infoList=fabaoModel.stampLookup[ubdId].infoList
local nowtime=gameUtilityModel.getServerShortTime()
local finalIdx=fabaoModel.getLianzhiInfoFinalIdx(ubdId)
for i,v in ipairs(infoList)do
local isFinal=i==finalIdx
if isFinal or nowtime<v.param_5 then
nowIndex=i
break
end
end

return nowIndex
end


function fabaoModel.getLianzhiInfoNowFinishIdx(ubdId)
if fabaoModel.stampLookup==nil or fabaoModel.stampLookup[ubdId]==nil or fabaoModel.stampLookup[ubdId].infoList==nil then return end
local nowFinishIndex
local infoList=fabaoModel.stampLookup[ubdId].infoList
local nowtime=gameUtilityModel.getServerShortTime()
for i,v in ipairs(infoList)do
if nowtime>=v.param_5 then
nowFinishIndex=i
else
break
end
end
return nowFinishIndex
end

function fabaoModel.getLianzhiInfoFinalIdx(ubdId)
if fabaoModel.stampLookup==nil or fabaoModel.stampLookup[ubdId]==nil or fabaoModel.stampLookup[ubdId].infoList==nil then return end
local finalIdx=#fabaoModel.stampLookup[ubdId].infoList
if finalIdx<=0 then
finalIdx=nil
end
return finalIdx
end

function fabaoModel.getLianzhiInfoByIdx(ubdId,infoIdx)
if not infoIdx then return end
if fabaoModel.stampLookup==nil or fabaoModel.stampLookup[ubdId]==nil or fabaoModel.stampLookup[ubdId].infoList==nil then return end
return fabaoModel.stampLookup[ubdId].infoList[infoIdx]
end

function fabaoModel.getLianzhiInfoList(ubdId)
if fabaoModel.stampLookup==nil or fabaoModel.stampLookup[ubdId]==nil then return end
return fabaoModel.stampLookup[ubdId].infoList
end


function fabaoModel.setLianzhiInfoList(ubdId,infoList)
if fabaoModel.stampLookup==nil then fabaoModel.stampLookup={}end
if fabaoModel.stampLookup[ubdId]==nil then fabaoModel.stampLookup[ubdId]={}end
fabaoModel.stampLookup[ubdId].infoList=infoList
end

function fabaoModel.hasLianzhiInfo(ubdId)
local finalIdx=fabaoModel.getLianzhiInfoFinalIdx(ubdId)
if not finalIdx then
return false
end

local lianzhiInfoList=fabaoModel.getLianzhiInfoByIdx(ubdId,finalIdx)
return lianzhiInfoList~=nil and next(lianzhiInfoList)~=nil
end

function fabaoModel.getOnekeyPrize()
local stampLookup=fabaoModel.stampLookup
if stampLookup==nil then return end
local sfId=mapIdType.zhufeng
local isBatchMarkList=fabaoModel.isBatchMarkList or{}
local temp={}
for ubdId,v in pairs(stampLookup)do
local isBatch=isBatchMarkList[ubdId]or false
if isBatch then
local finishIndex=fabaoModel.getLianzhiInfoNowFinishIdx(ubdId)
if finishIndex then
temp[#temp+1]={4,sfId,ubdId,finishIndex,0}
end
else
temp[#temp+1]={3,sfId,ubdId}
end
end
return temp
end

function fabaoModel.clearLianzhiInfo(ubdId)
fabaoModel.stampLookup[ubdId]=nil
end

function fabaoModel.setLianzhiInfo(sfid,ubdId,fabaoid,mainid,stamp,isBatchCreate)
if fabaoModel.stampLookup==nil then fabaoModel.stampLookup={}end
if fabaoModel.isBatchMarkList==nil then fabaoModel.isBatchMarkList={}end

local info={
param_1=sfid,
param_2=ubdId,
param_3=fabaoid,
param_4=mainid,
param_5=stamp,
}

if fabaoModel.stampLookup[ubdId]==nil then fabaoModel.stampLookup[ubdId]={}end
fabaoModel.stampLookup[ubdId].sfId=sfid
fabaoModel.stampLookup[ubdId].ubdId=ubdId
if fabaoModel.stampLookup[ubdId].infoList==nil then fabaoModel.stampLookup[ubdId].infoList={}end
table.insert(fabaoModel.stampLookup[ubdId].infoList,info)
fabaoModel.isBatchMarkList[ubdId]=isBatchCreate or nil

fabaoModel.startLianzhiTimer(sfid,ubdId)
end


function fabaoModel.finishSectionalLianzhiInfoList(oldInfoList,sfId,ubdId,finishIdx,isOver)
fabaoModel.stopLianzhiTimer(ubdId)
local isStop=true
if not isOver then

local newInfoList={}
for idx,v in ipairs(oldInfoList)do
if idx>finishIdx then
table.insert(newInfoList,v)
end
end

if next(newInfoList)then
fabaoModel.setLianzhiInfoList(ubdId,newInfoList)
fabaoModel.startLianzhiTimer(sfId,ubdId)
isStop=false
end
end
return isStop
end

function fabaoModel.checkLianzhiIsBatch(ubdId)
if fabaoModel.isBatchMarkList==nil then fabaoModel.isBatchMarkList={}end
return fabaoModel.isBatchMarkList[ubdId]==true
end

function fabaoModel.getLianzhiLeftTimeByInfo(info)
if info==nil then return 0 end
local stamp=info.param_5
local left=stamp-timeHelper.getServerShortTime()
if left<0 then return 0 end
return left
end

function fabaoModel.isLianZhiFabao(ubdId)
local isBatchCreate=fabaoModel.checkLianzhiIsBatch(ubdId)
local infoIndex
if not isBatchCreate then
infoIndex=1
else
infoIndex=fabaoModel.getLianzhiInfoNowIdx(ubdId)
end

return fabaoModel.getLianzhiLeftTime(ubdId,infoIndex)>0
end

function fabaoModel.getLianzhiLeftTime(ubdId,infoIndex)
local stampLookup=fabaoModel.stampLookup
if stampLookup==nil then return 0 end

local info=fabaoModel.getLianzhiInfoByIdx(ubdId,infoIndex)
return fabaoModel.getLianzhiLeftTimeByInfo(info)
end

function fabaoModel.getFabaoLianzhiType(ubdId)
local infoIndex=1

local info=fabaoModel.getLianzhiInfoByIdx(ubdId,infoIndex)
if info==nil then return FABAO_LIANZHI_TYPE.eNomal end
local left=fabaoModel.getLianzhiLeftTimeByInfo(info)
if left>0 then return FABAO_LIANZHI_TYPE.eMake end
return FABAO_LIANZHI_TYPE.ePrize
end










function fabaoModel.isCanPrize(ubdId)
local infoIndex=1

local info=fabaoModel.getLianzhiInfoByIdx(ubdId,infoIndex)
if info then
return fabaoModel.getLianzhiLeftTime(ubdId,infoIndex)<=0
end
return false
end

function fabaoModel.getLianqiMainid(ubdId)
local infoIndex=1

local info=fabaoModel.getLianzhiInfoByIdx(ubdId,infoIndex)
if info then
return info.param_4
end
end

function fabaoModel.getLianqiMainidIconName(ubdId)
local infoIndex=1

local info=fabaoModel.getLianzhiInfoByIdx(ubdId,infoIndex)
if info then
local itemid=info.param_4
return iconHelper.getIconName(itemid)
end
end

function fabaoModel.startLianzhiTimer(sfId,ubdId)

fabaoModel.freshLianQiEffect(sfId,ubdId)
local nowIndex=fabaoModel.getLianzhiInfoNowIdx(ubdId)
local left=fabaoModel.getLianzhiLeftTime(ubdId,nowIndex)
if left>0 and fabaoModel.lianzhiTimer[ubdId]==nil then
fabaoModel.lianzhiTimer[ubdId]=timer.new()
local callback=function()
local left=fabaoModel.getLianzhiLeftTime(ubdId,nowIndex)
if left<=0 then
fabaoModel.stopLianzhiTimer(ubdId)

fabaoModel.freshLianQiEffect(sfId,ubdId)
reddotControl.on_fabao_create_changed(ubdId)

local newIndex=fabaoModel.getLianzhiInfoNowIdx(ubdId)

fabaoControl.freshLianzhiWindow('flyItemIcon',ubdId)
if newIndex~=nowIndex then

fabaoControl.freshLianzhiWindow('startLianzhi',ubdId)

return fabaoModel.startLianzhiTimer(sfId,ubdId)
end
end
end
callback()
fabaoModel.lianzhiTimer[ubdId]:start(_tick,callback)
end
end

function fabaoModel.freshLianQiEffect(sfId,ubdId)
local nowIndex=fabaoModel.getLianzhiInfoNowIdx(ubdId)
local left=fabaoModel.getLianzhiLeftTime(ubdId,nowIndex)
local bdData=zongmenModel:getBuildingData(ubdId)
if bdData then
if left>0 then

if mainControl:isInScene(eSceneType.eZongmen)then
buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eProduce)
end
else

if mainControl:isInScene(eSceneType.eZongmen)then
buildingEffectControl:stopEffect(bdData.entityId,buildEffectType.eProduce)
end
end
end
end

function fabaoModel.stopLianzhiTimer(ubdId)
if fabaoModel.lianzhiTimer[ubdId]then
fabaoModel.lianzhiTimer[ubdId]:cancel()
fabaoModel.lianzhiTimer[ubdId]=nil
end
end

function fabaoModel.stopAllLianzhiTimer()
if fabaoModel.lianzhiTimer==nil then return end
for ubdId,t in pairs(fabaoModel.lianzhiTimer)do
t:cancel()
end
fabaoModel.lianzhiTimer={}
end



function fabaoModel:initBagData()
local baglist=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag)
for i,v in ipairs(baglist)do
fabaoModel.addBenMingOwner(nil,v,false)
end
end

function fabaoModel.addBenMingOwner(dressdzguid,equip,isDress,init)
local itemid=equip.itemid
if not fabaoConfig.isBenMingFabao(equip.itemid)then return end


local owner,dzguid=benMingFaBaoHelper.hasOwnerByEquip(equip)
local handle=tostring(dzguid)
if fabaoModel.ownerLookup[handle]==nil then fabaoModel.ownerLookup[handle]={}end
local list=fabaoModel.ownerLookup[handle]
local itemguid=equip.itemguid
list[#list+1]=itemguid
fabaoModel.ownerItemLookup[tostring(itemguid)]=handle

if isDress then
fabaoModel.setAbsorbExp(dressdzguid,itemguid,true,init)
benMingFaBaoSheetReddot.addConfig(itemguid)
end
fabaoModel.changeOwner(itemguid,true)
end


function fabaoModel.removeBenMingOwner(dzguid)
local handle=tostring(dzguid)
local list=fabaoModel.ownerLookup[handle]
if list==nil or#list==0 then return end
for i,itemguid in ipairs(list)do
fabaoModel.ownerItemLookup[tostring(itemguid)]=nil
local fabao=fabaoModel.getFabao(itemguid)
if fabao~=nil then
fabaoModel.setAbsorbExp(dzguid,itemguid,false)
end
fabaoModel.changeOwner(itemguid,false)
end
fabaoModel.ownerLookup[handle]=nil
end


function fabaoModel.removeBenMingOwnerByItem(itemguid)
local handleItemguid=tostring(itemguid)
if fabaoModel.ownerItemLookup[handleItemguid]==nil then return end
local dzGuidStr=fabaoModel.ownerItemLookup[handleItemguid]
fabaoModel.ownerItemLookup[handleItemguid]=nil
local list=fabaoModel.ownerLookup[dzGuidStr]
for i,v in ipairs(list)do
if tostring(v)==handleItemguid then
table.remove(list,i)
break
end
end
fabaoModel.changeOwner(itemguid,false)
end


function fabaoModel.changeOwner(itemguid,flag)

end

function fabaoModel.setNowAbsorbExpStamp(itemguid)
fabaoModel.absorbExpstamp[tostring(itemguid)]=timeHelper.getServerShortTime()
end

function fabaoModel.clearAbsorbExpStamp(itemguid)
fabaoModel.absorbExpstamp[tostring(itemguid)]=nil
end

function fabaoModel.growExp(itemguid)
return fabaoModel.absorbExp[tostring(itemguid)]or 0
end


function fabaoModel.bananceExp(itemguid)
local exp,deleteFlag=fabaoModel.getGrowExp(itemguid)
fabaoModel.absorbExp[tostring(itemguid)]=math.ceil(exp)
return deleteFlag
end


function fabaoModel.clearBananceExp(itemguid)
fabaoModel.absorbExp[tostring(itemguid)]=0
fabaoModel.absorbExpstamp[tostring(itemguid)]=timeHelper.getServerShortTime()
end

function fabaoModel.getLastLingXingExp(itemguid)
local equip=fabaoModel.getFabao(itemguid)
if equip==nil then return 0 end
local nowExp=mathHelper.int64_to_number(equip.itemData.lingxingexp)
return nowExp
end

function fabaoModel.getLingXingExp(equip)
local itemguid=equip.itemguid
local nowExp=mathHelper.int64_to_number(equip.itemData.lingxingexp)
local exp=nowExp+fabaoModel.growExp(itemguid)
return exp
end


function fabaoModel.getGrowExp(itemguid)
if fabaoHelper.getFabao(itemguid)==nil then return 0,true end
local handle=tostring(itemguid)
local dzGuidStr=fabaoModel.ownerItemLookup[handle]
if dzGuidStr==nil then return 0 end
local netData=UIDiscipleModel:getDiscipleDataByStr(dzGuidStr)
if netData==nil then return 0 end
local lerp
if not worldController:checkNoticiateBlockOpen()then
lerp=0
else
local lasStamp=fabaoModel.absorbExpstamp[handle]
if lasStamp==nil then return 0 end
lerp=timeHelper.getServerShortTime()-lasStamp
end
if lerp<=0 then return 0 end

local baseGrow=cfgHelper.getglobal1('jingjieincr')

local ex_grow=UIDiscipleModel:getJJGrowRateByData(netData)
local absorb=fabaoModel.getAbsorbExpRateByStr(dzGuidStr)
local grow=baseGrow*(1+ex_grow)*absorb
grow=grow*lerp
local lxlv=fabaoModel.getLingXingLv(itemguid)
local max=fabaoConfig.getStoreLxExp(lxlv)
local maxexp=math.ceil(max)
local lastlxexp=fabaoModel.getLastLingXingExp(itemguid)
local nowexp=lastlxexp+grow
if nowexp>=maxexp then
nowexp=maxexp
fabaoModel.stopAbsorbExp(itemguid)
return 0,true
end
if grow<0 then grow=0 end
return math.ceil(grow)
end


function fabaoModel.getLeftAddExp(itemguid)
local lxlv=fabaoModel.getLingXingLv(itemguid)
local max=fabaoConfig.getStoreLxExp(lxlv)
local maxexp=math.floor(max)
local lastlxexp=fabaoModel.getLastLingXingExp(itemguid)
local growexp=fabaoModel.getGrowExp(itemguid)
local cur=lastlxexp+math.ceil(growexp)
local left=maxexp-cur
if left>0 then return left end
return 0
end



function fabaoModel.setAbsorbExp(dressdzguid,itemguid,flag,init)
local equip=fabaoModel.getFabao(itemguid)
if equip==nil then return end

if flag then

local lxlv=fabaoModel.getLingXingLvByEquip(equip)
local max=fabaoConfig.getStoreLxExp(lxlv)
local maxexp=math.floor(max)
local lastlxexp=fabaoModel.getLastLingXingExp(itemguid)
if fabaoConfig.isLxTuPoLv(lxlv)or lastlxexp>=maxexp then
flag=false
else

local isYunYang=fabaoModel.isYunYang(equip)
flag=flag and isYunYang or false


if dressdzguid==nil then
flag=false
else
local ownerguid=benMingFaBaoHelper.getOwner(itemguid)
if tostring(ownerguid)~=tostring(dressdzguid)then
flag=false
end
end
end
end


if flag then
fabaoModel.setNowAbsorbExpStamp(itemguid)
else
fabaoModel.bananceExp(itemguid)
fabaoModel.clearAbsorbExpStamp(itemguid)
end


if dressdzguid then
local oldRate=fabaoModel.absorbExpRate[tostring(dressdzguid)]
local newRate=flag and 0.5 or 0
fabaoModel.absorbExpRate[tostring(dressdzguid)]=newRate
if oldRate~=newRate and not init then
notifySystem:postNotify(notifyConfig.onFabaoAbsorbExpChange,itemguid,dressdzguid,newRate)
end
end


local list=fabaoModel.absorbExpFabaoList
if not flag then
for i,v in ipairs(list)do
if tostring(v)==tostring(itemguid)then
table.remove(list,i)
break
end
end
else
for _,v in ipairs(list)do
if tostring(v)==tostring(itemguid)then
return
end
end
list[#list+1]=itemguid
end
end

function fabaoModel.stopAbsorbExp(itemguid)
local dzguidStr=fabaoModel.getDiziguidStrByItemguid(itemguid)
local oldRate=fabaoModel.absorbExpRate[dzguidStr]
local newRate=0
fabaoModel.absorbExpRate[dzguidStr]=0
if oldRate~=newRate then
notifySystem:postNotify(notifyConfig.onFabaoAbsorbExpChange,itemguid,dzguidStr,newRate)
end


local list=fabaoModel.absorbExpFabaoList
for i,v in ipairs(list)do
if tostring(v)==tostring(itemguid)then
table.remove(list,i)
break
end
end
end

function fabaoModel.getAbsorbExpRateByStr(guidStr)
return fabaoModel.absorbExpRate[guidStr]or 0
end

function fabaoModel.getAbsorbExpRate(dzguid)
return fabaoModel.absorbExpRate[tostring(dzguid)]or 0
end



function fabaoModel.getFabaoBatchPlanListLocalData()
local planList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eFabao,'fabaoBatchPlanList',{})

for _,planData in ipairs(planList)do
local costItemList=planData.costItemList
if costItemList and next(costItemList)then
local tmpList={}
for indexStr,v in pairs(costItemList)do
local index=tonumber(indexStr)
tmpList[index]=v
end
planData.costItemList=tmpList
end

local fabaoItem=planData.fabaoItem
if fabaoItem and fabaoItem.itemguid then
local guid=tonumber(fabaoItem.itemguid)
planData.fabaoItem.itemguid=guid
end
end

return planList
end


function fabaoModel.setFabaoBatchPlanListLocalData(planList)

for _,planData in ipairs(planList)do
local costItemList=planData.costItemList
if costItemList and next(costItemList)then
local tmpList={}
for i,v in pairs(costItemList)do
local indexStr=tostring(i)
tmpList[indexStr]=v
end
planData.costItemList=tmpList
end

local fabaoItem=planData.fabaoItem
if fabaoItem and fabaoItem.itemguid then
local guidStr=tostring(fabaoItem.itemguid)
planData.fabaoItem.itemguid=guidStr
end

if planData.weightList then

planData.weightList=nil
end
end

userActorArraySetting.set(ACTOR_SETTING_TYPE.eFabao,'fabaoBatchPlanList',planList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eFabao)
end


function fabaoModel.clearAllFabaoBatchPlanListLocalData()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eFabao,'fabaoBatchPlanList',nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eFabao)
end

function fabaoModel.getAllFaBaoToBagEmot()
local temp={}
for k,fabao in pairs(fabaoModel.equips)do
temp[#temp+1]=fabao
end
return temp
end