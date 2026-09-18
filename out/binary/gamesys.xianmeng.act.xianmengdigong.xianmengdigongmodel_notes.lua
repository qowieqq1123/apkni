







local getGoodsStr=function(data)
local str=''
if data~=nil and#data>0 then
local c=#data
for i,v in ipairs(data)do
local itemcfg=itemsConfig.getConfig(v[1])
local s=FMT.fmt('{0}*{1}',itemcfg.name,v[2])
s=FMT.cfmt(itemcfg.color,s)
if i<c then
str=FMT.fmt('{0}{1}、',str,s)
else
str=FMT.fmt('{0}{1}',str,s)
end
end
end
return str
end

local getEventsStr=function(x,y)
local str=''
local room=xianmengdigongModel:getRoom2(x,y)
if room then
local events=room:getEvents()
local c=#events
if events and#events>0 then
for i,event in ipairs(events)do
local e_id=event.eventId
local name=cfgHelper.get2(cfg_guilddigongeventconfig_get,event.eventId,'title')
if i<c then
str=FMT.fmt('{0}【{1}】、',str,name)
else
str=FMT.fmt('{0}【{1}】',str,name)
end
end
end
end
return str
end

local getEventsStr2=function(x,y)
local str=''
local str2=''
local room=xianmengdigongModel:getRoom2(x,y)
if room then
local events=room:getEvents()
if events and#events>0 then
for i,event in ipairs(events)do
if not event:isLimitEvent()then
local e_id=event.eventId
local name=cfgHelper.get2(cfg_guilddigongeventconfig_get,event.eventId,'title')
if i==1 then
str=FMT.fmt('{0}【{1}】',str,name)
else
str=FMT.fmt('{0}、【{1}】',str,name)
end
end
end
for i,event in ipairs(events)do
if event:isLimitEvent()then
local e_id=event.eventId
local name=cfgHelper.get2(cfg_guilddigongeventconfig_get,event.eventId,'title')
if i==1 then
str2=FMT.fmt('{0}【{1}】',str2,name)
else
str2=FMT.fmt('{0}、【{1}】',str2,name)
end
end
end
end
end
return str,str2
end

local getBossName=function(x,y)
local str=''
local room=xianmengdigongModel:getRoom2(x,y)
if room then
local boss=cfgHelper.get2(cfg_guilddigongyaoshouconfig_get,room.ysConfId,'boss')
if boss then
local groupid=boss[1]
str=cfgHelper.get2(cfg_monstergroup_get,groupid,'name')
end
end
return str
end

local getDZNames=function(names)
local str=''
if names and#names>0 then
local c=#names
local ismulti=c>3
if c>3 then c=3 end
for i=1,c do
local name=names[i]
if i==1 then
str=FMT.fmt('{0}【{1}】',str,name)
else
str=FMT.fmt('{0}、【{1}】',str,name)
end
end
if ismulti then
str=FMT.fmt('{0}等盟员',str)
end
end
return str
end

local getFengXianDesc=function(eventId)
local str=''
local fxResult=cfgHelper.get2(cfg_guilddigongeventconfig_get,eventId,'fxResult')
if fxResult and#fxResult>0 then
for i,v in ipairs(fxResult)do
local s=''
if v[1]==1 then
s=eSpecialAttrName:getDesc(v[2],v[3])
elseif v[1]==2 then
for i2,v2 in ipairs(v[2])do
local ss=UIDiscipleModel:getSpecialityName(DISCIPLE_SPECIALITY_TYPE.eStrange,v2,true)
if i2==1 then
s=FMT.fmt('获得怪癖{1}',s,ss)
else
s=FMT.fmt('{0}、获得怪癖{1}',s,ss)
end
end
elseif v[1]==3 then
s=FMT.fmt('扣除血量{0}%',v[2]/100)
end
if i==1 then
str=FMT.fmt('{0}{1}',str,s)
else
str=FMT.fmt('{0}、{1}',str,s)
end
end
end
return str
end

local noteFuncLookup={

[1]=function(note,data)
local mons_name=cfgHelper.get2(cfg_monstergroup_get,data[2],'name')
local str=FMT.fmt(note.msgFormat,data[1],mons_name,data[3])
return str
end,
[2]=function(note,data)
local mons_name=cfgHelper.get2(cfg_monstergroup_get,data[2],'name')
local str=FMT.fmt(note.msgFormat,data[1],mons_name)
return str
end,
[3]=function(note,data)
local goods_str=getGoodsStr(data)
local events_str=getEventsStr(note.x,note.y)
local str=FMT.fmt(note.msgFormat,goods_str,events_str)
return str
end,
[4]=function(note,data)
local mons_name=cfgHelper.get2(cfg_monstergroup_get,data[2],'name')
local str=FMT.fmt(note.msgFormat,data[1],mons_name,data[3]/100)
return str
end,
[5]=function(note,data)
local mons_name=getBossName(note.x,note.y)
local goods_str=getGoodsStr(data)
local events_str,events_str2=getEventsStr2(note.x,note.y)
local str=FMT.fmt(note.msgFormat,mons_name,goods_str,events_str,events_str2)
return str
end,
[6]=function(note,data)
local names_str=getDZNames(data[1])
local event_name=cfgHelper.get2(cfg_guilddigongeventconfig_get,data[2],'title')
local goods_str=getGoodsStr(data[3])
local str=FMT.fmt(note.msgFormat,names_str,event_name,goods_str)
return str
end,
[7]=function(note,data)
local goods_str=getGoodsStr(data[2])
local str=FMT.fmt(note.msgFormat,data[1],goods_str)
return str
end,
[8]=function(note,data)
local goods_str=getGoodsStr(data[2])
local str=FMT.fmt(note.msgFormat,data[1],goods_str)
return str
end,
[9]=function(note,data)
local fxDesc_str=getFengXianDesc(data[1])
local guid=data[2]
local playerName=playerModel:getActorName()
local discipleName=UIDiscipleModel:getDiscipleName(guid)
if not discipleName then return end
local str=FMT.fmt(note.msgFormat,playerName,discipleName,fxDesc_str)
return str
end,
[10]=function(note,data)
return note.msgFormat
end,
[11]=function(note,data)
local event_name=cfgHelper.get2(cfg_guilddigongeventconfig_get,data[1],'title')
local str=FMT.fmt(note.msgFormat,event_name)
return str
end,
[12]=function(note,data)
local str=FMT.fmt(note.msgFormat,data[1])
return str
end,
[13]=function(note,data)
local failHP=cfgHelper.get2(cfg_guilddigongeventconfig_get,data[3],'failHP')
local str=FMT.fmt(note.msgFormat,data[1],data[2],failHP/100)
return str
end,
[14]=function(note,data)
local event_name=cfgHelper.get2(cfg_guilddigongeventconfig_get,data[1],'title')
local str=FMT.fmt(note.msgFormat,event_name)
return str
end,
[15]=function(note,data)
local mons_name=getBossName(note.x,note.y)
local goods_str=getGoodsStr(data)
local events_str=getEventsStr(note.x,note.y)
local str=FMT.fmt(note.msgFormat,mons_name,goods_str,events_str)
return str
end,
[16]=function(note,data)
local str=FMT.fmt(note.msgFormat,data[1])
return str
end,
}

local noteReddotFuncLookup={
[16]=function(note,data)
local room=xianmengdigongModel:getRoom2(note.x,note.y)
if room then
return room:hasRankReward()
end
return false
end,
}

function xianmengdigongModel:getDGNoteDesc(note,data)
local func=noteFuncLookup[note.msgId]
return func(note,data)
end

function xianmengdigongModel:getDGNoteReddot(note)
local func=noteReddotFuncLookup[note.msgId]
if func then
return func(note)
end
return false
end

function xianmengdigongModel:getAllDGNoteReddot()
local data=self.data
if data and data.dgNotesList then
for i=#data.dgNotesList,1,-1 do
if xianmengdigongModel:getDGNoteReddot(data.dgNotesList[i])then
return true
end
end
end
return false
end

function xianmengdigongModel:initDGNotes(loglist)
local dgNotesList={}
if loglist then
for i,note in ipairs(loglist)do
xianmengdigongModel:initDGNote(note)
table.insert(dgNotesList,note)
end
end
self.data.dgNotesList=dgNotesList
end

function xianmengdigongModel:setDGNotesNew(loglist)
if loglist==nil then return end
local data=self.data
if data then
if data.dgNotesList==nil then
data.dgNotesList={}
end
if#loglist>0 then
for i,note in ipairs(loglist)do
local checkDesc=xianmengdigongModel:initDGNote(note)
if checkDesc then
table.insert(data.dgNotesList,note)
end
end
data.showNoteIndex=#data.dgNotesList
end
end
end

function xianmengdigongModel:initDGNote(note)
local cfg=cfgHelper.get1(cfg_guilddigongmsgformatconfig_get,note.msgId)
note.showgo=cfg.showgo
note.msgFormat=cfg.msgFormat
note.icon=cfg.icon

local data
if note.jsonMsg then
data=jsonHelper.decode(note.jsonMsg)
end
local desc=xianmengdigongModel:getDGNoteDesc(note,data)
if not desc then
return false
end
note.desc=desc


note.jump=function(self_)
if self_.showgo then
local room=xianmengdigongModel:getRoom2(self_.x,self_.y)
if room then
local eventList=room:getEvents_doing_idle()
if#eventList>0 then
return xianmengdigongController:jump(self_.x,self_.y)
end
if room:hasRankReward()then
return xianmengdigongController:jump(self_.x,self_.y)
end
end
end
return false
end
note.canGo=function(self_)
if self_.showgo then
local room=xianmengdigongModel:getRoom2(self_.x,self_.y)
if room then
local eventList=room:getEvents_doing_idle()
if#eventList>0 then
return true
end
if room:hasRankReward()then
return true
end
end
end
return false
end

return true
end

function xianmengdigongModel:getDGNotes()
local list={}
local data=self.data
if data and data.dgNotesList then
for i=#data.dgNotesList,1,-1 do
list[#list+1]=data.dgNotesList[i]
end
end
return list
end

function xianmengdigongModel:getDGOneNoteStr()
local data=self.data
if data and data.dgNotesList then
local c=#data.dgNotesList
if c>0 then
if data.showNoteIndex==nil or data.showNoteIndex>c or data.showNoteIndex<=0
or data.showNoteIndex<c-5 then
data.showNoteIndex=c
end
local note=data.dgNotesList[data.showNoteIndex]
data.showNoteIndex=data.showNoteIndex-1
return note.desc
end
end
end

function xianmengdigongModel:checkOpenNote()
local data=self.data
if data~=nil then
local needNew=false
if data.dgNotesList==nil then
needNew=true
xianmengdigongController:send_20_111()
end
return needNew
end
end