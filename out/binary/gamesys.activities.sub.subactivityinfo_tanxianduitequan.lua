









local subActivityInfo_tanxianduitequan={name='tanxianduitequan'}

function subActivityInfo_tanxianduitequan:onInit()
local data=self:getData()or{}
self:setData(data)
self.config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)

self.tqid=self.config.rewards[1][1]
self.tqCfg=cfgHelper.get1(cfg_cattequanconfig_get,self.tqid)
end

function subActivityInfo_tanxianduitequan:checkReddot()
local data=self.data

if data then
local channelDatas=wanBaoXunBaoDuiModel:getChannelDatas()
local state1=channelDatas[self.tqCfg.channelid].open_state
local state2=mathHelper.getBitValue(data.flag or 0,0)

return(not state2)and state1
end
return false
end


return subActivityInfo_tanxianduitequan