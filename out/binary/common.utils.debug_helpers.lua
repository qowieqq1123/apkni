







local _s_lower=string.lower
local _s_gsub=string.gsub
function reload(szName)

local moduleInfo=nil
if type(szName)=='table'then
moduleInfo=szName._NAME
else
moduleInfo=_s_lower(_s_gsub(szName,'/','.'))
end
if not moduleInfo then
error('expected arg #1 string or table got '..type(moduleInfo))
end
if package.loaded[moduleInfo]~=nil then
package.loaded[moduleInfo]=nil
collectgarbage()
end
return require(moduleInfo)
end
