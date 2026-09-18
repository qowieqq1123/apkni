







def_class("UISubAct_CangBaoTuRecordWin",UIWindowBase)









function UISubAct_CangBaoTuRecordWin:bindComponents()

self.numTx=UIText.get(self,0)
self.list=UIObject.get(self,1)



end


function UISubAct_CangBaoTuRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.numTx);self.numTx=nil;
_UIObject_release(self.list);self.list=nil;
end















local _this=nil
local _itemCmp={
content=0,
time=1,
}



function UISubAct_CangBaoTuRecordWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_CangBaoTuRecordWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_CangBaoTuRecordWin:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
call_activitiesHandle_func('activitiesHandle_cangbaotu','reqShareRecord',self.activityId,self.subId)
self:refreshNum()
end


function UISubAct_CangBaoTuRecordWin:onHide()

end



function UISubAct_CangBaoTuRecordWin:refreshView(check)
if check then
if check[1]~=self.activityId or check[2]~=self.subType or check[3]~=self.subId then
return
end
end

local datas=self.info:getRecord()
self.list:setChildLayoutGroupCreateItems(#datas,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local data=datas[index]
local content=self.config.record[data.recordtype]
local moneyName=itemsConfig.getColorName(data.moneytype)
local contentStr=FMT.fmt(content,moneyName,data.actorname)
local longstamp=timeHelper.convertLongStamp(data.recordsec)
local timeStr=timeHelper.dateServerStamp('%Y.%m.%d   %H:%M:%S',longstamp)

item:SetChildText(_itemCmp.content,contentStr)
item:SetChildText(_itemCmp.time,timeStr)
end)
end

function UISubAct_CangBaoTuRecordWin:refreshNum(check)
if check then
if check[1]~=self.activityId or check[2]~=self.subType or check[3]~=self.subId then
return
end
end

if self.config.recv and self.config.recv>0 then
local data=self.info:getData()
local str=FMT.fmt("今日获赠仙友分享次数：{0}/{1}",data.task.recvtimes,self.config.recv)
self.numTx:setText(str)
end
end