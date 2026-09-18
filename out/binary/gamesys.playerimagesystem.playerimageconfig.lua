playerImageConfig={}

local _requireCfg={}
local _imageCfgs={}
local _pageCfgs=nil
local _pageLookupCfgs=nil

function playerImageConfig:onReset()
_imageCfgs={}
end

function playerImageConfig.getCommomCfg()
return cfg_playerimagecommonconfig_get(1)
end

function playerImageConfig.getPlayerImageCost()
local cfg=playerImageConfig.getCommomCfg()
return cfg.cost
end

function playerImageConfig.getPlayerImageBody(sex)
local cfg=playerImageConfig.getCommomCfg()
return cfg.body[sex]
end

function playerImageConfig.getPlayerImageFreeCnt()
local cfg=playerImageConfig.getCommomCfg()
return cfg.free
end

function playerImageConfig.getPlayerImageSexChangedCost()
local cfg=playerImageConfig.getCommomCfg()
return cfg.sex_changed_cost
end

function playerImageConfig.getAllPageCfgs()
return cfg_playerimagetabconfig()
end

function playerImageConfig.getPageCfg(pageid)
return cfg_playerimagetabconfig_get(pageid)
end

function playerImageConfig.getPageName(pageid)
return playerImageConfig.getPageCfg(pageid).name
end

function playerImageConfig.getSubTabCommonCfg(tabid)
return cfg_playerimagesubtabconfig_get(tabid)
end

function playerImageConfig.getDefaultImage(tabid,sex)
local cfg=playerImageConfig.getSubTabCommonCfg(tabid)
return cfg.defaultimage[sex]
end

function playerImageConfig.getAllSubTabId(pageid)
if _pageCfgs==nil then
_pageCfgs={}
_pageLookupCfgs={}
local cfgs=cfg_playerimagesubtabconfig()
for i,v in ipairs(cfgs)do
local page=v.tab
if _pageCfgs[page]==nil then _pageCfgs[page]={}end
local pageCfgs=_pageCfgs[page]
pageCfgs[#pageCfgs+1]=v.id
_pageLookupCfgs[v.id]=page
end
end
return _pageCfgs[pageid]
end

function playerImageConfig.getPageByTabId(tabid)
if _pageCfgs==nil then
_pageCfgs={}
_pageLookupCfgs={}
local cfgs=cfg_playerimagesubtabconfig()
for i,v in ipairs(cfgs)do
local page=v.tab
if _pageCfgs[page]==nil then _pageCfgs[page]={}end
local pageCfgs=_pageCfgs[page]
pageCfgs[#pageCfgs+1]=v.id
_pageLookupCfgs[v.id]=page
end
end
return _pageLookupCfgs[tabid]
end

function playerImageConfig.getAllSubConfig(sex,tabid)
if _requireCfg[tabid]==nil then
local name=playerImageConfig.getSubTabCommonCfg(tabid).exportname
local cfg=require(FMT.fmt('data/config/{0}',name))
_requireCfg[tabid]=cfg
end
if _imageCfgs[sex]==nil or _imageCfgs[sex][tabid]==nil then
if _imageCfgs.lookup==nil then _imageCfgs.lookup={}end
if _imageCfgs.lookup[tabid]==nil then _imageCfgs.lookup[tabid]={}end

local lookup=_imageCfgs.lookup[tabid]
local cfg=_requireCfg[tabid]
for _,v in pairs(cfg)do
local r_sex=v.sex

if v.version_id then
local version=pfwindowslController:getGameVersion()
if v.version_id[version]==1 then
if _imageCfgs[r_sex]==nil then _imageCfgs[r_sex]={}end
local imageSexCfgs=_imageCfgs[r_sex]
if imageSexCfgs[tabid]==nil then imageSexCfgs[tabid]={}end

local list=imageSexCfgs[tabid]
list[#list+1]=v
lookup[v.id]=v
end
else
if _imageCfgs[r_sex]==nil then _imageCfgs[r_sex]={}end
local imageSexCfgs=_imageCfgs[r_sex]
if imageSexCfgs[tabid]==nil then imageSexCfgs[tabid]={}end

local list=imageSexCfgs[tabid]
list[#list+1]=v
lookup[v.id]=v
end

end
table.sort(_imageCfgs[sex][tabid],function(a,b)
return a.id<b.id
end)
end
return _imageCfgs[sex][tabid],_imageCfgs.lookup[tabid]
end

function playerImageConfig.getSubConfig(tabid,id)
if id==0 then return end
if _requireCfg[tabid]==nil then
local name=playerImageConfig.getSubTabCommonCfg(tabid).exportname
local cfg=require(FMT.fmt('data/config/{0}',name))
_requireCfg[tabid]=cfg
end
local cfgs=_requireCfg[tabid]
return cfgs[id]
end

function playerImageConfig.getSubTabName(tabid)
return playerImageConfig.getSubTabCommonCfg(tabid).name
end

function playerImageConfig.isNewImage(tabid,id)



end

function playerImageConfig.getUnlockCost(tabid,id)
local cfg=playerImageConfig.getSubConfig(tabid,id)
return cfg and cfg.cost or nil
end

function playerImageConfig.isHideInPage(tabid,id)
local cfg=playerImageConfig.getSubConfig(tabid,id)
return cfg and cfg.isHide or nil
end


local clientUnlockConditionType={
eXianZhi=1,
}

local conditionCheckFunc={
[clientUnlockConditionType.eXianZhi]=function(args)
local limitLvMin=args[2]
local limitLvMax=args[3]
local xzLv=xianzhiModel:getXianZhiId()

if limitLvMin and xzLv>=limitLvMin then
if limitLvMax then
return xzLv<=limitLvMax
else
return true
end
else
return false
end
end,
}

function playerImageConfig.checkClientUnlock(tabid,id)
local cfg=playerImageConfig.getSubConfig(tabid,id)
if cfg and cfg.unlock_condition then
local state=true
for index,condition in ipairs(cfg.unlock_condition)do
local conditionType=condition[1]
if conditionType and conditionCheckFunc[conditionType]then
local cstate=conditionCheckFunc[conditionType](condition)
state=state and cstate
else
logErr(FMT.fmt("技术为处理此条件类型 :: {0}",conditionType))
end
end

return state
end
return false
end