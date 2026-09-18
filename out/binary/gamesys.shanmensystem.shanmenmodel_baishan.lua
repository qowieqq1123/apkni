





local baiShanData
local _baishanGuidDict
local _baishanEntityDict
local _baishanHudDict
local _bsDiscipleState
local _posIndex
local modelUseFlag
local modelUseLook
local _baishanBTDict

local baishanModelList=
{
[SEX_TYPE.eMale]={1114107,1114108,1114109},
[SEX_TYPE.eFeMale]={1114110,1114111,1114112},
}


function shanmenModel.initBaiShan()
shanmenModel:removeAllModel()
baiShanData={}
_baishanGuidDict={}
_baishanEntityDict={}
_baishanHudDict={}
_bsDiscipleState={}
_posIndex={}
modelUseFlag={}
modelUseLook={}
_baishanBTDict={}
end


function shanmenModel:clearBaiShan()

shanmenModel:removeAllModel()
baiShanData=nil
_baishanGuidDict=nil
_baishanEntityDict=nil
_baishanHudDict=nil
_bsDiscipleState=nil
_posIndex=nil
modelUseFlag=nil
modelUseLook=nil
_baishanBTDict=nil
end


function shanmenModel.getBaiShanConfigField(str)
return cfgHelper.get2(cfg_disciplebaishanconfig_get,1,str)
end


function shanmenModel:initBaiShanData(baishanlistlen,baishanList)
if baishanlistlen>0 then
if baiShanData.isInit then
return
end
baiShanData={}
_bsDiscipleState={}
for i,v in ipairs(baishanList)do
UIDiscipleModel:addDiscipleDataTemp(v)
table.insert(baiShanData,{discipleInfo=v,posIdx=i})
_bsDiscipleState[tostring(v.discipleguid)]=0
end
end
baiShanData.isInit=true
end

function shanmenModel:createBaiShanRole()
for i,v in ipairs(baiShanData)do
self:createBaiShanModel(v.discipleInfo,v.posIdx)
end
end

function shanmenModel:addBaiShanData(baishanList)
for i,v in ipairs(baishanList)do
local idx=self:getBaiShanFreePosIndex()
self:createBaiShanModel(v,idx)
table.insert(baiShanData,{discipleInfo=v,posIdx=idx})
_bsDiscipleState[tostring(v.discipleguid)]=0
end
end

function shanmenModel:removeBaiShanData(dzId)
local data,index=shanmenModel:getBaiShanDataByDzId(dzId)
if data then
table.remove(baiShanData,index)
end
end

function shanmenModel:getBaiShanData()
return baiShanData
end

function shanmenModel:getBaiShanDataCount()
return baiShanData and#baiShanData or 0
end

function shanmenModel:hasBaiShanDZ()
return#baiShanData>0
end


function shanmenModel:hasHeightColorOrFullBaiShanDZ()
local data=shanmenModel:getBaiShanData()
if not data then

return false
end
local maxBaiShanCount=shanmenModel.getBaiShanConfigField('maxnum')
local baiShanCount=data and#data or 0
if baiShanCount and baiShanCount>=maxBaiShanCount then

return true
end
for i,v in ipairs(data)do
if v.discipleInfo then
local dzData=v.discipleInfo
local color=dzData.imageInfo.color
if color>=4 then

return true
end
end
end

return false
end


function shanmenModel:isFullBaiShanDZ()
local data=shanmenModel:getBaiShanData()
if not data then

return false
end
local maxBaiShanCount=shanmenModel.getBaiShanConfigField('maxnum')
local baiShanCount=data and#data or 0
if baiShanCount and baiShanCount>=maxBaiShanCount then

return true
end

return false
end

function shanmenModel:getBaiShanDataByDzId(dzId)
local datas=self:getBaiShanData()
for i,v in ipairs(datas)do
local dis_guid=v.discipleInfo.discipleguid
if mathHelper.compareInt64(dis_guid,dzId)then
return v,i
end
end
end

function shanmenModel:setBaiShanState(dzId,state)
_bsDiscipleState[tostring(dzId)]=state
end

function shanmenModel:getBaiShanStateByDzId(dzId)
return _bsDiscipleState[tostring(dzId)]
end

function shanmenModel:setLastBaiShanTime(lastTime)
self.data.lastBSTime=lastTime
end

function shanmenModel:getLastBaiShanTime()
return self.data.lastBSTime
end


function shanmenModel:createBaiShanModel(dzData,index)
local dzId=dzData.discipleguid
local dzIdStr=tostring(dzId)
local posList=self.getBaiShanConfigField('pos')
local idxPos=posList[index]
if idxPos then
_posIndex[index]=dzId
if mainControl:isSceneLoaded(eSceneType.eZongmen)and not _baishanEntityDict[dzIdStr]then
local pos=_MapManager.ToVector3Int(idxPos[1],idxPos[2],0)

local model=self:getShanMenDiscipleModel(dzId)
local scale=isometricMapSystem:getModelScale(model)
local offset=Vector3(idxPos[3]or 0,idxPos[4]or 0,0)
local guid=isometricMapSystem:createRoleEntity(objectType.eRole,mapIdType.zhufeng,0,model,{},SortingLayers.ITBuilding,scale,pos,offset)
_MapManager.ShowShadow(guid,true)

local bt=behaviorManager:addBehaviorTree('bt_baishan',{dzId=dzId,stId=guid},true)
if bt then
bt:setUpdateInterval(0.2)
end

local color=dzData.imageInfo.color
local effectIdList=self.getBaiShanConfigField('colorEffect')or{}
if color and effectIdList[color]then
local ent=_EntityManager:GetEntity(guid)

ent:SetSortingOrder(-1)

local bottomParam=effectIdList[color].bottom
if bottomParam then
local effectId=bottomParam.effect
local scaleNum=bottomParam.scale
local effScale=Vector3.New(scaleNum,scaleNum,scaleNum)
local offsetParam=bottomParam.offset
local offsetValue_x=offsetParam[1]or 0
local offsetValue_y=offsetParam[2]or 0
local offsetValue_z=offsetParam[3]or 0.1
ent:PlayEffect(effectId,Vector3.New(offsetValue_x,offsetValue_y,offsetValue_z),effScale,true,true)
end


ent:SetSortingOrder(0)

local topParam=effectIdList[color].top
if topParam then
local effectId=topParam.effect
local scaleNum=topParam.scale
local effScale=Vector3.New(scaleNum,scaleNum,scaleNum)
local offsetParam=topParam.offset
local offsetValue_x=offsetParam[1]or 0
local offsetValue_y=offsetParam[2]or 0
local offsetValue_z=offsetParam[3]or 0
ent:PlayEffect(effectId,Vector3.New(offsetValue_x,offsetValue_y,offsetValue_z),effScale,true,true)
end
end

_baishanBTDict[dzIdStr]=bt

hudControl:addHUD(INSTANCE_TYPE.eDiscipleBaiShan,guid,offset,true,true,function(hudId)
local widget=hudControl:getHUDWidget(hudId)
widget:SetChildButtonClick(2,function(...)
shanmenController:showBaiShanWin(guid)
end)
widget:SetChildRotation(1,0,0,0)
local tweener=widget:SetChildDOPunchRotation(1,Vector3(0,0,15),2,6,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)

_baishanHudDict[dzIdStr]=hudId
end)
_baishanGuidDict[guid]=dzId
_baishanEntityDict[dzIdStr]=guid
end
end
end

function shanmenModel:removeAllModel()
for _,v in ipairs(baiShanData or{})do
shanmenModel:removeBaiShanModel(v.discipleInfo.discipleguid)
end
end

function shanmenModel:removeBaiShanModel(dzId,clearData)
if dzId==nil then return end
local guid=_baishanEntityDict[tostring(dzId)]
if guid then
_MapManager.RemoveTilemapObject(guid)
end
_baishanEntityDict[tostring(dzId)]=nil
self:removeBaiHUD(dzId)
self:removeBaiShanBT(dzId)

local data=self:getBaiShanDataByDzId(dzId)
local index=data and data.posIdx or nil
if clearData then
self:removeBaiShanData(dzId)
end
if index then
_posIndex[index]=nil
end

local model=modelUseLook[tostring(dzId)]
if model then
modelUseFlag[model]=nil
end
modelUseLook[tostring(dzId)]=nil
end

function shanmenModel:removeBaiHUD(dzId)
local hudId=_baishanHudDict[tostring(dzId)]
if hudId then
hudControl:removeHUD(hudId)
_baishanHudDict[tostring(dzId)]=nil
end
end

function shanmenModel:removeBaiShanBT(dzId)
local bt=_baishanBTDict[tostring(dzId)]
if bt then
behaviorManager:removeBehaviorTree(bt)
_baishanBTDict[tostring(dzId)]=nil
end
end

function shanmenModel:removeAllBaiShanBT()
for k,v in pairs(_baishanBTDict)do
behaviorManager:removeBehaviorTree(v)
end
end


function shanmenModel:loadFirstBaiShanState()
self.firstBaiShan=userActorSetting.get('firstbaishanstate',true)
end

function shanmenModel:saveFirstBaiShanState()
self.firstBaiShan=false
userActorSetting.flushVal('firstbaishanstate',self.firstBaiShan)
end

function shanmenModel:getFirstBaiShanState()
return self.firstBaiShan
end

function shanmenModel:getShanMenDiscipleModel(dzId)
local firstBaiShan=self:getFirstBaiShanState()
if firstBaiShan then
self:saveFirstBaiShanState()
local modelid=self.getBaiShanConfigField('firstmodel')
modelUseLook[tostring(dzId)]=modelid
modelUseFlag[modelid]=true
return modelid
end
local sex=UIDiscipleModel:getDiscipleSex(dzId)
local modelList=baishanModelList[sex]
local useCnt=0
for i,v in ipairs(modelList)do
if modelUseFlag[v]then
useCnt=useCnt+1
end
end
if useCnt>=#modelList then
modelUseFlag={}
end
local model=self:getBaiShanRandModel(modelList)
modelUseLook[tostring(dzId)]=model
return model
end

function shanmenModel:getBaiShanRandModel(list)









local model
local nlist={}
for i,v in ipairs(list)do
if not modelUseFlag[v]then
table.insert(nlist,v)
end
end
local len=#nlist
if len>0 then
model=nlist[math.random(1,len)]
modelUseFlag[model]=true
end
return model
end

function shanmenModel:getBaiShanFreePosIndex()
local posList=self.getBaiShanConfigField('pos')
for i,v in ipairs(posList)do
if not _posIndex[i]then
return i
end
end
end

function shanmenModel:getBaiShanDisciplePos(dzId)
for index,v in pairs(_posIndex)do
if mathHelper.compareInt64(v,dzId)then
local posList=self.getBaiShanConfigField('pos')
local idxPos=posList[index]
local pos=_MapManager.ToVector3Int(idxPos[1],idxPos[2],0)
return pos
end
end
end

function shanmenModel:getBaiShanDisciplePosIndexList()
return _posIndex
end

function shanmenModel:getBsDiscipleguidByGuid(guid)
return _baishanGuidDict[guid]
end

function shanmenModel:getBaiShanDzPos(dzId)
local data=self:getBaiShanDataByDzId(dzId)
if data then
local index=data.posIdx
local posList=self.getBaiShanConfigField('pos')
local idxPos=posList[index]
return idxPos
end
end

function shanmenModel:checkZhaoru()
local cost=self.getBaiShanConfigField('consume')
for i,v in ipairs(cost)do
local itemid=v[1]
local need=v[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if have<need then
local itemConfig=itemsConfig.getConfig(itemid)
local msg=FMT.fmt('{0}不足',itemConfig.name)
gainControl:showGainWin(itemid)
return false,msg
end
end

local curDzCount=UIDiscipleModel:checkDiscipleCount()
local maxDzCount=UIRecruitModel:getZongMenPeopleMax()
if curDzCount>=maxDzCount then
return false,'宗门人数已达上限'
end
return true
end

function shanmenModel:getSuccessSpeakStr()
local speakList=shanmenModel.getBaiShanConfigField('successspeak')
local rand=math.random(1,#speakList)
return speakList[rand]
end

function shanmenModel:getFailSpeakStr()
local speakList=shanmenModel.getBaiShanConfigField('failspeak')
local rand=math.random(1,#speakList)
return speakList[rand]
end


function shanmenModel:getFirstBaiShanDzPos()
local posList=self.getBaiShanConfigField('pos')
if not posList then
return
end

local dzId
local selectPosCfg
local posCount=#posList
if _posIndex and next(_posIndex)then
for i=1,posCount do
if _posIndex[i]then
dzId=_posIndex[i]
selectPosCfg=posList[i]
break
end
end
end

if dzId then
local dzIdStr=tostring(dzId)

local guid=_baishanEntityDict[dzIdStr]
local dzEntity=_EntityManager:GetEntity(guid)
local pos=dzEntity:GetPosition()
local offset=Vector3(selectPosCfg[3]or 0,selectPosCfg[4]or 0,0)
local showPos=pos+offset
return showPos
else
return nil
end
end


function shanmenModel:changeBaiShanDzShow(isShow)
if mainControl:isSceneLoaded(eSceneType.eZongmen)then
for dzIdStr,guid in pairs(_baishanEntityDict)do
local dzEntity=_EntityManager:GetEntity(guid)


dzEntity:SetVisible(isShow)
local hudId=_baishanHudDict[dzIdStr]
if hudId then
local hudWidget=hudControl:getHUDWidget(hudId)
hudWidget:SetChildActive(0,isShow)
end
end
end
end



