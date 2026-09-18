







downAssetGroup={}

local _DownloadGroup=CS.ResourceHelper.DownloadGroup
local _SetDownloadGroup=CS.ResourceHelper.SetDownloadGroup
local _StartDownloadGroup=CS.ResourceHelper.StartDownloadGroup
local _StopDownloadGroup=CS.ResourceHelper.StopDownloadGroup

local _SetVersionJsonByKey=CS.AppDataModel.SetVersionJsonByKey
local _GetVersionJsonByKey=CS.AppDataModel.GetVersionJsonByKey
local VERSION_CONFIG_GROUP_FMT="g{%d}";

function downAssetGroup:enter()
downAssetGroup.groupID=0
downAssetGroup.singleFileCall=nil
downAssetGroup.onDownGroupCall=nil
downAssetGroup.totalSize=0
end

function downAssetGroup:leave()

end







function downAssetGroup.onSingleFileProgressCallBack(fval,fileName,speed)

if downAssetGroup.singleFileCall~=nil then
downAssetGroup.singleFileCall(fval,downAssetGroup.totalSize,fileName,speed)
end
end





function downAssetGroup.onGroupDownFinish(errorcode,groupid,resVersion)

if downAssetGroup.delayDown==nil then
downAssetGroup.onDownGroupCall(errorcode,groupid,resVersion)
end

if errorcode~=nil then




if string.find(errorcode,'%[timeout%]')==nil then
logErr(errorcode)
end
end
end









function downAssetGroup:startDownGroup(groupID,progressCall,finishCall,maxDownCount)

downAssetGroup.singleFileCall=progressCall
downAssetGroup.onDownGroupCall=finishCall


maxDownCount=downAssetManager:getDownloadMax()

local needDownSize=_DownloadGroup(groupID,true,maxDownCount,self.onSingleFileProgressCallBack,self.onGroupDownFinish,0)
downAssetGroup.totalSize=needDownSize



if needDownSize==0 then
downAssetGroup.onDownGroupCall(nil,groupID,0)
end
return needDownSize
end


function downAssetGroup:stopDownGroup()
if downAssetGroup.delayDown~=nil then
downAssetGroup.delayDown:cancel()
downAssetGroup.delayDown=nil
end
_StopDownloadGroup(true)
end

