







def_class("UISystemZongMenFightRecordWin",UIWindowBase)









function UISystemZongMenFightRecordWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.clearBtn=UIButton.get(self,2)
self.list=UIObject.get(self,3)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.clearBtn:setButtonClick(function()self:onClearBtn()end)



end


function UISystemZongMenFightRecordWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.clearBtn);self.clearBtn=nil;
_UIObject_release(self.list);self.list=nil;
end















local _this=nil
local _itemCmp={
icon=0,
reportBtn=1,
timeTx=2,
resultImg=3,
contentTx=4,
newFlag=5,
stongWayTips=6,
stongWayList=7,
checkTx=8,
addList=9,
minusList=10,
}
local _resultImage={
[fightResultType.Victory]="image_pqjsshengbai_1",
[fightResultType.Lose]="image_pqjsshengbai_2",
}
local _saveDay=7
local _swItemKid={
button=0,
icon=1,
name=2,
}
local _abName="ui/windows/world/pqjs_new_atlas_pak.ab"



function UISystemZongMenFightRecordWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSystemZMFightRecordNew,self.onSystemZMFightRecordNew)

self.battleId=nil
self.jumpData=strengthenController:getStrengthenJumpList(strengthenFunctionType.eFightLose,true)
end


function UISystemZongMenFightRecordWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenFightRecordWin:onShow(argtable,afterOnloaded)
self:refreshView()
end


function UISystemZongMenFightRecordWin:onHide()

end





function UISystemZongMenFightRecordWin:onBackground()
self:onCloseBtn()
end



function UISystemZongMenFightRecordWin:onCloseBtn()
systemZongMenModel:clearValidReportNewFlag()

shanMenDaZhenController:refreshDaZhenRecordReddot()
self:closeSelf()
end



function UISystemZongMenFightRecordWin:onClearBtn()
systemZongMenModel:clearValidFightReport()
self:refreshView()
end

function UISystemZongMenFightRecordWin.onClickJump(index)
local jumpCfg=_this.jumpData[index]
strengthenController:doJump(jumpCfg.jumpType)
end

function UISystemZongMenFightRecordWin:refreshView()
self.recordList=systemZongMenModel:getValidFightReport()
self.list:setChildLayoutGroupCreateItems(#self.recordList,function(index)
local item=self.list:getChildLayoutGroupGridItem(index-1)
local record=self.recordList[index]
local type=record.teamIndex
local result=record.result
local reports=record.report
local gameStamp=record.gameStamp
local timeStamp=record.timeStamp
local zmName=record.name
local newFlag=record.newFlag
local items=record.items or{}

local iconName="image_pqjsshengbai_2"

local contentLang="systemZongMen_FightRecord_War_Defeat"

local showItem=0
if type>0 then
iconName=result==fightResultType.Victory and"image_pqjsshengbai_1"or"image_pqjsshengbai_2"
contentLang=result==fightResultType.Victory and"systemZongMen_FightRecord_Attack_Victory"or"systemZongMen_FightRecord_Attack_Defeat"
elseif type==0 then
iconName=result~=fightResultType.Victory and"image_pqjsshengbai_1"or"image_pqjsshengbai_2"
contentLang=result==fightResultType.Victory and"systemZongMen_FightRecord_Defense_Victory"or"systemZongMen_FightRecord_Defense_Defeat"
showItem=result==1 and-1 or 1
end
item:SetChildCSImageSprite(_itemCmp.icon,globalABLookup.global,iconName)

local timeStr=timeHelper.dateServerStamp(pfwindowslController:getDateFormatForVersion(true),timeHelper.convertLongStamp(timeStamp))
item:SetChildText(_itemCmp.timeTx,timeStr)

iconName=type==0 and"icon_typaiqianzjui_5"or"icon_typaiqianzjui_4"
item:SetChildCSImageSprite(_itemCmp.resultImg,_abName,iconName)

local gameYear=gameUtilityModel.getGameYearPass((gameStamp and gameStamp>0)and gameStamp or timeStamp)
local contentStr=FMT.fmt(cfgHelper.getlang(contentLang),gameYear,zmName)
contentStr=comHelper.getCheckLayoutStr(item:GetChildGameObject(_itemCmp.checkTx),692,contentStr,true)
item:SetChildText(_itemCmp.contentTx,contentStr)

item:SetChildActive(_itemCmp.newFlag,newFlag)

item:SetChildActive(_itemCmp.reportBtn,reports~=nil)
item:SetChildButtonClick(_itemCmp.reportBtn,function()
local replayType=type>0 and eRePlayerType.systemZongMenAttack or eRePlayerType.systemZongMenDefense
systemZongMenController:playFightRecord(reports,replayType)
end)

item:SetChildActive(_itemCmp.addList,showItem>0)
item:SetChildActive(_itemCmp.minusList,showItem<0)
if showItem>0 then
item:SetChildLayoutGroupCreateItems(_itemCmp.addList,#items,function(index)
local listItem=item:GetChildLayoutGroupGridItem(_itemCmp.addList,index-1)
local itemData=items[index]
local itemId=itemData[1]
local itemNum=itemData[2]
local showCountBG=itemNum>1
local numStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local conf={itemid=itemId,itemcount=numStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
listItem:SetChildPropData(-1,prop)
listItem:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
elseif showItem<0 then
item:SetChildLayoutGroupCreateItems(_itemCmp.minusList,#items,function(index)
local listItem=item:GetChildLayoutGroupGridItem(_itemCmp.minusList,index-1)
local itemData=items[index]
local itemId=itemData[1]
local itemNum=itemData[2]
local numStr=mathHelper.formatNumber(math.abs(itemNum))
listItem:SetChildCSImageIcon(0,iconHelper.getIconName(itemId),false)
listItem:SetChildText(1,FMT.fmt("-{0}",numStr,true))
end)
end
end)
end

function UISystemZongMenFightRecordWin.onSystemZMFightRecordNew()
_this:refreshView()
end