UIRawImage=UIObject

function UIRawImage:load(pathType,baseURL,filename,setNativeSize)
self.__owner:setChildRawImageLoader(self.__id,pathType,baseURL,filename,setNativeSize)
end

function UIRawImage:loadFromStreamingAsset(baseURL,filename,setNativeSize)
if setNativeSize==nil then
setNativeSize=false
end
self.__owner:setChildRawImageLoader(self.__id,0,baseURL,filename,setNativeSize)
end
