
local _httpGetRequest=CS.ResourceHelper.HttpGetRequest;


verifyData={}

function verifyData:loadData()
local path=CS.GamePath.streamingAssetsPath..'/'..'gameInfo.json'






self.data=jsonHelper.readPath(path)or{}
end

function verifyData:loadDataFromServer(callback)
local path=CS.GamePath.streamingAssetsPath..'/'..'gameInfo.json'
if gameInfo:checkFileCacheMode(1)then
path=gameInfo:getPackageCDNURL()..'/'..'gameInfo.json'
end
local cb
cb=function(message,err)
if err==nil or err==''then
self.data=jsonHelper.decode_josn(message,{})
if callback then
callback()
end
else
UIUpdateDialog.ShowDialogBox('警告','网络连接异常，请重试',function()_httpGetRequest(path,cb)end,nil,false)
end
end
_httpGetRequest(path,cb)
end

function verifyData:getPFInfo()
return self.data.pfInfo
end

function verifyData:getLoginData()
return self.data.defLoginData
end

function verifyData:getServerListData()
return self.data.serverListData
end

function verifyData:getCDNJsonPath()
return self.data.cdnjson
end

function verifyData:getProductData()
return self.data.productData
end

function verifyData:getUserProtocolRUL()
return self.data.userProtocolRUL
end

function verifyData:getProviteProtocolURL()
return self.data.proviteProtocolURL
end

function verifyData:getCustomQualification()
return self.data.customQualification
end

