







def_class("UIXM_LXWJ_memberFourWin",UIWindowBase)









function UIXM_LXWJ_memberFourWin:bindComponents()

self.root=UIObject.get(self,0)
self.selectObj=UIObject.get(self,1)
self.memberNumText=UIText.get(self,2)
self.noItemTips=UIText.get(self,3)
self.fightSortBtn=UIButton.get(self,4)
self.defSortBtn=UIButton.get(self,5)
self.fightSortIcon=UIImage.get(self,6)
self.defSortIcon=UIImage.get(self,7)
self.memberGridPanel=UIObject.get(self,8)
self.selectBlock=UIButton.get(self,9)
self.selectGridPanel=UIObject.get(self,10)

self.fightSortBtn:setButtonClick(function()self:onFightSortBtn()end)

self.defSortBtn:setButtonClick(function()self:onDefSortBtn()end)

self.selectBlock:setButtonClick(function()self:onSelectBlock()end)



end


function UIXM_LXWJ_memberFourWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectObj);self.selectObj=nil;
_UIObject_release(self.memberNumText);self.memberNumText=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.fightSortBtn);self.fightSortBtn=nil;
_UIObject_release(self.defSortBtn);self.defSortBtn=nil;
_UIObject_release(self.fightSortIcon);self.fightSortIcon=nil;
_UIObject_release(self.defSortIcon);self.defSortIcon=nil;
_UIObject_release(self.memberGridPanel);self.memberGridPanel=nil;
_UIObject_release(self.selectBlock);self.selectBlock=nil;
_UIObject_release(self.selectGridPanel);self.selectGridPanel=nil;
end
















local _this=nil


function UIXM_LXWJ_memberFourWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_memberFourWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_memberFourWin:onHide()

end




function UIXM_LXWJ_memberFourWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin

self.fightSortType=1

self.defSortType=0

self:refreshSortBtn()
self:initMemberList()
self:refreshView()
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.2,function()
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end

function UIXM_LXWJ_memberFourWin:initMemberList()
local list=lingxuwenjianModel:getMemberList1()
self.memberList={}
for i,data in ipairs(list)do
local zyData=lingxuwenjianModel:getMyPosData2(data.actorid)
if zyData~=nil then
local d={data=data}
table.insert(self.memberList,d)
end
end

local cur=#self.memberList
local max=lingxuwenjianModel:getAllZhenYanNum()
local num_str=FMT.fmt('防守人员：{0}/{1}',cur,max)
self.memberNumText:setText(num_str)
end

function UIXM_LXWJ_memberFourWin:refreshView()
self.memberList_sort={}
local num=0
if#self.memberList>0 then
for i,v in ipairs(self.memberList)do
table.insert(self.memberList_sort,v)
end

num=#self.memberList_sort
if num>1 then
if self.fightSortType>0 then
if self.fightSortType==1 then
table.sort(self.memberList_sort,function(a,b)
return a.data.fightValNum>b.data.fightValNum
end)
else
table.sort(self.memberList_sort,function(a,b)
return a.data.fightValNum<b.data.fightValNum
end)
end
elseif self.defSortType>0 then
if self.defSortType==1 then
table.sort(self.memberList_sort,function(a,b)
return a.data.defendwinrate>b.data.defendwinrate
end)
else
table.sort(self.memberList_sort,function(a,b)
return a.data.defendwinrate<b.data.defendwinrate
end)
end
end
end
end
self.memberGridPanel:setChildLayoutGroupCreateItems(num,function(idx)
if _this==nil then return end
local item=_this.memberGridPanel:getChildLayoutGroupGridItem(idx-1)
_this:refreshItem(item,idx)
item:SetChildButtonClick(4,function()
if _this==nil then return end
_this:onClickSelect(idx)
end)
item:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onClickSelect(idx)
end)
item:SetChildButtonClick(6,function()
if _this==nil then return end
_this:onClickHead(idx)
end)
end)
self.noItemTips:setActive(num<=0)
if num<=0 then
self.noItemTips:setText('暂无参与人员')
end
end

function UIXM_LXWJ_memberFourWin:refreshItem(item,idx)
if item==nil then
item=self.memberGridPanel:getChildLayoutGroupGridItem(idx-1)
end

local d=self.memberList_sort[idx]
local data=d.data

local headParams={iconInfo=data.iconInfo,scale=0.6}
playerController:setHeadIcon(item,0,headParams)

item:SetChildText(1,data.actorname)

item:SetChildText(2,mathHelper.formatNumber6(data.fightValNum,true))

local rate_str=FMT.fmt('{0}%',data.defendwinrate/100)
item:SetChildText(3,rate_str)

local zyData=lingxuwenjianModel:getWJTData2(0,data.actorid)
local has=zyData~=nil
item:SetChildActive(4,not has)
item:SetChildActive(5,has)

local icon
if has then
icon=FMT.fmt('image_canzhancs_{0}',zyData.lxwjkey)
end
local showIcon=icon~=nil
item:SetChildActive(7,showIcon)
if showIcon then
item:SetChildCSImageSprite(7,globalABLookup.lingxuwenjianicons,icon)
end
end

function UIXM_LXWJ_memberFourWin:onClickHead(idx)
local d=self.memberList_sort[idx]
local data=d.data
local callback=function(teamDzList_,other)
if _this==nil then return end
lingxuwenjianController:showOtherPlayerRivalInfo(teamDzList_)
end

local lxwjteamtype=2
local server_id=playerModel:getActorServerID()
local send_args={serverid=server_id,lxwjteamtype=lxwjteamtype}
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eLingXuWenJianDef2,data.actorid,send_args,callback,false,true)
end

function UIXM_LXWJ_memberFourWin:canSeleck(isWarning)
local check=false
local checkTime=false
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eStandby then
checkTime=true
elseif raceState==eLXWJ_State.eFight then
local fightState=lingxuwenjianModel:getFightState()
if fightState==eLXWJ_Fight_State.eFight then
checkTime=true
end
end
if checkTime then
local result=lingxuwenjianModel:checkBattleResult()
if result==nil then
check=true
end
end
if not check and isWarning then
UIManager.error('本轮已结束，无法进行成员安排')
end
return check
end

function UIXM_LXWJ_memberFourWin:onClickSelect(idx)
if not self:canSeleck(true)then
return
end

local d=self.memberList_sort[idx]
local data=d.data
local zyData=lingxuwenjianModel:getWJTData2(0,data.actorid)
if zyData~=nil then

local list={}
list[1]={0,zyData.lxwjkey,int64.new('0')}
lingxuwenjianController:reqSetup(list)
else
self:openSelect(idx)
end
end

function UIXM_LXWJ_memberFourWin:refreshSortBtn()
local fightIcon
local fightRot=0
if self.fightSortType==0 then
fightIcon='button_tykepailie'
else
fightIcon='button_tybukepailie'
if self.fightSortType==2 then
fightRot=180
end
end
self.fightSortIcon:setSprite(globalABLookup.global,fightIcon)
self.fightSortIcon:setRotation(0,0,fightRot)
local defIcon
local defRot=0
if self.defSortType==0 then
defIcon='button_tykepailie'
else
defIcon='button_tybukepailie'
if self.defSortType==2 then
defRot=180
end
end
self.defSortIcon:setSprite(globalABLookup.global,defIcon)
self.defSortIcon:setRotation(0,0,defRot)
end

function UIXM_LXWJ_memberFourWin:onFightSortBtn()
if self.fightSortType==0 then
self.fightSortType=1
elseif self.fightSortType==1 then
self.fightSortType=2
else
self.fightSortType=1
end
self.defSortType=0
self:refreshSortBtn()
self:refreshView()
end

function UIXM_LXWJ_memberFourWin:onDefSortBtn()
if self.defSortType==0 then
self.defSortType=1
elseif self.defSortType==1 then
self.defSortType=2
else
self.defSortType=1
end
self.fightSortType=0
self:refreshSortBtn()
self:refreshView()
end

function UIXM_LXWJ_memberFourWin:onClickClose()
self.parentWin:onClickClose()
end



function UIXM_LXWJ_memberFourWin:openSelect(idx)
self.selectObj:setActive(true)
self.curSelecIndex=idx
self.selectList={'第一轮','第二轮','第三轮'}
local num=#self.selectList
self.selectGridPanel:setChildLayoutGroupCreateItems(num,function(idx_)
if _this==nil then return end
local item=_this.selectGridPanel:getChildLayoutGroupGridItem(idx_-1)
_this:refreshSelectItem(item,idx_)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onClickSelectItem(idx_)
end)
end)

local memberItem=self.memberGridPanel:getChildLayoutGroupGridItem(idx-1)
local pos=memberItem:GetChildScreenPointToLocalPointRectangle(4)
self.selectGridPanel:setLocalPos(pos.x+50,pos.y+35,0)
end

function UIXM_LXWJ_memberFourWin:refreshSelectItem(item,idx)
if item==nil then
item=self.selectGridPanel:getChildLayoutGroupGridItem(idx-1)
end

local s_data=self.selectList[idx]

item:SetChildText(1,s_data)
end

function UIXM_LXWJ_memberFourWin:onClickSelectItem(idx)
if not self:canSeleck(true)then
self:onSelectBlock()
return
end

local zyData=lingxuwenjianModel:getWJTData(0,idx)
local d=self.memberList_sort[self.curSelecIndex]
local m_data=d.data
if zyData~=nil then

local cb=function()
if _this==nil then return end
_this.comfirmDialog=nil
local list={}
local zyData_=lingxuwenjianModel:getWJTData2(0,m_data.actorid)
if zyData_~=nil then
table.insert(list,{0,zyData_.lxwjkey,int64.new('0')})
end
table.insert(list,{0,idx,int64.new('0')})
table.insert(list,{0,idx,m_data.actorid})
lingxuwenjianController:reqSetup(list)
end
local cb2=function()
if _this==nil then return end
_this.comfirmDialog=nil
end
local content='本轮已有问剑成员，是否要替换成当前成员？'
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=cb,
cancelcallback=cb2,
closecallback=cb2,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else

local list={}
local zyData_=lingxuwenjianModel:getWJTData2(0,m_data.actorid)
if zyData_~=nil then
table.insert(list,{0,zyData_.lxwjkey,int64.new('0')})
end
table.insert(list,{0,idx,m_data.actorid})
lingxuwenjianController:reqSetup(list)
end
end

function UIXM_LXWJ_memberFourWin:onSelectBlock()
self.selectObj:setActive(false)
self.curSelecIndex=nil
self.selectList=nil
end



function UIXM_LXWJ_memberFourWin:rec_change()
if self.comfirmDialog then
self.comfirmDialog:hide()
self.comfirmDialog=nil
end
self:onSelectBlock()
self:refreshView()
end
