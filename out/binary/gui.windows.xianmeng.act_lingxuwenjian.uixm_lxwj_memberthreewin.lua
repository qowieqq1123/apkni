







def_class("UIXM_LXWJ_memberThreeWin",UIWindowBase)









function UIXM_LXWJ_memberThreeWin:bindComponents()

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


function UIXM_LXWJ_memberThreeWin:unbindComponents()
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


function UIXM_LXWJ_memberThreeWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_memberThreeWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_memberThreeWin:onHide()

end




function UIXM_LXWJ_memberThreeWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin

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

function UIXM_LXWJ_memberThreeWin:initMemberList()
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

function UIXM_LXWJ_memberThreeWin:initPosLookup()
self.posLookup={}
local cfgs=cfg_lingxuwenjianfazhenconfig()
for i,v in ipairs(cfgs)do
local cur,max=lingxuwenjianModel:getMyFaZhenManNum(v.id)
self.posLookup[v.id]={cur=cur,max=max,name=v.name}
end
end

function UIXM_LXWJ_memberThreeWin:refreshView()
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
item:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onClickHead(idx)
end)
end)
self.noItemTips:setActive(num<=0)
if num<=0 then
self.noItemTips:setText('暂无参与人员')
end
end

function UIXM_LXWJ_memberThreeWin:refreshItem(item,idx)
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
item:SetChildActive(6,hasPos)
end

function UIXM_LXWJ_memberThreeWin:onClickHead(idx)
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

function UIXM_LXWJ_memberThreeWin:refreshSortBtn()
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

function UIXM_LXWJ_memberThreeWin:onFightSortBtn()
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

function UIXM_LXWJ_memberThreeWin:onDefSortBtn()
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

function UIXM_LXWJ_memberThreeWin:onClickClose()
self.parentWin:onClickClose()
end

function UIXM_LXWJ_memberThreeWin:rec_fazhenChange()
self:initPosLookup()
self:refreshView()
end