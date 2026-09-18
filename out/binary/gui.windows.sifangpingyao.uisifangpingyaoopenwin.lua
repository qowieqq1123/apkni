







def_class("UISiFangPingYaoOpenWin",UIWindowBase)









function UISiFangPingYaoOpenWin:bindComponents()

self.model=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.titleimg=UIImage.get(self,2)
self.zhangimg=UIImage.get(self,3)
self.world=UIObject.get(self,4)
self.zhang=UIObject.get(self,5)



end


function UISiFangPingYaoOpenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleimg);self.titleimg=nil;
_UIObject_release(self.zhangimg);self.zhangimg=nil;
_UIObject_release(self.world);self.world=nil;
_UIObject_release(self.zhang);self.zhang=nil;
end
















local this
local abname="ui/windows/sifangpingyao/sifangpingyao_atlas_pak.ab"
local zhangjie=
{
[1]="image_sifanwenzi_06",
[2]="image_sifanwenzi_07",
[3]="image_sifanwenzi_08",
}
local worlds=
{
[1]={"image_sifangpingyao_ditu3",{-148,20},{229,164}},
[2]={"image_sifangpingyao_ditu2",{-148,10},{178,177}},
[3]={"image_sifangpingyao_ditu1",{-148,2},{179,218}},
[4]={"image_sifangpingyao_ditu4",{-151,-2},{219,176}},
[5]={"image_sifangpingyao_ditu5",{-146,0},{360,278}},
}




function UISiFangPingYaoOpenWin:onLoaded(...)
self:bindComponents()
this=self
end


function UISiFangPingYaoOpenWin:__delete()
local flag=self.flag
self:unbindComponents()


if flag==1 then
local isFirst=userActorSetting.get('sfpy_zhiyin_first',false)
if not isFirst then
local allygjd=SiFangPingYaoModel:getYGJingDuData()
if allygjd and#allygjd>0 then
else
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_BRANCH_LUA_FUNC_NAME.FirstTimeSiFangPingYaoLuaFunc)
end
userActorSetting.set('sfpy_zhiyin_first',true)
userActorSetting.flush()
end
elseif flag==2 then
local isFirst=userActorSetting.get('sfpy_zhiyin_first_zj',false)
if not isFirst then
local allygjd=SiFangPingYaoModel:getYGJingDuData()
if allygjd and#allygjd>0 then
else
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_BRANCH_LUA_FUNC_NAME.FirstTimeSiFangPingYaoZJLuaFunc)
end
userActorSetting.set('sfpy_zhiyin_first_zj',true)
userActorSetting.flush()
end
end
this=nil
end




function UISiFangPingYaoOpenWin:onShow(argtable,afterOnloaded)
self.flag=argtable.flag
self.infoidx=argtable.infoidx
self.infoidx2=argtable.infoidx2
self.ygcfg=cfg_foursideskilldemonsconfig()

self:showinfo(self.flag,self.infoidx,self.infoidx2)

self:delayDo(3,function()
self:closeSelf()
end)
end


function UISiFangPingYaoOpenWin:onHide()

end


function UISiFangPingYaoOpenWin:showinfo(flag,infoidx,infoidx2)
this.winlua:SetChildCanvasGroupAlpha(this.root:getID(),0)
if flag==1 then

this.world:setActive(true)

this.winlua:SetChildCSImageSprite(this.model:getID(),abname,worlds[infoidx][1])
this.winlua:SetChildLocalPosition(this.model:getID(),Vector3(worlds[infoidx][2][1],worlds[infoidx][2][2],0))
this.winlua:SetChildSizeDelta(this.model:getID(),worlds[infoidx][3][1],worlds[infoidx][3][2])
local strname=this.ygcfg[infoidx].ygimg[3]
this.winlua:SetChildCSImageSprite(this.titleimg:getID(),abname,strname)
this:delayDo(0.2,function()
if this==nil then return end
this.winlua:SetChildCanvasGroupDOFade(this.root:getID(),1,0.4)
end)
elseif flag==2 then

this.zhang:setActive(true)

this.winlua:SetChildCSImageSprite(this.model:getID(),abname,worlds[infoidx][1])
this.winlua:SetChildLocalPosition(this.model:getID(),Vector3(worlds[infoidx][2][1],worlds[infoidx][2][2],0))
this.winlua:SetChildSizeDelta(this.model:getID(),worlds[infoidx][3][1],worlds[infoidx][3][2])
this.winlua:SetChildCSImageSprite(this.zhangimg:getID(),abname,zhangjie[infoidx2])
this:delayDo(0.2,function()
if this==nil then return end
this.winlua:SetChildCanvasGroupDOFade(this.root:getID(),1,0.4)
end)
end
end