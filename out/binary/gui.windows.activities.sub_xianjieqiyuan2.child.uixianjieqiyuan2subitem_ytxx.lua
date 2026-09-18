







def_class("UIXianJieQiYuan2SubItem_YTXX",UICloneObject)





UIXianJieQiYuan2SubItem_YTXX.abName="ui/windows/activities/sub_xianjieqiyuan2/child/uixianjieqiyuan2subitem_ytxx.ab"

UIXianJieQiYuan2SubItem_YTXX.assetName="UIXianJieQiYuan2SubItem_YTXX"


function UIXianJieQiYuan2SubItem_YTXX:bindComponents()

self.bgImg=UIObject.get(self,0)
self.Stage772050=UIObject.get(self,1)
self.texiao_guaidan0=UIObject.get(self,2)
self.texiao_guaidan1=UIObject.get(self,3)
self.texiao_guaidan2=UIObject.get(self,4)
self.texiao_guaidan3=UIObject.get(self,5)
self.texiao_guaidan4=UIObject.get(self,6)
self.texiao_guaidan5=UIObject.get(self,7)
self.UICamera=UIObject.get(self,8)
self.texiao={
["guaidan0"]=self.texiao_guaidan0,
["guaidan1"]=self.texiao_guaidan1,
["guaidan2"]=self.texiao_guaidan2,
["guaidan3"]=self.texiao_guaidan3,
["guaidan4"]=self.texiao_guaidan4,
["guaidan5"]=self.texiao_guaidan5,
}

end


function UIXianJieQiYuan2SubItem_YTXX:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.Stage772050);self.Stage772050=nil;
_UIObject_release(self.texiao_guaidan0);self.texiao_guaidan0=nil;
_UIObject_release(self.texiao_guaidan1);self.texiao_guaidan1=nil;
_UIObject_release(self.texiao_guaidan2);self.texiao_guaidan2=nil;
_UIObject_release(self.texiao_guaidan3);self.texiao_guaidan3=nil;
_UIObject_release(self.texiao_guaidan4);self.texiao_guaidan4=nil;
_UIObject_release(self.texiao_guaidan5);self.texiao_guaidan5=nil;
_UIObject_release(self.UICamera);self.UICamera=nil;
self.texiao=nil;
end






local chouType=
{
one=1,
ten=2,
}

local _effectID_YTXX={
[eQualityColor.eWhite]=18046,
[eQualityColor.eGreen]=18046,
[eQualityColor.eBlue]=18046,
[eQualityColor.ePurple]=18047,
[eQualityColor.eOrange]=18048,
[eQualityColor.eRed]=18049,
[eQualityColor.ePink]=18049,
}

local _effectIDbaozha={
[eQualityColor.eWhite]=18042,
[eQualityColor.eGreen]=18042,
[eQualityColor.eBlue]=18042,
[eQualityColor.ePurple]=18043,
[eQualityColor.eOrange]=18044,
[eQualityColor.eRed]=18045,
[eQualityColor.ePink]=18045,
}




function UIXianJieQiYuan2SubItem_YTXX:onLoaded(...)
self:bindComponents()
end


function UIXianJieQiYuan2SubItem_YTXX:__delete()
self:unbindComponents()
end




function UIXianJieQiYuan2SubItem_YTXX:onShow(argtable,afterOnloaded)

end


function UIXianJieQiYuan2SubItem_YTXX:onHide()

end




function UIXianJieQiYuan2SubItem_YTXX:hideEffectRoot_ytxx()
for i,effect in pairs(self.texiao)do
if i~='guaidan0'then
effect:setActive(false)
end
end
end

function UIXianJieQiYuan2SubItem_YTXX:playResultAnim(parent,typo,colors,callback)
local firstEffect,firstEffectid,bloomEffectid

if typo==chouType.one then

self:hideEffectRoot_ytxx()
local effect=self.texiao["guaidan0"]
local curcolor=colors[1]
local effectid=_effectID_YTXX[curcolor]
firstEffectid=effectid
bloomEffectid=_effectIDbaozha[curcolor]
self.widget:SetChildShowEffect(effect:getID(),effectid,true)
firstEffect=effect
elseif typo==chouType.ten then

local index=1
for i,effect in pairs(self.texiao)do
effect:setActive(true)
local curcolor=colors[index]
local effectid=_effectID_YTXX[curcolor]
if index==1 then
bloomEffectid=_effectIDbaozha[curcolor]
firstEffectid=effectid
firstEffect=effect
end
index=index+1
self.widget:SetChildShowEffect(effect:getID(),effectid,true)

end
end

self.Stage772050:setAnimatorInteger('nStateID',2,true)
if callback then
callback(firstEffect,firstEffectid,bloomEffectid)
end
end

function UIXianJieQiYuan2SubItem_YTXX:resetResultAnim()
self.Stage772050:setAnimatorInteger('nStateID',1,true)
end