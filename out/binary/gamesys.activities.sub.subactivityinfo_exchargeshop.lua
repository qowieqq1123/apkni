
local subActivityInfo_exchargeshop={name='exchargeshop'}

function subActivityInfo_exchargeshop:onInit()

end

function subActivityInfo_exchargeshop:onStart()

end

function subActivityInfo_exchargeshop:onDelete()

end

function subActivityInfo_exchargeshop:checkReddot()
return self:hasPrize()
end


function subActivityInfo_exchargeshop:getShopLevel()
local data=self.data
if data==nil then return 0 end
local exp=data.exp
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
local lvcfg=config.level
local need=0
local info
local len=#lvcfg
local level=len
for i,v in ipairs(lvcfg)do
if exp<v[1]then
level=i
need=v[1]-exp
info=v
break
end
end
if info==nil then info=lvcfg[len]end
local isMax=level==len
return level,need,info,isMax
end

function subActivityInfo_exchargeshop:getCanPrizeLevel()
local data=self.data
if data==nil then return{}end
local exp=data.exp or 0
local flag=data.flag or 0
local config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
local lvcfg=config.level
local levels={}
local max=#lvcfg
for i,v in ipairs(lvcfg)do
if exp>=v[1]and i~=max then
if not mathHelper.getBitValue(flag,i-1)then
levels[#levels+1]=i
end
else
break
end
end
return levels
end

function subActivityInfo_exchargeshop:hasPrize()
local data=self.data
if data==nil then return false end
return#self:getCanPrizeLevel()>0
end

function subActivityInfo_exchargeshop:alreadyPrize(i)
local data=self.data
if data==nil then return false end
local flag=data.flag or 0
return mathHelper.getBitValue(flag,i-1)
end

function subActivityInfo_exchargeshop:checkNewDay()
activitiesHandle_exchargeshop.onNewDay(self.sub_act_type,self.sub_act_id)
end

return subActivityInfo_exchargeshop