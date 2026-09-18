buildTiaoZhanModel={}

function buildTiaoZhanModel:initData()
self.data={}
end

function buildTiaoZhanModel:setShiLianTaFightType(sltType)
if self.data.shilianta==sltType then return end
self.data.shilianta=sltType
for i,v in pairs(buildShiLianTaFightFunc)do
if sltType~=i and v.completeFight then
v.completeFight()
end
end
end

function buildTiaoZhanModel:getShiLianTaFightType()
return self.data.shilianta
end

function buildTiaoZhanModel:clearShiLianTaFightType(sltType)
if sltType==self.data.shilianta then
self.data.shilianta=nil
end
end