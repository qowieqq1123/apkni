



















jiuChongTianJieSysBase={}
function jiuChongTianJieSysBase.new(class)
local _clone={}
if class then
for i,v in pairs(class)do
_clone[i]=v
end
_clone._base=class

end
if class.sysType==nil then
logErr('没有传入类型 ')
end
local clone_mt={}
clone_mt.__index=jiuChongTianJieSysBase
setmetatable(_clone,clone_mt)
JiuChongTianJieEnterModel.bindClass(_clone)
_clone:initSubSys()
return _clone
end

jiuChongTianJieSysBase.showSys={}

jiuChongTianJieSysBase.subSysConfig={}

function jiuChongTianJieSysBase:getSysList()
return self:getConfig().list
end

function jiuChongTianJieSysBase:getSysLookup()
if not self.sysLookup then
self.sysLookup={}
local sysList=self:getSysList()
for i,v in ipairs(sysList)do
self.sysLookup[v]=i
end
end
return self.sysLookup
end


function jiuChongTianJieSysBase:isSysSubType(subType)
local lookup=self:getSysLookup()
return lookup[subType]~=nil
end


function jiuChongTianJieSysBase:initSubSys()
for _,s in ipairs(self.showSys)do
JiuChongTianJieEnterModel:requireClass(s)
end
end

function jiuChongTianJieSysBase:checkSubOpen()
for _,s in ipairs(self.showSys)do
local sys=JiuChongTianJieEnterModel:getSubSysClass(s)
if sys:checkOpen()then
return true
end
end
end

function jiuChongTianJieSysBase:getConfig()
return cfgHelper.get(cfg_jctjsysconfig_get,self.sysType)
end

function jiuChongTianJieSysBase:isShield()
return self:getConfig().shield
end



function jiuChongTianJieSysBase:getConditon()
return false
end


function jiuChongTianJieSysBase:getConditonTxt()
return''
end


function jiuChongTianJieSysBase:getProgress()
local cur,max=0,0
for i,sType in ipairs(self.showSys)do
local sys=JiuChongTianJieEnterModel:getSubSysClass(sType)
max=max+100
if sys:checkOpen()then
if sys.checkFinish and sys:checkFinish()then
cur=cur+100
else
if sys.getProgress then
local c,m=sys:getProgress()
cur=cur+c/m*100
end
end
end
end
return math.floor(cur),max
end


function jiuChongTianJieSysBase:getSubProgress(subType)
local cur,max=0,0
local sysList=self:getSysLookup()
if sysList[subType]then
local sys=JiuChongTianJieEnterModel:getSubSysClass(subType)
max=100
if sys:checkOpen()then
if sys.checkFinish and sys:checkFinish()then
cur=100
else
if sys.getProgress then
local c,m=sys:getProgress()
cur=c/m*100
end
end
end
end
return math.floor(cur),max
end


function jiuChongTianJieSysBase:getProgressCount()
local cur,max=0,0
local sysList=self:getSysList()
for i,sType in ipairs(sysList)do
local sys=JiuChongTianJieEnterModel:getSubSysClass(sType)

if sType~=JIUCHONGTIANJIE_SUB_SYS_TYPE.eXianJieJieYin then
max=max+1
if sys.checkFinish and sys:checkFinish()then
cur=cur+1
else
if sys.getProgress then
local c,m=sys:getProgress()
if c>=m then
cur=cur+1
end
end
end
end

end
return cur,max
end



function jiuChongTianJieSysBase:getReddot(isEnter)
local sysList=self:getSysList()
for i,sType in ipairs(sysList)do
local sys=JiuChongTianJieEnterModel:getSubSysClass(sType)
if sys:checkOpen()then
if sys.getReddot and sys:getReddot(isEnter)then
return true
end
end
end
return false
end


function jiuChongTianJieSysBase:checkReward()
local sysList=self:getSysList()
for i,sType in ipairs(sysList)do
local sys=JiuChongTianJieEnterModel:getSubSysClass(sType)
if sys:checkOpen()then
if sys.checkReward and sys:checkReward()then
return true
end
end
end
return false
end

function jiuChongTianJieSysBase:getRewardSystem()
local sysList=self:getSysList()
local subList={}
for i,sType in ipairs(sysList)do
local sys=JiuChongTianJieEnterModel:getSubSysClass(sType)
if sys:checkOpen()then
if sys.checkReward and sys:checkReward()then
table.insert(subList,sys)
end
end
end
return subList
end