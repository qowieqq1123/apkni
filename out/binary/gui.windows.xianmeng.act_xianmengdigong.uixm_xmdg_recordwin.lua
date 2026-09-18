







def_class("UIXM_XMDG_RecordWin",UIWindowBase)









function UIXM_XMDG_RecordWin:bindComponents()

self.listPanel=UIObject.get(self,0)
self.nullTxt=UIText.get(self,1)
self.recordContent=UIObject.get(self,2)
self.btnClose=UIButton.get(self,3)
self.title=UIText.get(self,4)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIXM_XMDG_RecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.listPanel);self.listPanel=nil;
_UIObject_release(self.nullTxt);self.nullTxt=nil;
_UIObject_release(self.recordContent);self.recordContent=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UIXM_XMDG_RecordWin:onLoaded(...)
self:bindComponents()
end


function UIXM_XMDG_RecordWin:__delete()
self:unbindComponents()
end




function UIXM_XMDG_RecordWin:onShow(argtable,afterOnloaded)
self.recordType=argtable and argtable.recordType or XMDG_Shop_Record_Type.eAuction


local titleText
if self.recordType==XMDG_Shop_Record_Type.eAuction then
titleText="竞投记录"

xianmengdigongController:reqAuctionRollRecord()
elseif self.recordType==XMDG_Shop_Record_Type.eShop then
titleText="兑换记录"

xianmengdigongController:reqShopBuyRecord()
end
self.title:setText(titleText)


self:refresh()
end

function UIXM_XMDG_RecordWin:refresh(recordType)
if recordType and recordType~=self.recordType then

return
end


self.recordList=xianmengdigongModel:getXMDG_recordListByType(self.recordType)or{}

local count=#self.recordList
if count>0 then
self.listPanel:setActive(true)
self.nullTxt:setActive(false)


self.recordContent:setChildLayoutGroupCreateItems(count)
local grids=self.recordContent:getChildLayoutGroupGridList()
for i=1,count do
self:refreshRecordItem(grids[i-1],i,count)
end
else
self.listPanel:setActive(false)
self.nullTxt:setActive(true)
local nullText
if self.recordType==XMDG_Shop_Record_Type.eAuction then
nullText="暂无竞投记录"
elseif self.recordType==XMDG_Shop_Record_Type.eShop then
nullText="暂无兑换记录"
end

self.nullTxt:setText(nullText)
end
end


function UIXM_XMDG_RecordWin:onHide()

end


function UIXM_XMDG_RecordWin:refreshRecordItem(item,index,recordCount)
if item==nil then

item=self.recordContent:getChildLayoutGroupGridItem(index-1)
end

if item then
local dataIndex=recordCount-index+1
local recordData=self.recordList[dataIndex]

local actorName=recordData.actor_name
local itemId=recordData.item_id
local itemConfig=itemsConfig.getConfig(itemId)
local itemName=itemConfig.name
local itemColor=itemConfig.color
local itemCount=recordData.item_num
local itemNameStr=FMT.cfmt(itemColor,"{0}x{1}",itemName,itemCount)
local descStr
if self.recordType==XMDG_Shop_Record_Type.eAuction then
local rollPoint=recordData.rand_roll_num
local isSuccess=recordData.result==1
local isFinish=recordData.is_win==1
local checkNum=rollPoint
if isFinish then
checkNum=-2
elseif isSuccess then
checkNum=-1
end
local recordText=self:getAuctionRecordText(checkNum)
descStr=FMT.fmt(recordText,actorName,itemNameStr,rollPoint)
elseif self.recordType==XMDG_Shop_Record_Type.eShop then
local actorNameStr=FMT.cfmt(FONT_COLOR.eGreenColor,actorName)
descStr=FMT.fmt("{0} 兑换了 {1} ",actorNameStr,itemNameStr)
end
descStr=string.replaceSpace(descStr)
item:SetChildText(0,descStr)
end
end

function UIXM_XMDG_RecordWin:getAuctionRecordText(checkNum)

local tipsList=cfgHelper.get2(cfg_xmdgauctionconfig_get,1,'auctionRecordText')or{}
local tipsStr=""

for i,v in ipairs(tipsList)do
local minNum=v[1]
local maxNum=v[2]
local tips=v[3]
if checkNum>=minNum and checkNum<=maxNum then
tipsStr=tips
end
end

return tipsStr
end




function UIXM_XMDG_RecordWin:onBtnClose()
self:closeSelf()
end

