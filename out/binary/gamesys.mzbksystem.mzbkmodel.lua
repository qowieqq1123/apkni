






local _MODULENAME="mzbkModel"


def_table(_MODULENAME)
mzbkModel.name=_MODULENAME
mzbkModel.data={}

function mzbkModel:onAppStart()

end


function mzbkModel:onEnterState(isReconnect)
self:initData()
end


function mzbkModel:onProtocolReq()

end


function mzbkModel:onLeaveState(isReconnect)

self.data={}
end



function mzbkModel:initData()

self.data.activeTequan=0
self.data.dzbkMzItemLookUp={}
end





function mzbkModel:updateActiveTeQuan(tequanState)
self.data.activeTequan=tequanState
end

local _lookupDZBKMzItem=function(mzItemList)
local temp={}
if next(mzItemList)~=nil then
for index,mzItem in ipairs(mzItemList)do
local pos=mzItem.pos
temp[pos]=mzItem
end
end
return temp
end
function mzbkModel:setDiscipleMZBK(dzGuid,len,mzItemList)
if len<=0 then mzItemList={}end
local dzGuidStr=tostring(dzGuid)
self.data.dzbkMzItemLookUp[dzGuidStr]=_lookupDZBKMzItem(mzItemList)
end

function mzbkModel:updateDiscipleMZ(dzGuid,pos,len,mzInfoList)
if len<=0 then mzInfoList={}end
local dzGuidStr=tostring(dzGuid)
local mzitemLookUp=self.data.dzbkMzItemLookUp[dzGuidStr]
if mzitemLookUp==nil then
logErr("操作的弟子秘藏宝库缺失")
return
end

mzitemLookUp[pos]={pos=pos,len=len,mzList=mzInfoList}
end

function mzbkModel:popDiscipleMZ(dzGuid,pos,idx)
local dzGuidStr=tostring(dzGuid)
local mzitemLookUp=self.data.dzbkMzItemLookUp[dzGuidStr]
if mzitemLookUp==nil then
logErr("操作的弟子秘藏宝库缺失")
return
end

local mzInfoList=mzitemLookUp[pos]
if mzInfoList==nil then
logErr(FMT.fmt("操作的弟子秘藏宝库 pos:{0} 缺失",pos))
return
end

if mzInfoList[idx]==nil then
logErr(FMT.fmt("操作的弟子秘藏宝库 pos:{0} idx:{1} 缺失",pos,idx))
return
end

mzInfoList[idx].outFlag=1
end

function mzbkModel:clearDiscipleMZBK(dzGuid)
local dzGuidStr=tostring(dzGuid)
if self.data.dzbkMzItemLookUp[dzGuidStr]then
self.data.dzbkMzItemLookUp[dzGuidStr]=nil
end
end





function mzbkModel:checkActiveTeQuan()
return self.data.activeTequan==1 and systemModel.isOpen(SYSTEM_DEFINE.eMiZangBaoKu)
end


function mzbkModel:getActiveTeQuanState()
if self.data.activeTequan==nil then return false end
return self.data.activeTequan==1
end

function mzbkModel:getDiscipleMZBK(dzGuidStr)
return self.data.dzbkMzItemLookUp[dzGuidStr]
end

function mzbkModel:getDiscipleMZBKInfoByPos(dzGuidStr,pos)
local dzMZBKLookUp=self:getDiscipleMZBK(dzGuidStr)
if dzMZBKLookUp==nil then
logErr("弟子的秘藏宝库数据缺失")
return
end
return dzMZBKLookUp[pos]
end

function mzbkModel:getDiscipleMZBKPosSaveCount(dzGuidStr,pos)
local dzMZBKInfo=self:getDiscipleMZBKInfoByPos(dzGuidStr,pos)

local count=0

if dzMZBKInfo and dzMZBKInfo.len>0 then
for index,info in ipairs(dzMZBKInfo.mzList)do
if info.outFlag==0 then
count=count+1
end
end
end

return count
end

function mzbkModel:getDiscipleMZBKInfoList(dzGuid)
local dzMZBKLookUp=self:getDiscipleMZBK(tostring(dzGuid))
if dzMZBKLookUp==nil then
logErr("弟子密藏宝库缺失")
return defaultT
end

local list={}

for pos=1,6 do
if dzMZBKLookUp[pos]and dzMZBKLookUp[pos].len>0 then
local temp={}
temp.pos=pos
temp.mzbkData=dzMZBKLookUp[pos]
temp.isUnlock=UIDiscipleModel:checkHiddenSkillSlotUnlock(dzGuid,pos)
list[#list+1]=temp
end
end

local varyId=UIDiscipleModel:getDiscipleVarysrid(dzGuid)
if varyId>0 then
local pos=-varyId
if dzMZBKLookUp[pos]and dzMZBKLookUp[pos].len>0 then
local temp={}
temp.pos=pos
temp.mzbkData=dzMZBKLookUp[pos]
temp.isUnlock=UIDiscipleModel:checkDiscipleAssertVary(dzGuid)
list[#list+1]=temp
end
end

return list
end

function mzbkModel:getDiscipleVaryMZBKTypeList(dzGuid)
local dzMZBKLookUp=self:getDiscipleMZBK(tostring(dzGuid))
if dzMZBKLookUp==nil then
logErr("弟子密藏宝库缺失")
return defaultT
end


local temp={}

for index=-1,-5,-1 do
local lookup=dzMZBKLookUp[index]
if(lookup and lookup.len>0)then
temp[#temp+1]=index
end
end

return temp
end

function mzbkModel:getTeQuanFindMoneyDiscount(isVary)
local discount=1
if mzbkModel:checkActiveTeQuan()and not isVary then
discount=mzbkModel:getConfig("findConsumeMoneyDiscount")
end
return discount
end



function mzbkModel:getMZBKPosMaxSaveCount(pos)
return cfgHelper.get3(cfg_mizangbaokubaseconfig_get,1,'saveLimit',pos)
end

function mzbkModel:getConfig(key)
return cfgHelper.get2(cfg_mizangbaokubaseconfig_get,1,key)
end



local _oneTimeReddotKey="mzbk_tq_reddot"
function mzbkModel:getOneTimeReddot()
local reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,_oneTimeReddotKey,0)==0

return reddot and systemModel.isOpen(SYSTEM_DEFINE.eMiZangBaoKu)
end

function mzbkModel:markOneTimeReddot()
userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eOneTimeReddot,_oneTimeReddotKey,1,0)
reddotControl.on_change_catch_type(CATCH_TYPE.eDiscipleSpriteRoot)
end