






local _MODULENAME="YiFangLingTianModel"


def_table(_MODULENAME)
YiFangLingTianModel.name=_MODULENAME
YiFangLingTianModel.data={}
YiFangLingTianModel.gridDatas={}
local _tickTimer
local _tickTimer_B

function YiFangLingTianModel:onAppStart()

end


function YiFangLingTianModel:onEnterState(isReconnect)

end


function YiFangLingTianModel:onProtocolReq()



_tickTimer=timer.new()
_tickTimer:start(60,function()
YiFangLingTianModel:Refreshtime()

end)
_tickTimer_B=timer.new()
_tickTimer_B:start(60,function()
YiFangLingTianModel:RefreshPlanttime()

end)

end


function YiFangLingTianModel:onLeaveState(isReconnect)

self.data={}
self.gridDatas={}
if _tickTimer then
_tickTimer:cancel()
end
_tickTimer=nil

if _tickTimer_B then
_tickTimer_B:cancel()
end
_tickTimer_B=nil
end

function YiFangLingTianModel:RecordNowDzID()
local bdData=zongmenModel:getBuildingData(self.data.un_build_id)
self.data.dizi_id=bdData.dizi_id
end

function YiFangLingTianModel:GetNowDzID()
if not self.data.dizi_id then
self.data.dizi_id=0
end
return self.data.dizi_id
end


function YiFangLingTianModel:SetYFLTData(un_build_id,gezi_len,gezilist,begintime,extranum)
self.data.un_build_id=un_build_id
self.data.gezi_len=gezi_len
if self.data.gezi_len>0 then






self.data.gezilist=gezilist
else
self.data.gezilist={}
end
YiFangLingTianModel:RefreshPlanttime()

self.data.ly_begintimes=begintime
self.data.extranum=extranum
YiFangLingTianModel:RecordNowDzID()
end

function YiFangLingTianModel:GetUn_build_id()
return self.data.un_build_id
end

function YiFangLingTianModel:GetISOpen()
local Un_build_id=YiFangLingTianModel:GetUn_build_id()
if not Un_build_id or tostring(Un_build_id)=='0'then
return false
end
return true
end



function YiFangLingTianModel:SetYFLTgeziData(gezilist)
for k,v in ipairs(self.data.gezilist)do
if v.x==gezilist.x and v.y==gezilist.y then
self.data.gezilist[k]=gezilist
end
end
YiFangLingTianModel:RefreshPlanttime()
end


function YiFangLingTianModel:againPlant(len,gezilist)
for k,v in ipairs(gezilist)do
local idx=YiFangLingTianController:xyToIdx(v.param_1,v.param_2)
local data=YiFangLingTianModel:GetSingleGridData(idx)
local itemid=data.item_id
local pos_idx=data.pos_idx
local havenum=itemsModel.getCount(itemid)
if havenum>0 then
YiFangLingTianController:req_3_81(itemid,pos_idx,v.param_1,v.param_2)
end
end
end


function YiFangLingTianModel:ChangeYFLTData(gezilist)
self.data.gezilist=gezilist
end

function YiFangLingTianModel:ChangeChanChuData(x,y)
if self.data.gezilist then
for k,v in ipairs(self.data.gezilist)do
if v.x==x and v.y==y then
v.pos_idx=0
v.item_id=0
v.begintimes=0
v.ex_times=0
v.total_times=0
end
end
end
end

function YiFangLingTianModel:Setbegintimes(ly_begintimes)

self.data.ly_begintimes=ly_begintimes
end

function YiFangLingTianModel:Getbegintimes()
if not self.data.ly_begintimes then
self.data.ly_begintimes=0
end
return self.data.ly_begintimes
end



function YiFangLingTianModel:GetLingYeNum()
local nowtime=timeHelper.getServerShortTime()
local lt_constcfg=cfg_yifanglintianconfig().const_def

local max_lingye_cnt=lt_constcfg.max_lingye_cnt

if not self.data.ly_begintimes or self.data.ly_begintimes==0 then
local max_cnt=max_lingye_cnt[0]
return 0,max_cnt
end
local gubaolv=xianbaoModel:getXbStart_liandon(cfg_yifanglintianconfig().const_def.unlock_lingye_gubao_id)

local per_lingye_times=lt_constcfg.per_lingye_times

local max_cnt=max_lingye_cnt[gubaolv]
local nownum=math.floor((nowtime-self.data.ly_begintimes)/per_lingye_times[gubaolv])

if nownum>max_cnt then
nownum=max_cnt
end
nownum=nownum+self.data.extranum
return nownum,max_cnt
end


function YiFangLingTianModel:GetLingYeTime()
local nowtime=timeHelper.getServerShortTime()
if not self.data.ly_begintimes or self.data.ly_begintimes==0 then
return 0,0
end
local lt_constcfg=cfg_yifanglintianconfig().const_def

local per_lingye_times=lt_constcfg.per_lingye_times

local max_lingye_cnt=lt_constcfg.max_lingye_cnt
local gubaolv=xianbaoModel:getXbStart_liandon(cfg_yifanglintianconfig().const_def.unlock_lingye_gubao_id)
local max_cnt=max_lingye_cnt[gubaolv]
local nownum=math.floor((nowtime-self.data.ly_begintimes)/per_lingye_times[gubaolv])
nownum=nownum+self.data.extranum
if nownum>=max_cnt then
return 0,0
else

local yettime=nownum*per_lingye_times[gubaolv]

local nexttime=per_lingye_times[gubaolv]-(nowtime-self.data.ly_begintimes-yettime)

local alltime=max_cnt*per_lingye_times[gubaolv]+self.data.ly_begintimes

local alltime_S=alltime-nowtime
return nexttime,alltime_S
end
end


function YiFangLingTianModel:GetDiziReduceTime(dzid)
if tostring(dzid)=='0'then
return
end
local lt_constcfg=cfg_yifanglintianconfig().const_def
local buildid=lt_constcfg.buildId
local bd_tybe_cfg=cfg_monijybuildconfig_get(buildid)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzid,skill_id)

local dizi_pzlvl_reduce_times=lt_constcfg.dizi_pzlvl_reduce_times

for k,v in ipairs(dizi_pzlvl_reduce_times)do
if level>=v[1]and level<=v[2]then
return v[3]
end
end
end
return 0
end


function YiFangLingTianModel:GetLVReduceTime(level)
local lt_constcfg=cfg_yifanglintianconfig().const_def

local dizi_pzlvl_reduce_times=lt_constcfg.dizi_pzlvl_reduce_times

for k,v in ipairs(dizi_pzlvl_reduce_times)do
if level>=v[1]and level<=v[2]then
return v[3]
end
end
return 0
end



function YiFangLingTianModel:GetNowPlantData()
if self.data.gezi_len<=0 then
return{}
else
local plantTb={}
for k,v in ipairs(self.data.gezilist)do
if v.item_id>0 then
table.insert(plantTb,v)
end
end
return plantTb
end
end


function YiFangLingTianModel:GetCanPickPlant()
local CanPickPlant={}
for k,v in ipairs(self.data.gezilist)do
if v.item_id>0 then
local group_conf=cfgHelper.get2(cfg_yifanglintianconfig_get,v.item_id,'group_conf')
local nowtime=gameUtilityModel.getServerShortTime()

local grouptime=v.total_times
if group_conf then
local mintime=group_conf[1][1]
if grouptime>=mintime then
table.insert(CanPickPlant,v)
end
end
end
end
return CanPickPlant
end


function YiFangLingTianModel:GetCanCuiShuPlantData()
local CanCuiShuPlant={}
for k,v in ipairs(self.data.gezilist)do
if v.item_id>0 then
local group_conf=cfgHelper.get2(cfg_yifanglintianconfig_get,v.item_id,'group_conf')
local nowtime=gameUtilityModel.getServerShortTime()

local grouptime=v.total_times
if group_conf then
local maxtime=group_conf[#group_conf][1]
if grouptime<maxtime then
table.insert(CanCuiShuPlant,v)
end
end
end
end
return CanCuiShuPlant
end


function YiFangLingTianModel:GetSingeGezi(x,y)
for k,v in ipairs(self.data.gezilist)do
if v.x==x and v.y==y then
return v
end
end
return
end



function YiFangLingTianModel:getGameYear(shortStamp_s,shortStamp_e)
local a=shortStamp_s
local b=shortStamp_e or gameUtilityModel.getServerShortTime()
return gameUtilityModel.getGameYearPass3(a,b)
end



function YiFangLingTianModel:GetMaxYear(itemid)
local group_conf=cfgHelper.get2(cfg_yifanglintianconfig_get,itemid,'group_conf')
local index=#group_conf
local year=gameUtilityModel.calculateGameYearCeil(group_conf[index][1])
return year
end


function YiFangLingTianModel:GetNextYear(itemid,total_times)
local group_conf=cfgHelper.get2(cfg_yifanglintianconfig_get,itemid,'group_conf')

local nowPlanttime=total_times
for k,v in ipairs(group_conf)do
if nowPlanttime<v[1]then

local needtime=v[1]-nowPlanttime
return v[1],needtime
end
end
return 0
end


function YiFangLingTianModel:GetNextJieDuan(itemid,total_times)
local group_conf=cfgHelper.get2(cfg_yifanglintianconfig_get,itemid,'group_conf')

local nowPlanttime=total_times
if not nowPlanttime then
return nil
end
for k,v in ipairs(group_conf)do
if nowPlanttime<v[1]then
return k-1
end
end
return#group_conf
end


function YiFangLingTianModel:GetNowIndexBybegintimes(itemid,total_times)
local grow_conf=cfgHelper.get2(cfg_yifanglintianconfig_get,itemid,'grow_conf')

local nowPlanttime=total_times
if not nowPlanttime then
return nil
end

for k,v in ipairs(grow_conf)do
if nowPlanttime<v then
if k-1==0 then

return 1
end
return k-1
end
end

return#grow_conf
end


function YiFangLingTianModel:RecordSetting(showType,again)
userActorSetting.set("YiFangLingTianSetting",{showType=showType,again=again})
userActorSetting.flush()
end

function YiFangLingTianModel:loadRecord_Setting()
local record=userActorSetting.get("YiFangLingTianSetting",{})
self.data.show=record["showType"]or 1
self.data.again=record["again"]
end

function YiFangLingTianModel:Get_Setting()
YiFangLingTianModel:loadRecord_Setting()
return self.data.show,self.data.again
end


function YiFangLingTianModel:RecordDiZiShow(flag)
userActorSetting.set("YiFangLingDiZiShow",{showflag=flag})
userActorSetting.flush()
end


function YiFangLingTianModel:loadRecordDiZiShow()
local record=userActorSetting.get("YiFangLingDiZiShow",{})
self.data.DZinfoShow=record["showflag"]
end


function YiFangLingTianModel:Get_DZinfoShow()
YiFangLingTianModel:loadRecordDiZiShow()

if self.data.DZinfoShow==nil then
self.data.DZinfoShow=true
end
return self.data.DZinfoShow
end


function YiFangLingTianModel:Get_HaveItemAndLy()
local lynum=YiFangLingTianModel:GetLingYeNum()
local lt_constcfg=cfg_yifanglintianconfig().const_def
local gubaolv=xianbaoModel:getXbStart_liandon(cfg_yifanglintianconfig().const_def.unlock_lingye_gubao_id)
local lyreducetime=lt_constcfg.lingye_redece_times
local lyreducetime=lyreducetime[gubaolv]
local reduce_time_item_conf=lt_constcfg.reduce_time_item_conf
local itemid=0
local itemreducetime=0
for k,v in pairs(reduce_time_item_conf)do
itemid=k
itemreducetime=v
end
local havenum=itemsModel.getCount(itemid)
if lynum<0 then
lynum=0
end
return lynum,havenum,lyreducetime,itemreducetime,itemid
end

function YiFangLingTianModel:GetMaxPlant()
local PlantData=YiFangLingTianModel:GetNowPlantData()
for k,v in ipairs(PlantData)do
local index=YiFangLingTianModel:GetNextJieDuan(v.item_id,v.total_times)
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,v.item_id)
local group_conf=cfg.group_conf
if index==#group_conf then
return true
end
end

end


function YiFangLingTianModel:exitPlantModel(arg)
UIManager:showWindow("UIYiFangLingTianMain",arg)

UIManager:invokeUIMethod("UIYFLTSelectPlantMain","revertPosition")
end


function YiFangLingTianModel:JumpToCuiShu()
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eYiFangLingTian,args={cuishuwin=true}}},nil)
end


function YiFangLingTianModel:RefreshPlanttime()
if not YiFangLingTianModel:GetISOpen()then
return
end
if self.data and self.data.gezilist and self.data.gezi_len>0 then







for k,v in ipairs(self.data.gezilist)do
if v.item_id~=0 then
local dzid=YiFangLingTianModel:GetNowDzID()
local reduce_times=0
if tostring(dzid)~='0'then

reduce_times=YiFangLingTianModel:GetDiziReduceTime(YiFangLingTianModel:GetNowDzID())
end
local passTime=timeHelper.getServerShortTime()-v.begintimes
local realPassTime=passTime/(1-reduce_times/100)

self.data.gezilist[k].total_times=v.ex_times+realPassTime
end
end
end
end


function YiFangLingTianModel:Refreshtime()
if not YiFangLingTianModel:GetISOpen()then
return
end
local num,maxnum=YiFangLingTianModel:GetLingYeNum()
if num==maxnum and maxnum>0 then

reddotControl.on_change_catch_type(CATCH_TYPE.eXianBao)
end
if self.data.un_build_id and self.data.un_build_id~=0 then
hudControl:refreshBuildingStatusHUD(self.data.un_build_id)
end
end

function YiFangLingTianModel:openlyGainWin()
local args={}
local extraParams={}
args.titleName='获取途径'
args.pos=2
args.extraWin='UIYFLTMoneyGainWin'

local lt_constcfg=cfg_yifanglintianconfig().const_def
local itemid=lt_constcfg.ly_itemid
local config=itemsConfig.getConfig(itemid)
extraParams.goodName=config.name
extraParams.goodId=itemid
local lynum=YiFangLingTianModel:Get_HaveItemAndLy()
extraParams.goodNum=lynum
extraParams.showgoodNum=true
extraParams.goodIconName=iconHelper.getIconName(itemid)
extraParams.goodColor=config.color
local colorPage=config.colorPage or 0
extraParams.goodColorPage=colorPage
extraParams.goodSignIcon=config.signIcon
extraParams.goodDesc=config.desc
extraParams.goodProduce=table.deepCopy(config.produce)
extraParams.isLY=true
args.extraParams=extraParams

UIManager:showWindow('UICommonPageWin',args)
end


function YiFangLingTianModel:openPlantGainWin()
local args={}
local extraParams={}
args.titleName='获取途径'
args.pos=2
args.extraWin='UIYFLTMoneyGainWin'


local itemid=29024
local config=itemsConfig.getConfig(itemid)
extraParams.goodName=config.name
extraParams.goodId=itemid
extraParams.goodNum=0
extraParams.showgoodNum=false
extraParams.goodIconName=iconHelper.getIconName(itemid)
extraParams.goodColor=config.color
local colorPage=config.colorPage or 0
extraParams.goodColorPage=colorPage
extraParams.goodSignIcon=config.signIcon
extraParams.goodDesc=config.desc
extraParams.goodProduce=table.deepCopy(config.produce)
args.extraParams=extraParams

UIManager:showWindow('UICommonPageWin',args)
end


function YiFangLingTianModel:JudeIsFinishByid(item_id,total_times)
local group_conf=cfgHelper.get2(cfg_yifanglintianconfig_get,item_id,'group_conf')
local index=#group_conf
local maxtime=group_conf[index][1]

local nowPlanttime=total_times
return nowPlanttime>=maxtime
end




function YiFangLingTianModel:HandleGridData(gezilist)
self.gridDatas={}

for i,v in ipairs(gezilist or{})do
local x,y=v.x,v.y
local idx=YiFangLingTianController:xyToIdx(x,y)
self.gridDatas[idx]=table.weakCopy(v)
end

for i,v in pairs(self.gridDatas)do
if v.item_id~=0 then
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,v.item_id)
local coordinate_conf=cfg.coordinate_conf[v.pos_idx]
local x,y=v.x,v.y
for _,gridPos in ipairs(coordinate_conf)do
local x_offest,y_offest=unpack(gridPos)
local x_grid=x+x_offest-1
local y_grid=y+y_offest-1
if x_grid~=x or y_grid~=y then
local idx=YiFangLingTianController:xyToIdx(x_grid,y_grid)
if self.gridDatas[idx]then
self.gridDatas[idx].combinedGridIdx=YiFangLingTianController:xyToIdx(x,y)
else



end
end
end
end
end

end


function YiFangLingTianModel:HandleSingleGridData(gridData,is_clean)
local x,y=gridData.x,gridData.y
local idx=YiFangLingTianController:xyToIdx(x,y)
if is_clean then
local initData={
x=x,
y=y,
pos_idx=0,
item_id=0,
begintimes=0,
}
self.gridDatas[idx]=initData
else
self.gridDatas[idx]=table.weakCopy(gridData)
end
local temp={}
table.insert(temp,idx)

if gridData.item_id~=0 then
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,gridData.item_id)
local coordinate_conf=cfg.coordinate_conf[gridData.pos_idx]
for _,gridPos in ipairs(coordinate_conf)do
local x_offest,y_offest=unpack(gridPos)
local x_grid=x+x_offest-1
local y_grid=y+y_offest-1
if x_grid~=x or y_grid~=y then
local combinedIdx=YiFangLingTianController:xyToIdx(x_grid,y_grid)
if self.gridDatas[combinedIdx]then
if is_clean then
local initData={
x=x_grid,
y=y_grid,
pos_idx=0,
item_id=0,
begintimes=0,
}
self.gridDatas[combinedIdx]=initData
else
self.gridDatas[combinedIdx].combinedGridIdx=idx
end
table.insert(temp,combinedIdx)
else



end
end
end
end
if is_clean then
UIManager:invokeUIMethod("UIYFLTMapWin","cleanGrid",temp)
else
UIManager:invokeUIMethod("UIYFLTMapWin","plantedGrid",temp)
end

end


function YiFangLingTianModel:HandleCleanGridData(x,y)
local idx=YiFangLingTianController:xyToIdx(x,y)
local gridData=self.gridDatas[idx]
YiFangLingTianModel:HandleSingleGridData(gridData,true)
end


function YiFangLingTianModel:HandleUnlockGridData(geziList)
for i,v in ipairs(geziList)do
local x,y=v.param_1,v.param_2
local idx=YiFangLingTianController:xyToIdx(x,y)
local gridData={
x=x,
y=y,
pos_idx=0,
item_id=0,
begintimes=0,
}
self.gridDatas[idx]=gridData
end
end


function YiFangLingTianModel:GetUnlockGridNum()
return table.numsEx(self.gridDatas)
end


function YiFangLingTianModel:GetGridData()
return self.gridDatas
end


function YiFangLingTianModel:GetSingleGridData(idx)
return self.gridDatas[idx]
end


function YiFangLingTianModel:GetPlantGrowthStage(idx)
local data=self.gridDatas[idx]
if not data then
return 0,0
end
local itemid=data.item_id
if itemid==0 then
return 0,0
end
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,itemid)
local beginTime=data.begintimes
if beginTime<=0 then
return 0,0
end
local x,y=YiFangLingTianController:idxToXY(idx)
local exData=YiFangLingTianModel:GetSingeGezi(x,y)or{}

local growTime=exData.total_times or 0
local grow_conf=cfg.grow_conf
local plantStage=1
for stage=#grow_conf,1,-1 do
if growTime>=grow_conf[stage]then
plantStage=stage
break
end
end
return plantStage,#grow_conf
end


function YiFangLingTianModel:CheckPlantHarvest(idx)
local plantStage,maxStage=self:GetPlantGrowthStage(idx)
return plantStage>0 and plantStage>=maxStage
end


function YiFangLingTianModel:HasHarvestPlant()
for idx,gridData in pairs(self.gridDatas or defaultT)do
if YiFangLingTianModel:CheckPlantHarvest(idx)then
return true
end
end
return false
end


function YiFangLingTianModel:HarvestMaturePlant(is_assistant)
local temp={}
for idx,gridData in pairs(self.gridDatas)do
if YiFangLingTianModel:CheckPlantHarvest(idx)then
local x,y=gridData.x,gridData.y
table.insert(temp,{x,y})
end
end
YiFangLingTianController:req_3_84(#temp,temp,is_assistant or 0)
end


function YiFangLingTianModel:GetMaturePlantSmallIcon()
local showItemId,curColor
for idx,gridData in pairs(self.gridDatas)do
if YiFangLingTianModel:CheckPlantHarvest(idx)then
local itemid=gridData.item_id
local color=itemsConfig.getItemColor(itemid)
if not showItemId then
showItemId=itemid
curColor=color
elseif color>=curColor then
showItemId=itemid
curColor=color
end
end
end
if not showItemId then
return
end
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,showItemId)
if not cfg then
return
end
local growItemId=cfg.groupstage_itemid[#cfg.groupstage_itemid]
local itemIcon=iconHelper.getIconName(growItemId)
return itemIcon
end


function YiFangLingTianModel:getPlantedGridNum()
local gridDatas=YiFangLingTianModel:GetGridData()
local num=0
for idx,_ in pairs(gridDatas)do
if YiFangLingTianController:getGridState(idx)==YFLTGridState.ePlanted then
num=num+1
end
end
return num
end
