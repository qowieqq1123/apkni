






local _MODULENAME="SiFangPingYaoModel"


def_table(_MODULENAME)
SiFangPingYaoModel.name=_MODULENAME
SiFangPingYaoModel.data={}

function SiFangPingYaoModel:onAppStart()

end


function SiFangPingYaoModel:onEnterState(isReconnect)
self.data.severdata={}
end


function SiFangPingYaoModel:onProtocolReq()

end


function SiFangPingYaoModel:onLeaveState(isReconnect)

self.data={}
end


function SiFangPingYaoModel:initSFPYData(args)
self.data.severdata.demons_id=args[1]or 0
self.data.severdata.chapter_id=args[2]or 0
self.data.severdata.map_idx=args[3]or 0
self.data.severdata.point_id=args[4]or 0
self.data.severdata.challenge_progress=args[5]or 0
self.data.severdata.choice_bits=0
self.data.severdata.teamlist={}
self.data.severdata.pointlist={}
self.data.severdata.selectfzlist={}
self.data.severdata.allfz_list={}
self.data.severdata.achieve_list={}
self.data.severdata.pointendlist={}
self.data.severdata.ygrewarddata={}
self.data.severdata.challengeDemons={}

if args[6]>0 and args[7]then
self.data.severdata.teamlist=args[7]
end
if args[8]>0 and args[9]then

self:setPointList(args[9])
end
if args[10]>0 and args[11]then
self.data.severdata.seltfz_list=args[11]
end

self.data.severdata.choice_bits=args[12]
self.data.severdata.boss_anger=args[13]

if args[14]>0 and args[15]then
self.data.severdata.allfz_list=args[15]
end

if args[16]>0 and args[17]then
SiFangPingYaoModel:setYGrewarData(args[17])
end

if args[18]>0 and args[19]then
self.data.severdata.achieve_list=args[19]
end

if args[20]>0 and args[21]then
self.data.severdata.challengeDemons=args[21]
self:setYGJingDuData(args[21])
end

if args[22]>0 and args[23]then
self.data.severdata.pointendlist=args[23]
end

self.data.severdata.recordinit_boss_affinity=args[24]
self.data.severdata.record_boss_affinity=args[24]
end


function SiFangPingYaoModel:checkData()
local demons_id=self.data.severdata.demons_id
local chapter_id=self.data.severdata.chapter_id
if demons_id and chapter_id then
return true
end
return false
end


function SiFangPingYaoModel:goinSFPYData(args1,args2,args3,args4,args5,args6,args7,args8)

self.data.severdata.demons_id=args1 or 0
self.data.severdata.chapter_id=args2 or 0

SiFangPingYaoModel:setSLrecord(args3)
SiFangPingYaoModel:setinitrecord(args3)
SiFangPingYaoModel:setbossanger(args3)

self.data.severdata.map_idx=args8
if args4>0 and args5 then
SiFangPingYaoModel:setPointList(args5)
end
if args6>0 and args7 then
SiFangPingYaoModel:setBagFZ_list(args7)
end
end


function SiFangPingYaoModel:getMapIdex()
return self.data.severdata.demons_id
end
function SiFangPingYaoModel:getZhangjieIdex()
return self.data.severdata.chapter_id
end
function SiFangPingYaoModel:getJieDianIdex()
return self.data.severdata.point_id
end

function SiFangPingYaoModel:setMapIdex(demons_id)
self.data.severdata.demons_id=demons_id
end

function SiFangPingYaoModel:setZhangjieIdex(chapter_id)
self.data.severdata.chapter_id=chapter_id
end


function SiFangPingYaoModel:setSLrecord(value)
self.data.severdata.record_boss_affinity=value
end
function SiFangPingYaoModel:getSLrecord()
return self.data.severdata.record_boss_affinity or 0
end

function SiFangPingYaoModel:setinitrecord(value)
self.data.severdata.recordinit_boss_affinity=value
end
function SiFangPingYaoModel:getinitrecord()
return self.data.severdata.recordinit_boss_affinity or 0
end


function SiFangPingYaoModel:setachievelist(arry)
self.data.severdata.achieve_list={}
self.data.severdata.achieve_list=arry
end
function SiFangPingYaoModel:getachievelist()
return self.data.severdata.achieve_list
end



function SiFangPingYaoModel:setDZTeamList(teamlist)
if not self.data.severdata.teamlist then
self.data.severdata.teamlist={}
end
self.data.severdata.teamlist=teamlist
end
function SiFangPingYaoModel:getDZTeamList()
return self.data.severdata.teamlist
end


function SiFangPingYaoModel:setYGrewarData(ygrewarData)
self.data.severdata.ygrewarddata={}
if ygrewarData then
for k,v in ipairs(ygrewarData)do
self.data.severdata.ygrewarddata[v.param_1]=v
end
end
end

function SiFangPingYaoModel:setYGcomplerewarData(ygrewarData)
self.data.severdata.ygrewarddata=ygrewarData
end
function SiFangPingYaoModel:getYGrewarData()
return self.data.severdata.ygrewarddata
end


function SiFangPingYaoModel:setYGJingDuData(challengeDemons)
if not self.data.severdata.challengeDemons then
self.data.severdata.challengeDemons={}
end
if challengeDemons then
for k,v in ipairs(challengeDemons)do
self.data.severdata.challengeDemons[v.param_1]=v
end
end
end
function SiFangPingYaoModel:getYGJingDuData()
return self.data.severdata.challengeDemons
end


function SiFangPingYaoModel:getSeltFZ_list()
return self.data.severdata.seltfz_list
end
function SiFangPingYaoModel:setSeltFZ_list(seltfz_list)
self.data.severdata.seltfz_list={}
self.data.severdata.seltfz_list=seltfz_list
end


function SiFangPingYaoModel:getBagFZ_list()
return self.data.severdata.allfz_list
end
function SiFangPingYaoModel:setBagFZ_list(allfz_list)

self.data.severdata.allfz_list={}
self.data.severdata.allfz_list=allfz_list
end


function SiFangPingYaoModel:setbossanger(value)
self.data.severdata.boss_anger=value
end
function SiFangPingYaoModel:getbossanger()
return self.data.severdata.boss_anger or 0
end


function SiFangPingYaoModel:setPointFinishList(pointendlist)
if not self.data.severdata.pointendlist then
self.data.severdata.pointendlist={}
end
self.data.severdata.pointendlist=pointendlist

end
function SiFangPingYaoModel:getPointFinishFlagList()
local list={}

for k,v in ipairs(self.data.severdata.pointendlist)do
list[v]=true
end
return list
end
function SiFangPingYaoModel:getPointFinishList()
return self.data.severdata.pointendlist
end


function SiFangPingYaoModel:setPointList(pointlist)
self.data.severdata.pointlist={}
if pointlist then
for k,v in ipairs(pointlist)do
self.data.severdata.pointlist[v.point_id]=v
end
end
end

function SiFangPingYaoModel:setcomplPointList(pointlist)
self.data.severdata.pointlist=pointlist
end
function SiFangPingYaoModel:getPointList()
return self.data.severdata.pointlist
end


function SiFangPingYaoModel:setpointid(point_qiyuid)
self.data.point_qiyuid=point_qiyuid
end
function SiFangPingYaoModel:getpointid()
return self.data.point_qiyuid
end


function SiFangPingYaoModel:setdoingpointid(point_id)
self.data.severdata.point_id=point_id
end
function SiFangPingYaoModel:getdoingpointid()
return self.data.severdata.point_id
end


function SiFangPingYaoModel:setchoice_bits(choice_bits)
self.data.severdata.choice_bits=choice_bits
end
function SiFangPingYaoModel:getchoice_bits()
return self.data.severdata.choice_bits
end



function SiFangPingYaoModel:setmap_idx(map_idx)
self.data.severdata.map_idx=map_idx
end
function SiFangPingYaoModel:getmap_idx()
return self.data.severdata.map_idx
end


function SiFangPingYaoModel:resetCheLi()


self.data.severdata.map_idx=0
self.data.severdata.point_id=0
self.data.severdata.challenge_progress=0
self.data.severdata.teamlist={}
self.data.severdata.pointlist={}
self.data.severdata.allfz_list={}
self.data.severdata.pointendlist={}
self.data.teamchangerecord=nil
self.data.qiyudata=nil
self.data.severdata.choice_bits=0
SiFangPingYaoModel:setSeltFZ_list({})
end


function SiFangPingYaoModel:resetNewZhangJie()
self.data.severdata.point_id=0
self.data.severdata.challenge_progress=0
self.data.severdata.pointendlist={}
self.data.teamchangerecord=nil
self.data.qiyudata=nil
end



function SiFangPingYaoModel:cesidata()

end


function SiFangPingYaoModel:resetTiaoZhan()
self.data.severdata.point_id=0
self.data.severdata.challenge_progress=0
self.data.severdata.pointendlist={}
self.data.teamchangerecord=nil
self.data.qiyudata=nil
end


function SiFangPingYaoModel:resetFrightData(args1,args2,args3,args4,args5)
self.data.severdata.demons_id=args1
self.data.severdata.chapter_id=args2
if self.data.severdata.point_id==args3 then
self.data.severdata.point_id=0
end
if args4>0 then
SiFangPingYaoModel:setSeltFZ_list(args5)
end
end


function SiFangPingYaoModel:setfuhuodzguid(guid)
self.data.severdata.fhguid=guid
end
function SiFangPingYaoModel:getfuhuodzguid()
return self.data.severdata.fhguid
end


function SiFangPingYaoModel:set_fighting(isFighting)
self.data.is_fighting=isFighting
end
function SiFangPingYaoModel:is_fighting()
return self.data.is_fighting
end


function SiFangPingYaoModel:setTeamChangeRecord(data)
self.data.teamchangerecord=data
end
function SiFangPingYaoModel:getTeamChangeRecord()
return self.data.teamchangerecord
end


function SiFangPingYaoModel:setQiyuRecord(data)
self.data.qiyudata=data
end
function SiFangPingYaoModel:getQiyuRecord()
return self.data.qiyudata
end



function SiFangPingYaoModel:setqyfazedata(data)
self.data.qyfazedata=data
end
function SiFangPingYaoModel:getqyfazedata()
return self.data.qyfazedata
end


function SiFangPingYaoModel:testygclear()
local a={}
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSiFangPingYao,'ygopen',a)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSiFangPingYao)
UIManager.error("已清除妖国开启数据")
end

function SiFangPingYaoModel:testygzjclear()
local temp=
{
[1]={0,0,0},
[2]={0,0,0},
[3]={0,0,0},
[4]={0,0,0},
[5]={0,0,0},
}
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSiFangPingYao,'ygzjlist',temp)
UIManager.error("已清除章节开启数据")
local temp2=
{
[1]=0,
[2]=0,
[3]=0,
[4]=0,
[5]=0,
}
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSiFangPingYao,'sfpytgarry',temp2)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSiFangPingYao)
userActorSetting.set('sfpy_zhiyin_first',false)
userActorSetting.set('sfpy_zhiyin_first_zj',false)
userActorSetting.flush()
end

function SiFangPingYaoModel:testflsgclear()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSiFangPingYao,'huifutype',nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSiFangPingYao)
UIManager.error("已清除节点数据")
end

function SiFangPingYaoModel:testflsgallclear()
SiFangPingYaoModel:testygclear()
SiFangPingYaoModel:testygzjclear()
SiFangPingYaoModel:testflsgclear()
end


function SiFangPingYaoModel:isCanKitOut(guid)
local flag=false
if guid then
local dizilist=SiFangPingYaoController:getFSZteamList()
if dizilist and#dizilist>0 then
for k,v in ipairs(dizilist)do
if mathHelper.compareInt64(guid,v)then
flag=true
break
end
end
end
end
return flag
end


function SiFangPingYaoModel:setywbattle(data)
self.data.ywbattle=data
end
function SiFangPingYaoModel:getywbattle()
return self.data.ywbattle
end

function SiFangPingYaoModel:getplotBoardChange()
local ywbattle=SiFangPingYaoModel:getywbattle()
local plotBoardid=0
if ywbattle then
local demons_id=SiFangPingYaoModel:getMapIdex()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
if demons_id and chapter_id and demons_id~=0 and chapter_id~=0 then
local ywzjcfg=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id]
local fightstageTree=ywzjcfg.fightstageTree
if fightstageTree then
local nuqizhi=SiFangPingYaoModel:getbossanger()
local isqy=SiFangPingYaoController:checkshangzhendz()

if not isqy then
if nuqizhi>=0 then
local affine_boss_attrs=fightstageTree[2][1]
for k,v in ipairs(affine_boss_attrs)do
if nuqizhi>=v[1]then
plotBoardid=v[2]
end
end
else
local affine_boss_attrs=fightstageTree[2][2]
nuqizhi=-nuqizhi
for k,v in ipairs(affine_boss_attrs)do
if nuqizhi>=v[1]then
plotBoardid=v[2]
end
end
end
else
if nuqizhi>=0 then
local affine_boss_attrs=fightstageTree[3][1]
for k,v in ipairs(affine_boss_attrs)do
if nuqizhi>=v[1]then
plotBoardid=v[2]
end
end
else
local affine_boss_attrs=fightstageTree[3][2]
nuqizhi=-nuqizhi
for k,v in ipairs(affine_boss_attrs)do
if nuqizhi>=v[1]then
plotBoardid=v[2]
end
end
end
end
end
end
end

return plotBoardid
end


function SiFangPingYaoModel:getplotBoardback()
local ywbattle=true
local plotBoardid=0
if ywbattle then
local demons_id=SiFangPingYaoModel:getMapIdex()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
if demons_id and chapter_id and demons_id~=0 and chapter_id~=0 then
local ywzjcfg=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id]
local fightstageTree=ywzjcfg.fightstageback
if fightstageTree then
local nuqizhi=SiFangPingYaoModel:getbossanger()
local isqy=SiFangPingYaoController:checkshangzhendz()

if not isqy then
if nuqizhi>=0 then
local affine_boss_attrs=fightstageTree[1][1]
for k,v in ipairs(affine_boss_attrs)do
if nuqizhi>=v[1]then
plotBoardid=v[2]
end
end
else
local affine_boss_attrs=fightstageTree[1][2]
nuqizhi=-nuqizhi
for k,v in ipairs(affine_boss_attrs)do
if nuqizhi>=v[1]then
plotBoardid=v[2]
end
end
end
else
if nuqizhi>=0 then
local affine_boss_attrs=fightstageTree[2][1]
for k,v in ipairs(affine_boss_attrs)do
if nuqizhi>=v[1]then
plotBoardid=v[2]
end
end
else
local affine_boss_attrs=fightstageTree[2][2]
nuqizhi=-nuqizhi
for k,v in ipairs(affine_boss_attrs)do
if nuqizhi>=v[1]then
plotBoardid=v[2]
end
end
end
end
end
end
end

return plotBoardid
end


function SiFangPingYaoModel:settgflag(data)
self.data.tgflag=data
end
function SiFangPingYaoModel:gettgflag()
return self.data.tgflag
end


function SiFangPingYaoModel:setfightresult(data)
self.data.sfpyfightresult=data
end
function SiFangPingYaoModel:getfightresult()
return self.data.sfpyfightresult or 0
end


function SiFangPingYaoModel:settwohuifu(data)

self.data.twohuifu=data
end
function SiFangPingYaoModel:gettwohuifu()

return self.data.twohuifu
end


function SiFangPingYaoModel:settwofight(data)
self.data.twofight=data
end
function SiFangPingYaoModel:gettwofight()
return self.data.twofight
end


function SiFangPingYaoModel:setwuyaoguo(data)
self.data.wuyaoguo=data
end
function SiFangPingYaoModel:getwuyaoguo()
return self.data.wuyaoguo or{}
end


function SiFangPingYaoModel:setfinishlinepoid(data)
self.data.finishlinepoid=data
end
function SiFangPingYaoModel:getfinishlinepoid()
return self.data.finishlinepoid or 0
end

function SiFangPingYaoModel:settwofinishlinepoid(data)
self.data.twofinishlinepoid=data
end
function SiFangPingYaoModel:gettwofinishlinepoid()
return self.data.twofinishlinepoid or{}
end


function SiFangPingYaoModel:setmapcheli(data)
self.data.mapcheli=data
end
function SiFangPingYaoModel:getmapcheli()
return self.data.mapcheli
end

function SiFangPingYaoModel:setmaincheli(data)
self.data.maincheli=data
end
function SiFangPingYaoModel:getmaincheli()
return self.data.maincheli
end


function SiFangPingYaoModel:getSiFangPingYaoTgNum(ygid)
local ygnum=0
local all_yg_jd=SiFangPingYaoModel:getYGJingDuData()
if ygid>0 then
if all_yg_jd and all_yg_jd[ygid]and all_yg_jd[ygid].param_3 then
ygnum=all_yg_jd[ygid].param_3
end
else
local ygcfg=cfg_foursideskilldemonsconfig()
for i=1,#ygcfg do
if all_yg_jd and all_yg_jd[i]and all_yg_jd[i].param_3 then
ygnum=ygnum+all_yg_jd[i].param_3
end
end
end
return ygnum
end


function SiFangPingYaoModel:setdizifhtxt(data)
self.data.dizifhtxt=data
end
function SiFangPingYaoModel:getdizifhtxt()
return self.data.dizifhtxt
end

function SiFangPingYaoModel:setdizifhflag(data)
self.data.dizifhflag=data
end
function SiFangPingYaoModel:getdizifhflag()
return self.data.dizifhflag
end


function SiFangPingYaoModel:setdizisortygid(data)
self.data.zisortygid=data
end
function SiFangPingYaoModel:getdizisortygid()
return self.data.zisortygid or 1
end
