







def_class("UIXM_LXWJ_memberTwoWin",UIWindowBase)









function UIXM_LXWJ_memberTwoWin:bindComponents()

self.root=UIObject.get(self,0)
self.memberNumText=UIText.get(self,1)
self.noItemTips=UIText.get(self,2)
self.fightSortBtn=UIButton.get(self,3)
self.defSortBtn=UIButton.get(self,4)
self.fightSortIcon=UIImage.get(self,5)
self.defSortIcon=UIImage.get(self,6)
self.memberGridPanel=UIObject.get(self,7)

self.fightSortBtn:setButtonClick(function()self:onFightSortBtn()end)

self.defSortBtn:setButtonClick(function()self:onDefSortBtn()end)



end


function UIXM_LXWJ_memberTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.memberNumText);self.memberNumText=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.fightSortBtn);self.fightSortBtn=nil;
_UIObject_release(self.defSortBtn);self.defSortBtn=nil;
_UIObject_release(self.fightSortIcon);self.fightSortIcon=nil;
_UIObject_release(self.defSortIcon);self.defSortIcon=nil;
_UIObject_release(self.memberGridPanel);self.memberGridPanel=nil;
end
















local _this=nil


function UIXM_LXWJ_memberTwoWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_memberTwoWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_memberTwoWin:onHide()

end




function UIXM_LXWJ_memberTwoWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.fzid=argtable.fzid
self.zyid=argtable.zyid
local posData=lingxuwenjianModel:getMyPosData(self.fzid,self.zyid)
local actorid
if posData then
actorid=posData.actorid
end
self.cur_actorid=actorid


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

function UIXM_LXWJ_memberTwoWin:initMemberList()
local list=lingxuwenjianModel:getMemberList1()
self.memberList={}
for i,data in ipairs(list)do
local d={data=data}
local isCurrent=false
if self.cur_actorid~=nil then
isCurrent=mathHelper.compareInt64(self.cur_actorid,data.actorid)
end
d.isCurrent=isCurrent
self.memberList[i]=d
end

local lv=xianmengModel:getXMLevel()
local cur=#self.memberList
local max=xianmengModel.getXMMaxMemberNum(lv)
local num_str=FMT.fmt('参与人员：{0}/{1}',cur,max)
self.memberNumText:setText(num_str)
end

function UIXM_LXWJ_memberTwoWin:initPosLookup()
self.posLookup={}
local cfgs=cfg_lingxuwenjianfazhenconfig()
for i,v in ipairs(cfgs)do
local cur,max=lingxuwenjianModel:getMyFaZhenManNum(v.id)
self.posLookup[v.id]={cur=cur,max=max,name=v.name}
end
end

function UIXM_LXWJ_memberTwoWin:refreshView()
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
local isCurrent_a=a.isCurrent==true and 1 or 0
local isCurrent_b=b.isCurrent==true and 1 or 0
if isCurrent_a==isCurrent_b then
return a.data.fightValNum>b.data.fightValNum
else
return isCurrent_a>isCurrent_b
end
end)
else
table.sort(self.memberList_sort,function(a,b)
local isCurrent_a=a.isCurrent==true and 1 or 0
local isCurrent_b=b.isCurrent==true and 1 or 0
if isCurrent_a==isCurrent_b then
return a.data.fightValNum<b.data.fightValNum
else
return isCurrent_a>isCurrent_b
end
end)
end
elseif self.defSortType>0 then
if self.defSortType==1 then
table.sort(self.memberList_sort,function(a,b)
local isCurrent_a=a.isCurrent==true and 1 or 0
local isCurrent_b=b.isCurrent==true and 1 or 0
if isCurrent_a==isCurrent_b then
return a.data.defendwinrate>b.data.defendwinrate
else
return isCurrent_a>isCurrent_b
end
end)
else
table.sort(self.memberList_sort,function(a,b)
local isCurrent_a=a.isCurrent==true and 1 or 0
local isCurrent_b=b.isCurrent==true and 1 or 0
if isCurrent_a==isCurrent_b then
return a.data.defendwinrate<b.data.defendwinrate
else
return isCurrent_a>isCurrent_b
end
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

function UIXM_LXWJ_memberTwoWin:refreshItem(item,idx)
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
item:SetChildActive(8,hasPos)

local showSign=d.isCurrent
item:SetChildActive(7,showSign)
item:SetChildActive(5,not showSign)
end

function UIXM_LXWJ_memberTwoWin:onClickHead(idx)
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

function UIXM_LXWJ_memberTwoWin:onClickSelect(idx)
local raceState=lingxuwenjianModel:getLunState()
if raceState~=eLXWJ_State.eStandby then
UIManager.error('备战期间才可以派驻阵眼防守')
return
end

local d=self.memberList_sort[idx]
local data=d.data
local zyData=lingxuwenjianModel:getMyPosData2(data.actorid)
local list={}
if self.cur_actorid~=nil then
table.insert(list,{self.fzid,self.zyid,int64.new('0')})
end
if zyData~=nil then
table.insert(list,{zyData.lxwjtype,zyData.lxwjkey,int64.new('0')})
table.insert(list,{self.fzid,self.zyid,data.actorid})
local cb=function()
if _this==nil then return end
_this.comfirmDialog=nil
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
table.insert(list,{self.fzid,self.zyid,data.actorid})
lingxuwenjianController:reqSetup(list)
end
end

function UIXM_LXWJ_memberTwoWin:refreshSortBtn()
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

function UIXM_LXWJ_memberTwoWin:onFightSortBtn()
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

function UIXM_LXWJ_memberTwoWin:onDefSortBtn()
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

function UIXM_LXWJ_memberTwoWin:onClickClose()
self.parentWin:onClickClose()
end

function UIXM_LXWJ_memberTwoWin:rec_fazhenChange()
if self.comfirmDialog then
self.comfirmDialog:hide()
self.comfirmDialog=nil
end
local posData=lingxuwenjianModel:getMyPosData(self.fzid,self.zyid)
local actorid
if posData then
actorid=posData.actorid
end
if not mathHelper.compareInt64(actorid,self.cur_actorid)then
self.cur_actorid=actorid
end
self:initPosLookup()
self:refreshView()
end