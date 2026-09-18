







def_class("UIXM_LXWJ_memberOneWin",UIWindowBase)









function UIXM_LXWJ_memberOneWin:bindComponents()

self.root=UIObject.get(self,0)
self.selectObj=UIObject.get(self,1)
self.sortTypeDropdown=UIDropdown.get(self,2)
self.memberNumText=UIText.get(self,3)
self.noItemTips=UIText.get(self,4)
self.selectBlock=UIButton.get(self,5)
self.selectGridPanel=UIObject.get(self,6)
self.fightSortBtn=UIButton.get(self,7)
self.defSortBtn=UIButton.get(self,8)
self.memberGridPanel=UIObject.get(self,9)
self.fightSortIcon=UIImage.get(self,10)
self.defSortIcon=UIImage.get(self,11)

self.selectBlock:setButtonClick(function()self:onSelectBlock()end)

self.fightSortBtn:setButtonClick(function()self:onFightSortBtn()end)

self.defSortBtn:setButtonClick(function()self:onDefSortBtn()end)



end


function UIXM_LXWJ_memberOneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectObj);self.selectObj=nil;
_UIObject_release(self.sortTypeDropdown);self.sortTypeDropdown=nil;
_UIObject_release(self.memberNumText);self.memberNumText=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.selectBlock);self.selectBlock=nil;
_UIObject_release(self.selectGridPanel);self.selectGridPanel=nil;
_UIObject_release(self.fightSortBtn);self.fightSortBtn=nil;
_UIObject_release(self.defSortBtn);self.defSortBtn=nil;
_UIObject_release(self.memberGridPanel);self.memberGridPanel=nil;
_UIObject_release(self.fightSortIcon);self.fightSortIcon=nil;
_UIObject_release(self.defSortIcon);self.defSortIcon=nil;
end
















local _this=nil


function UIXM_LXWJ_memberOneWin:onLoaded(...)
_this=self
self:bindComponents()
self.sortTypeDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UIXM_LXWJ_memberOneWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_memberOneWin:onHide()

end




function UIXM_LXWJ_memberOneWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
local nameList={'全部'}
local cfgs=cfg_lingxuwenjianfazhenconfig()
for i,v in ipairs(cfgs)do
table.insert(nameList,v.name)
end
self.sortType=0
self.sortTypeDropdown:setOption(nameList)
self.sortTypeDropdown:setValue(self.sortType)

self.fightSortType=1

self.defSortType=0

self:refreshSortBtn()
self:initMemberList()
self:initPosLookup()
self:refreshView()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.2,function()
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end

function UIXM_LXWJ_memberOneWin:initMemberList()
local list=lingxuwenjianModel:getMemberList1()
self.memberList={}
for i,data in ipairs(list)do
local d={data=data}
self.memberList[i]=d
end

local lv=xianmengModel:getXMLevel()
local cur=#self.memberList
local max=xianmengModel.getXMMaxMemberNum(lv)
local num_str=FMT.fmt('参与人员：{0}/{1}',cur,max)
self.memberNumText:setText(num_str)
end

function UIXM_LXWJ_memberOneWin:initPosLookup()
self.posLookup={}
local cfgs=cfg_lingxuwenjianfazhenconfig()
for i,v in ipairs(cfgs)do
local cur,max=lingxuwenjianModel:getMyFaZhenManNum(v.id)
self.posLookup[v.id]={cur=cur,max=max,name=v.name}
end
end

function UIXM_LXWJ_memberOneWin:refreshView()
self.memberList_sort={}
local num=0
if#self.memberList>0 then
local fzid=self.sortType
for i,v in ipairs(self.memberList)do
local check=true
if fzid>0 then
if not lingxuwenjianModel:checkInMyPos(v.data.actorid,fzid)then
check=false
end
end
if check then
table.insert(self.memberList_sort,v)
end
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

function UIXM_LXWJ_memberOneWin:refreshItem(item,idx)
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

local pos_str
local hasPos=false
local zyData=lingxuwenjianModel:getMyPosData2(data.actorid)
if zyData~=nil then
hasPos=true
local fzid=zyData.lxwjtype
local lp=self.posLookup[fzid]
pos_str=lp.name
local isfull=lp.cur>=lp.max
if isfull then
pos_str=FMT.fmt('<color=#549327>{0}（{1}/{2}）</color>',pos_str,lp.cur,lp.max)
else
pos_str=FMT.fmt('<color=#c82c2c>{0}（{1}/{2}）</color>',pos_str,lp.cur,lp.max)
end
else
pos_str='无'
end
item:SetChildText(4,pos_str)
item:SetChildActive(7,hasPos)
end

function UIXM_LXWJ_memberOneWin:onClickHead(idx)
local d=self.memberList_sort[idx]
local data=d.data
local callback=function(teamDzList_,other)
if _this==nil then return end
lingxuwenjianController:showOtherPlayerRivalInfo(teamDzList_)
end

local lxwjteamtype=1
local server_id=playerModel:getActorServerID()
local send_args={serverid=server_id,lxwjteamtype=lxwjteamtype}
otherPlayerModel:reqActorDefTeams(otherPlayerInfoType.eLingXuWenJianDef2,data.actorid,send_args,callback,false,true)
end

function UIXM_LXWJ_memberOneWin:onClickSelect(idx)
local raceState=lingxuwenjianModel:getLunState()
if raceState~=eLXWJ_State.eStandby then
UIManager.error('备战期间才可以派驻阵眼防守')
return
end
self:openSelect(idx)
end

function UIXM_LXWJ_memberOneWin:onDropdownChange(idx)
self.sortType=idx
self:refreshView()
end

function UIXM_LXWJ_memberOneWin:refreshSortBtn()
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

function UIXM_LXWJ_memberOneWin:onFightSortBtn()
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

function UIXM_LXWJ_memberOneWin:onDefSortBtn()
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

function UIXM_LXWJ_memberOneWin:onClickClose()
self.parentWin:onClickClose()
end



function UIXM_LXWJ_memberOneWin:openSelect(idx)
self.selectObj:setActive(true)
self.curSelecIndex=idx
local d=self.memberList_sort[idx]
local data=d.data
local zyData=lingxuwenjianModel:getMyPosData2(data.actorid)
local fzid
local zyid
local selectData
if zyData then
fzid=zyData.lxwjtype
zyid=zyData.lxwjkey
selectData={fzid=fzid,zyid=zyid}
else
selectData={}
end
self.selectData=selectData
self.selectList={}
local cfgs=cfg_lingxuwenjianfazhenconfig()
for i,v in ipairs(cfgs)do
if fzid==nil or v.id~=fzid then
local lp_=self.posLookup[v.id]
local d={cur=lp_.cur,max=lp_.max,name=v.name,fzid=v.id}
table.insert(self.selectList,d)
end
end
if zyData~=nil then
local lp=self.posLookup[fzid]
local d={cur=lp.cur,max=lp.max,name=lp.name,fzid=fzid}
table.insert(self.selectList,d)
end
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
local pos=memberItem:GetChildScreenPointToLocalPointRectangle(5)
self.selectGridPanel:setLocalPos(pos.x+50,pos.y+35,0)
end

function UIXM_LXWJ_memberOneWin:refreshSelectItem(item,idx)
if item==nil then
item=self.selectGridPanel:getChildLayoutGroupGridItem(idx-1)
end

local s_data=self.selectList[idx]

local name_str
local bgicon
if s_data.fzid==self.selectData.fzid then
bgicon='button_chuangkou_8'
else
if s_data.cur>=s_data.max then
bgicon='button_chuangkou_7'
else
bgicon='button_chuangkou_1'
end
name_str=FMT.fmt('{0}({1}/{2})',s_data.name,s_data.cur,s_data.max)
end
item:SetChildCSImageSprite(0,globalABLookup.global,bgicon)
item:SetChildText(1,name_str or'')
item:SetChildActive(2,name_str==nil)
end

function UIXM_LXWJ_memberOneWin:onClickSelectItem(idx)
local raceState=lingxuwenjianModel:getLunState()
if raceState~=eLXWJ_State.eStandby then
UIManager.error('备战期间才可以派驻阵眼防守')
self:onSelectBlock()
return
end

local d=self.memberList_sort[self.curSelecIndex]
local m_data=d.data
local s_data=self.selectList[idx]
if s_data.fzid==self.selectData.fzid then

local list={}
list[1]={self.selectData.fzid,self.selectData.zyid,int64.new('0')}
lingxuwenjianController:reqSetup(list)
else
local f_zyid=nil
if s_data.cur<s_data.max then
f_zyid=lingxuwenjianModel:fingEmptyZhenYanID(s_data.fzid)
end
if f_zyid~=nil then
if self.selectData.fzid~=nil then

local cb=function()
if _this==nil then return end
_this.comfirmDialog=nil
local list={}
list[1]={_this.selectData.fzid,_this.selectData.zyid,int64.new('0')}
list[2]={s_data.fzid,f_zyid,m_data.actorid}
lingxuwenjianController:reqSetup(list)
end
local cb2=function()
if _this==nil then return end
_this.comfirmDialog=nil
end
local content='该成员已有防守阵眼，是否将其更换到当前阵眼进行防守？'
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
list[1]={s_data.fzid,f_zyid,m_data.actorid}
lingxuwenjianController:reqSetup(list)
end
else
UIManager.error('无法切换至该区域，防守成员已满。')
end
end
end

function UIXM_LXWJ_memberOneWin:onSelectBlock()
self.selectObj:setActive(false)
self.curSelecIndex=nil
self.selectData=nil
self.selectList=nil
end



function UIXM_LXWJ_memberOneWin:rec_fazhenChange()
if self.comfirmDialog then
self.comfirmDialog:hide()
self.comfirmDialog=nil
end
self:onSelectBlock()
self:initPosLookup()
self:refreshView()
end