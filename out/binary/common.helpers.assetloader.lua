






local _LoadAssetAsGameObject=CS.AssetLoader.LoadAssetAsGameObject
local _SpawnGameObject=CS.AssetPoolLoader.SpawnGameObject



assetLoader={}
local _loading={}
local function _LoadUICallback(key,ab)

local callback=_loading[key]
callback(key,ab)
_loading[key]=nil
end

function assetLoader.LoadUI(key,assetbundleName,syncLoad,callback)

if _loading[key]~=nil then



return
end

_loading[key]=callback
_LoadAssetAsGameObject({key},assetbundleName,'',syncLoad,-1,_LoadUICallback)
end

function assetLoader.LoadUIResource(key,prefab)

if _loading[key]~=nil then



return
end

_loading[key]=callback
_LoadAssetAsGameObject(key,assetbundleName,'',syncLoad,-1,_LoadUICallback)
end


function assetLoader.SpawnGameObject(key,tagname,assetbundleName,syncLoad,callback)
_loading[key]=callback
_SpawnGameObject(key,tagname,assetbundleName,syncLoad,callback,0)
end








function assetLoader.LoadAssetAsSprite(key,assetbundleName,assetName,syncLoad,callback)

_LoadAssetAsSprite(key,assetbundleName,assetName,syncLoad,true,callback)
end







function assetLoader.LoadAssetAsGameObject(key,assetbundleName,syncLoad,callback)

_LoadAssetAsGameObject(key,assetbundleName,'',syncLoad,false,callback)
end

function assetLoader.LoadAssetSpriteFromAtlas(key,assetName,callback)

_LoadAssetAsGameObject(key,assetName,false,true,callback)
end

function assetLoader.PoolManagerDestroyAll()


end
