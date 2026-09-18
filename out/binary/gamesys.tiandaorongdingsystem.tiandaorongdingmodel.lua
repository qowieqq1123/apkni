






local _MODULENAME="tianDaoRongDingModel"


def_table(_MODULENAME)
tianDaoRongDingModel.name=_MODULENAME
tianDaoRongDingModel.data={}

function tianDaoRongDingModel:onAppStart()

end


function tianDaoRongDingModel:onEnterState(isReconnect)
tianDaoRongDingModel:init()
end


function tianDaoRongDingModel:onLeaveState(isReconnect)

tianDaoRongDingModel:init()
end

function tianDaoRongDingModel:init()
self.data={}
self.data.fangan={}
self.data.fangan.planLookup={}
self.selectId=nil
self.lianzhicnt=nil
end

function tianDaoRongDingModel:resetCnt()
if self.data and self.data.fangan then
self.data.fangan.planLookup={}
end
end




function tianDaoRongDingModel:initData(id,len,array,beginstamp,cnt)
self.data.fangan={}
local fangan=self.data.fangan


fangan.planLookup={}
if len>0 then
for i=1,len do
local v=array[i]
fangan.planLookup[v.param_1]=v.param_2
end
end
self.lianzhicnt=cnt
tianDaoRongDingModel:setFanganInfo(id,beginstamp)
end

function tianDaoRongDingModel:onLianZhi(id,cnt)
tianDaoRongDingModel:setFanganInfo(id,timeHelper.getServerShortTime(),cnt)
self.lianzhicnt=cnt
self.data.fangan.planLookup[id]=cnt+(self.data.fangan.planLookup[id]or 0)
end

function tianDaoRongDingModel:setFanganInfo(id,beginstamp,cnt)
if id==nil or id<=0 then return end
if self.data.fangan==nil then self.data.fangan={}end
local fangan=self.data.fangan
fangan.id=id
fangan.beginstamp=beginstamp
local cost=tianDaoRongDingModel:getLianZhiTime(id)
fangan.endstamp=fangan.beginstamp+cost
fangan.itemid=tianDaoRongDingModel:getLianZhiItemId(id)
fangan.lianzhicnt=1
if cnt then
fangan.lianzhicnt=cnt
end
tianDaoRongDingModel:addCDData()
tianDaoRongDingModel:freshBuildingStatusHUD()
end

function tianDaoRongDingModel:clearFanganInfo()
if self.data.fangan==nil then self.data.fangan={}end
local fangan=self.data.fangan
fangan.id=0
fangan.beginstamp=nil
fangan.endstamp=nil
fangan.itemid=nil
fangan.lianzhicnt=nil
tianDaoRongDingModel:closeProgress()
tianDaoRongDingModel:removeCDData()
tianDaoRongDingModel:freshBuildingStatusHUD()
end


function tianDaoRongDingModel:isFanganActive(id)
return fangan.planLookup[id]~=nil
end

function tianDaoRongDingModel:isCanPrize()
if not tianDaoRongDingModel:hasPeiFang()then return false end
return timeHelper.getServerShortTime()>=self.data.fangan.endstamp
end

function tianDaoRongDingModel:hasPeiFang()
if self.data.fangan==nil or self.data.fangan.id==nil then return false end
return self.data.fangan.id>0
end

function tianDaoRongDingModel:getPeiFangId()
return self.data.fangan.id
end

function tianDaoRongDingModel:getPeiFanglzcnt()
return self.lianzhicnt or 0
end

function tianDaoRongDingModel:getFanganItemid()
return self.data.fangan.itemid
end

function tianDaoRongDingModel:getTime()
local fangan=self.data.fangan
return fangan.beginstamp,fangan.endstamp
end


function tianDaoRongDingModel:isGuDingFangAn(id)
local costlist=cfgHelper.get2(cfg_tdrlplanconfig_get,id,'cost')
return#costlist==1
end





function tianDaoRongDingModel:getLianZhiTime(id)
return cfgHelper.get2(cfg_tdrlplanconfig_get,id,'need_time')
end

function tianDaoRongDingModel:getStartedLianZhiTime(id)
if self.data.fangan==nil then return 0 end
local beginstamp=self.data.fangan.beginstamp
return timeHelper.getServerShortTime()-beginstamp
end

function tianDaoRongDingModel:getLeftLianZhiTime(id)
if self.data.fangan==nil then return 0 end
local beginstamp=self.data.fangan.beginstamp
local cost=tianDaoRongDingModel:getLianZhiTime(id)
local endstamp=beginstamp+cost
local left=endstamp-timeHelper.getServerShortTime()
if left<0 then left=0 end
return left
end

function tianDaoRongDingModel:getLeftLianZhiCnt(id)
local max=cfgHelper.get2(cfg_tdrlplanconfig_get,id,'week_lz_times')
if self.data.fangan==nil then
return max
end
local cnt=self.data.fangan.planLookup[id]or 0
local lerp=max-cnt
if lerp<0 then lerp=0 end
return lerp,max
end




local _func=
{
[1]=function(ubdId,v)
local val=v[2]
local data=zongmenModel:getBuildingData(ubdId)
return data.level>=val
end,
[2]=function(ubdId,v)
local gbid=v[2]
return gubaoModel:checkActive(gbid)
end,
}

function tianDaoRongDingModel:isUnlock(ubdId,id)
local condition=cfgHelper.get2(cfg_tdrlplanconfig_get,id,'condition')
local ret=true
local args
if condition then
for i,v in ipairs(condition)do
local typo=v[1]
if _func[typo]then
ret=ret and _func[typo](ubdId,v)
args=v
end
if not ret then
return false,{typo,args}
end
end
end
return true
end

function tianDaoRongDingModel:getUnlockTips(v)
if v==nil then return''end
local typo=v[1]
if typo==1 then
return FMT.fmt('天道鼎达到{0}级解锁',v[2])
elseif typo==2 then
local gbid=v[2]
local name=cfg_gubaoconfig_get(gbid).name
return FMT.fmt('需激活古宝[{0}]',name)
end
return''
end




function tianDaoRongDingModel:getLianZhiItem(id)
local showitem=cfgHelper.get2(cfg_tdrlplanconfig_get,id,'showitem')
return showitem
end

function tianDaoRongDingModel:getLianZhiItemId(id)
local showitem=tianDaoRongDingModel:getLianZhiItem(id)
return showitem[1]
end

function tianDaoRongDingModel:getMaxRonglianExp(buildid,lv)
local money
local effects=cfgHelper.get3(cfg_monijybuilduplvlconfig_get,buildid,lv,'effects')
for i,v in ipairs(effects)do
if v.type==8 then
money=table.deepCopy(v.param)
break
end
end
if money then

money[2]=money[2]+gubaoModel:getGBSkil_TianDaoDingAddDaoHuo()
end
return money
end

function tianDaoRongDingModel:isUnLockGB(pfId)
local config=cfg_tdrlplanconfig_get(pfId)
local condition=config.condition or{}
local gbid
for i,v in ipairs(condition)do
if v[1]==2 then
gbid=v[2]
break
end
end
local needgb=gbid~=nil
if not needgb then return true end
local isActive=gubaoModel:checkActive(gbid)
return isActive
end






function tianDaoRongDingModel:canLianZhi(id,fangAnID,num,isWarning)
local costlist=cfgHelper.get3(cfg_tdrlplanconfig_get,id,'cost',fangAnID)
for i,v in ipairs(costlist)do
local itemid=v[1]
local need=num*v[2]
local ret=itemsModel.getCount(itemid)>=need
if not ret then
if isWarning then
if itemid==eMoneyType.mtRongLian then
UIManager.error('熔炼值不足，无法炼制')
else
UIManager.error('材料不足，无法炼制')
end
gainControl:showGainWin(itemid)
end
return false
end
end
local left=tianDaoRongDingModel:getLeftLianZhiCnt(id)
if left<num then
if isWarning then
UIManager.error('炼制次数不足，无法炼制')
end
return false
end
return true
end






function tianDaoRongDingModel:getMaxLianZhiCount(id,fangAnID)
local costlist=cfgHelper.get3(cfg_tdrlplanconfig_get,id,'cost',fangAnID)
local cnt=nil
for i,v in ipairs(costlist)do
local itemid=v[1]
local need=v[2]
local has=itemsModel.getCount(itemid)
local num=math.floor(has/need)
if cnt~=nil then
cnt=math.min(cnt,num)
else
cnt=num
end
end
local left=tianDaoRongDingModel:getLeftLianZhiCnt(id)
return math.min(cnt,left)
end





function tianDaoRongDingModel:setSelectPeiFangId(id)
self.selectId=id
end

function tianDaoRongDingModel:getSelectPeiFangId()
return self.selectId
end

function tianDaoRongDingModel:addCDData()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eTianDaoRongLu)
if bdData then
buildingCDControl:addCDData(buildingCDType.tiandaohecheng,bdData)
end
end

function tianDaoRongDingModel:removeCDData()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eTianDaoRongLu)
if bdData then
buildingCDControl:removeCDData(buildingCDType.tiandaohecheng,bdData.un_build_id)
end
end
function tianDaoRongDingModel:closeProgress()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eTianDaoRongLu)
if bdData then
hudControl:closeProgress(bdData.un_build_id)
end
end
function tianDaoRongDingModel:freshBuildingStatusHUD()
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eTianDaoRongLu)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end



function tianDaoRongDingModel:checkOrderPT(conds,defaultVersionId,pfid)
local cond
if conds[defaultVersionId]then
if conds[defaultVersionId][-1]then
cond=conds[defaultVersionId][-1]
else
if pfid and conds[defaultVersionId][pfid]then
cond=conds[defaultVersionId][pfid]
end
end
end

return cond
end