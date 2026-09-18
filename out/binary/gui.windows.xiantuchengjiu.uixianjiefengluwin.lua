







def_class("UIXianJieFengLuWin",UIWindowBase)









function UIXianJieFengLuWin:bindComponents()

self.btnClose=UIButton.get(self,0)
self.getRewardBtn=UIButton.get(self,1)
self.mask=UIButton.get(self,2)
self.wagesList=UIObject.get(self,3)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.getRewardBtn:setButtonClick(function()self:onGetRewardBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIXianJieFengLuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.getRewardBtn);self.getRewardBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.wagesList);self.wagesList=nil;
end
















local CmpWagesSlotIndex={
title=0,
wagesList=1,
tips=2,
}

local xjWagesTypeEnum={
xianzhi=1,
xianguan=2,
}

local xjWagesTypeList={
[xjWagesTypeEnum.xianzhi]={
getTitle=function()
local xzid=xianzhiModel:getXianZhiId()
if xzid then
local jcTian=cfgHelper.get2(cfg_xianzhiconfig_get,xzid,'jctian')
return FMT.fmt("仙职：{0}重天",mathHelper.numberToChinese(jcTian))
else
return"暂无仙职"
end
end,
getWagesList=function()
return xianzhiConfig.getWagesItemsList()
end,
},
[xjWagesTypeEnum.xianguan]={
getTitle=function()
local jobInfo=xianguanController.getBestShowJob()
if jobInfo then
local jobName=xianguanConfig.getJobConfig(jobInfo.groupId,jobInfo.jobId,'name')
return FMT.fmt("仙官：{0}",jobName)
else
return"未担任仙官"
end
end,
getWagesList=function()
return xianguanController.getXianGuanWages()
end,
},
}




function UIXianJieFengLuWin:onLoaded(...)
self:bindComponents()
end


function UIXianJieFengLuWin:__delete()
self:unbindComponents()
end




function UIXianJieFengLuWin:onShow(argtable,afterOnloaded)
local len=#xjWagesTypeList

local rate=1+xianzhiModel:getRewardPercent()/1000000

local createFunc=function(index)
local item=self.wagesList:getChildLayoutGroupGridItem(index-1)

local typeFunc=xjWagesTypeList[index]

local title=typeFunc.getTitle()

item:SetChildText(CmpWagesSlotIndex.title,title)

local wagesList=typeFunc.getWagesList()
local wlen=#wagesList

item:SetChildActive(CmpWagesSlotIndex.wagesList,wlen>0)
item:SetChildActive(CmpWagesSlotIndex.tips,wlen==0)

item:SetChildLayoutGroupCreateItems(CmpWagesSlotIndex.wagesList,wlen,function(windex)
local witem=item:GetChildLayoutGroupGridItem(CmpWagesSlotIndex.wagesList,windex-1)

local data=wagesList[windex]

local itemid=data[1]
local itemCount=Mathf.Floor(data[2]*rate)
local showCountBG=itemCount>1
local countStr=showCountBG and mathHelper.formatNumber4(itemCount,2)or""

local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
witem:SetChildPropData(-1,propData)

witem:SetBaseItemClickEvent(-1,function()
itemsComponentHelper.onItemClick(itemid)
end)
end)
end
self.wagesList:setChildLayoutGroupCreateItems(len,createFunc)

end


function UIXianJieFengLuWin:onHide()

end





function UIXianJieFengLuWin:onBtnClose()
self:closeSelf()
end



function UIXianJieFengLuWin:onGetRewardBtn()

wagesMsgConfig:doReceiveWages(wagesTypeEnum.eXianZhi)
end



function UIXianJieFengLuWin:onMask()
self:onGetRewardBtn()
end
