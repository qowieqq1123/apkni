






local _MODULENAME="jiuchongtianjieGuideModel"


def_table(_MODULENAME)
jiuchongtianjieGuideModel.name=_MODULENAME
jiuchongtianjieGuideModel.data={}


local _askShowActorLimitNum=5


function jiuchongtianjieGuideModel:onAppStart()

end


function jiuchongtianjieGuideModel:onEnterState(isReconnect)
self.data.guideLen=0
self.data.guideList={}

self.data.askLen=0
self.data.askList={}

self.data.helpLen=0
self.data.helpList={}

self.data.view=false
self.data.recv=false



self.data.guideDataDirty=true
self.data.guideActorLen=0
self.data.guideActorList={}
self.data.reqGuidActorListStamp=0

self.data.helpDataDirty=true
self.data.detailHelpLen=0
self.data.detailHelpList={}
self.data.detailHelpLookup={}


self.data.oldHelpList={}
self.data.helpNewFlag=false
end


function jiuchongtianjieGuideModel:onProtocolReq()

end


function jiuchongtianjieGuideModel:onLeaveState(isReconnect)

self.data={}
end



function jiuchongtianjieGuideModel:setInitData(guideLen,guideList,view,recv,askLen,askList,helpLen,helpList)
self.data.guideLen=guideLen
self.data.guideList=guideList

self.data.askLen=askLen
self.data.askList=askList

self.data.helpLen=helpLen
self.data.helpList=helpList

self.data.view=view
self.data.recv=recv

self:checkHelpNewFlag()
end

function jiuchongtianjieGuideModel:setGuideActorInfo(guideLen,guideList)
self.data.guideActorLen=guideLen
self.data.guideActorList=guideList
self.data.reqGuidActorListStamp=timeHelper.getServerShortTime()
self.data.guideDataDirty=true
end

function jiuchongtianjieGuideModel:addAskActor(actorId)
self.data.askLen=self.data.askLen+1
self.data.askList[#self.data.askList+1]=actorId
end

function jiuchongtianjieGuideModel:setDetailHelpList(detailHelpLen,detailHelpList)
self.data.detailHelpLen=detailHelpLen
self.data.detailHelpList=detailHelpList or{}
self.data.helpDataDirty=true

for index,data in ipairs(self.data.detailHelpList)do
self.data.detailHelpLookup[tostring(data.actorid)]=data
end
end

function jiuchongtianjieGuideModel:changeViewState(state)
self.data.view=true
end

function jiuchongtianjieGuideModel:changeRecvState(state)
self.data.recv=true
end

function jiuchongtianjieGuideModel:changeHelpActorHelpState(actorId)
local isIn=false
for index,data in ipairs(self.data.helpList)do
if mathHelper.compareInt64(data.param_1,actorId)then
isIn=true
data.param_2=1
end
end
if not isIn then
local temp={
param_1=actorId,
param_2=1
}
table.insert(self.data.helpList,temp)
self.data.helpLen=self.data.helpLen+1
end
end

function jiuchongtianjieGuideModel:resetAskList()
if not self.data.view then
self.data.askLen=0
self.data.askList={}
end
end

function jiuchongtianjieGuideModel:resetHelpList()
self.data.helpLen=0
self.data.helpList={}
end



function jiuchongtianjieGuideModel:getViewState()
return self.data.view
end


function jiuchongtianjieGuideModel:getRecvState()
return self.data.recv
end


function jiuchongtianjieGuideModel:getGuideActorList()
return self.data.guideActorList,self.data.guideActorLen,self.data.reqGuidActorListStamp
end

function jiuchongtianjieGuideModel:getGuideActorByActorStr(actorStr)
return self.data.guideActorList[actorStr]
end


function jiuchongtianjieGuideModel:getAskList()
return self.data.askList,self.data.askLen
end

function jiuchongtianjieGuideModel:getAskCount()
return self.data.askLen
end


function jiuchongtianjieGuideModel:getGuideList()
return self.data.guideList,self.data.guideLen
end


function jiuchongtianjieGuideModel:getHelpList()
return self.data.helpList,self.data.helpLen
end

function jiuchongtianjieGuideModel:getGuideActorInfo()
return self.data.guideList[1]
end

function jiuchongtianjieGuideModel:getHelpNewFlag()
return self.data.helpNewFlag
end

function jiuchongtianjieGuideModel:changeGuideListDirty()
self.data.guideDataDirty=true
end

function jiuchongtianjieGuideModel:dirtyGuideList()
if self.data.guideDataDirty then
local noXmList={}
local xmList={}

self.data.guidActorList_NoXM=noXmList
self.data.guidActorList_XM=xmList

if self.data.guideActorLen>0 then
for index,data in ipairs(self.data.guideActorList)do
if xianmengModel:checkActorInXM(data.actorid)then
xmList[#xmList+1]=data
else
noXmList[#noXmList+1]=data
end
end
end
self.data.guideDataDirty=false
end
end

function jiuchongtianjieGuideModel:getAskShowGuideActorList(isChange)
self:dirtyGuideList()

isChange=isChange and true
if isChange then
local filterList={}
if self.data.curShowGuidActorList then
filterList=table.weakCopy(self.data.guidActorList_NoXM)
else
local convertFunc=function(data)return tostring(data.actorid)end
for index,data in ipairs(self.data.guideActorList)do
if not table.findValueEx(self.data.curShowGuidActorList,data,convertFunc)then
filterList[#filterList+1]=data
end
end
end

local list={}
self.data.curShowGuidActorList=list
local len=#filterList
for index=1,_askShowActorLimitNum do
local randomIndex=math.random(1,len)
list[index]=table.remove(filterList,randomIndex)
len=len-1
end
end
return self.data.curShowGuidActorList or{}
end

function jiuchongtianjieGuideModel:getAskShowXMGuideActorList()
self:dirtyGuideList()
return self.data.guidActorList_XM
end

function jiuchongtianjieGuideModel:removeCurrentShowGuidActor(actorid)
if self.data.curShowGuidActorList==nil then return end
local pos
for index,data in ipairs(self.data.guideActorList)do
if mathHelper.compareInt64(data.actorid,actorid)then
pos=index
break
end
end
if pos~=nil then
table.remove(self.data.guideActorList,pos)
pos=nil
self:changeGuideListDirty()
self:dirtyGuideList()
end


for index,data in ipairs(self.data.curShowGuidActorList)do
if mathHelper.compareInt64(data.actorid,actorid)then
pos=index
break
end
end

if pos~=nil then
table.remove(self.data.curShowGuidActorList,pos)
if#self.data.guideActorList==0 then
self:getAskShowGuideActorList()
end
pos=nil
end

UIManager:invokeUIMethod("UIXianJieJieYin_AskWin","refreshRight")
end


function jiuchongtianjieGuideModel:changeHelpListDirty()
self.data.helpDataDirty=true
end

function jiuchongtianjieGuideModel:dirtyHelpList()
if self.data.helpDataDirty then
local noXmList={}
local xmList={}

self.data.helpActorList_NoXM=noXmList
self.data.helpActorList_XM=xmList

for index,data in ipairs(self.data.detailHelpList)do
if xianmengModel:checkActorInXM(data.actorid)then
xmList[#xmList+1]=data
else
noXmList[#noXmList+1]=data
end
end
self.data.helpDataDirty=false
end
end

function jiuchongtianjieGuideModel:getShowHelpActorList()
self:dirtyHelpList()
return self.data.detailHelpList
end

function jiuchongtianjieGuideModel:getXmHelpActorList()
self:dirtyHelpList()
return self.data.helpActorList_XM
end

function jiuchongtianjieGuideModel:checkHelpNewFlag()
self.data.helpNewFlag=false
if self.data.helpLen>0 then
if#self.data.oldHelpList<=0 then
self.data.helpNewFlag=true
else
for _,data in ipairs(self.data.helpList)do
local index=table.findValueEx(self.data.oldHelpList,data,function(val)
return tostring(val.param_1)
end)
if index==nil then
self.data.helpNewFlag=true
break
end
end
end
self.data.oldHelpList=self.data.helpList
end
end

function jiuchongtianjieGuideModel:removeHelpActor(actorid)
local pos
for index,data in ipairs(self.data.detailHelpList)do
if mathHelper.compareInt64(data.actorid,actorid)then
pos=index
break
end
end

if pos~=nil then
table.remove(self.data.detailHelpList,pos)
self:changeHelpListDirty()
self:dirtyHelpList()
end

UIManager:invokeUIMethod("UIXianJieJieYin_SupportWin","refreshRight")
jiuchongtianjieGuideController:freshXianJieJieYinInfo()
end


