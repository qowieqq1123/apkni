






local _MODULENAME="poetryArenaModel"


def_table(_MODULENAME)
poetryArenaModel.name=_MODULENAME






























poetryArenaModel.data={}




poetryArenaModel.correct={}

function poetryArenaModel:onAppStart()

end


function poetryArenaModel:onEnterState(isReconnect)

end


function poetryArenaModel:onLeaveState(isReconnect)

self:clearArenaData()
end



function poetryArenaModel:setArenaList(list)
self.data={}
if list then
for idx,serverArena in ipairs(list)do
local question=nil
if serverArena.len>0 then
local q=serverArena.curTiMu[1]
local cull=0
if q.pcChoice1>0 then
cull=mathHelper.setbit(cull,q.pcChoice1-1)
end
if q.pcChoice2>0 then
cull=mathHelper.setbit(cull,q.pcChoice2-1)
end
local questionCfg=cfgHelper.get1(cfg_wendouleitaitimuconfig_get,q.id)
local sort1={}
for i,v in pairs(questionCfg.choice)do
table.insert(sort1,i)
end
local sortCnt=#sort1
local sort2={}
for i=1,sortCnt do
local r=math.random(1,#sort1)
local j=table.remove(sort1,r)
table.insert(sort2,j)
end
question={
id=q.id,
index=q.tmIndex,
startTime=q.startTime,
answer=q.answer,
result=q.result,
culls=cull,
sort=sort2,
}
end

local key=tostring(serverArena.ltGuid)
local data={
guid=serverArena.ltGuid,
id=serverArena.ltId,
right=serverArena.rightNum,
disciple=serverArena.dzGuid,
conghui=serverArena.dzSmartVal,
question=question,
percent=nil,
duration=self.calculateDuation(serverArena.dzSmartVal),
valid=true,
started=question~=nil,
}
self.data[key]=data
end


self:checkArenaInit()

self:checkArenaPosition()
else
worldPositionLibrary:checkData(eWorldUnitTpye.POETRYARENA,{})
end
end




function poetryArenaModel:getArenaData(guid)
local key=tostring(guid)
return self.data[key]
end


function poetryArenaModel:clearArenaData()
self.data={}
end

function poetryArenaModel:getAllArenas()
return self.data
end




function poetryArenaModel:setArenaQuestion(guid,serverQuestion,start)
local data=self:getArenaData(guid)
if data and serverQuestion then
local questionCfg=cfgHelper.get1(cfg_wendouleitaitimuconfig_get,serverQuestion.id)
local question={
id=serverQuestion.id,
index=serverQuestion.tmIndex,
startTime=serverQuestion.startTime,
answer=serverQuestion.answer,
result=serverQuestion.result,


}

if start then
local sort1={}
for i,v in pairs(questionCfg.choice)do
table.insert(sort1,i)
end
local sort2={}
local sortCnt=#sort1
for i=1,sortCnt do
local r=math.random(1,#sort1)
local j=table.remove(sort1,r)
table.insert(sort2,j)
end

local cull=0
if serverQuestion.pcChoice1>0 then
cull=mathHelper.setbit(cull,serverQuestion.pcChoice1-1)
end
if serverQuestion.pcChoice2>0 then
cull=mathHelper.setbit(cull,serverQuestion.pcChoice2-1)
end

question.culls=cull
question.sort=sort2
else
question.sort=data.question.sort
question.culls=data.question.culls
question.select=data.question.select
question.intoNext=data.question.intoNext
end

data.question=question
data.started=true

local arenuCfg=cfgHelper.get1(cfg_wendouleitaiconfig_get,data.id)
local total=arenuCfg.tmNum
if serverQuestion.tmIndex>=total then
if serverQuestion.answer>0 then
data.valid=false
end
local now=timeHelper.getServerShortTime()
local pass=now-serverQuestion.startTime
if pass>=data.duration then
data.valid=false
end
end
end
end

function poetryArenaModel:setArenaRight(guid,rightNum)
local data=self:getArenaData(guid)
if data then
data.right=rightNum
end
end

function poetryArenaModel:setArenaPercent(guid,percent)
local data=self:getArenaData(guid)
if data then
data.percent=percent
end
end




function poetryArenaModel:setArenaDisciple(guid,disciple)
local data=self:getArenaData(guid)
if data then
data.disciple=disciple
end
end


function poetryArenaModel:checkArenaInit()
local nowTime=timeHelper.getServerShortTime()
local wait=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"nextWait")
local list={}
for i,v in pairs(self.data)do
local totalNum=cfgHelper.get2(cfg_wendouleitaiconfig_get,v.id,"tmNum")
if v.question then
local interval=wait+v.duration
local delta=nowTime-v.question.startTime
local total=(totalNum-v.question.index+1)*interval-wait
if delta>=total then
v.valid=false
else
local next,time
if v.question.answer then
next=math.ceil((delta-wait)/interval)
time=v.question.startTime+wait+(next-1)*interval
else
next=math.floor(delta/interval)
time=v.question.startTime+next*interval
end
if next>0 then
self:addCorrectSend(v.guid,v.question.index+next,v.conghui,time,v.id)
end
end
else
if v.right==totalNum then
v.valid=false
end
end
end
end


function poetryArenaModel:checkArenaPosition()
local world=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"world")
local guids={}
local havePos={}
local noPos={}
local datas=poetryArenaModel:getAllArenas()
for i,v in pairs(datas)do
table.insert(guids,v.guid)
local posData=worldPositionLibrary:getData(v.guid)
if posData then
local position,block=worldPositionConfig:getPosition(world,{posData.x,posData.z})
if position~=Vector3.zero then
v.flip=posData.flip
v.position=position
v.block=block
havePos[block]=(havePos[block]or 0)+1
else
loggerUtil.logErrFMT("本地存在错误文斗擂台旧坐标数据:{0},({1},{2}),{3}",world,posData.x,posData.z,tostring(v.guid))
worldPositionLibrary:eraseData(v.guid)
table.insert(noPos,v.guid)
end
else
table.insert(noPos,v.guid)
end
end

worldPositionLibrary:checkData(eWorldUnitTpye.POETRYARENA,guids)

local allocation=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"ltNum")
for block,limit in pairs(allocation)do
if#noPos<=0 then
break
end
local have=havePos[block]or 0
for i=have+1,limit do
local guid=table.remove(noPos,1)
local data=self:getArenaData(guid)
local lib=cfgHelper.get3(cfg_wendouleitaibaseconfig_get,1,"posLib",block)
local check,temp=worldPositionLibrary:extract({lib})

if check then
local posData=temp[1]
local x=posData.x
local z=posData.z
local flip=posData.flip
local position,block=worldPositionConfig:getPosition(world,{posData.x,posData.z})
if position~=Vector3.zero then
data.position=position
data.flip=flip
data.block=block
worldPositionLibrary:markData(world,x,z,flip,eWorldUnitTpye.POETRYARENA,guid)
else
loggerUtil.logErrFMT("文斗擂台坐标随机库抽取失败,GUID:{0}",tostring(guid))
data.position=Vector3.zero
data.flip=false
data.block=0
end
else
loggerUtil.logErrFMT("文斗擂台坐标随机库抽取失败,GUID:{0}",tostring(guid))
data.position=Vector3.zero
data.flip=false
data.block=0
end
end
end
for i,v in ipairs(noPos)do
loggerUtil.logErrFMT("文斗擂台坐标随机库抽取失败,GUID:{0}",tostring(v))
local data=self:getArenaData(v)
data.position=Vector3.zero
data.flip=false
data.block=0
end
end




function poetryArenaModel:addCorrectSend(guid,index,conghui,time,id)
table.insert(self.correct,{guid,index,conghui,time,id})
end


function poetryArenaModel:clearCorrectSend()
self.correct={}
end


function poetryArenaModel:getCorrectSend()
return self.correct
end

function poetryArenaModel:convertUnitKey(series)
return worldModel:convertUnitKey({eWorldUnitTpye.POETRYARENA,tostring(series)})
end




function poetryArenaModel.calculateDuation(ch)
if ch<=0 then
return 0
end
local baseCfg=cfgHelper.get1(cfg_wendouleitaibaseconfig_get,1)
local add=0
local fix=baseCfg.dtTimes
for i,v in ipairs(baseCfg.dtAddTime)do
if v[1]<=ch and v[2]>=ch then
add=v[3]
break
end
end
return fix+add
end








function poetryArenaModel:getUnitDataList()
local list={}
local arenas=poetryArenaModel:getAllArenas()
local world=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"world")
for i,v in pairs(arenas)do
if v.valid and worldBlockModel:checkBlockState(world,v.block,eWorldBlockState.OPEN)then
local cfg=cfgHelper.get1(cfg_wendouleitaiconfig_get,v.id)
local data={
name=cfg.name,
icon=cfg.icon,
ing=v.question~=nil,
guid=v.guid,
}
table.insert(list,data)
end
end
return list
end

function poetryArenaModel:refreshUnitData(data)
local area=self:getArenaData(data.guid)
data.ing=area.question~=nil
end

function poetryArenaModel:findAStartArena()
local arenas=poetryArenaModel:getAllArenas()
for i,v in pairs(arenas)do
if v.valid and v.started then
return v
end
end
end

function poetryArenaModel:findAValidArena()
local limit=cfgHelper.get2(cfg_wendouleitaibaseconfig_get,1,"world")
local arenas=poetryArenaModel:getAllArenas()
for i,v in pairs(arenas)do
if v.valid and worldBlockModel:checkBlockState(limit,v.block,eWorldBlockState.OPEN)then
return v
end
end
end