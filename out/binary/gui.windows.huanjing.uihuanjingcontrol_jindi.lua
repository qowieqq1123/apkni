local _jdCondition={
[1]=
{
getTips=function(value)
return UIHuanJingControl:getLevelName("完成后山试炼",value)
end,
getValue=function()
return UIHuanJingControl:getCurrentLevel()
end,
}
}

local _checkDialog={

[1]=function(id,guid,callback)
local level=UIDiscipleModel:getDiscipleJJLevel(guid)
if UIDiscipleModel:checkJJLevelFull(level)or
(UIDiscipleModel:isDiscipleJJLevelWillChange(guid)and UIDiscipleModel:checkNextJJNeedBroke(level)and UIDiscipleModel:checkJJBrokeByHand(level))then
local show_data={
type='UIDialouge',
title='提示',
content="弟子修为值已达圆满，进入禁地历练将不能再获得修为值增长，确定要派遣此弟子吗？",
oktext='确定',
canceltext='取消',
okcallback=callback,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

return false
end
return true
end,

[2]=function(id,guid,callback)
local level=UIDiscipleModel:getDiscipleLTLevel(guid)
if UIDiscipleModel.checkLTFull(level)or UIDiscipleModel:checkDiscipleLTNeedBroke(guid)then
local show_data={
type='UIDialouge',
title='提示',
content="弟子炼体经验已达圆满，进入禁地历练将不能再获得炼体经验增长，确定要派遣此弟子吗？",
oktext='确定',
canceltext='取消',
okcallback=callback,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

return false
end
return true
end,
[3]=function(id,guid,callback)
local jjRateList=UIDiscipleModel:getDuJieDanRate(guid)
local cfg=cfgHelper.get1(cfg_backmountainareaconfig_get,id)
if jjRateList[4]and jjRateList[4]>0 then
local show_data={
type='UIDialouge',
title='提示',
content=FMT.fmt("弟子已在{0}中测算天命，再次进入无法再增加渡劫成功率，确定要派遣此弟子吗？",cfg.name),
oktext='确定',
canceltext='取消',
okcallback=callback,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

return false
end
return true
end,
[4]=function(id,guid,callback)
local levelCfg=cfgHelper.getdef1(cfg_discipleproskillconfig,"exp")
local maxLv=#levelCfg
for i,v in pairs(DISCIPLE_PROSKILL_TYPE)do
local data=UIDiscipleModel:getDiscipleJobData(guid,v)
if data.level<maxLv then
return true
end
end

local show_data={
type='UIDialouge',
title='提示',
content="弟子所有专业技能经验已满，进入禁地历练将不能再获得专业技能经验增长，确定要派遣此弟子吗？",
oktext='确定',
canceltext='取消',
okcallback=callback,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
end,
}


local _discipleChange={
[eDiscipleChangeType.eGongFaLvUp]=function(datas)
local result={}
for i,v in ipairs(datas)do
local name=cfgHelper.get2(cfg_disciplegongfaconfig_get,v[1],'name')
local temp={
name=FMT.fmt("{0}：",name),
showType=1,
sort=2,
current=v[3],
previous=v[2],
}
table.insert(result,temp)
end
return result
end,
[eDiscipleChangeType.eInjuryChange]=function(datas)
local o=datas[1][1]
local n=datas[#datas][2]
local result={
name="负伤值：",
showType=1,
sort=2,
current=FMT.fmt("{0}({1})",n,eInjuryType:getName(n)),
previous=o,
}
return{result}
end,
[eDiscipleChangeType.eShouYuan]=function(datas)
local o=datas[1][1]
local n=datas[#datas][2]
local delta=n-o
local result={
name=delta>0 and"获得寿元："or"损失寿元：",
showType=1,
sort=2,
current=math.abs(delta),
}
return{result}
end,
[eDiscipleChangeType.eJobExpChange]=function(datas)
local explist=cfgHelper.getdef1(cfg_discipleproskillconfig,'exp')
local result={}
for i,v in ipairs(datas)do
local jobName=cfgHelper.get2(cfg_discipleproskillconfig_get,v[1],"name")
if v[2]~=v[3]then
local sum=explist[v[2]]-v[4]
for j=v[2]+1,v[3]-1 do
local max=explist[j]
sum=sum+max
end
sum=sum+v[5]
table.insert(result,{
name=FMT.fmt("{0}经验：",jobName),
showType=1,
sort=1,
current=FMT.fmt("+{0}",sum),
})
table.insert(result,{
name=FMT.fmt("{0}等级：",jobName),
showType=1,
sort=2,
current=v[3],
previous=v[2],
})
else
local sum=v[5]-v[4]
table.insert(result,{
name=FMT.fmt("{0}经验：",jobName),
showType=1,
sort=1,
current=FMT.fmt("+{0}",sum),
})
end
end
return result
end,
[eDiscipleChangeType.eSpeciality]=function(datas)
local specialitytype=datas[1][1]
local specialityid=datas[1][2]
local updatetype=datas[1][3]
local typeName=cfgHelper.get2(cfg_disciplespecialitytypeconfig_get,specialitytype,"name")
local result={
name=updatetype==0 and FMT.fmt("解除{0}：",typeName)or FMT.fmt("获得{0}：",typeName),
showType=2,
sort=3,
special={specialitytype,specialityid},
}
return{result}
end,
[eDiscipleChangeType.eSixAttr]=function(datas)
local result={}
for i,v in pairs(datas)do
local name=UIDiscipleModel:discipleBaseAttrName(v[1])
table.insert(result,{
name=FMT.fmt("{0}：",name),
showType=1,
sort=2,
current=v[3],
previous=v[2],
})
end
return result
end,
[eDiscipleChangeType.eJJRate2]=function(datas)
local oldlist=datas[1][1]
local curlist=datas[#datas][2]

local oldval=oldlist[4]or 0
local newval=curlist[4]or 0
oldval=Mathf.Clamp(oldval,0,100)
newval=Mathf.Clamp(newval,0,100)
if oldval~=newval then
local result={
name="突破成功率：",
showType=1,
sort=2,
current=FMT.fmt("+{0}%",newval-oldval)

}
return{result}
end
end,
[eDiscipleChangeType.eJingJieChange]=function(datas)
local old_jjlv=datas[1][1]
local jingjielv=datas[#datas][2]
local old_jjexp=datas[1][3]
local jingjieexp=datas[#datas][4]

if old_jjlv<jingjielv then
local sum=cfgHelper.get2(cfg_disciplejingjieconfig_get,old_jjlv,"exp")-old_jjexp
for i=old_jjlv+1,jingjielv-1 do
sum=sum+cfgHelper.get2(cfg_disciplejingjieconfig_get,i,"exp")
end
sum=sum+jingjieexp

return{{
name="获得修为：",
showType=1,
sort=1,
current=mathHelper.formatNumber2(sum),
},
{
name="境界：",
showType=1,
sort=2,
current=jingjielv,
previous=old_jjlv,
}}
elseif old_jjlv==jingjielv then
local sum=jingjieexp-old_jjexp
if sum>0 then
return{{
name="获得修为：",
showType=1,
sort=2,
current=mathHelper.formatNumber2(sum),
}}
end
end
end,
[eDiscipleChangeType.eLianTiChange]=function(datas)
local old_lv=datas[1][1]
local liantilv=datas[#datas][2]
local old_exp=datas[1][3]
local liantiexp=datas[#datas][4]

if old_lv~=liantilv then
local sum=cfgHelper.get2(cfg_disciplelianticonfig_get,old_lv,"exp")-old_exp
for i=old_lv+1,liantilv-1 do
sum=sum+cfgHelper.get2(cfg_disciplelianticonfig_get,i,"exp")
end
sum=sum+liantiexp

return{{
name="炼体经验：",
showType=1,
sort=1,
current=mathHelper.formatNumber2(sum),
},
{
name="炼体等级：",
showType=1,
sort=2,
current=liantilv,
previous=old_lv,
}}
else
local sum=liantiexp-old_exp

local cfg=cfgHelper.get1(cfg_disciplelianticonfig_get,liantilv)
while liantiexp>cfg.exp and cfg.consume==nil do
liantilv=liantilv+1
liantiexp=liantiexp-cfg.exp
cfg=cfgHelper.get1(cfg_disciplelianticonfig_get,liantilv)
end

local temp={{
name="炼体经验：",
showType=1,
sort=1,
current=mathHelper.formatNumber2(sum),
}}
if liantilv~=old_lv then
table.insert(temp,{
name="炼体等级：",
showType=1,
sort=2,
current=liantilv,
previous=old_lv,
})
end
return temp
end
end,
}


function UIHuanJingControl:send_25_12(id,disciples)
socketManager:send_25_12(id,#disciples,disciples)
end


function UIHuanJingControl:send_25_14(id,if_add)
socketManager:send_25_14(id,if_add)
end


function UIHuanJingControl.recv_25_11(len,list)
UIHuanJingControl:setJDDatas(list or{})
UIManager:invokeUIMethod("UIHuanJingJinDiWin","refreshView")
end


function UIHuanJingControl.recv_25_12(id,len,list)
UIHuanJingControl:setWaitTeZhiData(id,list)
end


function UIHuanJingControl.recv_25_14(id,if_add)
UIHuanJingControl:delWaitTeZhiData(id)
end

function UIHuanJingControl.onNewMonth(isLogin)


for i,v in pairs(UIHuanJingControl.data.jdData)do
v.count=0
end
UIManager:invokeUIMethod("UIHuanJingJinDiWin","refreshView")

end

function UIHuanJingControl.onShowDiscipleChanged(effectType,temp,effectData)
if effectType==ePrizeType.eHouShanJinDi then
local id=effectData.back_mountain_id
local time=effectData.begin_time
local resutl=effectData.result
local times=effectData.times
UIHuanJingControl:addJDCount(id,time,times)

UIHuanJingControl:showJinDiResultWindow(id,resutl,temp,effectData.discipleguid)
end
end

function UIHuanJingControl:getJinDiResultUnit(cTpye,data)
local handle=_discipleChange[cTpye]
if handle and#data>0 then

return handle(data)
end
end

function UIHuanJingControl:getJinDiResultUnits(changeList)
























local list={}
local disciple=nil

if changeList[eDiscipleChangeType.eSpeciality]then
changeList[eDiscipleChangeType.eSixAttr]=nil
end

for cTpye,temp in pairs(changeList)do
for guidStr,data in pairs(temp)do
if disciple==nil then
disciple=guidStr
end
if guidStr==disciple then
local units=self:getJinDiResultUnit(cTpye,data)
if units then
list=table.concatTable(list,units)
end
end
end
end

return list,disciple
end


function UIHuanJingControl:setJDDatas(datas)
local list={}
for i,v in ipairs(datas)do
list[v.back_mountain_id]={count=v.open_times,time=v.begin_time,totalCount=v.times}
self:setWaitTeZhiData(v.back_mountain_id,v.list)
end
self.data.jdData=list
end


function UIHuanJingControl:getJDTotalCount(id)
if self.data.jdData then
local data=self.data.jdData[id]
if data then
return data.totalCount
end
end
return 0
end


function UIHuanJingControl:getJDCount(id)
if self.data.jdData then
local data=self.data.jdData[id]
if data then
return data.count
end
end
return 0
end


function UIHuanJingControl:getJDTime(id)
if self.data.jdData then
local data=self.data.jdData[id]
if data then
return data.time
end
end
return 0
end


function UIHuanJingControl:addJDCount(id,begin_time,times)
if self.data.jdData then
local data=self.data.jdData[id]
if data then
data.count=data.count+1
data.time=begin_time
data.totalCount=times
else
data={count=1,time=begin_time,totalCount=times}
self.data.jdData[id]=data
end
end
end


function UIHuanJingControl:getCD(id)
local cfg=cfgHelper.get1(cfg_backmountainareaconfig_get,id)
local now=timeHelper.getServerShortTime()
local time=self:getJDTime(id)
if time>0 then
return cfg.sec-(now-time)
end
return 0
end


function UIHuanJingControl:isJinDiFuncOpen()
local level=self:getCurrentLevel()
return level>=cfgHelper.get2(cfg_backmountainareabasicconfig_get,1,"open")
end


function UIHuanJingControl:isJinDiOpen(id)
local cfg=cfgHelper.get1(cfg_backmountainareaconfig_get,id)
local conditions=cfg.open_conditions
for i,v in ipairs(conditions)do
local c=_jdCondition[v[1]]
if c then
if c.getValue then
if c.getValue()<v[2]then
return false
end
else
loggerUtil.logErrFMT("未实现禁地开启条件配置",v[1])
return false
end
else
loggerUtil.logErrFMT("未知禁地开启条件类型",v[1])
return false
end
end
return true
end


function UIHuanJingControl:getJinDiOpenTips(id,post)
local cfg=cfgHelper.get1(cfg_backmountainareaconfig_get,id)
local conditions=cfg.open_conditions
local strs={}
for i,v in ipairs(conditions)do
local c=_jdCondition[v[1]]
if c then
if c.getTips then
table.insert(strs,c.getTips(v[2]))
end
else
loggerUtil.logErrFMT("未知禁地开启条件类型",v[1])
end
end
local count=#strs
if count>0 then
local str=""
for i=1,count do
str=FMT.fmt("{0}{1}{2}",str,i==1 and""or"、",strs[i])
end
return FMT.fmt("{0}{1}",str,post or"")
end
end

function UIHuanJingControl:getCost(id)
local cfg=cfgHelper.get1(cfg_backmountainareaconfig_get,id)
local count=self:getJDCount(id)
for i=count+1,1,-1 do
if cfg.cost[i]then
return cfg.cost[i]
end
end
end

function UIHuanJingControl:checkDialog(id,guid,callback,index)
local cfg=cfgHelper.get1(cfg_backmountainareaconfig_get,id)
local types=cfg.checkType
index=index or 1
if types then
local count=#types
for i=index,count do
local v=types[index]
local func=function()
UIHuanJingControl:checkDialog(id,guid,callback,index+1)
end
if not _checkDialog[v](id,guid,func)then
return false
end
end
end
if callback then
callback()
end
return true
end

function UIHuanJingControl:findAValidJD()
if not UIHuanJingControl:isJinDiFuncOpen()then
return
end
local config=cfg_backmountainareaconfig()
for id,cfg in pairs(config)do
local isOpen=UIHuanJingControl:isJinDiOpen(id)
if isOpen then
local startTime=UIHuanJingControl:getJDTime(id)
local check=false
if startTime then
local nowTime=timeHelper.getServerShortTime()
local endTime=startTime+cfg.sec
local cding=nowTime<endTime
if not cding then
check=true
end
else
check=true
end
if check then
local cost=UIHuanJingControl:getCost(id)
local pass=true
if cost then
for i,v in ipairs(cost)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
pass=false
break
end
end
end
if pass then
return id
end
end
end
end
end

function UIHuanJingControl:checkReddot()
return UIHuanJingControl:findAValidJD()~=nil
end



function UIHuanJingControl:setWaitTeZhiData(id,datas)
self.data.jindiWaitTeZhiData[id]=datas
end

function UIHuanJingControl:getWaitTeZhiData(id)
return self.data.jindiWaitTeZhiData[id]
end

function UIHuanJingControl:delWaitTeZhiData(id)
self.data.jindiWaitTeZhiData[id]=nil
end

function UIHuanJingControl:hasNeedSelectTeZhiData()
return next(self.data.jindiWaitTeZhiData)~=nil
end

function UIHuanJingControl:checkShowNeedSelectTeZhiDialouge()
if self:hasNeedSelectTeZhiData()then
local idx,tzdata,dzguid
for id,data in pairs(self.data.jindiWaitTeZhiData)do
idx,tzdata=next(data)
dzguid=tzdata.param_1
if UIDiscipleModel:getDiscipleData(dzguid)then
self:showNeedSelectTeZhiDialougeById(id,data)
else
UIHuanJingControl:send_25_14(id,0)
end
end
end
end

function UIHuanJingControl:hasNeedSelectTeZhiDataById(id)
return self.data.jindiWaitTeZhiData[id]~=nil
end

function UIHuanJingControl:checkShowNeedSelectTeZhiDialougeById(id)
if self:hasNeedSelectTeZhiDataById(id)then
local data=self:getWaitTeZhiData(id)
self:showNeedSelectTeZhiDialougeById(id,data)
end
end

function UIHuanJingControl:showNeedSelectTeZhiDialougeById(id,data)
local idx
idx,data=next(data)

local args={
jdid=id,
waitSelectData=data
}

UIManager:showWindow("UIJinDiWaitSelectTeZhiDialougeWin",args)
end