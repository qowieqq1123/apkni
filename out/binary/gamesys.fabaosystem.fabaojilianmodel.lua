






function fabaoModel.initJilian()

end































function fabaoModel:loadFabaoJiLianFilterIdx()
local defaultSelectIdx=1
self.selectedFilterIdx=userActorSetting.get('fabaojilianselected',{defaultSelectIdx,defaultSelectIdx})
end

function fabaoModel:saveFabaoJiLianFilterIdx()
userActorSetting.set('fabaojilianselected',self.selectedFilterIdx)
userActorSetting.flush()
end

function fabaoModel:changeFabaoJiLianFilterIdxByType(dropType,idx)
if not self.selectedFilterIdx then
self.selectedFilterIdx={}
end
if dropType==ITEM_FILTER_TYPE.eStage then
self.selectedFilterIdx[1]=idx
elseif dropType==ITEM_FILTER_TYPE.eColor then
self.selectedFilterIdx[2]=idx
end

reddotControl.on_change_catch_type(CATCH_TYPE.eFabaoJiLianFilterChanged)
end

function fabaoModel:getFabaoJiLianFilterIdx(dropType)
local list=self.selectedFilterIdx
local defaultSelectIdx=1
if dropType==ITEM_FILTER_TYPE.eStage then
return list and list[1]or defaultSelectIdx
elseif dropType==ITEM_FILTER_TYPE.eColor then
return list and list[2]or defaultSelectIdx
end
return defaultSelectIdx
end


function fabaoModel:getCacheTempTable_Materials()
if not self.cache_temp_materials then
self.cache_temp_materials={}
end

table.clear(self.cache_temp_materials)
return self.cache_temp_materials
end