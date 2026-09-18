







def_class("UIRankListDiscipleWin",UIWindowBase)









function UIRankListDiscipleWin:bindComponents()

self.scrollView=UILoopListView.new(self,0)

self.scrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIRankListDiscipleWin:unbindComponents()
local _UIObject_release=UIObject.release
self.scrollView:deleteSelf();self.scrollView=nil;
end















local _this=nil
local _discipleCmp={
model=0,
discipleName=1,
nameTx=2,
serverTx=3,
headBG=4,
head=5,
infoTx=6,
jobImage=7,
infoBg=8,
empty=9,
tips=10,
}



function UIRankListDiscipleWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
end


function UIRankListDiscipleWin:__delete()
self:unbindComponents()
_this=nil
end




function UIRankListDiscipleWin:onShow(argtable,afterOnloaded)
self.rank=argtable.rank
self.args=argtable.args
self.rankList={}
self:refreshView()
end


function UIRankListDiscipleWin:onHide()

end



function UIRankListDiscipleWin:refreshView()
local createList={}
for i,v in ipairs(self.rank)do
table.insert(createList,i)
end
self.scrollView:initData("discipleItem",createList)
end

function UIRankListDiscipleWin:onClickPlayer(index)
local rankType=self.rank[index]
local rankList=self.rankList[rankType]
if rankList then
local rankData=rankList[1]
if rankData and rankData.actorId then
local attach={serverid=rankData.server}
attach.isXianJie=self.server==3
otherPlayerController:openOtherPlayerInfoWin(rankData.actorId,nil,nil,attach)
end
end
end

function UIRankListDiscipleWin:onClickDisciple(index)
local rankType=self.rank[index]
local rankList=self.rankList[rankType]
if rankList then
local rankData=rankList[1]
if rankData and rankData.actorId and rankData.discipleguid then
local attach={serverid=rankData.server}
attach.isXianJie=self.server==3
otherPlayerController:openOtherPlayerDZInfoWin(rankData.actorId,rankData.discipleguid,true,nil,attach,{rankData.discipleguid})
end
end
end

function UIRankListDiscipleWin:onFreshAction(index,widget,data)
local rankType=self.rank[index]
self.rankList[rankType]=rankListModel:getRankList(rankType)
local rankData=self.rankList[rankType][1]
widget:SetChildActive(_discipleCmp.headBG,rankData~=nil)
widget:SetChildActive(_discipleCmp.nameTx,rankData~=nil)
widget:SetChildActive(_discipleCmp.serverTx,rankData~=nil)
widget:SetChildActive(_discipleCmp.infoTx,rankData~=nil)
widget:SetChildActive(_discipleCmp.empty,rankData==nil)
widget:SetChildCSImageSprite(_discipleCmp.jobImage,globalABLookup.rankList,self.args.jobImage[index])
if rankData and rankData.actorId and rankData.discipleguid then
local args={
clothingId=rankData.discipledress,
}
local weaponID=rankData.discipleweapon
if weaponID>0 then
local equipCfg=itemsConfig.getConfig(weaponID)
if equipCfg~=nil then
weaponID=equipCfg.imageID
else
weaponID=0
end
end
local image,outSideImage=UIDiscipleModel.getDiscipleFightModelInfo(rankData.discipledata,rankData.discipleimage,weaponID,1.0,args)
widget:SetChildUIModelShowTarget(_discipleCmp.model,outSideImage.body,1.1,outSideImage.componets,eAnimationID.stand,false,true,0)



widget:SetChildText(_discipleCmp.discipleName,rankData.disciplename or"")

playerController:setHeadIcon(widget,_discipleCmp.head,{iconInfo=rankData.head})
widget:SetChildText(_discipleCmp.nameTx,rankData.playerName)
local serverName=loginModel:getServerName(rankData.server)
widget:SetChildText(_discipleCmp.serverTx,FMT.fmt("[{0}]",serverName))
widget:SetChildButtonClick(_discipleCmp.headBG,function()
self:onClickPlayer(index)
end)
widget:SetChildButtonClick(_discipleCmp.infoBg,function()
self:onClickPlayer(index)
end)
widget:SetChildButtonClick(_discipleCmp.model,function()
self:onClickDisciple(index)
end)
local value=type(rankData.data[1])=="number"and rankData.data[1]or mathHelper.int64_to_number(rankData.data[1])
local infoStr=FMT.fmt(self.args.infoStr,mathHelper.formatNumber(value))
widget:SetChildText(_discipleCmp.infoTx,infoStr)
else
widget:SetChildUIModelRemoveTarget(_discipleCmp.model)
widget:SetChildText(_discipleCmp.discipleName,"")
local limit=cfgHelper.get4(cfg_rankbasicconfig_get,1,"rankLimit",rankType,1)
widget:SetChildText(_discipleCmp.tips,FMT.fmt("弟子实力达到<color=#EFB150>{0}</color>上榜",mathHelper.formatNumber(limit)))
end
end

function UIRankListDiscipleWin:onStartAction()

end

function UIRankListDiscipleWin.onRankListRefresh(rankType)
local index=table.findValue(_this.rank,rankType)
if index then
local widget=self.scrollView:getListViewItemWidgetByDataIndex(index)
self:onFreshAction(index,widget)
end
end