







def_class("UIGongFaMainWin",UIWindowBase)









function UIGongFaMainWin:bindComponents()

self.btnGrids=UIObject.get(self,0)
self.cloud=UIObject.get(self,1)
self.dzItem=UIObject.get(self,2)
self.juanzhou=UIObject.get(self,3)
self.progressTxt=UIText.get(self,4)
self.recycleBtn=UIButton.get(self,5)
self.recycleReddot=UIObject.get(self,6)
self.root=UIObject.get(self,7)

self.recycleBtn:setButtonClick(function()self:onRecycleBtn()end)



end


function UIGongFaMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnGrids);self.btnGrids=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.dzItem);self.dzItem=nil;
_UIObject_release(self.juanzhou);self.juanzhou=nil;
_UIObject_release(self.progressTxt);self.progressTxt=nil;
_UIObject_release(self.recycleBtn);self.recycleBtn=nil;
_UIObject_release(self.recycleReddot);self.recycleReddot=nil;
_UIObject_release(self.root);self.root=nil;
end
















local PageSlotConfig=
{
[1]={
wins={'UIGongFaSelectWin'},
},
[2]={
wins={'UIGongFaDiscipleSelectWin'},

},
[3]={
wins={'UICangJingGeInfoWin'},
},
}
local juanZhouHeight={
22,482
}


function UIGongFaMainWin:onLoaded(...)
self:bindComponents()
end


function UIGongFaMainWin:__delete()
self:unbindComponents()
self:closeAllWin()
end


function UIGongFaMainWin:onHide()

end

function UIGongFaMainWin:doFadeIn(delay,duration,callback)
local func=function()
self.root:setChildCanvasGroupDOFade(1,duration,nil)
if callback~=nil then
callback()
end
end
if delay>0 then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(delay,func)
else
func()
end
end

function UIGongFaMainWin:refreshJuanZhou()
local flag=self.selectPage~=1
local isOpenJZ=self.isOpenJZ
if isOpenJZ==nil then
isOpenJZ=false
end
if isOpenJZ==flag then
return
end
self.isOpenJZ=flag
local height=flag==true and juanZhouHeight[2]or juanZhouHeight[1]
local tw=self.juanzhou:setChildDOSizeDelta(Vector2(894,height),0.35,nil)
tw:SetEase(DG.Tweening.Ease.OutExpo)
end




function UIGongFaMainWin:onShow(argtable,afterOnloaded)
self.dis_guid=argtable.dis_guid
self.plotType=argtable.plotType
local defaultPage=argtable.showPage or 1
self.old_selectPage=self.selectPage
self.selectPage=defaultPage

local entityID=argtable.entityID
self.bdData=zongmenModel:findBuildingByEntityId(entityID)

local func=function()
self:refreshJuanZhou()
end
local fadeInData=argtable.fadeInData
self.fadeInData=fadeInData
if afterOnloaded and fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2],func)
else
func()
end

self:refreshBtnGrids()
self:refreshWin()
self:refreshProgress()
if afterOnloaded then
self:initModel()
end
self.fadeInData=nil
self:refreshRecycle()
end

function UIGongFaMainWin:onShowArgRecv(argtable)
self:onShow(argtable)
end






function UIGongFaMainWin:refreshWin()
local show_wins={}
local close_wins={}
local cur=PageSlotConfig[self.selectPage]

local cur_wins=cur.wins
cur_wins=cur_wins or cur.wins
if cur_wins and#cur_wins>0 then
for i,v in ipairs(cur_wins)do
show_wins[v]=true
end
end
if self.activeWin~=nil then
for k,v in pairs(self.activeWin)do
if show_wins[k]==nil then
close_wins[k]=true
end
end
end

for k,v in pairs(close_wins)do
UIManager:closeWindow(k)
self.activeWin[k]=nil
end

if self.activeWin==nil then
self.activeWin={}
end
if cur_wins and#cur_wins>0 then
local sortType
local data=self.btnlist[self.curSelectIndex]
if data then
sortType=data[1]
end
for i,v in ipairs(cur_wins)do
UIManager:showWindow(v,{guid=self.dis_guid,plotType=self.plotType,page=self.selectPage,parent=self,
bdData=self.bdData,old_page=self.old_selectPage,sortType=sortType,fadeInData=self.fadeInData})
self.activeWin[v]=true
end
self.dis_guid=nil
self.plotType=nil
end
end

function UIGongFaMainWin:callWinFunc(funcName,args)
for winName,v in pairs(self.activeWin)do
if v==true then
UIManager:invokeUIMethod(winName,funcName,args)
end
end
end

function UIGongFaMainWin:closeAllWin()
if self.activeWin~=nil then
for k,v in pairs(self.activeWin)do
UIManager:closeWindow(k)
end
self.activeWin=nil
end
end

function UIGongFaMainWin:refreshBtnGrids()
local btnlist={}
if self.selectPage==1 then
btnlist[#btnlist+1]={0,'全',ELEMENT_TYPE.getIconEx(0),globalABLookup.global}
local elementtypes=ELEMENT_TYPE:getFive()
for i,v in ipairs(elementtypes)do
btnlist[#btnlist+1]={v,ELEMENT_TYPE.getName(v),ELEMENT_TYPE.getIcon(v),globalABLookup.global}
end
elseif self.selectPage==2 then
local typelist={eDiscipleSortType.eFightSort,eDiscipleSortType.eJingJieSort,eDiscipleSortType.eLianTiSort,
eDiscipleSortType.eColorSort,eDiscipleSortType.ePostSort}
for i,v in ipairs(typelist)do
btnlist[#btnlist+1]={v,eDiscipleSortTypeName:getName1(v)}
end
end
self.btnlist=btnlist

self.curSelectIndex=1

local c=#btnlist
local func=function(idx)
self:refreshBtnItem(nil,idx)
end
self.btnGrids:setChildLayoutGroupCreateItems(c,func)
end

function UIGongFaMainWin:refreshBtnItem(item,idx)
if item==nil then
item=self.btnGrids:getChildLayoutGroupGridItem(idx-1)
end

local data=self.btnlist[idx]

item:SetChildText(2,data[2])

local icon=data[3]
local showIcon=icon~=nil
item:SetChildActive(1,showIcon)
if showIcon then
item:SetChildCSImageSprite(1,data[4],icon)
end

self:refreshBtnItemSelect(item,idx,self.curSelectIndex==idx)

item:SetChildButtonClick(0,function()
self:onBtnItemClick(idx)
end)
end

function UIGongFaMainWin:refreshBtnItemSelect(item,idx,flag)
if item==nil then
item=self.btnGrids:getChildLayoutGroupGridItem(idx-1)
end

local iconName=flag==true and'button_cangjinggetab_2'or'button_cangjinggetab_1'
item:SetChildCSImageSprite(0,globalABLookup.cangjingge,iconName)
end

function UIGongFaMainWin:onBtnItemClick(idx)
local data=self.btnlist[idx]
local sortType=data[1]

if self.curSelectIndex==idx then
return
end

self:refreshBtnItemSelect(nil,self.curSelectIndex,false)
self:refreshBtnItemSelect(nil,idx,true)
self.curSelectIndex=idx

self:refreshProgress()
self:callWinFunc('onSortTypeChange',{sortType=sortType})
end

function UIGongFaMainWin:refreshProgress()
local progress_str=''
if self.selectPage==1 then
local data=self.btnlist[self.curSelectIndex]
local element=data[1]
local desc1
if element==0 then
desc1='所有功法'
else
desc1=ELEMENT_TYPE.getNameGF(element)
end
local cur,max=UIGongFaModel:getGongFaProgressByElement(element)
progress_str=FMT.fmt('{0}收集：{1}/{2}',desc1,cur,max)
end
self.progressTxt:setText(progress_str)
end

function UIGongFaMainWin:initModel()
local guid=nil
local list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eChuanGong)or{}
if#list>0 then
local netData=list[1]
guid=netData.discipleguid
end
if guid==nil then
if self.dzData~=nil then
if self.dzData.bt then
behaviorManager:removeBehaviorTree(self.dzData.bt)
end
self.dzData.dzWidget:SetChildUIModelRemoveTarget(0)
self.dzData=nil
end
return
end

local dzWidget=self.dzItem:getWidgetBase()
local offsetX=0
local fadeIn=0.6
comHelper.setChildHead(dzWidget,guid,0,1,offsetX,nil,false,nil,fadeIn)
dzWidget:SetChildUIModelShowFlipX(0,true)
dzWidget:SetChildAnchoredPosition(0,Vector2(-444,-235))
local dzData={}
dzData.dzWidget=dzWidget
dzData.guid=guid
dzData.bt=nil

self.dzData=dzData
end



function UIGongFaMainWin:rec_activepage()
self:refreshProgress()
end

function UIGongFaMainWin:refreshRecycle()
local isOpen=systemModel.isOpen(SYSTEM_DEFINE.eGongFaRecycle)
self.recycleBtn:setActive(isOpen)
local reddot=UIGongFaModel:checkGongFaRecycleReddot()
self.recycleReddot:setActive(reddot)
end

function UIGongFaMainWin:onRecycleBtn()
local reddot=UIGongFaModel:checkGongFaRecycleReddot()
if not reddot then
return UIManager.info("暂无可回收的功法篇章")
else
self:showWindow("UIGongFaRecycleWin")
end
end