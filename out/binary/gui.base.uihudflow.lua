UIHUDFlow=UIObject







function UIHUDFlow:genFlowObj(typo,normol,stayTime,startPos,dir,onSpwanAcion,onDespwanAcion)
return self.__owner:setChildGenFlowObj(self.__id,typo,normol,stayTime,startPos,dir,onSpwanAcion,onDespwanAcion)
end

function UIHUDFlow:stop(id)
self.__owner:setChildStopFlowObj(self.__id,id)
end