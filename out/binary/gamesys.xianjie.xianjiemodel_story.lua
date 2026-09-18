





function xianjieModel:initStory()
self.storyUnitLookUp={}
self.checkUnitLookup={}
self.unitEntityLookUp={}
self.effectLookUp={}
end

function xianjieModel:clearData_Story()
end


function xianjieModel:pushStoryUnit(unitKey,entKey)
self.storyUnitLookUp[unitKey]=entKey
end

function xianjieModel:getStoryUnit(unitKey)
return self.storyUnitLookUp[unitKey]
end

function xianjieModel:getLookUp()
return self.storyUnitLookUp
end


function xianjieModel:pushUnit(unitKey,widget)
self.checkUnitLookup[unitKey]=widget
end

function xianjieModel:getUnit(unitKey)
return self.checkUnitLookup[unitKey]
end

function xianjieModel:popUnit(unitKey)
self.checkUnitLookup[unitKey]=nil
end



function xianjieModel:getUnitEntityLookUp()
return self.unitEntityLookUp
end

function xianjieModel:pushUnitEntity(unitKey,ent)
self.unitEntityLookUp[unitKey]=ent
end

function xianjieModel:getUnitEntity(unitKey)
return self.unitEntityLookUp[unitKey]
end



function xianjieModel:getEffectLookup()
return self.effectLookUp
end

function xianjieModel:pushEffectHandle(key,handle)
self.effectLookUp[key]=handle
end

function xianjieModel:getEffectHandle(key)
return self.effectLookUp[key]
end