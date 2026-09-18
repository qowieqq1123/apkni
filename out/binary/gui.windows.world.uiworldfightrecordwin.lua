







def_class("UIWorldFightRecordWin",UIWindowBase)









function UIWorldFightRecordWin:bindComponents()

self.RecordList=UIScrollView.get(self,0)
self.DeleteBtn=UIButton.get(self,1)
self.CloseBtn=UIButton.get(self,2)
self.Background=UIButton.get(self,3)
self.None=UIObject.get(self,4)

self.DeleteBtn:setButtonClick(function()self:onDeleteBtn()end)

self.CloseBtn:setButtonClick(function()self:onCloseBtn()end)

self.Background:setButtonClick(function()self:onBackground()end)



end


function UIWorldFightRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.RecordList);self.RecordList=nil;
_UIObject_release(self.DeleteBtn);self.DeleteBtn=nil;
_UIObject_release(self.CloseBtn);self.CloseBtn=nil;
_UIObject_release(self.Background);self.Background=nil;
_UIObject_release(self.None);self.None=nil;
end
















local itemKid={
VictoryImg=0,
LoseImg=1,
ContentTx=2,
RewardList=3,
ReportBtn=4,
ReportTime=5,
TipsTx=6,
New=7,
StongWayTips=8,
StongWayList=9,
RewardContent=10,
}
local swItemKid={
button=0,
icon=1,
name=2,
}





local _this=nil




function UIWorldFightRecordWin:onLoaded(...)
self:bindComponents()

if webGLHelper:isRunMiniGame()then
cameraControl.setCameraActive(false)
end

_this=self
worldController:stopCameraControl()
end


function UIWorldFightRecordWin:__delete()
self:unbindComponents()

if webGLHelper:isRunMiniGame()then
cameraControl.setCameraActive(true)
end

_this=nil
worldController:resumeCameraControl()
end




function UIWorldFightRecordWin:onShow(argtable,afterOnloaded)
self:updateView()
worldFightRecordModel:clearNew()
end


function UIWorldFightRecordWin:onHide()

end




function UIWorldFightRecordWin:onDeleteBtn()
worldFightRecordModel:clearAvailableRecord()
self.RecordList:freshGridsNum(0,0,1,false)
self.None:setActive(true)
UIManager.info("已清除派遣记事")
end


function UIWorldFightRecordWin:onCloseBtn()
self:doCloseWin()
end

function UIWorldFightRecordWin:onBackground()
self:doCloseWin()
end

function UIWorldFightRecordWin:doCloseWin()
self:closeSelf()
end

function UIWorldFightRecordWin:updateView()
self.jumpData=strengthenController:getStrengthenJumpList(strengthenFunctionType.eFightLose,true)
self.datas=worldFightRecordModel:getAllAvailableRecord()
local cnt=#self.datas
self.None:setActive(cnt<=0)
self.RecordList:freshGridsNum(cnt,cnt,1,false)
for i=1,cnt do
self:updateItem(i)
end
end

function UIWorldFightRecordWin:updateItem(index)
local item=self.RecordList:getGridObjectByindex(index-1)
local data=self.datas[index]
local isVictory=data[1]==fightResultType.Victory
local rewards=data[2]
local rewardCnt=#rewards
item:SetChildActive(itemKid.VictoryImg,isVictory)
item:SetChildActive(itemKid.LoseImg,not isVictory)
item:SetChildActive(itemKid.StongWayTips,not isVictory)
item:SetChildActive(itemKid.TipsTx,rewardCnt>0)
item:SetChildActive(itemKid.New,data[6])
item:SetChildText(itemKid.ContentTx,data[3])
item:SetChildText(itemKid.ReportTime,
timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(tonumber(data[5]))))
item:SetChildButtonClickWithID(itemKid.ReportBtn,self.onClickReport,index)

if rewardCnt>0 then
item:SetChildLayoutGroupCreateItems(itemKid.RewardContent,rewardCnt,function(index)
local rewardItem=item:GetChildLayoutGroupGridItem(itemKid.RewardContent,index-1)
local rewardData=rewards[index]
local itemid=rewardData.itemid
local showCountBG=not itemsConfig.isEquip(itemid)and not itemsConfig.isFabao(itemid)
local countStr=showCountBG and rewardData.itemcount or""





local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

rewardItem:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
rewardItem:SetChildPropData(0,prop)
end)
end













if not isVictory then
item:SetChildLayoutGroupCreateItems(itemKid.StongWayList,#self.jumpData,function(index)
local swItem=item:GetChildLayoutGroupGridItem(itemKid.StongWayList,index-1)
local jumpCfg=self.jumpData[index]
swItem:SetChildText(swItemKid.name,jumpCfg.name)
swItem:SetChildIcon(swItemKid.icon,FMT.fmt('icon_sjtp_{0}',jumpCfg.icon),false)
swItem:SetChildButtonClickWithID(swItemKid.button,self.onClickJump,index,true)
end)
end












end

function UIWorldFightRecordWin.onClickReport(index)
local reportId=_this.datas[index][4]
local reportStr=fightController:readServerReport(reportId)
if not reportStr then
UIManager.error("回放失败，战斗记录已过期或无效")
return
end
local onComplete=function(b)
if worldFightRecordModel.battle==b then
fightController:closeBattle(b)
worldFightRecordModel.battle=nil
end
end
worldFightRecordModel.battle=fightController:startBallte(reportStr,true,onComplete,nil,{hideExitWatch=false,isRePlay=true})
end

function UIWorldFightRecordWin.onClickJump(index)
local jumpCfg=_this.jumpData[index]
strengthenController:doJump(jumpCfg.jumpType)
end