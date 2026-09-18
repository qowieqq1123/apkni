






local _MODULENAME="WenXinGuanModel"


def_table(_MODULENAME)
WenXinGuanModel.name=_MODULENAME
WenXinGuanModel.data={}

function WenXinGuanModel:onAppStart()

end


function WenXinGuanModel:onEnterState(isReconnect)
self:initSpeList()
end


function WenXinGuanModel:onProtocolReq()

end


function WenXinGuanModel:onLeaveState(isReconnect)

self.data={}
self:clearAllData()
end



speXMType=
{
all=0,
immortal=1,
devil=2,
tm=3,
}

iconXMType=
{
normal="image_fanrenmoshi_1",
immortal="image_xianrenmoshi_1",
devil="image_mohuamoshi_1",
}

jobXMType={
[1]={"image_wxgjianxian_1","image_wxgjianmo_1"},
[2]={'image_wxgshengseng_1','image_wxgxiuluo_1'},
[51]={'image_wxgshengru_1','image_wxgpanguan_1'},
[52]={'image_wxgxianyi_1','image_wxgdusheng_1'},
[101]={'image_wxgyinxian_1','image_wxgmoyin_1'},
[102]={'image_wxghuangsheng_1','image_wxghuimo_1'},
[151]={'image_wxgdaosheng_1','image_wxgdaomo_1'},
[152]={'image_wxgtiannv_1','image_wxgwumei_1'},
[201]={'image_wxgshenjiang_1','image_wxgmohou_1'},
[251]={'image_wxgshenwu_1','image_wxggumo_1'},
[252]={'image_wxgmixian_1','image_wxgguimo_1'}
}

















function WenXinGuanModel:initWXGDatas(argtable)
if tostring(argtable[1])=="0"then
self.data.dtdzGuid=nil
else
self.data.dtdzGuid=argtable[1]
end

self.data.tmId=argtable[2]
self.data.choice=argtable[3]
self.data.dzLen=argtable[4]
self.data.dzList=argtable[5]
self.data.finishNum=argtable[6]
self.data.hcjLen=argtable[7]
self.data.hcjList=argtable[8]
self.data.xmLen=argtable[9]
self.data.xmList=argtable[10]
self.data.accuCount=argtable[11]

if self.data.dzLen>0 then
WenXinGuanModel:initDzWXGStateList(self.data.dzList)
end

if self.data.hcjLen>0 then
WenXinGuanModel:initHcjDzStateList(self.data.hcjList)
end

if self.data.xmLen>0 then
WenXinGuanModel:initDzXMChoiceList(self.data.xmList)
end
end

function WenXinGuanModel:setAccuCount(value)
self.data.accuCount=value
end

function WenXinGuanModel:getAccuCount()
return self.data.accuCount or 0
end

function WenXinGuanModel:getDtDzGuid()
return self.data.dtdzGuid
end

function WenXinGuanModel:setDzTmId(dzGuid,tmId)
if not self.data.dtdzGuid then
self.data.dtdzGuid=dzGuid
end

if self.data.dtdzGuid==dzGuid then
self.data.tmId=tmId
else
logErr("后端下发的正在答题的弟子guid和前端记录的不一样， 请前端检查")
end

UIManager:invokeUIMethod("UIWenXinGuanEnterWin","refreshSwitchBtn")
end

function WenXinGuanModel:getDzTmId()
if not self.data.tmId then
local guid=self.data.dtdzGuid
if guid then
WenXinGuanController:send_34_131(guid)
end
end

return self.data.tmId
end

function WenXinGuanModel:setDzChoice(choice,finishNum)
self.data.choice=choice
self.data.finishNum=finishNum
UIManager:invokeUIMethod("UIWenXinGuanMainWin","refreshStepCount")
end

function WenXinGuanModel:getDzChoice()
return self.data.choice
end


function WenXinGuanModel:checkTmAndAnswer(guid)
if not self.data.tmId or self.data.tmId==0 then
if not self.data.dtdzGuid and not self:checkDzWXGState(guid)then

self.data.dtdzGuid=guid
end

if self.data.dtdzGuid then
WenXinGuanController:send_34_131(guid)
end
end

if not self.data.choice or self.data.choice==0 and self.data.tmId~=0 then
WenXinGuanController.send_34_132()
end
end


function WenXinGuanModel:getDzFinishnum()
return self.data.finishNum
end


function WenXinGuanModel:getFinishDzCount()
if self.data.dzLen then
return self.data.dzLen
end
return 0
end

function WenXinGuanModel:setFinishDzList(guid)
if not self.data.dzList then
self.data.dzList={}
end
table.insert(self.data.dzList,guid)
end

function WenXinGuanModel:getFinishDzList()
if self.data.dzList then
return self.data.dzList
end
return nil
end


function WenXinGuanModel:getHCJDzList()
if self.data.hcjLen and self.data.hcjLen>0 then
return self.data.hcjList
end
return{}
end


function WenXinGuanModel:initHcjDzStateList(list)
self.hcjList={}

for k,v in ipairs(list)do
local str=tostring(v)
self.hcjList[str]=true
end
end


function WenXinGuanModel:judgeIsCanEnterByStr(guidStr)
if self.hcjList then
return self.hcjList[guidStr]
end
end


function WenXinGuanModel:judgeIsCanEnter(guid)
return WenXinGuanModel:judgeIsCanEnterByStr(tostring(guid))
end


function WenXinGuanModel:initDzXMChoiceList(list)
self.dzxmList={}

for k,v in ipairs(list)do
local guid=v.dzGuid
local moCount=v.moCount
local xianCount=v.xianCount
local str=tostring(guid)

if not self.dzxmList[str]then
self.dzxmList[str]={}
self.dzxmList[str].moCount=moCount
self.dzxmList[str].xianCount=xianCount
end
end
end


function WenXinGuanModel:setDzXMZChange(guid,xmz)
if not self.xmzList then self.xmzList={}end

local guidStr=tostring(guid)
self.xmzList[guidStr]=xmz
end

function WenXinGuanModel:getDzXMZByguid(guid)
local xmz=0
local guidStr=tostring(guid)

if self.xmzList and self.xmzList[guidStr]then
xmz=self.xmzList[guidStr]
else
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData and netData.xianmo then xmz=netData.xianmo end
end

return xmz
end

function WenXinGuanModel:getDzXMZ(guid)
if not self.dzxmList then
self.dzxmList={}
end

local str=tostring(guid)
if not self.dzxmList[str]then
self.dzxmList[str]={}
self.dzxmList[str].moCount=0
self.dzxmList[str].xianCount=0
end

local moCount=self.dzxmList[str].moCount
local xianCount=self.dzxmList[str].xianCount
return xianCount,moCount
end

function WenXinGuanModel:setDzXMZ_xian(value,guid)
if not self.dzxmList then
self.dzxmList={}
end

local str=tostring(guid)
if not self.dzxmList[str]then
self.dzxmList[str]={}
end

self.dzxmList[str].xianCount=value

end

function WenXinGuanModel:setDzXMZ_mo(value,guid)

if not self.dzxmList then
self.dzxmList={}
end

local str=tostring(guid)
if not self.dzxmList[str]then
self.dzxmList[str]={}
end

self.dzxmList[str].moCount=value

end


function WenXinGuanModel:addDzXMZAuto(choice)
local guid=self.data.dtdzGuid
local index=self.data.tmId
local xianCount,moCount=WenXinGuanModel:getDzXMZ(guid)
local config=cfg_wenxinguantimuconfig_get(index)

if not config then
logErr(string.format('问心关题目%s配置读取失败，请检查问心关配置表',index))
return
end

local xmz=config.xmz
local value=xmz[choice]

if value>0 then
self:setDzXMZ_mo(moCount+1,guid)
UIManager:invokeUIMethod("UIWenXinGuanMainWin","refreshXMZUp",2)
elseif value<0 then
self:setDzXMZ_xian(xianCount+1,guid)
UIManager:invokeUIMethod("UIWenXinGuanMainWin","refreshXMZUp",1)
end
end

function WenXinGuanModel:initSpeList()
self.speList={}
self.allSpeDevilList={}
self.allSpeImmortalList={}
self.speListDevil={}
self.speListImmortal={}
local config=cfg_wenxinguanbaseconfig_get(1)

if config then
local cfg=config.speList
for index,value in ipairs(cfg)do
local tempList
local tempAllList
local temp=value
if index==1 then
tempList=self.speListImmortal
tempAllList=self.allSpeImmortalList
elseif index==2 then
tempList=self.speListDevil
tempAllList=self.allSpeDevilList
end

for k,v in pairs(temp)do
if v then
local typo=k
local str=tostring(k)
local list={}
local listt={}

if not self.speList[str]then
self.speList[str]={}
end

if not tempList[str]then
tempList[str]={}
end

for i,j in pairs(v)do
if j then
local id=j
local strj=tostring(j)
if not self.speList[str][strj]then
self.speList[str][strj]=true
end

if not tempList[str][strj]then
tempList[str][strj]=true
end

local temp={}
temp.id=id
temp.typo=typo
table.insert(list,temp)
end
end
listt.typo=typo
listt.list=list
table.insert(tempAllList,listt)
end
end
end
end

self:sortXMSpeList()





end


function WenXinGuanModel:getSpeListstate(type,id,xmtype)
local tempList
local typestr=tostring(type)
local idstr=tostring(id)

if xmtype==0 then
tempList=self.speList
elseif xmtype==1 then
tempList=self.speListImmortal
elseif xmtype==2 then
tempList=self.speListDevil
elseif xmtype==3 then
tempList=self.tmSpeList
end

if tempList and tempList[typestr]then
if tempList[typestr][idstr]then
return tempList[typestr][idstr]
end
end
end


function WenXinGuanModel:checkSpestate(type,id)
local typestr=tostring(type)
local idstr=tostring(id)

if self.speListImmortal and self.speListImmortal[typestr]then
if self.speListImmortal[typestr][idstr]then
return 1
end
end

if self.speListDevil and self.speListDevil[typestr]then
if self.speListDevil[typestr][idstr]then
return 2
end
end

return 1
end

function WenXinGuanModel:checkSpeList(guid,xmtype)
if not self.speList then return end

local spelist={}
local speciallist=UIDiscipleModel:getDiscipleSpecialityConfig(guid,true)

for k,v in ipairs(speciallist)do
if v then
local type=v.typo
local id=v.id

if WenXinGuanModel:getSpeListstate(type,id,xmtype)then
table.insert(spelist,v)
end
end
end

return spelist
end

function WenXinGuanModel:sort(list)
local list=list
table.sort(list,function(a,b)
if a.typo==3 then
a.sort=0
else
a.sort=a.typo
end

if b.typo==3 then
b.sort=0
else
b.sort=b.typo
end

return a.sort<b.sort
end)
return list
end

function WenXinGuanModel:sortXMSpeList()
local list=self.allSpeImmortalList
self:sort(list)
self.allSpeImmortalList=list

list=self.allSpeDevilList
self:sort(list)
self.allSpeDevilList=list
end

function WenXinGuanModel:checkXMSpeList()
return self.allSpeImmortalList,self.allSpeDevilList
end

function WenXinGuanModel:getSpeListByTm(tmId,guid)
self.tmSpeList={}
local config=cfg_wenxinguantimuconfig_get(tmId)
config=config.tzWeight

if config then
for k,v in pairs(config)do
if v then
local type=tostring(k)
for i,j in pairs(v)do
local id=tostring(i)
if not self.tmSpeList[type]then
self.tmSpeList[type]={}
end
self.tmSpeList[type][id]=true
end
end
end
end

local list=self:checkSpeList(guid,speXMType.tm)
return list
end



function WenXinGuanModel:getDzXMSuit(guid)
local index=1
local xmz=0
local tmlv=0
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData and netData.xianmo then
xmz=netData.xianmo
tmlv=netData.tmlv
end

if tmlv==15 then
index=2
end

local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local suitCfg=cfgHelper.get2(cfg_disciplebodyimageconfig_get,imageInfo.body,"xm_transfer")

if suitCfg then
return suitCfg[1][index],suitCfg[2][index]
else
logErr(string.format('配置表读取失败，请检查弟子形象配置表身体id为%s的仙魔转职外观字段',imageInfo.body))
end
end



function WenXinGuanModel:getDzXMSkill(guid,flag)
local index=1
local xmz=0
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData and netData.xianmo then xmz=netData.xianmo end
if xmz>0 then
index=2
elseif xmz<0 then
index=1
end

local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local skillCfg=cfgHelper.get2(cfg_disciplevocationconfig_get,imageInfo.job,"xmskills")

if skillCfg then
if flag then
return skillCfg[1],skillCfg[2]
else
return skillCfg[index]
end
else
logErr(string.format('配置表读取失败，请检查弟子职业配置表职业id为%s的仙魔技能字段',imageInfo.job))
end
end


function WenXinGuanModel:initDzWXGStateList(list)
self.dzWxgList={}
self.dzWxgGuidList=list

for k,v in ipairs(list)do
local str=tostring(v)
self.dzWxgList[str]=true
end

end


function WenXinGuanModel:checkDzWXGStateByStr(guidStr)
local state=false
if self.dzWxgList then
if self.dzWxgList[guidStr]then
state=self.dzWxgList[guidStr]
end
end
return state
end


function WenXinGuanModel:checkDzWXGState(guid)
return WenXinGuanModel:checkDzWXGStateByStr(tostring(guid))
end


function WenXinGuanModel:checkDzIsFinishWXG(guid)
local xmz
local posX
local posY
local winName="UIWenXinGuanEnterWin"
local state=false

if self.data.dtdzGuid==guid and self.data.finishNum>0 then
winName="UIWenXinGuanMainWin"
end

if self.dzWxgList then
local str=tostring(guid)
if self.dzWxgList[str]then
state=self.dzWxgList[str]
end

if state then
xmz=self:getDzXMZByguid(guid)

if xmz<0 then
posX=540
posY=-290
winName="UIWenXinGuanTransferImmortalWin"
elseif xmz>0 then
posX=-538
posY=-243
winName="UIWenXinGuanTransferDevilWin"
else
posX=0
posY=-135
winName="UIWenXinGuanUnknownWin"
end
end
end

return winName,posX,posY

end


function WenXinGuanModel:clearDzAnswer()
self.data.tmId=0
self.data.choice=0
end


function WenXinGuanModel:clearDzFinishWXG(guid)
self.data.dtdzGuid=nil
self.data.tmId=0
self.data.choice=0
self.data.finishNum=0
self.data.dzLen=self.data.dzLen+1
self:setFinishDzList(guid)

local str=tostring(guid)
if not self.dzWxgList then self.dzWxgList={}end
self.dzWxgList[str]=true

if not self.dzWxgGuidList then self.dzWxgGuidList={}end
table.insert(self.dzWxgGuidList,guid)

UIManager:invokeUIMethod('UIDiscipleRoleInfoTwoWin','refreshJJInfoStatic')
reddotControl.on_change_catch_type(CATCH_TYPE.eDisciple)
notifySystem:postNotify(notifyConfig.onJctjProgressChange)
end


function WenXinGuanModel:clearAllData()
self.speList=nil
self.dzxmList=nil
self.xmzList=nil
self.hcjList=nil
self.dzWxgList=nil
end



function WenXinGuanModel:getProgress()
local max=cfgHelper.get2(cfg_wenxinguanbaseconfig_get,1,'tmzs')

if self.data.dzLen then
if self.data.dzLen>0 then
return max,max
else
return self.data.finishNum,max
end
else
return 0,max
end
end




















function WenXinGuanModel:checkIsEnoughCost(itemList)
if itemList then
for k,v in ipairs(itemList)do
if v then
local itemId=v[1]
local needNum=v[2]
local haveNum=itemsModel.getCount(itemId)

if haveNum<needNum then
return false
end
end
end
return true
end
return false
end

function WenXinGuanModel:checkIsEnoughConditionByStr(guidStr)
local netData=UIDiscipleModel:getDiscipleDataByStr(guidStr)
if netData.jingjielv<90 then
return false
end

if not WenXinGuanModel:judgeIsCanEnterByStr(guidStr)and not JiuChongTianJieEnterModel:isJiuChongTianJieComplete()then
return false
end

return true
end

function WenXinGuanModel:checkIsEnoughCondition(guid)
return WenXinGuanModel:checkIsEnoughConditionByStr(tostring(guid))
end


function WenXinGuanModel:isHaveReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eWenXinGuan)then
return false
end
local flag=false
local questionNum
local config=cfg_wenxinguanbaseconfig_get(1)
local costCfg=config.dtitems
local list=UIDiscipleModel:getFightTop5DiscipleGuidList()


if self.data.dtdzGuid then
questionNum=self.data.finishNum+1
else
questionNum=1
end

if list then
for k,v in ipairs(list)do
local discipleguidStr=v.discipleguidStr

if not self:checkDzWXGStateByStr(discipleguidStr)and self:checkIsEnoughConditionByStr(discipleguidStr)then
flag=true
break
end
end
end

if flag and costCfg then
local cost=costCfg[questionNum]
if cost then
return self:checkIsEnoughCost(cost)
end
end

return false
end


function WenXinGuanModel:dzIsHaveReddot(guid)
if not systemModel.isOpen(SYSTEM_DEFINE.eWenXinGuan)then
return false
end
local questionNum
local guidStr=tostring(guid)
local config=cfg_wenxinguanbaseconfig_get(1)
local costCfg=config.dtitems
if self.data.dtdzGuid then
if guid==self.data.dtdzGuid then
questionNum=self.data.finishNum+1
else
return false
end
else
local has=UIDiscipleModel:isTopFight(guidStr,5)
if has then

if not self:checkDzWXGStateByStr(guidStr)and self:checkIsEnoughConditionByStr(guidStr)then
questionNum=1
end
else
return false
end
end

if costCfg and questionNum then
local cost=costCfg[questionNum]
if cost then
return self:checkIsEnoughCost(cost)
end
end

return false
end

function WenXinGuanModel:getReddotState()
return userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eWenXinGuan,{})
end

function WenXinGuanModel:setReddotState()
local flag=false
local data=self:getReddotState()
local time=timeHelper.getServerLongTime()

if not data.time then
flag=true
data.time=time
elseif data.time<time then
local isSameDay=timeHelper.checkInSameDay(data.time,time)
if not isSameDay then
flag=true
data.time=time
end
end

if flag then
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eWenXinGuan,data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWenXinGuan)
reddotControl.on_change_catch_type(CATCH_TYPE.eDisciple)
end
end

function WenXinGuanModel:alldzXMYuLanReddot()
if not self.dzWxgGuidList then
return false
else
for k,v in ipairs(self.dzWxgGuidList)do
if v then
if self:dzXMYuLanReddot(v)then
return true
end
end
end
end
return false
end

function WenXinGuanModel:dzXMYuLanReddot(guid)
if UIDiscipleModel:checkDiscipleXianMoVoc(guid)then return false end
return UIDiscipleModel:checkDiscipleXianMoTransferReddot(guid)














end

function WenXinGuanModel:getMemoryTransferWin(guid)
local guidStr=tostring(guid)
local data=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eWenXinGuanTran,{})

if data and data[guidStr]then
return data[guidStr]
else
return false
end
end

function WenXinGuanModel:setMemoryTransferWin(guid)
local guidStr=tostring(guid)
local data=self:getMemoryTransferWin()
if not data then
data={}
end

data[guidStr]=true
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eWenXinGuanTran,data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWenXinGuanTran)
end