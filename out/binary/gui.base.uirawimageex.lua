UIRawImageEX=UIObject




function UIRawImageEX:setRawImageEx(handle,size,offsetX,offsetY)
self.__owner:setChildRawImageEx(self.__id,handle,size,offsetX,offsetY)
end


function UIRawImageEX:setRawImageExBloomEnable(value)
self.__owner:setChildRawImageExBloomEnable(self.__id,value)
end





function UIRawImageEX:setRawImageExBloomParams(intensity,bloomType,resolution,blurType)
self.__owner:setChildRawImageExBloomParams(self.__id,intensity,bloomType,resolution,blurType)
end








function UIRawImageEX:setRawImageExHandle(handle,size,position,rotation,animationID,layer,rootOffset)
self.__owner:setChildRawImageExHandle(self.__id,handle,size,position,rotation,animationID,layer,rootOffset)
end






function UIRawImageEX:setRawImageExInfo(handle,size,offsetX,offsetY,rotation)
self.__owner:setChildRawImageExInfo(self.__id,handle,size,offsetX,offsetY,rotation)
end










function UIRawImageEX:setRawImageExModel(modelID,weaponId,wingId,size,position,rotation,animationID,layer,rootOffset)
self.__owner:setChildRawImageExModel(self.__id,modelID,weaponId,wingId,size,position,rotation,animationID,layer,rootOffset)
end








function UIRawImageEX:setRawImageExModelInfo(modelID,size,offsetX,offsetY,rotation,animationID,rootOffset)
self.__owner:setChildRawImageExModelInfo(self.__id,modelID,size,offsetX,offsetY,rotation,animationID,rootOffset)
end


