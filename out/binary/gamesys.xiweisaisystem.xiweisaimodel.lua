






local _MODULENAME="XiWeiSaiModel"


def_table(_MODULENAME)
XiWeiSaiModel.name=_MODULENAME
XiWeiSaiModel.data={}

function XiWeiSaiModel:onAppStart()

end


function XiWeiSaiModel:onEnterState(isReconnect)

end


function XiWeiSaiModel:onProtocolReq()

end


function XiWeiSaiModel:onLeaveState(isReconnect)

self.data={}
end



function XiWeiSaiModel:getData()
return self.data
end

function XiWeiSaiModel:getData_startTime()
return self.data.startTime or 0
end

function XiWeiSaiModel:getData_fightCnt()
return self.data.fightCnt or 0
end

function XiWeiSaiModel:getData_attendCnt()
return self.data.attendCnt or 0
end

function XiWeiSaiModel:getData_xfwdStage()
return self.data.xfwdStage or 0
end

function XiWeiSaiModel:getData_pos()
return self.data.pos_id
end

function XiWeiSaiModel:getData_group()
if self.data.group and self.data.group~=0 then
return self.data.group
end
return WDCQCGroupEnum.eFangXiu
end

function XiWeiSaiModel:getData_grouplookUpList()
return self.data.grouplookUpList
end

function XiWeiSaiModel:getData_grouplookUp(group)
if not self.data.grouplookUpList then
return
end
return self.data.grouplookUpList[group]
end













function XiWeiSaiModel:getData_groupPos(group,pos)
if not self.data.grouplookUpList then
return
end
return self.data.grouplookUpList[group]and self.data.grouplookUpList[group][pos]
end

function XiWeiSaiModel:getData_logList()
return self.data.logList
end

function XiWeiSaiModel:getData_teamList()
return self.data.teamList
end




local abName="ui/windows/wendingcangqiong/wdcq_atlas_pak.ab"
local groupImageList=
{
"image_wdcqdwz_1",
"image_wdcqdwz_2",
"image_wdcqdwz_3",
"image_wdcqdwz_4",
}
function XiWeiSaiModel:getConfig_abName()
return abName
end

function XiWeiSaiModel:getConfig_groupImageList()
return groupImageList
end

function XiWeiSaiModel:getConfig_startTime()
local begin_time=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'begin_time')
local stamp=XiWeiSaiController.changeCfgTime(begin_time[1],begin_time[2],begin_time[3])
return stamp
end

function XiWeiSaiModel:getConfig_endTime()
local end_time=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'end_time')
local stamp=XiWeiSaiController.changeCfgTime(end_time[1],end_time[2],end_time[3])
return stamp
end

function XiWeiSaiModel:getConfig_nextEndTime()
local end_time=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'end_time')
local stamp=XiWeiSaiController.changeCfgTime(end_time[1],end_time[2],end_time[3],true)
return stamp
end

function XiWeiSaiModel:getConfig_stopFightTime()
local stop_time=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'stop_time')
local stamp=XiWeiSaiController.changeCfgTime(stop_time[1],stop_time[2],stop_time[3])
return stamp
end

function XiWeiSaiModel:getConfig_protect_sec()
local protect_sec=cfgHelper.get2(cfg_wendingcangqionghaixuanconfig_get,1,'protect_sec')
return protect_sec
end

