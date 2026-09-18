







UICreateRoleModel={}
local _roleArray={}
local _cacheData=nil
local _cacheDataEx=nil
local _defaultIdx=1

function UICreateRoleModel:InitData(data)
_roleArray=data or{}
if self:HasRole()then
local roleInfo=_roleArray[_defaultIdx]
local createtime=roleInfo.createtime
gameUtilityControl.setPlayerCreateTime(createtime)
end
end


function UICreateRoleModel:setCacheRoleData(data)
_cacheData=data
end


function UICreateRoleModel:onCreateRole(id,createtime)
if _cacheData==nil then return end
_cacheData.id=id
_cacheData.createtime=createtime
_roleArray[_defaultIdx]=_cacheData
_cacheData=nil
return _roleArray[_defaultIdx]
end


function UICreateRoleModel:setCacheRoleDataEx(name,sex)
_cacheDataEx={}
_cacheDataEx.name=name
_cacheDataEx.sex=sex
end

function UICreateRoleModel:onChangedRole()
local name=_cacheDataEx.name
local sex=_cacheDataEx.sex
_cacheDataEx=nil
_roleArray[_defaultIdx].name=name
_roleArray[_defaultIdx].sex=sex
return name,sex
end


function UICreateRoleModel:HasRole()
return _roleArray~=nil and#_roleArray>0
end

function UICreateRoleModel:GetRole(_Index)








return _roleArray[_Index]
end

function UICreateRoleModel:GetRoleByRoleId(roleid)
for i,v in ipairs(_roleArray)do
if v.id==roleid then
return v
end
end
end

function UICreateRoleModel:GetMaxLvRoleIndex()
local _idx=1
local lv=-1
for i,v in ipairs(_roleArray)do
if v.level>lv then
lv=v.level
_idx=i
end
end
return _idx
end

function UICreateRoleModel:getRoleInfo()
if UICreateRoleModel:HasRole()then
return UICreateRoleModel:GetRole(_defaultIdx)
end
end

function UICreateRoleModel:getRandomSex()
local list={0,1}
local rand=math.random(1,#list)
local sex=list[rand]
return sex
end

function UICreateRoleModel:getRoleLv()
local roleInfo=UICreateRoleModel:getRoleInfo()
if roleInfo then
return roleInfo.level
end
end

function UICreateRoleModel:getRoleName()
local roleInfo=UICreateRoleModel:getRoleInfo()
if roleInfo then
return roleInfo.name
end
end

function UICreateRoleModel:getRoleId()
local roleInfo=UICreateRoleModel:getRoleInfo()
if roleInfo then
return roleInfo.id
end
end

function UICreateRoleModel:checkZhuXiao()
local roleInfo=UICreateRoleModel:getRoleInfo()
local zhuxiaotime=roleInfo.zhuxiaotime or 0
if zhuxiaotime<=0 then return false end
local startStamp=timeHelper.convertLongStamp(zhuxiaotime)
local stamp=loginModel:getServerCurTimestamp()or os.time()
local endStamp=startStamp+1296000
return stamp>endStamp
end