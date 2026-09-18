







def_class("UIDiscipleyujuTipsWin",UIWindowBase)









function UIDiscipleyujuTipsWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.skillItem=UIObject.get(self,2)
self.title1=UIObject.get(self,3)
self.yuxianDesc=UIObject.get(self,4)
self.title2=UIObject.get(self,5)
self.upgradeCondition=UIObject.get(self,6)
self.title3=UIObject.get(self,7)
self.extra=UIObject.get(self,8)
self.coolDown1=UIObject.get(self,9)
self.coolDown2=UIObject.get(self,10)
self.coolDown3=UIObject.get(self,11)
self.coolDown4=UIObject.get(self,12)
self.coolDown5=UIObject.get(self,13)
self.skillCoolDownTxt1=UIText.get(self,14)
self.skillCoolDownTxt2=UIText.get(self,15)
self.skillCoolDownTxt3=UIText.get(self,16)
self.skillCoolDownTxt4=UIText.get(self,17)
self.skillCoolDownTxt5=UIText.get(self,18)
self.Image1=UIImage.get(self,19)
self.Image2=UIImage.get(self,20)
self.Image3=UIImage.get(self,21)
self.Image4=UIImage.get(self,22)
self.Image5=UIImage.get(self,23)
self.titlename=UIText.get(self,24)
self.yugouDesc=UIObject.get(self,25)
self.coolDowng1=UIObject.get(self,26)
self.coolDowng2=UIObject.get(self,27)
self.coolDowng3=UIObject.get(self,28)
self.coolDowng4=UIObject.get(self,29)
self.coolDowng5=UIObject.get(self,30)
self.coolDowng6=UIObject.get(self,31)
self.coolDowng7=UIObject.get(self,32)
self.coolDowng8=UIObject.get(self,33)
self.coolDowng9=UIObject.get(self,34)
self.coolDowng10=UIObject.get(self,35)
self.coolDowng11=UIObject.get(self,36)
self.coolDowng12=UIObject.get(self,37)
self.skillCoolDownTxtg1=UIText.get(self,38)
self.skillCoolDownTxtg2=UIText.get(self,39)
self.skillCoolDownTxtg3=UIText.get(self,40)
self.skillCoolDownTxtg4=UIText.get(self,41)
self.skillCoolDownTxtg5=UIText.get(self,42)
self.skillCoolDownTxtg6=UIText.get(self,43)
self.skillCoolDownTxtg7=UIText.get(self,44)
self.skillCoolDownTxtg8=UIText.get(self,45)
self.skillCoolDownTxtg9=UIText.get(self,46)
self.skillCoolDownTxtg10=UIText.get(self,47)
self.skillCoolDownTxtg11=UIText.get(self,48)
self.skillCoolDownTxtg12=UIText.get(self,49)
self.Imageg1=UIImage.get(self,50)
self.Imageg3=UIImage.get(self,51)
self.Imageg5=UIImage.get(self,52)
self.Imageg7=UIImage.get(self,53)
self.Imageg9=UIImage.get(self,54)
self.Imageg11=UIImage.get(self,55)



end


function UIDiscipleyujuTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.yuxianDesc);self.yuxianDesc=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.upgradeCondition);self.upgradeCondition=nil;
_UIObject_release(self.title3);self.title3=nil;
_UIObject_release(self.extra);self.extra=nil;
_UIObject_release(self.coolDown1);self.coolDown1=nil;
_UIObject_release(self.coolDown2);self.coolDown2=nil;
_UIObject_release(self.coolDown3);self.coolDown3=nil;
_UIObject_release(self.coolDown4);self.coolDown4=nil;
_UIObject_release(self.coolDown5);self.coolDown5=nil;
_UIObject_release(self.skillCoolDownTxt1);self.skillCoolDownTxt1=nil;
_UIObject_release(self.skillCoolDownTxt2);self.skillCoolDownTxt2=nil;
_UIObject_release(self.skillCoolDownTxt3);self.skillCoolDownTxt3=nil;
_UIObject_release(self.skillCoolDownTxt4);self.skillCoolDownTxt4=nil;
_UIObject_release(self.skillCoolDownTxt5);self.skillCoolDownTxt5=nil;
_UIObject_release(self.Image1);self.Image1=nil;
_UIObject_release(self.Image2);self.Image2=nil;
_UIObject_release(self.Image3);self.Image3=nil;
_UIObject_release(self.Image4);self.Image4=nil;
_UIObject_release(self.Image5);self.Image5=nil;
_UIObject_release(self.titlename);self.titlename=nil;
_UIObject_release(self.yugouDesc);self.yugouDesc=nil;
_UIObject_release(self.coolDowng1);self.coolDowng1=nil;
_UIObject_release(self.coolDowng2);self.coolDowng2=nil;
_UIObject_release(self.coolDowng3);self.coolDowng3=nil;
_UIObject_release(self.coolDowng4);self.coolDowng4=nil;
_UIObject_release(self.coolDowng5);self.coolDowng5=nil;
_UIObject_release(self.coolDowng6);self.coolDowng6=nil;
_UIObject_release(self.coolDowng7);self.coolDowng7=nil;
_UIObject_release(self.coolDowng8);self.coolDowng8=nil;
_UIObject_release(self.coolDowng9);self.coolDowng9=nil;
_UIObject_release(self.coolDowng10);self.coolDowng10=nil;
_UIObject_release(self.coolDowng11);self.coolDowng11=nil;
_UIObject_release(self.coolDowng12);self.coolDowng12=nil;
_UIObject_release(self.skillCoolDownTxtg1);self.skillCoolDownTxtg1=nil;
_UIObject_release(self.skillCoolDownTxtg2);self.skillCoolDownTxtg2=nil;
_UIObject_release(self.skillCoolDownTxtg3);self.skillCoolDownTxtg3=nil;
_UIObject_release(self.skillCoolDownTxtg4);self.skillCoolDownTxtg4=nil;
_UIObject_release(self.skillCoolDownTxtg5);self.skillCoolDownTxtg5=nil;
_UIObject_release(self.skillCoolDownTxtg6);self.skillCoolDownTxtg6=nil;
_UIObject_release(self.skillCoolDownTxtg7);self.skillCoolDownTxtg7=nil;
_UIObject_release(self.skillCoolDownTxtg8);self.skillCoolDownTxtg8=nil;
_UIObject_release(self.skillCoolDownTxtg9);self.skillCoolDownTxtg9=nil;
_UIObject_release(self.skillCoolDownTxtg10);self.skillCoolDownTxtg10=nil;
_UIObject_release(self.skillCoolDownTxtg11);self.skillCoolDownTxtg11=nil;
_UIObject_release(self.skillCoolDownTxtg12);self.skillCoolDownTxtg12=nil;
_UIObject_release(self.Imageg1);self.Imageg1=nil;
_UIObject_release(self.Imageg3);self.Imageg3=nil;
_UIObject_release(self.Imageg5);self.Imageg5=nil;
_UIObject_release(self.Imageg7);self.Imageg7=nil;
_UIObject_release(self.Imageg9);self.Imageg9=nil;
_UIObject_release(self.Imageg11);self.Imageg11=nil;
end



















local _this
local abname_='ui/sharedtextures/uiglobalspriteatlas_1.ab'



function UIDiscipleyujuTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleyujuTipsWin:__delete()
self:unbindComponents()
end


function UIDiscipleyujuTipsWin:onHide()

end




function UIDiscipleyujuTipsWin:onShow(argtable,afterOnloaded)



















local index=argtable[1]
local isinit=true
if isinit then
self.root:setChildCanvasGroupAlpha(0)


self.root:setChildCanvasGroupDOFade(1,0.3,nil)
self.blackImg:setChildCanvasGroupAlpha(0)

end
self:refreshSkillView(index)
end


function UIDiscipleyujuTipsWin:onHide()

end




function UIDiscipleyujuTipsWin:refreshSkillView(index)




if index==3 then
_this.titlename:setText('鱼线详情')
_this.yuxianDesc:setActive(true)
_this.winlua:SetChildAnchoredPos(1,116,102)

local level=YiYuHuiYouModel:getYxLevel()or 1
local cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yuxian)

local img={_this.Image1,_this.Image2,_this.Image3,_this.Image4,_this.Image5}
local item={_this.coolDown1,_this.coolDown2,_this.coolDown3,_this.coolDown4,_this.coolDown5}
local test={_this.skillCoolDownTxt1,_this.skillCoolDownTxt2,_this.skillCoolDownTxt3,_this.skillCoolDownTxt4,_this.skillCoolDownTxt5}

for i=1,#item do
if cfg[i]then
item[i]:setActive(true)

local color=level>=i and'#00FF06'or'#FFFFFF'
local str=FMT.fmt('<color={0}>{1}：{2}</color>',color,cfg[i].yj_name,cfg[i].yj_xiaoguo)

if level>=i then
_this.winlua:SetChildCSImageSprite(img[i]:getID(),abname_,'image_tipsty_4')
else
_this.winlua:SetChildCSImageSprite(img[i]:getID(),abname_,'image_tipsty_1')
end
test[i]:setText(str or'无')

else
item[i]:setActive(false)
end
end
end


if index==1 then
_this.titlename:setText('鱼竿详情')
_this.yuxianDesc:setActive(true)
_this.winlua:SetChildAnchoredPos(1,116,139)

local level=YiYuHuiYouModel:getYgLevel()or 1
local cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yugan)

local img={_this.Image1,_this.Image2,_this.Image3,_this.Image4,_this.Image5}
local item={_this.coolDown1,_this.coolDown2,_this.coolDown3,_this.coolDown4,_this.coolDown5}
local test={_this.skillCoolDownTxt1,_this.skillCoolDownTxt2,_this.skillCoolDownTxt3,_this.skillCoolDownTxt4,_this.skillCoolDownTxt5}


for i=1,#item do

if cfg[i]then
item[i]:setActive(true)

local color=level>=i and'#00FF06'or'#FFFFFF'
local str=FMT.fmt('<color={0}>{1}：{2}</color>',color,cfg[i].yj_name,cfg[i].yj_xiaoguo)

if level>=i then
_this.winlua:SetChildCSImageSprite(img[i]:getID(),abname_,'image_tipsty_4')
else
_this.winlua:SetChildCSImageSprite(img[i]:getID(),abname_,'image_tipsty_1')
end
test[i]:setText(str or'无')

else
item[i]:setActive(false)
end
end
end



if index==2 then
_this.titlename:setText('鱼钩详情')
_this.yugouDesc:setActive(true)
_this.winlua:SetChildAnchoredPos(1,116,169)

local img={_this.Imageg1,_this.Imageg3,_this.Imageg5,_this.Imageg7,_this.Imageg9}
local item={_this.coolDowng1,_this.coolDowng2,_this.coolDowng3,_this.coolDowng4,_this.coolDowng5,_this.coolDowng6,
_this.coolDowng7,_this.coolDowng8,_this.coolDowng9,_this.coolDowng10}
local test={_this.skillCoolDownTxtg1,_this.skillCoolDownTxtg2,_this.skillCoolDownTxtg3,
_this.skillCoolDownTxtg4,_this.skillCoolDownTxtg5,_this.skillCoolDownTxtg6,
_this.skillCoolDownTxtg7,_this.skillCoolDownTxtg8,_this.skillCoolDownTxtg9,
_this.skillCoolDownTxtg10}

local itemname={_this.coolDowng1,_this.coolDowng3,_this.coolDowng5,_this.coolDowng7,_this.coolDowng9}
local itemxiaoguo={_this.coolDowng2,_this.coolDowng4,_this.coolDowng6,_this.coolDowng8,_this.coolDowng10}
local testname={_this.skillCoolDownTxtg1,_this.skillCoolDownTxtg3,
_this.skillCoolDownTxtg5,_this.skillCoolDownTxtg7,
_this.skillCoolDownTxtg9,}
local testxiaoguo={_this.skillCoolDownTxtg2,_this.skillCoolDownTxtg4,
_this.skillCoolDownTxtg6,_this.skillCoolDownTxtg8,
_this.skillCoolDownTxtg10,}


local level=YiYuHuiYouModel:getYwLevel()or 1
local cfg=cfg_yiyuhuiyouyujuconfig_get(YYHYYuJuState.yugou)


for i=1,#cfg do
local color=level>=i and'#00FF06'or'#FFFFFF'
local str=FMT.fmt('<color={0}>{1}：{2}</color>',color,cfg[i].yj_name,cfg[i].yj_xiaoguo)
testname[i]:setText(str or'无')
itemname[i]:setActive(true)



local temp=cfg[i].tips
if temp then
local strxiaoguo=FMT.fmt('<color={0}>领悟渔技：{1}</color>',color,temp)
testxiaoguo[i]:setText(strxiaoguo or'无')
itemxiaoguo[i]:setActive(true)
end


if level>=i then
_this.winlua:SetChildCSImageSprite(img[i]:getID(),abname_,'image_tipsty_4')
else
_this.winlua:SetChildCSImageSprite(img[i]:getID(),abname_,'image_tipsty_1')
end
end
end

end
