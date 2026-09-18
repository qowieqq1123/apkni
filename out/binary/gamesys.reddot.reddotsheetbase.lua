




reddotSheetBase={}























function reddotSheetBase.new(class)
local _clone={}
if class then
for i,v in pairs(class)do
_clone[i]=v
end
_clone._base=class

end
if class.classname==nil then
logErr('没有传入classname')
end
local clone_mt={}
clone_mt.__index=reddotSheetBase
setmetatable(_clone,clone_mt)
reddotSheetBase.reset_data(_clone)
reddotClassManager.register_class(_clone)
return _clone
end

function reddotSheetBase.reset_data(class)
if class==nil then return end
class.reddot_sub_flags={}
class.reddot_sub_ref_flags={}
class.reddot_sub_really_flags={}
class.need_fresh_sub_reddot={}
class.reddot_flag=nil
class.need_fresh_flag=true
class.subTypeList=nil
end

function reddotSheetBase.init_data(class)
local configs=reddotSheetBase.get_all_configs(class)
for subTypo,v in pairs(configs)do
reddotSheetBase.fresh_sub_reddot(class,subTypo,false)
end
reddotSheetBase.fresh_reddot(class)
end

function reddotSheetBase.init_single_data(class,subTypo)
reddotSheetBase.fresh_sub_reddot(class,subTypo,false)
reddotSheetBase.fresh_reddot(class)
end


function reddotSheetBase.get_all_configs(class)
if class==nil then return end
return class.reddot_config
end

function reddotSheetBase.is_need_fresh_sub_type(class,subTypo)
return class.need_fresh_sub_reddot[subTypo]~=false
end

function reddotSheetBase.set_need_refresh_flag(class,subTypo,flag)
if class.need_fresh_sub_reddot[subTypo]~=flag then
class.need_fresh_sub_reddot[subTypo]=flag
end
end


function reddotSheetBase.fresh_all_reddot(class)
if class.subTypeList then
local list=class.subTypeList
if list and#list>0 then
for _,subTypo in ipairs(list)do
reddotSheetBase.set_need_refresh_flag(class,subTypo,true)
reddotSheetBase.fresh_sub_reddot(class,subTypo,false)
end
reddotSheetBase.fresh_reddot(class)
end
else



end
end


function reddotSheetBase.fresh_reddot(class)
if class.need_fresh_reddot==true then
class.need_fresh_reddot=false
local flag=false

for subTypo,subConfig in pairs(class.reddot_config)do
flag=flag or class.reddot_sub_really_flags[subTypo]==true
if flag==true then
break
end
end
local last_flag=class.reddot_flag or false
local is_change=flag~=last_flag

if is_change then
class.reddot_flag=flag
local reddot_type=class.reddot_type
reddotSheetBase.on_reddot_changed(class,reddot_type,last_flag,flag)
reddotClassManager.on_ref_reddot_change(class,reddot_type,flag)
end
end
end


function reddotSheetBase.fresh_sub_reddot(class,subTypo,freshTtype,element)

if class==nil then return nil end
if class.reddot_config==nil then



return
end
if class.reddot_config[subTypo]==nil then




return
end

if not reddotSheetBase.is_need_fresh_sub_type(class,subTypo)then
return
end
local sub_config=class.reddot_config[subTypo]
local func=sub_config.func
if func then
local last_flag=class.reddot_sub_flags[subTypo]
if element and sub_config.asynchData==nil then sub_config.asynchData={}end

local flag,asynchData=func(element~=nil,sub_config.asynchData)
sub_config.asynchData=asynchData

if flag==nil then
logErr('redSheet 脚本：%s 子类型：%s 返回不能为空',class.classname,reddotConfig.get_sub_name_by_type(subTypo))
flag=false
elseif not element and flag==-1 then
logErr('redSheet 脚本：%s 子类型：%s 方法未使用异步刷新，结果不能为空',class.classname,reddotConfig.get_sub_name_by_type(subTypo))
flag=false
elseif flag==-1 then
if asynchData==nil then
logErr('redSheet 脚本：%s 子类型：%s 方法使用了异步刷新，但没有返回asynchData',class.classname,reddotConfig.get_sub_name_by_type(subTypo))
flag=false
else
if not sub_config.asynch then
logErr('redSheet 脚本：%s 子类型：%s 方法使用了异步刷新，但配置没有设置asynch标记',class.classname,reddotConfig.get_sub_name_by_type(subTypo))
end
reddotClassManager.set_asynch_sub_type(element)
return true
end
end
if sub_config.asynchData~=nil then sub_config.asynchData=nil end
reddotClassManager.set_asynch_sub_type(nil)






reddotSheetBase.set_need_refresh_flag(class,subTypo,false)
local is_sub_change=flag~=last_flag

if is_sub_change then
class.reddot_sub_flags[subTypo]=flag
reddotSheetBase.on_sub_reddot_changed(class,subTypo,freshTtype)
end
end
end

function reddotSheetBase.fresh_sub_ref_reddot(class,subTypo,ref_type,flag)

if class==nil then return nil end
if class.reddot_config==nil then



return
end
if class.reddot_config[subTypo]==nil then




return
end





local sub_config=class.reddot_config[subTypo]
if sub_config==nil or sub_config.refTypeList==nil then return end
if class.reddot_sub_ref_flags[subTypo]==nil then class.reddot_sub_ref_flags[subTypo]={}end
local last_flag=class.reddot_sub_ref_flags[subTypo][ref_type]
local is_sub_ref_change=flag~=last_flag
if is_sub_ref_change then
class.reddot_sub_ref_flags[subTypo][ref_type]=flag
reddotSheetBase.on_sub_reddot_changed(class,subTypo,true)
end
end

function reddotSheetBase.on_sub_reddot_changed(class,subTypo,freshTtype)
local func_flag=class.reddot_sub_flags[subTypo]
local ref_flag=reddotSheetBase.get_sub_ref_flag(class,subTypo)
local last_flag=class.reddot_sub_really_flags[subTypo]
local tflag=func_flag or ref_flag or false
if last_flag~=tflag then
class.reddot_sub_really_flags[subTypo]=tflag
class.need_fresh_reddot=true
reddotClassManager.on_sub_reddot_changed(class,subTypo,last_flag,tflag)
if freshTtype~=false then
reddotSheetBase.fresh_reddot(class)
end




end
end

function reddotSheetBase.on_reddot_changed(class,tTypo,last_flag,flag)




reddotClassManager.on_reddot_changed(class,tTypo,last_flag,flag)
end

function reddotSheetBase.get_sub_ref_flag(class,subTypo)
local sub_config=class.reddot_config[subTypo]
if sub_config==nil or sub_config.refTypeList==nil then return end
if class.reddot_sub_ref_flags[subTypo]==nil then class.reddot_sub_ref_flags[subTypo]={}end
local flag=false
for _,v in ipairs(sub_config.refTypeList)do
flag=flag or class.reddot_sub_ref_flags[subTypo][v]==true
if flag==true then
break
end
end
return flag
end

function reddotSheetBase:getSubReddotKey(subid)
local subType=self.subType_
return reddotSheetBase.getSubReddotKeyEx(subType,subid)
end


function reddotSheetBase.getSubReddotKeyEx(subType,subid)
return reddotConfig.get_base_val()*subType+subid
end
