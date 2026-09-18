







def_class("UIXM_ZZSH_RankListWin",UIWindowBase)









function UIXM_ZZSH_RankListWin:bindComponents()

self.leftList=UIObject.get(self,0)
self.ZCRankList=UIObject.get(self,1)
self.ZMRankList=UIObject.get(self,2)
self.BZRankList=UIObject.get(self,3)
self.ZCScrollerScript=UIEnhancedScrollerLua.get(self,4)
self.ZMScrollerScript=UIEnhancedScrollerLua.get(self,5)
self.BZScrollerScript=UIEnhancedScrollerLua.get(self,6)
self.menuAnimGrid=UIObject.get(self,7)
self.menu_anim_1=UIObject.get(self,8)
self.menu_anim_2=UIObject.get(self,9)
self.menu_anim_3=UIObject.get(self,10)
self.notLog=UIObject.get(self,11)
self.ZCsortTypeDropdown=UIDropdown.get(self,12)
self.BMsortTypeDropdown=UIDropdown.get(self,13)
self.menu_anim={
self.menu_anim_1,
self.menu_anim_2,
self.menu_anim_3,
}



end


function UIXM_ZZSH_RankListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftList);self.leftList=nil;
_UIObject_release(self.ZCRankList);self.ZCRankList=nil;
_UIObject_release(self.ZMRankList);self.ZMRankList=nil;
_UIObject_release(self.BZRankList);self.BZRankList=nil;
_UIObject_release(self.ZCScrollerScript);self.ZCScrollerScript=nil;
_UIObject_release(self.ZMScrollerScript);self.ZMScrollerScript=nil;
_UIObject_release(self.BZScrollerScript);self.BZScrollerScript=nil;
_UIObject_release(self.menuAnimGrid);self.menuAnimGrid=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.menu_anim_2);self.menu_anim_2=nil;
_UIObject_release(self.menu_anim_3);self.menu_anim_3=nil;
_UIObject_release(self.notLog);self.notLog=nil;
_UIObject_release(self.ZCsortTypeDropdown);self.ZCsortTypeDropdown=nil;
_UIObject_release(self.BMsortTypeDropdown);self.BMsortTypeDropdown=nil;
self.menu_anim=nil;
end


















local eRankListType=
{
zhanchang=1,
xianmeng=2,
benzong=3,
}

local eRoleRankType=
{
attack=1,
defend=2,
}

local UIXM_ZZSH_RankItem_ZC=
{
rankframe=2,
rankNo=3,
serversName=4,
playerName=5,
xianmengName=6,
attackCount=7,
defendCount=8,
MomentumValue=9,
}

local UIXM_ZZSH_RankItem_XM=
{
rankframe=2,
rankNo=3,
serversName=4,
playerName=5,
attackCount=6,
defendCount=7,
}

local UIXM_ZZSH_RankItem_BZ=
{
rankframe=2,
rankNo=3,
serversName=4,
playerName=5,
attackCount=6,
defendCount=7,
bianduiName=8,
}

local this
local CdTime=30
local typeList={eRankListType.zhanchang,eRankListType.xianmeng,eRankListType.benzong}
local typeName={"战场","本盟","本宗"}
local leftCmp={
owner=-1,
select=0,
name=1,
}

local SortType=
{
attack=0,
defend=1,
}
local body_menu_id=2017
local menu_slot_name='button_dytab'


local UIZCEnScroller=simple_class(UIEnhancedScroller)
local UIXMEnScroller=simple_class(UIEnhancedScroller)
local UIBZEnScroller=simple_class(UIEnhancedScroller)

function UIXM_ZZSH_RankListWin:bindEnScroller()
self.ZCenhancedscrollscript=UIZCEnScroller(self.ZCScrollerScript:getGameObject(),self.ZCScrollerScript:getCSharpObject(),nil,nil)
self.ZCenhancedscrollscript.window=self

self.XMenhancedscrollscript=UIXMEnScroller(self.ZMScrollerScript:getGameObject(),self.ZMScrollerScript:getCSharpObject(),nil,nil)
self.XMenhancedscrollscript.window=self

self.BZenhancedscrollscript=UIBZEnScroller(self.BZScrollerScript:getGameObject(),self.BZScrollerScript:getCSharpObject(),nil,nil)
self.BZenhancedscrollscript.window=self
end


function UIXM_ZZSH_RankListWin:initSortType()
self.ZCSort=SortType.attack
self.XMSort=SortType.attack
end

function UIXM_ZZSH_RankListWin:onLoaded(...)
this=self
self:bindComponents()
self:bindEnScroller()
self.ZCsortTypeDropdown:setChangeAction(function(...)self:onDropdownChange_ZC(...)end)
self.BMsortTypeDropdown:setChangeAction(function(...)self:onDropdownChange_BM(...)end)
self.localRankCfg=zhengzhanshanhaiController:getZZSHCfg('rank')
self.TimeRecord=zhengzhanshanhaiModel:getTimeRecord()
self.PanelList={self.ZCRankList,self.ZMRankList,self.BZRankList}
self.ScrollList={self.ZCScrollerScript,self.ZMScrollerScript,self.BZScrollerScript}
self:initSortType()
self:shwoMenu_Anim()
self:refreshLeft()
self:onClickLeft(1)
end


function UIXM_ZZSH_RankListWin:__delete()
self:unbindComponents()
self.selected=nil
end




function UIXM_ZZSH_RankListWin:onShow(argtable,afterOnloaded)
self.ZCsortTypeDropdown:setOption({"进攻胜场","防守胜场"})
self.ZCsortTypeDropdown:setValue(self.ZCSort)

self.BMsortTypeDropdown:setOption({"进攻胜场","防守胜场"})
self.BMsortTypeDropdown:setValue(self.XMSort)
end


function UIXM_ZZSH_RankListWin:onHide()

end




function UIXM_ZZSH_RankListWin:onDropdownChange_ZC(idx)
self.ZCSort=idx
self:refreshRight()
end
function UIXM_ZZSH_RankListWin:onDropdownChange_BM(idx)
self.XMSort=idx
self:refreshRight()
end

function UIXM_ZZSH_RankListWin:onCloseClick()
self:closeSelf()
end

function UIXM_ZZSH_RankListWin:refreshLeft()
self.leftList:setChildLayoutGroupCreateItems(#typeList,function(idx)
local leftItem=self.leftList:getChildLayoutGroupGridItem(idx-1)
local TitleName=typeName[idx]
leftItem:SetChildText(leftCmp.name,TitleName)
leftItem:SetChildButtonClickWithID(leftCmp.owner,function(index)
self:onClickLeft(index)
end,idx)
end)
end

function UIXM_ZZSH_RankListWin:onClickLeft(index)

if self.selected~=index then
if self.selected then
self.PanelList[self.selected]:setActive(false)
local anim=self.menu_anim[self.selected]
self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,FMT.fmt("{0}_{1}",menu_slot_name,1))
end
self.selected=index
local anim=self.menu_anim[self.selected]
if self.selected then
anim:setChildModelAnimationState(eAnimationID.common_window_dianji)
self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,FMT.fmt("{0}_{1}",menu_slot_name,2))
end

self:onClickHandle()
end
end


function UIXM_ZZSH_RankListWin:onClickHandle()
self.MomentumData=zhengzhanshanhaiModel:getMomentumData()
if self.TimeRecord[self.selected]and self.MomentumData then
local reqCd=((os.time()-self.TimeRecord[self.selected])>=CdTime)
if reqCd then
self.TimeRecord[self.selected]=os.time()
self:reqHandle()
else
self:refreshRight()
end
else
self.TimeRecord[self.selected]=os.time()
self:reqHandle()
end
end


function UIXM_ZZSH_RankListWin:reqHandle()
if self.selected==eRankListType.zhanchang then
zhengzhanshanhaiController:reqZCMomentRankData()
elseif self.selected==eRankListType.xianmeng then
zhengzhanshanhaiController:reqXMMomentRankData()
else
zhengzhanshanhaiController:reqBZMomentRankData()
end
end


function UIXM_ZZSH_RankListWin:shwoMenu_Anim()
for i,v in ipairs(self.menu_anim)do
local anim=self.menu_anim[i]
local func=function(...)
self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,1==i and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
anim:setChildUIModelShowTarget(body_menu_id,1,{},eAnimationID.common_window_enter,false,false,0,func)
end
end


function UIXM_ZZSH_RankListWin:refreshRight()
self.PanelList[self.selected]:setActive(true)
self.MomentumData=zhengzhanshanhaiModel:getMomentumData()
local itemCount=0
if self.selected==eRankListType.zhanchang then
if self.ZCSort==SortType.attack then
itemCount=#self.MomentumData.ZCattacklist
self.ZCenhancedscrollscript:initData(self.MomentumData.ZCattacklist,73,itemCount)
else
itemCount=#self.MomentumData.ZCdefendlist
self.ZCenhancedscrollscript:initData(self.MomentumData.ZCdefendlist,73,itemCount)
end
elseif self.selected==eRankListType.xianmeng then
if self.XMSort==SortType.attack then
if self.MomentumData.XMattacklist then
table.sort(self.MomentumData.XMattacklist,function(a,b)
return a.attackSort>b.attackSort
end)
end
itemCount=#self.MomentumData.XMattacklist
self.XMenhancedscrollscript:initData(self.MomentumData.XMattacklist,73,itemCount)
else
if self.MomentumData.XMattacklist then
table.sort(self.MomentumData.XMattacklist,function(a,b)
return a.defendSort>b.defendSort
end)
end
itemCount=#self.MomentumData.XMattacklist
self.XMenhancedscrollscript:initData(self.MomentumData.XMattacklist,73,itemCount)
end
else
if self.MomentumData.BZattacklist then
itemCount=#self.MomentumData.BZattacklist
self.BZenhancedscrollscript:initData(self.MomentumData.BZattacklist,73,itemCount)
end
end
self.notLog:setActive(itemCount==0)
end



function UIXM_ZZSH_RankListWin:ZCBtn1()
if self.ZCSort~=SortType.attack then
self.ZCSort=SortType.attack
self:refreshRight()
end

end


function UIXM_ZZSH_RankListWin:ZCBtn2()
if self.ZCSort~=SortType.defend then
self.ZCSort=SortType.defend
self:refreshRight()
end
end



function UIXM_ZZSH_RankListWin:XMBtn1()
if self.XMSort~=SortType.attack then
self.XMSort=SortType.attack
self:refreshRight()
end
end


function UIXM_ZZSH_RankListWin:XMBtn2()
if self.XMSort~=SortType.defend then
self.XMSort=SortType.defend
self:refreshRight()
end
end


function UIZCEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIZCEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIZCEnScroller:RefreshCell(dataIndex,cellIndex,cell)
local curdata
local showattack,curRankCfg
local addMomentum=0
if this.ZCSort==SortType.attack then
curdata=this.MomentumData.ZCattacklist[dataIndex]
showattack=curdata.times

curRankCfg=this.localRankCfg[eRoleRankType.attack]
else
curdata=this.MomentumData.ZCdefendlist[dataIndex]
showattack=curdata.times

curRankCfg=this.localRankCfg[eRoleRankType.defend]
end
local itemCmp=cell

local frameName=rankListModel.getFrameName(dataIndex)
if frameName then
itemCmp:SetChildCSImageSprite(UIXM_ZZSH_RankItem_ZC.rankframe,globalABLookup.rankList,frameName)
else
itemCmp:SetChildIcon(UIXM_ZZSH_RankItem_ZC.rankframe,"",false)
end
itemCmp:SetChildText(UIXM_ZZSH_RankItem_ZC.rankNo,dataIndex)
itemCmp:SetChildText(UIXM_ZZSH_RankItem_ZC.serversName,loginModel:getServerName(curdata.serverid))
itemCmp:SetChildText(UIXM_ZZSH_RankItem_ZC.playerName,curdata.actorname)
itemCmp:SetChildText(UIXM_ZZSH_RankItem_ZC.xianmengName,curdata.guildname)

itemCmp:SetChildText(UIXM_ZZSH_RankItem_ZC.attackCount,showattack)


local rankAddMomentumCfg=curRankCfg[2]
for i=1,#rankAddMomentumCfg do
if i==1 then
if dataIndex==1 then
addMomentum=rankAddMomentumCfg[i][2]
break
end
else
if dataIndex>rankAddMomentumCfg[i-1][1]and dataIndex<=rankAddMomentumCfg[i][1]then
addMomentum=rankAddMomentumCfg[i][2]
break
end
end
end
itemCmp:SetChildText(UIXM_ZZSH_RankItem_ZC.MomentumValue,addMomentum)
end



function UIXMEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIXMEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIXMEnScroller:RefreshCell(dataIndex,cellIndex,cell)

local curdata
local showattack,defend,curRankCfg

curdata=this.MomentumData.XMattacklist[dataIndex]
if this.XMSort==SortType.attack then
showattack=curdata.attack
else
showattack=curdata.defend
end

local itemCmp=cell

local frameName=rankListModel.getFrameName(dataIndex)
if frameName then
itemCmp:SetChildCSImageSprite(UIXM_ZZSH_RankItem_XM.rankframe,globalABLookup.rankList,frameName)
else
itemCmp:SetChildIcon(UIXM_ZZSH_RankItem_XM.rankframe,"",false)
end
itemCmp:SetChildText(UIXM_ZZSH_RankItem_XM.rankNo,dataIndex)

itemCmp:SetChildText(UIXM_ZZSH_RankItem_XM.serversName,loginModel:getServerName(curdata.serverid))
itemCmp:SetChildText(UIXM_ZZSH_RankItem_XM.playerName,curdata.actorname)
itemCmp:SetChildText(UIXM_ZZSH_RankItem_XM.attackCount,showattack)

end


function UIBZEnScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIBZEnScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIBZEnScroller:RefreshCell(dataIndex,cellIndex,cell)


local curdata=this.MomentumData.BZattacklist[dataIndex]
local teamtype=curdata.teamtype
local support=curdata.support
local attack=curdata.attack
local defend=curdata.defend

local bianduiName=string.format("编队%s",dataIndex)
local Desc=support==0 and string.format("进攻仙阵%s",dataIndex)or"外派队伍"

local itemCmp=cell

local frameName=rankListModel.getFrameName(dataIndex)
if frameName then
itemCmp:SetChildCSImageSprite(UIXM_ZZSH_RankItem_BZ.rankframe,globalABLookup.rankList,frameName)
else
itemCmp:SetChildIcon(UIXM_ZZSH_RankItem_BZ.rankframe,"",false)
end
itemCmp:SetChildText(UIXM_ZZSH_RankItem_BZ.rankNo,dataIndex)

itemCmp:SetChildText(UIXM_ZZSH_RankItem_BZ.bianduiName,bianduiName)
itemCmp:SetChildText(UIXM_ZZSH_RankItem_BZ.playerName,Desc)
itemCmp:SetChildText(UIXM_ZZSH_RankItem_BZ.attackCount,attack)
itemCmp:SetChildText(UIXM_ZZSH_RankItem_BZ.defendCount,defend)
end

