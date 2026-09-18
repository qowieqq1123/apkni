UIButton=UIObject


function UIButton:setButtonClick(action,removeAllListeners,soundID)
if removeAllListeners==nil then removeAllListeners=true end
soundID=soundID or SoundID.BtnClick

self.__owner:setChildButtonClick(self.__id,action,removeAllListeners,soundID)
end



function UIButton:setButtonEnable(flag,gray)
self.__owner:setChildButtonEnable(self.__id,flag,gray)
end


function UIButton:setButtonInteractable(flag)
self.__owner:setChildButtonInteractable(self.__id,flag)
end

function UIButton:setButtonInvoke()
self.__owner:setChildButtonInvoke(self.__id)
end
