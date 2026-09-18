







def_class("UIDiZIGongLueWin",UIWindowBase)









function UIDiZIGongLueWin:bindComponents()

self.menuGridPanel=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.discipleList=UIScrollView.get(self,2)
self.instructionBtn=UIButton.get(self,3)
self.discipleModelRoot=UIObject.get(self,4)
self.discipleNameText=UIText.get(self,5)
self.discipleJobIcon=UIImage.get(self,6)
self.discipleJobIcon2=UIImage.get(self,7)
self.spBg=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.instructionBtn:setButtonClick(function()self:onInstructionBtn()end)



end


function UIDiZIGongLueWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.discipleList);self.discipleList=nil;
_UIObject_release(self.instructionBtn);self.instructionBtn=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
_UIObject_release(self.spBg);self.spBg=nil;
end
















local _this=nil
local pageConfig=
{
[1]={
page=1,
win='UIDiZIGongLueOneWin',
name='攻略',
},
[2]={
page=2,
win='UIDiZIGongLueTwoWin',
name='实力',
},
[3]={
page=3,
win='',
name='社区\n攻略',
hideFunc=function()
return not houtaiModel:isOpenGongLue()
end
},
}
local menu_slot_name='button_dytab'


function UIDiZIGongLueWin:onLoaded(...)
_this=self
self:bindComponents()
self._on_select_dis=function(...)
self:on_select_dis(...)
end
self.discipleList:setClickAction(self._on_select_dis)
self.winList={}
self.pageLookup={}

for i=#pageConfig,1,-1 do
if pageConfig[i].hideFunc and pageConfig[i].hideFunc()then
table.remove(pageConfig,i)
end
end
for i,v in ipairs(pageConfig)do
self.pageLookup[v.page]=i
end
end


function UIDiZIGongLueWin:__delete()
_this=nil
self:unbindComponents()
for win,v in pairs(self.winList)do
UIManager:closeWindow(win)
end
self.winList=nil
end


function UIDiZIGongLueWin:onHide()

end




function UIDiZIGongLueWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.dis_guid
self.disciplelist=argtable.disciplelist
self.curDisIndex=nil
if self.disciplelist==nil then
local sortType=UIDiscipleModel:getSaveSortType()
local sortCondition=UIDiscipleModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local list=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder)
self.disciplelist=list
end
if#self.disciplelist>0 then
if self.disciple_guid==nil then
self.curDisIndex=1
self.disciple_guid=self.disciplelist[self.curDisIndex].netData.net.discipleguid
else
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,self.disciple_guid)then
self.curDisIndex=i
break
end
end
end
end
if self.disciple_guid~=nil then
self:refreshDiscipleInfo()
else
self:closeSelf()
return
end
self:refreshDiscipleList()


local page=1
if argtable.page then
page=argtable.page
end
local idx=self.pageLookup[page]
if afterOnloaded then
local cnt=#pageConfig
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=pageConfig[i]
item:SetChildText(1,cfg.name)
local isSelected=i==idx
local func=function()
if _this==nil then return end
if isSelected then
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
self:refreshMenuItemSelect(item,i,isSelected)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)

item:SetChildNewBieComponentId(0,FMT.fmt('UIDiZIGongLueWin.menuGridPanel.page{0}',i))
end
end
self:onMenuItemClick(idx)
end



function UIDiZIGongLueWin:refreshDiscipleInfo()
local guid=self.disciple_guid
local netData=UIDiscipleModel:getDiscipleData(guid)

self.discipleNameText:setText(UIDiscipleModel:getDiscipleName(guid))

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(guid)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(isSPdz)
self.spBg:setActive(isSPdz)
if isSPdz then
local switchidx=1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(guid,switchidx)
self.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
self.discipleJobIcon:setChildAnchoredPos(-10,10)
local scale=54/68
self.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
end

self.discipleModelRoot:setChildUIModelRemoveTarget()
local args={bgFisrt=true}
comHelper.setChildInSideModel(self.discipleModelRoot,guid,0.85,nil,0,0,false,false,nil,args)
end

function UIDiZIGongLueWin:refreshDiscipleList()
local tNum=#self.disciplelist

self.discipleList:freshGridsNum(tNum,tNum,1,true)
for i=1,tNum do
local item=self.discipleList:getGridObjectByindex(i-1)
local netdata=self.disciplelist[i].netData.net
local discipleguid=netdata.discipleguid

comHelper.setChildModelHeadIconBG(item,0,discipleguid)

comHelper.setChildModelRawImage(item,discipleguid,1,0,eHeadCenterType.eHead)

local isSelect=self.curDisIndex==i
self:changItemSelect(item,i,isSelect)

item:SetChildActive(2,false)


item:SetChildActive(6,false)
end
self.discipleList:jumpToLockX(self.curDisIndex)
end

function UIDiZIGongLueWin:changItemSelect(item,idx,isSelect)
if item==nil then
item=self.discipleList:getGridObjectByindex(idx-1)
end
item:SetChildActive(3,isSelect)
end

function UIDiZIGongLueWin:on_select_dis(id,index,guid,attach)
if self.curDisIndex==index then return end

local old=self.curDisIndex
self.curDisIndex=index
if old then
self:changItemSelect(nil,old,false)
end
self:changItemSelect(nil,self.curDisIndex,true)

local netdata=self.disciplelist[self.curDisIndex].netData.net
local dis_guid=netdata.discipleguid
self.disciple_guid=dis_guid

self:refreshDiscipleInfo()
self:onChangeDisciple(dis_guid)
end

function UIDiZIGongLueWin:onChangeDisciple(dis_guid)
local winList=self.winList
if winList~=nil then
for k,v in pairs(winList)do
if v==true then
local name=k
if UIManager:isActive(name)then
local win=UIManager:findActiveWindow(name)
if win and win.onChangeDisciple then
win:onChangeDisciple(dis_guid)
end
end
end
end
end
end





function UIDiZIGongLueWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIDiZIGongLueWin:onMenuItemClick(idx)
local cfg=pageConfig[idx]
if cfg.page==3 then
local data=houtaiModel:getSheQuEnterData()
local jumpURL=data.jumpURL
local apiLevel=deviceHelper.getAPILevel()
if apiLevel<431 then
if deviceHelper.isRunIOS()and apiLevel>=400 then
platformSDK:reqOpenURL(jumpURL)
else
LuaApplication.GetApplication().OpenURL(jumpURL)
end
else

platformSDK:reqOpenCommunity(10003)
end
return
end
if cfg.page==self.curPage then
return
end
local old=self.curPage
self.curPage=cfg.page
if old~=nil then
local idx_=self.pageLookup[old]
self:refreshMenuItemSelect(nil,idx_,false)
end
self:refreshMenuItemSelect(nil,idx,true)
self:refreshMenuPage()
end

function UIDiZIGongLueWin:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=pageConfig[idx]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args={}
args.parentWin='UIDiZIGongLueWin'
args.page=self.curPage
args.dis_guid=self.disciple_guid
self:showWindow(win,args)
end
end



function UIDiZIGongLueWin:onCloseBtn()
self:closeSelf()
end

function UIDiZIGongLueWin:onInstructionBtn()
instructionbookController:jumpTo(INSTRUCTIONBOOK_JUMP_TYPE.eUIDiZIGongLueWin)
end
