UISprite=UIObject


function UISprite:setSpriteAnimationPrefabIndex(spid,loop)
self.__owner:setChildSpriteAnimationPrefabIndex(self.__id,spid,loop)
end



function UISprite:setSpriteByPrefabIndex(spid,native)
self.__owner:setChildSpriteByPrefabIndex(self.__id,spid,native or false)
end


function UISprite:setSpriteRenderByIndex(spid)
self.__owner:setChildSpriteRenderByIndex(self.__id,spid)
end
