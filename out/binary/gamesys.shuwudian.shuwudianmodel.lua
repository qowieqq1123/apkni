







shuwudianModel={}



function shuwudianModel.saveSortType_kickout(idx)
onlineDataSetting:setData(onlineDataKeyType.eDiscipleSelectSortType_kickout,idx)
end
function shuwudianModel.getSortType_kickout()
return onlineDataSetting:getData(onlineDataKeyType.eDiscipleSelectSortType_kickout,nil)
end
function shuwudianModel.saveSortCondition_kickout(sortCondition)
local saveSortCondition={}
for k,v in pairs(sortCondition)do
saveSortCondition[tostring(k)]=v
end
onlineDataSetting:setData(onlineDataKeyType.eDiscipleSelectSortCond_kickout,saveSortCondition)
end
function shuwudianModel.getSortCondition_kickout()
local temp=onlineDataSetting:getData(onlineDataKeyType.eDiscipleSelectSortCond_kickout,{})
local temp_=table.deepCopy(temp)
local saveSortCondition={}
for k,v in pairs(temp_)do
saveSortCondition[tonumber(k)]=v
end
return saveSortCondition
end

