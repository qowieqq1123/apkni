




contactTabController={}

local _

CONCAT_TYPE=
{
eTouZi=1,
}


CONCAT_TAB_TYPE=
{
eOperActivity=1,
}

local _concatfunc=
{
[CONCAT_TYPE.eTouZi]={

[CONCAT_TAB_TYPE.eOperActivity]={
add=function(tabType,data)
return UIFullTotalTouZiActivityontrol:addOperActivity(tabType,data)

end,
remove=function(data)
return UIFullTotalTouZiActivityontrol:removeOperActivity(data)

end,
check=function(data)
return UIFullTotalTouZiActivityontrol:checkJumpOperActivity(data)

end,
jump=function(data,warn)
local ret,error=UIFullTotalTouZiActivityontrol:jumpOperActivity(data,warn)
return ret,error

end,
},
},
}

function contactTabController:addTab(concatType,tabType,data)
if _concatfunc[concatType]==nil or
_concatfunc[concatType][tabType]==nil or
_concatfunc[concatType][tabType].add==nil then
loggerUtil.debugErrFMT('没有处理拼接类型{0} 页签类型{1}的方法',concatType,tabType)
return false
end
return _concatfunc[concatType][tabType].add(tabType,data)
end

function contactTabController:removeTab(concatType,tabType,data)
if _concatfunc[concatType]==nil or
_concatfunc[concatType][tabType]==nil or
_concatfunc[concatType][tabType].remove==nil then
loggerUtil.debugErrFMT('没有处理删除拼接类型{0} 页签类型{1}的方法',concatType,tabType)
return false
end
return _concatfunc[concatType][tabType].remove(data)
end

function contactTabController:checkTab(concatType,tabType,data)
if _concatfunc[concatType]==nil or
_concatfunc[concatType][tabType]==nil or
_concatfunc[concatType][tabType].check==nil then
loggerUtil.debugErrFMT('没有处理删除拼接类型{0} 页签类型{1}的方法',concatType,tabType)
return false
end
return _concatfunc[concatType][tabType].check(data)
end


function contactTabController:jumpTab(concatType,tabType,data,warn)
if _concatfunc[concatType]==nil or
_concatfunc[concatType][tabType]==nil or
_concatfunc[concatType][tabType].jump==nil then
loggerUtil.debugErrFMT('没有处理删除拼接类型{0} 页签类型{1}的方法',concatType,tabType)
return false
end
return _concatfunc[concatType][tabType].jump(data,warn)
end

