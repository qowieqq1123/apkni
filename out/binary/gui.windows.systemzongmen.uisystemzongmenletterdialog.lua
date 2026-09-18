







def_class("UISystemZongMenLetterDialog",UIWindowBase)









function UISystemZongMenLetterDialog:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.letterList=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISystemZongMenLetterDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.letterList);self.letterList=nil;
end















local _this=nil
local _letterCmp={
typeImg=0,
desc=1,
zmName=2,
time=3,
bgImg=4,
}
local _abName="ui/windows/systemzongmen/systemzongmen_atlas_pak.ab"
local _bgImageLib={
[systemZongMenRelationLetterType.eDeclareWar]="image_zhongmenA_22",
[systemZongMenRelationLetterType.eArmistice]="image_zhongmenA_23",
[systemZongMenRelationLetterType.eWarning]="image_zhongmenB23",
}
local _typeImageLib={
[systemZongMenRelationLetterType.eDeclareWar]="image_zhongmenB_20",
[systemZongMenRelationLetterType.eArmistice]="image_zhongmenB_21",
[systemZongMenRelationLetterType.eWarning]="image_zhongmenB_22",
}



function UISystemZongMenLetterDialog:onLoaded(...)
self:bindComponents()
_this=self
end


function UISystemZongMenLetterDialog:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenLetterDialog:onShow(argtable,afterOnloaded)
local letters=systemZongMenModel:getAllLetter()
table.sort(letters,function(a,b)
return a.time<b.time
end)
self.letterList:setChildLayoutGroupCreateItems(#letters,function(index)
local letterItem=self.letterList:getChildLayoutGroupGridItem(index-1)
local letterData=letters[index]
local infoData=systemZongMenModel:getInfoData(int64.new(letterData.serial))
letterItem:SetChildCSImageSprite(_letterCmp.typeImg,_abName,_typeImageLib[letterData.type])
letterItem:SetChildCSImageSprite(_letterCmp.bgImg,_abName,_bgImageLib[letterData.type])
local contentStr=cfgHelper.getlang(FMT.fmt("systemzongmen_letter_{0}",letterData.type))
letterItem:SetChildText(_letterCmp.desc,contentStr)
letterItem:SetChildText(_letterCmp.zmName,infoData and systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)or"不知名的宗门")
letterItem:SetChildText(_letterCmp.time,FMT.fmt("第{0}年",gameUtilityModel.getGameYearPass(letterData.time)))
end)
systemZongMenModel:clearAllLetter()

notifySystem:postNotify(notifyConfig.onSystemZMLetterChange,false)
end


function UISystemZongMenLetterDialog:onHide()

end





function UISystemZongMenLetterDialog:onCloseBtn()
self:closeSelf()
end

function UISystemZongMenLetterDialog:onBackground()
self:closeSelf()
end