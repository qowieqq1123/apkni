






local _MODULENAME="blueDiamondModel"
local sformat=string.format


def_table(_MODULENAME)
blueDiamondModel.name=_MODULENAME
blueDiamondModel.data={}

function blueDiamondModel:onAppStart()

end


function blueDiamondModel:onEnterState(isReconnect)

end


function blueDiamondModel:onProtocolReq()

end


function blueDiamondModel:onLeaveState(isReconnect)

self.data={}
end


function blueDiamondModel.getBuleDiamondIcon(blueinfo)
if blueinfo.isSBule then
return sformat('image_hhlz_%d',blueinfo.level)
else
return sformat('image_lz_%d',blueinfo.level)
end
end

function blueDiamondModel:setBuleData(blueinfo,blueexpire)
self.data.blueInfo=blueinfo
self.data.blueexpire=blueexpire
end

function blueDiamondModel:getBuleInfo()
return self.data.blueInfo
end

function blueDiamondModel:getData()
return self.data
end

function blueDiamondModel:checkOpen()



if not blueDiamondModel:isHasBlueDiamond()then
return false
end
return systemModel.isOpen(SYSTEM_DEFINE.eBlueDiamond)
end

function blueDiamondModel:checkReddot()
return reddotClassManager.get_reddot(REDDIT_TYPE.eBlueDiamond)
end

function blueDiamondModel:isHasBlueDiamond()
if not pfCommonHelper:isRunPC()then
return false
end
local qqPfid=cfgHelper.get2(cfg_globalconfig_get,1,'qqPfid')
local pfid=loginModel:getPfid()
return qqPfid==pfid
end
