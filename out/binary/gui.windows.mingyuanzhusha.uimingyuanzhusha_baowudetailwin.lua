







def_class("UIMingYuanZhuSha_BaoWuDetailWin",UIWindowBase)









function UIMingYuanZhuSha_BaoWuDetailWin:bindComponents()

self.centerLayout=UIObject.get(self,0)
self.noBaoWu=UIObject.get(self,1)
self.Root=UIObject.get(self,2)
self.scrollview=UIScrollView.get(self,3)
self.uiRoot=UIObject.get(self,4)



end


function UIMingYuanZhuSha_BaoWuDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.noBaoWu);self.noBaoWu=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local _itemCmpIndex={
icon=0,
name=1,
effectDesc=2,
gotBg=3,
gotTxt=4,
}





function UIMingYuanZhuSha_BaoWuDetailWin:onLoaded(...)
self:bindComponents()

_this=self

local _bindScollView=function(...)
if _this==nil then return end

_this:bindBwInfoitem(...)
end
self.scrollview:bindScrollWidget(_bindScollView)
end


function UIMingYuanZhuSha_BaoWuDetailWin:__delete()
_this=nil

self:unbindComponents()
end




function UIMingYuanZhuSha_BaoWuDetailWin:onShow(argtable,afterOnloaded)

self:refreshAll()

end


function UIMingYuanZhuSha_BaoWuDetailWin:onHide()

end

function UIMingYuanZhuSha_BaoWuDetailWin:refreshAll()
self:refreshBwScollView()
end

function UIMingYuanZhuSha_BaoWuDetailWin:refreshBwScollView()
local totalBwList,totalBwListLen=myzsModel:getTotalBwList()

self.totalBwList=totalBwList

self.scrollview:freshGridsNum(totalBwListLen,totalBwListLen,1,self.svZero)
self.svZero=true
if totalBwListLen==0 then
self.noBaoWu:setActive(true)
else
self.noBaoWu:setActive(false)
end
end

function UIMingYuanZhuSha_BaoWuDetailWin:bindBwInfoitem(index,item)
local data=self.totalBwList[index]

local bwId=data.param_1
local layer=data.param_2

local bwCfg=cfgHelper.get1(cfg_mingyuanzhushabaowuconfig_get,bwId)


item:SetChildIcon(_itemCmpIndex.icon,bwCfg.icon,true)


item:SetChildText(_itemCmpIndex.name,bwCfg.name)


local desc=skillModel:getSkillDesc(bwCfg.skill[1],bwCfg.skill[2])
item:SetChildText(_itemCmpIndex.effectDesc,desc)

local gotStr=FMT.fmt("第{0}重获得",layer)
item:SetChildText(_itemCmpIndex.gotTxt,gotStr)
end



