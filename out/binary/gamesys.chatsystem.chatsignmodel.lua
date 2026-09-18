
function chatModel:getSignIcon(id)
local index=cfgHelper.get(cfg_chatflagconfig_get,id,"icon")
return FMT.fmt("icon_chat_flag_{0}",index)
end

function chatModel:setSignList(len,signList,xgCurSign)
signList=signList or{}
self.signList=signList

self.signLookup={}
for index,signInfo in ipairs(self.signList)do
self.signLookup[signInfo.id]=signInfo
end

self.xgCurSign=xgCurSign
end

function chatModel:changeXgCurSign(xgCurFlag)
local oldSign=self.xgCurSign
self.xgCurSign=xgCurFlag

UIManager:invokeUIMethod("UIChatMesgFilterWin","onSelectXianGuanSign",oldSign,self.xgCurSign)
end

function chatModel:getSignXgCurSign()
return self.xgCurSign or 0
end

function chatModel:getSignDataList()
return self.signList or{}
end

function chatModel:getSignList()
local time=timeHelper.getServerShortTime()
local list={}

local group
local isNeedChangeXgSign=false
for i,v in ipairs(self.signList)do
group=cfgHelper.get(cfg_chatflagconfig_get,v.id,"group")
if group==2 then
if v.id==self.xgCurSign then
if v.expireTime==0 or time<v.expireTime then
table.insert(list,v.id)
else
isNeedChangeXgSign=true
end
end
else
if v.expireTime==0 or time<v.expireTime then
table.insert(list,v.id)
end
end
end

if isNeedChangeXgSign then
chatModel:updateXgChatFlag()
if self.xgCurSign>0 then
table.insert(list,self.xgCurSign)
end
end

return list
end


function chatModel:updateXgChatFlag()
if self.xgCurSign>0 then
local time=timeHelper.getServerShortTime()
local xgCurSignInfo=self.signLookup[self.xgCurSign]
if xgCurSignInfo.expireTime~=0 and time>xgCurSignInfo.expireTime then
local group
local sortWidget=0
local changeSign=0
for i,v in ipairs(self.signList)do
group=cfgHelper.get(cfg_chatflagconfig_get,v.id,"group")
if group==2 then
if v.expireTime==0 or time<v.expireTime then
local relevantPram=cfgHelper.get2(cfg_chatflagconfig_get,v.id,'relevantPram')
local cSortWidget=xianguanConfig.getJobSortWidget(relevantPram[1],relevantPram[2])
if cSortWidget>sortWidget then
changeSign=v.id
sortWidget=cSortWidget
end
end
end
end
self.xgCurSign=changeSign
end
end
end