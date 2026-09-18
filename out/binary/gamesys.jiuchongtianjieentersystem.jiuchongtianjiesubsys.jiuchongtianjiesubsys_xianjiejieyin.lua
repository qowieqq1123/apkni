













jiuChongTianJieSubSys_xianjiejieyin=jiuChongTianJieSubSysBase.new({sysType=JIUCHONGTIANJIE_SUB_SYS_TYPE.eXianJieJieYin})

jiuChongTianJieSubSys_xianjiejieyin.progressType=eJiuChongTianJieSysType.eNumber

jiuChongTianJieSubSys_xianjiejieyin.showProgessNum=0

jiuChongTianJieSubSys_xianjiejieyin.isShowProgress=false


function jiuChongTianJieSubSys_xianjiejieyin:checkFinish()
return jiuchongtianjieGuideModel:getViewState()
end

function jiuChongTianJieSubSys_xianjiejieyin:getProgress()
local curVal=jiuchongtianjieGuideModel:getViewState()and 100 or 0
return curVal,100
end

function jiuChongTianJieSubSys_xianjiejieyin:getReddot(isEnter)
return jiuchongtianjieGuideController:getAskReddot()
end

function jiuChongTianJieSubSys_xianjiejieyin:jump()
if jiuchongtianjieGuideModel:getViewState()then
UIManager:showWindow("UIXianJieJieYin_AskWin")
return
end

local subSys=JiuChongTianJieEnterModel:getSubSysClass(JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie)
local isFinish=subSys:checkFinish()

if isFinish then
UIManager.info("您已完成天魔劫，无需接引")
else
UIManager:showWindow("UIXianJieJieYin_AskWin")
end
end

