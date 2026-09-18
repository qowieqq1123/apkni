xianjieHelper={}
local _debugStamp
function xianjieHelper.require(filename,fileLookup,typo)
local child=nil













child=fileLookup[typo]
if child==nil then
child=require(filename)
fileLookup[typo]=child
end




return child
end
