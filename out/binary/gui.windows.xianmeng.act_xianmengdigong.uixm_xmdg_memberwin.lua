







def_class("UIXM_XMDG_MemberWin",UIWindowBase)









function UIXM_XMDG_MemberWin:bindComponents()

self.root=UIObject.get(self,0)
self.itemGridPanel=UIObject.get(self,1)



end


function UIXM_XMDG_MemberWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.itemGridPanel);self.itemGridPanel=nil;
end
















local _this=nil


function UIXM_XMDG_MemberWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_XMDG_MemberWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_XMDG_MemberWin:onHide()

end




function UIXM_XMDG_MemberWin:onShow(argtable,afterOnloaded)
local needNew=xianmengdigongModel:checkOpenMember()
local isshow=needNew==false
self.root:setActive(isshow)
if isshow then
self:refreshView()
end
end

function UIXM_XMDG_MemberWin:refreshView()
self.memberList=xianmengdigongModel:getDGMembersSort()
self.itemGridPanel:setChildLayoutGroupCreateItems(#self.memberList,function(idx)
if _this==nil then return end
_this:initGridItem(nil,idx)
end)
end

function UIXM_XMDG_MemberWin:initGridItem(item,idx)
if item==nil then
item=self.itemGridPanel:getChildLayoutGroupGridItem(idx-1)
end

local member=self.memberList[idx]

local headParams
local gxNum
if member.isself then
gxNum=member.gongXian
headParams={iconInfo=nil,scale=0.8}
else
gxNum=member.gongXian
headParams={iconInfo=member.iconInfo,scale=0.8}
end
playerController:setHeadIcon(item,1,headParams)

local postType=member.xmPos
local isleader=postType==GUILD_POST_TYPE.gpAllyLeader
local postName=xianmengModel.getXMPostName(postType,true)
item:SetChildText(5,postName)
item:SetChildActive(6,isleader)

item:SetChildText(2,member.name)

local name=moneyModel.getMoneyName(eMoneyType.mtDiGongContribute)
local icon=moneyModel.getIconNameEx(eMoneyType.mtDiGongContribute)
item:SetChildCSImageIcon(4,icon,true)
item:SetChildText(3,FMT.fmt('<color=#7d3b17>{0}：</color>{1}',name,gxNum))
end

function UIXM_XMDG_MemberWin:rec_members()
self.root:setActive(true)
self:refreshView()
end