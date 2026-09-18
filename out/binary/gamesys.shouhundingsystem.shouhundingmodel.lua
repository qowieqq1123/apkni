






local _MODULENAME="shouhundingModel"


def_table(_MODULENAME)
shouhundingModel.name=_MODULENAME


function shouhundingModel:onAppStart()

end


function shouhundingModel:onEnterState(isReconnect)

end


function shouhundingModel:onProtocolReq()

end


function shouhundingModel:onLeaveState(isReconnect)

end


function shouhundingModel:getDataValue()
local moneyType=self:getDataType()
return moneyModel.getMoney(moneyType)
end

function shouhundingModel:isDataType(type)
local moneyType=self:getDataType()
return moneyType==type
end

function shouhundingModel:getDataType()
return cfgHelper.get4(cfg_shouhundingconfig_get,1,"cost",1,1)
end

function shouhundingModel:getDataMax()
return cfgHelper.get4(cfg_shouhundingconfig_get,1,"cost",1,2)
end

function shouhundingModel:getSysID()
return cfgHelper.get2(cfg_shouhundingconfig_get,1,"sysId")
end

function shouhundingModel:isSysID(sysId)
return self:getSysID()==sysId
end

function shouhundingModel:isEntityType(entityType)
local sysId=self:getSysID()
local sysCfg=cfgHelper.get1(cfg_systemopenconfig_get,sysId)
return sysCfg.openargs[1][1][2]==entityType
end

function shouhundingModel:checkEntityData(monsterData)
local sysId=self:getSysID()
local sysCfg=cfgHelper.get1(cfg_systemopenconfig_get,sysId)
local monsterCfg=monsterData:getCfg()
local config=sysCfg.openargs[1][1]
if config[1]==SYSTEM_OPEN_TYPE.eXianJieEntityStage then
local temp=cfgHelper.get3(cfg_fairylandrefreshstageconfig_get,config[2],config[3],"maxlevel")
return config[2]==monsterData.entitytype and temp<=monsterCfg.stage
end
return true
end

local _preview=nil
function shouhundingModel:getPreviewData()
if not _preview then
_preview={
[1]={},
[2]={},
}
local dropId=cfgHelper.get2(cfg_shouhundingconfig_get,1,"dropId")
local items=cfgHelper.get2(cfg_awardconfig_get,dropId,'detailItems')
for i,v in ipairs(items)do
local itemId=v[1]
local itemCfg=itemsConfig.getConfig(itemId)
local xmType=itemCfg.type3
if xmType and _preview[xmType]then
table.insert(_preview[xmType],itemId)
end
end
end

return _preview
end