UIProgress=UIObject


function UIProgress:setProgress(val,max)
self.__owner:setChildProgress(self.__id,val,max)
end



function UIProgress:setProgressInt64(val,max)
self.__owner:setChildProgressInt64(self.__id,val,max)
end




function UIProgress:setProgressOnTime(current,target,max)
self.__owner:setChildProgressOnTime(self.__id,current,target,max)
end



function UIProgress:setProgressUInt64(val,max)
self.__owner:setChildProgressUInt64(self.__id,val,max)
end



function UIProgress:setProgressValue(val,max)
self.__owner:setChildProgressValue(self.__id,val,max)
end

function UIProgress:setChildProgressText(text)
self.__owner:setChildProgressText(self.__id,text)
end