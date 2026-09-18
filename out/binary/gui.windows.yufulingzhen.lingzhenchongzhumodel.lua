





LingZhenChongZhuModel={}

LingZhenChongZhuModel.chongZhuData={}

function LingZhenChongZhuModel:onEnterState(isReconnect)
self.chongZhuData={}
end

function LingZhenChongZhuModel:onLeaveState(isReconnect)
self.chongZhuData={}
end

function LingZhenChongZhuModel:saveChongZhuEquipByEquip(itemguid,randattrList,randAttrIdList2)
if not randattrList then
return
end


local mdata=lingzhenBagModel:getItem(itemguid)
if mdata then
mdata.itemData.randAttrIdList2=randattrList
mdata.itemData.randAttrIdList3=randAttrIdList2
end












end

function LingZhenChongZhuModel:saveChongZhuEquipEquiped(yufuGuid,kongIndex,randattrList,randAttrIdList2)
if not randattrList then
return
end

local zItem=UIYuFuLingZhenControl:getDiziLingData(yufuGuid)

if zItem then
if zItem.len>0 then
for ii,vv in ipairs(zItem.kongList)do
if kongIndex==vv.index then
vv.randAttrIdList2=randattrList
vv.randAttrIdList3=randAttrIdList2
break
end
end
end
end










end


function LingZhenChongZhuModel:getChongZhuEquipData(itemguid,yufuGuid,kongIndex)






local mdata=lingzhenBagModel:getItem(itemguid)
if(kongIndex==nil or kongIndex==0)and mdata then
local randAttrIdList2Map={}
if mdata.itemData.randAttrIdList3 then
for i,v in ipairs(mdata.itemData.randAttrIdList3)do
randAttrIdList2Map[v]=i
end
end
if not mdata.itemData.randAttrIdList2 then
return
end

return{randAttrIdList=mdata.itemData.randAttrIdList2,randAttrIdList2=randAttrIdList2Map}
else
local zItem=UIYuFuLingZhenControl:getDiziLingData(yufuGuid)

if zItem then
if zItem.len>0 then
for ii,vv in ipairs(zItem.kongList)do
if kongIndex==vv.index then
local randAttrIdList2Map={}
if vv.randAttrIdList3 then
for i,v in ipairs(vv.randAttrIdList3)do
randAttrIdList2Map[v]=i
end
end
if not vv.randAttrIdList2 then
return
end

return{randAttrIdList=vv.randAttrIdList2,randAttrIdList2=randAttrIdList2Map}
end
end
end
end
end
end

function LingZhenChongZhuModel:onChongZhuEquipByEquip(isEquip,equip,randAttrIdList,yufuGuid,kongIndex)

if equip then
if isEquip then

local list=randAttrIdList or{}
equip.randAttrIdList=list
equip.randAttrIdList2=nil
equip.randAttrIdList3=nil
else
if equip.itemData==nil then
equip.itemData={}
equip.itemData.itemtype=ITEM_MAIN_TYPE.eYFLingZhen
equip.itemData.len=0

end
local itemData=equip.itemData


local list=randAttrIdList or{}
itemData.randAttrIdList=list
itemData.randAttrIdList2=nil
itemData.randAttrIdList3=nil
equip.itemData=itemData
end
end

if isEquip then
local lzItem=UIYuFuLingZhenControl:getDiziLingData(yufuGuid)
if lzItem then
if lzItem.kongList then
for ii,vv in ipairs(lzItem.kongList)do
if kongIndex==vv.index then
local list=randAttrIdList or{}
vv.randAttrIdList=list
vv.randAttrIdList2=nil
vv.randAttrIdList3=nil
break
end
end
end
end
end
end

function LingZhenChongZhuModel:onChongZhuEquipByCancel(isEquip,equip,yufuGuid,kongIndex)
if equip then
if isEquip then

equip.randAttrIdList2=nil
equip.randAttrIdList3=nil
else
if equip.itemData==nil then
equip.itemData={}
equip.itemData.itemtype=ITEM_MAIN_TYPE.eYFLingZhen
equip.itemData.len=0

end
local itemData=equip.itemData


itemData.randAttrIdList2=nil
itemData.randAttrIdList3=nil
equip.itemData=itemData
end
end

if isEquip then
local lzItem=UIYuFuLingZhenControl:getDiziLingData(yufuGuid)
if lzItem then
if lzItem.kongList then
for ii,vv in ipairs(lzItem.kongList)do
if kongIndex==vv.index then
vv.randAttrIdList2=nil
vv.randAttrIdList3=nil
break
end
end
end
end
end
end




function LingZhenChongZhuModel:getjihuonum(lzData,yfId)
local max=0
local jihuonum=0
if lzData and yfId then
local yfcfg=itemsConfig.getConfig(yfId)
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,lzData.zhentuId)
local attrs=cfg.attr
max=#attrs
for i=1,max do
local data=attrs[i]
local typeLevelDatas=UIYuFuLingZhenControl:countTypeLevels(lzData)
local thismax=data[3]
local curr=typeLevelDatas[data[2]]or 0
local unlock=yfcfg.color>=data[1]
if unlock then
if curr>=thismax then
jihuonum=jihuonum+1
end
end
end
end
return jihuonum,max
end


function LingZhenChongZhuModel:getjihuoArr(lzData,yfId)
if lzData and yfId then
local cur,max=LingZhenChongZhuModel:getjihuonum(lzData,yfId)
if cur>=max then
local tzcfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,lzData.zhentuId)
return tzcfg.lzgmjhAttr
end
end
return false
end


function LingZhenChongZhuModel:getdengjiArr(lzData,yfId)
if lzData and yfId then
local cur,max=LingZhenChongZhuModel:getjihuonum(lzData,yfId)
if cur>=max then
local yfcfg=itemsConfig.getConfig(yfId)
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,lzData.zhentuId)
local gmdjdata=cfg.lzgmdjAttr
local alllevel=0
for i=1,5 do
local unlock=true
local check=cfg.unlock[i]
if check then
unlock=yfcfg.color>=check
end
local isUse=lzData~=nil and lzData.zhentuId==cfg.id
if unlock then
if isUse then
local kdata=lzData.kongList[i]
if kdata then
alllevel=alllevel+UIYuFuLingZhenControl:getItemLevel(kdata.itemId)
end
end
end
end
local nowidex=0
if gmdjdata and alllevel>0 then
for k,v in ipairs(gmdjdata)do
if alllevel>=v[1]then
nowidex=k
end
end
end
local attrs
if nowidex>0 and gmdjdata[nowidex]then
attrs=gmdjdata[nowidex][2]
end
return attrs
end
end
return false
end


function LingZhenChongZhuModel:getskilljihuoArr(diziguid)
local Allprecent=0
for idx=1,2 do
local fbData=UIFuLuFangModel:getFubaoData(diziguid,idx)
if fbData then
local yfGuid=fbData.itemguid
local yfId=fbData.itemid
local lzData=UIYuFuLingZhenControl:getLingZhenData(yfGuid)
local yfcfg=itemsConfig.getConfig(yfId)
if lzData and yfId then
local cur,max=LingZhenChongZhuModel:getjihuonum(lzData,yfId)
if cur>=max then
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,lzData.zhentuId)
local gmdjdata=cfg.lzgmdjAttr
local lzgmSkill=cfg.lzgmSkill
if gmdjdata and gmdjdata[#gmdjdata]then
local maxlevel=gmdjdata[#gmdjdata][1]or 0
local alllevel=0
for i=1,5 do
local unlock=true
local check=cfg.unlock[i]
if check then
unlock=yfcfg.color>=check
end
local isUse=lzData~=nil and lzData.zhentuId==cfg.id
if unlock then
if isUse then
local kdata=lzData.kongList[i]
if kdata then
alllevel=alllevel+UIYuFuLingZhenControl:getItemLevel(kdata.itemId)
end
end
end
end
if alllevel>=maxlevel and lzgmSkill[1]then
Allprecent=Allprecent+lzgmSkill[1][2]or 0
end
end
end
end
end
end
return Allprecent
end