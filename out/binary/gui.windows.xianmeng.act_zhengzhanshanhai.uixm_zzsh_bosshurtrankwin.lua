







def_class("UIXM_ZZSH_BossHurtRankWin",UIWindowBase)









function UIXM_ZZSH_BossHurtRankWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.selfRoot=UIObject.get(self,1)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXM_ZZSH_BossHurtRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.selfRoot);self.selfRoot=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
end















local _this=nil
local _rankCmp={
rankImg=0,
rankTx=1,
serverName=2,
xmName=3,
progressBar=4,
hurtTx=5,
numTx=6,
haveTips=7,
item=8,
noneTips=9,
tempRoot=10,
}
local UIPrepareEnScroller=simple_class(UIEnhancedScroller)



function UIXM_ZZSH_BossHurtRankWin:onLoaded(...)
self:bindComponents()
_this=self

self.enhancedscrollscript=UIPrepareEnScroller(self.ScrollerScript:getGameObject(),self.ScrollerScript:getCSharpObject(),nil,nil)
self.enhancedscrollscript.window=self

self.selfRootWidget=self.selfRoot:getChildWidgetBase()
end


function UIXM_ZZSH_BossHurtRankWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXM_ZZSH_BossHurtRankWin:onShow(argtable,afterOnloaded)
self.qbGuid=argtable.qbGuid
self.qbData=zhengzhanshanhaiModel:getQingBaoData(self.qbGuid)
self.detail=self.qbData:getDetail()
self.rankList=self.detail.ranklist or{}
self.config=self.qbData:getCfg()
self:refreshList()
self:refreshSelf()
end


function UIXM_ZZSH_BossHurtRankWin:onHide()

end





function UIXM_ZZSH_BossHurtRankWin:onCloseBtn()
self:closeSelf()
end

function UIXM_ZZSH_BossHurtRankWin:refreshList()
local rank=self.config.rank
local len=rank[#rank][1]
self.enhancedscrollscript:initData(self.rankList,100,len)
end

function UIXM_ZZSH_BossHurtRankWin:refreshSelf()
local data,rank
if xianmengModel:hasXM()then
for i,v in ipairs(self.rankList)do
if xianmengModel:isMyXM(v.guildid)then
data=v
rank=i
break
end
end
if not data then
local xmDetialData=xianmengModel:getXMDetialData()
data={}
data.guildid=xianmengModel:myXMGuildID()
data.guildname=xianmengModel:getXMName()
data.serverid=xmDetialData.leaderserverid
data.damage=0
data.percent=0
data.mass=0
end
end
self:setItem(self.selfRootWidget,rank,data,true)
end

function UIXM_ZZSH_BossHurtRankWin:setItem(item,rank,data,isSelf)








local mass=data and data.mass or 0
local serverName=data and loginModel:getServerName(data.serverid)or""
local xmName=data and data.guildname or""
local damage=data and tonumber(tostring(data.damage))or 0
local hurtStr=data and FMT.fmt("伤害：{0}",mathHelper.formatNumber(tonumber(tostring(data.damage))))or
"伤害：0"
local hurtPercent=data and data.percent or 0
local hurtPercent100=hurtPercent/100
if damage>0 and hurtPercent100<=0 then
hurtPercent100=0.01
end
local hurtPercentStr=FMT.fmt("{0}%",hurtPercent100)
local numStr=data and data.mass or 0
local reward
local rankCfg=self.config.rank or{}
if rank then
for i=1,#rankCfg do
local v=rankCfg[i]
if rank<=v[1]then
reward=v[2]
break
end
end







end
local haveReward=reward~=nil
if rank and rank<4 then
local imgName=FMT.fmt('icon_phbmingci_{0}',rank)
item:SetChildActive(_rankCmp.rankImg,true)
item:SetChildCSImageSprite(_rankCmp.rankImg,globalABLookup.global,imgName)
item:SetChildText(_rankCmp.rankTx,FMT.cfmt(FONT_COLOR.eNomalBlackColor,rank))
else
item:SetChildActive(_rankCmp.rankImg,false)
item:SetChildIcon(_rankCmp.rankImg,"",false)
item:SetChildText(_rankCmp.rankTx,isSelf and rank==nil and"未上榜"or rank)
end
item:SetChildText(_rankCmp.serverName,serverName)
item:SetChildText(_rankCmp.xmName,xmName)
item:SetChildText(_rankCmp.hurtTx,hurtStr)


item:SetChildText(_rankCmp.numTx,numStr)
item:SetChildActive(_rankCmp.haveTips,false)
item:SetChildActive(_rankCmp.item,haveReward)
item:SetChildActive(_rankCmp.noneTips,not haveReward)
item:SetChildActive(_rankCmp.tempRoot,data==nil)
if haveReward then
local len=#reward
item:SetChildLayoutGroupCreateItems(8,len,function(index)
local info=reward[index]
local widget=item:GetChildLayoutGroupGridItem(8,index-1)
widgetHelper.setNormalRewardItem(widget,0,info)
end)
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
local data=self.window.rankList[dataIndex]
self.window:setItem(cell,dataIndex,data)
end

function UIPrepareEnScroller:onItemClick(eventName,clickCount,index,cell)

end

