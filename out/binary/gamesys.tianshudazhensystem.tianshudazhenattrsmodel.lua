tianshudazhenAttrsModel={}

function tianshudazhenAttrsModel:initData()
self.totalAttrsList={}
self.totalAttrsLookup={}

self.hdTop=0
end

function tianshudazhenAttrsModel:onProtocolReq()
tianshudazhenAttrsModel:calAllAttrs()
end




function tianshudazhenAttrsModel:calAllAttrs()
tianshudazhenAttrsModel:calAttrs()
tianshudazhenAttrsModel:caculationHDTop()
end


function tianshudazhenAttrsModel:calAttrs()
self.totalAttrsLookup={}
local level=tianshudazhenModel:getLevel()
if level==0 then return end


local tsdzCfg=tianshudazhenConfig.getTianshudazhenconfig(level)
local attr=tsdzCfg.attr
for i,v in ipairs(attr)do
tianshudazhenAttrsModel:addAttrValue(v[1],v[2])
end


local lookup=tianshudazhenModel:getJylzAttrlookup()
if lookup then
for k,v in pairs(lookup)do
tianshudazhenAttrsModel:addAttrValue(k,v)
end
end
end

function tianshudazhenAttrsModel:addAttrValue(attrid,attrValue)
local old=self.totalAttrsLookup[attrid]or 0
self.totalAttrsLookup[attrid]=old+attrValue

local flag=false
for i,v in ipairs(self.totalAttrsList)do
if v[1]==attrid then
v[2]=(v[2]or 0)+attrValue
flag=true
break
end
end
if not flag then
self.totalAttrsList[#self.totalAttrsList+1]={attrid,attrValue}
end
end

function tianshudazhenAttrsModel:caculationHDTop()
local top=tianshudazhenModel:getMaxHDZValue()

self.hdTop=top
end


function tianshudazhenAttrsModel:getLookupAttrs(attrid)
return self.totalAttrsLookup[attrid]
end

function tianshudazhenAttrsModel:getAttrsList()
return self.totalAttrsList
end

function tianshudazhenAttrsModel:getHDTop()
return self.hdTop
end