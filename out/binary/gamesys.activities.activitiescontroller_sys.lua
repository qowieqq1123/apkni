


function activitiesController:onAppStart_sys()
end

function activitiesController:onEnterState_sys()
self:init_sys()
end

function activitiesController:onLeaveState_sys()
self:init_sys()
end

function activitiesController:init_sys()
self.sysCache={}
end

function activitiesController:onActivity_system_tab_Change(subType,flag)
self.sysCache[subType]=flag
end

function activitiesController:isAddSysTab(subType)
return self.sysCache[subType]==true
end


