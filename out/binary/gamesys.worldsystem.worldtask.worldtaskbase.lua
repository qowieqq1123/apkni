









worldTaskBase=simple_class()
worldTaskBase.ground_delay=2
worldTaskBase.sky_offset={
[1]={Vector3.zero},
[2]={Vector3.zero,Vector3.New(-1,0,-1)},
[3]={Vector3.zero,Vector3.New(-1,0,-1),Vector3.New(-1,0,1)},
[4]={Vector3.zero,Vector3.New(-1,0,-1),Vector3.New(-1,0,1),Vector3.New(-2,0,-1)},
[5]={Vector3.zero,Vector3.New(-1,0,-1),Vector3.New(-1,0,1),Vector3.New(-2,0,-1),Vector3.New(-2,0,1)},
}
worldTaskBase.fadeDuration=0.3
worldTaskBase.waitInterval=0.5
worldTaskBase.experienceWalkSpeed=5
worldTaskBase.experienceWalkAnimation=11
worldTaskBase.runAnimation=11
worldTaskBase.fadeEffect=3
worldTaskBase.runEffect=20105
worldTaskBase.tourHUD=13
















function worldTaskBase:__init(data)
self.key=data.key
self.world=data.world
self.startTime=data.startTime
self.endTime=data.endTime or-1
self.speed=data.speed
self.destination=data.destination
self.target=data.target
self.disciples=data.disciples
self.mode=data.mode
self.zfId=data.zfId or 0
self.objects={}
self.move={}
self:initShowDiscipleList()

end



function worldTaskBase:start(serverTime)













end


function worldTaskBase:quit()
self.objects={}
self.move={}
end


function worldTaskBase:complete()

worldTaskController:send_5_4(self.key,1,#self.disciples,self.disciples)
end


function worldTaskBase:finish()

if next(self.move)then
for i,v in pairs(self.move)do
worldController:popMove(v.Key)
end
self.move={}
end
for i=1,#self.objects do
local member=self.objects[i]
worldController:popUnit(member.Key)
end
self.objects={}
worldHUDModel:UpdateHUDByKey(self.target)

end


function worldTaskBase:onComplete()

end


function worldTaskBase:goBack()

end



function worldTaskBase:isWaitingBack()
return false
end



function worldTaskBase:isComplete(time)
if not self.triggerComplete then
local check=self.endTime>=0 and time>=self.endTime
if check then
self.triggerComplete=true
return 0
else
return-1
end
else
return 1
end
end


function worldTaskBase:showAllDisciples()
for i,v in ipairs(self.sortDiscipleList)do
worldTaskController:showTaskDisciple(self.key,v,i==1)
local unitKey=worldTaskModel:convertMissionUnitKey(self.key,v)
local obj=worldController:getUnit(unitKey)
self.objects[i]=obj
end
end

function worldTaskBase:appendTaskDisciple(disciples)
if self:getShowDiscipleCnt()+#disciples>worldTaskModel.maxDisciple then
return false
end
for i,v in ipairs(disciples)do


local job=UIDiscipleModel:getDiscipleJob(v)
local jobCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,job)
local pospriorty=jobCfg.pospriorty
if pospriorty then
for j,w in ipairs(pospriorty)do
if self.disciples[w]==int64.zero then
self.disciples[w]=v
break
end
end
else
for j,w in ipairs(self.disciples)do
if w==int64.zero then
self.disciples[j]=v
break
end
end
end
self:initShowDiscipleList()
end
notifySystem:postNotify(notifyConfig.onMissionDiscipleChanged,self.key,#disciples)
return true
end

function worldTaskBase:subtractTaskDisciple(disciples)



for i,v in ipairs(disciples)do
for j,w in ipairs(self.disciples)do
if w==v then
self.disciples[j]=int64.zero
break
end
end
self:initShowDiscipleList()
end
notifySystem:postNotify(notifyConfig.onMissionDiscipleChanged,self.key,-#disciples)

end

function worldTaskBase:changeTaskDisciplePos(teamList)

local list={}
local count=0
for i,v in ipairs(teamList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
list[tostring(v[2])]=i
count=count+1
end
end
if count~=#self.sortDiscipleList then
return loggerUtil.logErrFMT("派遣弟子阵容改变信息无效（弟子数量[{0},{1}]）",count,#self.sortDiscipleList)
end
for i,v in ipairs(self.sortDiscipleList)do
local key=tostring(v)
if list[key]==nil then
return loggerUtil.logErrFMT("派遣弟子阵容改变信息无效（不存在弟子[{0}]）",key)
end
end
for i=1,#self.disciples do
self.disciples[i]=int64.zero
end
for i,v in pairs(list)do
self.disciples[v]=teamList[v][2]
end
end

function worldTaskBase:initShowDiscipleList()
self.sortDiscipleList={}
for i,v in ipairs(self.disciples)do

if v>int64.zero then
table.insert(self.sortDiscipleList,v)
end
end
table.sort(self.sortDiscipleList,function(a,b)
local fa=UIDiscipleModel:getDiscipleFightValue(a)
local fb=UIDiscipleModel:getDiscipleFightValue(b)
return fa>fb
end)

end

function worldTaskBase:getShowDisciple(index)
return self.sortDiscipleList[index]
end

function worldTaskBase:getShowDiscipleCnt()
return#self.sortDiscipleList
end

function worldTaskBase:getFirstShowDisciple()
return self:getShowDisciple(1)
end

function worldTaskBase:getShowDisciples()
return self.sortDiscipleList
end

function worldTaskBase:getFightPrepareTeamList()
local list={}
for i,v in ipairs(self.disciples)do
if v~=int64.zero then
list[i]=v
end
end
return list
end

function worldTaskBase:getBattleTeamList()
local teamList={}
for i,v in ipairs(self.disciples)do
if v>int64.zero then
table.insert(teamList,{fightPreSelectModel.teamEntityType.dizi,v})
else
table.insert(teamList,{fightPreSelectModel.teamEntityType.empty,int64.zero})
end
end
return teamList
end



function worldTaskBase:__tostring()
return{
self.key,
self.world,
self.startTime,
self.endTime,
self.speed,
tostring(self.destination),
self.target,
self.disciples,
self.mode,
}
end



function worldTaskBase:Serialize()
local data={}

table.insert(data,self.key)
table.insert(data,self.world)
table.insert(data,tonumber(self.startTime))
table.insert(data,math.ceil(tonumber(self.endTime)))
table.insert(data,self.speed*100)
table.insert(data,self.mode)
table.insert(data,math.floor(self.destination.x*100))
table.insert(data,math.floor(self.destination.y*100))
local targetKeys=worldModel:separateUnitKey(self.target)
table.insert(data,tonumber(targetKeys[1]))
table.insert(data,tonumber(targetKeys[2]))
for i=1,5 do
local v=self.disciples[i]
local dh,dl=mathHelper.splitToInt32(v)

table.insert(data,dh)
table.insert(data,dl)
end
table.insert(data,self.zfId)
return data
end




function worldTaskBase.Deserialize(data)
local temp={}
temp.key=data[1]
temp.world=data[2]
temp.startTime=data[3]
temp.endTime=data[4]
temp.speed=data[5]/100
temp.mode=data[6]
temp.destination=Vector2.New(data[7]/100,data[8]/100)
temp.target=worldModel:convertUnitKey({data[9],data[10]})
temp.disciples={}
for i=11,20,2 do

local ld=data[i]or 0
local hd=data[i+1]or 0
local guid=mathHelper.concatToInt64(ld,hd)
table.insert(temp.disciples,guid)
if guid>int64.zero and not UIDiscipleModel:getDiscipleData(guid)then
logErr(FMT.fmt("派遣[{0}]中的弟子[{1}]无法找到数据:{2},",temp.key,tostring(guid),i))
end
end
temp.zfId=data[21]or 0

return worldTaskModel.CreateTask(temp)
end


function worldTaskBase.GE_Time(a,b)
return a>=b or Mathf.Approximately(a,b)
end


function worldTaskBase.LE_Time(a,b)
return a<=b and Mathf.Approximately(a,b)
end


function worldTaskBase.GT_Time(a,b)
return a>b and not Mathf.Approximately(a,b)
end


function worldTaskBase.LT_Time(a,b)
return a<b and not Mathf.Approximately(a,b)
end
