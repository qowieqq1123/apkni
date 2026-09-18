







animalStateManager=gameState.addListener({})

eAnimalType=
{
dog=1,
}

local animalModel={
[eAnimalType.dog]=440011
}

local _animalBTFile={
[eAnimalType.dog]='bt_dog_idle',
}



local _animalBTDict
local _animalBTBBDict

function animalStateManager:onAppStart()
self:onLeaveHome()
end

function animalStateManager:onEnterState(...)

end

function animalStateManager:onLeaveState(...)

end



function animalStateManager:onEnterHome()

end

function animalStateManager:onLeaveHome()
_animalBTDict={}
_animalBTBBDict={}
end



function animalStateManager:createAnimal(datas)
if datas and isometricMapSystem.isAreaInit then
for _,typo in pairs(eAnimalType)do
local model=animalModel[typo]
local scale=isometricMapSystem:getModelScale(model)
local rand=math.random(1,#datas)
local data=datas[rand]
if data then
local pos=_MapManager.ToVector3Int(data.x,data.y,0)
local mapId=zongmenModel:getMountainId()
local guid=isometricMapSystem:createRoleEntity(objectType.eRole,mapId,data.random_id,model,nil,SortingLayers.ITBuilding,scale,pos)
_MapManager.ShowShadow(guid,true)
self:addAnimalBehaviorTree({guid=guid,type=typo},eAnimationID.stand)
end
end
end
end


function animalStateManager:addAnimalBehaviorTree(args,stateId,clean)
local guid=args.guid
local bts=_animalBTDict[guid]
if bts==nil then
bts={}
_animalBTDict[guid]=bts
end
for k,bt in pairs(bts)do
if not bt.sleep then
bt:reset()
bt.sleep=true
end
end
local file=_animalBTFile[args.type]
if not file then
logErr('找不到对应状态行为树文件名')
return
end
local bt=bts[file]
if bt==nil then
bt=behaviorManager:addBehaviorTree(file,args,true)
bt.blackBoard=self:getSharedBlackBoard(guid)
bts[file]=bt
end
if clean then
self:cleanSharedBlackBoard(guid)
end
bt:setSharedVar(behaviorConfig.stateIdKey,stateId)
bt.sleep=nil
return bt
end

function animalStateManager:getSharedBlackBoard(guid)
local blackBoard=_animalBTBBDict[guid]
if blackBoard==nil then
blackBoard={}
_animalBTBBDict[guid]=blackBoard
end
return blackBoard
end

function animalStateManager:cleanSharedBlackBoard(guid)
local bb=self:getSharedBlackBoard(guid)

for k,v in pairs(bb)do
bb[k]=nil
end
end

function animalStateManager:getIdleAnimalState(key,value,typo)
local bts
for k,v in pairs(_animalBTFile)do
if k==typo then
bts=behaviorManager:getBehaviorTreeByFile(v)
for i,bt in ipairs(bts)do
if bt then
local val=bt:getSharedVar(key)
if val==value then
return bt
end
end
end
end
end
end
