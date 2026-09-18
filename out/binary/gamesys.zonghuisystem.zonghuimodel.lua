






local _MODULENAME="ZongHuiModel"


def_table(_MODULENAME)
ZongHuiModel.name=_MODULENAME
ZongHuiModel.data={}

function ZongHuiModel:onAppStart()

end


function ZongHuiModel:onEnterState(isReconnect)

end


function ZongHuiModel:onProtocolReq()

end


function ZongHuiModel:onLeaveState(isReconnect)

self.data={}
end



function ZongHuiModel:setBadgeList(len,list)
if not self.data.badge_list then
self.data.badge_list={}
end
if len>0 and list then
for k,v in ipairs(list)do
if v.param_1 then
self.data.badge_list[v.param_1]=v
end
end
end
end


function ZongHuiModel:freshBadgeList(len,list)
if not self.data.badge_list then
self.data.badge_list={}
end
local newlist={}
if len>0 and list then
for k,v in ipairs(list)do
if v.param_1 then
if not self.data.badge_list[v.param_1]then
newlist[#newlist+1]=v.param_1
end
self.data.badge_list[v.param_1]=v
end
end
end


end

function ZongHuiModel:setBadgeHide(len,set_list)
if self.data.badge_list then
if len>0 and set_list then
for k,v in ipairs(set_list)do
if self.data.badge_list[v.param_1]then
self.data.badge_list[v.param_1].param_3=v.param_2
end
end
end
end
end



function ZongHuiModel:getBadgeList()
return self.data.badge_list or{}
end

