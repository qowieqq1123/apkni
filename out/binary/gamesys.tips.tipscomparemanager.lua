




tipsCompareManager=gameState.addListener({})




function tipsCompareManager:onAppStart()

end

function tipsCompareManager:onEnterState()
end

function tipsCompareManager:onLeaveState()
end


function tipsCompareManager.showTips(argstable)

tipsManager.handleItemArgs(argstable)

tipsCompareManager.showTipsCom(argstable)
end


function tipsCompareManager.showTipsGB(argstable)

tipsManager.handleGBArgs(argstable)

tipsCompareManager.showTipsCom(argstable)
end


function tipsCompareManager.showTipsCom(argstable)
argstable.isCompareTips=true

tipsManager.handleCommonArgs(argstable)

tipsManager.handleTipsBody(argstable)

tipsCompareManager.handleTipsBtn(argstable)

tipsCompareManager.showTipsWindow(argstable)
end



function tipsCompareManager.showTipsWindow(argstable)
UIManager:showWindow('UITipsCompareWin',argstable)
end

function tipsCompareManager.closeTips()
UIManager:closeWindow('UITipsCompareWin')
end

function tipsCompareManager.handleTipsBtn(argstable)
local attach=argstable.attach
local tipsType=argstable.tipsType

argstable.tipsBtnsConfig=tipsConfig.getBtnsConfig(tipsType)

tipsBtnManager.clearBtn(argstable)

if attach and attach.insertBtnList then
tipsBtnManager.insertBtn(argstable,attach.insertBtnList)
end
end
