







def_class("UIMoJieRankWin",UIWindowBase)









function UIMoJieRankWin:bindComponents()

self.left=UIObject.get(self,0)
self.right=UIObject.get(self,1)
self.leftBtn=UIButton.get(self,2)
self.rightBtn=UIButton.get(self,3)
self.packScrollerView=UIObject.get(self,4)
self.xianfa=UIObject.get(self,5)
self.zhumo=UIObject.get(self,6)
self.xfroot=UIObject.get(self,7)
self.zmroot=UIObject.get(self,8)
self.closebtn=UIButton.get(self,9)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)



end


function UIMoJieRankWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.left);self.left=nil;
_UIObject_release(self.right);self.right=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.packScrollerView);self.packScrollerView=nil;
_UIObject_release(self.xianfa);self.xianfa=nil;
_UIObject_release(self.zhumo);self.zhumo=nil;
_UIObject_release(self.xfroot);self.xfroot=nil;
_UIObject_release(self.zmroot);self.zmroot=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
end
















local _this
local Ranktype=
{
xianfa=1,
zhumo=2,
}
local xfpageidx=
{
selfitem=0,
root=1,
bg=2,
bgtitle=3,
title=4,
btnone=5,
btnonetxt=6,
btntwo=7,
btntwotxt=8,
txtpanel=9,
rwScrollview=10,
selfwidget=11,
paihangtxt=12,

XFpanel=13,
XSpanel=14,
rwScrollview2=15,
paihangtxt2=16,
selfwidget2=17,

}
local rwitemidx=
{
rwself=0,
rankbg=1,
rank=2,
name=3,
meng=4,
value=5,
value2=6,
scrollview=7,
content=8,
xfaddbtn=9,
xsjdpanel=10,
bg=11,
}
local rewardtype=
{
rank=1,
xfz=2,
zmgx=3
}
local rewardrank=
{
xf=1,
xs=2,
zm=3,
zmxm=4,
}
local _eRankListType=
{
xf=1,
xs=2,
zm=3,
zmxm=4,
}
local bingzhongs=
{
[1]='筑基',
[2]='结丹',
[3]='元婴',
[4]='化神',
[5]='炼虚',
[6]='合体',
[7]='大乘',
[8]='渡劫',
[9]='天仙',
}




function UIMoJieRankWin:onLoaded(...)
self:bindComponents()
_this=self

self.isopenxs=false
self.selectSubIdx=1
self.selectIdx=1
self.isAnimate=false

self.pageCount=0
self.pageLength=1
self.pageIndex=0
self.isDrag=false
self.targetHor=0
self.smooting=10
self.lastslIdx=1




end


function UIMoJieRankWin:__delete()
self:unbindComponents()
_this=nil
end
function UIMoJieRankWin:onClosebtn()
self:closeSelf()
end

function UIMoJieRankWin.beginDragCallback()
_this.isDrag=true
end
function UIMoJieRankWin.endDragCallback()
_this.isDrag=false
local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true)
local index=0
local offset=Mathf.Abs(-posX)
for i=1,_this.pageCount do
local temp=Mathf.Abs(_this.pageLength*i-posX)
if(temp<offset)then
index=i
offset=temp
end
end
_this.pageIndex=index

_this.targetHor=_this.pageLength*_this.pageIndex
_this:checkArrowBtn()

if _this.selectIdx==_this.pageIndex+1 then
return
else
_this.lastslIdx=_this.pageIndex
_this.selectIdx=_this.pageIndex+1
if#_this.showList<_this.selectIdx then
_this.selectIdx=_this.pageIndex
_this.targetHor=_this.pageLength*(_this.pageIndex-1)
end



end
end
function UIMoJieRankWin.onScrollChanged()

if not _this.isDrag then
local np=_this.winlua:GetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true)
_this.winlua:SetChildScrollRectNormalizedPosition(_this.packScrollerView:getID(),true,Mathf.Lerp(np,_this.targetHor,Time.deltaTime*_this.smooting))
if _this.lastslIdx~=_this.selectIdx then
local grids=_this.packScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then





end
end
_this.lastslIdx=_this.selectIdx
end
end
end


function UIMoJieRankWin:checkArrowBtn()
self.left:setActive(self.pageIndex>0)
self.right:setActive(self.pageIndex<self.pageCount-1)
end
function UIMoJieRankWin:onRightBtn()
if self.isAnimate then
return
end
if self.isopenxs then
self:XFAddBtn()
return
end
if self.pageIndex+1<self.pageCount then
self.pageIndex=self.pageIndex+1
self.targetHor=self.pageLength*self.pageIndex
self.selectIdx=self.pageIndex+1
end
self:checkArrowBtn()
self:ChangeBigWin(self.selectIdx)
end
function UIMoJieRankWin:onLeftBtn()
if self.isAnimate then
return
end
if self.isopenxs then
self:XFAddBtn()
return
end
if self.pageIndex-1>=0 then
self.pageIndex=self.pageIndex-1
self.targetHor=self.pageLength*self.pageIndex
self.selectIdx=self.pageIndex+1
end
self:checkArrowBtn()
self:ChangeBigWin(self.selectIdx)
end

function UIMoJieRankWin:changeSubBtn(subid)
if self.isAnimate then
return
end
if self.isopenxs then
self:XFAddBtn()
return
end
if subid==self.selectSubIdx then
return
end
local oldid=subid
self.selectSubIdx=subid



self:reqRankData(self.selectIdx,self.selectSubIdx)
self:switchSubPanle(self.selectIdx,self.selectSubIdx)
end

function UIMoJieRankWin:XFAddBtn()
local widget=self.XFwidget:GetChildWidgetBase(xfpageidx.selfwidget2)
self.isopenxs=not self.isopenxs
if self.isopenxs then
widget:SetChildSizeDelta(rwitemidx.bg,660,140)
widget:SetChildActive(rwitemidx.xsjdpanel,true)
else
widget:SetChildSizeDelta(rwitemidx.bg,660,100)
widget:SetChildActive(rwitemidx.xsjdpanel,false)
end
end





function UIMoJieRankWin:onShow(argtable,afterOnloaded)
local selectid=argtable.id or 1
local selectsubid=argtable.subid or 1
self.pageCount=2
self:initJumpShow(selectid,selectsubid)
self:checkArrowBtn()
end


function UIMoJieRankWin:onHide()

end


function UIMoJieRankWin:refreshPanel()
self.showList={}
self.pageCount=#self.showList
self.pageLength=1/((self.pageCount-1)==1 and 1 or(self.pageCount-1))

self.packScrollerView:setChildScrollViewDelayCreateGrids(2,1,0.02,1,false,false,function(id,widget)
self:refreshItem(id,widget)
end)

end

function UIMoJieRankWin:initJumpShow2(index)
self:refreshPanel()
self.pageIndex=index-1
self.targetHor=self.pageLength*self.pageIndex
self.selectIdx=index
self.lastslIdx=self.selectIdx
self.packScrollerView:setChildScrollViewSelectItem(self.pageIndex,false,false,false)
local grids=self.packScrollerView:getChildScrollViewItemWidgets()
local item=grids[self.selectIdx-1]

self:checkArrowBtn()


end




function UIMoJieRankWin:severmkrankfresh(rankType)
if _this then

if rankType==eRankListType.eXianFaRank then
_this:freshXianFa_ZhuXian()
elseif rankType==eRankListType.eXianSunRank then
_this:freshXianFa_XianSun()
elseif rankType==eRankListType.eZhuMoRank then
_this:freshZhuMo_GeRen()
elseif rankType==eRankListType.eXMZhuMoRank then
_this:freshZhuMo_XianMeng()
end
end
end

function UIMoJieRankWin:ChangeBigWin(selectid)

if selectid==Ranktype.xianfa then
self:initXianFaXianSun()
elseif selectid==Ranktype.zhumo then
self:initZhuMoAll()
end
self:reqRankData(selectid,self.selectSubIdx)
self:switchSubPanle(selectid,self.selectSubIdx)
self:DoAnimate(selectid)
end

function UIMoJieRankWin:DoAnimate(selectid)
if selectid==Ranktype.xianfa then



self.isAnimate=true
self.xfroot:setChildCanvasGroupAlpha(0)
self.zmroot:setChildCanvasGroupDOFade(0,0.6,function()
if _this==nil then return end


self.xianfa:setActive(true)
self.zhumo:setActive(false)
end)
self:delayDo(1.5,function()
if _this==nil then return end
self.xfroot:setChildCanvasGroupDOFade(1,0.6,nil)
self.isAnimate=false
end)
elseif selectid==Ranktype.zhumo then
self.isAnimate=true
self.zmroot:setChildCanvasGroupAlpha(0)
self.xfroot:setChildCanvasGroupDOFade(0,0.6,function()
if _this==nil then return end


self.xianfa:setActive(false)
self.zhumo:setActive(true)
end)
self:delayDo(1.5,function()
if _this==nil then return end
self.zmroot:setChildCanvasGroupDOFade(1,0.6,nil)
self.isAnimate=false
end)
end
end

function UIMoJieRankWin:initJumpShow(selectid,selectsubid)
if selectid==Ranktype.xianfa then
self.selectIdx=1
self.selectSubIdx=selectsubid
self.xianfa:setActive(true)
self.zhumo:setActive(false)
self.zmroot:setChildCanvasGroupAlpha(0)
self.xfroot:setChildCanvasGroupAlpha(0)
self.xfroot:setChildCanvasGroupDOFade(1,0.6,nil)
self:initXianFaXianSun()
elseif selectid==Ranktype.zhumo then
self.selectIdx=2
self.selectSubIdx=selectsubid
self.xianfa:setActive(false)
self.zhumo:setActive(true)
self.zmroot:setChildCanvasGroupAlpha(0)
self.xfroot:setChildCanvasGroupAlpha(0)
self.zmroot:setChildCanvasGroupDOFade(1,0.6,nil)
self:initZhuMoAll()
end
self:switchSubPanle(selectid,selectsubid)
end

function UIMoJieRankWin:reqRankData(selectIdx,selectSubIdx)
if selectIdx==1 then
if selectSubIdx==1 then
if xianjieController:checkmojieRankTime(_eRankListType.xf)then
xianjieController:reqmojieRankData(_eRankListType.xf)
end
else
if xianjieController:checkmojieRankTime(_eRankListType.xs)then
xianjieController:reqmojieRankData(_eRankListType.xs)
end
end
else
if selectSubIdx==1 then
if xianjieController:checkmojieRankTime(_eRankListType.zm)then
xianjieController:reqmojieRankData(_eRankListType.zm)
end
else
if xianjieController:checkmojieRankTime(_eRankListType.zmxm)then
xianjieController:reqmojieRankData(_eRankListType.zmxm)
end
end
end
end

function UIMoJieRankWin:switchSubPanle(selectIdx,selectSubIdx)
if selectIdx==1 then
if selectSubIdx==1 then
self.XFwidget:SetChildActive(xfpageidx.XFpanel,true)
self.XFwidget:SetChildActive(xfpageidx.XSpanel,false)
else
self.XFwidget:SetChildActive(xfpageidx.XFpanel,false)
self.XFwidget:SetChildActive(xfpageidx.XSpanel,true)
end
else
if selectSubIdx==1 then
self.ZMwidget:SetChildActive(xfpageidx.XFpanel,true)
self.ZMwidget:SetChildActive(xfpageidx.XSpanel,false)
else
self.ZMwidget:SetChildActive(xfpageidx.XFpanel,false)
self.ZMwidget:SetChildActive(xfpageidx.XSpanel,true)
end
end
end

function UIMoJieRankWin:getTypeReward(flag)
local cfgrank=self.mojiecfg.rank
return cfgrank[flag]
end

function UIMoJieRankWin:getRewardByRank(cfg,rank)
if cfg then
for k,v in ipairs(cfg)do
if v[3]and v[1]<=rank and rank<=v[2]then
return v[3]
end
end
if cfg[0]then
return cfg[0]
end
end
end

function UIMoJieRankWin:XFFrsehRewards(widget,cfgrewards,rankNum)
local rewards=self:getRewardByRank(cfgrewards,rankNum)

if rewards then
widget:SetChildLayoutGroupCreateItems(rwitemidx.content,#rewards,function(index)
local item=widget:GetChildLayoutGroupGridItem(rwitemidx.content,index-1)
local rewardData=rewards[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and itemNum or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
end
end


function UIMoJieRankWin:initXianFaXianSun()
local enterData=xianjieModel:getMoJieEnterData()
self.mojiecfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
self:initXianFa()
end

function UIMoJieRankWin:setXFtopTxt()
local item=self.XFwidget:GetChildWidgetBase(xfpageidx.txtpanel)
item:SetChildText(1,'祖师名')
item:SetChildText(2,'所属盟')
item:SetChildText(3,'仙伐值')
item:SetChildText(4,'仙修数量')
item:SetChildText(5,'奖励')
end

function UIMoJieRankWin:XFFrsehSelf(rankDatas,cfgrewards,flag,myRank)
local widget
if flag==_eRankListType.xf then
widget=self.XFwidget:GetChildWidgetBase(xfpageidx.selfwidget)
widget:SetChildActive(rwitemidx.xfaddbtn,false)
elseif flag==_eRankListType.xs then
widget=self.XFwidget:GetChildWidgetBase(xfpageidx.selfwidget2)
widget:SetChildActive(rwitemidx.xfaddbtn,true)
end
if widget then
local isInList=myRank>0 and myRank<=#rankDatas
widget:SetChildText(rwitemidx.rank,isInList and myRank or'未上榜')
widget:SetChildText(rwitemidx.name,playerModel:getActorName())
if isInList then
local data=rankDatas[myRank]
widget:SetChildText(rwitemidx.meng,data.guildname)
widget:SetChildText(rwitemidx.value,tostring(data.val))
widget:SetChildText(rwitemidx.value2,tostring(data.num))
else
local xmName=xianmengModel:hasXM()and xianmengModel:getXMName()or"暂无"
widget:SetChildText(rwitemidx.meng,xmName)
widget:SetChildText(rwitemidx.value,0)
widget:SetChildText(rwitemidx.value2,0)
end
self:XFFrsehRewards(widget,cfgrewards,myRank)
end
end

function UIMoJieRankWin:initXianFa()
self.XFwidget=self.xianfa:getChildWidgetBase()
self.XFwidget:SetChildText(xfpageidx.bgtitle,'诛魔榜')
self.XFwidget:SetChildText(xfpageidx.title,'仙伐榜')
self.XFwidget:SetChildText(xfpageidx.btnonetxt,'个人诛仙')
self.XFwidget:SetChildText(xfpageidx.btntwotxt,'个人仙损')
self.XFwidget:SetChildButtonClick(xfpageidx.btnone,function()
if _this==nil then return end
self:changeSubBtn(1)
end)
self.XFwidget:SetChildButtonClick(xfpageidx.btntwo,function()
if _this==nil then return end
self:changeSubBtn(2)
end)
if self.selectSubIdx==1 then
self.XFwidget:SetChildActive(xfpageidx.XFpanel,true)
self.XFwidget:SetChildActive(xfpageidx.XSpanel,false)
else
self.XFwidget:SetChildActive(xfpageidx.XFpanel,false)
self.XFwidget:SetChildActive(xfpageidx.XSpanel,true)
end
self:setXFtopTxt()
self:freshXianFa_ZhuXian()
self:freshXianFa_XianSun()
end

function UIMoJieRankWin:freshXianFa_ZhuXian()
local cfgrank=self:getTypeReward(rewardtype.rank)
local cfgrewards=cfgrank[rewardrank.xf]
local rankDatas=xianjieController:getmojieRankList(_eRankListType.xf)

local len=#rankDatas
if len>0 then
self.XFwidget:SetChildActive(xfpageidx.rwScrollview,true)
self.XFwidget:SetChildActive(xfpageidx.paihangtxt,false)
self.XFwidget:SetChildScrollViewCreateGrids(xfpageidx.rwScrollview,len,0)
local grids=self.XFwidget:GetChildScrollViewItemWidgets(xfpageidx.rwScrollview)
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local data=rankDatas[i]
widget:SetChildText(rwitemidx.rank,data.rankNum)
widget:SetChildText(rwitemidx.name,data.actorname)
widget:SetChildText(rwitemidx.meng,data.guildname)
widget:SetChildText(rwitemidx.value,tostring(data.val))
widget:SetChildText(rwitemidx.value2,tostring(data.num))
self:XFFrsehRewards(widget,cfgrewards,data.rankNum)
end
else
self.XFwidget:SetChildActive(xfpageidx.rwScrollview,false)
self.XFwidget:SetChildActive(xfpageidx.paihangtxt,true)
end
self:ZhuXian_Self(rankDatas,cfgrewards)
end

function UIMoJieRankWin:ZhuXian_Self(rankDatas,cfgrewards)
local myRank=xianjieController:getmojieMyRank(_eRankListType.xf)
self:XFFrsehSelf(rankDatas,cfgrewards,_eRankListType.xf,myRank)
end

function UIMoJieRankWin:freshXianFa_XianSun()
local cfgrank=self:getTypeReward(rewardtype.rank)
local cfgrewards=cfgrank[rewardrank.xs]
local rankDatas=xianjieController:getmojieRankList(_eRankListType.xs)

local len=#rankDatas
if len>0 then
self.XFwidget:SetChildActive(xfpageidx.rwScrollview2,true)
self.XFwidget:SetChildActive(xfpageidx.paihangtxt2,false)
self.XFwidget:SetChildScrollViewCreateGrids(xfpageidx.rwScrollview2,len,0)
local grids=self.XFwidget:GetChildScrollViewItemWidgets(xfpageidx.rwScrollview2)
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local data=rankDatas[i]
widget:SetChildText(rwitemidx.rank,data.rankNum)
widget:SetChildText(rwitemidx.name,data.actorname)
widget:SetChildText(rwitemidx.meng,data.guildname)
widget:SetChildText(rwitemidx.value,tostring(data.val))
widget:SetChildText(rwitemidx.value2,tostring(data.num))
self:XFFrsehRewards(widget,cfgrewards,data.rankNum)
end
else
self.XFwidget:SetChildActive(xfpageidx.rwScrollview2,false)
self.XFwidget:SetChildActive(xfpageidx.paihangtxt2,true)
end
self:XianSun_Self(rankDatas,cfgrewards)
end

function UIMoJieRankWin:XianSun_Self(rankDatas,cfgrewards)
local myRank=xianjieController:getmojieMyRank(_eRankListType.xs)
local widget=self.XFwidget:GetChildWidgetBase(xfpageidx.selfwidget2)
self:XFFrsehSelf(rankDatas,cfgrewards,_eRankListType.xs,myRank)

widget:SetChildButtonClick(rwitemidx.xfaddbtn,function()
if self==nil then return end
self:XFAddBtn()
end)
self:freshXianSunSelf()
end

function UIMoJieRankWin:freshXianSunSelf()
local widget=_this.XFwidget:GetChildWidgetBase(xfpageidx.selfwidget2)
local txtitem=widget:GetChildWidgetBase(rwitemidx.xsjdpanel)
local xfList2=xianjieController:getXianSunList2()
if xfList2 then
for i=1,9 do
if xfList2[i]then
txtitem:SetChildActive(i-1,true)
txtitem:SetChildText(i-1,string.format("%s：%s",bingzhongs[xfList2[i][1]],tostring(xfList2[i][2])))
else
txtitem:SetChildActive(i-1,false)
end
end
end
end


function UIMoJieRankWin:initZhuMoAll()
local enterData=xianjieModel:getMoJieEnterData()
self.mojiecfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
self:initZhuMo()
end

function UIMoJieRankWin:setZMtopTxt()
local item=self.ZMwidget:GetChildWidgetBase(xfpageidx.txtpanel)
if self.selectSubIdx==1 then
item:SetChildText(1,'祖师名')
item:SetChildText(2,'所属盟')
item:SetChildText(3,'贡献值')
item:SetChildText(4,'魔修数量')
item:SetChildText(5,'奖励')
else
item:SetChildText(1,'仙盟名称')
item:SetChildText(3,'贡献值')
item:SetChildText(4,'魔修数量')
item:SetChildText(5,'奖励')
end
end

function UIMoJieRankWin:initZhuMo()
self.ZMwidget=self.zhumo:getChildWidgetBase()
self.ZMwidget:SetChildText(xfpageidx.bgtitle,'仙伐榜')
self.ZMwidget:SetChildText(xfpageidx.title,'诛魔榜')
self.ZMwidget:SetChildText(xfpageidx.btnonetxt,'个人伏魔')
self.ZMwidget:SetChildText(xfpageidx.btntwotxt,'仙盟伏魔')
self.ZMwidget:SetChildButtonClick(xfpageidx.btnone,function()
if _this==nil then return end
self:changeSubBtn(1)
end)
self.ZMwidget:SetChildButtonClick(xfpageidx.btntwo,function()
if _this==nil then return end
self:changeSubBtn(2)
end)

self:setZMtopTxt()
self:freshZhuMo_GeRen()
self:freshZhuMo_XianMeng()
end

function UIMoJieRankWin:freshZhuMo_GeRen()
local cfgrank=self:getTypeReward(rewardtype.rank)
local cfgrewards=cfgrank[rewardrank.zm]
local rankDatas=xianjieController:getmojieRankList(_eRankListType.zm)

local len=#rankDatas
if len>0 then
self.ZMwidget:SetChildActive(xfpageidx.rwScrollview,true)
self.ZMwidget:SetChildActive(xfpageidx.paihangtxt,false)
self.ZMwidget:SetChildScrollViewCreateGrids(xfpageidx.rwScrollview,len,0)
local grids=self.ZMwidget:GetChildScrollViewItemWidgets(xfpageidx.rwScrollview)
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local data=rankDatas[i]
widget:SetChildText(rwitemidx.rank,data.rankNum)
widget:SetChildText(rwitemidx.name,data.actorname)
widget:SetChildText(rwitemidx.meng,data.guildname)
widget:SetChildText(rwitemidx.value,tostring(data.val))
widget:SetChildText(rwitemidx.value2,tostring(data.num))
self:XFFrsehRewards(widget,cfgrewards,data.rankNum)
end
else
self.ZMwidget:SetChildActive(xfpageidx.rwScrollview,false)
self.ZMwidget:SetChildActive(xfpageidx.paihangtxt,true)
end
self:ZhuMo_Self(rankDatas,cfgrewards)
end

function UIMoJieRankWin:ZhuMo_Self(rankDatas,cfgrewards)
local widget=self.ZMwidget:GetChildWidgetBase(xfpageidx.selfwidget)
local myRank=xianjieController:getmojieMyRank(_eRankListType.zm)
local isInList=myRank>0 and myRank<=#rankDatas
widget:SetChildText(rwitemidx.rank,isInList and myRank or'未上榜')
widget:SetChildText(rwitemidx.name,playerModel:getActorName())
if isInList then
local data=rankDatas[myRank]
widget:SetChildText(rwitemidx.meng,data.guildname)
widget:SetChildText(rwitemidx.value,tostring(data.val))
widget:SetChildText(rwitemidx.value2,tostring(data.num))
else
local xmName=xianmengModel:hasXM()and xianmengModel:getXMName()or"暂无"
widget:SetChildText(rwitemidx.meng,xmName)
widget:SetChildText(rwitemidx.value,0)
widget:SetChildText(rwitemidx.value2,0)
end
self:XFFrsehRewards(widget,cfgrewards,myRank)
end

function UIMoJieRankWin:freshZhuMo_XianMeng()
local cfgrank=self:getTypeReward(rewardtype.rank)
local cfgrewards=cfgrank[rewardrank.zmxm]
local rankDatas=xianjieController:getmojieRankList(_eRankListType.zmxm)

local len=#rankDatas
if len>0 then
self.ZMwidget:SetChildActive(xfpageidx.rwScrollview2,true)
self.ZMwidget:SetChildActive(xfpageidx.paihangtxt2,false)
self.ZMwidget:SetChildScrollViewCreateGrids(xfpageidx.rwScrollview2,len,0)
local grids=self.ZMwidget:GetChildScrollViewItemWidgets(xfpageidx.rwScrollview2)
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local data=rankDatas[i]
widget:SetChildText(rwitemidx.rank,data.rankNum)
widget:SetChildText(rwitemidx.meng,data.guildname)
widget:SetChildText(rwitemidx.value,tostring(data.val))
widget:SetChildText(rwitemidx.value2,tostring(data.num))
self:XFFrsehRewards(widget,cfgrewards,data.rankNum)
end
else
self.ZMwidget:SetChildActive(xfpageidx.rwScrollview2,false)
self.ZMwidget:SetChildActive(xfpageidx.paihangtxt2,true)
end
self:XianMengZhuMo_Self(rankDatas,cfgrewards)
end

function UIMoJieRankWin:XianMengZhuMo_Self(rankDatas,cfgrewards)
local widget=self.ZMwidget:GetChildWidgetBase(xfpageidx.selfwidget2)
local myRank=xianjieController:getmojieMyRank(4)
local isInList=myRank>0 and myRank<=#rankDatas
widget:SetChildText(rwitemidx.rank,isInList and myRank or'未上榜')
widget:SetChildText(rwitemidx.name,playerModel:getActorName())
if isInList then
local data=rankDatas[myRank]
widget:SetChildText(rwitemidx.meng,data.guildname)
widget:SetChildText(rwitemidx.value,tostring(data.val))
widget:SetChildText(rwitemidx.value2,tostring(data.num))
else
local xmName=xianmengModel:hasXM()and xianmengModel:getXMName()or"暂无"
widget:SetChildText(rwitemidx.meng,xmName)
widget:SetChildText(rwitemidx.value,0)
widget:SetChildText(rwitemidx.value2,0)
end
self:XFFrsehRewards(widget,cfgrewards,myRank)
end
