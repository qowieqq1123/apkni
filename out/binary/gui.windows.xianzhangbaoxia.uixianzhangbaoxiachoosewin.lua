







def_class("UIXianZhangBaoXiaChooseWin",UIWindowBase)









function UIXianZhangBaoXiaChooseWin:bindComponents()

self.title=UIText.get(self,0)
self.taskScroller=UIObject.get(self,1)
self.onkeybtn=UIButton.get(self,2)
self.surebtn=UIButton.get(self,3)
self.dfptxt=UIText.get(self,4)
self.tipsbtn=UIButton.get(self,5)
self.sortTypeMenu=UIDropdown.get(self,6)
self.notips=UIObject.get(self,7)
self.root=UIObject.get(self,8)

self.onkeybtn:setButtonClick(function()self:onOnkeybtn()end)

self.surebtn:setButtonClick(function()self:onSurebtn()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)



end


function UIXianZhangBaoXiaChooseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.onkeybtn);self.onkeybtn=nil;
_UIObject_release(self.surebtn);self.surebtn=nil;
_UIObject_release(self.dfptxt);self.dfptxt=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.sortTypeMenu);self.sortTypeMenu=nil;
_UIObject_release(self.notips);self.notips=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this
local _sort_type={
eFight=1,
eWeekscore=2,
eTmscore=3,
}
local _sort_type_name={
[_sort_type.eFight]="实力",
[_sort_type.eWeekscore]="活跃",
[_sort_type.eTmscore]="积分",
}
local intemidx=
{
selfitem=0,
head=1,
name=2,
shili=3,
voc=4,
jifen=5,
choose=6,
nochoose=7,
btn=8,
}
local abname="ui/windows/xianzhangbaoxia/xianzhangbaoxia_atlas_pak.ab"



function UIXianZhangBaoXiaChooseWin:onLoaded(...)
self:bindComponents()
_this=self
self.memberList={}
self.assignFenPeilist={}
self.chooseList={}
self.sortTypeMenu:setChangeAction(function(id)
self:onDropDownChange(id)
end)
end


function UIXianZhangBaoXiaChooseWin:__delete()
self:unbindComponents()
_this=nil
end
function UIXianZhangBaoXiaChooseWin:onTipsbtn()
local d={}
d.title='规则'
d.mode=3
d.name='ui_UIMoJieForceMainWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end


function UIXianZhangBaoXiaChooseWin:onClickActorBtn(i)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local item=grids[i-1]
if item then
local memberData=self.memberList[i]
local actorData=memberData.netData
local actorKey=memberData.actorKey
local actorid=actorData.actorid
if self.chooseList[actorKey]then
self.chooseList[actorKey]=nil
item:SetChildActive(intemidx.choose,false)
item:SetChildActive(intemidx.nochoose,true)
else
local chooseNum,maxNum=self:getFenPeiNum()
local shengyuNum=maxNum-chooseNum
if shengyuNum<=0 then
UIManager.info('可分配数量已达上限')
return
end
self.chooseList[actorKey]=actorid
item:SetChildActive(intemidx.choose,true)
item:SetChildActive(intemidx.nochoose,false)
end
end
self:freshFenPeiNum()
end

function UIXianZhangBaoXiaChooseWin:onSurebtn()
if self.memberList and#self.memberList==0 then
UIManager.info('已分配所有盟友')
return
end
if self.chooseList and next(self.chooseList)then
local actorList={}
for k,v in pairs(self.chooseList)do
table.insert(actorList,v)
end
local itemId=self.itemList.itemId
XianMengBaoXiaController:send_20_98(self.bx_guid,itemId,#actorList,actorList,1)
self:onCloseBtn()
end
end

function UIXianZhangBaoXiaChooseWin:onOnkeybtn()
if self.memberList and#self.memberList==0 then
UIManager.info('已分配所有盟友')
return
end
local chooseNum,maxNum=self:getFenPeiNum()
local shengyuNum=maxNum-chooseNum
local list=self.memberList
if chooseNum>=#list then
UIManager.info('已分配')
return
end
if shengyuNum>0 then
local grids=self.taskScroller:getChildScrollViewItemWidgets()
for i,v in ipairs(list)do
local item=grids[i-1]
if item then
local memberData=list[i]
local actorData=memberData.netData
local actorKey=memberData.actorKey
local actorid=actorData.actorid
if not self.chooseList[actorKey]then
self.chooseList[actorKey]=actorid

item:SetChildActive(intemidx.choose,true)
item:SetChildActive(intemidx.nochoose,false)

shengyuNum=shengyuNum-1
if shengyuNum==0 then
break
end
end
end
end
else
UIManager.info('可分配数量已达上限')
return
end
self:freshFenPeiNum()
end




function UIXianZhangBaoXiaChooseWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
local bxguid=argtable.guid
local bxindex=argtable.index
if bxguid and bxindex then
self.bx_guid=bxguid
self.bx_index=bxindex
self.bx_list=XianMengBaoXiaModel:getXZBXDataByGuid(bxguid)
self.itemList=self.bx_list.itemList[self.bx_index]


self:setAssignList()
self:setMemberCheckList()
self.isXZ=XianMengBaoXiaController:isMengZhu()


self:freshFenPeiNum()
self.sortTypeMenu:setOption(_sort_type_name)
self.sortType=_sort_type.eFight


self:onDropDownChange(self.sortType-1)
end
end


function UIXianZhangBaoXiaChooseWin:onHide()

end
function UIXianZhangBaoXiaChooseWin:onCloseBtn()
self:closeSelf()
end

function UIXianZhangBaoXiaChooseWin:freshsever(bxguid)
if bxguid==self.bx_guid then
self.bx_list=XianMengBaoXiaModel:getXZBXDataByGuid(bxguid)
self.itemList=self.bx_list.itemList[self.bx_index]
self:setAssignList()
self:setMemberCheckList()
self:freshFenPeiNum()
self:refreshDisciplePanel()
end
end


function UIXianZhangBaoXiaChooseWin:onDropDownChange(id)
self.sortType=id+1
self:refreshDisciplePanel()
end

function UIXianZhangBaoXiaChooseWin:freshFenPeiNum()
local chooseNum,maxNum=self:getFenPeiNum()
self.dfptxt:setText(FMT.fmt('待分配<color=#7d3b17>（{0}/{1}）</color>',chooseNum,maxNum))
end

function UIXianZhangBaoXiaChooseWin:getFenPeiNum()
local chooseNum=0
if self.chooseList then
for k,v in pairs(self.chooseList)do
chooseNum=chooseNum+1
end
end
local maxNum=self.itemList.itemNum
chooseNum=chooseNum+(maxNum-self.itemList.itemNum2)
if chooseNum>maxNum then
chooseNum=maxNum
end
return chooseNum,maxNum
end

function UIXianZhangBaoXiaChooseWin:setAssignList()
self.assignFenPeilist={}

local itemList=self.bx_list.itemList
for _,k in pairs(itemList)do
local assignList=k.assignList
if assignList then
for _,v in ipairs(assignList)do
local dstActorKey=tostring(v.dstActorId)
self.assignFenPeilist[dstActorKey]=true
end
end
end









end

function UIXianZhangBaoXiaChooseWin:setMemberCheckList()
local list=xianmengModel:getXMMemberList()
local temp={}
for i,v in ipairs(list)do
local actorKey=tostring(v.actorid)
if not self.assignFenPeilist[actorKey]then
local w_fight=tonumber(tostring(v.fight))
local w_weekscore=v.weekscore
local w_tmscore=v.tmscore
local d={netData=v,actorKey=actorKey,w_fight=w_fight,w_weekscore=w_weekscore,w_tmscore=w_tmscore}
table.insert(temp,d)
end
end
self.memberList=temp
end

function UIXianZhangBaoXiaChooseWin:getListSort()
if self.memberList and#self.memberList>1 then
if self.sortType==_sort_type.eFight then
table.sort(self.memberList,function(a,b)
return a.w_fight>b.w_fight
end)
elseif self.sortType==_sort_type.eWeekscore then
table.sort(self.memberList,function(a,b)
return a.w_weekscore>b.w_weekscore
end)
elseif self.sortType==_sort_type.eWeekscore then
table.sort(self.memberList,function(a,b)
return a.w_tmscore>b.w_tmscore
end)
end
end
end


function UIXianZhangBaoXiaChooseWin:refreshDisciplePanel()
self:getListSort()
local list=self.memberList
local dataNum=#list
if dataNum>0 then
self.taskScroller:setActive(true)
self.notips:setActive(false)
self.taskScroller:setChildScrollViewCreateGrids(dataNum,2)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local memberData=list[i]
local actorData=memberData.netData
local actorKey=memberData.actorKey


local actorname=actorData.actorname
item:SetChildText(intemidx.name,actorname)

local headwidget=item:GetChildWidgetBase(intemidx.head)
playerController:setHeadIcon(headwidget,0,{iconInfo=actorData.iconInfo,scale=0.68})

local fightnum=tonumber(tostring(actorData.fight))
local fight_str=FMT.fmt('实力：<color=#7d3b17>{0}</color>',mathHelper.formatNumber3(fightnum))
item:SetChildText(intemidx.shili,fight_str)

local postType=actorData.pos
local postName=xianmengModel.getXMPostName(postType,true)
item:SetChildText(intemidx.voc,postName)

local tmscore=actorData.tmscore
if tmscore and tmscore>0 then
item:SetChildText(intemidx.jifen,FMT.fmt('积分：<color=#7d3b17>{0}</color>',tmscore))
else
item:SetChildText(intemidx.jifen,"")
end


if self.chooseList[actorKey]then
item:SetChildActive(intemidx.choose,true)
item:SetChildActive(intemidx.nochoose,false)
else
item:SetChildActive(intemidx.choose,false)
item:SetChildActive(intemidx.nochoose,true)
end


item:SetChildButtonClick(intemidx.btn,function()
if _this==nil then return end
self:onClickActorBtn(i)
end)
end
end
else
self.taskScroller:setActive(false)
self.notips:setActive(true)
end
end


