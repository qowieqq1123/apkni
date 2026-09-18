







def_class("UIDiscipleZhiShengUpWin",UIWindowBase)









function UIDiscipleZhiShengUpWin:bindComponents()

self.root=UIObject.get(self,0)
self.titleBack=UIObject.get(self,1)
self.attrGrid=UIObject.get(self,2)
self.successEffect=UIObject.get(self,3)
self.arrowImg=UIObject.get(self,4)
self.imgbg2=UIObject.get(self,5)
self.mask=UIObject.get(self,6)
self.discipleModelRoot=UIObject.get(self,7)
self.titlepanel=UIObject.get(self,8)
self.text1=UIText.get(self,9)
self.text2=UIText.get(self,10)
self.nameimg=UIObject.get(self,11)
self.jobicon=UIImage.get(self,12)
self.diziname=UIText.get(self,13)
self.roleimg=UIObject.get(self,14)
self.spDzFlag=UIObject.get(self,15)



end


function UIDiscipleZhiShengUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.arrowImg);self.arrowImg=nil;
_UIObject_release(self.imgbg2);self.imgbg2=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.titlepanel);self.titlepanel=nil;
_UIObject_release(self.text1);self.text1=nil;
_UIObject_release(self.text2);self.text2=nil;
_UIObject_release(self.nameimg);self.nameimg=nil;
_UIObject_release(self.jobicon);self.jobicon=nil;
_UIObject_release(self.diziname);self.diziname=nil;
_UIObject_release(self.roleimg);self.roleimg=nil;
_UIObject_release(self.spDzFlag);self.spDzFlag=nil;
end

















local _this


function UIDiscipleZhiShengUpWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleZhiShengUpWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleZhiShengUpWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.disciple_guid
self.oldattrLookup=argtable.oldattrLookup
self.oldlevel=argtable.oldlevel


local pos=self.winlua:GetChildLocalPosition(self.mask:getID())
self.winlua:SetChildLocalPosX(self.mask:getID(),pos.x-123)
local pos2=self.winlua:GetChildLocalPosition(self.roleimg:getID())
self.winlua:SetChildLocalPosX(self.roleimg:getID(),pos.x-123)
self.discipleModelRoot:setChildUIModelRemoveTarget()
local args={isNotBg=true}
comHelper.setChildInSideModel(self.discipleModelRoot,self.disciple_guid,0.85,nil,0,0,false,false,nil,args)
self.winlua:SetChildDOLocalMoveX(self.mask:getID(),pos.x,0.3)
self.winlua:SetChildDOLocalMoveX(self.roleimg:getID(),pos2.x,0.3)


local jobicon=UIDiscipleModel:getJobIconNameX(self.disciple_guid)
self.jobicon:setSprite(globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(self.disciple_guid)
self.spDzFlag:setActive(isSpDz)

self.diziname:setText(UIDiscipleModel:getDiscipleName(self.disciple_guid))

local posnameimg=self.winlua:GetChildLocalPosition(self.nameimg:getID())
self.winlua:SetChildLocalPosX(self.nameimg:getID(),posnameimg.x-123)
self.winlua:SetChildDOLocalMoveX(self.nameimg:getID(),posnameimg.x,0.3)


local dizData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local jingJieLv=dizData.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jingJieLv)
local newstr=FMT.fmt('{0}{1}',n,pN)
self.text2:setText(newstr)
local _n,_p,_pN=UIDiscipleModel:getJJNameX(self.oldlevel)
local oldstr=FMT.fmt('{0}{1}',_n,_pN)
self.text1:setText(oldstr)


local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
local attrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(self.disciple_guid,false)
local attrlist=UIDiscipleModel.getAttrListByType(attrLookup,attrsBase,true,true)
local oldattrLookup=self.oldattrLookup or attrLookup
local oldattrlist=UIDiscipleModel.getAttrListByType(oldattrLookup,attrsBase,true,true)


self.titlepanel:setActive(false)
local attrNum=0
local gridlist=self.attrGrid:getChildCommonLayoutGroupWidgetList()
local c=gridlist.Count
for i=1,5 do
local item=gridlist[i-1]
local attr=attrlist[i]
local oldattr=oldattrlist[i]
local show=attr~=nil or i>c
item:SetChildActive(0,show)
if show then
attrNum=attrNum+1
local attrType=attr[1]
local attrValue=attr[2]
local oldattrValue=oldattr[2]
item:SetChildText(1,helper.getAttributeStr(attrType,oldattrValue,nil,'{0}：       {1}'))
local isadd=true
item:SetChildActive(2,false)
item:SetChildActive(3,isadd)
if isadd then
item:SetChildText(3,helper.getAttributeStr(attrType,attrValue,nil,'{0}：       {1}'))
end
end
end
self.attrNum=attrNum
self.attrGrid:setActive(false)

self:doMyAnim()
end


function UIDiscipleZhiShengUpWin:doMyAnim()
local delay=0
self.titleBack:setScale(Vector3(2,2,2))
self.titleBack:setChildDOScale(1,0.15)
delay=delay+0.15


self.titlepanel:setActive(true)

self.winlua:SetChildLocalPosY(self.titlepanel:getID(),-400)
self:delayDo(delay,function()
self.winlua:SetChildActive(self.titlepanel:getID(),true)
self.winlua:SetChildDOLocalMoveY(self.titlepanel:getID(),78,0.2)
end)
delay=delay+0.1


self.arrowImg:setActive(true)
self.winlua:SetChildLocalPosY(self.arrowImg:getID(),-400)
self:delayDo(delay,function()
self.winlua:SetChildActive(self.arrowImg:getID(),true)
self.winlua:SetChildDOLocalMoveY(self.arrowImg:getID(),-8,0.2)
end)
delay=delay+0.1


self.attrGrid:setActive(true)
for i=1,self.attrNum do
local item=self.attrGrid:getChildCommonLayoutGroupWidgetItem(i-1)
item:SetChildActive(-1,false)
local pos=item:GetChildLocalPosition(-1)
item:SetChildLocalPosY(-1,pos.y-200)
self:delayDo(delay,function()
item:SetChildActive(-1,true)
item:SetChildDOLocalMoveY(-1,pos.y,0.2)
end)
delay=delay+0.1
end
end


function UIDiscipleZhiShengUpWin:myClose()
fullScreenUI.closeActiveUI(true)
end


function UIDiscipleZhiShengUpWin:onHide()

end



