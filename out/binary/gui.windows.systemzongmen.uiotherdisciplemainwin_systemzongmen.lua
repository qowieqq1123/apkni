







def_class("UIOtherDiscipleMainWin_SystemZongMen",UIWindowBase)









function UIOtherDiscipleMainWin_SystemZongMen:bindComponents()

self.back=UIObject.get(self,0)
self.menuAnimGrid=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.menulist=UIObject.get(self,3)
self.menu_anim_1=UIObject.get(self,4)
self.menu_anim_2=UIObject.get(self,5)
self.menu_anim_3=UIObject.get(self,6)
self.menu_anim_4=UIObject.get(self,7)
self.discipleListPanel=UIScrollView.get(self,8)
self.copyBtn=UIButton.get(self,9)
self.scrollView=UIScrollView.get(self,10)

self.copyBtn:setButtonClick(function()self:onCopyBtn()end)
self.menu_anim={
self.menu_anim_1,
self.menu_anim_2,
self.menu_anim_3,
self.menu_anim_4,
}



end


function UIOtherDiscipleMainWin_SystemZongMen:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.menuAnimGrid);self.menuAnimGrid=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.menulist);self.menulist=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.menu_anim_2);self.menu_anim_2=nil;
_UIObject_release(self.menu_anim_3);self.menu_anim_3=nil;
_UIObject_release(self.menu_anim_4);self.menu_anim_4=nil;
_UIObject_release(self.discipleListPanel);self.discipleListPanel=nil;
_UIObject_release(self.copyBtn);self.copyBtn=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
self.menu_anim=nil;
end
















local WriteInCopyBuffer=CS.UIHelper.WriteInCopyBuffer

local PageSlotConfig=
{
[FULL_TAB_TYPE.eOtherDiscipleInfo]={

wins={'UIOtherDiscipleInfoWin_SystemZongMen',},
},
[FULL_TAB_TYPE.eOtherDiscipleAttr]={

wins={'UIOtherDiscipleAttrWin_SystemZongMen'},
},
}
local maxScrollNum=5
local _this=nil

local _CMP_INDEX={
cmpSelfItem=0,
cmpNomalIcon=1,
cmpReddot=2,
}
local body_id={
back=2072,
menu=2017,
}
local menu_slot_name='button_dytab'

local _scrollLen=4


function UIOtherDiscipleMainWin_SystemZongMen:onLoaded(...)
self:bindComponents()
_this=self
self._on_select_dis=function(...)
self:on_select_dis(...)
end
self.discipleListPanel:setClickAction(self._on_select_dis)
self.isInitDiscipleList=false
notifySystem:listenNotify(notifyConfig.onTestModelChange,self.onTestModelChange)

self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)

local pagelist={}
for tabType,v in pairsBySortKey(PageSlotConfig)do
table.insert(pagelist,{tabType,v})
end
self.pagelist=pagelist
self.showMenuNum=#pagelist


self:showCopyBtn()
end


function UIOtherDiscipleMainWin_SystemZongMen:__delete()
_this=nil
self.scrollView:setClickAction(nil)
self:unbindComponents()
self.isInitDiscipleList=false
self:closeAllWin()
self:clearMenuTweener()
notifySystem:removelistener(notifyConfig.onTestModelChange,self.onTestModelChange)
end

function UIOtherDiscipleMainWin_SystemZongMen.onTestModelChange(flag)
if _this==nil then return end

_this:showCopyBtn()
end

function UIOtherDiscipleMainWin_SystemZongMen:showCopyBtn()
local show=false



show=show and playerController.testModel
self.copyBtn:setActive(show)
end




function UIOtherDiscipleMainWin_SystemZongMen:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.dis_guid
self.curDisIndex=nil
self.tabType=argtable.tabType or FULL_TAB_TYPE.eOtherDiscipleInfo
for i,page in ipairs(self.pagelist)do
if page[1]==self.tabType then
self.selectMenuIdx=i
break
end
end

self.dislist=argtable.dislist

if self.disciple_guid~=nil then
for i,dzData in ipairs(self.dislist)do
if mathHelper.compareInt64(dzData.discipleguid,self.disciple_guid)then
self.curDisIndex=i
break
end
end
end
if self.curDisIndex==nil then
self.curDisIndex=1
self.disciple_guid=self.dislist[self.curDisIndex].base.discipleguid
end

self:refreshWin()
if not self.isInitDiscipleList then
self.isInitDiscipleList=true
self:refreshDiscipleList()
end

self:freshMenuList()
local isfirst=afterOnloaded
local cb=nil
if isfirst then
self.animLock1=true
cb=function()
self:onLoadFinish()
end
end
self.back:setChildUIModelShowTarget(body_id.back,1,{},eAnimationID.common_window_enter,false,false,0,cb)
if not isfirst then
self:onLoadFinish()
end
end

function UIOtherDiscipleMainWin_SystemZongMen:onLoadFinish()
self.animLock1=nil
self:clearMenuTweener()
self.menuAnimGrid:setChildCanvasGroupAlpha(0)
self.menulist:setChildCanvasGroupAlpha(0)

local func=function()
self.menuAnimGrid:setChildCanvasGroupAlpha(1)
local selectMenuIdx=self.selectMenuIdx
for i,v in ipairs(self.menu_anim)do
local isshow=i<=self.showMenuNum
local anim=self.menu_anim[i]
local func2=function()

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,selectMenuIdx==i and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
anim:setChildUIModelShowTarget(body_id.menu,1,{},eAnimationID.common_window_enter,false,false,0,func2)
anim:setActive(isshow)
end
end
self:delayDo(0.1,func)
self.animLock1=true
local func1=function()
self.animLock1=nil
self.menulist:setChildCanvasGroupAlpha(0)
local fun3=function()
self.menuTweener=nil
end
self.menuTweener=self.menulist:setChildCanvasGroupDOFade(1,1,fun3)
end
self:delayDo(0.4,func1)
end

function UIOtherDiscipleMainWin_SystemZongMen:clearMenuTweener()
if self.menuTweener~=nil then
self.menuTweener:Complete()
self.menuTweener=nil
end
end

function UIOtherDiscipleMainWin_SystemZongMen:onClickClose()
if self.animLock1==true then return end
self:closeSelf()
end

function UIOtherDiscipleMainWin_SystemZongMen:freshMenuList()
local tNum=self.showMenuNum

self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),tNum>_scrollLen)
self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i,page in ipairs(self.pagelist)do
self:fillMenu(i,page[1],page[2])
end
end

function UIOtherDiscipleMainWin_SystemZongMen:fillMenu(index,tabType,config)
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local selectMenuIdx=self.selectMenuIdx

local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
local anim=self.menu_anim[index]

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,selectMenuIdx==index and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))

item:SetChildActive(_CMP_INDEX.cmpReddot,false)
end

function UIOtherDiscipleMainWin_SystemZongMen:freshMenuSelect(index,is_select)
if index==nil then
return
end
local selectMenuIdx=self.selectMenuIdx
local item=self.winlua:GetChildCSGUIBaseItem(index-1)
local anim=self.menu_anim[index]
if is_select then
anim:setChildModelAnimationState(eAnimationID.common_window_dianji)
end

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,is_select and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIOtherDiscipleMainWin_SystemZongMen:on_click_callback(id,index,guid,attach)
if self.animLock1==true then return end
if index==self.selectMenuIdx then
return
end

local page=self.pagelist[index]
local tabType=page[1]
if not fullScreenModel.checkTabEnoughCND(tabType,true)then return end
self:freshMenuSelect(self.selectMenuIdx,false)
self:freshMenuSelect(index,true)
self.selectMenuIdx=index

self:onShowArgRecv({tabType=tabType})
end

function UIOtherDiscipleMainWin_SystemZongMen:getTabType()
return self.tabType
end

function UIOtherDiscipleMainWin_SystemZongMen:onShowArgRecv(argtable)
self.tabType=argtable.tabType
self:refreshWin()
end

function UIOtherDiscipleMainWin_SystemZongMen:refreshWin()
local show_wins={}
local close_wins={}
local cur=PageSlotConfig[self.tabType]
local cur_wins=cur.wins
if cur_wins and#cur_wins>0 then
for i,v in ipairs(cur_wins)do
show_wins[v]=true
end
end
if self.activeWin~=nil then
for k,v in pairs(self.activeWin)do
if v==true and show_wins[k]==nil then
close_wins[k]=true
end
end

for k,v in pairs(close_wins)do
UIManager:hideWindow(k)
self.activeWin[k]=false
end
end

if self.activeWin==nil then
self.activeWin={}
end
if cur_wins and#cur_wins>0 then
for i,v in ipairs(cur_wins)do
local args={guid=self.disciple_guid,data=self.dislist[self.curDisIndex]}
if self.activeWin[v]then
local win=UIManager:findActiveWindow(v)
if win then
win:onShow(args)
else
UIManager:showWindowImp(v,args)
end
else
UIManager:showWindowImp(v,args)
self.activeWin[v]=true
end
end
end
end

function UIOtherDiscipleMainWin_SystemZongMen:closeAllWin()
if self.activeWin~=nil then
for k,v in pairs(self.activeWin)do
UIManager:closeWindow(k)
end
self.activeWin=nil
end
end

function UIOtherDiscipleMainWin_SystemZongMen:refreshDiscipleList()
local tNum=#self.dislist

self.discipleListPanel:freshGridsNum(tNum,tNum,1,true)
local idx=1
for i=1,tNum do
local item=self.discipleListPanel:getGridObjectByindex(i-1)
local dzData=self.dislist[i]
local discipleguid=dzData.discipleguid
local image=UIDiscipleModel.calculationDiscipleImageBase(dzData)



comHelper.setChildModelHeadIconBGByColor(item,0,image.color)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,item,modelParams,eHeadCenterType.eHead,nil,false)

local isSelect=mathHelper.compareInt64(self.disciple_guid,discipleguid)
if isSelect then
idx=i
self.curDisIndex=idx
end
self:changItemSelect(item,isSelect)

end
self.discipleListPanel:jumpToLockX(idx)
end

function UIOtherDiscipleMainWin_SystemZongMen:changItemSelect(item,isSelect)
item:SetChildActive(3,isSelect)
end

function UIOtherDiscipleMainWin_SystemZongMen:on_select_dis(id,index,guid,attach)
if self.curDisIndex==index then return end

local old=self.curDisIndex
self.curDisIndex=index
if old then
local olditem=self.discipleListPanel:getGridObjectByindex(old-1)
self:changItemSelect(olditem,false)
end
local item=self.discipleListPanel:getGridObjectByindex(self.curDisIndex-1)
self:changItemSelect(item,true)

local dzData=self.dislist[self.curDisIndex]
self.disciple_guid=dzData.discipleguid
if self.activeWin~=nil then
for k,v in pairs(self.activeWin)do
if v==true then
local win=UIManager:findActiveWindow(k)
if win and win.onChangeDisciple then
win:onChangeDisciple(dzData.discipleguid,dzData)
end
end
end
end
end

function UIOtherDiscipleMainWin_SystemZongMen:onCopyBtn()
local dzData=self.dislist[self.curDisIndex]
WriteInCopyBuffer(tostring(dzData.discipleguid))
end

function UIOtherDiscipleMainWin_SystemZongMen:getDiscipleList()
return self.dislist
end
