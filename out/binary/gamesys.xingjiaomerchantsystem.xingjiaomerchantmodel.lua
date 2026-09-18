






local _MODULENAME="xingjiaoMerchantModel"


def_table(_MODULENAME)
xingjiaoMerchantModel.name=_MODULENAME



function xingjiaoMerchantModel:onAppStart()

end


function xingjiaoMerchantModel:onEnterState(isReconnect)

end


function xingjiaoMerchantModel:onProtocolReq()

end


function xingjiaoMerchantModel:onLeaveState(isReconnect)

self:clearData()
end


function xingjiaoMerchantModel:setData(refreshTimes,randomIndex)
local fixLib=cfgHelper.get2(cfg_business1config_get,1,"fix_pool")
local fixData=fixLib[refreshTimes]
if fixData then
self.data=fixData
else
local randomLib=cfgHelper.get2(cfg_business1config_get,1,"rand_pool")
local randomData=randomLib[randomIndex]
self.data={randomData[1],randomData[2]}
end
end

function xingjiaoMerchantModel:getData()
return self.data
end

function xingjiaoMerchantModel:hasData()
return self:getData()~=nil
end

function xingjiaoMerchantModel:clearData()
self.data=nil
end

function xingjiaoMerchantModel:isOpenSys()
return systemModel.isOpen(SYSTEM_DEFINE.eBusiness1)
end