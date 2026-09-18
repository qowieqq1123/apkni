






local _MODULENAME="yushoufangModel"




def_table(_MODULENAME)
yushoufangModel.name=_MODULENAME




yushoufangModel.data={}
yushoufangModel.hud={}
local sortFunction={
[eDiscipleSortType.eJingJieSort]=function(sortOrder)
local sortFunc=function(a,b)
local zizhiA=lingshouModel.getLingShouPropertyVal(a,lingshouPropertyType.ZIZHI)
local zizhiB=lingshouModel.getLingShouPropertyVal(b,lingshouPropertyType.ZIZHI)
if a.jj_lvl~=b.jj_lvl then
return helper.sortOrderComparis(a.jj_lvl,b.jj_lvl,sortOrder)
elseif zizhiA~=zizhiB then
return helper.sortOrderComparis(zizhiA,zizhiB,sortOrder)
else
local aColor=lingshouModel:getColor(a.guid)
local bColor=lingshouModel:getColor(b.guid)
if aColor~=bColor then
return helper.sortOrderComparis(aColor,bColor,sortOrder)
else
local aFY=lingshouModel.getFanYanLeastEx(a)
local bFY=lingshouModel.getFanYanLeastEx(b)
if aFY~=bFY then
return helper.sortOrderComparis(aFY,bFY,sortOrder)
else
return helper.sortOrderComparis(a.cfg.race,a.cfg.race,sortOrder)
end
end
end
end
return sortFunc
end,
[eDiscipleSortType.eZiZhi]=function(sortOrder)
local sortFunc=function(a,b)
local zizhiA=lingshouModel.getLingShouPropertyVal(a,lingshouPropertyType.ZIZHI)
local zizhiB=lingshouModel.getLingShouPropertyVal(b,lingshouPropertyType.ZIZHI)
if zizhiA~=zizhiB then
return helper.sortOrderComparis(zizhiA,zizhiB,sortOrder)
elseif a.jj_lvl~=b.jj_lvl then
return helper.sortOrderComparis(a.jj_lvl,b.jj_lvl,sortOrder)
else
local aColor=lingshouModel:getColor(a.guid)
local bColor=lingshouModel:getColor(b.guid)
if aColor~=bColor then
return helper.sortOrderComparis(aColor,bColor,sortOrder)
else
local aFY=lingshouModel.getFanYanLeastEx(a)
local bFY=lingshouModel.getFanYanLeastEx(b)
if aFY~=bFY then
return helper.sortOrderComparis(aFY,bFY,sortOrder)
else
return helper.sortOrderComparis(a.cfg.race,a.cfg.race,sortOrder)
end
end
end
end
return sortFunc
end,
[eDiscipleSortType.eFanYan]=function(sortOrder)
local sortFunc=function(a,b)
local aFY=lingshouModel.getFanYanLeastEx(a)
local bFY=lingshouModel.getFanYanLeastEx(b)
local zizhiA=lingshouModel.getLingShouPropertyVal(a,lingshouPropertyType.ZIZHI)
local zizhiB=lingshouModel.getLingShouPropertyVal(b,lingshouPropertyType.ZIZHI)
if aFY~=bFY then
return helper.sortOrderComparis(aFY,bFY,sortOrder)
elseif a.jj_lvl~=b.jj_lvl then
return helper.sortOrderComparis(a.jj_lvl,b.jj_lvl,sortOrder)
elseif zizhiA~=zizhiB then
return helper.sortOrderComparis(zizhiA,zizhiB,sortOrder)
else
local aColor=lingshouModel:getColor(a.guid)
local bColor=lingshouModel:getColor(b.guid)
if aColor~=bColor then
return helper.sortOrderComparis(aColor,bColor,sortOrder)
else
return helper.sortOrderComparis(a.cfg.race,a.cfg.race,sortOrder)
end
end
end
return sortFunc
end,
}


function yushoufangModel:onAppStart()
self.data.selectlist={}
end


function yushoufangModel:onEnterState()

end


function yushoufangModel:onLeaveState()

self.data={}
self.hud={}
end


function yushoufangModel:onServerDataInitFinish()

end


function yushoufangModel:setYSFBuildSingleData(petBornData)
if not self.data.ysf_list then
self.data.ysf_list={}
end
if petBornData then

self.data.ysf_list[petBornData.un_build_id]=petBornData
end
end


function yushoufangModel:setYSFBuildData(len,petBornDatas)
if not self.data.ysf_list then
self.data.ysf_list={}
end

if len>0 and petBornDatas then
for k,v in ipairs(petBornDatas)do
self.data.ysf_list[v.un_build_id]=v
end
end
end


function yushoufangModel:setYSFFangYanData(un_build_id,len,list,item_id)
if not self.data.ysf_parent_list then
self.data.ysf_parent_list={}
end
if len>0 and list then
self.data.ysf_parent_list[un_build_id]=list
end
end


function yushoufangModel:freshYSFFuMoTime(un_build_id,soothe_time,group_end_time)
if self.data.ysf_list then
if self.data.ysf_list[un_build_id]then
self.data.ysf_list[un_build_id].soothe_time=soothe_time
self.data.ysf_list[un_build_id].group_end_time=group_end_time
end
end
end


function yushoufangModel:setYSFRewards(len,lsguidList)

if len>0 and lsguidList then
if self.data.ysf_list then
for k,v in ipairs(lsguidList)do
if self.data.ysf_list[v.param_2]then
self.data.ysf_list[v.param_2].new_lingshou_len=0
self.data.ysf_list[v.param_2].newLingShouList=nil
self.data.ysf_list[v.param_2].group_end_time=0
self.data.ysf_list[v.param_2].soothe_time=0
self.data.ysf_list[v.param_2].group_begin_time=0
end
end
end
end
end



function yushoufangModel:getLSBuildingData()
local bdDatas=zongmenModel:getBuildingDataByBdId(mapIdType.lingshoudao,SLG_SYSTEM_TYPE.eYuShouFang)
return bdDatas
end


function yushoufangModel:getLSDataByBuildID(un_build_id)
if self.data.ysf_list and self.data.ysf_list[un_build_id]then
return self.data.ysf_list[un_build_id]
end
return false
end


function yushoufangModel:getLSNewDataByBuildID(un_build_id)
if self.data.ysf_list and self.data.ysf_list[un_build_id]then
if self.data.ysf_list[un_build_id].newLingShouList then
return self.data.ysf_list[un_build_id].newLingShouList
end
end
return false
end


function yushoufangModel:getLSGroupTimeByBuildID(un_build_id)
if self.data.ysf_list then
if self.data.ysf_list[un_build_id]then
return self.data.ysf_list[un_build_id].group_end_time
end
end
return 0
end




function yushoufangModel:setLSChooseData(un_build_id,index,lsguid)
if not self.data.selectlist then
self.data.selectlist={}
end
if not self.data.selectlist[un_build_id]then
self.data.selectlist[un_build_id]={}
end
self.data.selectlist[un_build_id][index]=lsguid
end

function yushoufangModel:getLSChooseData(un_build_id,index)
if self.data.selectlist then
if self.data.selectlist[un_build_id]then
if self.data.selectlist[un_build_id][index]then
return self.data.selectlist[un_build_id][index]
end
end
end
return false
end

function yushoufangModel:clearLSChooseData()
if self.data.selectlist then
self.data.selectlist={}
end
self:clearLSItemId()
end

function yushoufangModel:clearLSChooseSingleData(un_build_id)
if self.data.selectlist and self.data.selectlist[un_build_id]then
self.data.selectlist[un_build_id]={}
end
self:clearLSItemId()
end

function yushoufangModel:setLSItemId(itemid)
self.data.selectitemid=itemid
end

function yushoufangModel:getLSItemId()
return self.data.selectitemid or 0
end

function yushoufangModel:clearLSItemId()
self.data.selectitemid=nil
end


function yushoufangModel:getNewCDTimes(un_build_id,grow_time)
local bdData=zongmenModel:getBuildingData(un_build_id)
if bdData then
local dzId=bdData.dizi_id
local haveDz=dzId and dzId~=int64.zero or false
if haveDz then
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,DISCIPLE_PROSKILL_TYPE.eSiYang)
local cfg=cfgHelper.get2(cfg_discipleproskillconfig_get,DISCIPLE_PROSKILL_TYPE.eSiYang,'lingshouborn_reduce_time')
end
end
return grow_time
end


function yushoufangModel:checkYSFShouLanDzFire(sfId,ubdId,okCallBack)


local bdData=zongmenModel:getBuildingData(ubdId)
local dzId=bdData.dizi_id
local hasDZ=tostring(dzId)~='0'
if not hasDZ then

return true
end

local ls1=yushoufangModel:getLSChooseData(ubdId,1)
if ls1 then
UIManager.info('已选择灵兽，不可卸任')
return false
end
local ls2=yushoufangModel:getLSChooseData(ubdId,2)
if ls2 then
UIManager.info('已选择灵兽，不可卸任')
return false
end

local nowTime=timeHelper.getServerShortTime()
local data=yushoufangModel:getLSDataByBuildID(ubdId)
if data then
local group_end_time=data.group_end_time
if group_end_time>0 and group_end_time>nowTime then
UIManager.info('该育兽房的灵兽成长中，不可更换')
return false
end
end

local state=UIDiscipleModel:getDiscipleState(dzId)
if state==DISCIPLE_STATE_TYPE.eChuiWei then
UIManager.error('弟子垂危中')
return false
end
return true
end

function yushoufangModel.addThrowOutAndSliderTipsEx(args)
local win=UIManager:findActiveWindow('UIYSFThrowOutAndSlideWin')
if win then
win:addMessage(args)
else
UIManager:showWindow('UIYSFThrowOutAndSlideWin',args)
end
end

function yushoufangModel:isCanFuMo(sfId,un_build_id)
local data=yushoufangModel:getLSDataByBuildID(un_build_id)
if data then
local soothe_time=data.soothe_time
local nowtime=timeHelper.getServerShortTime()
local group_end_time=data.group_end_time or 0
if group_end_time>0 and group_end_time>nowtime then
local config=cfg_lingshoubabybasicconfig_get(1)
local afjiange=config.soothe_conf and config.soothe_conf[1]or 0
local canfm=soothe_time+afjiange
if canfm<nowtime then
return true
end
end
end
return false
end

function yushoufangModel:isCanFanYu(sfId,un_build_id)
local data=yushoufangModel:getLSDataByBuildID(un_build_id)
if data then
local group_end_time=data.group_end_time

local nowtime=timeHelper.getServerShortTime()
if group_end_time>0 and group_end_time>nowtime then
return true
end
end
return false
end

function yushoufangModel:isCanGetFanYu(sfId,un_build_id)
local nowTime=timeHelper.getServerShortTime()
local data=yushoufangModel:getLSDataByBuildID(un_build_id)
if data then
local group_end_time=data.group_end_time
if group_end_time>0 and group_end_time<nowTime then

return true
end
end
return false
end

function yushoufangModel.hasReddotInfo(un_build_id)
local flag
flag=yushoufangModel:isCanGetFanYu(2,un_build_id)
if flag then
return flag,1
end
flag=yushoufangModel:isCanFuMo(2,un_build_id)
if flag then
return flag,2
end
flag=yushoufangModel:isCanFanYu(2,un_build_id)
if flag then
return flag,3
end
return false
end

function yushoufangModel.freshBuildingHUD(sfId,ubdId)
local bdData=zongmenModel:getBuildingData(ubdId)
if not bdData then return end
local isreddot,flag=yushoufangModel.hasReddotInfo(ubdId)
if isreddot then
buildingCDControl:addCDData(buildingCDType.yushoufang,bdData)
else
buildingCDControl:removeCDData(buildingCDType.yushoufang,ubdId)
end
hudControl:refreshBuildingStatusHUD(ubdId)
end

function yushoufangModel:getOneKeysLSRewardsList()
local temp={}
local ysfbdDatas=yushoufangModel:getLSBuildingData()
for k,v1 in ipairs(ysfbdDatas)do
local un_build_id=v1.un_build_id
local data=yushoufangModel:getLSDataByBuildID(un_build_id)
if data then
local nowTime=timeHelper.getServerShortTime()
local group_end_time=data.group_end_time
if group_end_time>0 and group_end_time<nowTime then
temp[#temp+1]=un_build_id
end
end
end
return temp
end


