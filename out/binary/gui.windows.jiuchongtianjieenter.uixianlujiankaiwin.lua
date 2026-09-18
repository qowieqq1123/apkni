







def_class("UIXianLuJianKaiWin",UIWindowBase)









function UIXianLuJianKaiWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.help=UIButton.get(self,1)
self.leftRoot=UIObject.get(self,2)
self.num=UIText.get(self,3)
self.scrollview=UIObject.get(self,4)
self.topPlayerInfo=UIObject.get(self,5)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXianLuJianKaiWin")end)

self.help:setButtonClick(function()self:onHelp()end)



end


function UIXianLuJianKaiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.topPlayerInfo);self.topPlayerInfo=nil;
end
















local _this

local CmpWidgetIndex={
model=0,
name=1,
server=2,
iconHead=3,
headBg=4,
}




function UIXianLuJianKaiWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
end


function UIXianLuJianKaiWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianLuJianKaiWin:onShow(argtable,afterOnloaded)
rankListController:req_rankList_data(eRankListType.eDuJieFeiSheng)
self:refreshChengXianRank()

local buffList=JiuChongTianJieEnterModel:getBuffList()
local num=JiuChongTianJieEnterModel:getOpenTianJiePeople()
self.num:setText(FMT.fmt("渡劫仙宗:{0}",num))
local posdata={{-50,-10},{5,-210},{705,190},{760,-30},{710,-255},{770,-150}}
local buffNum=#buffList

self.scrollview:setChildLayoutGroupCreateItems(buffNum)
local grids=self.scrollview:getChildLayoutGroupGridList()
local offsetX={0,15,0,15,5}
for i=1,grids.Count do
local isRight=i>2
local grid=grids[i-1]
local buffData=buffList[i]
grid:SetChildActive(0,not isRight)
grid:SetChildActive(3,isRight)
local pos=posdata[i]
if isRight then

grid:SetChildLocalPos(3,pos[1],pos[2],0)
grid:SetChildText(4,buffData[1])
grid:SetChildText(5,buffData[2])
else

grid:SetChildLocalPos(0,pos[1],pos[2],0)
grid:SetChildText(1,buffData[1])
grid:SetChildText(2,buffData[2])
end
end
end


function UIXianLuJianKaiWin:onHide()

end

function UIXianLuJianKaiWin.onRankListRefresh(rankType)
if _this then
if rankType==eRankListType.eDuJieFeiSheng then
_this:refreshChengXianRank()
end
end
end

function UIXianLuJianKaiWin:refreshChengXianRank()

local data=rankListModel:getRankList(eRankListType.eDuJieFeiSheng)
if data and data[1]then
self.topPlayerInfo:setActive(true)
local serverId=data[1].serverId
local actorId=data[1].actorId
local name=data[1].name
local iconInfo=data[1].iconInfo

local widget=self.topPlayerInfo:getWidgetBase()

playerController:setHeadIcon(widget,CmpWidgetIndex.iconHead,{scale=0.8,iconInfo=iconInfo})

local serverName=loginModel:getServerName(serverId)
serverName=FMT.fmt("[{0}]",serverName)
widget:SetChildText(CmpWidgetIndex.server,serverName)
widget:SetChildText(CmpWidgetIndex.name,playerModel:getOtherActorName(name))


widget:SetChildButtonClick(CmpWidgetIndex.headBg,function()
local attach={
serverid=serverId,
}
otherPlayerController:openOtherPlayerInfoWin(actorId,true,nil,attach)
end)
else
self.topPlayerInfo:setActive(false)
end
end

function UIXianLuJianKaiWin:onHelp()
local d={}
d.mode=3
d.title="规则介绍"
d.name='UIXianLuJianKaiWin_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end


