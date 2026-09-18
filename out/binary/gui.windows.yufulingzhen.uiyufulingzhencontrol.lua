
UIYuFuLingZhenControl=gameState.addListener({})

function UIYuFuLingZhenControl:onAppStart()
socketManager:register_receiver(2,109,self.recv_2_109)
socketManager:register_receiver(2,110,self.recv_2_110)
socketManager:register_receiver(2,111,self.recv_2_111)
socketManager:register_receiver(2,112,self.recv_2_112)
socketManager:register_receiver(2,113,self.recv_2_113)
socketManager:register_receiver(2,114,self.recv_2_114)
socketManager:register_receiver(2,115,self.recv_2_115)
socketManager:register_receiver(2,116,self.recv_2_116)
socketManager:register_receiver(2,117,self.recv_2_117)
socketManager:register_receiver(2,118,self.recv_2_118)
socketManager:register_receiver(2,119,self.recv_2_119)
socketManager:register_receiver(2,146,self.recv_2_146)
socketManager:register_receiver(2,104,self.recv_2_104)

socketManager:register_receiver(2,108,UIYuFuLingZhenControl.recv_2_108)
socketManager:register_receiver(2,107,UIYuFuLingZhenControl.recv_2_107)
socketManager:register_receiver(2,105,UIYuFuLingZhenControl.recv_2_105)



self.zyIconNames={
[1]='icon_yufulingzhentp_1',
[2]='icon_yufulingzhentp_2',
[3]='icon_yufulingzhentp_3',
[4]='icon_yufulingzhentp_4',
[5]='icon_yufulingzhentp_5',
}

self.lzIconNames={
[1]='icon_yufulingzhenxtp_1',
[2]='icon_yufulingzhenxtp_2',
[3]='icon_yufulingzhenxtp_3',
[4]='icon_yufulingzhenxtp_4',
[5]='icon_yufulingzhenxtp_5',
}

self.pzIconNames={
[1]='image_yflzpjk_1',
[2]='image_yflzpjk_2',
[3]='image_yflzpjk_3',
[4]='image_yflzpjk_4',
[5]='image_yflzpjk_5',
[6]='image_yflzpjk_6',
}

self.imageAB='ui/windows/yufulingzhen/sharedtextures/{0}.ab'
end

function UIYuFuLingZhenControl:onEnterState(isReconnect)
self.data={}
self.lingZhenEquipedNum=0
self.lingZhenEquipedLevelNum={}
self.data.client={}





self.data.researchedInfo={}
self.lingZhenEquipedLevelNum={}
self.data.lingZhenData={}
self.data.lingZhenKongData={}
self.data.prefix={'庚金','震木','坎水','离火','坤土','五行'}

LingZhenChongZhuModel:onEnterState(isReconnect)









if isReconnect then
return
end
notifySystem:listenNotify(notifyConfig.onDiscipleSixAttrChange,self.onDiscipleSixAttrChange)
notifySystem:listenNotify(notifyConfig.onNewMonth5am,self.onNewMonth5am)
end

function UIYuFuLingZhenControl:onLeaveState(isReconnect)
self.lingZhenEquipedNum=0
self.lingZhenEquipedLevelNum={}
if self.data and self.data.client and next(self.data.client)then
for k,v in pairs(self.data.client)do
taskController:unlistenTaskCount(v[2],v[3],v[1])
end
end

LingZhenChongZhuModel:onLeaveState(isReconnect)

end
































function UIYuFuLingZhenControl:getImageName(zttype,isActive)
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,zttype)
local name=isActive and cfg.image[1]or cfg.image[2]
local abName=FMT.fmt(self.imageAB,string.lower(name))
return abName,name
end

function UIYuFuLingZhenControl:getSpine(zttype)
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,zttype)
return cfg.spine
end

function UIYuFuLingZhenControl:getZYIconName(lztype)
return self.zyIconNames[lztype]
end

function UIYuFuLingZhenControl:getLZIconName(cfg)




return iconHelper.getIconName(cfg.id)
end

function UIYuFuLingZhenControl:getPZIconName(color)
return self.pzIconNames[color]
end

function UIYuFuLingZhenControl:getPrefixName(lztype)
return self.data.prefix[lztype]
end

function UIYuFuLingZhenControl:getItemColorbyItemId(itemId)
local cfg=itemsConfig.getConfig(itemId)








return cfg.color
end

function UIYuFuLingZhenControl:getItemColor(item)
return self:getItemColorbyItemId(item.itemid)
end

function UIYuFuLingZhenControl:getItemLevel(itemid)
local cfg=itemsConfig.getConfig(itemid)
return cfg.level
end

function UIYuFuLingZhenControl:getItemColorById(itemid,itemguid)
local data=lingzhenBagModel:getItem(itemguid)
if data then
return self:getItemColor(data)
else
return self:getItemColorbyItemId(itemid)
end
end

function UIYuFuLingZhenControl:getLingZhenColorName(data)
local cfg=itemsConfig.getConfig(data.itemid)
local color=self:getItemColor(data)
local name=FMT.cfmt(color,cfg.name)
return name
end


function UIYuFuLingZhenControl:getItemLevelGroup(itemid)
local itemCfg=itemsConfig.getConfig(itemid)

local cfg=cfg_items_lingzhen_type_lookup_get(itemCfg.type1)
return cfg[itemCfg.type2]
end

function UIYuFuLingZhenControl:getItemIdByLevel(otherId,level)
local group=self:getItemLevelGroup(otherId)
return group and group[level]
end

function UIYuFuLingZhenControl:getItemLevelDescList(levelAttr)
local strList={}
local baseCfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"levelAttrDesc")
local percent,wuxing
if levelAttr[1]==1 then
local attrList=levelAttr[2]
for i,v in ipairs(attrList)do
local name,str=equipsHelper.getAttr(v[1],v[2])
table.insert(strList,FMT.fmt('{0}：{1}',name,str))
end
else
local str=baseCfg[levelAttr[1]]
percent=levelAttr[1]==2 and 100 or 1
if str then
local attrList=levelAttr[2]
for i,v in ipairs(attrList)do
if v[1]==0 then
str=str[2]
table.insert(strList,FMT.fmt(str,percent*v[2]))
else
str=str[1]
wuxing=self.data.prefix[v[1]]
table.insert(strList,FMT.fmt(str,percent*v[2],wuxing))
end
end

end
end

return strList
end

function UIYuFuLingZhenControl:getDzAttrDesc(attrCfg,color)
local diziAttrs=attrCfg.dzAttrDesc
if diziAttrs then
local val=attrCfg.attrDescVal
if val then
if color then
return FMT.fmt(FMT.cfmt2(color,diziAttrs),FMT.cfmt(FONT_COLOR.eNomalBlackColor,unpack(val)))
else
return FMT.fmt(diziAttrs,unpack(val))
end
else
return diziAttrs
end
end
end

function UIYuFuLingZhenControl:getAttrs(itemid,itemguid,yfguid,kongIndex)
local cfg=itemsConfig.getConfig(itemid)

local colorAttr=cfg.colorAttr
local levelAttr=cfg.levelAttr
local list={}
local colorAddRate_xmt=wanLingTaModel:getWanLingTaLingZhenBaseSpeAttrsLookup()
if colorAttr then
for i,v in ipairs(colorAttr)do
local val=list[v[1]]or 0

if equipsConfig.isModAttr(v[1])then
val=val+v[2]
list[v[1]]=val
else
local ex_rate=1
local addrate_xmt=(colorAddRate_xmt[v[1]]or 0)/100
ex_rate=ex_rate+addrate_xmt
list[v[1]]=val+math.floor(v[2]*ex_rate+0.00001)
end
end
end
if levelAttr then
for _,v in ipairs(levelAttr)do
if v[1]==1 then
for i,vv in ipairs(v[2])do
local val=list[vv[1]]or 0
val=val+vv[2]
list[vv[1]]=val
end
end
end
end

local baseAttr=cfg.baseAttr
if baseAttr then
for i,attr in ipairs(baseAttr)do
if attr[1]==2 then
for iii,vvv in ipairs(attr[2])do
local dv=list[vvv[1]]or 0
dv=dv+vvv[2]
list[vvv[1]]=dv
end
end
end
end

local rlist=attrListHelper.transformToList(list,colorAttr)

local dlist={}
if itemguid then
local level=UIYuFuLingZhenControl:getItemLevel(itemid)
local itemData=lingzhenBagModel:getItem(itemguid)
if not itemData then
itemData=UIYuFuLingZhenControl:getXianQianData(yfguid,kongIndex)
end
local randAttrIdList=itemData.itemData.randAttrIdList
if randAttrIdList then
for i=1,#randAttrIdList do
local attrId=randAttrIdList[i]

local attrCfg=cfgHelper.get1(cfg_yufuzhenturandattrconfig_get,attrId)
local attrs=attrCfg.attr or{}
local diziAttrs=UIYuFuLingZhenControl:getDzAttrDesc(attrCfg)
local unlockLv=attrCfg.xcLevel or 1
if attrs and level>=unlockLv then
for _,v in ipairs(attrs)do
if v[1]==1 then
for i,vv in ipairs(v[2])do
local val=list[vv[1]]or 0
val=val+vv[2]
list[vv[1]]=val
end
end
end
end

if diziAttrs and level>=unlockLv then
table.insert(dlist,diziAttrs)
end
end
end
end

return rlist,dlist
end

function UIYuFuLingZhenControl:countAddLevelData(data)
local addLevelData={}
for k,v in pairs(data.kongList)do
local cfg=itemsConfig.getConfig(v.itemId)
if cfg.levelAttr then
for ii,vv in ipairs(cfg.levelAttr)do
for iii,vvv in ipairs(vv[2])do
local dv=addLevelData[vvv[1]]or 0
dv=dv+vvv[2]
addLevelData[vvv[1]]=dv
end
end

end
end
return addLevelData
end

function UIYuFuLingZhenControl:countTotalLevel(data)
local datas=self:countTypeLevels(data)
local level=0
for k,v in pairs(datas)do
level=level+v
end
return level
end

function UIYuFuLingZhenControl:countTypeLevels(data)
local addLevelData=self:countAddLevelData(data)
local list={}
for k,v in pairs(data.kongList)do
local cfg=itemsConfig.getConfig(v.itemId)
local ztype=cfg.type1
local level=list[ztype]or 0
level=level+UIYuFuLingZhenControl:getItemLevel(v.itemId)+(addLevelData[ztype]or 0)
list[ztype]=level
end
return list
end


function UIYuFuLingZhenControl:isSysOpen()
return systemModel.isOpen(SYSTEM_DEFINE.eYuFuLingZhen)
end

function UIYuFuLingZhenControl:showMainWin(args)
UIManager:showWindow('UIYuFuLingZhenWin',args)
end

function UIYuFuLingZhenControl:showCombineWin()
UIManager:showWindow('UIYFLZCombineWin')
end

function UIYuFuLingZhenControl:checkZhuanHuanLZReddot()
if systemModel.isOpen(SYSTEM_DEFINE.eLingZhenConvert)then
local zhuanHuanLZ_Reddot=userActorSetting.get('zhuanHuanLZ',false)
return not zhuanHuanLZ_Reddot
end
return false
end




function UIYuFuLingZhenControl:setData(len2,arr2,len3,arr3,len4,arr4,convertNum)
local lingZhenData={}


























local unlockZhenTu={}
if len2>0 then
for i,v in ipairs(arr2)do
unlockZhenTu[v]=true
end
end
self.data.unlockZhenTu=unlockZhenTu

local researchedData={}
local researchedNum=0
if len3>0 then
for i,v in ipairs(arr3)do
researchedData[v]=true
researchedNum=researchedNum+1
end
end
self.data.researchedData=researchedData
self.data.researchedNum=researchedNum

local researchedInfo={}

if len4>0 then
for i,v in ipairs(arr4)do

researchedInfo[v.taskType]=researchedInfo[v.taskType]or{}
researchedInfo[v.taskType][v.taskParam]={}
researchedInfo[v.taskType][v.taskParam][v.zhentuId]=v.finishNum
end
end

self.data.researchedInfo=researchedInfo
















self.data.convertNum=convertNum
end

function UIYuFuLingZhenControl:refreshTaskProgress(list)
for i,v in ipairs(list)do
local otherArgs=v.otherArgs

end
end

function UIYuFuLingZhenControl:isZhenTuResearched(ztId)
return self.data.researchedData[ztId]==true
end

function UIYuFuLingZhenControl:setZhenTuResearched(ztId)
if self.data.researchedData==nil then return end
if self.data.researchedData[ztId]then return end
self.data.researchedNum=(self.data.researchedNum or 0)+1
self.data.researchedData[ztId]=true
end

function UIYuFuLingZhenControl:getZhenTuResearchedNum()
return self.data.researchedNum or 0
end

function UIYuFuLingZhenControl:setResearchedInfo(taskType,taskParam,finishNum,zhentuId)
self.data.researchedInfo[taskType]=self.data.researchedInfo[taskType]or{}
self.data.researchedInfo[taskType][taskParam]=self.data.researchedInfo[taskType][taskParam]or{}
self.data.researchedInfo[taskType][taskParam][zhentuId]=finishNum
end

function UIYuFuLingZhenControl:getResearchedInfo(rtype,taskParam,zhentuId)
self.data.researchedInfo[rtype]=self.data.researchedInfo[rtype]or{}
self.data.researchedInfo[rtype][taskParam]=self.data.researchedInfo[rtype][taskParam]or{}

if self.data.researchedInfo[rtype][taskParam][zhentuId]then
return self.data.researchedInfo[rtype][taskParam][zhentuId]
else
if self:GetTask(zhentuId)then
return self:GetTask(zhentuId)
end

end
end

function UIYuFuLingZhenControl:setConvertNum(convertNum)
self.data.convertNum=convertNum
end

function UIYuFuLingZhenControl:getConvertNum()
return self.data.convertNum
end

function UIYuFuLingZhenControl:GetTask(ztId)
local cfg=cfgHelper.get(cfg_yufuzhentuconfig_get,ztId)
local rid=cfg.unlockList[1]
if taskModel:checkClientCheckTask(rid[1])and not self.data.client[ztId]then
local funcArgs={taskId=ztId}

local listenGuid=taskController:listenTaskCount(rid[1],rid[2],funcArgs,rid[3])
self.data.client[ztId]={listenGuid,rid[1],rid[2]}
end

if self.data.client[ztId]then
return taskController:getTaskCount(rid[1],rid[2])
end
return false
end

function UIYuFuLingZhenControl:checkZhenTyReseach(ztId)
if UIYuFuLingZhenControl:isZhenTuResearched(ztId)then
return false
end

local cfg=cfgHelper.get(cfg_yufuzhentuconfig_get,ztId)
local rid=cfg.unlockList[1]


local data=UIYuFuLingZhenControl:getResearchedInfo(rid[1],rid[2],ztId)
local max=rid[3]

local curr=data or 0

if curr>=max then
local costs=cfg.yjItems
if costs then
for i,v in ipairs(costs)do
local have=itemsModel.getCount(v[1])
if have<=v[2]then
return false
end
end
end
end

return curr>=max
end

function UIYuFuLingZhenControl:checkAllZhenTyReseach()
local cfgs=cfg_yufuzhentuconfig()
for i,v in pairs(cfgs)do
if self:checkZhenTyReseach(v.id)then
return true
end
end
return false
end

function UIYuFuLingZhenControl:resetXiangQian(dzId,yfId,item)
local data=UIYuFuLingZhenControl:getDiziLingData(yfId)
local list={}

if data.kongList then
for i,v in pairs(data.kongList)do


UIYuFuLingZhenControl:calcLingZhenEquipedNum(-1)
local lv=self:getItemLevel(v.itemId)
UIYuFuLingZhenControl:calcLingZhenEquipedLevelNum(lv,-1)
end
end

if item.len>0 then
for ii,vv in ipairs(item.kongList)do
list[vv.index]=vv

LingZhenChongZhuModel:saveChongZhuEquipByEquip(vv.itemGuid,vv.randAttrIdList2,vv.randAttrIdList3)

UIYuFuLingZhenControl:calcLingZhenEquipedNum(1)
local lv=self:getItemLevel(vv.itemId)
UIYuFuLingZhenControl:calcLingZhenEquipedLevelNum(lv,1)
end
end
data.len=item.len
data.kongList=item.kongList
data.dzGuid=item.dzGuid
end

function UIYuFuLingZhenControl:getDiziLingData(guid)
local itemdata=fubaoBagModel:getItem(guid)
if itemdata then
return itemdata.itemData and itemdata.itemData.lzItem
else
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(guid)
if dzId then
local pos=UIFuLuFangModel:getEquipPos(dzId,guid)
if pos then
local itemdata=UIFuLuFangModel:getFubaoData(dzId,pos)
if itemdata then
return itemdata.itemData and itemdata.itemData.lzItem
end
end
end
end
end


function UIYuFuLingZhenControl:getLingZhenData(guid)


local zItem=UIYuFuLingZhenControl:getDiziLingData(guid)
if zItem and zItem.zhentuId~=0 then
local list={}
if zItem.len>0 then
for ii,vv in ipairs(zItem.kongList)do
if vv.itemId>0 then
list[vv.index]=vv
end
end
end
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(guid)
return{dzGuid=dzId,yufuGuid=guid,zhentuId=zItem.zhentuId,len=zItem.len,kongList=list}
else

local equip=equipsHelper.getEquip(guid)
if equip then
if equip.itemData and equip.itemData.lzItem then
local zItem=equip.itemData.lzItem
if zItem and zItem.zhentuId~=0 then
local list={}
if zItem.len>0 then
for ii,vv in ipairs(zItem.kongList)do
if vv.itemId>0 then
list[vv.index]=vv
end
end
end
return{yufuGuid=guid,zhentuId=zItem.zhentuId,len=zItem.len,kongList=list,other=true}
end
end
end
end
end

function UIYuFuLingZhenControl:addLingZhenKongData(guid,data)
self.data.lingZhenKongData[tostring(guid)]=data
end

function UIYuFuLingZhenControl:setLingZhenKongLevel(guid,itemid)
if self.data.lingZhenKongData[tostring(guid)]then
self.data.lingZhenKongData[tostring(guid)].itemid=itemid
end

local dzguid=UIFuLuFangModel:getDzGuidByItemGuid(guid)
equipsModel.setAllEquipedAttrsDirty(dzguid)
end

function UIYuFuLingZhenControl:removeLingZhenKongData(guid)
self.data.lingZhenKongData[tostring(guid)]=nil
end

function UIYuFuLingZhenControl:getLingZhenKongData(guid)
return self.data.lingZhenKongData[tostring(guid)]
end

function UIYuFuLingZhenControl:getXianQianData(guid,index)
local lzdata=self:getLingZhenData(guid)
if lzdata then
return lzdata.kongList[index]
end
end

function UIYuFuLingZhenControl:calcLingZhenEquipedNum(changeNum)
self.lingZhenEquipedNum=(self.lingZhenEquipedNum or 0)+changeNum
end

function UIYuFuLingZhenControl:calcLingZhenEquipedByKongList(kongList,add)
for i,v in pairs(kongList)do
UIYuFuLingZhenControl:calcLingZhenEquipedNum(add and 1 or-1)
local lv=self:getItemLevel(v.itemId)
UIYuFuLingZhenControl:calcLingZhenEquipedLevelNum(lv,add and 1 or-1)
end
end

function UIYuFuLingZhenControl:getLingZhenEquipedNum()
return self.lingZhenEquipedNum or 0
end

function UIYuFuLingZhenControl:calcLingZhenEquipedLevelNum(level,changeNum)
self.lingZhenEquipedLevelNum[level]=(self.lingZhenEquipedLevelNum[level]or 0)+changeNum
end

function UIYuFuLingZhenControl:getLingZhenEquipedLevelNum(level)
local num=0
for lv,count in pairs(self.lingZhenEquipedLevelNum)do
if lv>=level then
num=num+count
end
end
return num
end

function UIYuFuLingZhenControl:getItem(itemGuid,yfguid,kongIndex)
local mdata=lingzhenBagModel:getItem(itemGuid)
if not mdata then
mdata=UIYuFuLingZhenControl:getXianQianData(yfguid,kongIndex)
end
return mdata
end

function UIYuFuLingZhenControl:getItemLock(itemGuid,yfguid,kongIndex)
local mdata=lingzhenBagModel:getItem(itemGuid)
if mdata then
return mdata.itemData.lockFlag==1
else
local zItem=UIYuFuLingZhenControl:getDiziLingData(yfguid)
if zItem then
if zItem.len>0 then
for ii,vv in ipairs(zItem.kongList)do
if kongIndex==vv.index then
return vv.lockFlag==1
end
end
end
end
end
end

function UIYuFuLingZhenControl:setItemLock(itemGuid,yfguid,kongIndex,lockFlag)
local mdata=lingzhenBagModel:getItem(itemGuid)
if mdata then
mdata.itemData.lockFlag=lockFlag
else
local zItem=UIYuFuLingZhenControl:getDiziLingData(yfguid)
if zItem then
if zItem.len>0 then
for ii,vv in ipairs(zItem.kongList)do
if kongIndex==vv.index then
vv.lockFlag=lockFlag
break
end
end
end
end
end
end

function UIYuFuLingZhenControl:activeZhenTU(id)
self.data.unlockZhenTu[id]=true
end

function UIYuFuLingZhenControl:isZhenTuActive(id)
return self.data.unlockZhenTu[id]~=nil
end

function UIYuFuLingZhenControl:isZhenTuCanActive(id)
if self:isZhenTuActive(id)then
return false
end
if not self:isZhenTuResearched(id)then
return false
end
local cfg=cfgHelper.get(cfg_yufuzhentuconfig_get,id)
if cfg.jhItems then
for i,v in ipairs(cfg.jhItems)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
return false
end
end
end
return true
end

function UIYuFuLingZhenControl:iszhenTuCanActiveByYuFu(yuFuId)
local zhentuList=itemsConfig.getConfig(yuFuId).zhentuList
if not zhentuList then return end
for i,v in ipairs(zhentuList)do
if self:isZhenTuCanActive(v)then
return true
end
end

end

function UIYuFuLingZhenControl:changeZhenTu(dzId,yfId,ztId)
local data=UIYuFuLingZhenControl:getDiziLingData(yfId)
if data then
data.zhentuId=ztId
end
end


function UIYuFuLingZhenControl:countAllAttr(yfId,yfGuid,ohterData,color)
local data
if ohterData then
data=ohterData
else
data=UIYuFuLingZhenControl:getLingZhenData(yfGuid)
end

local diziAttrList={}

local baseDatas={}

local colorAddRate_xmt=wanLingTaModel:getWanLingTaLingZhenBaseSpeAttrsLookup()
for k,v in pairs(data.kongList)do
local cfg=itemsConfig.getConfig(v.itemId)
local colorAttr=cfg.colorAttr

if colorAttr then
for kk,vv in pairs(colorAttr)do
local dv=baseDatas[vv[1]]or 0
if equipsConfig.isModAttr(vv[1])then
dv=dv+vv[2]
baseDatas[vv[1]]=dv
else
local ex_rate=1
local addrate_xmt=(colorAddRate_xmt[vv[1]]or 0)/100
ex_rate=ex_rate+addrate_xmt
baseDatas[vv[1]]=dv+math.floor(vv[2]*ex_rate+0.00001)
end
end
end


if v.randAttrIdList then
local level=self:getItemLevel(v.itemId)
for i,attrId in ipairs(v.randAttrIdList)do

local attrCfg=cfgHelper.get1(cfg_yufuzhenturandattrconfig_get,attrId)
local attrs=attrCfg.attr or{}
local data=attrs
local unlockLv=attrCfg.xcLevel or 1
if level>=unlockLv then
if data then
for ii,attr in ipairs(data)do
if attr[1]==1 then
for _,a in ipairs(attr[2])do
local dv=baseDatas[a[1]]or 0
dv=dv+a[2]
baseDatas[a[1]]=dv
end
end
end
end
local dzAttr=UIYuFuLingZhenControl:getDzAttrDesc(attrCfg,color)
if dzAttr then
table.insert(diziAttrList,dzAttr)
end
end
end
end


local baseAttr=cfg.baseAttr
if baseAttr then
for i,attr in ipairs(baseAttr)do
if attr[1]==2 then
for iii,vvv in ipairs(attr[2])do
local dv=baseDatas[vvv[1]]or 0
dv=dv+vvv[2]
baseDatas[vvv[1]]=dv
end
end
end
end










end


local attrDatas={}
for k,v in pairs(baseDatas)do
attrDatas[k]=v
local attrConfig=equipsConfig.getAttributesconfig(k)

local flag=attrConfig.flag
if flag==3 then
attrDatas[k]=mathHelper.decimal(attrDatas[k],3)
else
attrDatas[k]=math.floor(attrDatas[k])
end

end

return attrDatas,diziAttrList
end


function UIYuFuLingZhenControl:countTotalAttr(yfGuid)
local data=UIYuFuLingZhenControl:getLingZhenData(yfGuid)
if not data then return{}end
local yfId=itemsModel.getItem(yfGuid).itemid
local dzGuid=data.dzGuid

local addLevelData=UIYuFuLingZhenControl:countAddLevelData(data)
local levelData=UIYuFuLingZhenControl:countTypeLevels(data)
local percentList={}


local allPercent=0
for k,v in pairs(data.kongList)do
local cfg=itemsConfig.getConfig(v.itemId)

local baseAttr=cfg.baseAttr
if baseAttr then
for i,attr in ipairs(baseAttr)do
if attr[1]==1 then
if attr[2]==0 then
allPercent=allPercent+attr[3]
else
local dv=percentList[attr[2]]or 0
dv=dv+attr[3]
percentList[attr[2]]=dv
end

end
end
end
end


for k,v in pairs(data.kongList)do
local cfg=itemsConfig.getConfig(v.itemId)
local sType=cfg.type1
if sType==6 then
if v.randAttrIdList then
local level=self:getItemLevel(v.itemId)
for i,attrId in ipairs(v.randAttrIdList)do
local attrCfg=cfgHelper.get1(cfg_yufuzhenturandattrconfig_get,attrId)
local attrs=attrCfg.attr or{}
local data=attrs
local unlockLv=attrCfg.xcLevel or 1
if level>=unlockLv then
if data then
for ii,attr in ipairs(data)do
if attr[1]==2 then
for _,a in ipairs(attr[2])do
local dv=percentList[a[1]]or 0
dv=dv+a[2]
percentList[a[1]]=dv
end
end
end
end
end
end
end
end
end


local allAttr=0
local attrList={}
local yfcfg=itemsConfig.getConfig(yfId)
local tzcfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,data.zhentuId)
for i,v in ipairs(tzcfg.attr)do
local ttype=v[2]




local level=(levelData[ttype]or 0)+(addLevelData[ttype]or 0)

if level>=v[3]then
for i,vv in ipairs(v[4])do
local stype=vv[1]
if stype==1 then
if v[4][2]==0 then
allPercent=allPercent+vv[3]
else
local dv=percentList[vv[2]]or 0
dv=dv+vv[3]
percentList[vv[2]]=dv
end

elseif stype==2 then
for ii,vvv in ipairs(vv[2])do
local dv=attrList[vvv[1]]or 0
dv=dv+vvv[2]
attrList[vvv[1]]=dv
end
end
end
end


end

local isjhzt=LingZhenChongZhuModel:getjihuoArr(data,yfId)
if isjhzt then
for k,v in pairs(isjhzt)do
if k==0 then
allPercent=allPercent+v
else
local dv=percentList[k]or 0
dv=dv+v
percentList[k]=dv
end
end
end



local baseDatas={}

local colorAddRate_xmt=wanLingTaModel:getWanLingTaLingZhenBaseSpeAttrsLookup()
for k,v in pairs(data.kongList)do
local cfg=itemsConfig.getConfig(v.itemId)
local stype=cfg.type1
local colorAttr=cfg.colorAttr
if colorAttr then
for kk,vv in pairs(colorAttr)do
local dv=baseDatas[vv[1]]or 0
if equipsConfig.isModAttr(vv[1])then
dv=dv+vv[2]
else
local addrate_xmt=(colorAddRate_xmt[vv[1]]or 0)/100
dv=mathHelper.floor((dv+vv[2]+vv[2]*allPercent+vv[2]*(percentList[stype]or 0)+vv[2]*addrate_xmt)*10000)/10000
end
baseDatas[vv[1]]=dv
end
end

if v.randAttrIdList then
local haveDZ=UIDiscipleModel:getDiscipleData(dzGuid)~=nil
local level=self:getItemLevel(v.itemId)
for i,attrId in ipairs(v.randAttrIdList)do

local attrCfg=cfgHelper.get1(cfg_yufuzhenturandattrconfig_get,attrId)
local attrs=attrCfg.attr or{}
local data=attrs
local dzAttr=attrCfg.dzAttr
local unlockLv=attrCfg.xcLevel or 1
if level>=unlockLv then
if data then
for ii,attr in ipairs(data)do
if attr[1]==1 then
for _,a in ipairs(attr[2])do
local dv=baseDatas[a[1]]or 0
if equipsConfig.isModAttr(a[1])then
dv=dv+a[2]
else
dv=mathHelper.floor((dv+a[2]+a[2]*allPercent+a[2]*(percentList[stype]or 0))*10000)/10000
end
baseDatas[a[1]]=dv
end
end
end
end

if dzAttr and haveDZ then
local dzAttrVal=UIDiscipleModel:getDiscipleBaseAttr(dzGuid,dzAttr[1])
for ii,attr in ipairs(dzAttr[3])do
local dv=baseDatas[attr[1]]or 0
local add=mathHelper.floor(dzAttrVal/dzAttr[2])*attr[2]
dv=dv+(equipsConfig.isModAttr(attr[1])and(mathHelper.floor(add*100000)/100000)or add)
baseDatas[attr[1]]=dv
end
end

end
end
end

local baseAttr=cfg.baseAttr
if baseAttr then
for i,attr in ipairs(baseAttr)do
if attr[1]==2 then
for iii,vvv in ipairs(attr[2])do
local dv=baseDatas[vvv[1]]or 0
if equipsConfig.isModAttr(vvv[1])then
dv=dv+vvv[2]
else
dv=mathHelper.floor((dv+vvv[2]+vvv[2]*allPercent+vvv[2]*(percentList[stype]or 0))*10000)/10000
end
baseDatas[vvv[1]]=dv
end
end
end
end
end


local isdjzt=LingZhenChongZhuModel:getdengjiArr(data,yfId)
if isdjzt then
for iii,vvv in ipairs(isdjzt)do
local dv=baseDatas[vvv[1]]or 0
dv=dv+vvv[2]
baseDatas[vvv[1]]=dv
end
end



local attrDatas={}
for k,v in pairs(baseDatas)do
attrDatas[k]=v+(attrDatas[k]or 0)
end
for k,v in pairs(attrList)do
attrDatas[k]=v+(attrDatas[k]or 0)
end
return attrDatas
end


function UIYuFuLingZhenControl:getLZCombineItemList_crossLevel(itemId)
if self.data.lingZhenCombineItemList and self.data.lingZhenCombineItemList[itemId]then
return self.data.lingZhenCombineItemList[itemId]
end

if not self.data.lingZhenCombineItemList then
self.data.lingZhenCombineItemList={}
end

local cfg=itemsConfig.getConfig(itemId)
local nowLevel=cfg.level
local type1=cfg.type1
local isWuXing=type1==6
local combineItemList={}
if isWuXing then

return nil
else

local hcdata=cfgHelper.get2(cfg_yufulingzhenbaseconfig_get,1,'hcItems')
for lv=nowLevel,1,-1 do
local itemid=UIYuFuLingZhenControl:getItemIdByLevel(itemId,lv)
local need=hcdata[lv]
local weight=need[1]
local hcCostCount=need[2]
combineItemList[#combineItemList+1]={
level=lv,
itemId=itemid,
weight=weight,
cost=hcCostCount,
}
end
end

self.data.lingZhenCombineItemList[itemId]=combineItemList
return self.data.lingZhenCombineItemList[itemId]
end


function UIYuFuLingZhenControl:getLZMaxCombineCntAndMaxSelectNum(itemId)
local cfg=itemsConfig.getConfig(itemId)
local isWuXing=cfg.type1==6
local maxCombineCnt=0
local maxSelectNum=0
if isWuXing then

maxCombineCnt=1
maxSelectNum=1
return maxCombineCnt,maxSelectNum
end

local combineItemList=self:getLZCombineItemList_crossLevel(itemId)
local level=cfg.level
local hcdata=cfgHelper.get2(cfg_yufulingzhenbaseconfig_get,1,'hcItems')
local need=hcdata[level+1]
local singleNeedWeight=need[1]
local targetCostCount=need[2]
local costType=eMoneyType.mtZhenShi
local hasItemCountList={}
local useItemCountList={}
local addItemFunc=function(itemList,itemId,itemCount)
if itemList[itemId]then
itemList[itemId]=itemList[itemId]+itemCount
else
itemList[itemId]=itemCount
end
end
local costHasCount=hasItemCountList[costType]or itemsModel.getCount(costType)
hasItemCountList[costType]=costHasCount

local tmpItemSelectList={}
for _,v in ipairs(combineItemList)do
local levelItemId=v.itemId
local hasCount=hasItemCountList[levelItemId]or itemsModel.getCount(levelItemId)
hasItemCountList[levelItemId]=hasCount
if hasCount>0 then
local weight=v.weight
local usedCnt=useItemCountList[levelItemId]or 0
local needWeight=singleNeedWeight
local addCombineCnt_item=0
local addCombineCnt=0
if tmpItemSelectList and next(tmpItemSelectList)then
local selectWeight=0
for itemId,data in pairs(tmpItemSelectList)do
selectWeight=selectWeight+data.weight
end
needWeight=singleNeedWeight-selectWeight
addCombineCnt_item=math.ceil(needWeight/weight)
local validCnt=hasCount-usedCnt
addCombineCnt_item=math.min(addCombineCnt_item,validCnt)
if singleNeedWeight-selectWeight-weight*addCombineCnt_item<=0 then
local allCostCount=0
for itemId,data in pairs(tmpItemSelectList)do
addItemFunc(useItemCountList,itemId,data.count)
allCostCount=allCostCount+data.costCount*data.count
end
local combineCostCount=targetCostCount-allCostCount-v.cost*addCombineCnt_item
local usedCostCnt=useItemCountList[costType]or 0
local validCostCnt=costHasCount-usedCostCnt
if validCostCnt>=combineCostCount then
maxSelectNum=maxSelectNum+1
addItemFunc(useItemCountList,costType,combineCostCount)
end

addItemFunc(useItemCountList,levelItemId,addCombineCnt_item)
tmpItemSelectList={}
addCombineCnt=addCombineCnt+1
else
tmpItemSelectList[levelItemId]={
count=addCombineCnt_item,
weight=weight*addCombineCnt_item,
costCount=v.cost,
}
end
end

local validCnt=hasCount-usedCnt-addCombineCnt_item
local maxCombineCnt_item=math.floor(weight*validCnt/singleNeedWeight)
maxCombineCnt=maxCombineCnt+maxCombineCnt_item+addCombineCnt
local addCnt=math.ceil(singleNeedWeight/weight)*maxCombineCnt_item
addItemFunc(useItemCountList,levelItemId,addCnt)

local usedCostCnt=useItemCountList[costType]or 0
local validCostCnt=costHasCount-usedCostCnt
local itemCostCount=v.cost
local combineSingleCount=targetCostCount-(singleNeedWeight/weight*itemCostCount)
local maxSelectNum_item=math.floor(validCostCnt/combineSingleCount)
local selectCnt=math.min(maxCombineCnt_item,maxSelectNum_item)
maxSelectNum=maxSelectNum+selectCnt
addItemFunc(useItemCountList,costType,combineSingleCount*selectCnt)

usedCnt=useItemCountList[levelItemId]or 0
local remainingItemCnt=hasCount-usedCnt-addCombineCnt_item
if remainingItemCnt>0 then
tmpItemSelectList[itemId]={
count=remainingItemCnt,
weight=weight*remainingItemCnt,
costCount=itemCostCount,
}
end
end
end

return maxCombineCnt,maxSelectNum
end

function UIYuFuLingZhenControl:getLZCombineSelectItemList_crossLevel(itemId,selectCnt,selectItemList,tmpList)
local cfg=itemsConfig.getConfig(itemId)
local isWuXing=cfg.type1==6
if isWuXing then
return
end

if selectCnt<=0 then
return{}
end

local level=cfg.level
local hcdata=cfgHelper.get2(cfg_yufulingzhenbaseconfig_get,1,'hcItems')
local need=hcdata[level+1]
local singleNeedWeight=need[1]
local targetCostCount=need[2]

local costType=eMoneyType.mtZhenShi
selectItemList=selectItemList or{}
table.clear(selectItemList)
local combineItemList=self:getLZCombineItemList_crossLevel(itemId)
local remainingSelectCnt=selectCnt
local tmpItemSelectList=tmpList or{}
local totalNeedWeight=singleNeedWeight*selectCnt
selectItemList[costType]=targetCostCount*selectCnt
for _,v in ipairs(combineItemList)do
local levelItemId=v.itemId
local weight=v.weight
local hasCount=itemsModel.getCount(levelItemId)
if hasCount>0 then
local useCount=math.min(hasCount,math.floor(totalNeedWeight/weight))
if useCount>0 then
totalNeedWeight=totalNeedWeight-useCount*weight
selectItemList[levelItemId]=(selectItemList[levelItemId]or 0)+useCount
selectItemList[costType]=(selectItemList[costType]or 0)-v.cost*useCount

if totalNeedWeight<=0 then
break
end
end
end
end













































































return selectItemList
end


function UIYuFuLingZhenControl:reqLZDatas(dzId,yfId)
socketManager:send_2_110(dzId,yfId)
end

function UIYuFuLingZhenControl:reqActiveZhenTU(dzId,yfId,ztId)
socketManager:send_2_111(dzId,yfId,ztId)
end

function UIYuFuLingZhenControl:reqReplaceZhenTU(dzId,yfId,ztId)
socketManager:send_2_112(dzId,yfId,ztId)
end

function UIYuFuLingZhenControl:reqLZXiangQian(dzId,yfId,len,arr)
socketManager:send_2_113(dzId,yfId,len,arr)
end

function UIYuFuLingZhenControl:reqLZXieXia(dzId,yfId,len,arr)
socketManager:send_2_114(dzId,yfId,len,arr)
end











function UIYuFuLingZhenControl:reqLZHeCheng(dstItemId,dstItemNum,srcItemGuid,selectItemList)
socketManager:send_2_115(dstItemId,dstItemNum,srcItemGuid,#selectItemList,selectItemList)
end

function UIYuFuLingZhenControl:reqYanJiu(id)
socketManager:send_2_116(id)
end



function UIYuFuLingZhenControl.recv_2_110(datas)
UIYuFuLingZhenControl:setData(datas[1],datas[2],datas[3],datas[4],datas[5],datas[6],datas[7])
end

function UIYuFuLingZhenControl.recv_2_111(dzId,yufuGuid,ztId)
UIYuFuLingZhenControl:activeZhenTU(ztId)

UIYuFuLingZhenControl:changeZhenTu(dzId,yufuGuid,ztId)

UIManager:callWindowFunc('UIYuFuLingZhenWin','activeLzData')

end

function UIYuFuLingZhenControl.recv_2_112(dzId,yfId,ztId)
UIYuFuLingZhenControl:changeZhenTu(dzId,yfId,ztId)

UIManager:callWindowFunc('UIYuFuLingZhenWin','refreshlzData')
UIManager:callWindowFunc('UIYuFuLingZhenWin','refresh')

equipsModel.setAllEquipedAttrsDirty(dzId)
UIDiscipleModel:setDiscipleAttrListDirtyX(dzId,DISCIPLE_ATTRIBUTE_TYPE.eYuFu,true)
equipsModel.onChangeAttrsOnJinglianEquipbyFulu(dzId,false)
end

function UIYuFuLingZhenControl.recv_2_113(dzId,yfId,item)
UIYuFuLingZhenControl:resetXiangQian(dzId,yfId,item)
UIManager:callWindowFunc('UIYuFuLingZhenWin','refreshlzData')
UIManager:callWindowFunc('UIYuFuLingZhenWin','refresh')

notifySystem:postNotify(notifyConfig.onLingZhenEquip,item)

equipsModel.setAllEquipedAttrsDirty(dzId)
UIDiscipleModel:setDiscipleAttrListDirtyX(dzId,DISCIPLE_ATTRIBUTE_TYPE.eYuFu,true)
UIDiscipleModel:setSkillLvPlusLookupDirty(dzId,false)
equipsModel.onChangeAttrsOnJinglianEquipbyFulu(dzId,false)
end

function UIYuFuLingZhenControl.recv_2_114(dzId,yfId,item)
UIYuFuLingZhenControl:resetXiangQian(dzId,yfId,item)
UIManager:callWindowFunc('UIYuFuLingZhenWin','refreshlzData')
UIManager:callWindowFunc('UIYuFuLingZhenWin','refresh')

notifySystem:postNotify(notifyConfig.onLingZhenEquip,item)

equipsModel.setAllEquipedAttrsDirty(dzId)
UIDiscipleModel:setDiscipleAttrListDirtyX(dzId,DISCIPLE_ATTRIBUTE_TYPE.eYuFu,true)
UIDiscipleModel:setSkillLvPlusLookupDirty(dzId,false)
equipsModel.onChangeAttrsOnJinglianEquipbyFulu(dzId,false)
end















































function UIYuFuLingZhenControl.recv_2_115(itemId,dstItemNum,guid)
local data=lingzhenBagModel:getItem(guid)
local old,new
if data then
old=UIYuFuLingZhenControl:getItemLevel(data.itemid)
new=UIYuFuLingZhenControl:getItemLevel(itemId)
data.itemid=itemId
else
UIYuFuLingZhenControl:setLingZhenKongLevel(guid,itemId)
end

UIManager:callWindowFunc('UIYFLZCombineWin','refresh')



local tempRewardlist={}
showPrizeControl.insertTemp(tempRewardlist,guid,itemId,dstItemNum)
showPrizeControl.showWindow(tempRewardlist)
end

function UIYuFuLingZhenControl.recv_2_116(id)
UIYuFuLingZhenControl:setZhenTuResearched(id)
reddotControl.on_change_catch_type(CATCH_TYPE.eLingTuYanJiu)
UIManager:callWindowFunc('UIZhenTuYanJiuWin','refresh',true)

notifySystem:postNotify(notifyConfig.onZhenTuYanJiu,id)
end

function UIYuFuLingZhenControl.recv_2_117(taskType,taskParam,finishNum,zhentuId)
UIYuFuLingZhenControl:setResearchedInfo(taskType,taskParam,finishNum,zhentuId)
UIManager:callWindowFunc('UIZhenTuYanJiuWin','refresh')
end

function UIYuFuLingZhenControl.recv_2_118(args)
local dzGuid,yufuGuid,kongIndex,len,randAttrIdList,len2,randAttrIdList2,itemGuid=unpack(args)
if kongIndex==0 then
LingZhenChongZhuModel:saveChongZhuEquipByEquip(itemGuid,randAttrIdList,randAttrIdList2)
else
LingZhenChongZhuModel:saveChongZhuEquipEquiped(yufuGuid,kongIndex,randAttrIdList,randAttrIdList2)
end

UIManager:callWindowFunc("UILingzhenChongZhuWin","selectLzId",itemGuid,1,yufuGuid,kongIndex,true)

UIManager.info("刷新成功")
end

function UIYuFuLingZhenControl.recv_2_119(args)
local dzGuid,yufuGuid,kongIndex,len,randAttrIdList,itemGuid=unpack(args)
local mdata=lingzhenBagModel:getItem(itemGuid)
local isEquiped=false
if not mdata then

isEquiped=true
end
LingZhenChongZhuModel:onChongZhuEquipByEquip(isEquiped,mdata,randAttrIdList,yufuGuid,kongIndex)

if isEquiped then
UIManager:callWindowFunc('UIYuFuLingZhenWin','refresh')
end

UIManager:callWindowFunc("UILingzhenChongZhuWin","selectLzId",itemGuid,2,yufuGuid,kongIndex)

UIManager.info("替换成功")

local equipData=UIYuFuLingZhenControl:getLingZhenData(yufuGuid)
if equipData then
UIDiscipleModel:setDiscipleAttrListDirtyX(equipData.dzGuid,DISCIPLE_ATTRIBUTE_TYPE.eYuFu,true)
UIDiscipleModel:setSkillLvPlusLookupDirty(equipData.dzGuid,false)
end
end

function UIYuFuLingZhenControl.req_2_109(itemGuidList)
socketManager:send_2_109(#itemGuidList,itemGuidList)
end

function UIYuFuLingZhenControl.recv_2_109(len,itemGuidList)
if len>0 then

for _,itemguid in ipairs(itemGuidList)do
local item=bagModel.getItem(itemguid)
if item then
lingzhenBagModel:changeItem(item)
else
lingzhenBagModel:deleteItem(tostring(itemguid))
end
end
end

UIManager:callWindowFunc('UIYFLZCombineWin','refresh')
UIManager:callWindowFunc('UILingZhenFJWin','refreshArgRecv')
end

function UIYuFuLingZhenControl.req_2_105(yufuGuid,itemGuid,kongIndex)
yufuGuid=yufuGuid or int64.zero
itemGuid=itemGuid or int64.zero
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(yufuGuid)
socketManager:send_2_105(dzId or int64.zero,yufuGuid,itemGuid,kongIndex or 0)

end

function UIYuFuLingZhenControl.recv_2_105(dzGuid,yufuGuid,itemGuid,kongIndex)
local mdata=lingzhenBagModel:getItem(itemGuid)
local isEquiped=false
if not mdata then
isEquiped=true
end
LingZhenChongZhuModel:onChongZhuEquipByCancel(isEquiped,mdata,yufuGuid,kongIndex)

UIManager:callWindowFunc("UILingzhenChongZhuWin","selectLzId",itemGuid,nil,yufuGuid,kongIndex,true)
end

function UIYuFuLingZhenControl.req_2_107(yufuGuid,itemGuid,kongIndex,lockFlag)
yufuGuid=yufuGuid or int64.zero
itemGuid=itemGuid or int64.zero
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(yufuGuid)
socketManager:send_2_107(dzId or int64.zero,yufuGuid,itemGuid,kongIndex or 0,lockFlag)
end
function UIYuFuLingZhenControl.recv_2_107(dzGuid,yufuGuid,itemGuid,kongIndex,lockFlag)
UIYuFuLingZhenControl:setItemLock(itemGuid,yufuGuid,kongIndex,lockFlag)

UIManager:callWindowFunc('UIYFLZCombineWin','refresh')

UIManager:callWindowFunc('UIBagWin','freshItemByGuid',itemGuid)
end






function UIYuFuLingZhenControl.req_2_146(hcItemId,hcNum,hcListLen,hcList)
socketManager:send_2_146(hcItemId,hcNum,hcListLen,hcList)
end


function UIYuFuLingZhenControl.recv_2_146(hcItemId,hcNum)
local reward={{param_1=hcItemId,param_2=hcNum}}
local quickWin=UIManager:findActiveWindow('UIQuickHeChengWin')
if not quickWin then
local win=UIManager:findActiveWindow('UIHeChengLianHuaWin')
if win then
local pfId=heChengLianHuaModel:getPFIdByItemid(hcItemId)

return win:startHeChengLianHua(pfId,reward)
end
end
if quickWin then

local showRewardList={}
for i,v in ipairs(reward)do
local itemid=v.param_1
local itemcount=v.param_2
local item={itemid=itemid,num=itemcount}
table.insert(showRewardList,item)
end
showPrizeControl.showWindowNow(showRewardList)
UIManager:invokeUIMethod("UICommonMoneyGainWin","onCloseClick")
end
end


function UIYuFuLingZhenControl.onDiscipleSixAttrChange(discipleguid,attrid,old,cur)
UIDiscipleModel:setDiscipleAttrListDirtyX(discipleguid,DISCIPLE_ATTRIBUTE_TYPE.eYuFu,false)
end

function UIYuFuLingZhenControl:reqZhuanHuan(itemGuid,dzGuid,yufuGuid,kongIndex,dstItemId)
socketManager:send_2_104(itemGuid,dzGuid,yufuGuid,kongIndex,dstItemId)
end


function UIYuFuLingZhenControl.recv_2_104(args)
local itemGuid,dzGuid,yufuGuid,kongIndex,dstItemId,convertNum=unpack(args)
UIYuFuLingZhenControl:setConvertNum(convertNum)
if kongIndex then
UIManager:callWindowFunc('UIYuFuLingZhenWin','setlzDataConvert',kongIndex,dstItemId)
end
UIManager:callWindowFunc('UIYuFuLingZhenWin','refresh')
UIManager:callWindowFunc('UIYFLZCombineWin','refresh')

local equipData=UIYuFuLingZhenControl:getLingZhenData(yufuGuid)
if equipData then
UIDiscipleModel:setDiscipleAttrListDirtyX(equipData.dzGuid,DISCIPLE_ATTRIBUTE_TYPE.eYuFu,true)
UIDiscipleModel:setSkillLvPlusLookupDirty(equipData.dzGuid,false)
end
UIManager:invokeUIMethod('UILingzhenZhuanHuanWin','onCancelbtn')
UIManager.info('灵阵转换成功')
end

function UIYuFuLingZhenControl.onNewMonth5am()
if systemModel.isOpen(SYSTEM_DEFINE.eLingZhenConvert)then
UIManager:callWindowFunc('UILingzhenZhuanHuanWin','refreshRemainTimesOnNewMonth5am')
UIManager:callWindowFunc('UILingzhenZhuanHuanWin','checkZhuanHuan')
end
end

