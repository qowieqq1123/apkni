





xingChenFightEffectChangeType={

}


local xingChenFightValFunc=
{




}


function xingChenCiZhuiEffectController:getXingChenFightVal(effectType,guid)
return xingChenFightValFunc[effectType](guid)
end


function xingChenCiZhuiEffectController:getEquippedXingChenFightVal(effectType)
if xingChenBagModel:getStarGrowEffectDirty(effectType)then
return self.data.fightData[effectType]
else
self.data.fightData=self.data.fightData or{}
self.data.fightData[effectType]=xingChenFightValFunc[effectType]()
xingChenBagModel:setStarFightEffectDirty(effectType)
return self.data.fightData[effectType]
end
end

