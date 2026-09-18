







npcModel={}

npcIntimacyRewardType={
eReward=1,
eMiWen=2,
eGame=3,
}

local npcIntimacyRewardConfig={
[npcIntimacyRewardType.eReward]={'赠予礼物','icon_npctp_001'},
[npcIntimacyRewardType.eMiWen]={'秘闻','icon_npctp_002'},
[npcIntimacyRewardType.eGame]={'进行考验','icon_npctp_002'},
}

function npcModel:initData()
local data={}
data.posVectorUsedLookup={}
self.mydata=data

local cfgs=cfg_npcintimacyconfig()

local maxCfg=cfgs[#cfgs]
local range=maxCfg.hgdRange
self.maxHgd=range[2]

local minCfg=cfgs[0]
local range=minCfg.hgdRange
self.minHgd=range[1]
























end

function npcModel:clearData()
self.mydata=nil
self.maxHgd=nil
self.minHgd=nil
end

function npcModel:checkPosition(npcList)
local posList={}
if npcList then
for i,v in ipairs(npcList)do
if v.npcData.posGuid then
table.insert(posList,v.posGuid)
end
end
end
worldPositionLibrary:checkData(eWorldUnitTpye.NPC,posList)
end

function npcModel:newPosVector(npcData)
local groupType=NPC_TYPE:getNPCGroupType(npcData.npctype)
local posVector={}
posVector.groupType=groupType
if groupType==NPC_GROUP_TYPE.eWorld then
local worldid=npcData.worldid
local blockid=npcData.blockid
local posGuid=npcData.posGuid
posVector.worldid=worldid
posVector.blockid=blockid

if worldPositionLibrary:containData(posGuid)then
local posData=worldPositionLibrary:getData(posGuid)
posVector.flip=posData.flip
posVector.side=posData.flip==true and 1 or 0
posVector.pos=worldPositionConfig:getPosition(worldid,{posData.x,posData.z})
if posVector.pos~=Vector3.zero then
posVector.key=tostring(posGuid)
posVector.guid=posGuid
return posVector
else
loggerUtil.logErrFMT("本地存在错误NPC旧坐标数据:{0},({1},{2}),{3}",worldid,posData.x,posData.z,tostring(posGuid))
worldPositionLibrary:eraseData(posGuid)
end
end
local posCfg=cfgHelper.get2(cfg_npcworldposconfig_get,worldid,blockid)
local libs=posCfg.poslist
local check,temp=worldPositionLibrary:extract(libs)
local x,z,flip,valid
if check then
x=temp[1].x
z=temp[1].z
flip=temp[1].flip
valid=true
else
x=0
z=0
flip=false
loggerUtil.logErrFMT("NPC{0}坐标随机库抽取失败,GUID:{1}",serializeHelper.serialize(libs),tostring(posGuid))
end
if valid then
worldPositionLibrary:markData(worldid,x,z,flip,eWorldUnitTpye.NPC,posGuid)
end
posVector.flip=flip
posVector.side=flip==true and 1 or 0
posVector.pos=worldPositionConfig:getPosition(worldid,{x,z})

posVector.key=tostring(posGuid)
posVector.guid=posGuid




















elseif groupType==NPC_GROUP_TYPE.eZongMen then
posVector.sfid=npcData.sfid
posVector.areaid=npcData.areaid
end
return posVector
end

function npcModel:initNPCDataList(dataList)
local lookup={}
if dataList then
for i,v in ipairs(dataList)do
lookup[v.npcid]=v
end
end
self.mydata.npcDataLookup=lookup
end

function npcModel:getAllUnlockNPC(checkHide)
local list={}
if self.mydata and self.mydata.npcDataLookup then
for npcid,data in pairs(self.mydata.npcDataLookup)do
local check=true
if checkHide then
local npccfg=cfgHelper.get1(cfg_npcconfig_get,npcid)
if npccfg.hide==true then
check=false
end
end
if check then
table.insert(list,npcid)
end
end
end
return list
end

function npcModel:checkNPCUnlock(npcid)
if self.mydata and self.mydata.npcDataLookup then
return self.mydata.npcDataLookup[npcid]~=nil
end
return false
end

function npcModel:initNPCList(npcList)

self.mydata.npcLookup=nil
self.mydata.npcList=nil
self.mydata.posVectorUsedLookup={}

local lookup={}


self:checkPosition(npcList)

if npcList then
for i,npcItemData in ipairs(npcList)do
local npcid=npcItemData.npcid
lookup[npcid]=npcItemData
npcModel:resetNPCItemData(npcItemData)
end
end
self.mydata.npcLookup=lookup
self.mydata.npcList=npcList or{}
end

function npcModel:getAllNPCLookup()
if self.mydata then
return self.mydata.npcLookup or{}
end
end

function npcModel:getAllNPCDataLookup()
if self.mydata then
return self.mydata.npcDataLookup or{}
end
end

function npcModel:getAllNPCList()
if self.mydata then
return self.mydata.npcList or{}
end
end

function npcModel:getNPCCnt()
if self.mydata and self.mydata.npcList then
return#self.mydata.npcList
end
return 0
end


function npcModel:resetNPCItemData(npcItemData,old_npcItemData)
local needResetPos=false
local isNew=false
local npcData=npcItemData.npcData
local groupType=NPC_TYPE:getNPCGroupType(npcData.npctype)
if old_npcItemData~=nil then
local removePos=true
local old_npcData=old_npcItemData.npcData
if npcData.npctype==old_npcData.npctype then
if groupType==NPC_GROUP_TYPE.eWorld then
if npcData.worldid==old_npcData.worldid and npcData.blockid==old_npcData.blockid then
removePos=false
end
elseif groupType==NPC_GROUP_TYPE.eZongMen then
if npcData.sfid==old_npcData.sfid and npcData.areaid==old_npcData.areaid then
removePos=false
end
end
end
if removePos then
needResetPos=true
local posVector=old_npcItemData.posVector

if posVector~=nil then
self.mydata.posVectorUsedLookup[posVector.key]=nil
old_npcItemData.posVector=nil
end
end
else
isNew=true
local npcid=npcItemData.npcid
if npcModel:getNPCIntimacy(npcid)==nil then
local initIntimacy=npcModel:getInitIntimacy(npcid)
npcModel:setNPCIntimacy(npcid,initIntimacy)
end
end
if needResetPos or isNew then
local posVector

if groupType==NPC_GROUP_TYPE.eWorld then
posVector=npcModel:newPosVector(npcData)
end
if posVector then
self.mydata.posVectorUsedLookup[posVector.key]=posVector
npcItemData.posVector=posVector
end
end
return isNew
end

function npcModel:initInteractDZ(discipleguid)
self.mydata.initInteractDZ=discipleguid
end

function npcModel:getInteractDZ()
local cur=self.mydata.initInteractDZ
if mathHelper.validInt64(cur)and UIDiscipleModel:getDiscipleData(cur)then
return cur
else

local jys=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJieYin)
if jys and#jys>0 then
local netData=jys[1]
return netData.discipleguid
else
local netData=UIDiscipleModel:findSrcTypeDisciple(discipleSrcType.ePlot1)
return netData.discipleguid
end
end
end

function npcModel:getNPCItemData(npcid)
if self.mydata and self.mydata.npcLookup then
return self.mydata.npcLookup[npcid]
end
return nil
end

function npcModel:removeNPCItemData(npcid)
if self.mydata and self.mydata.npcLookup then
local npcItemData=self.mydata.npcLookup[npcid]
if npcItemData then
local posVector=npcItemData.posVector

if posVector~=nil then
worldPositionLibrary:eraseData(posVector.guid)
self.mydata.posVectorUsedLookup[posVector.key]=nil
npcItemData.posVector=nil
end
local f=nil
for i,v in ipairs(self.mydata.npcList)do
if v.npcid==npcid then
f=i
break
end
end
if f then
table.remove(self.mydata.npcList,f)
end
self.mydata.npcLookup[npcid]=nil
return true
end
end
return false
end

function npcModel:refreshNPCItemData(npcid,interacttype,interacttimes)
local npcItemData=npcModel:getNPCItemData(npcid)
if npcItemData then
npcItemData.timeslist[interacttype]=interacttimes
end
end

function npcModel:checkInteractTypeOpen(npcid,interacttype)
local key=FMT.fmt('interact_{0}',interacttype)
local interact=cfgHelper.get2(cfg_npcconfig_get,npcid,key)
return interact~=nil
end

function npcModel:checkInteractTypeEnough(npcid,interacttype,isWarning)
if not npcModel:checkInteractTypeOpen(npcid,interacttype)then
return false
end
local cur=npcModel:getNPCInteractTypeNum(npcid,interacttype)
local max=npcController:getInteractMaxNum(interacttype,npcid)
local check=true
if cur>=max or not npcController:checkInteractNumCond(interacttype,npcid)then
check=false
end
if not check then
if isWarning then
UIManager.error(npcController:getInteractTips(interacttype))
end
end
return check
end

function npcModel:getNPCInteractTypeNum(npcid,interacttype)
local npcItemData=npcModel:getNPCItemData(npcid)
return npcItemData.timeslist[interacttype]
end

function npcModel:refreshNPCItemData3(npcItemData)
local lookup=self.mydata.npcLookup
local npcid=npcItemData.npcid
local old_npcItemData=npcModel:getNPCItemData(npcid)
lookup[npcItemData.npcid]=npcItemData
local isNew=npcModel:resetNPCItemData(npcItemData,old_npcItemData)
return isNew
end

function npcModel:refrescNPCAskfor(npcid,itemguid)
local npcItemData=npcModel:getNPCItemData(npcid)
if npcItemData then
local bagList=npcItemData.bagList
if bagList~=nil then
local f=nil
for i,item in ipairs(bagList)do
if mathHelper.compareInt64(item.itemguid,itemguid)then
f=i
break
end
end
if f then
table.remove(bagList,f)
end
end
end
end

function npcModel:getNPCLevel(npcid)
local npcItemData=npcModel:getNPCItemData(npcid)

if npcItemData then
return npcItemData.npclv
else
local condition=cfgHelper.get2(cfg_npcconfig_get,npcid,'condition')
local f=nil
for lv,condArr in ipairs(condition)do
local fix=true
for i,cond in ipairs(condArr)do
local condType=cond[1]
if condType==1 then

local lv=zongmenModel:getLevel()
if lv<cond[2]then
fix=false
end
elseif condType==2 then

if not taskModel:checkTaskFinish(cond[2])then
fix=false
end
elseif condType==3 then

if not worldBlockModel:checkBlockState(cond[2],cond[3],eWorldBlockState.OPEN)then
fix=false
end
else
fix=false
end
if not fix then
break
end
end
if not fix then
f=lv
break
end
end
if f then
return f-1
else
return 0
end
end
end


function npcModel:getWorldAreaNPCList()
local lookup=self:getAllNPCLookup()or{}
local areaList={}
local npcWorldLookup={}
for _,npcItemData in pairs(lookup)do
local npcData=npcItemData.npcData
if NPC_TYPE:isWorldNPC(npcData.npctype)then
local worldid=npcData.worldid
local blockid=npcData.blockid
local state=worldBlockModel:getBlockState(worldid,blockid)
if state==worldBlockModel.BLOCKSTATE.OPEN then
local list=npcWorldLookup[worldid]
if list==nil then
list={}
npcWorldLookup[worldid]=list
end
table.insert(list,npcItemData)
end
end
end
for i,list in pairsBySortKey(npcWorldLookup)do
table.insert(areaList,list)
end
return areaList
end

function npcModel:getWorldAreaNPCReddot()
local lookup=self:getAllNPCLookup()
if lookup then
for _,npcItemData in pairs(lookup)do
local npcData=npcItemData.npcData
if NPC_TYPE:isWorldNPC(npcData.npctype)then
local worldid=npcData.worldid
local blockid=npcData.blockid
local state=worldBlockModel:getBlockState(worldid,blockid)
if state==worldBlockModel.BLOCKSTATE.OPEN then
local npcid=npcItemData.npcid
local showEvent=npcModel:checkIntimacyReward(npcid)~=nil
if showEvent then
return true
end
end
end
end
end
return false
end

function npcModel:findNPCByPosGuid(posGuid)
local list=npcModel:getAllNPCList()
for i,v in ipairs(list)do
if mathHelper.compareInt64(v.npcData.posGuid,posGuid)then
return v
end
end
end


function npcModel:getNPCLastFightTime(npcid)
local mydata=self.mydata
if mydata~=nil then
local data=mydata.npcDataLookup[npcid]
if data then
return data.lastfightsec or 0
end
end
end


function npcModel:customer2NPC(roomData)
local npcid=roomData.customerId
if npcid<=0 then
return
end
local mydata=self.mydata
if mydata~=nil then
local data=mydata.npcDataLookup[npcid]
if data==nil then
local intimacy=roomData.haoGanDu
data={npcid=npcid,intimacy=intimacy,lastfightsec=0,flag=0}
mydata.npcDataLookup[npcid]=data
end
local npcItemData=npcModel:getNPCItemData(npcid)
if npcItemData==nil then
npcItemData={}
npcItemData.npcid=npcid
npcItemData.npclv=npcModel:getNPCLevel(npcid)
local timeslist={}
for k,v in pairs(NPC_INTERACT_TYPE)do
timeslist[v]=0
end
npcItemData.timeslist=timeslist
npcItemData.timeslistlen=#timeslist
local bagList={}










npcItemData.bagList=bagList
npcItemData.baglistlen=#bagList
local npcData={}
npcData.npctype=NPC_TYPE.eZongmenRandom
npcData.sfid=mapIdType.xianzhan
npcData.areaid=roomData.roomId
npcItemData.npcData=npcData

npcController.do_protocol_22_5(npcItemData)
end
end
end


function npcModel:customerLevel(customerId)
local npcid=customerId
if npcid<=0 then return end
local mydata=self.mydata
if mydata~=nil then
local npcItemData=npcModel:getNPCItemData(npcid)
if npcItemData~=nil then
local npctype=npcItemData.npcData.npctype
if npctype==NPC_TYPE.eZongmenRandom then
npcController.do_protocol_22_7(npctype,npcid)
end
end
end
end




function npcModel:getNPCIntimacy(npcid)
local mydata=self.mydata
if mydata~=nil then
local data=mydata.npcDataLookup[npcid]
if data then
return data.intimacy
end
end
end

function npcModel:getNPCIntimacyRewardFlag(npcid)
local mydata=self.mydata
if mydata~=nil then
local data=mydata.npcDataLookup[npcid]
if data then
return data.flag
end
end
end

function npcModel:setNPCIntimacyRewardFlag(npcid,hgdlv)
local mydata=self.mydata
if mydata~=nil then
local data=mydata.npcDataLookup[npcid]
if data then
local flag=data.flag
flag=bitHelper.set_1(flag,hgdlv)
data.flag=flag
end
end
end

function npcModel:setNPCIntimacy(npcid,intimacy)
local mydata=self.mydata
if mydata~=nil then
local data=mydata.npcDataLookup[npcid]
if data~=nil then
mydata.intimacyChangeRecord=intimacy-data.intimacy
data.intimacy=intimacy
else
data={npcid=npcid,intimacy=intimacy,lastfightsec=0,flag=0}
mydata.npcDataLookup[npcid]=data
end
end
notifySystem:postNotify(notifyConfig.onNPCIntimacyChange,npcid)
end

function npcModel:getIntimacyChangeRecord()
local mydata=self.mydata
if mydata~=nil then
return mydata.intimacyChangeRecord or 0
end
return 0
end

function npcModel:checkIntimacyReward(npcid)
local chengwei=cfgHelper.get2(cfg_npcconfig_get,npcid,'chengwei')
if chengwei then
local hgd=npcModel:getNPCIntimacy(npcid)
local lv=npcModel.getHaoGanDuLevel(hgd)
local flag=npcModel:getNPCIntimacyRewardFlag(npcid)
for lv_,v in pairsBySortKey(chengwei)do
if lv>=lv_ then
if not bitHelper.check_pos(flag,lv_)then
return v,lv_
end
end
end
end
end

function npcModel:getIntimacyReward(npcid,hgdlv)
local chengwei=cfgHelper.get2(cfg_npcconfig_get,npcid,'chengwei')
if chengwei then
return chengwei[hgdlv]
end
end

function npcModel.getIntimacyShowReward(reward)
local typo=reward[1]
if typo==npcIntimacyRewardType.eReward then

return reward[2]
elseif typo==npcIntimacyRewardType.eMiWen then

return reward[3]
elseif typo==npcIntimacyRewardType.eGame then

return reward[2]
end
end

function npcModel.getIntimacyRewardResultTalk(reward)
local typo=reward[1]
if typo==npcIntimacyRewardType.eReward then

return reward[3]
elseif typo==npcIntimacyRewardType.eMiWen then

return reward[4]
elseif typo==npcIntimacyRewardType.eGame then

return reward[3][4]
end
end

function npcModel.getIntimacyRewardInfo(reward)
local typo=reward[1]
return npcIntimacyRewardConfig[typo]
end

function npcModel.getIntimacyIcon(hgdlv)
local abName=globalABLookup.npcCommonIcons
local icon=cfgHelper.get2(cfg_npcintimacyconfig_get,hgdlv,'imgRes')
icon=FMT.fmt('image_npcqinmiduwz_{0}',icon)
return abName,icon
end

function npcModel:getMaxHaoGanDu()
return self.maxHgd
end

function npcModel:getMinHaoGanDu()
return self.minHgd
end

function npcModel:getNewHaoGanDu(hgd,changeNum)
hgd=hgd+changeNum

local min=npcModel:getMinHaoGanDu()
if hgd<0 then hgd=min end

return hgd
end

function npcModel:getHaoGanDuConfig(hgd)
local max=npcModel:getMaxHaoGanDu()
local min=npcModel:getMinHaoGanDu()
if hgd<min then hgd=min end
if hgd>max then hgd=max end
local cfgs=cfg_npcintimacyconfig()
for i,v in pairs(cfgs)do
local range=v.hgdRange
if hgd>=range[1]and hgd<=range[2]then
return v
end
end
end

function npcModel.getHaoGanDuLevel(hgd,isfix)
local cfg=npcModel:getHaoGanDuConfig(hgd)
local range=cfg.hgdRange
if hgd<range[1]then hgd=range[1]end
if hgd>range[2]then hgd=range[2]end
local cur=hgd-range[1]
local max=range[2]-range[1]
if isfix==nil or isfix==true then
max=max+1
end
local rate=cur/max
local lv=cfg.id
local n_lv=lv+1
local n_cfg=cfgHelper.get1(cfg_npcintimacyconfig_get,n_lv)
local isFull=n_cfg==nil
return lv,rate,cur,max,isFull
end

function npcModel.getHaoGanDuName(hgd,isColor)
local cfg=npcModel:getHaoGanDuConfig(hgd)
if isColor then
return FMT.fmt("<color={0}>{1}</color>",cfg.color,cfg.name)
end
return cfg.name
end

function npcModel.getHaoGanDuName2(hgd)
local cfg=npcModel:getHaoGanDuConfig(hgd)
return FMT.fmt("<color={0}>{1}</color>",cfg.color2,cfg.name)
end

function npcModel.getHaoGanDuNameEx(hgdlv)
return cfgHelper.get2(cfg_npcintimacyconfig_get,hgdlv,'name')
end





function npcModel:getName(npcImgID)
return cfgHelper.get2(cfg_npcimageconfig_get,npcImgID,'name')
end

function npcModel:getInitIntimacy(npcid)
return cfgHelper.get2(cfg_npcconfig_get,npcid,'init')
end

function npcModel:getImageInfo(npcImgID)
local cfg=cfgHelper.get1(cfg_npcimageconfig_get,npcImgID)
local image=cfg.image
local imageType=cfg.imageType
return self:getImageInfoEx(image)
end

function npcModel:getImageInfoEx(image)
local result={}
result.body=image[1]
result.componets={}
local imageInfo=image[2]
if imageInfo~=nil then
if imageInfo[1]>0 then

local hair=cfgHelper.get2(cfg_disciplehairimageconfig_get,imageInfo[1],'in_side')
if hair~=nil then
for _,cmpID in ipairs(hair)do
table_insert(result.componets,cmpID)
end
end
end
if imageInfo[2]>0 then

local face=cfgHelper.get2(cfg_disciplefaceimageconfig_get,imageInfo[2],'in_side')
if face~=nil then
for _,cmpID in ipairs(face)do
table_insert(result.componets,cmpID)
end
end
end
if imageInfo[3]>0 then

local bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,imageInfo[3])

if bodyCfg.skeletonID~=nil then
result.body=bodyCfg.skeletonID
end
if bodyCfg.in_side then
for _,cmpID in ipairs(bodyCfg.in_side)do
table_insert(result.componets,cmpID)
end
end
end
if imageInfo[4]>0 then

local accessory=cfgHelper.get2(cfg_disciplefaceaccessoryimageconfig_get,imageInfo[4],'in_side')
if accessory~=nil then
for _,cmpID in ipairs(accessory)do
table_insert(result.componets,cmpID)
end
end
end
end
local dbcfg=cfgHelper.get1(cfg_dbbodyconfig_get,result.body)
local scales=dbcfg.scales or{}
result.scale=scales[1]or 1
result.headOffset=dbcfg.headOffset or{0,-90}
result.anim=0
return result
end

function npcModel:getImageInfoOutSide(npcImgID,scaleType)
local result={}
local cfg=cfgHelper.get1(cfg_npcimageconfig_get,npcImgID)
local image=cfg.image
result.componets={}
result.sex=cfg.sex

local imageInfo=image[2]
if imageInfo then
local bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,imageInfo[3])
result.body=bodyCfg.out_side
local hideWeapon=cfgHelper.get2(cfg_dbbodyconfig_get,result.body,'hideWeapon')
result.hideWeapon=hideWeapon
if imageInfo[1]>0 then

local hair=cfgHelper.get2(cfg_disciplehairimageconfig_get,imageInfo[1],'out_side')
if hair~=nil then
for _,cmpID in ipairs(hair)do
table_insert(result.componets,cmpID)
end
end
end
if imageInfo[2]>0 then

local face=cfgHelper.get2(cfg_disciplefaceimageconfig_get,imageInfo[2],'out_side')
if face then
for _,cmpID in ipairs(face)do
table_insert(result.componets,cmpID)
end
end
end
if imageInfo[5]and imageInfo[5]>0 and hideWeapon==nil then

local weapon=cfgHelper.get2(cfg_discipleweaponimageconfig_get,imageInfo[5],'out_side')
if weapon then
table_insert(result.componets,weapon)
end
end
else
result.body=image[1]
end

local scales=cfgHelper.get2(cfg_dbbodyconfig_get,result.body,'scales')or{}
scaleType=scaleType or 2
result.scale=scales[scaleType]or 1
result.anim=0
return result
end

function npcModel:getImageInfoOutSideEx(modelId,scaleType)
local result={}
result.body=modelId
result.componets={}
local scales=cfgHelper.get2(cfg_dbbodyconfig_get,result.body,'scales')or{}
scaleType=scaleType or 2
result.scale=scales[scaleType]or 1
result.anim=0
return result
end

function npcModel:getNPCImageID(npcid,npclv)
if npclv<=0 then npclv=1 end
local imageids=cfgHelper.get2(cfg_npcconfig_get,npcid,'imageids')
if npclv>#imageids then
npclv=#imageids
end
return imageids[npclv]
end

function npcModel:getNPCWorldModelID(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local worldImages=cfgHelper.get2(cfg_npcconfig_get,npcid,'worldImages')
if npclv>#worldImages then
npclv=#worldImages
end
return worldImages[npclv]
end

function npcModel:getNPCImageCfg(npcid)
local npclv=npcModel:getNPCLevel(npcid)
local imageID=npcModel:getNPCImageID(npcid,npclv)
return cfgHelper.get1(cfg_npcimageconfig_get,imageID)
end


function npcModel:getMortalNPCImageCfg(npcid)
local imageID=cfgHelper.get2(cfg_mortalnpcconfig_get,npcid,'imageid')
return cfgHelper.get1(cfg_npcimageconfig_get,imageID)
end

function npcModel:getNPCJingJie(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local jingjie=cfgHelper.get2(cfg_npcconfig_get,npcid,'jingjie')
if npclv>#jingjie then
npclv=#jingjie
end
return jingjie[npclv]
end

function npcModel:getNPCJob(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local jobs=cfgHelper.get2(cfg_npcconfig_get,npcid,'jobs')
if npclv>#jobs then
npclv=#jobs
end
return jobs[npclv]
end

function npcModel:getNPCDesc(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local descs=cfgHelper.get2(cfg_npcconfig_get,npcid,'descs')
if npclv>#descs then
npclv=#descs
end
return descs[npclv]
end

function npcModel:getNPCRelations(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local relations=cfgHelper.get2(cfg_npcconfig_get,npcid,'relations')
if npclv>#relations then
npclv=#relations
end
return relations[npclv]
end

function npcModel:getNPCLikeItems(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local likeItems=cfgHelper.get3(cfg_npcconfig_get,npcid,'interact5',3)
if npclv>#likeItems then
npclv=#likeItems
end
return likeItems[npclv]
end


function npcModel:getNPCMaxGiftHaoGanDu(npcid)
return cfgHelper.get3(cfg_npcconfig_get,npcid,'interact5',1)
end

function npcModel:getNPCEnoughGiftTalk(npcid)
local talkarr=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact_5_')
local str=table.randomIndex(talkarr)
return str
end


function npcModel:getNPCGiftRate(npcid)
return cfgHelper.get3(cfg_npcconfig_get,npcid,'interact5',2)
end

function npcModel:getNPCName(npcid)
local imagecfg=npcModel:getNPCImageCfg(npcid)
return imagecfg.name
end

function npcModel:getNPCAskforTalk(npcid,issuccess)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local hgd=npcModel:getNPCIntimacy(npcid)
local interact_1=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact_1')
if npclv>#interact_1 then
npclv=#interact_1
end
local talkData=interact_1[npclv]
local talkarr=issuccess==true and talkData[1]or talkData[2]
local str=table.randomIndex(talkarr)
return str

end

function npcModel:getNPCStealTalk(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local hgd=npcModel:getNPCIntimacy(npcid)
local interact_2=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact_2')
if npclv>#interact_2 then
npclv=#interact_2
end
local talkarr=interact_2[npclv]
local str=table.randomIndex(talkarr)
return str
end

function npcModel:getNPCStealHitTalk(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local hgd=npcModel:getNPCIntimacy(npcid)
local interact_2_=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact_2_')
if npclv>#interact_2_ then
npclv=#interact_2_
end
local talkarr=interact_2_[npclv]
local str=table.randomIndex(talkarr)
return str
end

function npcModel:getNPCGiftTalk(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local hgd=npcModel:getNPCIntimacy(npcid)
local interact_5=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact_5')
if npclv>#interact_5 then
npclv=#interact_5
end
local talkarr=interact_5[npclv]
local f=nil
for i,v in ipairs(talkarr)do
if hgd>=v[1]and hgd<=v[2]then
f=v[3]
break
end
end
if f==nil then
f=talkarr[#talkarr][3]
end
return f
end

function npcModel:getNPCDialogue(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local interact_3=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact_3')
if npclv>#interact_3 then
npclv=#interact_3
end
local list=interact_3[npclv]
local dialogueData,idx=table.randomWeight(list)
local dialoguelist={}
for i,dialogudID in ipairs(dialogueData[2])do
table.insert(dialoguelist,dialogudID)
end
local selectlist={}
selectlist[1]=#dialoguelist
local selectTitles={}
local rewardlist={}
local afterSelectTalks={}
for i,v in ipairs(dialogueData[3])do
selectTitles[i]=v[1]
rewardlist[i]=v[2]
afterSelectTalks[i]={}
for i2,dialogudID_ in ipairs(v[3])do
table.insert(afterSelectTalks[i],dialogudID_)
end
end
selectlist[2]=selectTitles
local d={}
d.dialoguelist=dialoguelist
d.selectlist=selectlist
d.afterSelectTalks=afterSelectTalks
d.rewardlist=rewardlist
return d
end

function npcModel:getNPCFightGroup(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local interact4=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact4')
if npclv>#interact4 then
npclv=#interact4
end
return interact4[npclv][1]
end

function npcModel:getNPCFightTalkAfter(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local interact_4=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact_4')
if npclv>#interact_4 then
npclv=#interact_4
end
local talkarr=interact_4[npclv][1]
local str=table.randomIndex(talkarr)
return str
end

function npcModel:getNPCFightTalkNone(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local interact_4=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact_4')
if npclv>#interact_4 then
npclv=#interact_4
end
local talkarr=interact_4[npclv][4]
local str=table.randomIndex(talkarr)
return str
end

function npcModel:getNPCFightTalkResult(npcid,result)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local interact_4=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact_4')
if npclv>#interact_4 then
npclv=#interact_4
end
local talkarr
if result==fightResultType.Victory then
talkarr=interact_4[npclv][2]
else
talkarr=interact_4[npclv][3]
end
local str=table.randomIndex(talkarr)
return str
end

function npcModel:getNPCGame(npcid)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local interact_6=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact_6')
if npclv>#interact_6 then
npclv=#interact_6
end
local list=interact_6[npclv]
local data,idx=table.randomWeight(list)
local gameType=data[2]
local mapidlist=data[3]
local mapid=table.randomIndex(mapidlist)
local resultLookup=data[4]
return gameType,mapid,resultLookup
end

function npcModel:getNPCGameResultTalk(npcid,resultLV)
local npclv=npcModel:getNPCLevel(npcid)
if npclv<=0 then npclv=1 end
local interact_6_1=cfgHelper.get2(cfg_npcconfig_get,npcid,'interact_6_1')
if npclv>#interact_6_1 then
npclv=#interact_6_1
end
local list=interact_6_1[npclv]
local talkarr=list[resultLV]
local str=table.randomIndex(talkarr)
return str
end

function npcModel:getNPCStandTalk(npcid)
local talkarr=cfgHelper.get2(cfg_npcconfig_get,npcid,'standTalks')
local str=table.randomIndex(talkarr)
return str
end

function npcModel:getNPCClickTalk(npcid)
local str=cfgHelper.get2(cfg_npcconfig_get,npcid,'clickTalk')
local desc=systemModel.getOpenTips(SYSTEM_DEFINE.eNPCOpen,'（','）')

return FMT.fmt('　　{0}<color=#ff6600>{1}</color>',str,desc)
end

