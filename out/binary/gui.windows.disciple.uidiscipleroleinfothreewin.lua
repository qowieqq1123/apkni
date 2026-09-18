







def_class("UIDiscipleRoleInfoThreeWin",UIWindowBase)









function UIDiscipleRoleInfoThreeWin:bindComponents()

self.attrGrid=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.noteBtn=UIButton.get(self,2)

self.noteBtn:setButtonClick(function()self:onNoteBtn()end)



end


function UIDiscipleRoleInfoThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.noteBtn);self.noteBtn=nil;
end
















local _this=nil


function UIDiscipleRoleInfoThreeWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
self:addNotify(notifyConfig.onDiscipleAttrChange,self.onDiscipleAttrChange)
end


function UIDiscipleRoleInfoThreeWin:__delete()
_this=nil
self:unbindComponents()
end


function UIDiscipleRoleInfoThreeWin:onHide()

end

function UIDiscipleRoleInfoThreeWin.onDiscipleAttrChange(dis_guid,attrType)
if _this==nil then return end
if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then return end

_this:refreshAttrs()
end

function UIDiscipleRoleInfoThreeWin.onDiscipleStateChange(discipleguid,stateType,old,cur)
if _this==nil then return end
if _this.disciple_guid==discipleguid and stateType==DISCIPLE_STATE_TYPE.eChuiWei then
_this:refreshAttrs()
end
end




function UIDiscipleRoleInfoThreeWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)

self:refreshAttrs()
end

function UIDiscipleRoleInfoThreeWin:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end

function UIDiscipleRoleInfoThreeWin:refreshAttrs()
local injury=UIDiscipleModel:getDiscipleInjury(self.disciple_guid)

local lookup={}
local ratelist=eInjuryType:getAttrRate(injury)
if ratelist~=nil and#ratelist>0 then
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
if not dzSpecialitySpecialEffectController:getInjurpNotDownAttr(netData)then
for i,v in ipairs(ratelist)do
lookup[v[1]]=v[2]
end
end
end

local attrsShow=cfgHelper.getdef(cfg_attributesconfig,'attrsShow')

local attrlist=UIDiscipleModel:getDiscipleMultipleAttrListByType(self.disciple_guid,attrsShow,true)
self.attrGrid:setChildLayoutGroupCreateItems(#attrlist)
local gridlist=self.attrGrid:getChildLayoutGroupGridList()
local c=gridlist.Count
if c>0 then
for i=1,c do
local item=gridlist[i-1]
local attr=attrlist[i]
local attrType=attr[1]
local value=attr[2]
if value<0 then
value=0
end

local isred=false
local pre=helper.getAttrRelationShip(attrType)
if pre~=nil and lookup[pre]~=nil then
isred=true
end
local color_str
if isred then
color_str='<color=#7D3B17>{0}</color> <color=#c82c2c>{1}</color>'
else
color_str='<color=#7D3B17>{0}</color> {1}'
end
item:SetChildText(0,helper.getAttributeStr4(attrType,value,nil,color_str))
end
end

local showNote=true
if self.showType==dicipleType.eTemp then
showNote=false
end
self.noteBtn:setActive(showNote)
end

function UIDiscipleRoleInfoThreeWin:onDetailClick()
local args={}
args.titleName='详细属性'
args.pos=1
args.extraWin='UICommonAttrDetailWin'
local extraParams={}
extraParams.attrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(self.disciple_guid,false)
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIDiscipleRoleInfoThreeWin:onNoteBtn()
oneTabScreenController:openUI(SEC_FULL_TYPE.discipleSecondary,{guid=self.disciple_guid})
end