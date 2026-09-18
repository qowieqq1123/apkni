







def_class("UIGuBaoMainWin",UIWindowBase)









function UIGuBaoMainWin:bindComponents()

self.bszlBtn=UIButton.get(self,0)
self.bszlReddot=UIObject.get(self,1)
self.btn1=UIButton.get(self,2)
self.btn2=UIButton.get(self,3)
self.checkBtnReddot=UIObject.get(self,4)
self.reddot1=UIObject.get(self,5)
self.reddot2=UIObject.get(self,6)
self.rewardReddot=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.select1=UIObject.get(self,9)
self.select2=UIObject.get(self,10)

self.bszlBtn:setButtonClick(function()self:onBszlBtn()end)

self.btn1:setButtonClick(function()self:onBtn1()end)

self.btn2:setButtonClick(function()self:onBtn2()end)



end


function UIGuBaoMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bszlBtn);self.bszlBtn=nil;
_UIObject_release(self.bszlReddot);self.bszlReddot=nil;
_UIObject_release(self.btn1);self.btn1=nil;
_UIObject_release(self.btn2);self.btn2=nil;
_UIObject_release(self.checkBtnReddot);self.checkBtnReddot=nil;
_UIObject_release(self.reddot1);self.reddot1=nil;
_UIObject_release(self.reddot2);self.reddot2=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.select1);self.select1=nil;
_UIObject_release(self.select2);self.select2=nil;
end
















local _winNames=
{
'UIGuBaoCollectWin',
'UIGuBaoBagWin'
}


function UIGuBaoMainWin:onLoaded(...)
self:bindComponents()
end


function UIGuBaoMainWin:__delete()
self:unbindComponents()
end


function UIGuBaoMainWin:onHide()

end

function UIGuBaoMainWin:doFadeIn(delay,duration)
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,duration,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end




function UIGuBaoMainWin:onShow(argtable,afterOnloaded)
local fadeInData=argtable.fadeInData
if fadeInData~=nil then
self:doFadeIn(fadeInData[1],fadeInData[2])
end

local btnType=argtable.btnType or 1
self.argtable=argtable
self:onSelect(btnType)
self:refreshBtnReddot()
self:refreshRewardBtn()
self:refreshCheckBtn()
self:refreshBSZLBtn()
end

function UIGuBaoMainWin:onShowArgRecv()
self:freshWindow()
self:refreshBtnReddot()
self:refreshRewardBtn()
self:refreshCheckBtn()
self:refreshBSZLBtn()
end

function UIGuBaoMainWin:onBtn1()
self:onSelect(1)
end

function UIGuBaoMainWin:onBtn2()
self:onSelect(2)
end

function UIGuBaoMainWin:onSelect(btnType)
if self.btnType==btnType then return end
self.btnType=btnType
self:freshWindow()
end

function UIGuBaoMainWin:freshWindow()
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
end

function UIGuBaoMainWin:refreshBtnReddot()
local reddot=gubaoModel:checkCollectPageReddot()
self.reddot1:setActive(reddot)

local reddot2=gubaoModel:checkBagPageReddot()
self.reddot2:setActive(reddot2)
end

function UIGuBaoMainWin:onRewardBtn()
UIManager:showWindow('UIGuBaoRewardWin')
end

function UIGuBaoMainWin:refreshRewardBtn()
local reddot=gubaoModel:checkAllCollectReddot()
self.rewardReddot:setActive(reddot)
end

function UIGuBaoMainWin:refreshCheckBtn()
local reddot=gubaoModel:checkAllColorCollectReddot()
self.checkBtnReddot:setActive(reddot)
end

function UIGuBaoMainWin:onCheckClick()
local num=gubaoModel:getActiveNum()
if num<=0 then
UIManager.error(cfgHelper.getlang('gubao_tips_8'))
return
end




UIManager:showWindow('UIGuBaoAttrWin')
end

function UIGuBaoMainWin:rec_active(gbid)
self:refreshBtnReddot()
self:refreshRewardBtn()
self:refreshCheckBtn()
end

function UIGuBaoMainWin:rec_lianhua(gbid)
self:refreshBtnReddot()
self:refreshRewardBtn()
end

function UIGuBaoMainWin:rec_upStar(gbid)
self:refreshBtnReddot()
self:refreshRewardBtn()
end

function UIGuBaoMainWin:rec_awake(gbid)
self:refreshBtnReddot()
self:refreshBSZLBtn()
end

function UIGuBaoMainWin:rec_colorCollect()
self:refreshCheckBtn()
end

function UIGuBaoMainWin:onBszlBtn()
UIManager:showWindow("UIBaoShuZhuLingWin")
self.bszlReddot:setActive(false)
end

function UIGuBaoMainWin:refreshBSZLBtn()


local open=systemModel.isOpen(SYSTEM_DEFINE.eBaoShuZhuLing)and gubaoModel.checkBaoShuZhuLingPlatformOpen()
if open then
open=false

if gubaoModel.getBaoShuZhuLingOpen()then
open=true
else
local fullStarPieceList=gubaoLookup:getGoodsSortList4(eQualityColor.eRed)
for i,v in ipairs(fullStarPieceList)do
local itemid=v.item.itemid
local gbid=gubaoLookup:good2GuBaoPiece(itemid)
local exp=gubaoModel:getGuBaoPieceBSZLExp(itemid)
local isAwake=gubaoModel:checkAwake(gbid)

if gbid and isAwake and exp>0 then
open=true
break
end
end
end
end
self.bszlBtn:setActive(open)
if open then
local reddot=gubaoModel:checkBSZLReddot()
self.bszlReddot:setActive(reddot)

if not gubaoModel.getBaoShuZhuLingOpen()then
local data={1}
serverSaveController:send_254_10(serverSaveModel.SYSTEM_ENUM.BaoShuZhuLingOpen,#data,data)
gubaoModel.setBaoShuZhuLingOpen(true)
end
end
end