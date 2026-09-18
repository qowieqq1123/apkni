







def_class("UIDanLingSuccessWin",UIWindowBase)









function UIDanLingSuccessWin:bindComponents()

self.diziScrollView=UILoopListView.new(self,0)
self.effect=UIObject.get(self,1)
self.tips=UIText.get(self,2)
self.titleBack=UIObject.get(self,3)

self.diziScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIDanLingSuccessWin:unbindComponents()
local _UIObject_release=UIObject.release
self.diziScrollView:deleteSelf();self.diziScrollView=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
end



















function UIDanLingSuccessWin:onLoaded(...)
self:bindComponents()
self.effect:setChildShowEffect(10010,true)
end


function UIDanLingSuccessWin:__delete()
self:unbindComponents()
end




function UIDanLingSuccessWin:onShow(argtable,afterOnloaded)

self:refreshView()

end


function UIDanLingSuccessWin:onHide()

end

function UIDanLingSuccessWin:refreshView()
local discipleList=jctjDuJieXianDanModel:getDuJieJJUpDiziList()or{}
local createList={}
local length=#discipleList
for i=1,length,2 do
table.insert(createList,{discipleList[i],discipleList[i+1]})
end
self.discipleList=createList
self.diziScrollView:initData('item',createList)

end

function UIDanLingSuccessWin:onFreshAction(i,item)
local discipleData=self.discipleList[i]

local dizi1=discipleData[1]
local grid1=item:GetChildWidgetBase(0)
self:onFreshGrid(dizi1,grid1)

local dizi2=discipleData[2]
local grid2=item:GetChildWidgetBase(1)
self:onFreshGrid(dizi2,grid2)

end

function UIDanLingSuccessWin:onStartAction()

end

function UIDanLingSuccessWin:onFreshGrid(dizi,item)
item:SetChildActive(-1,dizi~=nil)
if dizi then
local diziStr=tostring(dizi.dzGuid)

local oldexp=mathHelper.int64_to_number(dizi.jjExpOld)or 0
local jj=dizi.jjLevelOld or 0
local newData=UIDiscipleModel:getDiscipleData(diziStr)
local jingjielv=dizi.jjLevelNew
local jingjieexp=mathHelper.int64_to_number(dizi.jjExpNew)

comHelper.setChildModelHeadIconBG(item,0,diziStr)

comHelper.setChildModelRawImage(item,diziStr,1,0,eHeadCenterType.eHead)

item:SetChildText(2,newData.disciplename)

local exp=0
if jingjielv>jj then
for i=jj,jingjielv-1 do
local nxjjexp=cfgHelper.get2(cfg_disciplejingjieconfig_get,i,'exp')
if i==jj then
exp=exp+nxjjexp-oldexp
else
exp=exp+nxjjexp
end
end
exp=exp+jingjieexp
else
exp=jingjieexp-oldexp
end

item:SetChildText(3,FMT.fmt("修为提升：<color=#aae252>{0}</color>",exp))
local jjName=UIDiscipleModel:getJJNameX(jj)
item:SetChildText(4,FMT.fmt("境界提升：{0}",jjName))
local newjjName=UIDiscipleModel:getJJNameX(jingjielv)
item:SetChildText(5,newjjName)
end
end

function UIDanLingSuccessWin:onClose()
self:closeSelf()
end


