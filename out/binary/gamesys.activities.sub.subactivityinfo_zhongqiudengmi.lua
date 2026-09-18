









local subActivityInfo_zhongqiudengmi={name='zhongqiudengmi'}

function subActivityInfo_zhongqiudengmi:onInit()

end

function subActivityInfo_zhongqiudengmi:onStart()

end

function subActivityInfo_zhongqiudengmi:on_money_changed(moneyType,lastVal,val)

end

function subActivityInfo_zhongqiudengmi:on_item_changed(changeType,itemguid,itemid,oldcount,newcount)

end

function subActivityInfo_zhongqiudengmi:onUpdate()

end

function subActivityInfo_zhongqiudengmi:onDelete()

end

function subActivityInfo_zhongqiudengmi:checkReddot()
local data=self.data
if data then
return activitiesHandle_zhongqiudengmi:getreddot(self.act_id,SUB_ACTIVITY_TYPE.eLanternriddles,self.sub_act_id)
end
return false
end


function subActivityInfo_zhongqiudengmi:checkNewDay()
if self:checkDoing()then
local data=self.data
if data then
self:clearalldata()
self:setactivitytime()
local sub_actcfg=self:getSubActConfig()
local flag=sub_actcfg.winflag
if flag==1 then
UIManager:invokeUIMethod('UISubAct_ZQDMmainWin','refreshOtherDay')
UIManager.info("已刷新为当天最新题目")
if UIManager:isActive('UISubAct_ZQDMtitleWin')then
UIManager:closeWindow("UISubAct_ZQDMtitleWin")
self:setnowdaydata(nil,nil,false)
end
elseif flag==2 then
UIManager:invokeUIMethod('UISubAct_YXJmainWin','refreshOtherDay')
UIManager.info("已刷新为当天最新题目")
if UIManager:isActive('UISubAct_YXJMtitleWin')then
UIManager:closeWindow("UISubAct_YXJMtitleWin")
self:setnowdaydata(nil,nil,false)
end
end
end
end
end


function subActivityInfo_zhongqiudengmi:getRewardBits()
if self:checkDoing()then
local data=self.data
if data and data.reward_bits then
return data.reward_bits
end
end
return 0
end


function subActivityInfo_zhongqiudengmi:setnowdaydata(chooseidx,deletlist,islucking)
if self.data then
self.data.chooseidx=chooseidx
self.data.deletlist=deletlist
self.data.islucking=islucking

end
end
function subActivityInfo_zhongqiudengmi:getnowdaydata()
if self.data then

return self.data.chooseidx,self.data.deletlist,self.data.islucking
end
end


function subActivityInfo_zhongqiudengmi:clearalldata()
if self.data then
local key_AnserIdx=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_AnserIdx',self.act_id,self.sub_act_type,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_AnserIdx,0)
local key_skillnum=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_skillnum',self.act_id,self.sub_act_type,self.sub_act_id)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_skillnum,{})
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhongQiuDengMi)
self:setnowdaydata(nil,nil,false)
end
end

function subActivityInfo_zhongqiudengmi:getactivitytime()
if self.data then
local key_stamp=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_acttime',self.act_id,self.sub_act_type,self.sub_act_id)
local stamp=userActorArraySetting.get(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_stamp,nil)
return stamp
end
return
end

function subActivityInfo_zhongqiudengmi:setactivitytime()
if self.data then
local key_stamp=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_acttime',self.act_id,self.sub_act_type,self.sub_act_id)
local stamp=tostring(timeHelper.getServerLongTime())
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_stamp,stamp)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhongQiuDengMi)
end
end


function subActivityInfo_zhongqiudengmi:setAnserdata()
if self.data then
local key_AnserIdx=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_AnserIdx',self.act_id,self.sub_act_type,self.sub_act_id)
local anserIdx=userActorArraySetting.get(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_AnserIdx,0)
anserIdx=anserIdx+1
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_AnserIdx,anserIdx)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhongQiuDengMi)

end
end

function subActivityInfo_zhongqiudengmi:getAnserdata()
if self.data then
local key_AnserIdx=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_AnserIdx',self.act_id,self.sub_act_type,self.sub_act_id)
local anserIdx=userActorArraySetting.get(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_AnserIdx,0)

return anserIdx
end
return 0
end

function subActivityInfo_zhongqiudengmi:setSkilldata(skillid,num)
if self.data then
local key_skillnum=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_skillnum',self.act_id,self.sub_act_type,self.sub_act_id)
local old_skilldata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_skillnum,{})
local oldnum=old_skilldata[tostring(skillid)]
if oldnum then
old_skilldata[tostring(skillid)]=oldnum+num
else
old_skilldata[tostring(skillid)]=num
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_skillnum,old_skilldata)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZhongQiuDengMi)

end
end

function subActivityInfo_zhongqiudengmi:getSkilldata(skillid)
if self.data then
local key_skillnum=FMT.fmt('ActivityZQDM_act{0}_sub{1}_subid{2}_skillnum',self.act_id,self.sub_act_type,self.sub_act_id)
local old_skilldata=userActorArraySetting.get(ACTOR_SETTING_TYPE.eZhongQiuDengMi,key_skillnum,{})

local oldnum=old_skilldata[tostring(skillid)]
if oldnum then
return oldnum
else
return 0
end
end
return 0
end


function subActivityInfo_zhongqiudengmi:setAnawerData()
if self.data then
local finishIdex=self:getAnserdata()
local temp={self.act_id,self.sub_act_type,self.sub_act_id,finishIdex}
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.ZhongQiuDengMiActivity,#temp,temp)
end
end


function subActivityInfo_zhongqiudengmi:getWinFlag()
if self.data then
local sub_actcfg=self:getSubActConfig()
return sub_actcfg.winflag
end
end




return subActivityInfo_zhongqiudengmi