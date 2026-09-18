






local _MODULENAME="worldTourModel"




def_table(_MODULENAME)
worldTourModel.name=_MODULENAME
worldTourModel.data={}
worldTourModel.count=0

local _record_key="WorldTourRecord"
local _record_data={}


function worldTourModel:onAppStart()

end


function worldTourModel:onEnterState()
self:loadBlockOpenTourRecord()
end


function worldTourModel:onLeaveState()

self.data={}
self.count=0
_record_data={}
end


function worldTourModel:onServerDataInitFinish()

end



function worldTourModel:getUnitKey(tourID,discipleGuid)
return worldModel:convertUnitKey({worldModel.UNITTYPE.TOURPOINT,tourID,tostring(discipleGuid)})
end

function worldTourModel:setDatas(tourList)
local list=tourList or{}
self.data={}
self.count=0
for i,v in ipairs(list)do
self.data[v.travelpointid]=v
end
self.count=#list
end

function worldTourModel:addData(tourData)
self.data[tourData.travelpointid]=tourData
self.count=self.count+1
end

function worldTourModel:removeData(tourId)
if self:containData(tourId)then
self.count=self.count-1
end
self.data[tourId]=nil
end

function worldTourModel:getData(tourId)
return self.data[tourId]
end

function worldTourModel:getAllData()
return self.data
end

function worldTourModel:containData(tourId)
return self:getData(tourId)~=nil
end

function worldTourModel:getCount()
return self.count
end

function worldTourModel:getMaxCount()
local info=cfgHelper.getdef(cfg_worldtravelpointconfig,"dispatchnum")
local zmLv=zongmenModel:getLevel()
for i,v in ipairs(info)do
if v[1]<=zmLv and zmLv<=v[2]then
return v[3]
end
end
return 0
end

function worldTourModel:getDisciple(tourID)
local data=self:getData(tourID)
if data then
return data.discipleguid
end
end

function worldTourModel:calculateReward(tourID,time)
local data=self:getData(tourID)
local rewards={}
if data then
local total=data.endtime-data.begintime
local percent=Mathf.Clamp(time,0,total)/total
if data.rewardlistlen>0 then
for i,v in ipairs(data.rewardList)do
local cnt=math.floor(v.param_2*percent)
cnt=math.floor(cnt*(1+data.percent/100))
local itemId=v.param_1
if cnt>0 then
if itemsConfig.isMoney(itemId)then
table.insert(rewards,{itemid=itemId,itemcount=cnt})
else
local itemCfg=itemsConfig.getConfig(v.param_1)
local dup=itemsConfig.dup or 1
for j=cnt,1,-dup do
table.insert(rewards,{itemid=itemId,itemcount=math.min(j,dup)})
end
end
end
end
end
if data.sperewardlistlen>0 then
for i,v in ipairs(data.sperewardList)do
local cnt=(data.begintime+time)>=v.param_4 and v.param_2 or 0
cnt=math.floor(cnt*(1+data.percent/100))
local itemId=v.param_1
if cnt>0 then
if itemsConfig.isMoney(itemId)then
table.insert(rewards,{itemid=itemId,itemcount=cnt})
else
local itemCfg=itemsConfig.getConfig(v.param_1)
local dup=itemsConfig.dup or 1
for j=cnt,1,-dup do
table.insert(rewards,{itemid=itemId,itemcount=math.min(j,dup)})
end
end
end
end
end
table.sort(rewards,self.sortRewardItem)
else
logErr(FMT.fmt("计算游历奖励错误，没有该游历{0}",tourID))
end
return rewards
end

function worldTourModel:getAreaTourCnt(area)
local num=0
for i,v in pairs(self.data)do
local cfg=cfgHelper.get1(cfg_worldtravelpointconfig_get,i)
if cfg.area==area then
num=num+1
end
end
return num
end

function worldTourModel:exsitWorldEmpty(world)
for i,v in pairs(cfg_worldareaconfig())do
if v.world==world then
if self:getAreaEmpty(i)then
return true
end
end
end
end

function worldTourModel:getAreaEmpty(area)
local nowTime=timeHelper.getServerShortTime()
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
for i,v in ipairs(areaCfg.travelpoints)do
local pointCfg=cfgHelper.get1(cfg_worldtravelpointconfig_get,v)
if worldBlockModel:checkBlockState(pointCfg.world,pointCfg.block,worldBlockModel.BLOCKSTATE.OPEN)then
if not self:containData(v)then
return true
end
end
end
return false
end

function worldTourModel:getAreaReddot(area)
local nowTime=timeHelper.getServerShortTime()
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
for i,v in ipairs(areaCfg.travelpoints)do
local pointCfg=cfgHelper.get1(cfg_worldtravelpointconfig_get,v)
if worldBlockModel:checkBlockState(pointCfg.world,pointCfg.block,worldBlockModel.BLOCKSTATE.OPEN)then
local data=self:getData(v)
if data~=nil and nowTime>=data.endtime then
return true
end
end
end
return false
end

function worldTourModel:getWorldReddot(world)

for i,v in pairs(cfg_worldareaconfig())do
if v.world==world then
if self:getAreaReddot(i)then
return true
end

end
end






return false
end

function worldTourModel:getReddot()
for i,v in pairs(cfg_worldareaconfig())do
if self:getAreaReddot(i)then
return true
end
end
return false
end

function worldTourModel:getFree()
if self:getCount()>=self:getMaxCount()then return false end
for i,v in pairs(cfg_worldareaconfig())do
if self:getAreaEmpty(i)then
return true
end
end
return false
end

function worldTourModel.sortRewardItem(a,b)
local colora=itemsConfig.getConfig(a.itemid).color
local colorb=itemsConfig.getConfig(b.itemid).color
if colora~=colorb then
return colora>colorb
else
return a.itemid>b.itemid
end
end

function worldTourModel:getJingJieStandard(area)
local areaCfg=cfgHelper.get1(cfg_worldareaconfig_get,area)
local jjInfo=areaCfg.traveljingjie
local zmLv=zongmenModel:getLevel()
for i,v in ipairs(jjInfo)do
if v[1]<=zmLv and zmLv<=v[2]then
return v[3]
end
end
return 0
end

function worldTourModel:calculateitionRewardCoefficient(jjLv,jjStandard,jjCoefficient,jyValue,jyStandard,jyCoefficient)
local jjAdd=(jjLv-jjStandard)*jjCoefficient
local jyAdd=(jyValue-jyStandard)*jyCoefficient

return math.floor(math.max(jjAdd,0)*100)
end

function worldTourModel:findEffectList(discipleData)
local list={}
for i,v in pairs(discipleData.specialitylistlookup)do
for j,w in ipairs(v)do

if not UIDiscipleModel:hasHideSpecialityType(i)or w.param_2==0 then
local cfg=UIDiscipleModel:getSpecialityConfig(i,w.param_1)
if cfg.search_effects then
for k,u in ipairs(cfg.search_effects)do
if u[1]==4 then
table_insert(list,cfg)
end
end
end
end
end
end
return list
end

function worldTourModel:getSelectDiscipleArgs(pointCfg,cost)
local args={
titleTx="弟子派遣",
buttonTx="派  遣",
cost=cost[1],
okCB=function(dzId)

if UIDiscipleModel:getDiscipleState(dzId)==DISCIPLE_STATE_TYPE.edsDispatch then
UIManager.error("弟子已被派遣")
end

local discipleData=UIDiscipleModel:getDiscipleData(dzId)
if eInjuryType.getType(discipleData.injury)==eInjuryType.eImminent then
UIManager.error("弟子已垂危")
end

if discipleData.jingjielv<pointCfg.jingjie then
UIManager.error("弟子境界不足")
end

worldTourController:send_5_71(pointCfg.id,dzId)
end,
titleName={"弟子","境界","机缘","奖励加成","特质"},
data={},
}

local jjStandard=worldTourModel:getJingJieStandard(pointCfg.area)
local conf=cfgHelper.getdef(cfg_worldtravelpointconfig)
local jjCoefficient=conf.jingjie[1]
local jyStandard=conf.attr6[1]
local jyCoefficient=conf.attr6[2]

local discipleList=UIDiscipleModel:getAllDiscipleData()
for i,v in pairs(discipleList)do
local discipleData=v.netData.net
local jjLv=discipleData.jingjielv
local jyNum=discipleData.attrList[DISCIPLE_BASE_ATTR_TYPE.eJiYuan]
local addition=self:calculateitionRewardCoefficient(jjLv,jjStandard,jjCoefficient,jyNum,jyStandard,jyCoefficient)
local injury=UIDiscipleModel:getDiscipleInjury(discipleData.discipleguid)
local injuryType=eInjuryType.getType(injury)
local lowloyalty=UIDiscipleModel:checkLowLoyalty(discipleData.discipleguid)
local checkJJLv=jjLv>=pointCfg.jingjie
local reason=nil
if injuryType==eInjuryType.eImminent then
reason=eInjuryType:getName(injury)

elseif UIDiscipleModel:getDiscipleState(discipleData.discipleguid)==DISCIPLE_STATE_TYPE.edsDispatch then
reason="派遣中"
elseif not checkJJLv then
reason="境界不足"
end
local data={}
data.discipleguid=discipleData.discipleguid
data.effects=self:findEffectList(discipleData)
data.reason=reason
data.others={
UIDiscipleModel:getJJNameX(jjLv),
jyNum,
addition>0 and FMT.cfmt(FONT_COLOR.eOrangeColor,"{0}%",addition)or FMT.cfmt(FONT_COLOR.eGrayColor,"无加成"),
}
data.sorts={
reason==nil and 1 or 0,addition,jyNum,jjLv,
UIDiscipleModel:getDiscipleColor(discipleData.discipleguid),discipleData.discipleguid
}
table.insert(args.data,data)
end
table.sort(args.data,self.sortDiscilpeSelect)
return args
end

function worldTourModel.sortDiscilpeSelect(a,b)
for i=1,6 do
if a.sorts[i]~=b.sorts[i]then
return a.sorts[i]>b.sorts[i]
end
end
return false
end

function worldTourModel:pushBlockOpenTourRecord(world,area,block)
table.insert(_record_data,{world,area,block})
self:saveBlockOpenTourRecord()
end

function worldTourModel:popBlockOpenTourRecord()
local temp=_record_data
if#temp>0 then
_record_data={}
self:saveBlockOpenTourRecord()
end
return temp
end

function worldTourModel:loadBlockOpenTourRecord()
_record_data=userActorSetting.get(_record_key,{})

end

function worldTourModel:saveBlockOpenTourRecord()
userActorSetting.set(_record_key,_record_data)
userActorSetting.flush()
end


