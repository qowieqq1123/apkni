








UICacheConfig={

['UIDiscipleSelectWin']={3},
['UIXM_XMDG_MapWin']={300},
['UIXM_XMDG_MapNoneWin']={300},
['UIXM_LXWJ_BattleWin']={300},
['UIXM_ZZSH_MapWin']={300},
}


UIMaskConfig={
['UIDiscipleSelectWin']=true,
['UIXM_XMDG_MapNoneWin']=true,
['UIXM_XMDG_MapWin']=true,
['UIXM_LXWJ_BattleWin']=true,
['UIXM_ZZSH_MapWin']=true,
}

local window_cache_list={}
local window_num=0
local cache_window_pool_max=4

local win_cache_check_time=10
local win_cache_cull_timer=nil

function UIManager.clearCache()
window_cache_list={}
window_num=0
end

function UIManager.initCacheTimer()
win_cache_cull_timer=timer.new()
win_cache_cull_timer:start(win_cache_check_time,UIManager.cullCacheOverTime)
end

function UIManager.cullCacheOverTime()
if window_num>0 then
local list=UIManager.get_cache_sort_list()
if#list>0 then
local data=list[1]
if data.lerp<0 then
local winname=data[1]
UIManager.remove_cache_window(winname)
if UIManager.window_show_states[winname]==2 then
UIManager:closeWindow(winname,true)
end
end
end
local f
for name,v in pairs(UIMaskConfig)do
if UIManager:isActive(name,true)then
f=name
break
end
end
if f then
for name,v in pairs(UIMaskConfig)do
if f~=name then
local data=window_cache_list[name]
if data~=nil then
local winname=data[1]
UIManager.remove_cache_window(winname)
if UIManager.window_show_states[winname]==2 then
UIManager:closeWindow(winname,true)
end
break
end
end
end
end
end
end

function UIManager.close_cache_window(name)
local data=window_cache_list[name]
if data~=nil then
local winname=data[1]
UIManager.remove_cache_window(winname)
if UIManager.window_show_states[winname]==2 then
UIManager:closeWindow(winname,true)
end
end
end

function UIManager.remove_cache_window(name)
local data=window_cache_list[name]
if data~=nil then
window_cache_list[name]=nil
window_num=window_num-1
end
end

function UIManager.check_cache_window(name)
return UICacheConfig[name]~=nil
end

function UIManager.get_cache_sort_list()
local list={}
for name,data in pairs(window_cache_list)do
data.lerp=data[3]-(Time.realtimeSinceStartup-data[2])
table.insert(list,data)
end
if#list>1 then
table.sort(list,function(a,b)
return a.lerp<b.lerp
end)
end
return list
end

function UIManager.cache_window(name)
local data=window_cache_list[name]
if data==nil then
local cfg=UICacheConfig[name]
data={name,Time.realtimeSinceStartup,cfg[1]}
window_cache_list[name]=data
window_num=window_num+1
else
data[2]=Time.realtimeSinceStartup
end
if window_num>cache_window_pool_max then
local list=UIManager.get_cache_sort_list()
if#list>0 then
local winname=list[1][1]
UIManager.remove_cache_window(winname)
if UIManager.window_show_states[winname]==2 then
UIManager:closeWindow(winname,true)
end
end
end
return true
end