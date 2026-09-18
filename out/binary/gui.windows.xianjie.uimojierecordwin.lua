







def_class("UIMoJieRecordWin",UIWindowBase)









function UIMoJieRecordWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.leftBtn=UIButton.get(self,1)
self.myEmptyReward=UIText.get(self,2)
self.myNumTx=UIText.get(self,3)
self.myRankTx=UIText.get(self,4)
self.myRewardList=UIObject.get(self,5)
self.myRewardView=UIObject.get(self,6)
self.picture=UIImage.get(self,7)
self.rightBtn=UIButton.get(self,8)
self.serverPlayerTx=UIText.get(self,9)
self.serverTotalTx=UIText.get(self,10)
self.serverXMTx=UIText.get(self,11)
self.titleImg=UIImage.get(self,12)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UIMoJieRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.myEmptyReward);self.myEmptyReward=nil;
_UIObject_release(self.myNumTx);self.myNumTx=nil;
_UIObject_release(self.myRankTx);self.myRankTx=nil;
_UIObject_release(self.myRewardList);self.myRewardList=nil;
_UIObject_release(self.myRewardView);self.myRewardView=nil;
_UIObject_release(self.picture);self.picture=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.serverPlayerTx);self.serverPlayerTx=nil;
_UIObject_release(self.serverTotalTx);self.serverTotalTx=nil;
_UIObject_release(self.serverXMTx);self.serverXMTx=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
end















local _this=nil
local _itemCmp={
titleTx=0,
image=1,
rewardView=2,
rewardList=3,
myTotalTx=4,
myRankTx=5,
contentTx=6,
contentCheck=7,
summaryTx=8,
}
local _abName="ui/windows/xianjie/mojierecord_atlas_pak.ab"



function UIMoJieRecordWin:onLoaded(...)
self:bindComponents()
_this=self
self.index=1
self:addProNotify(35,149,self.on_35_149)
end


function UIMoJieRecordWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieRecordWin:onShow(argtable,afterOnloaded)
self:refreshView()
end


function UIMoJieRecordWin:onHide()

end




function UIMoJieRecordWin:onCloseBtn()
self:closeSelf()
end

function UIMoJieRecordWin:onLeftBtn()
if self.index>1 then
self.index=self.index-1
self:refreshViewEx()
end
end

function UIMoJieRecordWin:onRightBtn()
if self.index<#self.datas then
self.index=self.index+1
self:refreshViewEx()
end
end

function UIMoJieRecordWin:refreshView()
local records=xianjieModel:getMoJieAllRecordData()
if next(records)==nil then
self:onCloseBtn()
return
end
self.datas={}
if records then
for i,v in pairs(records)do
table.insert(self.datas,i)
end
if#self.datas>1 then
table.sort(self.datas)
end
end
self.index=Mathf.Clamp(self.index,1,#self.datas)
self:refreshViewEx()
end

function UIMoJieRecordWin:refreshViewEx()
self.leftBtn:setActive(self.index>1)
self.rightBtn:setActive(self.index<(#self.datas))

local type=self.datas[self.index]
local cfg=cfgHelper.get1(cfg_devildomrecordconfig_get,type)
local data=xianjieModel:getMoJieRecordData(type)

self.picture:setSprite(_abName,cfg.image)
self.titleImg:setSprite(_abName,cfg.title)
local serverPlayerStr=FMT.fmt(cfg.playerStr,data.actornum,data.actorname)
self.serverPlayerTx:setText(serverPlayerStr)
local serverTotalStr=FMT.fmt(cfg.serverStr,data.recordnum)
self.serverTotalTx:setText(serverTotalStr)
local serverXMStr=FMT.fmt(cfg.xmStr,data.guildnum,data.guildname)
self.serverXMTx:setText(serverXMStr)
local myRankStr=FMT.fmt(cfg.myRankStr,data.rank>0 and data.rank or"未上榜")
self.myRankTx:setText(myRankStr)
local myNumStr=FMT.fmt(cfg.myNumStr,data.numEx)
self.myNumTx:setText(myNumStr)

local rewardDatas=xianjieModel:getMoJieRecordReward(type)or defaultT
local participated=data.numEx>0
local rewardsLen=#rewardDatas
self.myRewardView:setActive(participated)
self.myEmptyReward:setActive(not participated)
if participated then
self.myRewardList:setChildLayoutGroupCreateItems(rewardsLen,function(index)
local item=self.myRewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardDatas[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local showCountBG=rewardNum>1
local countStr=showCountBG and mathHelper.formatNumber(rewardNum)or""
local rewardConf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local rewardProp=itemsComponentHelper.getCommonFillDataSmall(rewardConf)
item:SetChildPropData(0,rewardProp)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)
self.myRewardView:setChildScrollRectEnable(rewardsLen>=3)
end
end

function UIMoJieRecordWin.on_35_149()
_this:refreshView()
end