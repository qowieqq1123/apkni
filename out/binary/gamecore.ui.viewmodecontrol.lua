





viewModeControl=gameState.addListener({})


local _idx=0
local _index=function()
_idx=_idx+1
return _idx
end

VIEW_MODE=
{
eNone=_index(),
eFight=_index(),
eFightPrepare=_index(),
}

local _viewConfig=
{
[VIEW_MODE.eFight]=
{
{'UIBagWin',}
},








}
local _viewLookup={}

for viewMode,v in pairs(_viewConfig)do
for _,name in ipairs(v)do
if _viewLookup[viewMode]==nil then _viewLookup[viewMode]={}end
_viewLookup[viewMode][name]=true
end
end








function viewModeControl:onAppStart()

end

function viewModeControl:onEnterState()
self.viewMode=VIEW_MODE.eNone
end

function viewModeControl:onLeaveState()
self.viewMode=VIEW_MODE.eNone
end


function viewModeControl:enterMode(viewMode)
if self.viewMode==viewMode then return end
self.viewMode=viewMode



end


function viewModeControl:exitMode()
if self.viewMode==VIEW_MODE.eNone then return end



self.viewMode=VIEW_MODE.eNone
end


function viewModeControl:canOpen(name)
if self.viewMode~=VIEW_MODE.eNone then
local viewMode=self.viewMode
local namelist=_viewLookup[viewMode]
if namelist then
return namelist[name]or false
end
end
return true
end






