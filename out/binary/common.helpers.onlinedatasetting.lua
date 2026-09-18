








onlineDataSetting={}

local myData=nil

onlineDataKeyType={
eDiscipleSelectSortType=1,
eDiscipleSelectSortCond=2,
ePrivateMoneyTimes=3,
eDiscipleChuiWei=4,
eDiscipleSelectSortType_kickout=5,
eDiscipleSelectSortCond_kickout=6,
eDiscipleDickoutSelectCheckColor=7,

eLingShouSelectSortType=8,
eLingShouSelectSortCond=9,
}

function onlineDataSetting.onEnter()
myData={}
end

function onlineDataSetting.reset()
myData=nil
end

function onlineDataSetting:setData(key,data)
myData[key]=data

end

function onlineDataSetting:getData(key,defualt)
if myData then
local data=myData[key]
if data~=nil then
return data
else
return defualt
end
else

return defualt
end
end
