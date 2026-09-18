







downAssetSubPackage={}

local _GetNeedDownloadGroupInPack=CS.ResourceHelper.UpdateManager_GetNeedDownloadGroupInPack
local _GetTotalNeedUpdatePackageSize=CS.ResourceHelper.UpdateManager_GetTotalNeedUpdatePackageSize



function downAssetSubPackage.onGroupDownFinish(errorcode,groupid,resVersion)


if errorcode==nil then
downAssetSubPackage.retryCount=0
table.remove(downAssetSubPackage.groupArray,1)
local groupNum=#downAssetSubPackage.groupArray
if groupNum>0 then
downAssetSubPackage:downLoadGroup()
end
downAssetSubPackage.groupDownCall(groupid,resVersion,groupNum)
else




downAssetSubPackage.retryCount=downAssetSubPackage.retryCount+1
if downAssetSubPackage.retryCount>4 then
downAssetSubPackage.groupDownCall(groupid,resVersion,-2)
else
local groupNum=#downAssetSubPackage.groupArray
if groupNum>0 then
if downAssetSubPackage.FailedDelayDown~=nil then
downAssetSubPackage.FailedDelayDown:cancel()
downAssetSubPackage.FailedDelayDown=nil
end

local delayDownCall=function()
downAssetSubPackage:downLoadGroup()
downAssetSubPackage.FailedDelayDown=nil
end

downAssetSubPackage.FailedDelayDown=timer.new()
downAssetSubPackage.FailedDelayDown:start(10*downAssetSubPackage.retryCount,delayDownCall,1)
else
downAssetSubPackage.groupDownCall(groupid,resVersion,-2)
end
end
end
end





function downAssetSubPackage:startDownPackage(groupArray,singleFileCallBack,groupDownFinish)
downAssetGroup:stopDownGroup()
self.singleFileDownCall=singleFileCallBack
self.groupDownCall=groupDownFinish
self.errorGroup={}
downAssetSubPackage.retryCount=0
self.groupArray=groupArray
local groupNum=#self.groupArray
local groupID=-1
local size=0
if groupNum>0 then
downAssetSubPackage:downLoadGroup()
end

end


function downAssetSubPackage:stopDownPackage()
if self.delayDown~=nil then
self.delayDown:cancel()
self.delayDown=nil
end

if self.FailedDelayDown~=nil then
self.FailedDelayDown:cancel()
self.FailedDelayDown=nil
end
downAssetGroup:stopDownGroup()
end





function downAssetSubPackage:downLoadGroup()

local group=self.groupArray[1]
local size=downAssetGroup:startDownGroup(group,self.singleFileDownCall,self.onGroupDownFinish,3)

if size<0 then

local giveupTry=self:recordErrorGroup(groupid)
if giveupTry==false then
local groupNun=#self.groupArray
table.remove(self.groupArray,1)
self.groupArray[#self.groupArray+1]=group
if self.delayDown~=nil then
self.delayDown:cancel()
self.delayDown=nil
end

local delayDownCall=function()
downAssetSubPackage:downLoadGroup()
self.delayDown=nil
end

self.delayDown=timer.new()
self.delayDown:start(1,delayDownCall,1)
else

self.groupDownCall(0,0,-2)
end
end
return group,size
end



function downAssetSubPackage:recordErrorGroup(groupid)
if self.errorGroup[groupid]~=nil then
self.errorGroup[groupid]=self.errorGroup[groupid]+1
if self.errorGroup[groupid]>3 then
return true
end
else
self.errorGroup[groupid]=1
end

return false
end
