







def_class("UIXianGuanJingXuanResultWin",UIWindowBase)









function UIXianGuanJingXuanResultWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.mbg=UIObject.get(self,2)
self.root=UIObject.get(self,3)
self.scrollView=UIEnhancedScrollerLua.get(self,4)
self.title=UIObject.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianGuanJingXuanResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.title);self.title=nil;
end















local _this=nil
local _unitCmp={
widget=-1,
serverName=0,
playerName=1,
jobIcon=2,
jobName=3,
playerRoot=4,
}
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UIXianGuanJingXuanResultWin:onLoaded(...)
self:bindComponents()
_this=self

self.enhancedscrollscript=UIPrepareEnScroller(self.scrollView:getGameObject(),self.scrollView:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self
end


function UIXianGuanJingXuanResultWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianGuanJingXuanResultWin:onShow(argtable,afterOnloaded)
self:updateData()
self:refreshView()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6037,1,nil,eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end


function UIXianGuanJingXuanResultWin:onHide()

end




function UIXianGuanJingXuanResultWin:onBackground()
self:onCloseBtn()
end


function UIXianGuanJingXuanResultWin:onCloseBtn()
self:closeSelf()
end

function UIXianGuanJingXuanResultWin:updateData()
local types=xianguanModel:getMsgJingXuanResultType()
self.world="仙官文选武选今日出榜，位列仙班者特此提名！"
self.datas={}
local typeWorld,typeWorldTemp
for campaignType,temp in pairs(types)do
local cfgs=xianguanConfig.getCampaignJobListConfig(campaignType)
for i,v in ipairs(cfgs)do
local jobId=v.id
local groupId=xianguanModel:getGroupIdByJob(jobId)
local jobInfo=xianguanModel:getGroupJobInfo(groupId,jobId)
if mathHelper.validInt64(jobInfo.actorid)then
table.insert(self.datas,jobId)
end
end




xianguanController:recordJingXuanResultRefreshTime(campaignType)
end

if typeWorld~=nil then
self.world=FMT.fmt("仙官{0}今日出榜，位列仙班者特此提名！",typeWorld)
end

table.sort(self.datas)
xianguanModel:clearMsgJingXuanResultType()
end

function UIXianGuanJingXuanResultWin:refreshView()
local cnt=#self.datas
self.enhancedscrollscript:initData(self.datas,70,math.ceil(cnt/2))
end

function UIXianGuanJingXuanResultWin:refresItem(index,cell)
for i=1,2 do
local idx=(index-1)*2+i
local jobId=self.datas[idx]
local widget=cell:GetChildWidgetBase(i-1)
widget:SetChildActive(_unitCmp.widget,jobId~=nil)
if jobId then
local groupId=xianguanModel:getGroupIdByJob(jobId)
local jobInfo=xianguanModel:getGroupJobInfo(groupId,jobId)
local jobCfg=cfgHelper.get(cfg_xianguanconfig_get,jobId)
local serverName=loginModel:getServerName(jobInfo.serverid)
widget:SetChildText(_unitCmp.serverName,serverName or"")
widget:SetChildText(_unitCmp.playerName,FMT.fmt("[{0}]",jobInfo.actorname or""))
widget:SetChildCSImageSprite(_unitCmp.jobIcon,globalABLookup.xianguan,xianguanConfig.getJobIconName(jobCfg.jobIcon))
local stageColors={"#6833c0","#ca631d","#ca631d","#c82c2c"}
widget:SetChildText(_unitCmp.jobName,FMT.fmt("<color={1}>[{0}]</color>",jobCfg.name,stageColors[jobCfg.stage]))
widget:ForceLayoutRect(_unitCmp.playerRoot)
end
end
end

function UIPrepareEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIPrepareEnScroller:RefreshCell(dataIndex,cellIndex,cell)
if self.window and self.window.isClose then
return
end
self.window:refresItem(dataIndex,cell)
end