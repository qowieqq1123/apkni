







mailModel={}

mailModel.data={}



function mailModel:init_data()

self.data=
{
mail_list={},
guidlookup={},
preViewItem={},
}

self.sortType=
{
sendTime=0,
expireTime=1
}

self.curSortType=self.sortType.sendTime

self.eMailCount=0










end

function mailModel:get_eMailCount()
if not self.data.mail_list then
self.eMailCount=0
else
self.eMailCount=#self.data.mail_list
end

return self.eMailCount
end

function mailModel:set_sortType(time)
self.curSortType=time
end

function mailModel:get_sortType()

if self.curSortType then
return self.curSortType
else
return self.sortType.sendTime
end
end


function mailModel:sortMail()
table.sort(self.data.mail_list,function(a,b)return(a.time*10000+a.mailId)>(b.time*10000+b.mailId)end)
end


function mailModel:clear_mail_list()
self.data.mail_list={}
end


function mailModel:add_to_mail(mailList)
mailModel:add_mail(mailList)
end


function mailModel:add_to_mail_list(mailList)
for i,v in ipairs(mailList)do
mailModel:add_mail(v)
end
end


function mailModel:get_mail_list()
return self.data.mail_list
end


function mailModel:get_first_mail()
if#self.data.mail_list<=0 then
return
end
return self.data.mail_list[1]
end


function mailModel:get_mail_id_list()
local mailIdList={}
for i,v in ipairs(self.data.mail_list)do
mailIdList[#mailIdList+1]=v.mailId
end
return mailIdList
end


function mailModel:add_mail(mail)
local sortAttachList=function()
local items={}
for i,v in ipairs(mail.attList or{})do
local itemData=nil
local itemId=v.id
if v.data~=0 then

itemData=v.itemData
end

local item={
itemId=itemId,
count=v.num,
type=v.type,

itemData=itemData
}
items[#items+1]=item


mailModel:createItem(mail.mailId,item)
end
return items
end

local mailData=
{
mailId=mail.mailId,

isRead=mail.mailStatus==1,
isPrize=mail.attStatus==1,
time=mail.revTime,
from=mail.sendName,
title=mail.title,
content=mail.content,
expireTime=mail.expireTime,
attNum=mail.attNum,
items=sortAttachList(),
}
self.data.mail_list[#self.data.mail_list+1]=mailData


self:tryUpdateMailExpireTime(mailData)
end


function mailModel:read_mail_list(mailIdList)
for i,mailId in ipairs(mailIdList)do
local index=self:get_mail_index(mailId)
if index then
self.data.mail_list[index].isRead=true
local mailData=self.data.mail_list[index]

self:tryUpdateMailExpireTime(mailData)
end
end
end


function mailModel:prize_mail_list(mailIdList)
for i,mailId in ipairs(mailIdList)do
local index=self:get_mail_index(mailId)
if index then
self.data.mail_list[index].isPrize=true
local mailData=self.data.mail_list[index]

self:tryUpdateMailExpireTime(mailData)
end
end
end


function mailModel:del_mail_list(mailIdList)
for i,mailId in ipairs(mailIdList)do
local index=self:get_mail_index(mailId)



table.remove(self.data.mail_list,index)

self:deleteMailExpireTime(mailId)
end
end


function mailModel:get_mail_index(mailId)
for i,v in pairs(self.data.mail_list)do
if tonumber(tostring(v.mailId))==tonumber(tostring(mailId))then
return i
end
end
end


function mailModel:hasUnread()
for i,v in pairs(self.data.mail_list)do
if v.isRead==false then
return true
end
end
return false
end

function mailModel:checkReddot()
if self.data~=nil then
for i,v in pairs(self.data.mail_list)do
if v.isRead==false then
return true
else
local hasAttach=#v.items>0
if hasAttach and v.isPrize==false then
return true
end
end
end
end
return false
end

function mailModel:getReddotCount()
local reddotCount=0
local glableCfg=cfg_globalconfig_get(1)
local MaxCount=glableCfg.maxmail

if self.data~=nil then
for i,v in pairs(self.data.mail_list)do
if v.isRead==false and i<=MaxCount then
reddotCount=reddotCount+1
else
local hasAttach=#v.items>0

if hasAttach and v.isPrize==false and i<=MaxCount then
reddotCount=reddotCount+1
end
end
end
end
return reddotCount
end


function mailModel:createItem(mailId,item)
local itemid=item.itemId
local itemguid=mailModel:getItemguid(mailId,itemid)
if itemguid then return end
itemguid=itemsModel.getGUID()
mailModel:setItemguid(mailId,itemid,itemguid)
local itemStruct={}
itemStruct.itemguid=itemguid
itemStruct.itemid=itemid
itemStruct.itemcount=item.count
itemStruct.itemflag=0
itemStruct.itemtime=0
itemStruct.itemData=item.itemData
if itemsConfig.isFabao(itemid)then
fabaoHelper.handleItem(itemStruct)
end
self.data.preViewItem[tostring(itemguid)]=itemStruct
end

function mailModel:getItem(itemguid)
return self.data.preViewItem[tostring(itemguid)]
end

function mailModel:setItemguid(mailId,itemid,itemguid)
if not self.data.guidlookup[tostring(mailId)]then
self.data.guidlookup[tostring(mailId)]={}
end
self.data.guidlookup[tostring(mailId)][itemid]=itemguid
end

function mailModel:getItemguid(mailId,itemid)
return self.data.guidlookup[tostring(mailId)]and self.data.guidlookup[tostring(mailId)][itemid]or nil
end



function mailModel:tryUpdateMailExpireTime(mailData)
local mailId=mailData.mailId
if not self.data.mailExpireTimeList then
mailModel:loadMailExpireTimeData()
end
local mailIdStr=tostring(mailId)



if self.data.mailExpireTimeList[mailIdStr]then

return
end


local needExpire=false
local hasItems=mailData.items and next(mailData.items)or false
if hasItems then

needExpire=mailData.isRead and mailData.isPrize
else

needExpire=mailData.isRead
end
if not needExpire then

return
end


local todayZeroTime=timeHelper.getTodayZeroStamp()
local oneDayTime=86400
local expireDayCount=cfgHelper.get2(cfg_globalconfig_get,1,'mailautodelete_client')
if not expireDayCount then

return
end

self.data.mailExpireTimeList[mailIdStr]=todayZeroTime+oneDayTime*expireDayCount
end

function mailModel:loadMailExpireTimeData()
self.data.mailExpireTimeList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eMail,'mailExpireTimeList',{})
end

function mailModel:saveMailExpireTimeData()
if self.data and self.data.mailExpireTimeList then
local mailExpireTimeList=self.data.mailExpireTimeList
userActorArraySetting.set(ACTOR_SETTING_TYPE.eMail,'mailExpireTimeList',mailExpireTimeList)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMail)
end
end


function mailModel:getMailExpireTime(mailId)
if not self.data.mailExpireTimeList then
mailModel:loadMailExpireTimeData()
end

local mailExpireTimeList=self.data.mailExpireTimeList
local mailIdStr=tostring(mailId)
if mailExpireTimeList[mailIdStr]then
return mailExpireTimeList[mailIdStr]
end
return nil
end


function mailModel:checkMailExpireTime(mailId)

local time=0
local glableCfg=cfg_globalconfig_get(1)
local index=self:get_mail_index(mailId)

if not self.data.mail_list[index]then
return false
end

local nowTime=timeHelper.getServerLongTime()
local sengTime=self.data.mail_list[index].time
local expireTime=self.data.mail_list[index].expireTime
sengTime=timeHelper.convertLongStamp(sengTime)

if not expireTime then

return false
end

if expireTime==0 and glableCfg.mailautodelete then
if self.data.mail_list[index].attNum>0 then
time=glableCfg.mailautodelete[2]*86400
else
time=glableCfg.mailautodelete[1]*86400
end
expireTime=time
end

local lerp=nowTime-sengTime
return lerp>=expireTime
end


function mailModel:checkMailExpire(mailId)
local expireTime=mailModel:getMailExpireTime(mailId)
if not expireTime then

return false
end

local nowTime=timeHelper.getServerLongTime()
local lerp=expireTime-nowTime
return lerp<=0
end



function mailModel:deleteMailExpireTime(mailId)
if not self.data.mailExpireTimeList then
mailModel:loadMailExpireTimeData()
end

local mailIdStr=tostring(mailId)
if not self.data.mailExpireTimeList[mailIdStr]then
return
end

self.data.mailExpireTimeList[mailIdStr]=nil
end

