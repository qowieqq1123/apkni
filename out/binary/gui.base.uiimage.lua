UIImage=UIObject


function UIImage:setImageIcon(icon,setNative)
self.__owner:setChildCSImageIcon(self.__id,icon,setNative)
end



function UIImage:setSprite(abname,asset)
self.__owner:setChildCSImageSprite(self.__id,abname,asset)
end



function UIImage:setImageExGray(flag)
self.__owner:setChildImageExGray(self.__id,flag)
end




function UIImage:setImageSprite(spriteIndex,isNative)
self.__owner:setChildImageSprite(self.__id,spriteIndex,isNative)
end
