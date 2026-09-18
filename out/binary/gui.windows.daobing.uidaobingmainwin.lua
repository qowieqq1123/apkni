







def_class("UIDaoBingMainWin",UIWindowBase)









function UIDaoBingMainWin:bindComponents()

self.btn1=UIButton.get(self,0)
self.btn2=UIButton.get(self,1)
self.select1=UIObject.get(self,2)
self.select2=UIObject.get(self,3)
self.reddot1=UIObject.get(self,4)
self.reddot2=UIObject.get(self,5)

self.btn1:setButtonClick(function()self:onBtn1()end)

self.btn2:setButtonClick(function()self:onBtn2()end)



end


function UIDaoBingMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btn1);self.btn1=nil;
_UIObject_release(self.btn2);self.btn2=nil;
_UIObject_release(self.select1);self.select1=nil;
_UIObject_release(self.select2);self.select2=nil;
_UIObject_release(self.reddot1);self.reddot1=nil;
_UIObject_release(self.reddot2);self.reddot2=nil;
end

















local _winNames=
{
'UIDaoBingCollectWin',
'UIDaoBingBagWin'
}


function UIDaoBingMainWin:onLoaded(...)
self:bindComponents()
self:addReddotNotify(REDDIT_TYPE.eDaoBing,function(...)self:freshReddot()end)
end

function UIDaoBingMainWin:__delete()
self:unbindComponents()
UIManager:hideWindow('UITopMoneyWin')
end

function UIDaoBingMainWin:onShow(argtable,afterOnloaded)
local btnType=argtable.btnType or 1
self.argtable=argtable
self:onSelect(btnType)
end

function UIDaoBingMainWin:onHide()
end

function UIDaoBingMainWin:onShowArgRecv()
self:freshWindow()
end




function UIDaoBingMainWin:onBtn1()
self:onSelect(1)
end



function UIDaoBingMainWin:onBtn2()
self:onSelect(2)
end

function UIDaoBingMainWin:onSelect(btnType)
if self.btnType==btnType then return end
self.btnType=btnType
self:freshWindow()
end

function UIDaoBingMainWin:freshWindow()
local btnType=self.btnType
for i,name in ipairs(_winNames)do
if btnType==i then
self:showWindow(name,self.argtable)
else
self:hideWindow(name)
end
end

self.select1:setActive(btnType==1)
self.select2:setActive(btnType==2)

self:freshReddot()
end

function UIDaoBingMainWin:freshReddot()
self.reddot2:setActive(daobingHelper.isCanAnyCombine())
end