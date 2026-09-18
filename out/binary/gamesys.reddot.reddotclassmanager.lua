




reddotClassManager=gameState.addListener({})


local _updateRate=0.13
local _remove=table.remove
local _format=string.format
local _maxNum=100000
local _tFloor=math.floor
local _speedDequeueNum=20
local _topDequeueNum=50


local _ref_class_list={}
local _register_class_list={}
local _register_class_lookup={}
local _register_classname_lookup={}

local _register_sub_reddot_list={}
local _register_reddot_lookup={}
local _catch_type_list={}



local _update_change_list={}
local _update_change_lookup={}
local _update_change_dynamic_class_lookup={}
local _asynchElement=nil

local _register_events={}
local _timer
local _check_list={}
local _curnum=100000
local _isRecvInit=false


local _debug_check_overflow_lookup={}
local _debug_check_reddot_list={}
local _debug_check_overflow_list={}
local _debug_check_repeat_list={}
local _debug_check_repeat_sub_ref_list={}



local function _update()
if _isRecvInit then
reddotClassManager.dequeue()
end
end

local function _cancelTimer()
if _timer then
_timer:Stop()
_timer=nil
end
end

local function _creatTimer()
if not _timer then
_timer=FrameTimer.New(_update,0,-1)
_timer:Start()
end
end

function reddotClassManager:onAppStart()
for _,class in ipairs(_register_class_list)do
reddotClassManager.init_class(class)
end
end

function reddotClassManager:onEnterState()
for _,class in ipairs(_register_class_list)do
if class.onEnterState then
class:onEnterState()
end
end
end

function reddotClassManager:onLeaveState(isReconnet)
_isRecvInit=false
for _,class in ipairs(_register_class_list)do
if class.onLeaveState then
class:onLeaveState(isReconnet)
end
end
if not isReconnet then
reddotClassManager.reset()
end
end

function reddotClassManager:onPlayerCreate()
for _,class in ipairs(_register_class_list)do
if class.onPlayerCreate then
class:onPlayerCreate()
end
end
end

function reddotClassManager:onProtocolReq()
_isRecvInit=true
end



function reddotClassManager.on_change_catch_type(catchType)
local catchList=_catch_type_list[catchType]
if catchList then
for _,sub_type in ipairs(catchList)do
reddotClassManager.on_change_sub_type(sub_type)
end
end
end


function reddotClassManager.printReddot(typo,reddot_flag)
if reddotConfig.isSubType(typo)then
if _update_change_lookup[typo]then return end
local type_config=reddotClassManager.get_sub_config(typo)
local class=type_config.class
local sub_config=class.reddot_config[typo]
local func=sub_config.func
local flag=func()
if reddot_flag~=flag then
loggerUtil.log(FMT.fmt('脚本{0}子红点{1}没有刷新!现在状态：{2} 正确状态：{3}',class.classname,typo,reddot_flag,flag))
end
else
local class=reddotClassManager.get_class(typo)
local reddot_config=class.reddot_config
local str
local big_reddot=class.reddot_flag or false
local new_big_reddot=false
local needFreshBig=false
for subTypo,v in pairs(reddot_config)do
if not _update_change_lookup[subTypo]then
local last_flag=class.reddot_sub_flags[subTypo]or false
local sub_config=class.reddot_config[subTypo]
local func=sub_config.func
local flag=func()
new_big_reddot=new_big_reddot or flag
if flag~=last_flag then
str=str and FMT.fmt('{0}\n脚本{1}子红点{2}没有刷新!现在状态：{3} 正确状态：{4}',str,class.classname,subTypo,last_flag,flag)or
FMT.fmt('脚本{0}子红点{1}没有刷新!现在状态：{2} 正确状态：{3}',class.classname,subTypo,last_flag,flag)
end
else
needFreshBig=true
end
end
if str then
loggerUtil.log(str)
end

if not needFreshBig and new_big_reddot~=big_reddot then
loggerUtil.log(FMT.fmt('脚本{0}大红点{1}没有刷新!现在状态：{2} 正确状态：{3}',class.classname,typo,big_reddot,new_big_reddot))
end
end
end

local get_big_reddot=function(typo)
if typo==nil then return nil end
local class=reddotClassManager.get_class(typo)
if class==nil then



return
end
class:init_data()
local reddot_flag=class.reddot_flag or false



return reddot_flag
end


function reddotClassManager.get_sub_reddot(sub_type)
if sub_type==nil then return nil end
local type_config=reddotClassManager.get_sub_config(sub_type)
if type_config==nil or type_config.class==nil then



return
end
local class=type_config.class
class:init_data()
local reddot_sub_flags=class.reddot_sub_flags or{}
local reddot_flag=reddot_sub_flags[sub_type]or false




return reddot_flag
end


local reddotOverflowCheck=0
function reddotClassManager.get_reddot(typo)
reddotOverflowCheck=reddotOverflowCheck+1
if reddotOverflowCheck>2 then
reddotOverflowCheck=0
loggerUtil.logErrFMT('获取红点{0}形成死循环:',tostring(typo))
return false
end
if not reddotConfig.isSubType(typo)then
local ret=get_big_reddot(typo)
reddotOverflowCheck=0
return ret
end
local ret=reddotClassManager.get_sub_reddot(typo)
reddotOverflowCheck=0
return ret
end

function reddotClassManager.get_class_by_sub_type(sub_type)
if sub_type==nil then return nil end
local type_config=reddotClassManager.get_sub_config(sub_type)or{}
return type_config.class
end



function reddotClassManager.register_eventList(typoList,event)
for _,v in ipairs(typoList)do
reddotClassManager.register_event(v,event)
end
end



function reddotClassManager.register_event(typo,event)
reddotClassManager.unregister_event(typo,event)
if _register_events[typo]==nil then _register_events[typo]={}end
local event_list=_register_events[typo]
event_list[#event_list+1]=event

if _isRecvInit then
if reddotConfig.isSubType(typo)then
reddotClassManager.on_change_sub_type(typo)
else
reddotClassManager.on_change_bigtype(typo)
end
end
end



function reddotClassManager.unregister_eventList(typoList,event)
for _,v in ipairs(typoList)do
reddotClassManager.unregister_event(v,event)
end
end


function reddotClassManager.unregister_event(typo,event)
if _register_events[typo]==nil then return false end
local event_list=_register_events[typo]
if#event_list<=0 then return end
for i,evt in ipairs(event_list)do
if evt==event then
table.remove(event_list,i)
return true
end
end
return false
end


function reddotClassManager.register_class(class)
if class==nil then return end
local classname=class.classname
if _register_classname_lookup[classname]then return end
_register_class_list[#_register_class_list+1]=class
_register_classname_lookup[classname]=class
end



function reddotClassManager.init_class(class)
if class==nil then return end
local reddot_type=class.reddot_type
if reddot_type==nil then



return
end








_register_class_lookup[reddot_type]=class
if class.reddot_config==nil or
_register_reddot_lookup[reddot_type]==true then
return
end
_register_reddot_lookup[reddot_type]=true

if class.isDynamic and class.subTypeList==nil then
local subTypeList={}
for k,v in pairs(class.reddot_config)do
if v.func then
subTypeList[#subTypeList+1]=k
end
end
class.subTypeList=subTypeList
end






for k,v in pairs(class.reddot_config)do
local sub_config={}
sub_config.class=class
sub_config.config={k,v}






reddotClassManager.check_repeat(sub_config)

local refTypeList=v.refTypeList
if refTypeList then
for _,refType in ipairs(refTypeList)do
reddotClassManager.handle_refType_list(refType,sub_config)
end
end

local catch=v.catch
if catch then
for _,catchType in ipairs(catch)do
if _catch_type_list[catchType]==nil then _catch_type_list[catchType]={}end
local catchList=_catch_type_list[catchType]
catchList[#catchList+1]=k
end
end

local func=v.func
if func then

if _register_sub_reddot_list==nil then _register_sub_reddot_list={}end
if _register_sub_reddot_list[k]then



end
_register_sub_reddot_list[k]=sub_config
end
end
end


function reddotClassManager.add_class_config(class,sub_typo,sub_config)
if class==nil then return end
local reddot_type=class.reddot_type
if reddot_type==nil then



return
end






if _register_reddot_lookup[reddot_type]==nil then



return
end

if class.isDynamic and class.subTypeList==nil then
class.subTypeList={}
end

if sub_config.func and not table.containsValue(class.subTypeList,sub_typo)then
class.subTypeList[#class.subTypeList+1]=sub_typo
end


local k=sub_typo
local v=sub_config
local sub_config={}
sub_config.class=class
sub_config.config={k,v}

reddotClassManager.check_repeat(sub_config)

local refTypeList=v.refTypeList
if refTypeList then
for _,refType in ipairs(refTypeList)do
reddotClassManager.handle_refType_list(refType,sub_config)
end
end

local catch=v.catch
if catch then
for _,catchType in ipairs(catch)do
if _catch_type_list[catchType]==nil then _catch_type_list[catchType]={}end
local catchList=_catch_type_list[catchType]
catchList[#catchList+1]=k
end
end

local func=v.func
if func then
if _register_sub_reddot_list==nil then _register_sub_reddot_list={}end
if _register_sub_reddot_list[k]then



end
_register_sub_reddot_list[k]=sub_config
end
reddotSheetBase.init_single_data(class,sub_typo)
end

function reddotClassManager.reset_class(class)
if class==nil then return end
if class.reddot_type==nil then return end
if class.reddot_config==nil then return end
local reddot_type=class.reddot_type




_register_reddot_lookup[reddot_type]=nil

for k,v in pairs(class.reddot_config)do










_register_sub_reddot_list[k]=nil

local refTypeList=v.refTypeList
if refTypeList then
for _,refType in ipairs(refTypeList)do
if _ref_class_list[refType]==nil then _ref_class_list[refType]={}end
local list=_ref_class_list[refType]
for i1,v1 in ipairs(list)do
local sub_type1=v1.config and v1.config[1]
if sub_type1==k then
table.remove(list,i1)
break
end
end
end
end

local catch=v.catch
if catch then
for _,catchType in ipairs(catch)do
if _catch_type_list[catchType]==nil then _catch_type_list[catchType]={}end
local catchList=_catch_type_list[catchType]
for i,v in ipairs(catchList)do
if v==k then
table.remove(catchList,i)
break
end
end
end
end
end
end

function reddotClassManager.reset()
_update_change_list={}
_update_change_lookup={}
_update_change_dynamic_class_lookup={}
_asynchElement=nil
_timer=nil
_curnum=0
_check_list={}
_register_events={}
_isRecvInit=false
for k,v in ipairs(_register_class_list)do
reddotSheetBase.reset_data(v)
end
end

function reddotClassManager.handle_refType_list(refType,sub_config)
reddotClassManager.set_class_reddot_type(refType,sub_config)
reddotClassManager.check_repeat_ref_one_sub(refType,sub_config)
reddotClassManager.check_overflow(refType,sub_config)
if _ref_class_list[refType]==nil then _ref_class_list[refType]={}end
local list=_ref_class_list[refType]
list[#list+1]=sub_config
end



function reddotClassManager.on_ref_reddot_change(class,ref_type,flag)
if _ref_class_list[ref_type]==nil then _ref_class_list[ref_type]={}end
local list=_ref_class_list[ref_type]or{}
for _,v in ipairs(list)do
local class=v.class
local config=v.config
local sub_type=config[1]
reddotSheetBase.fresh_sub_ref_reddot(class,sub_type,ref_type,flag)
end
end


function reddotClassManager.dequeue()
if fightModel:haveBattleShow()then return end

if _asynchElement then
reddotClassManager.handle_sub_type(_asynchElement)
return
end

local length=#_update_change_list
if length<=0 then return end


local element=_update_change_list[1]
_remove(_update_change_list,1)

if#_update_change_list<=0 then _cancelTimer()end
reddotClassManager.handle_sub_type(element)

end

function reddotClassManager.set_asynch_sub_type(element)
_asynchElement=element
end

function reddotClassManager.handle_sub_type(element)
if element==nil then return end
local sub_type=element.sub_type
local class=element.class
if class and class.isDynamic then
_update_change_dynamic_class_lookup[class.reddot_type]=nil
reddotSheetBase.fresh_all_reddot(class)

else
local conf=_register_sub_reddot_list[sub_type]
local class=conf.class
reddotClassManager.fresh_need_refresh_flag(sub_type,true)
reddotSheetBase.fresh_sub_reddot(class,sub_type,true,element)
end
reddotClassManager.set_update_change_lookup(sub_type,false)
end


function reddotClassManager.fresh_need_refresh_flag(sub_type,flag)
local conf=_register_sub_reddot_list[sub_type]
local class=conf.class
reddotSheetBase.set_need_refresh_flag(class,sub_type,flag)
end


function reddotClassManager.on_change_bigtype(typo)
local class=reddotClassManager.get_class(typo)
local reddot_config=class.reddot_config
for subTypo,_ in pairs(reddot_config)do
reddotClassManager.on_change_sub_type(subTypo)
end
end

function reddotClassManager.on_change_sub_type(sub_type)

if _update_change_lookup[sub_type]==true or _register_sub_reddot_list[sub_type]==nil then return end
local args={sub_type=sub_type}
local class=reddotClassManager.get_class_by_sub_type(sub_type)
if class and class.isDynamic then
if _update_change_dynamic_class_lookup[class.reddot_type]then return end
_update_change_dynamic_class_lookup[class.reddot_type]=true
args.class=class
else
reddotClassManager.fresh_need_refresh_flag(sub_type,true)
end
_update_change_list[#_update_change_list+1]=args
reddotClassManager.set_update_change_lookup(sub_type,true)
_creatTimer()
end

function reddotClassManager.get_sub_config(sub_type)
if sub_type==nil then return nil end
local register_sub_list=_register_sub_reddot_list or{}
return register_sub_list[sub_type]
end

function reddotClassManager.get_class(typo)
if typo==nil then return nil end
local class_lookup=_register_class_lookup or{}
return class_lookup[typo]
end

function reddotClassManager.get_class_by_name(name)
return _register_classname_lookup[name]
end

function reddotClassManager.set_update_change_lookup(sub_type,flag)
_update_change_lookup[sub_type]=flag
end


function reddotClassManager.set_class_reddot_type(refType,sub_config)












end

function reddotClassManager.check_overflow(check_reddot_type)




















end

function reddotClassManager.has_overflow(checkType,reddot_type)

























end


function reddotClassManager.check_repeat_ref_one_sub(refType,sub_config)

















end


function reddotClassManager.check_repeat(sub_config)












end

function reddotClassManager.on_reddot_changed(class,typo,last_flag,flag)
if _register_events[typo]==nil then return end
local event_list=_register_events[typo]
if#event_list<=0 then return end
for _,event in ipairs(event_list)do
event(class,typo,last_flag,flag)
end
end

function reddotClassManager.on_sub_reddot_changed(class,sub_typo,last_flag,flag)
if _register_events[sub_typo]==nil then return end
local event_list=_register_events[sub_typo]
if#event_list<=0 then return end
for _,event in ipairs(event_list)do
event(class,sub_typo,last_flag,flag)
end
end


function reddotClassManager.dequeueNum(length)
local num=1+_tFloor((length-1)/_speedDequeueNum)
if num>_topDequeueNum then num=_topDequeueNum end
return num
end
