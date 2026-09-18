







def_class("UISectPalacePostWin",UIWindowBase)









function UISectPalacePostWin:bindComponents()

self.poslistPanel=UIObject.get(self,0)
self.descText=UIText.get(self,1)



end


function UISectPalacePostWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.poslistPanel);self.poslistPanel=nil;
_UIObject_release(self.descText);self.descText=nil;
end

















function UISectPalacePostWin:onLoaded(...)
self:bindComponents()
end


function UISectPalacePostWin:__delete()
roleAudioController:stopRoleSpeak()
self:unbindComponents()
end


function UISectPalacePostWin:onHide()

end




function UISectPalacePostWin:onShow(argtable,afterOnloaded)

local entityID=argtable.entityID
self.sfId=mapIdType.zhufeng
self.bdData=zongmenModel:findBuildingByEntityId(entityID)

self:refreshPostList1()
self:refreshPostList2()
self:refreshPostList3()
self:refreshMoney()
end

function UISectPalacePostWin:refreshPostList1()

local widget1=self.poslistPanel:getChildCommonLayoutGroupWidgetItem(0)
self:refreshSlot(widget1:GetChildWidgetBase(0),eZongMenPostType.eZhangMen,1)

end

function UISectPalacePostWin:refreshPostList2()

local widget1=self.poslistPanel:getChildCommonLayoutGroupWidgetItem(0)
self:refreshSlot(widget1:GetChildCommonLayoutGroupWidgetItem(1,0),eZongMenPostType.eChuanGong,1)
self:refreshSlot(widget1:GetChildCommonLayoutGroupWidgetItem(1,1),eZongMenPostType.eJieYin,1)
self:refreshSlot(widget1:GetChildCommonLayoutGroupWidgetItem(1,2),eZongMenPostType.eJielu,1)
self:refreshSlot(widget1:GetChildCommonLayoutGroupWidgetItem(1,3),eZongMenPostType.eZhenYu,1)
end

function UISectPalacePostWin:refreshPostList3()

local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eNeiMen)or{}
local widget2=self.poslistPanel:getChildCommonLayoutGroupWidgetItem(1)
widget2:SetChildText(0,'内门弟子')
for i=1,10 do
self:refreshSlot2(widget2:GetChildCommonLayoutGroupWidgetItem(1,i-1),eZongMenPostType.eNeiMen,dis_list[i])
end
end

function UISectPalacePostWin:refreshSlot(slot,postType,idx)
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(postType)or{}
local netData=nil
if#dis_list>0 then
netData=dis_list[idx]
end
self:refreshSlot2(slot,postType,netData)
end

function UISectPalacePostWin:refreshSlot2(slot,postType,netData)
local dis_guid=nil
if netData~=nil then
dis_guid=netData.discipleguid
end
self:refreshSlotEx(slot,postType,dis_guid)
end

function UISectPalacePostWin:refreshSlotEx(slot,postType,dis_guid)
local has_dis=dis_guid~=nil

slot:SetChildText(3,eZongMenPostType.getName(postType))
slot:SetChildActive(4,has_dis)
slot:SetChildActive(5,not has_dis)

slot:SetChildActive(1,has_dis)
if has_dis then
slot:SetChildText(0,UIDiscipleModel:getDiscipleName(dis_guid)or'')



local scale=0.35
comHelper.setChildModelRawImage(slot,dis_guid,1,0,eHeadCenterType.eHead)
else
local isOpen,lockData=UIDiscipleModel.checkDisciplePostOpen(postType)
slot:SetChildActive(6,not isOpen)
local desc_str
if not isOpen then
if lockData[1]==1 then
desc_str=FMT.fmt(cfgHelper.getlang('sectpalace_tips_3'),lockData[2])
elseif lockData[1]==2 then
local name=cfgHelper.get2(cfg_monijybuildconfig_get,lockData[2],'name')
desc_str=FMT.fmt(cfgHelper.getlang('sectpalace_tips_5'),name)
end
else
desc_str='  ？？？'
end
slot:SetChildText(0,desc_str)
end

slot:SetChildButtonClick(-1,function()
self:onPostSlotClick(postType,dis_guid)
end)
end

function UISectPalacePostWin:refreshMoney()
local num=UISectPalaceModel:checkAllPostWages()
local str=FMT.fmt('<color=#7d3b17>宗门总俸禄：</color>{0}灵石/年\n<color=#65615f>（俸禄不足将降低弟子的忠诚度）</color>',num)
self.descText:setText(str)
end

function UISectPalacePostWin:onPostSlotClick(postType,dis_guid)
UIFullSectPalaceControl:showSectPalacePostInfo(postType,dis_guid,false)
end

function UISectPalacePostWin:onDetailsClick()
UIManager:showWindow('UISectPalacePostDetailsWin')
end

function UISectPalacePostWin:rec_changepost(dis_guid,postType)
self:doRefreshPostList(postType,dis_guid)
self:refreshMoney()
end

function UISectPalacePostWin:doRefreshPostList(postType,dis_guid)
if postType==eZongMenPostType.eZhangMen then
self:refreshPostList1()
elseif eZongMenPostType:isZhangLao(postType)then
self:refreshPostList2()
elseif postType==eZongMenPostType.eNeiMen then
self:refreshPostList3()
end
end