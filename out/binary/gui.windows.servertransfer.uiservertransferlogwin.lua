







def_class("UIServerTransferLogWin",UIWindowBase)









function UIServerTransferLogWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.logMainContent=UIObject.get(self,1)
self.notRecord=UIObject.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIServerTransferLogWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.logMainContent);self.logMainContent=nil;
_UIObject_release(self.notRecord);self.notRecord=nil;
end



















function UIServerTransferLogWin:onLoaded(...)
self:bindComponents()
end


function UIServerTransferLogWin:__delete()
self:unbindComponents()
end




function UIServerTransferLogWin:onShow(argtable,afterOnloaded)


























local logDataList=ServerTransferModel:getTransferReviewLogDatas()or defaultT
local dateLogLookup={}
local dateLogList={}
for i,v in ipairs(logDataList)do
local longTime=timeHelper.convertLongStamp(v.deal_sec)
local timeInfo=timeHelper.dateServerStampData(longTime)
local date=string.format("%s-%s-%s",timeInfo.year,timeInfo.month,timeInfo.day)
local time=timeHelper.dateServerStamp('%H:%M:%S',longTime)
if not dateLogLookup[date]then
dateLogLookup[date]={}
table.insert(dateLogList,date)
end
local logStr=""
if v.deal_result==1 then
local zmGradeStr=ServerTransferModel:getZongMenGradeName(v.real_zm_pj)
logStr=string.format("%s消耗了一位<color=#CA631D>%s</color>名额同意了%s的跃迁申请",v.deal_actor_name,zmGradeStr,v.ask_actor_name)
else
logStr=string.format("%s拒绝了%s的跃迁申请",v.deal_actor_name,v.ask_actor_name)
end
table.insert(dateLogLookup[date],{time=time,log=logStr})
end
self.notRecord:setActive(#dateLogList<=0)
self.logMainContent:setChildLayoutGroupCreateItems(#dateLogList,function(index)
local logMainItem=self.logMainContent:getChildLayoutGroupGridItem(index-1)
local date=dateLogList[index]
local logList=dateLogLookup[date]
logMainItem:SetChildText(0,date)
logMainItem:SetChildLayoutGroupCreateItems(1,#logList,function(idx)
local logItem=logMainItem:GetChildLayoutGroupGridItem(1,idx-1)
local logData=logList[idx]
logItem:SetChildText(0,logData.time)
logItem:SetChildText(1,logData.log)
end)
end)
end



function UIServerTransferLogWin:onCloseBtn()
self:closeSelf()
end

