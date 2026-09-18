






local _MODULENAME="fightUpRemindModel"




def_table(_MODULENAME)
fightUpRemindModel.name=_MODULENAME
fightUpRemindModel.data={}

function fightUpRemindModel:onAppStart()

end


function fightUpRemindModel:onEnterState()
self.fightData={}
self.aniData={}
self.zongmenData={}
self.zongmenTop15Data={}
self.diziData={}
self.lingshouData={}
self.frdData={}
end


function fightUpRemindModel:onLeaveState()

self.fightData={}
self.aniData={}
self.zongmenData={}
self.zongmenTop15Data={}
self.diziData={}
self.lingshouData={}
self.frdData={}
end

function fightUpRemindModel:setFightVal(oldVal,newVal)
self.fightData.oldVal=oldVal
self.fightData.newVal=newVal
end

function fightUpRemindModel:getFightVal(isClear)
local oldVal=self.fightData.oldVal
local newVal=self.fightData.newVal
if isClear then
self.fightData={}
end
return oldVal,newVal
end

function fightUpRemindModel:clearFight()
self.fightData={}
end



function fightUpRemindModel:setZongmenFightVal(oldVal,newVal)
if self.zongmenData.oldVal then
self.zongmenData.oldVal=oldVal<self.zongmenData.oldVal and oldVal or self.zongmenData.oldVal
else
self.zongmenData.oldVal=oldVal
end
if self.zongmenData.newVal then
self.zongmenData.newVal=newVal>self.zongmenData.newVal and newVal or self.zongmenData.newVal
else
self.zongmenData.newVal=newVal
end
end

function fightUpRemindModel:getZongmenFightVal(isClear)
local oldVal=self.zongmenData.oldVal
local newVal=self.zongmenData.newVal
if isClear then
self.zongmenData={}
end
return oldVal,newVal
end

function fightUpRemindModel:clearZongmenFight()
self.zongmenData={}
end

function fightUpRemindModel:setZongmenTop15FightVal(oldVal,newVal)
if self.zongmenTop15Data.oldVal then
self.zongmenTop15Data.oldVal=oldVal<self.zongmenTop15Data.oldVal and oldVal or self.zongmenTop15Data.oldVal
else
self.zongmenTop15Data.oldVal=oldVal
end
if self.zongmenTop15Data.newVal then
self.zongmenTop15Data.newVal=newVal>self.zongmenTop15Data.newVal and newVal or self.zongmenTop15Data.newVal
else
self.zongmenTop15Data.newVal=newVal
end
end

function fightUpRemindModel:getZongmenTop15FightVal(isClear)
local oldVal=self.zongmenTop15Data.oldVal
local newVal=self.zongmenTop15Data.newVal
if isClear then
self.zongmenTop15Data={}
end
return oldVal,newVal
end

function fightUpRemindModel:checkZongmenTop15FightValChanged()
local oldVal=self.zongmenTop15Data.oldVal or 0
local newVal=self.zongmenTop15Data.newVal or 0
return newVal>oldVal
end

function fightUpRemindModel:clearZongmenTop15Fight()
self.zongmenTop15Data={}
end


function fightUpRemindModel:setAniVal(diziguid,typo,oldVal,newVal)
local guidStr=tostring(diziguid)
if self.aniData[guidStr]==nil then self.aniData[guidStr]={}end
if self.aniData[guidStr][typo]==nil then self.aniData[guidStr][typo]={}end
local data=self.aniData[guidStr][typo]
if data.oldVal then
data.oldVal=oldVal<data.oldVal and oldVal or data.oldVal
else
data.oldVal=oldVal
end
if data.newVal then
data.newVal=newVal>data.newVal and newVal or data.newVal
else
data.newVal=newVal
end
end

function fightUpRemindModel:getAniVal(diziguid,typo,isClear)
local guidStr=tostring(diziguid)
if self.aniData[guidStr]==nil then return end
if self.aniData[guidStr][typo]==nil then return end
local data=self.aniData[guidStr][typo]
local oldVal=data.oldVal
local newVal=data.newVal
if isClear then
self.aniData[guidStr][typo]=nil
end
return oldVal,newVal
end

function fightUpRemindModel:clearAniVal(diziguid,typo)
local guidStr=tostring(diziguid)
if self.aniData[guidStr]==nil then return end
self.aniData[guidStr][typo]=nil
end



function fightUpRemindModel:setDiziFight(diziguid,oldVal,newVal)
local guidStr=tostring(diziguid)
if self.diziData[guidStr]==nil then self.diziData[guidStr]={}end
local data=self.diziData[guidStr]
if data.oldVal then
data.oldVal=oldVal<data.oldVal and oldVal or data.oldVal
else
data.oldVal=oldVal
end
if data.newVal then
data.newVal=newVal>data.newVal and newVal or data.newVal
else
data.newVal=newVal
end
if UIDiscipleModel:isShuWuDiscipleEx(diziguid)then
local old=UIDiscipleModel:getShuWuLastFightValue(diziguid)
local new=UIDiscipleModel:getShuWuFightValue(diziguid)
if old>=0 and old<new then
UIDiscipleModel:recordShuWuLastFightValue(diziguid)
data.newVal=new
data.oldVal=old
data.source=1
end
end
end

function fightUpRemindModel:getDiziFight(diziguid,isClear)
local guidStr=tostring(diziguid)
if self.diziData[guidStr]==nil then return end
local oldVal=self.diziData[guidStr].oldVal
local newVal=self.diziData[guidStr].newVal
if isClear then
self.diziData[guidStr]=nil
end
return oldVal,newVal
end

function fightUpRemindModel:clearDiziFight(diziguid)
local guidStr=tostring(diziguid)
self.diziData[guidStr]=nil
end



function fightUpRemindModel:setLingShouFight(guid,oldVal,newVal)
local guidStr=tostring(guid)
if self.lingshouData[guidStr]==nil then self.lingshouData[guidStr]={}end
local data=self.lingshouData[guidStr]
if data.oldVal then
data.oldVal=oldVal<data.oldVal and oldVal or data.oldVal
else
data.oldVal=oldVal
end
if data.newVal then
data.newVal=newVal>data.newVal and newVal or data.newVal
else
data.newVal=newVal
end
end

function fightUpRemindModel:getLingShouFight(guid,isClear)
local guidStr=tostring(guid)
if self.lingshouData[guidStr]==nil then return end
local oldVal=self.lingshouData[guidStr].oldVal
local newVal=self.lingshouData[guidStr].newVal
if isClear then
self.lingshouData[guidStr]=nil
end
return oldVal,newVal
end

function fightUpRemindModel:clearLingShouFight(guid)
local guidStr=tostring(guid)
self.lingshouData[guidStr]=nil
end



function fightUpRemindModel:setFrdFight(oldVal,newVal)
self.frdData[#self.frdData+1]={oldVal=oldVal,newVal=newVal,source=2}
end



function fightUpRemindModel:getCurrentFightList(clear)
local list={}
local oldVal,newVal=fightUpRemindModel:getZongmenFightVal(clear)
if oldVal and newVal then
list[#list+1]={oldVal=oldVal,newVal=newVal,source=3}
end

for guidStr,v in pairs(self.diziData)do
if v then
local oldVal=v.oldVal
local newVal=v.newVal
local source=v.source
if oldVal and newVal then
list[#list+1]={oldVal=oldVal,newVal=newVal,source=source}
end
end
end
for guidStr,v in pairs(self.lingshouData)do
if v then
local oldVal=v.oldVal
local newVal=v.newVal
if oldVal and newVal then
list[#list+1]={oldVal=oldVal,newVal=newVal}
end
end
end

for i,v in pairs(self.frdData)do
if v then
list[#list+1]=v
end
end

if clear then
self.diziData={}
self.lingshouData={}
self.frdData={}
end
return list
end