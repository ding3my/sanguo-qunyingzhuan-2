/* declare global variable https://autohotkey.com/board/topic/74822-declare-global-variable/
the var are always global outside a function.
You need to use the word global inside a function to use external var :
*/


#If WinActive("ahk_exe Sango2.exe")
	; manual https://autohotkey.com/docs/AutoHotkey.htm
	
	徵兵( 带兵数份数 )
	{
		MouseGetPos, cur_x, cur_y
		
		带兵数总份数 :=6 ; 分割带兵数，参考需求。
		默认点击次数 :=3 ; 点击一次可能失败，因为游戏加速。
		默认延时 :=10 ; 游戏渲染可能无法响应操作，延时等待，例如单击最大徵兵。
		最大徵兵x := 368
		最大徵兵y := 456
		最大带兵数x := 605
		最大带兵数y := 191
		最小带兵数x := 561
		最小带兵数y := 最大带兵数y
		下一武将相对y := 22
		
		带兵数距离相对x := 最大带兵数x - 最小带兵数x ;44.25 ; 即
		徵兵拖动速度 :=50 ; 移动快了无法徵兵。
		徵兵拖动距离 := - ( 带兵数距离相对x / 带兵数总份数 * ( 带兵数总份数 - 带兵数份数 )) ; 中文使用小括号需要空格隔开，否则报错。
		
		click % 默认点击次数 ; 双击当前武将，避免单击失效，估计游戏加速，-speed
		mouseclick % "left", 最大徵兵x, 最大徵兵y, 默认点击次数
		sleep 默认延时
		
		mouseclick % "left", cur_x, cur_y + 下一武将相对y, 默认点击次数
		sleep 默认延时
		mouseclick % "left", cur_x, cur_y, 默认点击次数
		sleep 默认延时
		; 用于立即最大徵兵，不等数字渲染，耗时20ms+
		
		mousemove % 最大带兵数x, cur_y
		MouseClickDrag % "left", , , 徵兵拖动距离, 0, 徵兵拖动速度, R ;
		mouseclick % "left", cur_x, cur_y + 下一武将相对y, 默认点击次数
	}

	1::徵兵(1)
	2::徵兵(2)
	3::徵兵(3)
	4::徵兵(4)
	5::徵兵(5)
	6::徵兵(6)
#If