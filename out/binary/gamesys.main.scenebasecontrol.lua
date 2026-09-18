sceneBaseControl={}

function sceneBaseControl:resetSceneData()
self.sceneType=nil
self.mapId=nil
end

function sceneBaseControl:onChangeScene(sceneType)
self.sceneType=sceneType
self.mapId=nil
self:onChangeScene_(sceneType)
end

function sceneBaseControl:onChangeSceneMap(sceneType,mapId)
if sceneType==self.sceneType and self.mapId==mapId then return end
self.sceneType=sceneType
self.mapId=mapId
self:onChangeSceneMap_(sceneType,mapId)
end