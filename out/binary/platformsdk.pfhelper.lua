pfHelper={}

function pfHelper.showDelAccount()
local pfid=loginModel:getPfid()
local delaccount=cfgHelper.get2(cfg_pfcommonconfig_get,1,'delaccount')
if delaccount==nil then return false end
return delaccount[pfid]~=nil
end