






local _MODULENAME="xianMengDaZhenModel"


def_table(_MODULENAME)
xianMengDaZhenModel.name=_MODULENAME
xianMengDaZhenModel.myData=nil

local showMoneys={}

function xianMengDaZhenModel:onAppStart()
local configs=cfg_devildomdazhenconfig()
local showMoneysLookup={}
for level,config in ipairs(configs)do
for i,v in ipairs(config.consume)do
local moneyType=v[1]
showMoneysLookup[moneyType]=true
end
end
for moneyType,value in pairs(showMoneysLookup)do
table.insert(showMoneys,moneyType)
end
table.sort(showMoneys)
end


function xianMengDaZhenModel:onEnterState(isReconnect)

end


function xianMengDaZhenModel:onProtocolReq()

end


function xianMengDaZhenModel:onLeaveState(isReconnect)

self.myData=nil
end



function xianMengDaZhenModel:setData(level,sheild,since)
if level>0 then
if self.myData==nil then
self.myData={}
end
self.myData.level=level
self.myData.value=sheild
self.myData.since=since
else
self.myData=nil
end
end

function xianMengDaZhenModel:getLevel()
return self.myData and self.myData.level or 0
end

function xianMengDaZhenModel:getProgress()
if self.myData then
return self.myData.value,self.myData.since
end
end

function xianMengDaZhenModel:getShowMoneys()
return showMoneys
end

function xianMengDaZhenModel:getCurrentAttrs()
local level=self:getLevel()
local list={}

if level>0 then
end
end