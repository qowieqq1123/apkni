






local _MODULENAME="xianMengBaoXiangModel"


def_table(_MODULENAME)
xianMengBaoXiangModel.name=_MODULENAME
xianMengBaoXiangModel.data={}

function xianMengBaoXiangModel:onAppStart()

end


function xianMengBaoXiangModel:onEnterState(isReconnect)

end


function xianMengBaoXiangModel:onProtocolReq()

end


function xianMengBaoXiangModel:onLeaveState(isReconnect)

self.data={}
end



function xianMengBaoXiangModel:getItemTag(itemId)
local config=itemsConfig.getConfig(itemId)
if config and config.funcparam then
return config.funcparam.tag
end
return nil
end


function xianMengBaoXiangModel:setBoxList(list)
self.data.boxList=list
self.data.boxList1={}
self.data.boxList2={}
for k,v in ipairs(list)do
local tag=xianMengBaoXiangModel:getItemTag(v.itemId)
local flag=self:getEndLeftTime(v.expireTime)
if tag==1 then
if not flag then table.insert(self.data.boxList1,v)end
elseif tag==2 then
if not flag then table.insert(self.data.boxList2,v)end
end
end
end


function xianMengBaoXiangModel:getBoxList(tag)
if tag==1 then
return self.data.boxList1 or{}
elseif tag==2 then
return self.data.boxList2 or{}
else
return self.data.boxList or{}
end
end

function xianMengBaoXiangModel:setReceiveState(guid)
local itemId
if self.data.boxList and next(self.data.boxList)then
for k,v in ipairs(self.data.boxList)do
if v.guid==guid then
v.rwFlag=1
itemId=v.itemid
break
end
end
end

if itemId then
local tag=xianMengBaoXiangModel:getItemTag(itemId)
if tag==1 then
if self.data.boxList1 and next(self.data.boxList1)then
for k,v in ipairs(self.data.boxList1)do
if v.guid==guid then
v.rwFlag=1
break
end
end
end
elseif tag==2 then
if self.data.boxList2 and next(self.data.boxList2)then
for k,v in ipairs(self.data.boxList2)do
if v.guid==guid then
v.rwFlag=1
break
end
end
end
end
end

UIManager:invokeUIMethod('UIXMZengLiWin','refreshWin')
end


function xianMengBaoXiangModel:setReceiveNum(value)
self.data.receiveNum=value
end


function xianMengBaoXiangModel:getReceiveNum()
return self.data.receiveNum or 0
end


function xianMengBaoXiangModel:setNMFlag(value)
self.data.nmFlag=value
end


function xianMengBaoXiangModel:getNMFlag()
return self.data.nmFlag or 0
end


function xianMengBaoXiangModel:getEndLeftTime(expireTime)
local curTime=gameUtilityModel.getServerShortTime()
if curTime>=expireTime then
return true,0
else
return false,expireTime-curTime
end
end

function xianMengBaoXiangModel:getGiftReddot(index)
local list
if index==0 then
list=self.data.boxList
elseif index==1 then
list=self.data.boxList1
elseif index==2 then
list=self.data.boxList2
end

if list then
for k,v in ipairs(list)do
if v.rwFlag==0 then
if index==0 or index==2 then
local tag=xianMengBaoXiangModel:getItemTag(v.itemId)
local max=cfg_guildboxbaseconfig_get(1).dayMax or 10
if tag==2 and self.data.receiveNum<max then
return true
elseif tag==1 then
return true
end
else
return true
end
end
end
end

return false
end