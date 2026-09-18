







def_class("UIXMKuCunWin",UIWindowBase)









function UIXMKuCunWin:bindComponents()

self.root=UIObject.get(self,0)
self.tipsBtn=UIButton.get(self,1)
self.changeBtn=UIButton.get(self,2)
self.noteBtn=UIButton.get(self,3)
self.itemScrollView=UILoopListView.new(self,4)
self.itemPanel=UIObject.get(self,5)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.noteBtn:setButtonClick(function()self:onNoteBtn()end)

self.itemScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXMKuCunWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.noteBtn);self.noteBtn=nil;
self.itemScrollView:deleteSelf();self.itemScrollView=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
end


















local col=6
local maxCount=500

function UIXMKuCunWin:onLoaded(...)
xianmengController:reqFPData()
xianmengController:reqFSTFinshData()
self:bindComponents()






self:initScrollView()
end


function UIXMKuCunWin:__delete()
self:unbindComponents()
end




function UIXMKuCunWin:onShow(argtable,afterOnloaded)

end


function UIXMKuCunWin:onHide()

end

function UIXMKuCunWin:onFreshAction(index,widget,data)
for i=0,col-1 do
local subwidget=widget:GetChildWidgetBase(i)
local itemCfg=data[i+1]
if itemCfg then
local conf={itemid=itemCfg[1],itemcount=itemCfg[2],showCountBG=itemCfg[2]>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
subwidget:SetChildActive(0,true)
subwidget:SetChildPropData(0,prop)
subwidget:SetBaseItemClickEvent(0,function()
self:ItemClick(itemCfg[1])
end)
else
subwidget:SetChildActive(0,false)
end
end
end


function UIXMKuCunWin:onStartAction()
end

function UIXMKuCunWin:ItemClick(itemid)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eXMKCBag,itemid=itemid})

end

function UIXMKuCunWin:initScrollView()
local bagList=xianmengModel:getkufangBag()
local row=math.ceil(maxCount/col)
local tempList={}
for i=1,row do
tempList[i]={}
for ii=(i-1)*col+1,i*col do
table.insert(tempList[i],bagList[ii])
end
end
self.itemScrollView:initData("xmkcitem",tempList)
end





function UIXMKuCunWin:onTipsBtn()
local d={}
d.title='说明'
d.mode=3
d.name='UIXMKuCunWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end



function UIXMKuCunWin:onNoteBtn()
UIManager:showWindow("UIXMKuFangRJWin")
end

function UIXMKuCunWin:onChangeBtn()
UIManager:showWindow("UIXMCK_ZH_FP_Win")
end

function UIXMKuCunWin:onNewDay()
UIManager:invokeUIMethod("UIXMCK_ZH_FP_Win","initScrollView")
local argstable=tipsManager:getArgs()
if argstable then
local attach=argstable.attach or{}
tipsManager.freshTipsWithAttach(attach,"freshTips",not attach.freshTips)
end
end




