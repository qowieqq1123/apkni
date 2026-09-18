UI3DDisplayStand=UIObject








function UI3DDisplayStand:set3DDisplayStand(standID,component_ids,size,position,rotation,animId,offset)
self.__owner:setChild3DDisplayStand(self.__id,standID,component_ids,size,position,rotation,animId,offset)
end









function UI3DDisplayStand:set3DDisplayStandAndIdle(standID,component_ids,size,position,rotation,animId,offset,idle)
self.__owner:setChild3DDisplayStandAndIdle(self.__id,standID,component_ids,size,position,rotation,animId,offset,idle)
end