





function MysteryModel:initLinShiDisciple(tmpTeam)
self.currentFBData.linshiDisciple={}

if tmpTeam then
local list={}
for i,v in ipairs(tmpTeam)do
list[tostring(v.guid)]=v
end
self.currentFBData.linshiDisciple=list
end
end

function MysteryModel:getLinShiDiscipleList()
return self.currentFBData.linshiDisciple
end

function MysteryModel:getLinShiDisciple(guid)
local key=tostring(guid)
return self.currentFBData.linshiDisciple[key]
end

function MysteryModel:setLinShiDisciple(tmp)
self.currentFBData.linshiDisciple[tostring(tmp.guid)]=tmp
end

function MysteryModel:initHisDisciple(tmpTeam)
self.currentFBData.hisDisciple={}

if tmpTeam then
local list={}
for i,v in ipairs(tmpTeam)do
list[tostring(v.guid)]=v
end
self.currentFBData.hisDisciple=list
end
end

function MysteryModel:getHisDiscipleList()
return self.currentFBData.hisDisciple
end

function MysteryModel:getHisDisciple(guid)
local key=tostring(guid)
return self.currentFBData.hisDisciple[key]
end



function MysteryModel:setHisDisciple(tmp)
self.currentFBData.hisDisciple[tostring(tmp.guid)]=tmp
end

function MysteryModel:isDiscipleCanUse(guid)
local key=tostring(guid)
local hisDisciple=self.currentFBData.hisDisciple[key]
if hisDisciple then
return hisDisciple.blood>=0
end

local linshiDisciple=self.currentFBData.linshiDisciple[key]
if linshiDisciple then
return linshiDisciple.blood>=0
end

end
