







function activitiesModel.getCommonAtlasABName()
return globalABLookup.activieSprites
end

function activitiesModel.get_total_days_by_time(s_time,e_time)
local s_y,s_m,s_d=timeHelper.getDateNumber(s_time)
local start_seconds=timeHelper.getSeconds(s_y,s_m,s_d)
local e_y,e_m,e_d=timeHelper.getDateNumber(e_time)
local end_seconds=timeHelper.getSeconds(e_y,e_m,e_d+1)
local f_total_days=(end_seconds-start_seconds)/(24*3600)
local i_total_days=math.ceil(f_total_days)
return i_total_days
end


function activitiesModel.get_open_day_index(s_time)
local cur_time=gameUtilityModel:getServerLongTime()
if cur_time<=s_time then
return 0
end
local s_y,s_m,s_d=timeHelper.getDateNumber(s_time)
local start_seconds=timeHelper.getSeconds(s_y,s_m,s_d)
local c_y,c_m,c_d=timeHelper.getDateNumber(cur_time)
local cur_seconds=timeHelper.getSeconds(c_y,c_m,c_d)
local lerp=math.floor((cur_seconds-start_seconds)/(24*3600))+1
return lerp
end

function activitiesModel.get_day_area(s_time,e_time)
local s_y,s_m,s_d=timeHelper.getDateNumber(s_time)
local e_y,e_m,e_d=timeHelper.getDateNumber(e_time)
s_m=tonumber(s_m)
e_m=tonumber(e_m)
return FMT.fmt('{0}月{1}日-{2}月{3}日',s_m,s_d,e_m,e_d)
end

function activitiesModel.get_open_time(s_time,e_time,s_day_idx,e_day_idx)
local s_y,s_m,s_d=timeHelper.getDateNumber(s_time)
local s_time_=timeHelper.timeServer(s_y,s_m,s_d,0,0,0)
local start_time=s_time_+(s_day_idx-1)*86400
local end_time=s_time+e_day_idx*86400-1
start_time=math.max(s_time,start_time)
end_time=math.min(e_time,end_time)
return start_time,end_time
end

function activitiesModel.getTimeDesc1(s_time_l,e_time_l)
local y1,m1,d1=timeHelper.getServerStampData(s_time_l)
local y2,m2,d2=timeHelper.getServerStampData(e_time_l)
local str1,str2
if y1==y2 and m1==m2 and d1==d2 then
str1=timeHelper.dateServerStamp('%Y年%m月%d日%H:%M',s_time_l)
str2=timeHelper.dateServerStamp('%H:%M',e_time_l)
elseif y1==y2 then
str1=timeHelper.dateServerStamp('%Y年%m月%d日%H:%M',s_time_l)
str2=timeHelper.dateServerStamp('%m月%d日%H:%M',e_time_l)
else
str1=timeHelper.dateServerStamp('%Y年%m月%d日%H:%M',s_time_l)
str2=timeHelper.dateServerStamp('%Y年%m月%d日%H:%M',e_time_l)
end
return FMT.fmt('{0} - {1}',str1,str2)
end