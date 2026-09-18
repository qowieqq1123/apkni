
function xianmengController:showMain()
UIManager:showWindow('UIMainXMInfoWin')
UIManager:showWindow('UIMainXMTaskWin')
UIManager:showWindow('UIMainBottomWin')
UIManager:showWindow('UIMainFuncBtnWin')
end

function xianmengController:hideMain()
UIManager:hideWindow('UIMainXMInfoWin')
UIManager:hideWindow('UIMainXMTaskWin')
UIManager:hideWindow('UIMainBottomWin')
UIManager:hideWindow('UIMainFuncBtnWin')
end

function xianmengController:closeMain()
UIManager:closeWindow('UIMainXMInfoWin')
UIManager:closeWindow('UIMainXMTaskWin')
UIManager:closeWindow('UIMainBottomWin')
UIManager:closeWindow('UIMainFuncBtnWin')
end