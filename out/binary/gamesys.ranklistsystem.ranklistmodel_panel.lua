eRankListStelePanelType={
eNormal=1,
eWuJiBei=2,
}

eRankListStelePanelHandle={
[eRankListStelePanelType.eNormal]={
openPanel=function(args)
UIFullZaoHuaTianBeiControl:openNormalRankListWin(args)
end,
},
[eRankListStelePanelType.eWuJiBei]={
openPanel=function(args)
UIFullZaoHuaTianBeiControl:openWuJiBei()
end,
getReddot=function(args)
return wuJiBeiModel:getAllReddot()
end,
},
}

function rankListModel:getStelePanelReddot(type,args)
local handle=eRankListStelePanelHandle[type]
if handle and handle.getReddot then
return handle.getReddot(args)
end
return false
end

function rankListModel:doStelePanelOpen(type,args)
local handle=eRankListStelePanelHandle[type]
if handle and handle.openPanel then
handle.openPanel(args)
end
end

function rankListModel:getSteleServerReddot(server)
local lookup=cfgHelper.get1(cfg_lookupsteletypeconfig_get,server)
for i,v in ipairs(lookup)do
local cfg=cfgHelper.get1(cfg_steletypeconfig_get,v)
local type=cfg.panelType
local args=cfg.panelArgs
if self:getStelePanelReddot(type,args)then
return true
end
end
return false
end

function rankListModel:checkStelePaneShow(conditions)
if conditions and next(conditions)then
for i,v in ipairs(conditions)do
if v[1]==1 then
local openDay=timeHelper.getServerOpenDay()
if openDay<v[2]then
return false
end
elseif v[1]==2 then
local level=zongmenModel:getLevel()
if level<v[2]then
return false
end
elseif v[1]==3 then
local version=pfwindowslController:getGameVersion()
if version~=v[2]then
return false
end
end
end
end
return true
end