







def_class("UIRankListHunDunBeiWin",UIWindowBase)









function UIRankListHunDunBeiWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.leftList=UIObject.get(self,2)
self.rightList=UIScrollView.get(self,3)
self.player=UIObject.get(self,4)
self.talk=UIObject.get(self,5)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,6)
self.title_1=UIText.get(self,7)
self.title_2=UIText.get(self,8)
self.title_3=UIText.get(self,9)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.title={
self.title_1,
self.title_2,
self.title_3,
}



end


function UIRankListHunDunBeiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.leftList);self.leftList=nil;
_UIObject_release(self.rightList);self.rightList=nil;
_UIObject_release(self.player);self.player=nil;
_UIObject_release(self.talk);self.talk=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.title_1);self.title_1=nil;
_UIObject_release(self.title_2);self.title_2=nil;
_UIObject_release(self.title_3);self.title_3=nil;
self.title=nil;
end
















local _this=nil
local typeList={eRankListType.eZongMenFight,eRankListType.eDouFaTai,eRankListType.eShiLianTa}
local iconFunc={
[eRankListType.eDouFaTai]=function()
return douFaTaiModel:getWenDaoIconName()
end,
}
local titleStr={
[eRankListType.eZongMenFight]={"排名","玩家","最强五人"},
[eRankListType.eDouFaTai]={"排名","玩家","问道值"},
[eRankListType.eShiLianTa]={"排名","玩家","通关层数"},
[eRankListType.eYinJieKaiTian]={"排名","玩家","完成谪仙令时间"},
[eRankListType.eDuJieFeiSheng]={"排名","玩家","渡劫进度"},
}
local playerCmp={
rankframe=0,
rankNo=1,
rankIcon=2,
rankNum=3,
head=4,


levelTx=6,
playerName=7,
zmName=8,
progress=9,
rankIcon_big=10,
}
local leftCmp={
owner=-1,
select=0,
name=1,
}
local rightCmp={
leftframe=0,
rightframe=1,
rankframe=2,
rankNo=3,
rankIcon=4,
rankNum=5,
head=6,


levelTx=8,
playerName=9,
zmName=10,
headEmpty=11,
headBg=12,
selfRoot=13,
levelBg=14,
progress=15,
rankIcon_big=16,
}
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UIRankListHunDunBeiWin:onLoaded(...)
self:bindComponents()
_this=self
self.typeList=table.deepCopy(typeList)
if JiuChongTianJieEnterModel:getState()==eJiuChongTianJieStateType.eDoing then
table.insert(self.typeList,eRankListType.eYinJieKaiTian)
end
if JiuChongTianJieEnterModel:isJiuChongTianJieComplete()then
table.insert(self.typeList,eRankListType.eDuJieFeiSheng)
end

self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

self.playerWidget=self.player:getChildWidgetBase()








notifySystem:listenNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
self:refreshLeft()
self:onClickLeft(1)
end


function UIRankListHunDunBeiWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onRankListRefresh,self.onRankListRefresh)
end




function UIRankListHunDunBeiWin:onShow(argtable,afterOnloaded)
self.root:setActive(true)
self.enhancedscrollscript:jumpToDataIndex(0,0,0,true,0,0,nil)
end


function UIRankListHunDunBeiWin:onHide()
self.root:setActive(false)
end




function UIRankListHunDunBeiWin:onCloseBtn()
UIFullZaoHuaTianBeiControl:closeHunDunBei()
end

function UIRankListHunDunBeiWin:refreshTitle()
local sRankType=self.typeList[self.selected]
local titleList=titleStr[sRankType]
for i,v in ipairs(self.title)do
v:setText(titleList[i])
end
end

function UIRankListHunDunBeiWin:refreshLeft()
self.leftList:setChildLayoutGroupCreateItems(#self.typeList,function(idx)
local leftItem=self.leftList:getChildLayoutGroupGridItem(idx-1)
local sRankType=self.typeList[idx]
local typeCfg=cfgHelper.get1(cfg_ranktypeconfig_get,sRankType)

leftItem:SetChildActive(leftCmp.select,self.selected==idx)
leftItem:SetChildText(leftCmp.name,typeCfg.title)
leftItem:SetChildButtonClickWithID(leftCmp.owner,function(index)
self:onClickLeft(index)
end,idx)
end)
end

function UIRankListHunDunBeiWin:refreshRight()
local sRankType=self.typeList[self.selected]
self.rankList=rankListModel:getRankList(sRankType)
local showNum=#self.rankList

self.enhancedscrollscript:initData(self.rankList,94,showNum)




















































end



























































function UIRankListHunDunBeiWin:refreshPlayer()
local sRankType=self.typeList[self.selected]
local playerInfo=rankListModel:getPlayerInfo(sRankType)

playerController:setHeadIcon(self.playerWidget,playerCmp.head,{iconInfo=playerInfo.head})








self.playerWidget:SetChildText(playerCmp.levelTx,playerInfo.zmLevel)
self.playerWidget:SetChildText(playerCmp.playerName,playerInfo.playerName)
self.playerWidget:SetChildText(playerCmp.zmName,playerInfo.zmName)









local numStr=rankListModel.getNumberStr(playerInfo.number)
self.playerWidget:SetChildText(playerCmp.rankNo,numStr)

local iconCB=iconFunc[sRankType]
self.playerWidget:SetChildActive(playerCmp.rankIcon,iconCB~=nil)
if iconCB then
self.playerWidget:SetChildIcon(playerCmp.rankIcon,"",false)
local iconName=iconCB()or""
self.playerWidget:SetChildIcon(playerCmp.rankIcon,iconName,false)
end


local showPercent=playerInfo.percent~=nil

self.playerWidget:SetChildActive(playerCmp.rankNum,not showPercent)
self.playerWidget:SetChildActive(playerCmp.progress,showPercent)
if playerInfo.percent then
self.playerWidget:SetChildProgress(playerCmp.progress,playerInfo.percent,100)
self.playerWidget:SetChildProgressText(playerCmp.progress,FMT.fmt("{0}%",math.floor(playerInfo.percent*10)/10))
self.playerWidget:SetChildActive(playerCmp.rankIcon_big,sRankType==eRankListType.eDuJieFeiSheng and playerInfo.percent==100)
if sRankType==eRankListType.eDuJieFeiSheng and playerInfo.percent==100 then
self.playerWidget:SetChildActive(playerCmp.progress,false)
self.playerWidget:SetChildCSImageSprite(playerCmp.rankIcon_big,"ui/windows/jiuchongtianjieenter/enter_atlas_pak.ab","image_jiuchongtianjie_wz9")
end
else
self.playerWidget:SetChildText(playerCmp.rankNum,playerInfo.data)
self.playerWidget:SetChildActive(playerCmp.rankIcon_big,false)
end
end

function UIRankListHunDunBeiWin:onClickLeft(index)
if self.selected~=index then
if self.selected then
local leftItem=self.leftList:getChildLayoutGroupGridItem(self.selected-1)
leftItem:SetChildActive(leftCmp.select,false)
end
self.selected=index
local leftItem=self.leftList:getChildLayoutGroupGridItem(index-1)
leftItem:SetChildActive(leftCmp.select,true)
self:refreshRight()
self:refreshPlayer()
self:refreshTitle()
end
end

function UIRankListHunDunBeiWin:onClickHead(index)
local rankData=self.rankList[index]

if rankData and rankData.actorId then
local sRankType=self.typeList[self.selected]
local attach={
type=otherPlayerController.eAttachType.Rank,
rankType=sRankType
}
otherPlayerController:openOtherPlayerInfoWin(rankData.actorId,true,nil,attach)
end
end

function UIRankListHunDunBeiWin.onRankListRefresh(rankType)
if rankType==_this.typeList[_this.selected]then
_this:refreshRight()
end
end


function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local itemCmp=cell
if self.window and self.window.isClose then
return
end

local sRankType=self.window.typeList[self.window.selected]
local iconCB=iconFunc[sRankType]
local iconName=iconCB and iconCB()or nil
local rankData=self.window.rankList[dataIndex]

local frameName2=rankListModel.getFrameName2(rankData.rankNum)
if frameName2 then
itemCmp:SetChildCSImageSprite(rightCmp.leftframe,globalABLookup.rankList,frameName2)
itemCmp:SetChildCSImageSprite(rightCmp.rightframe,globalABLookup.rankList,frameName2)
else
itemCmp:SetChildIcon(rightCmp.leftframe,"",false)
itemCmp:SetChildIcon(rightCmp.rightframe,"",false)
end

playerController:setHeadIcon(itemCmp,rightCmp.head,{iconInfo=rankData.head or rankData.iconInfo})

itemCmp:SetChildActive(rightCmp.levelBg,rankData.zmLevel~=nil)
itemCmp:SetChildText(rightCmp.levelTx,rankData.zmLevel)
itemCmp:SetChildText(rightCmp.playerName,rankData.playerName)
itemCmp:SetChildText(rightCmp.zmName,rankData.zmName)
itemCmp:SetChildButtonClick(rightCmp.headBg,function()
self.window:onClickHead(dataIndex)
end)




local frameName=rankListModel.getFrameName(rankData.rankNum)
if frameName then
itemCmp:SetChildCSImageSprite(rightCmp.rankframe,globalABLookup.rankList,frameName)
else
itemCmp:SetChildIcon(rightCmp.rankframe,"",false)
end
local numStr=rankListModel.getNumberStr(rankData.rankNum)
itemCmp:SetChildText(rightCmp.rankNo,numStr)

itemCmp:SetChildActive(rightCmp.rankIcon,iconName~=nil)
if iconName then
itemCmp:SetChildIcon(rightCmp.rankIcon,"",false)
itemCmp:SetChildIcon(rightCmp.rankIcon,iconName,false)
end
local showPercent=rankData.percent~=nil
itemCmp:SetChildActive(rightCmp.rankNum,not showPercent)
itemCmp:SetChildActive(rightCmp.progress,showPercent)
if rankData.percent then
itemCmp:SetChildProgress(rightCmp.progress,rankData.percent,100)
itemCmp:SetChildProgressText(rightCmp.progress,FMT.fmt("{0}%",math.floor(rankData.percent*10)/10))
itemCmp:SetChildActive(rightCmp.rankIcon_big,sRankType==eRankListType.eDuJieFeiSheng and rankData.percent==100)
if sRankType==eRankListType.eDuJieFeiSheng and rankData.percent==100 then
itemCmp:SetChildActive(rightCmp.progress,false)

itemCmp:SetChildCSImageSprite(rightCmp.rankIcon_big,"ui/windows/jiuchongtianjieenter/enter_atlas_pak.ab","image_jiuchongtianjie_wz9")
end
else
itemCmp:SetChildText(rightCmp.rankNum,tostring(rankData.data[1]))
itemCmp:SetChildActive(rightCmp.rankIcon_big,false)
end

end

function UIPrepareEnScroller:onItemClick(eventName,clickCount,index,cell)
self.window:onClickHead(index+1)
end